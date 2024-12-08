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
  input  [3:0] usr_sw,
  output [3:0] usr_led,
  
  // VGA specific I/O ports
  output VGA_HSYNC,
  output VGA_VSYNC,
  output [3:0] VGA_RED,
  output [3:0] VGA_GREEN,
  output [3:0] VGA_BLUE
);

// Declare system variables

reg  [31:0] water_drop_clock;
reg  [31:0] tea_drop_clock;
reg  [31:0] juice_drop_clock;
reg  [31:0] coke_drop_clock;
// vending machine item

wire [9:0]  vend_pos;
wire        vend_region;

wire [9:0]  vending_water_pos;
wire        vending_water_region;

wire [9:0]  vending_juice_pos;
wire        vending_juice_region;

wire [9:0]  vending_tea_pos;
wire        vending_tea_region;

wire [9:0]  vending_coke_pos;
wire        vending_coke_region;

wire [9:0]  drop_pos;
wire        drop_region;
// falling item var
wire [9:0]  drop_water_pos;
wire        fall_water_region;

wire [9:0]  drop_tea_pos;
wire        fall_tea_region;

wire [9:0]  drop_juice_pos;
wire        fall_juice_region;

wire [9:0]  select_top_pos;
wire        select_top_region;

wire [9:0]  select_pos1;
wire        select_region1;

wire [9:0]  select_pos2;
wire        select_region2;

wire [9:0]  money_top_pos;
wire        money_top_region;

wire [9:0]  money_pos1;
wire        money_region1;

wire [9:0]  money_pos2;
wire        money_region2;

wire [9:0]  sm_block_pos;
wire        sm_block_region;

wire [9:0]  drop_coke_pos;
wire        fall_coke_region;

wire [9:0]  rest_pos;
wire        rest_region;

wire [9:0]  num0_1_pos;
wire        num0_1_region;

wire [9:0]  num0_2_pos;
wire        num0_2_region;

wire [9:0]  num0_3_pos;
wire        num0_3_region;

wire [9:0]  num0_4_pos;
wire        num0_4_region;

wire [9:0]  num1_1_pos;
wire        num1_1_region;

wire [9:0]  num1_2_pos;
wire        num1_2_region;

wire [9:0]  num1_3_pos;
wire        num1_3_region;

wire [9:0]  num1_4_pos;
wire        num1_4_region;

wire [9:0]  num1_5_pos;
wire        num1_5_region;

wire [9:0]  num1_6_pos;
wire        num1_6_region;

wire [9:0]  num1_7_pos;
wire        num1_7_region;

wire [9:0]  num1_8_pos;
wire        num1_8_region;

wire [9:0]  num2_1_pos;
wire        num2_1_region;

wire [9:0]  num2_2_pos;
wire        num2_2_region;

wire [9:0]  num2_3_pos;
wire        num2_3_region;

wire [9:0]  num2_4_pos;
wire        num2_4_region;

wire [9:0]  num2_5_pos;
wire        num2_5_region;

wire [9:0]  num2_6_pos;
wire        num2_6_region;

wire [9:0]  num2_7_pos;
wire        num2_7_region;

wire [9:0]  num2_8_pos;
wire        num2_8_region;

wire [9:0]  num2_9_pos;
wire        num2_9_region;

wire [9:0]  num2_10_pos;
wire        num2_10_region;

wire [9:0]  num2_11_pos;
wire        num2_11_region;

wire [9:0]  num_time_1_pos;
wire        num_time_1_region;

wire [9:0]  num_time_2_pos;
wire        num_time_2_region;

wire [9:0]  error_pos;
wire        error_region;

wire [9:0]  num3_1_pos;
wire        num3_1_region;


wire [9:0]  num3_2_pos;
wire        num3_2_region;

wire [9:0]  num3_3_pos;
wire        num3_3_region;

wire [9:0]  num3_4_pos;
wire        num3_4_region;

wire [9:0]  num4_1_pos;
wire        num4_1_region;

wire [9:0]  num4_2_pos;
wire        num4_2_region;

wire [9:0]  num4_3_pos;
wire        num4_3_region;

wire [9:0]  num4_4_pos;
wire        num4_4_region;

wire [9:0]  slash1_1_pos;
wire        slash1_1_region;

wire [9:0]  slash1_2_pos;
wire        slash1_2_region;

wire [9:0]  slash1_3_pos;
wire        slash1_3_region;

wire [9:0]  slash1_4_pos;
wire        slash1_4_region;

wire [9:0]  slash2_1_pos;
wire        slash2_1_region;

wire [9:0]  slash2_2_pos;
wire        slash2_2_region;

wire [9:0]  slash2_3_pos;
wire        slash2_3_region;

wire [9:0]  slash2_4_pos;
wire        slash2_4_region;

wire [9:0] block1_pos;
wire       block1_region;

wire [9:0] block2_pos;
wire       block2_region;

wire [9:0] block3_pos;
wire       block3_region;

wire [9:0] block4_pos;
wire       block4_region;

wire [20:0] sram_vend_addr;
wire [11:0] data_vend_in;
wire [11:0] data_vend_out;
// drop item sram
wire [20:0] sram_water_addr;
wire [11:0] data_water_in;
wire [11:0] data_water_out;

wire [20:0] sram_tea_addr;
wire [11:0] data_tea_in;
wire [11:0] data_tea_out;

wire [20:0] sram_juice_addr;
wire [11:0] data_juice_in;
wire [11:0] data_juice_out;

wire [20:0] sram_coke_addr;
wire [11:0] data_coke_in;
wire [11:0] data_coke_out;

// vending item sram
wire [20:0] sram_water_addr2;
wire [11:0] data_water_in2;
wire [11:0] data_water_out2;

wire [20:0] sram_juice_addr2;
wire [11:0] data_juice_in2;
wire [11:0] data_juice_out2;

wire [20:0] sram_tea_addr2;
wire [11:0] data_tea_in2;
wire [11:0] data_tea_out2;

wire [20:0] sram_coke_addr2;
wire [11:0] data_coke_in2;
wire [11:0] data_coke_out2;

wire [20:0] sram_num_addr;
wire [11:0] data_num_in;
wire [11:0] data_num_out;

wire [20:0] sram_money_top_addr;
wire [11:0] data_money_top_in;
wire [11:0] data_money_top_out;

wire [20:0] sram_money_addr;
wire [11:0] data_money_in;
wire [11:0] data_money_out;

wire [20:0] sram_select_top_addr;
wire [11:0] data_select_top_in;
wire [11:0] data_select_top_out;

wire [20:0] sram_select_addr;
wire [11:0] data_select_in;
wire [11:0] data_select_out;

wire [20:0] sram_rest_addr;
wire [11:0] data_rest_in;
wire [11:0] data_rest_out;

wire [20:0] sram_slash_addr;
wire [11:0] data_slash_in;
wire [11:0] data_slash_out;

wire [20:0] sram_error_addr;
wire [11:0] data_error_in;
wire [11:0] data_error_out;

wire sram_we, sram_en;

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
reg  [20:0] pixel_vend_addr;

reg  [20:0] pixel_drop_addr;
// drop
reg  [20:0] pixel_water_addr;
reg  [20:0] pixel_tea_addr;
reg  [20:0] pixel_juice_addr;
reg  [20:0] pixel_coke_addr;
// vending
reg  [20:0] pixel_water_addr2;
reg  [20:0] pixel_juice_addr2;
reg  [20:0] pixel_tea_addr2;
reg  [20:0] pixel_coke_addr2;

reg  [20:0] pixel_num_addr;
reg  [20:0] pixel_slash_addr;

reg  [20:0] pixel_select_top_addr;
reg  [20:0] pixel_select_addr;
reg  [20:0] pixel_money_top_addr;
reg  [20:0] pixel_money_addr;

reg  [20:0] pixel_rest_addr;
reg  [20:0] pixel_error_addr;

// Declare the video buffer size
localparam VBUF_W = 320; // video buffer width
localparam VBUF_H = 240; // video buffer height


localparam vend_vpos   = 10;
localparam VEND_W      = 100;
localparam VEND_H      = 170;
reg [20:0] vend_addr;

localparam drop_vpos   = 145;
localparam DROP_W      = 56;
localparam DROP_H      = 13;
reg [20:0] drop_addr;

localparam WATER_W      = 18;
localparam WATER_H      = 27;
reg [20:0] water_addr;

localparam error_vpos  = 200;
localparam ERROR_W = 21;
localparam ERROR_H = 19;
reg [20:0] error_addr;

localparam select_top_vpos  = 10;
localparam select_vpos1  = 20;
localparam select_vpos2  = 191;
localparam money_top_vpos  = 67;
localparam money_vpos1  = 77;
localparam money_vpos2  = 134;

reg [20:0] select_top_addr;
reg [20:0] select_addr;
reg [20:0] money_top_addr;
reg [20:0] money_addr;

initial begin
  select_top_addr = 0;
  select_addr = 10*BLOCK_W;
  money_top_addr = 0;
  money_addr = 10*BLOCK_W;
  error_addr = 0;
end


localparam block1_vpos  = 10;
localparam block2_vpos  = 67;
localparam block3_vpos  = 124;
localparam block4_vpos  = 181;

localparam BLOCK_W      = 190;
localparam BLOCK_H      = 50;

localparam sm_block_vpos  = 190;
localparam SM_BLOCK_W      = 100;
localparam SM_BLOCK_H      = 40;

localparam rest_vpos  = 190;

localparam num0_1_vpos  = 190+28;
localparam num0_2_vpos  = 190+28;
localparam num0_3_vpos  = 190+28;
localparam num0_4_vpos  = 190+28;

localparam num1_1_vpos  = 50;
localparam num1_2_vpos  = 50;
localparam num1_3_vpos  = 50;
localparam num1_4_vpos  = 50;
localparam num1_5_vpos  = 50;
localparam num1_6_vpos  = 50;
localparam num1_7_vpos  = 50;
localparam num1_8_vpos  = 50;
localparam num2_1_vpos  = 107;
localparam num2_2_vpos  = 107;
localparam num2_3_vpos  = 107;
localparam num2_4_vpos  = 107;
localparam num2_5_vpos  = 107;
localparam num2_6_vpos  = 107;
localparam num2_7_vpos  = 107;
localparam num2_8_vpos  = 107;
localparam num3_1_vpos  = 164;
localparam num3_2_vpos  = 164;
localparam num3_3_vpos  = 164;
localparam num3_4_vpos  = 164;
localparam num4_1_vpos  = 221;
localparam num4_2_vpos  = 221;
localparam num4_3_vpos  = 221;
localparam num4_4_vpos  = 221;
localparam NUM_W      = 7;
localparam NUM_H      = 9;

