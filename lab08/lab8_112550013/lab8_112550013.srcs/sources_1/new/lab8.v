`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dept. of Computer Science, National Chiao Tung University
// Engineer: Chun-Jen Tsai
// 
// Create Date: 2017/05/08 15:29:41
// Design Name: 
// Module Name: lab6
// Project Name: 
// Target Devices: 
// Tool Versions:
// Description: The sample top module of lab 6: sd card reader. The behavior of
//              this module is as follows
//              1. When the SD card is initialized, display a message on the LCD.
//                 If the initialization fails, an error message will be shown.
//              2. The user can then press usr_btn[2] to trigger the sd card
//                 controller to read the super block of the sd card (located at
//                 block # 8192) into the SRAM memory.
//              3. During SD card reading time, the four LED lights will be turned on.
//                 They will be turned off when the reading is done.
//              4. The LCD will then displayer the sector just been read, and the
//                 first byte of the sector.
//              5. Everytime you press usr_btn[2], the next byte will be displayed.
// 
// Dependencies: clk_divider, LCD_module, debounce, sd_card
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab8(
  // General system I/O ports
  input  clk,
  input  reset_n,
  input  [3:0] usr_btn,
  output [3:0] usr_led,

  // SD card specific I/O ports
  output spi_ss,
  output spi_sck,
  output spi_mosi,
  input  spi_miso,

  // 1602 LCD Module Interface
  output LCD_RS,
  output LCD_RW,
  output LCD_E,
  output [3:0] LCD_D,
  
  // tri-state LED
  output [3:0] rgb_led_r,
  output [3:0] rgb_led_g,
  output [3:0] rgb_led_b
);

localparam [2:0] S_MAIN_INIT = 3'b000,
                 S_MAIN_IDLE = 3'b001,
                 S_MAIN_WAIT = 3'b010,
                 S_MAIN_READ_BLOCK = 3'b011,
                 S_MAIN_PROCESS_BLOCK = 3'b100,
                 S_MAIN_DISPLAY = 3'b101,
                 S_MAIN_SHOW_STATS = 3'b110;

localparam START_LEN = 9;
localparam END_LEN = 7;

// Declare system variables
wire btn_level, btn_pressed;
reg  prev_btn_level;
// reg  [5:0] send_counter;
reg  [2:0] P, P_next;
reg  [9:0] sd_counter;
// reg  [7:0] data_byte;
reg  [31:0] blk_addr;
reg  [31:0] max_blk_addr;

reg  [127:0] row_A = "SD card cannot  ";
reg  [127:0] row_B = "be initialized! ";
// reg  done_flag; // Signals the completion of reading one SD sector.

// Declare SD card interface signals
wire clk_sel;
wire clk_500k;
reg  rd_req;
reg  [31:0] rd_addr;
wire init_finished;
wire [7:0] sd_dout;
wire sd_valid;

// Declare the control/data signals of an SRAM memory block
wire [7:0] data_in;
wire [7:0] data_out;
// wire [8:0] sram_addr;
reg [8:0]  sram_addr;
wire       sram_we, sram_en;

assign clk_sel = (init_finished)? clk : clk_500k; // clock for the SD controller
// assign usr_led = 4'h00;
assign usr_led = P;

reg  found_start, found_end;
reg [3:0] start_match_index, end_match_index;
reg [7:0] DCL_START [0:START_LEN-1];
reg [7:0] DCL_END [0:END_LEN-1];
reg [9:0] process_counter;


reg [7:0] count_R, count_G, count_B, count_Y, count_P, count_X, count_invalid;

// Shift register for LEDs
reg [7:0] shift_reg [0:3];

// PWM variables
reg [4:0] pwm_counter;

// RGB LED outputs after PWM
wire [3:0] rgb_led_r_out;
wire [3:0] rgb_led_g_out;
wire [3:0] rgb_led_b_out;

// Assign PWM outputs
assign rgb_led_r = rgb_led_r_out;
assign rgb_led_g = rgb_led_g_out;
assign rgb_led_b = rgb_led_b_out;

reg [7:0] char_buffer [0:511];
reg [8:0] char_index = 0;

reg [8:0] display_ptr = 0;
localparam WINDOW_SIZE = 4;

reg [28:0] counter_2s = 0;
reg clk_2s = 0;

clk_divider#(200) clk_divider0(
  .clk(clk),
  .reset(~reset_n),
  .clk_out(clk_500k)
);

debounce btn_db0(
  .clk(clk),
  .btn_input(usr_btn[2]),
  .btn_output(btn_level)
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

sd_card sd_card0(
  .cs(spi_ss),
  .sclk(spi_sck),
  .mosi(spi_mosi),
  .miso(spi_miso),

  .clk(clk_sel),
  .rst(~reset_n),
  .rd_req(rd_req),
  .block_addr(rd_addr),
  .init_finished(init_finished),
  .dout(sd_dout),
  .sd_valid(sd_valid)
);

sram ram0(
  .clk(clk),
  .we(sram_we),
  .en(sram_en),
  .addr(sram_addr),
  .data_i(data_in),
  .data_o(data_out)
);

always @(posedge clk) begin
    if (~reset_n)
        prev_btn_level <= 0;
    else
        prev_btn_level <= btn_level;
end

assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;

// ------------------------------------------------------------------------
// The following code sets the control signals of an SRAM memory block
// that is connected to the data output port of the SD controller.
// Once the read request is made to the SD controller, 512 bytes of data
// will be sequentially read into the SRAM memory block, one byte per
// clock cycle (as long as the sd_valid signal is high).
assign sram_we = sd_valid;          // Write data into SRAM when sd_valid is high.
assign sram_en = 1;                 // Always enable the SRAM block.
assign data_in = sd_dout;           // Input data always comes from the SD controller.
// assign sram_addr = sd_counter[8:0]; // Set the driver of the SRAM address signal.
// End of the SRAM memory block
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM of the SD card reader
always @(posedge clk) begin
    if (~reset_n) begin
        P <= S_MAIN_INIT;
    end
    else begin
        P <= P_next;
    end
end

// FSM next-state logic
always @(*) begin
    case (P)
        S_MAIN_INIT:
            if (init_finished) P_next = S_MAIN_IDLE;
            else P_next = S_MAIN_INIT;
        S_MAIN_IDLE:
            if (btn_pressed) P_next = S_MAIN_WAIT;
            else P_next = S_MAIN_IDLE;
        S_MAIN_WAIT:
            P_next = S_MAIN_READ_BLOCK;
        S_MAIN_READ_BLOCK:
            if (sd_counter == 512) P_next = S_MAIN_PROCESS_BLOCK;
            else P_next = S_MAIN_READ_BLOCK;
        S_MAIN_PROCESS_BLOCK:
            if (process_counter == 512) begin
                if (found_end) P_next = S_MAIN_DISPLAY;
                else if (blk_addr < max_blk_addr) P_next = S_MAIN_WAIT;
                else P_next = S_MAIN_SHOW_STATS;
            end else P_next = S_MAIN_PROCESS_BLOCK;
        S_MAIN_DISPLAY:
            if (display_ptr >= char_index && clk_2s) P_next = S_MAIN_SHOW_STATS;
            else P_next = S_MAIN_DISPLAY;
        S_MAIN_SHOW_STATS:
            P_next = S_MAIN_SHOW_STATS;
        default:
            P_next = S_MAIN_IDLE;
    endcase
end

// FSM output logic: controls the 'rd_req' and 'rd_addr' signals.
always @(*) begin
    rd_req = (P == S_MAIN_WAIT);
    rd_addr = blk_addr;
end

// always @(posedge clk) begin
//   if (~reset_n) blk_addr <= 32'h2000;
//   else blk_addr <= blk_addr; // In lab 6, change this line to scan all blocks
// end

// Control blk_addr
always @(posedge clk) begin
    if (~reset_n)
        blk_addr <= 32'h4000;
    else if (P == S_MAIN_PROCESS_BLOCK && P_next == S_MAIN_WAIT && found_end == 0)
        blk_addr <= blk_addr + 1;
    else
        blk_addr <= blk_addr;
end

always @(posedge clk) begin
    if (~reset_n)
        max_blk_addr <= 32'hFFFF;
    else
        max_blk_addr <= max_blk_addr;
end

// FSM output logic: controls the 'sd_counter' signal.
// SD card read address incrementer
// always @(posedge clk) begin
//   if (~reset_n || (P == S_MAIN_READ && P_next == S_MAIN_DONE))
//     sd_counter <= 0;
//   else if ((P == S_MAIN_READ && sd_valid) ||
//            (P == S_MAIN_DONE && P_next == S_MAIN_SHOW))
//     sd_counter <= sd_counter + 1;
// end

always @(posedge clk) begin
    if (~reset_n || (P != S_MAIN_READ_BLOCK))
        sd_counter <= 0;
    else if (sd_valid)
        sd_counter <= sd_counter + 1;
end

always @(posedge clk) begin
    if (P == S_MAIN_READ_BLOCK)
        sram_addr <= sd_counter[8:0];
    else if (P == S_MAIN_PROCESS_BLOCK)
        sram_addr <= process_counter[8:0];
    else
        sram_addr <= 0;
end

// End of the FSM of the SD card reader
// ------------------------------------------------------------------------

// Initialize DCL_START and DCL_END
integer i;
always @(posedge clk) begin
    if (~reset_n) begin
        DCL_START[0] <= "D";
        DCL_START[1] <= "C";
        DCL_START[2] <= "L";
        DCL_START[3] <= "_";
        DCL_START[4] <= "S";
        DCL_START[5] <= "T";
        DCL_START[6] <= "A";
        DCL_START[7] <= "R";
        DCL_START[8] <= "T";
        DCL_END[0] <= "D";
        DCL_END[1] <= "C";
        DCL_END[2] <= "L";
        DCL_END[3] <= "_";
        DCL_END[4] <= "E";
        DCL_END[5] <= "N";
        DCL_END[6] <= "D";
    end
end

integer flg;

// FSM output logic: process data from SRAM
always @(posedge clk) begin
  if (!reset_n) begin
        found_start <= 0;
        found_end <= 0;
        start_match_index <= 0;
        end_match_index <= 0;
        count_R <= 0;
        count_G <= 0;
        count_B <= 0;
        count_Y <= 0;
        count_P <= 0;
        count_X <= 0;
        count_invalid <= 0;
        char_index <= 0;
        for (i = 0; i < 512; i = i + 1)
            char_buffer[i] <= 8'd0;
    end else if (P == S_MAIN_READ_BLOCK && P_next == S_MAIN_PROCESS_BLOCK) begin
        process_counter <= 0;
        flg <= 1;
        // start_match_index <= 0;
        // end_match_index <= 0;
        // found_start <= 0;
        // found_end <= 0;
    end else if (P == S_MAIN_PROCESS_BLOCK) begin
        if (flg) begin
            process_counter <= process_counter + 1;
            flg <= 0;
        end
        else begin
            flg <= 1;
            if (!found_start) begin
                if (data_out == DCL_START[start_match_index]) begin
                    start_match_index <= start_match_index + 1;
                    if (start_match_index == START_LEN - 1) begin
                        found_start <= 1;
                        start_match_index <= 0;
                    end
                end else begin
                    start_match_index <= 0;
                end
            end else if (!found_end) begin
                if (data_out == DCL_END[end_match_index]) begin
                    end_match_index <= end_match_index + 1;
                    if (end_match_index == END_LEN - 1) begin
                        found_end <= 1;
                        end_match_index <= 0;
                    end
                end else begin
                    end_match_index <= 0;
                    if (char_index < 512) begin
                        char_buffer[char_index] <= data_out;
                        char_index <= char_index + 1;
                    end
                    case (data_out)
                        "R", "r": count_R <= count_R + 1;
                        "G", "g": count_G <= count_G + 1;
                        "B", "b": count_B <= count_B + 1;
                        "Y", "y": count_Y <= count_Y + 1;
                        "P", "p": count_P <= count_P + 1;
                        "X", "x": count_X <= count_X + 1;
                        default: count_invalid <= count_invalid + 1;
                    endcase
                end
            end
        end
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter_2s <= 0;
        clk_2s <= 0;
    end else if (P == S_MAIN_DISPLAY) begin
        if (counter_2s == 200_000_000) begin
            counter_2s <= 0;
            clk_2s <= 1;
        end else begin
            counter_2s <= counter_2s + 1;
            clk_2s <= 0;
        end
    end else begin
        counter_2s <= 0;
        clk_2s <= 0;
    end
end

integer initialized;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        display_ptr <= 0;
        initialized <= 0;
        for (i = 0; i < WINDOW_SIZE; i = i + 1) begin
            shift_reg[i] <= 8'd0;
        end
    end else if (P == S_MAIN_DISPLAY && clk_2s) begin
        if (!initialized) begin
            shift_reg[3] <= char_buffer[0];
            shift_reg[2] <= char_buffer[1];
            shift_reg[1] <= char_buffer[2];
            shift_reg[0] <= char_buffer[3];
            display_ptr <= 4;
            initialized <= 1;
        end else if (display_ptr < char_index) begin
            shift_reg[3] <= shift_reg[2];
            shift_reg[2] <= shift_reg[1];
            shift_reg[1] <= shift_reg[0];
            shift_reg[0] <= char_buffer[display_ptr];
            display_ptr <= display_ptr + 1;
        end
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        pwm_counter <= 0;
    else
        pwm_counter <= (pwm_counter == 19) ? 0 : pwm_counter + 1;
end

generate
    genvar idx;
    for (idx = 0; idx < 4; idx = idx + 1) begin : LED_CONTROL
        reg r, g, b;
        always @(*) begin
            case (shift_reg[idx])
                "R", "r": begin
                    r = 1;
                    g = 0;
                    b = 0;
                end
                "G", "g": begin
                    r = 0;
                    g = 1;
                    b = 0;
                end
                "B", "b": begin
                    r = 0;
                    g = 0;
                    b = 1;
                end
                "Y", "y": begin
                    r = 1;
                    g = 1;
                    b = 0;
                end
                "P", "p": begin
                    r = 1;
                    g = 0;
                    b = 1;
                end
                "X", "x": begin
                    r = 1;
                    g = 1;
                    b = 1;
                end
                default: begin
                    r = 0;
                    g = 0;
                    b = 0;
                end
            endcase
        end
        assign rgb_led_r_out[idx] = r & (pwm_counter < 1);
        assign rgb_led_g_out[idx] = g & (pwm_counter < 1);
        assign rgb_led_b_out[idx] = b & (pwm_counter < 1);
    end
endgenerate

// ------------------------------------------------------------------------
// LCD Display function.
always @(posedge clk) begin
    if (~reset_n) begin
        row_A <= "SD card cannot  ";
        row_B <= "be initialized! ";
    end else if (P == S_MAIN_PROCESS_BLOCK) begin
        row_A <= "Finding...      ";
        row_B <= "                ";
    end else if (P == S_MAIN_DISPLAY) begin
        row_A <= "Calculating...  ";
        if (initialized) begin
            row_B <= { ((shift_reg[3][7:4] > 9)? "7" : "0") + shift_reg[3][7:4],
                    ((shift_reg[3][3:0] > 9)? "7" : "0") + shift_reg[3][3:0],
                    " ",
                    ((shift_reg[2][7:4] > 9)? "7" : "0") + shift_reg[2][7:4],
                    ((shift_reg[2][3:0] > 9)? "7" : "0") + shift_reg[2][3:0],
                    " ",
                    ((shift_reg[1][7:4] > 9)? "7" : "0") + shift_reg[1][7:4],
                    ((shift_reg[1][3:0] > 9)? "7" : "0") + shift_reg[1][3:0],
                    " ",
                    ((shift_reg[0][7:4] > 9)? "7" : "0") + shift_reg[0][7:4],
                    ((shift_reg[0][3:0] > 9)? "7" : "0") + shift_reg[0][3:0],
                    "     " };
        end else begin
            row_B <= "                ";
        end
    end else if (P == S_MAIN_SHOW_STATS) begin
        row_A <= "RGBPYX          ";
        row_B <= { int_to_ascii(count_R),
                int_to_ascii(count_G),
                int_to_ascii(count_B),
                int_to_ascii(count_P),
                int_to_ascii(count_Y),
                int_to_ascii(count_invalid), "          " };
    end else if (P == S_MAIN_IDLE) begin
        row_A <= "Hit BTN2 to read";
        row_B <= "the SD card ... ";
    end
end

function [7:0] int_to_ascii;
    input [7:0] value;
    begin
        int_to_ascii = value + "0";
    end
endfunction
// End of the LCD display function
// ------------------------------------------------------------------------

endmodule
