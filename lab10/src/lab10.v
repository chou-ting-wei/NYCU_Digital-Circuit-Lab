`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dept. of Computer Science, National Chiao Tung University
// Engineer: Chun-Jen Tsai 
// 
// Create Date: 2018/12/11 16:04:41
// Design Name: 
// Module Name: lab9
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A circuit that show the animation of a fish swimming in a seabed
//              scene on a screen through the VGA interface of the Arty I/O card.
// 
// Dependencies: vga_sync, clk_divider, sram 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab10(
  input  clk,
  input  reset_n,
  input  [3:0] usr_btn,
  output [3:0] usr_led,
  
  // VGA specific I/O ports
  output VGA_HSYNC,
  output VGA_VSYNC,
  output [3:0] VGA_RED,
  output [3:0] VGA_GREEN,
  output [3:0] VGA_BLUE,

  // 1602 LCD Module Interface
  output LCD_RS,
  output LCD_RW,
  output LCD_E,
  output [3:0] LCD_D
);

// Declare system variables
reg  [35:0] fish1_clock;
reg  [35:0] fish2_clock;
reg  [35:0] fish3_clock;
wire [9:0]  fish1_pos;
wire [9:0]  fish2_pos;
wire [9:0]  fish3_pos;
wire        fish1_region;
wire        fish2_region;
wire        fish3_region;

// declare SRAM control signals
wire [20:0] sram_f1_addr;
wire [11:0] data_f1_in;
wire [11:0] data_f1_out;

wire [20:0] sram_f2_addr;
wire [11:0] data_f2_in;
wire [11:0] data_f2_out;

wire [20:0] sram_f3_addr;
wire [11:0] data_f3_in;
wire [11:0] data_f3_out;

wire [20:0] sram_bg_addr;
wire [11:0] data_bg_in;
wire [11:0] data_bg_out;

wire        sram_we, sram_en;

// General VGA control signals
wire vga_clk;         // 50MHz clock for VGA control
wire video_on;        // when video_on is 0, the VGA controller is sending
                      // synchronization signals to the display device.
  
wire pixel_tick;      // when pixel tick is 1, we must update the RGB value
                      // based for the new coordinate (pixel_x, pixel_y)
  
wire [9:0] pixel_x;   // x coordinate of the next pixel (between 0 ~ 639) 
wire [9:0] pixel_y;   // y coordinate of the next pixel (between 0 ~ 479)
  
reg  [11:0] rgb_reg;  // RGB value for the current pixel
reg  [11:0] rgb_next; // RGB value for the next pixel
  
// Application-specific VGA signals
reg  [20:0] pixel_f1_addr;
reg  [20:0] pixel_f2_addr;
reg  [20:0] pixel_f3_addr;
reg  [20:0] pixel_bg_addr;

// Declare the video buffer size
localparam VBUF_W = 320; // video buffer width
localparam VBUF_H = 240; // video buffer height

// Set parameters for the fish images
localparam FISH1_VPOS   = 32; // Vertical location of the fish in the sea image.
localparam FISH1_W      = 64; // Width of the fish.
localparam FISH1_H      = 32; // Height of the fish.
reg [20:0] fish1_addr[0:7];   // Address array for up to 8 fish images.

localparam FISH2_VPOS   = 40;
localparam FISH2_W      = 64;
localparam FISH2_H      = 44;
reg [20:0] fish2_addr[0:3];

localparam FISH3_VPOS   = 128;
localparam FISH3_W      = 64;
localparam FISH3_H      = 72;
reg [20:0] fish3_addr[0:3];

wire [3:0]  btn_level, btn_pressed;
reg  [3:0]  prev_btn_level;

reg  [127:0] row_A = "SD card cannot  ";
reg  [127:0] row_B = "be initialized! ";

// Initializes the fish images starting addresses.
// Note: System Verilog has an easier way to initialize an array,
//       but we are using Verilog 2001 :(
integer k;
initial begin
  for (k = 0; k < 8; k = k + 1) begin
    fish1_addr[k] = VBUF_W * VBUF_H + FISH1_W * FISH1_H * k;
  end
  for (k = 0; k < 4; k = k + 1) begin
    fish2_addr[k] = FISH2_W * FISH2_H * k;
    fish3_addr[k] = FISH2_W * FISH2_H * 4 + FISH3_W * FISH3_H * k;
  end
end

// Instiantiate the VGA sync signal generator
vga_sync vs0(
  .clk(vga_clk), .reset(~reset_n), .oHS(VGA_HSYNC), .oVS(VGA_VSYNC),
  .visible(video_on), .p_tick(pixel_tick),
  .pixel_x(pixel_x), .pixel_y(pixel_y)
);

clk_divider#(2) clk_divider0(
  .clk(clk),
  .reset(~reset_n),
  .clk_out(vga_clk)
);

debounce btn_db0(
  .clk(clk),
  .btn_input(usr_btn[0]),
  .btn_output(btn_level[0])
);

debounce btn_db1(
  .clk(clk),
  .btn_input(usr_btn[1]),
  .btn_output(btn_level[1])
);

debounce btn_db2(
  .clk(clk),
  .btn_input(usr_btn[2]),
  .btn_output(btn_level[2])
);

debounce btn_db3(
  .clk(clk),
  .btn_input(usr_btn[3]),
  .btn_output(btn_level[3])
);

LCD_module lcd0( 
  .clk(clk),
  .reset(~reset_n),
  .row_A(row_A),
  .row_B(row_B),
  .LCD_E(LCD_E),
  .LCD_RS(LCD_RS),
  .LCD_RW(LCD_RW),
  .LCD_D(LCD_D)
);

always @(posedge clk) begin
    if (~reset_n)
        prev_btn_level <= 0;
    else
        prev_btn_level <= btn_level;
end

assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;

// ------------------------------------------------------------------------
// The following code describes an initialized SRAM memory block that
// stores a 320x240 12-bit seabed image, plus two 64x32 fish images.

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(VBUF_W*VBUF_H+FISH1_W*FISH1_H*8), .FILE("images.mem"))
  ram_1 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_bg_addr), .data_i_1(data_bg_in), .data_o_1(data_bg_out),
          .addr_2(sram_f1_addr), .data_i_2(data_f1_in), .data_o_2(data_f1_out));

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(FISH2_W*FISH2_H*4+FISH3_W*FISH3_H*4), .FILE("images2.mem"))
  ram_2 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_f2_addr), .data_i_1(data_f2_in), .data_o_1(data_f2_out),
          .addr_2(sram_f3_addr), .data_i_2(data_f3_in), .data_o_2(data_f3_out));


assign sram_we = usr_btn[3]; // In this demo, we do not write the SRAM. However, if
                             // you set 'sram_we' to 0, Vivado fails to synthesize
                             // ram0 as a BRAM -- this is a bug in Vivado.
assign sram_en = 1;          // Here, we always enable the SRAM block.
assign sram_f1_addr = pixel_f1_addr;
assign data_f1_in = 12'h000; // SRAM is read-only so we tie inputs to zeros.

assign sram_f2_addr = pixel_f2_addr;
assign data_f2_in = 12'h000;

assign sram_f3_addr = pixel_f3_addr;
assign data_f3_in = 12'h000;

assign sram_bg_addr = pixel_bg_addr;
assign data_bg_in = 12'h000;
// End of the SRAM memory block.
// ------------------------------------------------------------------------

// VGA color pixel generator
assign {VGA_RED, VGA_GREEN, VGA_BLUE} = rgb_reg;

// ------------------------------------------------------------------------
// An animation clock for the motion of the fish, upper bits of the
// fish clock is the x position of the fish on the VGA screen.
// Note that the fish will move one screen pixel every 2^20 clock cycles,
// or 10.49 msec
// assign pos = fish_clock[31:20]; // the x position of the right edge of the fish image
                                // in the 640x480 VGA screen
assign fish1_pos = fish1_clock[33:22];
assign fish2_pos = fish2_clock[31:20];
assign fish3_pos = fish3_clock[30:19];

// Direction: 0 = left, 1 = right
reg fish1_dir;
reg fish2_dir;
reg fish3_dir;

always @(posedge clk) begin
  if (~reset_n) begin
    fish1_clock <= 0;
    fish2_clock <= 0;
    fish3_clock <= 0;
    fish1_dir <= 1;
    fish2_dir <= 1;
    fish3_dir <= 1;
  end else begin
    if (fish1_dir) begin
      if (fish1_clock[33:23] < VBUF_W)
        fish1_clock <= fish1_clock + 1;
      else begin
        fish1_dir <= 0;
        fish1_clock <= fish1_clock - 1;
      end
    end else begin
      if (fish1_clock[33:23] > FISH1_W)
        fish1_clock <= fish1_clock - 1;
      else begin
        fish1_dir <= 1;
        fish1_clock <= fish1_clock + 1;
      end
    end
    if (fish2_dir) begin
      if (fish2_clock[31:21] < VBUF_W)
        fish2_clock <= fish2_clock + 1;
      else begin
        fish2_dir <= 0;
        fish2_clock <= fish2_clock - 1;
      end
    end else begin
      if (fish2_clock[31:21] > FISH2_W)
        fish2_clock <= fish2_clock - 1;
      else begin
        fish2_dir <= 1;
        fish2_clock <= fish2_clock + 1;
      end
    end
    if (fish3_dir) begin
      if (fish3_clock[30:20] < VBUF_W)
        fish3_clock <= fish3_clock + 1;
      else begin
        fish3_dir <= 0;
        fish3_clock <= fish3_clock - 1;
      end
    end else begin
      if (fish3_clock[30:20] > FISH3_W)
        fish3_clock <= fish3_clock - 1;
      else begin
        fish3_dir <= 1;
        fish3_clock <= fish3_clock + 1;
      end
    end
  end
end
// End of the animation clock code.
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// Video frame buffer address generation unit (AGU) with scaling control
// Note that the width x height of the fish image is 64x32, when scaled-up
// on the screen, it becomes 128x64. 'pos' specifies the right edge of the
// fish image.
// assign fish_region =
//            pixel_y >= (FISH_VPOS<<1) && pixel_y < (FISH_VPOS+FISH_H)<<1 &&
//            (pixel_x + 127) >= pos && pixel_x < pos + 1;
assign fish1_region =
          pixel_y >= (FISH1_VPOS<<1) && pixel_y < (FISH1_VPOS+FISH1_H)<<1 &&
          (pixel_x + 127) >= fish1_pos && pixel_x < fish1_pos + 1;

assign fish2_region =
          pixel_y >= (FISH2_VPOS<<1) && pixel_y < (FISH2_VPOS+FISH2_H)<<1 &&
          (pixel_x + 127) >= fish2_pos && pixel_x < fish2_pos + 1;

assign fish3_region =
          pixel_y >= (FISH3_VPOS<<1) && pixel_y < (FISH3_VPOS+FISH3_H)<<1 &&
          (pixel_x + 127) >= fish3_pos && pixel_x < fish3_pos + 1;

always @ (posedge clk) begin
  if (~reset_n)
    pixel_f1_addr <= 0;
    pixel_f2_addr <= 0;
    pixel_f3_addr <= 0;
  if (fish1_region) begin
    if (fish1_dir)
      pixel_f1_addr <= fish1_addr[fish1_clock[25:23]] +
                    ((pixel_y>>1)-FISH1_VPOS)*FISH1_W +
                    ((pixel_x +(FISH1_W*2-1)-fish1_pos)>>1);
    else
      pixel_f1_addr <= fish1_addr[fish1_clock[25:23]] +
                    ((pixel_y >> 1) - FISH1_VPOS) * FISH1_W +
                    (FISH1_W - ((pixel_x +(FISH1_W*2-1)-fish1_pos)>>1) - 1);
  end
  if (fish2_region) begin
    if (fish2_dir)
      pixel_f2_addr <= fish2_addr[fish2_clock[25:24]] +
                    ((pixel_y>>1)-FISH2_VPOS)*FISH2_W +
                    ((pixel_x +(FISH2_W*2-1)-fish2_pos)>>1);
    else
      pixel_f2_addr <= fish2_addr[fish2_clock[25:24]] +
                    ((pixel_y >> 1) - FISH2_VPOS) * FISH2_W +
                    (FISH2_W - ((pixel_x +(FISH2_W*2-1)-fish2_pos)>>1) - 1);
  end
  if (fish3_region) begin
    if (~fish3_dir)
      pixel_f3_addr <= fish3_addr[fish3_clock[25:24]] +
                    ((pixel_y>>1)-FISH3_VPOS)*FISH3_W +
                    ((pixel_x +(FISH3_W*2-1)-fish3_pos)>>1);
    else
      pixel_f3_addr <= fish3_addr[fish3_clock[25:24]] +
                    ((pixel_y >> 1) - FISH3_VPOS) * FISH3_W +
                    (FISH3_W - ((pixel_x +(FISH3_W*2-1)-fish3_pos)>>1) - 1);
  end
end

always @ (posedge clk) begin
  if (~reset_n)
    pixel_bg_addr <= 0;
  else
    pixel_bg_addr <= (pixel_y >> 1) * VBUF_W + (pixel_x >> 1);
end

// End of the AGU code.
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// Send the video data in the sram to the VGA controller
always @(posedge clk) begin
  if (pixel_tick) rgb_reg <= rgb_next;
end

always @(*) begin
  if (~video_on)
    rgb_next = 12'h000; // Synchronization period, must set RGB values to zero.
  else
    if (fish1_region && data_f1_out != 12'h0f0)
      rgb_next = data_f1_out;
    else if (fish2_region && data_f2_out != 12'h0f0)
      rgb_next = data_f2_out;
    else if (fish3_region && data_f3_out != 12'h0f0)
      rgb_next = data_f3_out;
    else
      rgb_next = data_bg_out;
end
// End of the video data display code.
// ------------------------------------------------------------------------

endmodule