reg [31:0] num_time_1_vpos;
reg [31:0] num_time_2_vpos;

always @(*) begin
  if (P == S_MAIN_BUY) begin
    num_time_1_vpos = 50;
    num_time_2_vpos = 50;
  end
  else if (P == S_MAIN_PAY) begin
    num_time_1_vpos = 107;
    num_time_2_vpos = 107;
  end
  // else if (P == S_MAIN_CALC) begin
  //   num_time_1_vpos = 164;
  //   num_time_2_vpos = 164;
  // end
  // else if (P == S_MAIN_DROP) begin
  //   num_time_1_vpos = 221;
  //   num_time_2_vpos = 221;
  // end
  // else begin
  //   num_time_1_vpos = 0;
  //   num_time_2_vpos = 0;
  // end
end

localparam num2_9_vpos  = 76;
localparam num2_10_vpos  = 76;
localparam num2_11_vpos  = 76;

localparam slash1_1_vpos  = 50;
localparam slash1_2_vpos  = 50;
localparam slash1_3_vpos  = 50;
localparam slash1_4_vpos  = 50;
localparam slash2_1_vpos  = 107;
localparam slash2_2_vpos  = 107;
localparam slash2_3_vpos  = 107;
localparam slash2_4_vpos  = 107;

reg [20:0] zero_addr;
reg [20:0] one_addr;
reg [20:0] two_addr;
reg [20:0] three_addr;
reg [20:0] four_addr;
reg [20:0] five_addr;
reg [20:0] six_addr;
reg [20:0] seven_addr;
reg [20:0] eight_addr;
reg [20:0] nine_addr;
reg [20:0] slash_addr;
initial begin
  zero_addr = VEND_W*VEND_H;
  one_addr = VEND_W*VEND_H+NUM_W * NUM_H;
  two_addr = VEND_W*VEND_H+NUM_W * NUM_H * 2;
  three_addr = VEND_W*VEND_H+NUM_W * NUM_H * 3;
  four_addr = VEND_W*VEND_H+NUM_W * NUM_H * 4;
  five_addr = VEND_W*VEND_H+NUM_W * NUM_H * 5;
  six_addr = VEND_W*VEND_H+NUM_W * NUM_H * 6;
  seven_addr = VEND_W*VEND_H+NUM_W * NUM_H * 7;
  eight_addr = VEND_W*VEND_H+NUM_W * NUM_H * 8;
  nine_addr = VEND_W*VEND_H+NUM_W * NUM_H * 9;
  slash_addr = SM_BLOCK_H*SM_BLOCK_W;
end

wire [3:0]  btn_level, btn_pressed;
reg  [3:0]  prev_btn_level;

localparam TEA_W      = 22;
localparam TEA_H      = 18;
reg [20:0] tea_addr;

localparam JUICE_W      = 22;
localparam JUICE_H      = 27;
reg [20:0] juice_addr;

localparam COKE_W      = 12;
localparam COKE_H      = 24;
reg [20:0] coke_addr;

reg [9:0] drop_water_vpos;
reg [9:0] drop_tea_vpos;
reg [9:0] drop_juice_vpos;
reg [9:0] drop_coke_vpos;

localparam water_vpos2   = 42;
localparam WATER_W2 = 18;
localparam WATER_H2 = 27;
localparam juice_vpos2   = 42;
localparam JUICE_W2 = 22;
localparam JUICE_H2 = 27;
localparam tea_vpos2   = 113;
localparam TEA_W2 = 22;
localparam TEA_H2 = 18;
localparam coke_vpos2   = 107;
localparam COKE_W2 = 12;
localparam COKE_H2 = 24;

reg [20:0]water_addr2;
reg [20:0]juice_addr2;
reg [20:0]tea_addr2;
reg [20:0]coke_addr2;

localparam vending_water_vpos   = 42;
localparam vending_juice_vpos   = 42;
localparam vending_tea_vpos   = 113;
localparam vending_coke_vpos   = 107;

initial begin
  water_addr2 = 0;
  juice_addr2 = WATER_W * WATER_H;
  tea_addr2 = 0;
  coke_addr2 = TEA_W * TEA_H;
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

always @(posedge clk) begin
  if (~reset_n)
    prev_btn_level <= 4'b0000;
  else
    prev_btn_level <= btn_level;
end

assign btn_pressed = (btn_level & ~prev_btn_level);

// ------------------------------------------------------------------------
// The following code describes an initialized SRAM memory block that
// stores a 320x240 12-bit seabed image, plus two 64x32 fish images.

wire [20:0] sram_tmp_addr;
wire [11:0] data_tmp_in;
wire [11:0] data_tmp_out;

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(VEND_W*VEND_H+NUM_W * NUM_H * 10), .FILE("images.mem"))
  ram_1 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_vend_addr), .data_i_1(data_vend_in), .data_o_1(data_vend_out),
          .addr_2(sram_num_addr), .data_i_2(data_num_in), .data_o_2(data_num_out));

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(BLOCK_W*BLOCK_H), .FILE("images2.mem"))
  ram_2 (.clk(clk), .we(sram_we), .en(sram_en),
         .addr_1(sram_select_top_addr), .data_i_1(data_select_top_in), .data_o_1(data_select_top_out),
         .addr_2(sram_select_addr), .data_i_2(data_select_in), .data_o_2(data_select_out));

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(BLOCK_W*BLOCK_H), .FILE("images3.mem"))
  ram_3 (.clk(clk), .we(sram_we), .en(sram_en),
         .addr_1(sram_money_top_addr), .data_i_1(data_money_top_in), .data_o_1(data_money_top_out),
         .addr_2(sram_money_addr), .data_i_2(data_money_in), .data_o_2(data_money_out));

// vending item sram
sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(WATER_W*WATER_H+JUICE_W*JUICE_H), .FILE("images4.mem"))
  ram_4 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_water_addr2), .data_i_1(data_water_in2), .data_o_1(data_water_out2),
          .addr_2(sram_juice_addr2), .data_i_2(data_juice_in2), .data_o_2(data_juice_out2));

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(TEA_W*TEA_H+COKE_W*COKE_H), .FILE("images5.mem"))
  ram_5 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_tea_addr2), .data_i_1(data_tea_in2), .data_o_1(data_tea_out2),
          .addr_2(sram_coke_addr2), .data_i_2(data_coke_in2), .data_o_2(data_coke_out2));


sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(SM_BLOCK_H*SM_BLOCK_W+NUM_H*NUM_W), .FILE("images6.mem"))
  ram_6 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_rest_addr), .data_i_1(data_rest_in), .data_o_1(data_rest_out),
          .addr_2(sram_slash_addr), .data_i_2(data_slash_in), .data_o_2(data_slash_out));

// dropping item sram
sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(WATER_W*WATER_H+JUICE_W*JUICE_H), .FILE("images7.mem"))
  ram_7 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_water_addr), .data_i_1(data_water_in), .data_o_1(data_water_out),
          .addr_2(sram_juice_addr), .data_i_2(data_juice_in), .data_o_2(data_juice_out));

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(TEA_W*TEA_H+COKE_W*COKE_H), .FILE("images8.mem"))
  ram_8 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_tea_addr), .data_i_1(data_tea_in), .data_o_1(data_tea_out),
          .addr_2(sram_coke_addr), .data_i_2(data_coke_in), .data_o_2(data_coke_out));

sram #(.DATA_WIDTH(12), .ADDR_WIDTH(18), .RAM_SIZE(ERROR_H*ERROR_W), .FILE("images9.mem"))
  ram_9 (.clk(clk), .we(sram_we), .en(sram_en),
          .addr_1(sram_error_addr), .data_i_1(data_error_in), .data_o_1(data_error_out),
          .addr_2(sram_tmp_addr), .data_i_2(data_tmp_in), .data_o_2(data_tmp_out));

assign sram_we = usr_sw[3]; // In this demo, we do not write the SRAM. However, if
                                  // you set 'sram_we' to 0, Vivado fails to synthesize
                                  // ram0 as a BRAM -- this is a bug in Vivado.
assign sram_en = 1;               // Here, we always enable the SRAM block.

// assign sram_f1_addr = pixel_f1_addr;
// assign data_f1_in = 12'h000; // SRAM is read-only so we tie inputs to zeros.

// assign sram_f2_addr = pixel_f2_addr;
// assign data_f2_in = 12'h000;

// assign sram_f3_addr = pixel_f3_addr;
// assign data_f3_in = 12'h000;

// assign sram_bg_addr = pixel_bg_addr;
// assign data_bg_in = 12'h000;

assign sram_vend_addr = pixel_vend_addr;
assign data_vend_in = 12'h000;

// drop
assign sram_water_addr = pixel_water_addr;
assign data_water_in = 12'h000;
assign sram_juice_addr = pixel_juice_addr;
assign data_juice_in = 12'h000;
assign sram_tea_addr = pixel_tea_addr;
assign data_tea_in = 12'h000;
assign sram_coke_addr = pixel_coke_addr;
assign data_coke_in = 12'h000;
// vending
assign sram_water_addr2 = pixel_water_addr2;
assign data_water_in2 = 12'h000;
assign sram_juice_addr2 = pixel_juice_addr2;
assign data_juice_in2 = 12'h000;
assign sram_tea_addr2 = pixel_tea_addr2;
assign data_tea_in2 = 12'h000;
assign sram_coke_addr2 = pixel_coke_addr2;
assign data_coke_in2 = 12'h000;

assign sram_select_top_addr = pixel_select_top_addr;
assign data_select_top_in = 12'h000;
assign sram_select_addr = pixel_select_addr;
assign data_select_in = 12'h000;
assign sram_money_top_addr = pixel_money_top_addr;
assign data_money_top_in = 12'h000;
assign sram_money_addr = pixel_money_addr;
assign data_money_in = 12'h000;

assign sram_num_addr = pixel_num_addr;
assign data_num_in = 12'h000;

assign sram_rest_addr = pixel_rest_addr;
assign data_rest_in = 12'h000;

assign sram_slash_addr = pixel_slash_addr;
assign data_slash_in = 12'h000;

assign sram_error_addr = pixel_error_addr;
assign data_error_in = 12'h000;

// End of the SRAM memory block.
// ------------------------------------------------------------------------

// VGA color pixel generator
assign {VGA_RED, VGA_GREEN, VGA_BLUE} = rgb_reg;

// ------------------------------------------------------------------------
// An animation clock for the motion of the fish, upper bits of the
// fish clock is the x position of the fish on the VGA screen.
// Note that the fish will move one screen pixel every 2^20 clock cycles,
// or 10.49 msec


assign vend_pos = 220;

assign water_pos2 = 105;
assign juice_pos2 = 192;
assign tea_pos2 = 105;
assign coke_pos2 = 182;

assign vending_water_pos = 105;
assign vending_juice_pos = 192;
assign vending_tea_pos = 105;
assign vending_coke_pos = 182;

assign drop_pos = 176;
assign block1_pos = 620;
assign block2_pos = 620;
assign block3_pos = 620;
assign block4_pos = 620;
assign sm_block_pos = 220;

assign select_top_pos = 620;
assign select_pos1 = 620;
assign select_pos2 = 620;
assign money_top_pos = 620;
assign money_pos1 = 620;
assign money_pos2 = 620;

assign num1_1_pos = 235+44;
assign num1_2_pos = 235+84;
assign num1_3_pos = 235+124;
assign num1_4_pos = 235+164;
assign num1_5_pos = 235+204;
assign num1_6_pos = 235+244;
assign num1_7_pos = 235+284;
assign num1_8_pos = 235+324;
assign num2_1_pos = 235+44;
assign num2_2_pos = 235+84;
assign num2_3_pos = 235+124;
assign num2_4_pos = 235+164;
assign num2_5_pos = 235+204;
assign num2_6_pos = 235+244;
assign num2_7_pos = 235+284;
assign num2_8_pos = 235+324;
assign num3_1_pos = 235+64;
assign num3_2_pos = 235+144;
assign num3_3_pos = 235+224;
assign num3_4_pos = 235+304;
assign num4_1_pos = 235+64;
assign num4_2_pos = 235+144;
assign num4_3_pos = 235+224;
assign num4_4_pos = 235+304;

//left-top
// 15x30 30x30 45x30 75x30
assign rest_pos = 220;
assign num0_1_pos = 20+44;
assign num0_2_pos = 20+74;
assign num0_3_pos = 20+110;
assign num0_4_pos = 20+164;

assign slash1_1_pos = 235+64;
assign slash1_2_pos = 235+144;
assign slash1_3_pos = 235+224;
assign slash1_4_pos = 235+304;

assign slash2_1_pos = 235+64;
assign slash2_2_pos = 235+144;
assign slash2_3_pos = 235+224;
assign slash2_4_pos = 235+304;

assign num2_9_pos = 235+352;
assign num2_10_pos = 235+366;
assign num2_11_pos = 235+380;

assign num_time_1_pos = 235+366;
assign num_time_2_pos = 235+380;

assign error_pos = 20+121;

assign drop_water_pos = water_pos_reg;
assign drop_tea_pos = tea_pos_reg; // right bound
assign drop_juice_pos = juice_pos_reg; // right bound
assign drop_coke_pos = coke_pos_reg; // right bound

// water drop clock control
reg water_drop_speed;
always @(posedge clk) begin
  if(~reset_n) begin
    water_drop_clock <= 0;
  end
  else if (P == S_MAIN_DROP && remain_water_num > 0) begin
    if(water_drop_speed == 1 || drop_water_vpos > 160) begin
      water_drop_clock <= 0;
    end
    else if(drop_water_vpos > 160) begin
      water_drop_clock <= 0;
    end
    else begin
      water_drop_clock <= water_drop_clock + 8;
    end
  end
  else begin
    water_drop_clock <= 0;
  end
end
// water drop speed control
always @(posedge clk) begin
  if(~reset_n) begin
    water_drop_speed <= 0;
  end
  else if (P == S_MAIN_DROP && remain_water_num > 0) begin
    if(water_drop_speed == 1) begin
      water_drop_speed <= 0;
    end
    else if(water_drop_clock[26:25] == 1) begin
      water_drop_speed <= 1;
    end
  end
  else begin
    water_drop_speed <= 0;
  end
end
// water drop vpos control
always @(posedge clk) begin
    if (~reset_n) begin
      drop_water_vpos <= 10'd118;
    end else begin
      if (P == S_MAIN_DROP && remain_water_num > 0) begin
        if(drop_water_vpos > 160) begin
          drop_water_vpos <= 10'd118;
        end
        else begin
          drop_water_vpos <= drop_water_vpos + water_drop_speed;
        end
      end
      else begin
        drop_water_vpos <= 10'd118;
      end
  end
end
// water random x control
reg [7:0] lfsr;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    lfsr <= 8'hA5;
  else
    lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5]};
end

wire [5:0] rand_val = lfsr[5:0];
wire [5:0] offset = rand_val % 51;
reg [9:0] water_pos_reg;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
    water_pos_reg <= 141;
  end else if (drop_water_vpos > 160) begin
    water_pos_reg <= 126 + offset;
  end
end
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
// juice drop clock control
reg juice_drop_speed;
always @(posedge clk) begin
  if(~reset_n) begin
    juice_drop_clock <= 0;
  end
  else if (P == S_MAIN_DROP && remain_juice_num > 0 && remain_water_num == 0) begin
    if(juice_drop_speed == 1 || drop_juice_vpos > 160) begin
      juice_drop_clock <= 0;
    end
    else if(drop_juice_vpos > 160) begin
      juice_drop_clock <= 0;
    end
    else begin
      juice_drop_clock <= juice_drop_clock + 8;
    end
  end
  else begin
    juice_drop_clock <= 0;
  end
end
// juice drop speed control
always @(posedge clk) begin
  if(~reset_n) begin
    juice_drop_speed <= 0;
  end
  else if (P == S_MAIN_DROP && remain_juice_num > 0 && remain_water_num == 0) begin
    if(juice_drop_speed == 1) begin
      juice_drop_speed <= 0;
    end
    else if(juice_drop_clock[26:25] == 1) begin
      juice_drop_speed <= 1;
    end
  end
  else begin
    juice_drop_speed <= 0;
  end
end
// juice drop vpos control
always @(posedge clk) begin
    if (~reset_n) begin
      drop_juice_vpos <= 10'd118;
    end else begin
      if (P == S_MAIN_DROP && remain_juice_num > 0 && remain_water_num == 0) begin
        if(drop_juice_vpos > 160) begin
          drop_juice_vpos <= 10'd118;
        end
        else begin
          drop_juice_vpos <= drop_juice_vpos + juice_drop_speed;
        end
      end
      else begin
        drop_juice_vpos <= 10'd118;
      end
  end
end
// juice random x control
reg [9:0] juice_pos_reg;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
    juice_pos_reg <= 176;
  end else if (drop_juice_vpos > 160) begin
    juice_pos_reg <= 126 + offset;
  end
end
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
// tea drop clock control
reg tea_drop_speed;
always @(posedge clk) begin
  if(~reset_n) begin
    tea_drop_clock <= 0;
  end
  else if (P == S_MAIN_DROP && remain_tea_num > 0 && remain_water_num == 0 && remain_juice_num == 0) begin
    if(tea_drop_speed == 1 || drop_tea_vpos > 160) begin
      tea_drop_clock <= 0;
    end
    else if(drop_tea_vpos > 160) begin
      tea_drop_clock <= 0;
    end
    else begin
      tea_drop_clock <= tea_drop_clock + 8;
    end
  end
  else begin
    tea_drop_clock <= 0;
  end
end
// tea drop speed control
always @(posedge clk) begin
  if(~reset_n) begin
    tea_drop_speed <= 0;
  end
  else if (P == S_MAIN_DROP && remain_tea_num > 0 && remain_water_num == 0 && remain_juice_num == 0) begin
    if(tea_drop_speed == 1) begin
      tea_drop_speed <= 0;
    end
    else if(tea_drop_clock[26:25] == 1) begin
      tea_drop_speed <= 1;
    end
  end
  else begin
    tea_drop_speed <= 0;
  end
end
// water drop vpos control
always @(posedge clk) begin
    if (~reset_n) begin
      drop_tea_vpos <= 10'd127;
    end else begin
      if (P == S_MAIN_DROP && remain_tea_num > 0 && remain_water_num == 0 && remain_juice_num == 0) begin
        if(drop_tea_vpos > 160) begin
          drop_tea_vpos <= 10'd127;
        end
        else begin
          drop_tea_vpos <= drop_tea_vpos + tea_drop_speed;
        end
      end
      else begin
        drop_tea_vpos <= 10'd127;
      end
  end
end
// tea random x control
reg [9:0] tea_pos_reg;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
    tea_pos_reg <= 158;
  end else if (drop_tea_vpos > 160) begin
    tea_pos_reg <= 126 + offset;
  end
end
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
// coke drop clock control
reg coke_drop_speed;
always @(posedge clk) begin
  if(~reset_n) begin
    coke_drop_clock <= 0;
  end
  else if (P == S_MAIN_DROP && remain_coke_num > 0 && remain_water_num == 0 && remain_tea_num == 0 && remain_juice_num == 0) begin
    if(coke_drop_speed == 1 || drop_coke_vpos > 160) begin
      coke_drop_clock <= 0;
    end
    else if(drop_coke_vpos > 160) begin
      coke_drop_clock <= 0;
    end
    else begin
      coke_drop_clock <= coke_drop_clock + 8;
    end
  end
  else begin
    coke_drop_clock <= 0;
  end
end
// coke drop speed control
always @(posedge clk) begin
  if(~reset_n) begin
    coke_drop_speed <= 0;
  end
  else if (P == S_MAIN_DROP && remain_coke_num > 0 && remain_water_num == 0 && remain_tea_num == 0 && remain_juice_num == 0) begin
    if(coke_drop_speed == 1) begin
      coke_drop_speed <= 0;
    end
    else if(coke_drop_clock[26:25] == 1) begin
      coke_drop_speed <= 1;
    end
  end
  else begin
    coke_drop_speed <= 0;
  end
end
// coke drop vpos control
always @(posedge clk) begin
    if (~reset_n) begin
      drop_coke_vpos <= 10'd121;
    end else begin
      if (P == S_MAIN_DROP && remain_coke_num > 0 && remain_water_num == 0 && remain_tea_num == 0 && remain_juice_num == 0) begin
        if(drop_coke_vpos > 160) begin
          drop_coke_vpos <= 10'd121;
        end
        else begin
          drop_coke_vpos <= drop_coke_vpos + coke_drop_speed;
        end
      end
      else begin
        drop_coke_vpos <= 10'd121;
      end
  end
end
// juice random x control
reg [9:0] coke_pos_reg;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
    coke_pos_reg <= 137;
  end else if (drop_coke_vpos > 160) begin
    coke_pos_reg <= 126 + offset;
  end
end

// End of the animation clock code.
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// Video frame buffer address generation unit (AGU) with scaling control
// Note that the width x height of the fish image is 64x32, when scaled-up
// on the screen, it becomes 128x64. 'pos' specifies the right edge of the
// fish image.

assign vend_region =
          pixel_y >= (vend_vpos<<1) && pixel_y < (vend_vpos+VEND_H)<<1 &&
          (pixel_x + 199) >= vend_pos && pixel_x < vend_pos + 1;

assign vending_water_region =
          pixel_y >= (vending_water_vpos<<1) && pixel_y < (vending_water_vpos + WATER_H)<<1 &&
          (pixel_x + 35) >= vending_water_pos && pixel_x < vending_water_pos + 1;

assign vending_juice_region =
          pixel_y >= (vending_juice_vpos<<1) && pixel_y < (vending_juice_vpos + JUICE_H)<<1 &&
          (pixel_x + 43) >= vending_juice_pos && pixel_x < vending_juice_pos + 1;

assign vending_tea_region =
          pixel_y >= (vending_tea_vpos<<1) && pixel_y < (vending_tea_vpos + TEA_H)<<1 &&
          (pixel_x + 43) >= vending_tea_pos && pixel_x < vending_tea_pos + 1;

assign vending_coke_region =
          pixel_y >= (vending_coke_vpos<<1) && pixel_y < (vending_coke_vpos + COKE_H)<<1 &&
          (pixel_x + 23) >= vending_coke_pos && pixel_x < vending_coke_pos + 1;

assign drop_region =
          pixel_y >= (drop_vpos<<1) && pixel_y < (drop_vpos+DROP_H)<<1 &&
          (pixel_x + 111) >= drop_pos && pixel_x < drop_pos + 1;

assign rest_region =
          pixel_y >= (rest_vpos<<1) && pixel_y < (rest_vpos+SM_BLOCK_H)<<1 &&
          (pixel_x + 199) >= sm_block_pos && pixel_x < sm_block_pos + 1;

assign error_region =
          pixel_y >= (error_vpos<<1) && pixel_y < (error_vpos+ERROR_H)<<1 &&
          (pixel_x + 41) >= error_pos && pixel_x < error_pos + 1;

assign num0_1_region =
          pixel_y >= (num0_1_vpos<<1) && pixel_y < (num0_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num0_1_pos && pixel_x < num0_1_pos + 1;

assign num0_2_region =
          pixel_y >= (num0_2_vpos<<1) && pixel_y < (num0_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num0_2_pos && pixel_x < num0_2_pos + 1;

assign num0_3_region =
          pixel_y >= (num0_3_vpos<<1) && pixel_y < (num0_3_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num0_3_pos && pixel_x < num0_3_pos + 1;

assign num0_4_region =
          pixel_y >= (num0_4_vpos<<1) && pixel_y < (num0_4_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num0_4_pos && pixel_x < num0_4_pos + 1;

assign num1_1_region =
          pixel_y >= (num1_1_vpos<<1) && pixel_y < (num1_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_1_pos && pixel_x < num1_1_pos + 1;

assign num1_2_region =
          pixel_y >= (num1_2_vpos<<1) && pixel_y < (num1_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_2_pos && pixel_x < num1_2_pos + 1;

assign num1_3_region =
          pixel_y >= (num1_3_vpos<<1) && pixel_y < (num1_3_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_3_pos && pixel_x < num1_3_pos + 1;

assign num1_4_region =
          pixel_y >= (num1_4_vpos<<1) && pixel_y < (num1_4_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_4_pos && pixel_x < num1_4_pos + 1;

assign num1_5_region =
          pixel_y >= (num1_5_vpos<<1) && pixel_y < (num1_5_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_5_pos && pixel_x < num1_5_pos + 1;

assign num1_6_region =
          pixel_y >= (num1_6_vpos<<1) && pixel_y < (num1_6_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_6_pos && pixel_x < num1_6_pos + 1;

assign num1_7_region =
          pixel_y >= (num1_7_vpos<<1) && pixel_y < (num1_7_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_7_pos && pixel_x < num1_7_pos + 1;

assign num1_8_region =
          pixel_y >= (num1_8_vpos<<1) && pixel_y < (num1_8_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num1_8_pos && pixel_x < num1_8_pos + 1;

assign num2_1_region =
          pixel_y >= (num2_1_vpos<<1) && pixel_y < (num2_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_1_pos && pixel_x < num2_1_pos + 1;

assign num2_2_region =
          pixel_y >= (num2_2_vpos<<1) && pixel_y < (num2_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_2_pos && pixel_x < num2_2_pos + 1;

assign num2_3_region =
          pixel_y >= (num2_3_vpos<<1) && pixel_y < (num2_3_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_3_pos && pixel_x < num2_3_pos + 1;

assign num2_4_region =
          pixel_y >= (num2_4_vpos<<1) && pixel_y < (num2_4_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_4_pos && pixel_x < num2_4_pos + 1;

assign num2_5_region =
          pixel_y >= (num2_5_vpos<<1) && pixel_y < (num2_5_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_5_pos && pixel_x < num2_5_pos + 1;

assign num2_6_region =
          pixel_y >= (num2_6_vpos<<1) && pixel_y < (num2_6_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_6_pos && pixel_x < num2_6_pos + 1;

assign num2_7_region =
          pixel_y >= (num2_7_vpos<<1) && pixel_y < (num2_7_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_7_pos && pixel_x < num2_7_pos + 1;

assign num2_8_region =
          pixel_y >= (num2_8_vpos<<1) && pixel_y < (num2_8_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_8_pos && pixel_x < num2_8_pos + 1;

assign num2_9_region =
          pixel_y >= (num2_9_vpos<<1) && pixel_y < (num2_9_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_9_pos && pixel_x < num2_9_pos + 1;

assign num2_10_region =
          pixel_y >= (num2_10_vpos<<1) && pixel_y < (num2_10_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_10_pos && pixel_x < num2_10_pos + 1;

assign num2_11_region =
          pixel_y >= (num2_11_vpos<<1) && pixel_y < (num2_11_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num2_11_pos && pixel_x < num2_11_pos + 1;

assign num_time_1_region =
          pixel_y >= (num_time_1_vpos<<1) && pixel_y < (num_time_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num_time_1_pos && pixel_x < num_time_1_pos + 1;

assign num_time_2_region =
          pixel_y >= (num_time_2_vpos<<1) && pixel_y < (num_time_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num_time_2_pos && pixel_x < num_time_2_pos + 1;

assign num3_1_region =
          pixel_y >= (num3_1_vpos<<1) && pixel_y < (num3_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num3_1_pos && pixel_x < num3_1_pos + 1;

assign num3_2_region =
          pixel_y >= (num3_2_vpos<<1) && pixel_y < (num3_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num3_2_pos && pixel_x < num3_2_pos + 1;

assign num3_3_region =
          pixel_y >= (num3_3_vpos<<1) && pixel_y < (num3_3_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num3_3_pos && pixel_x < num3_3_pos + 1;

assign num3_4_region =
          pixel_y >= (num3_4_vpos<<1) && pixel_y < (num3_4_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num3_4_pos && pixel_x < num3_4_pos + 1;

assign num4_1_region =
          pixel_y >= (num4_1_vpos<<1) && pixel_y < (num4_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num4_1_pos && pixel_x < num4_1_pos + 1;

assign num4_2_region =
          pixel_y >= (num4_2_vpos<<1) && pixel_y < (num4_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num4_2_pos && pixel_x < num4_2_pos + 1;

assign num4_3_region =
          pixel_y >= (num4_3_vpos<<1) && pixel_y < (num4_3_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num4_3_pos && pixel_x < num4_3_pos + 1;

assign num4_4_region =
          pixel_y >= (num4_4_vpos<<1) && pixel_y < (num4_4_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= num4_4_pos && pixel_x < num4_4_pos + 1;

assign slash1_1_region =
          pixel_y >= (slash1_1_vpos<<1) && pixel_y < (slash1_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash1_1_pos && pixel_x < slash1_1_pos + 1;

assign slash1_2_region =
          pixel_y >= (slash1_2_vpos<<1) && pixel_y < (slash1_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash1_2_pos && pixel_x < slash1_2_pos + 1;

assign slash1_3_region =
          pixel_y >= (slash1_3_vpos<<1) && pixel_y < (slash1_3_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash1_3_pos && pixel_x < slash1_3_pos + 1;

assign slash1_4_region =
          pixel_y >= (slash1_4_vpos<<1) && pixel_y < (slash1_4_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash1_4_pos && pixel_x < slash1_4_pos + 1;

assign slash2_1_region =
          pixel_y >= (slash2_1_vpos<<1) && pixel_y < (slash2_1_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash2_1_pos && pixel_x < slash2_1_pos + 1;

assign slash2_2_region =
          pixel_y >= (slash2_2_vpos<<1) && pixel_y < (slash2_2_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash2_2_pos && pixel_x < slash2_2_pos + 1;

assign slash2_3_region =
          pixel_y >= (slash2_3_vpos<<1) && pixel_y < (slash2_3_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash2_3_pos && pixel_x < slash2_3_pos + 1;

assign slash2_4_region =
          pixel_y >= (slash2_4_vpos<<1) && pixel_y < (slash2_4_vpos+NUM_H)<<1 &&
          (pixel_x + 13) >= slash2_4_pos && pixel_x < slash2_4_pos + 1;

assign select_top_region =
          pixel_y >= (select_top_vpos<<1) && pixel_y < (select_top_vpos+10)<<1 &&
          (pixel_x + 379) >= select_top_pos && pixel_x < select_top_pos + 1;

assign select_region1 =
          pixel_y >= (select_vpos1<<1) && pixel_y < (select_vpos1+40)<<1 &&
          (pixel_x + 379) >= select_pos1 && pixel_x < select_pos1 + 1;

assign select_region2 =
          pixel_y >= (select_vpos2<<1) && pixel_y < (select_vpos2+40)<<1 &&
          (pixel_x + 379) >= select_pos2 && pixel_x < select_pos2 + 1;

assign money_top_region =
          pixel_y >= (money_top_vpos<<1) && pixel_y < (money_top_vpos+10)<<1 &&
          (pixel_x + 379) >= money_top_pos && pixel_x < money_top_pos + 1;

assign money_region1 =
          pixel_y >= (money_vpos1<<1) && pixel_y < (money_vpos1+40)<<1 &&
          (pixel_x + 379) >= money_pos1 && pixel_x < money_pos1 + 1;

assign money_region2 =
          pixel_y >= (money_vpos2<<1) && pixel_y < (money_vpos2+40)<<1 &&
          (pixel_x + 379) >= money_pos2 && pixel_x < money_pos2 + 1;

assign block1_region =
    (
        (pixel_y == (block1_vpos << 1)) &&
        ((pixel_x + 379) >= block1_pos && pixel_x < block1_pos + 1)
    ) ||
    (
        (pixel_y == ((block1_vpos + BLOCK_H) << 1) - 1) &&
        ((pixel_x + 379) >= block1_pos && pixel_x < block1_pos + 1)
    ) ||
    (
        (pixel_x == block1_pos) &&
        (pixel_y >= (block1_vpos << 1) && pixel_y < (block1_vpos + BLOCK_H) << 1)
    ) ||
    (
        (pixel_x == block1_pos - 2 * BLOCK_W + 1) &&
        (pixel_y >= (block1_vpos << 1) && pixel_y < (block1_vpos + BLOCK_H) << 1)
    );

assign block2_region =
    (
        (pixel_y == (block2_vpos << 1)) &&
        ((pixel_x + 379) >= block2_pos && pixel_x < block2_pos + 1)
    ) ||
    (
        (pixel_y == ((block2_vpos + BLOCK_H) << 1) - 1) &&
        ((pixel_x + 379) >= block2_pos && pixel_x < block2_pos + 1)
    ) ||
    (
        (pixel_x == block2_pos) &&
        (pixel_y >= (block2_vpos << 1) && pixel_y < (block2_vpos + BLOCK_H) << 1)
    ) ||
    (
        (pixel_x == block2_pos - 2 * BLOCK_W + 1) &&
        (pixel_y >= (block2_vpos << 1) && pixel_y < (block2_vpos + BLOCK_H) << 1)
    );

assign block3_region =
    (
        (pixel_y == (block3_vpos << 1)) &&
        ((pixel_x + 379) >= block3_pos && pixel_x < block3_pos + 1)
    ) ||
    (
        (pixel_y == ((block3_vpos + BLOCK_H) << 1) - 1) &&
        ((pixel_x + 379) >= block3_pos && pixel_x < block3_pos + 1)
    ) ||
    (
        (pixel_x == block3_pos) &&
        (pixel_y >= (block3_vpos << 1) && pixel_y < (block3_vpos + BLOCK_H) << 1)
    ) ||
    (
        (pixel_x == block3_pos - 2 * BLOCK_W + 1) &&
        (pixel_y >= (block3_vpos << 1) && pixel_y < (block3_vpos + BLOCK_H) << 1)
    );

assign block4_region =
    (
        (pixel_y == (block4_vpos << 1)) &&
        ((pixel_x + 379) >= block4_pos && pixel_x < block4_pos + 1)
    ) ||
    (
        (pixel_y == ((block4_vpos + BLOCK_H) << 1) - 1) &&
        ((pixel_x + 379) >= block4_pos && pixel_x < block4_pos + 1)
    ) ||
    (
        (pixel_x == block4_pos) &&
        (pixel_y >= (block4_vpos << 1) && pixel_y < (block4_vpos + BLOCK_H) << 1)
    ) ||
    (
        (pixel_x == block4_pos - 2 * BLOCK_W + 1) &&
        (pixel_y >= (block4_vpos << 1) && pixel_y < (block4_vpos + BLOCK_H) << 1)
    );

assign sm_block_region =
    (
        (pixel_y == (sm_block_vpos << 1)) &&
        ((pixel_x + 199) >= sm_block_pos && pixel_x < sm_block_pos + 1)
    ) ||
    (
        (pixel_y == ((sm_block_vpos + SM_BLOCK_H) << 1) - 1) &&
        ((pixel_x + 199) >= sm_block_pos && pixel_x < sm_block_pos + 1)
    ) ||
    (
        (pixel_x == sm_block_pos) &&
        (pixel_y >= (sm_block_vpos << 1) && pixel_y < (sm_block_vpos + SM_BLOCK_H) << 1)
    ) ||
    (
        (pixel_x == sm_block_pos - 2 * SM_BLOCK_W + 1) &&
        (pixel_y >= (sm_block_vpos << 1) && pixel_y < (sm_block_vpos + SM_BLOCK_H) << 1)
    );

function [20:0] select_base_addr;
  input [3:0] tmp_val;
  begin
    case(tmp_val)
      4'd0: select_base_addr = zero_addr;
      4'd1: select_base_addr = one_addr;
      4'd2: select_base_addr = two_addr;
      4'd3: select_base_addr = three_addr;
      4'd4: select_base_addr = four_addr;
      4'd5: select_base_addr = five_addr;
      4'd6: select_base_addr = six_addr;
      4'd7: select_base_addr = seven_addr;
      4'd8: select_base_addr = eight_addr;
      4'd9: select_base_addr = nine_addr;
      default: select_base_addr = zero_addr;
    endcase
  end
endfunction



assign fall_water_region =
          pixel_y >= (drop_water_vpos<<1) && 
          pixel_y < ((drop_water_vpos + WATER_H)<<1) &&
          (pixel_x + 35) >= drop_water_pos && pixel_x < (drop_water_pos + 1);

assign fall_tea_region =
          pixel_y >= (drop_tea_vpos<<1) && 
          pixel_y < ((drop_tea_vpos + TEA_H)<<1) &&
          (pixel_x + 43) >= drop_tea_pos && pixel_x < (drop_tea_pos + 1);

assign fall_juice_region =
          pixel_y >= (drop_juice_vpos<<1) && 
          pixel_y < ((drop_juice_vpos + JUICE_H)<<1) &&
          (pixel_x + 43) >= drop_juice_pos && pixel_x < (drop_juice_pos + 1);

assign fall_coke_region =
          pixel_y >= (drop_coke_vpos<<1) && 
          pixel_y < ((drop_coke_vpos + COKE_H)<<1) &&
          (pixel_x + 23) >= drop_coke_pos && pixel_x < (drop_coke_pos + 1);


always @ (posedge clk) begin
  if (~reset_n)
    pixel_vend_addr <= 0;
  else begin
      if (vend_region) begin
        pixel_vend_addr <= ((pixel_y>>1) - vend_vpos)*VEND_W +
                      ((pixel_x +(VEND_W*2-1)-vend_pos)>>1);
      end

      if (fall_water_region) begin
        pixel_water_addr <= ((pixel_y>>1) - drop_water_vpos)*WATER_W +
                      ((pixel_x + (WATER_W*2-1) - drop_water_pos)>>1);
      end
      if (fall_tea_region) begin
        pixel_tea_addr <= ((pixel_y>>1) - drop_tea_vpos)*TEA_W +
                      ((pixel_x + (TEA_W*2-1) - drop_tea_pos)>>1);
      end
      if (fall_juice_region) begin
        pixel_juice_addr <= juice_addr2 + ((pixel_y>>1) - drop_juice_vpos)*JUICE_W +
                      ((pixel_x + (JUICE_W*2-1) - drop_juice_pos)>>1);
      end
      if (fall_coke_region) begin
        pixel_coke_addr <= coke_addr2 + ((pixel_y>>1) - drop_coke_vpos)*COKE_W +
                      ((pixel_x + (COKE_W*2-1) - drop_coke_pos)>>1);
      end
      if (vending_water_region) begin
        pixel_water_addr2 <= ((pixel_y>>1)-vending_water_vpos)*WATER_W +
                      ((pixel_x +(WATER_W*2-1)-vending_water_pos)>>1);
      end
      if (vending_juice_region) begin
        pixel_juice_addr2 <= juice_addr2+((pixel_y>>1)-vending_juice_vpos)*JUICE_W +
                      ((pixel_x +(JUICE_W*2-1)-vending_juice_pos)>>1);
      end

      if (select_top_region) begin
        pixel_select_top_addr <= select_top_addr + ((pixel_y >> 1) - select_top_vpos) * BLOCK_W +
                              ((pixel_x + (BLOCK_W * 2 - 1) - select_top_pos) >> 1);
      end
      if (select_region1) begin
        pixel_select_addr <= select_addr + ((pixel_y >> 1) - select_vpos1) * BLOCK_W +
                              ((pixel_x + (BLOCK_W * 2 - 1) - select_pos1) >> 1);
      end
      if (select_region2) begin
        pixel_select_addr <= select_addr + 
                              ((pixel_y >> 1) - select_vpos2) * BLOCK_W +
                              ((pixel_x + (BLOCK_W * 2 - 1) - select_pos2) >> 1);
      end

      if (money_top_region) begin
        pixel_money_top_addr <= money_top_addr+((pixel_y >> 1) - money_top_vpos) * BLOCK_W +
                              ((pixel_x + (BLOCK_W * 2 - 1) - money_top_pos) >> 1);
      end
      if (money_region1) begin
        pixel_money_addr <= money_addr + ((pixel_y >> 1) - money_vpos1) * BLOCK_W +
                              ((pixel_x + (BLOCK_W * 2 - 1) - money_pos1) >> 1);
      end
      if (money_region2) begin
        pixel_money_addr <= money_addr + ((pixel_y >> 1) - money_vpos2) * BLOCK_W +
                              ((pixel_x + (BLOCK_W * 2 - 1) - money_pos2) >> 1);
      end

      if (rest_region) begin
        pixel_rest_addr <=  ((pixel_y >> 1) - rest_vpos) * SM_BLOCK_W +
                              ((pixel_x + (SM_BLOCK_W * 2 - 1) - sm_block_pos) >> 1);
      end

      if (error_region) begin
        pixel_error_addr <=  ((pixel_y >> 1) - error_vpos) * ERROR_W +
                              ((pixel_x + (ERROR_W * 2 - 1) - error_pos) >> 1);
      end
      
      if (num0_1_region) begin
        pixel_num_addr <= select_base_addr(mach_coin_one) + 
                              ((pixel_y >> 1) - num0_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num0_1_pos) >> 1);
      end

      if (num0_2_region) begin
        pixel_num_addr <= select_base_addr(mach_coin_five) + 
                              ((pixel_y >> 1) - num0_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num0_2_pos) >> 1);
      end

      if (num0_3_region) begin
        pixel_num_addr <= select_base_addr(mach_coin_ten) + 
                              ((pixel_y >> 1) - num0_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num0_3_pos) >> 1);
      end

      if (num0_4_region) begin
        pixel_num_addr <= select_base_addr(mach_coin_hundred) + 
                              ((pixel_y >> 1) - num0_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num0_4_pos) >> 1);
      end

      if (num1_1_region) begin
        pixel_num_addr <= select_base_addr(used_water_num) + 
                              ((pixel_y >> 1) - num1_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_1_pos) >> 1);
      end
      if (num1_2_region) begin
        pixel_num_addr <= select_base_addr(water_num) + 
                              ((pixel_y >> 1) - num1_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_2_pos) >> 1);
      end
      if (num1_3_region) begin
        pixel_num_addr <= select_base_addr(used_juice_num) + 
                              ((pixel_y >> 1) - num1_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_3_pos) >> 1);
      end
      if (num1_4_region) begin
        pixel_num_addr <= select_base_addr(juice_num) + 
                              ((pixel_y >> 1) - num1_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_4_pos) >> 1);
      end
      if (num1_5_region) begin
        pixel_num_addr <= select_base_addr(used_tea_num) + 
                              ((pixel_y >> 1) - num1_5_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_5_pos) >> 1);
      end
      if (num1_6_region) begin
        pixel_num_addr <= select_base_addr(tea_num) + 
                              ((pixel_y >> 1) - num1_6_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_6_pos) >> 1);
      end
      if (num1_7_region) begin
        pixel_num_addr <= select_base_addr(used_coke_num) + 
                              ((pixel_y >> 1) - num1_7_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_7_pos) >> 1);
      end
      if (num1_8_region) begin
        pixel_num_addr <= select_base_addr(coke_num) + 
                              ((pixel_y >> 1) - num1_8_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num1_8_pos) >> 1);
      end
      if (num2_1_region) begin
        pixel_num_addr <= select_base_addr(used_coin_one) + 
                              ((pixel_y >> 1) - num2_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_1_pos) >> 1);
      end
      if (num2_2_region) begin
        pixel_num_addr <= select_base_addr(coin_one) + 
                              ((pixel_y >> 1) - num2_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_2_pos) >> 1);
      end
      if (num2_3_region) begin
        pixel_num_addr <= select_base_addr(used_coin_five) + 
                              ((pixel_y >> 1) - num2_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_3_pos) >> 1);
      end
      if (num2_4_region) begin
        pixel_num_addr <= select_base_addr(coin_five) + 
                              ((pixel_y >> 1) - num2_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_4_pos) >> 1);
      end
      if (num2_5_region) begin
        pixel_num_addr <= select_base_addr(used_coin_ten) + 
                              ((pixel_y >> 1) - num2_5_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_5_pos) >> 1);
      end
      if (num2_6_region) begin
        pixel_num_addr <= select_base_addr(coin_ten) + 
                              ((pixel_y >> 1) - num2_6_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_6_pos) >> 1);
      end
      if (num2_7_region) begin
        pixel_num_addr <= select_base_addr(used_coin_hundred) + 
                              ((pixel_y >> 1) - num2_7_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_7_pos) >> 1);
      end
      if (num2_8_region) begin
        pixel_num_addr <= select_base_addr(coin_hundred) + 
                              ((pixel_y >> 1) - num2_8_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_8_pos) >> 1);
      end
      if (num2_9_region) begin
        pixel_num_addr <= select_base_addr(hundreds_num) + 
                              ((pixel_y >> 1) - num2_9_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_9_pos) >> 1);
      end
      if (num2_10_region) begin
        pixel_num_addr <= select_base_addr(tens_num) + 
                              ((pixel_y >> 1) - num2_10_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_10_pos) >> 1);
      end
      if (num2_11_region) begin
        pixel_num_addr <= select_base_addr(ones_num) + 
                              ((pixel_y >> 1) - num2_11_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num2_11_pos) >> 1);
      end
      if (num_time_1_region) begin
        pixel_num_addr <= select_base_addr(time_tens_num) + 
                              ((pixel_y >> 1) - num_time_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num_time_1_pos) >> 1);
      end
      if (num_time_2_region) begin
        pixel_num_addr <= select_base_addr(time_ones_num) + 
                              ((pixel_y >> 1) - num_time_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num_time_2_pos) >> 1);
      end
      if (num3_1_region) begin
        pixel_num_addr <= select_base_addr(ret_coin_one) + 
                              ((pixel_y >> 1) - num3_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num3_1_pos) >> 1);
      end
      if (num3_2_region) begin
        pixel_num_addr <= select_base_addr(ret_coin_five) + 
                              ((pixel_y >> 1) - num3_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num3_2_pos) >> 1);
      end
      if (num3_3_region) begin
        pixel_num_addr <= select_base_addr(ret_coin_ten) + 
                              ((pixel_y >> 1) - num3_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num3_3_pos) >> 1);
      end
      if (num3_4_region) begin
        pixel_num_addr <= select_base_addr(ret_coin_hundred) + 
                              ((pixel_y >> 1) - num3_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num3_4_pos) >> 1);
      end
      if (num4_1_region) begin
        if (P == S_MAIN_DROP)
          pixel_num_addr <= select_base_addr(used_water_num - remain_water_num) +
                              ((pixel_y >> 1) - num4_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_1_pos) >> 1);
        else
          pixel_num_addr <= select_base_addr(0) +
                              ((pixel_y >> 1) - num4_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_1_pos) >> 1);
      end
      if (num4_2_region) begin
        if (P == S_MAIN_DROP)
          pixel_num_addr <= select_base_addr(used_juice_num - remain_juice_num) +
                              ((pixel_y >> 1) - num4_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_2_pos) >> 1);
        else
          pixel_num_addr <= select_base_addr(0) +
                              ((pixel_y >> 1) - num4_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_2_pos) >> 1);
      end
      if (num4_3_region) begin
        if (P == S_MAIN_DROP)
          pixel_num_addr <= select_base_addr(used_tea_num - remain_tea_num) +
                              ((pixel_y >> 1) - num4_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_3_pos) >> 1);
        else
          pixel_num_addr <= select_base_addr(0) +
                              ((pixel_y >> 1) - num4_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_3_pos) >> 1);
      end
      if (num4_4_region) begin
        if (P == S_MAIN_DROP)
          pixel_num_addr <= select_base_addr(used_coke_num - remain_coke_num) +
                              ((pixel_y >> 1) - num4_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_4_pos) >> 1);
        else
          pixel_num_addr <= select_base_addr(0) +
                              ((pixel_y >> 1) - num4_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - num4_4_pos) >> 1);
      end
      if (slash1_1_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash1_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash1_1_pos) >> 1);
      end
      if (slash1_2_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash1_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash1_2_pos) >> 1);
      end
      if (slash1_3_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash1_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash1_3_pos) >> 1);
      end
      if (slash1_4_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash1_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash1_4_pos) >> 1);
      end
      if (slash2_1_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash2_1_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash2_1_pos) >> 1);
      end
      if (slash2_2_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash2_2_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash2_2_pos) >> 1);
      end
      if (slash2_3_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash2_3_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash2_3_pos) >> 1);
      end
      if (slash2_4_region) begin
        pixel_slash_addr <= slash_addr + ((pixel_y >> 1) - slash2_4_vpos) * NUM_W +
                              ((pixel_x + (NUM_W * 2 - 1) - slash2_4_pos) >> 1);
      end
      if (vending_tea_region) begin
        pixel_tea_addr2 <= ((pixel_y>>1)-vending_tea_vpos)*TEA_W +
                      ((pixel_x +(TEA_W*2-1)-vending_tea_pos)>>1);
      end
      if (vending_coke_region) begin
        pixel_coke_addr2 <= coke_addr2+((pixel_y>>1)-vending_coke_vpos)*COKE_W +
                      ((pixel_x +(COKE_W*2-1)-vending_coke_pos)>>1);
    end
  end
end

// End of the AGU code.
// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
//deal with feature of sold_out
wire water_sold_out;
wire juice_sold_out;
wire tea_sold_out;
wire coke_sold_out;
// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// Send the video data in the sram to the VGA controller
always @(posedge clk) begin
  if (pixel_tick) rgb_reg <= rgb_next;
end

always @(*) begin
  if (~video_on)
    rgb_next = 12'h000; // Synchronization period, must set RGB values to zero.
  else begin
    if (drop_region && fall_water_region && data_water_out != 12'h0f0)
      rgb_next = data_water_out;
    else if (drop_region && fall_tea_region && data_tea_out != 12'h0f0)
      rgb_next = data_tea_out;
    else if (drop_region && fall_juice_region && data_juice_out != 12'h0f0)
      rgb_next = data_juice_out;
    else if (drop_region && fall_coke_region && data_coke_out != 12'h0f0)
      rgb_next = data_coke_out;

    else if (vending_water_region && data_water_out2 != 12'h0f0 && !water_sold_out)
      rgb_next = data_water_out2;
    else if (vending_juice_region && data_juice_out2 != 12'h0f0 && !juice_sold_out)
      rgb_next = data_juice_out2;
    else if (vending_tea_region && data_tea_out2 != 12'h0f0 && !tea_sold_out)
      rgb_next = data_tea_out2;
    else if (vending_coke_region && data_coke_out2 != 12'h0f0 && !coke_sold_out)
      rgb_next = data_coke_out2;
    
    // else if (vend_region && data_vend_out != 12'h0f0)
    //   rgb_next = data_vend_out;
      // rgb_next = 12'hf00;
    // else if (fish2_region && data_f2_out != 12'h0f0)
    //   rgb_next = data_f2_out;
    // else if (fish3_region && data_f3_out != 12'h0f0)
    //   rgb_next = data_f3_out;
    // if (vend_region)
    //   // rgb_next = data_vend_out;
    //   rgb_next = 12'hf00;

    else if (error_region && data_error_out != 12'h0f0 && P == S_MAIN_ERROR)
      rgb_next = data_error_out;
    // else if (error_region)
    //   rgb_next = 12'hf00;
    
    else if (num0_1_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num0_2_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num0_3_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num0_4_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;

    else if (num1_1_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num1_2_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num1_3_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num1_4_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num1_5_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num1_6_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num1_7_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num1_8_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_1_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_2_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_3_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_4_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_5_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_6_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_7_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_8_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num3_1_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num3_2_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num3_3_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num3_4_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num4_1_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num4_2_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num4_3_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num4_4_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    
    else if (num2_9_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_10_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    else if (num2_11_region && data_num_out != 12'h0f0)
      rgb_next = data_num_out;
    // else if (num2_9_region)
    //   rgb_next = 12'hf00;
    // else if (num2_10_region)
    //   rgb_next = 12'hf00;
    // else if (num2_11_region)
    //   rgb_next = 12'hf00;
    else if (num_time_1_region && data_num_out != 12'h0f0 && (P == S_MAIN_BUY || P == S_MAIN_PAY))
      rgb_next = data_num_out;
    else if (num_time_2_region && data_num_out != 12'h0f0 && (P == S_MAIN_BUY || P == S_MAIN_PAY))
      rgb_next = data_num_out;
    
    else if (slash1_1_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (slash1_2_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (slash1_3_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (slash1_4_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (slash2_1_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (slash2_2_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (slash2_3_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (slash2_4_region && data_slash_out != 12'h0f0)
      rgb_next = data_slash_out;
    else if (vend_region && data_vend_out != 12'h0f0) begin
      if(usr_sw[1])
        rgb_next = data_vend_out;
      else
        rgb_next = 12'hfff - data_vend_out;
    end
    else if (block1_region)
      rgb_next = (P == S_MAIN_BUY) ? 12'h96b : 12'h555;
    else if (block2_region)
      rgb_next = (P == S_MAIN_PAY) ? 12'h96b : 12'h555;
    else if (block3_region)
      rgb_next = (P == S_MAIN_CALC) ? 12'h96b : 12'h555;
    else if (block4_region)
      rgb_next = (P == S_MAIN_DROP) ? 12'h96b : 12'h555;

    else if (rest_region && data_rest_out != 12'h0f0)
      rgb_next = data_rest_out;

    else if (select_top_region && data_select_top_out != 12'h0f0)
      rgb_next = data_select_top_out;
    else if (select_region1 && data_select_out != 12'h0f0)
      rgb_next = data_select_out;
    else if (select_region2 && data_select_out != 12'h0f0)
      rgb_next = data_select_out;
    else if (money_top_region && data_money_top_out != 12'h0f0)
      rgb_next = data_money_top_out;
    else if (money_region1 && data_money_out != 12'h0f0)
      rgb_next = data_money_out;
    else if (money_region2 && data_money_out != 12'h0f0)
      rgb_next = data_money_out;

    else if (sm_block_region)
      rgb_next = (P == S_MAIN_ERROR) ? 12'hd24 : 12'h555;
    else begin
      if(usr_sw[1])
        rgb_next = 12'hed5;
      else
        rgb_next = 12'h29F;
    end
  end
end
// End of the video data display code.
// ------------------------------------------------------------------------

localparam [3:0] 
  S_MAIN_INIT         = 4'd0,
  S_MAIN_BUY          = 4'd1,
  S_MAIN_PAY          = 4'd2,
  S_MAIN_CALC         = 4'd3,
  S_MAIN_DROP         = 4'd4,
  S_MAIN_ERROR        = 4'd5;

reg [3:0] P, P_next;
localparam INIT_DELAY = 100_000; // 1 msec @ 100 MHz
reg [$clog2(INIT_DELAY):0] init_counter;

assign usr_led = P;

reg calc_done;
reg [1:0] refund_valid;

wire times_up;


// ------------------------------------------------------------------------
// FSM of the main controller
always @(posedge clk) begin
  if (~reset_n) begin
    P <= S_MAIN_INIT;
  end
  else begin
    P <= P_next;
  end
end

always @(*) begin // FSM next-state logic
  case (P)
      S_MAIN_INIT:
        P_next = (init_counter < INIT_DELAY) ? S_MAIN_BUY : S_MAIN_INIT;

      S_MAIN_BUY:begin
        if(times_up)begin
          P_next = S_MAIN_ERROR;
        end
        else if(btn_pressed[3])begin
          P_next = S_MAIN_PAY;
        end
        else begin
          P_next = S_MAIN_BUY;
        end
      end
      S_MAIN_PAY:begin
        if(times_up)begin
          P_next = S_MAIN_ERROR;
        end
        else if(btn_pressed[3])begin
          P_next = S_MAIN_CALC;
        end
        else begin
          P_next = S_MAIN_PAY;
        end
      end

      S_MAIN_CALC: begin
        if (calc_done) begin
          if (refund_valid == 2'b10) begin
            P_next = S_MAIN_DROP;
          end else begin
            P_next = S_MAIN_ERROR;
          end
        end else begin
          P_next = S_MAIN_CALC;
        end
      end
      S_MAIN_DROP:
        P_next = (btn_pressed[3]) ? S_MAIN_INIT : S_MAIN_DROP;
      S_MAIN_ERROR:
        P_next = (btn_pressed[3]) ? S_MAIN_INIT : S_MAIN_ERROR;
      default:
        P_next = S_MAIN_INIT;
  endcase
end

// FSM ouput logic: Fetch the data bus of sram[] for display

// End of the main controller

// ------------------------------------------------------------------------
// S_MAIN_INIT
always @(posedge clk) begin
  if (P == S_MAIN_INIT) init_counter <= init_counter + 1;
  else init_counter <= 0;
end
// ------------------------------------------------------------------------

localparam WATER_VALUE = 9,
           JUICE_VALUE = 5,
           TEA_VALUE = 4,
           COKE_VALUE = 1;

// S_MAIN_BUY
reg [8:0] total_amount; // item value
reg [3:0] water_num, tea_num, juice_num, coke_num; // we have how many coin
reg [3:0] used_water_num, used_tea_num, used_juice_num, used_coke_num; // we have used how many coin
reg [1:0] item_pointer;
assign water_sold_out = (water_num == used_water_num) || water_out;
assign juice_sold_out = (juice_num == used_juice_num) || juice_out;
assign tea_sold_out = (tea_num == used_tea_num) || tea_out;
assign coke_sold_out = (coke_num == used_coke_num) || coke_out;
localparam [1:0] CHOOSE_WATER = 2'd0,
                 CHOOSE_TEA = 2'd2,
                 CHOOSE_JUICE = 2'd1,
                 CHOOSE_COKE = 2'd3;

// choose what item
always @(posedge clk) begin
  if (~reset_n)begin
    item_pointer = 0;
  end
  else if (P == S_MAIN_INIT) begin
    item_pointer = 0;
  end
  else if (P == S_MAIN_BUY) begin
    if (btn_pressed[1]) begin
      item_pointer = item_pointer - 1;
    end
    else if (btn_pressed[0]) begin
      item_pointer = item_pointer + 1;
    end
  end
end
// add or minus item
// calculate total amount
always @(posedge clk) begin
  if (~reset_n)begin
    used_water_num <= 0;
    used_tea_num <= 0;
    used_juice_num <= 0;
    used_coke_num <= 0;
    total_amount <= 0;
  end
  else if (P == S_MAIN_INIT)begin
    used_water_num <= 0;
    used_tea_num <= 0;
    used_juice_num <= 0;
    used_coke_num <= 0;
  end
  else if (P == S_MAIN_BUY) begin 
    if (btn_pressed[2]) begin
      if(usr_sw[0]) begin
        // add item
        case(item_pointer)
          CHOOSE_WATER: begin
            if(used_water_num < water_num)
              used_water_num <= used_water_num + 1;
          end
          CHOOSE_TEA: begin
            if(used_tea_num < tea_num)
              used_tea_num <= used_tea_num + 1;
          end
          CHOOSE_JUICE: begin
            if(used_juice_num < juice_num)
              used_juice_num <= used_juice_num + 1;
          end
          CHOOSE_COKE: begin
            if(used_coke_num < coke_num)
              used_coke_num <= used_coke_num + 1;
          end
        endcase
      end
      else begin
        // minus item
        case(item_pointer)
          CHOOSE_WATER: begin
            if(used_water_num > 0)
              used_water_num <= used_water_num - 1;
          end
          CHOOSE_TEA: begin
            if(used_tea_num > 0)
              used_tea_num <= used_tea_num - 1;
          end
          CHOOSE_JUICE: begin
            if(used_juice_num > 0)
              used_juice_num <= used_juice_num - 1;
          end
          CHOOSE_COKE: begin
            if(used_coke_num > 0)
              used_coke_num <= used_coke_num - 1;
          end
        endcase
      end
    end
    else if (btn_pressed[3]) begin
      total_amount <= used_water_num * WATER_VALUE + used_tea_num * TEA_VALUE+
                      used_juice_num * JUICE_VALUE + used_coke_num * COKE_VALUE;
    end
  end
end
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// S_MAIN_PAY
reg [7:0] used_total;
reg [3:0] coin_one, coin_five, coin_ten, coin_hundred; // we have how many coin
reg [3:0] used_coin_one, used_coin_five, used_coin_ten, used_coin_hundred; // we have used how many coin
reg [1:0] coin_pointer; // choose what coin to pay
localparam [1:0] CHOOSE_ONE = 2'd0,
                 CHOOSE_FIVE = 2'd1,
                 CHOOSE_TEN = 2'd2,
                 CHOOSE_HUNDRED = 2'd3;

always @(posedge clk) begin
  if (~reset_n)begin
    coin_pointer = 0;
  end
  else if (P == S_MAIN_INIT) begin
    coin_pointer = 0;
  end
  else if (P == S_MAIN_PAY) begin
    if (btn_pressed[1]) begin
      coin_pointer <= coin_pointer - 1;
    end
    else if (btn_pressed[0]) begin
      coin_pointer <= coin_pointer + 1;
    end
  end
end

always @(posedge clk) begin
  if (~reset_n)begin
    used_coin_one <= 0;
    used_coin_five <= 0;
    used_coin_ten <= 0;
    used_coin_hundred <= 0;
  end
  else if (P == S_MAIN_INIT)begin
    used_coin_one <= 0;
    used_coin_five <= 0;
    used_coin_ten <= 0;
    used_coin_hundred <= 0;
    used_total <= 0;
  end
  else if (P == S_MAIN_PAY) begin
    if (btn_pressed[2]) begin
      if(usr_sw[0]) begin
        // add coin
        case(coin_pointer)
          CHOOSE_ONE: begin
            if(used_coin_one < coin_one)
              used_coin_one <= used_coin_one + 1;
          end
          CHOOSE_FIVE: begin
            if(used_coin_five < coin_five)
              used_coin_five <= used_coin_five + 1;
          end
          CHOOSE_TEN: begin
            if(used_coin_ten < coin_ten)
              used_coin_ten <= used_coin_ten + 1;
          end
          CHOOSE_HUNDRED: begin
            if(used_coin_hundred < coin_hundred)
              used_coin_hundred <= used_coin_hundred + 1;
          end
        endcase
      end
      else begin
        // minus coin
        case(coin_pointer)
          CHOOSE_ONE: begin
            if(used_coin_one > 0)
              used_coin_one <= used_coin_one - 1;
          end
          CHOOSE_FIVE: begin
            if(used_coin_five > 0)
              used_coin_five <= used_coin_five - 1;
          end
          CHOOSE_TEN: begin
            if(used_coin_ten > 0)
              used_coin_ten <= used_coin_ten - 1;
          end
          CHOOSE_HUNDRED: begin
            if(used_coin_hundred > 0)
              used_coin_hundred <= used_coin_hundred - 1;
          end
        endcase
      end
    end
    used_total = used_coin_one * 1 + used_coin_five * 5 + 
                used_coin_ten * 10 + used_coin_hundred * 100;
  end
end

//total counter
wire[3:0]hundreds_num,tens_num,ones_num;
assign hundreds_num = used_total/100;
assign tens_num = (used_total%100)/10;
assign ones_num = used_total%10;

// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// timer
reg [31:0]process_timer;
reg [6:0]count_down;

wire[3:0]time_tens_num,time_ones_num;
assign time_tens_num = count_down/10;
assign time_ones_num = count_down%10;

assign times_up = (count_down == 0);
always  @(posedge clk)begin
  if(~reset_n || times_up)begin
    process_timer <= 0;
    count_down <= 99;
  end 
  else if((P == S_MAIN_BUY || P == S_MAIN_PAY) && (count_down > 0))begin
    if(btn_pressed[0] || btn_pressed[1] || btn_pressed[2] || btn_pressed[3])begin
      process_timer <= 0;
      count_down <= 99;
    end
    else if(process_timer == 99999999)begin
      process_timer <= 0;
      count_down <= count_down - 1; 
    end 
    else begin
      process_timer <= process_timer + 1;
    end
  end
end

// ------------------------------------------------------------------------
// S_MAIN_CALC


reg [3:0] mach_coin_one, mach_coin_five, mach_coin_ten, mach_coin_hundred;
reg [3:0] ret_coin_one, ret_coin_five, ret_coin_ten, ret_coin_hundred;
reg [8:0] refund;

always @ (posedge clk) begin
  if (~reset_n) begin
    ret_coin_one     <= 4'd0;
    ret_coin_five    <= 4'd0;
    ret_coin_ten     <= 4'd0;
    ret_coin_hundred <= 4'd0;
    refund_valid     <= 2'b00;
    calc_done        <= 1'b0;
    mach_coin_one    <= 4'd4;
    mach_coin_five   <= 4'd6;
    mach_coin_ten    <= 4'd7;
    mach_coin_hundred<= 4'd3;
    coin_one <= 5;
    coin_five <= 3;
    coin_ten <= 2;
    coin_hundred <= 1;
    water_num <= 9;
    tea_num <= 9;
    juice_num <= 9;
    coke_num <= 9;
  end else if(P == S_MAIN_INIT)begin 
    calc_done <= 1'b0;
    ret_coin_hundred = 4'd0;
    ret_coin_ten     = 4'd0;
    ret_coin_five    = 4'd0;
    ret_coin_one     = 4'd0;
  end else if (P == S_MAIN_CALC && (calc_done == 0)) begin      
    if (used_total >= total_amount) begin
        refund = used_total - total_amount;
        
        // Initialize refund coins
        ret_coin_hundred = 4'd0;
        ret_coin_ten     = 4'd0;
        ret_coin_five    = 4'd0;
        ret_coin_one     = 4'd0;
        
        // Calculate hundreds
        if (refund >= 100 && (mach_coin_hundred + used_coin_hundred) > 0) begin
            ret_coin_hundred = (refund / 100) > (mach_coin_hundred + used_coin_hundred) ? (mach_coin_hundred + used_coin_hundred) : (refund / 100);
            refund = refund - ret_coin_hundred * 100;
        end
        
        // Calculate tens
        if (refund >= 10 && (mach_coin_ten + used_coin_ten) > 0) begin
            ret_coin_ten = (refund / 10) > (mach_coin_ten + used_coin_ten) ? (mach_coin_ten + used_coin_ten) : (refund / 10);
            refund = refund - ret_coin_ten * 10;
        end
        
        // Calculate fives
        if (refund >= 5 && (mach_coin_five + used_coin_five) > 0) begin
            ret_coin_five = (refund / 5) > (mach_coin_five + used_coin_five) ? (mach_coin_five + used_coin_five) : (refund / 5);
            refund = refund - ret_coin_five * 5;
        end
        
        // Calculate ones
        if (refund >= 1 && (mach_coin_one + used_coin_one) > 0) begin
            ret_coin_one = (refund / 1) > (mach_coin_one + used_coin_one) ? (mach_coin_one + used_coin_one) : (refund / 1);
            refund = refund - ret_coin_one * 1;
        end
        
        // Check if refund was successfully calculated
        if (refund == 0) begin
            refund_valid <= 2'b10;
            // Update machine coins
            mach_coin_hundred <= mach_coin_hundred - ret_coin_hundred + used_coin_hundred;
            mach_coin_ten     <= mach_coin_ten - ret_coin_ten + used_coin_ten;
            mach_coin_five    <= mach_coin_five - ret_coin_five + used_coin_five;
            mach_coin_one     <= mach_coin_one - ret_coin_one + used_coin_one;
            coin_hundred      <= coin_hundred - used_coin_hundred + ret_coin_hundred;
            coin_ten          <= coin_ten - used_coin_ten + ret_coin_ten;
            coin_five         <= coin_five - used_coin_five + ret_coin_five;
            coin_one          <= coin_one - used_coin_one + ret_coin_one;
            calc_done <= 1'b1;
            water_num <= water_num - used_water_num;
            tea_num <= tea_num - used_tea_num;
            juice_num <= juice_num - used_juice_num;
            coke_num <= coke_num - used_coke_num;
        end else begin
            // Not enough coins to provide exact refund
            ret_coin_hundred = 4'd0;
            ret_coin_ten     = 4'd0;
            ret_coin_five    = 4'd0;
            ret_coin_one     = 4'd0;
            refund_valid     <= 2'b01;
            calc_done <= 1'b1;
        end
    end else begin
        // Not enough money inserted
        ret_coin_hundred = 4'd0;
        ret_coin_ten     = 4'd0;
        ret_coin_five    = 4'd0;
        ret_coin_one     = 4'd0;
        refund_valid     <= 2'b00;
        calc_done <= 1'b1;
    end
  end
end

// ------------------------------------------------------------------------
reg water_out, tea_out, juice_out, coke_out;
always @(posedge clk)begin
  if(~reset_n)begin
    water_out<=0;
    tea_out<=0;
    juice_out<=0;
    coke_out<=0;
  end
  else if(P == S_MAIN_INIT)begin
    water_out<=0;
    tea_out<=0;
    juice_out<=0;
    coke_out<=0;
  end
  else if(P == S_MAIN_BUY && P_next == S_MAIN_PAY)begin
    if(water_sold_out)
      water_out<=1;
    if(juice_sold_out)
      juice_out<=1;
    if(tea_sold_out)
      tea_out<=1;
    if(coke_sold_out)
      coke_out<=1;
  end

end
// ------------------------------------------------------------------------
// S_MAIN_DROP
reg [3:0] what_item_fall;
reg [3:0] remain_water_num, 
          remain_tea_num, 
          remain_juice_num, 
          remain_coke_num; 
          // how many item remain to fall
localparam [1:0] FALL_WATER = 2'd0,
                 FALL_TEA = 2'd1,
                 FALL_JUICE = 2'd2,
                 FALL_COKE = 2'd3;

// judge whether the item touched the bottom
always @(posedge clk) begin
  if(~reset_n) begin
    remain_water_num <= 0;
    remain_tea_num <= 0;
    remain_juice_num <= 0;
    remain_coke_num <= 0;
  end
  // set remain constant
  else if (P == S_MAIN_CALC && P_next == S_MAIN_DROP) begin
    remain_water_num <= used_water_num;
    remain_tea_num <= used_tea_num;
    remain_juice_num <= used_juice_num;
    remain_coke_num <= used_coke_num;
  end
  // remain constant minus
  else if (P == S_MAIN_DROP) begin
    if(drop_water_vpos > 160 || drop_tea_vpos > 160 || drop_juice_vpos > 160 || drop_coke_vpos > 160) begin
      case(what_item_fall)
      FALL_WATER: begin
        remain_water_num = remain_water_num - 1;
      end
      FALL_TEA: begin
        remain_tea_num = remain_tea_num - 1;
      end
      FALL_JUICE: begin
        remain_juice_num = remain_juice_num - 1;
      end
      FALL_COKE: begin
        remain_coke_num = remain_coke_num - 1;
      end
      endcase
    end
  end
end

// control what item to fall
// need modify: item image
always @(posedge clk) begin
  if(~reset_n) begin
    what_item_fall <= 0;
  end
  else if (P == S_MAIN_DROP) begin
    if (remain_water_num > 0) begin
      // use water image to fall
      what_item_fall <= FALL_WATER;
    end
    else if (remain_juice_num > 0) begin
      // use tea image to fall
      what_item_fall <= FALL_JUICE;
    end
    else if (remain_tea_num > 0) begin
      // use juice image to fall
      what_item_fall <= FALL_TEA;
    end
    else if (remain_coke_num > 0) begin
      // use coke image to fall
      what_item_fall <= FALL_COKE;
    end
  end
end

// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// S_MAIN_ERROR

// ------------------------------------------------------------------------

endmodule
