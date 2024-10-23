`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dept. of Computer Science, National Chiao Tung University
// Engineer: Chun-Jen Tsai
// 
// Create Date: 2018/11/01 11:16:50
// Design Name: 
// Module Name: lab6
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This is a sample circuit to show you how to initialize an SRAM
//              with a pre-defined data file. Hit BTN0/BTN1 let you browse
//              through the data.
// 
// Dependencies: LCD_module, debounce
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab6(
  // General system I/O ports
  input  clk,
  input  reset_n,
  input  [3:0] usr_btn,
  output [3:0] usr_led,

  // 1602 LCD Module Interface
  output LCD_RS,
  output LCD_RW,
  output LCD_E,
  output [3:0] LCD_D,
  
  input  uart_rx,
  output uart_tx
);

//localparam [1:0] S_MAIN_ADDR = 3'b000, S_MAIN_READ = 3'b001,
//                 S_MAIN_SHOW = 3'b010, S_MAIN_WAIT = 3'b011;

localparam [3:0] 
  S_MAIN_INIT         = 4'd0,
  S_MAIN_WAIT         = 4'd1,
  S_MAIN_SRAM_READ_A  = 4'd2,
  S_MAIN_SRAM_READ_B  = 4'd3,
  S_MAIN_POOL_A       = 4'd4,
  S_MAIN_POOL_B       = 4'd5,
  S_MAIN_MUL          = 4'd6,
  S_MAIN_CONVERT      = 4'd7,
  S_MAIN_REPLY        = 4'd8;
                 
localparam [1:0] 
  S_UART_IDLE   = 2'd0, 
  S_UART_WAIT   = 2'd1,
  S_UART_SEND   = 2'd2, 
  S_UART_INCR   = 2'd3;

localparam INIT_DELAY = 100_000; // 1 msec @ 100 MHz

localparam RESULT_LEN_FIRST = 34;
localparam RESULT_LEN = 33;
localparam RESULT_LEN_FINISH = 34;
localparam MEM_SIZE = RESULT_LEN_FIRST + 4 * RESULT_LEN + RESULT_LEN_FINISH;

// declare system variables
wire [1:0]  btn_level, btn_pressed;
reg  [1:0]  prev_btn_level;
reg  [11:0] user_addr;
reg  [7:0]  user_data;

wire print_enable, print_done;
reg [$clog2(MEM_SIZE):0] send_counter;

reg [3:0] P, P_next;
reg [1:0] Q, Q_next;
reg [$clog2(INIT_DELAY):0] init_counter;
reg [7:0] data[0:MEM_SIZE-1];

reg [0:(RESULT_LEN_FIRST*8)-1] msg_result1 = { "\015The matrix operation result is:\015\012" };
reg [0:(RESULT_LEN*8)-1] msg_result2 = { "[00000,00000,00000,00000,00000]\015\012" };
reg [0:(RESULT_LEN*8)-1] msg_result3 = { "[00000,00000,00000,00000,00000]\015\012" };
reg [0:(RESULT_LEN*8)-1] msg_result4 = { "[00000,00000,00000,00000,00000]\015\012" };
reg [0:(RESULT_LEN*8)-1] msg_result5 = { "[00000,00000,00000,00000,00000]\015\012" };
reg [0:(RESULT_LEN_FINISH*8)-1] msg_result6 = { "[00000,00000,00000,00000,00000]\015\012", 8'h00 };

//reg  [127:0] row_A, row_B;

// declare SRAM control signals
wire [10:0] sram_addr;
wire [7:0]  data_in;
wire [7:0]  data_out;
wire        sram_we, sram_en;

// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
reg  [7:0] rx_temp;  // if recevied is true, rx_temp latches rx_byte for ONLY ONE CLOCK CYCLE!
wire [7:0] tx_byte;
wire [7:0] echo_key; // keystrokes to be echoed to the terminal
wire is_num_key;
wire is_receiving;
wire is_transmitting;
wire recv_error;

assign usr_led = 4'h00;
reg sram_a_done, sram_b_done, pooling_a_done, pooling_b_done, mul_done, convert_done;
reg[5:0] mat_a_count;
reg[5:0] mat_b_count;
reg[8:0] mat_a[49:0];
reg[8:0] mat_b[49:0];
reg [8:0] mat_a_pooling [24:0];
reg [8:0] mat_b_pooling [24:0];
reg [19:0] mat_c [24:0];

//LCD_module lcd0( 
//  .clk(clk),
//  .reset(~reset_n),
//  .row_A(row_A),
//  .row_B(row_B),
//  .LCD_E(LCD_E),
//  .LCD_RS(LCD_RS),
//  .LCD_RW(LCD_RW),
//  .LCD_D(LCD_D)
//);
  
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

/* The UART device takes a 100MHz clock to handle I/O at 9600 baudrate */
uart uart(
  .clk(clk),
  .rst(~reset_n),
  .rx(uart_rx),
  .tx(uart_tx),
  .transmit(transmit),
  .tx_byte(tx_byte),
  .received(received),
  .rx_byte(rx_byte),
  .is_receiving(is_receiving),
  .is_transmitting(is_transmitting),
  .recv_error(recv_error)
);

//
// Enable one cycle of btn_pressed per each button hit
//
always @(posedge clk) begin
  if (~reset_n)
    prev_btn_level <= 2'b00;
  else
    prev_btn_level <= btn_level;
end

assign btn_pressed = (btn_level & ~prev_btn_level);

// Initializes some strings.
// System Verilog has an easier way to initialize an array,
// but we are using Verilog 2001 :(
//
integer idx, row;
reg[2:0] convert_x;
reg[2:0] convert_y;
reg[2:0] convert_cnt;
reg[19:0] convert_tmp;

always @(posedge clk) begin
  if (~reset_n) begin
    for (idx = 0; idx < RESULT_LEN_FIRST; idx = idx + 1) data[idx] <= msg_result1[idx*8 +: 8];
    for (idx = 0; idx < RESULT_LEN; idx = idx + 1) data[idx + RESULT_LEN_FIRST] <= msg_result2[idx*8 +: 8];
    for (idx = 0; idx < RESULT_LEN; idx = idx + 1) data[idx + RESULT_LEN_FIRST + RESULT_LEN] <= msg_result3[idx*8 +: 8];
    for (idx = 0; idx < RESULT_LEN; idx = idx + 1) data[idx + RESULT_LEN_FIRST + 2 * RESULT_LEN] <= msg_result4[idx*8 +: 8];
    for (idx = 0; idx < RESULT_LEN; idx = idx + 1) data[idx + RESULT_LEN_FIRST + 3 * RESULT_LEN] <= msg_result5[idx*8 +: 8];
    for (idx = 0; idx < RESULT_LEN_FINISH; idx = idx + 1) data[idx + RESULT_LEN_FIRST + 4 * RESULT_LEN] <= msg_result6[idx*8 +: 8];
    convert_x <= 0;
    convert_y <= 0;
    convert_done <= 0;
  end
  else if (P == S_MAIN_CONVERT && convert_y < 5) begin
    case (convert_cnt)
      0: data[RESULT_LEN_FIRST + RESULT_LEN * convert_y + 1 + convert_x * 6] <= 
           ((mat_c[5 * convert_y + convert_x][19:16] > 9) ? "7" : "0") + mat_c[5 * convert_y + convert_x][19:16];
      1: data[RESULT_LEN_FIRST + RESULT_LEN * convert_y + 2 + convert_x * 6] <= 
           ((mat_c[5 * convert_y + convert_x][15:12] > 9) ? "7" : "0") + mat_c[5 * convert_y + convert_x][15:12];
      2: data[RESULT_LEN_FIRST + RESULT_LEN * convert_y + 3 + convert_x * 6] <= 
           ((mat_c[5 * convert_y + convert_x][11:8] > 9) ? "7" : "0") + mat_c[5 * convert_y + convert_x][11:8];
      3: data[RESULT_LEN_FIRST + RESULT_LEN * convert_y + 4 + convert_x * 6] <= 
           ((mat_c[5 * convert_y + convert_x][7:4] > 9) ? "7" : "0") + mat_c[5 * convert_y + convert_x][7:4];
      4: data[RESULT_LEN_FIRST + RESULT_LEN * convert_y + 5 + convert_x * 6] <= 
           ((mat_c[5 * convert_y + convert_x][3:0] > 9) ? "7" : "0") + mat_c[5 * convert_y + convert_x][3:0];
      default: ;
    endcase
    
    convert_cnt <= convert_cnt + 1;
    
    if (convert_cnt == 4) begin
      convert_cnt  <= 0;
      convert_x    <= convert_x + 1;
      
      if (convert_x == 4) begin
        convert_x  <= 0;
        convert_y  <= convert_y + 1;
      end
    end
  end
  else if (P == S_MAIN_CONVERT && convert_y == 5) begin
    convert_done <= 1;
  end
end

// ------------------------------------------------------------------------
// The following code creates an initialized SRAM memory block that
// stores an 1024x8-bit unsigned numbers.
sram ram0(.clk(clk), .we(sram_we), .en(sram_en),
          .addr(sram_addr), .data_i(data_in), .data_o(data_out));

assign sram_we = usr_btn[3]; // In this demo, we do not write the SRAM. However,
                             // if you set 'we' to 0, Vivado fails to synthesize
                             // ram0 as a BRAM -- this is a bug in Vivado.
// assign sram_en = (P == S_MAIN_ADDR || P == S_MAIN_READ); // Enable the SRAM block.
assign sram_en = (P == S_MAIN_SRAM_READ_A || P == S_MAIN_SRAM_READ_B); // Enable the SRAM block.
assign sram_addr = user_addr[11:0];
assign data_in = 8'b0; // SRAM is read-only so we tie inputs to zeros.

// End of the SRAM memory block.
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM of the main controller
always @(posedge clk) begin
  if (~reset_n) begin
    // P <= S_MAIN_ADDR; // read samples at 000 first
    P <= S_MAIN_INIT;
  end
  else begin
    P <= P_next;
  end
end

always @(*) begin // FSM next-state logic
  case (P)
//    S_MAIN_ADDR: // send an address to the SRAM 
//      P_next = S_MAIN_READ;
//    S_MAIN_READ: // fetch the sample from the SRAM
//      P_next = S_MAIN_SHOW;
//    S_MAIN_SHOW:
//      P_next = S_MAIN_WAIT;
//    S_MAIN_WAIT: // wait for a button click
//      if (| btn_pressed == 1) P_next = S_MAIN_ADDR;
//      else P_next = S_MAIN_WAIT;
      S_MAIN_INIT:
        P_next = (init_counter < INIT_DELAY) ? S_MAIN_INIT : S_MAIN_WAIT;
      S_MAIN_WAIT:
        // P_next = S_MAIN_POOL_A;
        P_next = (btn_pressed[1]) ? S_MAIN_SRAM_READ_A : S_MAIN_WAIT;
      S_MAIN_SRAM_READ_A:
        P_next = (sram_a_done) ? S_MAIN_SRAM_READ_B : S_MAIN_SRAM_READ_A;
      S_MAIN_SRAM_READ_B:
        P_next = (sram_b_done) ? S_MAIN_POOL_A : S_MAIN_SRAM_READ_B;
      S_MAIN_POOL_A:
        P_next = (pooling_a_done) ? S_MAIN_POOL_B : S_MAIN_POOL_A;
      S_MAIN_POOL_B:
        P_next = (pooling_b_done) ? S_MAIN_MUL : S_MAIN_POOL_B;
      S_MAIN_MUL:
        P_next = (mul_done) ? S_MAIN_CONVERT : S_MAIN_MUL;
      S_MAIN_CONVERT:
        P_next = (convert_done) ? S_MAIN_REPLY : S_MAIN_CONVERT;
        // P_next = S_MAIN_REPLY;
      S_MAIN_REPLY:
        P_next = (print_done) ? S_MAIN_INIT : S_MAIN_REPLY;
      default:
        P_next = S_MAIN_INIT;
  endcase
end

// FSM ouput logic: Fetch the data bus of sram[] for display
always @(posedge clk) begin
  if (~reset_n) begin
    user_data <= 8'b0;
  end
  else if (sram_en && !sram_we) user_data <= data_out;
end
// End of the main controller
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// The following code updates the 1602 LCD text messages.
// always @(posedge clk) begin
//   if (~reset_n) begin
//     row_A <= "Data at [0x---] ";
//   end
//   else if (P == S_MAIN_SHOW) begin
//     row_A[39:32] <= ((user_addr[11:08] > 9)? "7" : "0") + user_addr[11:08];
//     row_A[31:24] <= ((user_addr[07:04] > 9)? "7" : "0") + user_addr[07:04];
//     row_A[23:16] <= ((user_addr[03:00] > 9)? "7" : "0") + user_addr[03:00];
//   end
// end

// always @(posedge clk) begin
//   if (~reset_n) begin
//     row_B <= "is equal to 0x--";
//   end
//   else if (P == S_MAIN_SHOW) begin
//     row_B[15:08] <= ((user_data[7:4] > 9)? "7" : "0") + user_data[7:4];
//     row_B[07: 0] <= ((user_data[3:0] > 9)? "7" : "0") + user_data[3:0];
//   end
// end
// End of the 1602 LCD text-updating code.
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// The circuit block that processes the user's button event.
// always @(posedge clk) begin
//   if (~reset_n)
//     user_addr <= 12'h000;
//   else if (btn_pressed[1])
//     user_addr <= (user_addr < 2048)? user_addr + 1 : user_addr;
//   else if (btn_pressed[0])
//     user_addr <= (user_addr > 0)? user_addr - 1 : user_addr;
// end
// End of the user's button control.
// ------------------------------------------------------------------------

integer sram_flg;
integer sram_col, sram_row, sram_index;

// ------------------------------------------------------------------------
// The circuit block that processes the SRAM input.
always @(posedge clk) begin
  if (~reset_n) begin
    sram_a_done <= 0;
    sram_b_done <= 0;
    sram_flg <= 0;
    user_addr <= 12'h000;
    mat_a_count <= 6'h00;
    mat_b_count <= 6'h00;
  end
  else begin
    // col-major
    if (P == S_MAIN_SRAM_READ_A) begin
      if (!sram_a_done && !sram_flg && mat_a_count < 49) begin
        user_addr <= user_addr + 1;
        sram_flg <= 1;
      end
      else if (mat_a_count < 49) begin
        sram_col   = mat_a_count / 7;
        sram_row   = mat_a_count % 7;
        sram_index = sram_row * 7 + sram_col;
        mat_a[sram_index] <= data_out;
        mat_a_count <= mat_a_count + 1;
        sram_flg <= 0;
      end
      else if (mat_a_count == 49) begin
        sram_a_done <= 1;
      end
    end
    // else if (P == S_MAIN_SRAM_READ_B) begin
    //   if (!sram_b_done && !sram_flg && mat_b_count < 49) begin
    //     user_addr <= user_addr + 1;
    //     sram_flg <= 1;
    //   end
    //   else if (mat_b_count < 49) begin
    //     sram_col   = mat_b_count / 7;
    //     sram_row   = mat_b_count % 7;
    //     sram_index = sram_row * 7 + sram_col;
    //     mat_b[sram_index] <= data_out;
    //     mat_b_count <= mat_b_count + 1;
    //     sram_flg <= 0;
    //   end
    //   else if (mat_b_count == 49) begin
    //     sram_b_done <= 1;
    //   end
    // end

    // row-major
    // if (P == S_MAIN_SRAM_READ_A) begin
    //   if (!sram_a_done && !sram_flg && mat_a_count < 49) begin
    //     user_addr <= user_addr + 1;
    //     sram_flg <= 1;
    //   end
    //   else if (mat_a_count < 49) begin
    //     mat_a[mat_a_count] <= data_out;
    //     mat_a_count <= mat_a_count + 1;
    //     sram_flg <= 0;
    //   end
    //   else if (mat_a_count == 49) begin
    //     sram_a_done <= 1;
    //   end
    // end
    else if (P == S_MAIN_SRAM_READ_B) begin
      if (!sram_b_done && !sram_flg && mat_b_count < 49) begin
        user_addr <= user_addr + 1;
        sram_flg <= 1;
      end
      else if (mat_b_count < 49) begin
        mat_b[mat_b_count] <= data_out;
        mat_b_count <= mat_b_count + 1;
        sram_flg <= 0;
      end
      else if (mat_b_count == 49) begin
        sram_b_done <= 1;
      end
    end
  end
end
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM output logics: print string control signals.
assign print_enable = ((P != P_next) && (P_next == S_MAIN_REPLY));
assign print_done = (tx_byte == 8'h0);

// Initialization counter.
always @(posedge clk) begin
  if (P == S_MAIN_INIT) init_counter <= init_counter + 1;
  else init_counter <= 0;
end
// End of the FSM of the print string controller
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM of the controller that sends a string to the UART.
always @(posedge clk) begin
  if (~reset_n) Q <= S_UART_IDLE;
  else Q <= Q_next;
end

always @(*) begin // FSM next-state logic
  case (Q)
    S_UART_IDLE: // wait for the print_string flag
      if (print_enable) Q_next = S_UART_WAIT;
      else Q_next = S_UART_IDLE;
    S_UART_WAIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_UART_SEND;
      else Q_next = S_UART_WAIT;
    S_UART_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_UART_INCR; // transmit next character
      else Q_next = S_UART_SEND;
    S_UART_INCR:
      if (tx_byte == 8'h0) Q_next = S_UART_IDLE; // string transmission ends
      else Q_next = S_UART_WAIT;
  endcase
end

// FSM output logics: UART transmission control signals
//assign transmit = (Q_next == S_UART_WAIT ||
//                  (P == S_MAIN_READ_NUM && received) ||
//                   print_enable);
//assign is_num_key = (rx_byte > 8'h2F) && (rx_byte < 8'h3A) && (key_cnt < 5);
//assign echo_key = (is_num_key || rx_byte == 8'h0D)? rx_byte : 0;
//assign tx_byte  = ((P == S_MAIN_READ_NUM) && received)? echo_key : data[send_counter];

assign transmit = (Q_next == S_UART_WAIT || print_enable);
assign is_num_key = (rx_byte >= "0") && (rx_byte <= "9");
// assign echo_key = (is_num_key || rx_byte == 8'h0D) ? rx_byte : 0;
assign tx_byte = data[send_counter];
// assign tx_byte = ((Q != S_UART_IDLE) ? data[send_counter] :
//                   ((P == S_MAIN_READ_DIVIDEND || P == S_MAIN_READ_DIVISOR) && received) ? echo_key : 8'h00);

// UART send_counter control circuit
always @(posedge clk) begin
//  case (P_next)
//    S_MAIN_INIT: send_counter <= PROMPT_STR;
//    S_MAIN_READ_NUM: send_counter <= REPLY_STR;
//    default: send_counter <= send_counter + (Q_next == S_UART_INCR);
//  endcase
  if (print_enable) begin
    case (P_next)
      // S_MAIN_PROMPT_DIVIDEND:
      //   send_counter <= 0;
      // S_MAIN_PROMPT_DIVISOR:
      //   send_counter <= PROMPT_LEN_DIVIDEND;
      // S_MAIN_REPLY:
      //   if (divide_zero_flag)
      //     send_counter <= PROMPT_LEN_DIVIDEND + PROMPT_LEN_DIVISOR + REPLY_LEN_RESULT;
      //   else
      //     send_counter <= PROMPT_LEN_DIVIDEND + PROMPT_LEN_DIVISOR;
      S_MAIN_REPLY:
        send_counter <= 0;
      default:
        send_counter <= send_counter;
    endcase
  end 
  else if (Q_next == S_UART_INCR) begin
    send_counter <= send_counter + 1;
  end
end
// End of the FSM of the print string controller
// ------------------------------------------------------------------------

wire [8:0] current_max_a;
wire [8:0] current_max_b;
reg [5:0] pool_index;
reg [6:0] pool_cnt;
reg [3:0] compare_cnt_a, compare_cnt_b;

max_finder_9 max_finder_a (
  .clk(clk),
  .reset_n(reset_n),
  .cnt(compare_cnt_a),
  .in0(mat_a[pool_index + 0]),
  .in1(mat_a[pool_index + 1]),
  .in2(mat_a[pool_index + 2]),
  .in3(mat_a[pool_index + 7]),
  .in4(mat_a[pool_index + 8]),
  .in5(mat_a[pool_index + 9]),
  .in6(mat_a[pool_index + 14]),
  .in7(mat_a[pool_index + 15]),
  .in8(mat_a[pool_index + 16]),
  .max_out(current_max_a)
);

max_finder_9 max_finder_b (
  .clk(clk),
  .reset_n(reset_n),
  .cnt(compare_cnt_b),
  .in0(mat_b[pool_index + 0]),
  .in1(mat_b[pool_index + 1]),
  .in2(mat_b[pool_index + 2]),
  .in3(mat_b[pool_index + 7]),
  .in4(mat_b[pool_index + 8]),
  .in5(mat_b[pool_index + 9]),
  .in6(mat_b[pool_index + 14]),
  .in7(mat_b[pool_index + 15]),
  .in8(mat_b[pool_index + 16]),
  .max_out(current_max_b)
);

always @(posedge clk or negedge reset_n) begin
  if (!reset_n) begin
    pool_index       <= 0;
    pooling_a_done   <= 0;
    pooling_b_done   <= 0;
    pool_cnt        <= 0;
    compare_cnt_a    <= 0;
    compare_cnt_b    <= 0;
  end
  else begin
    if (P == S_MAIN_POOL_A) begin
      if (pool_cnt < 25) begin
        if (compare_cnt_a == 4'd9) begin
          mat_a_pooling[pool_cnt] <= current_max_a;
          pool_cnt <= pool_cnt + 1;
          compare_cnt_a <= 0;
          
          if (pool_index % 7 == 4) begin
              pool_index <= pool_index + 3;
          end
          else begin
              pool_index <= pool_index + 1;
          end
        end
        else begin
          compare_cnt_a <= compare_cnt_a + 1;
        end
      end
      else begin
          pooling_a_done <= 1;
          pool_index <= 0;
          pool_cnt <= 0;
      end
    end
    else if (P == S_MAIN_POOL_B) begin
      if (pool_cnt < 25) begin
        if (compare_cnt_b == 4'd9) begin
          mat_b_pooling[pool_cnt] <= current_max_b;
          pool_cnt <= pool_cnt + 1;
          compare_cnt_b <= 0;
          
          if (pool_index % 7 == 4) begin
            pool_index <= pool_index + 3;
          end
          else begin
            pool_index <= pool_index + 1;
          end
        end
        else begin
          compare_cnt_b <= compare_cnt_b + 1;
        end
      end
      else begin
        pooling_b_done <= 1;
        pool_index <= 0;
        pool_cnt <= 0;
      end
    end
    else begin
      pool_cnt      <= 0;
      compare_cnt_a <= 0;
      compare_cnt_b <= 0;
      pool_index    <= 0;
    end
  end
end

reg [2:0] mul_cnt;
reg [2:0] mul_a;
reg [2:0] mul_b;
reg flg_cnt;
reg [17:0] tmp_cnt;

integer idx_cnt;

always @(posedge clk) begin
  if (!reset_n) begin
    for (idx_cnt = 0; idx_cnt < 25; idx_cnt = idx_cnt + 1) begin
        mat_c[idx_cnt] <= 20'd0;
    end
    mul_cnt <= 0;
    mul_a   <= 0;
    mul_b   <= 0;
    flg_cnt <= 0;
    mul_done <= 0;
  end
  else begin
    if (P == S_MAIN_MUL) begin
      if (mul_cnt < 5) begin
        if (!flg_cnt) begin
            tmp_cnt <= mat_a_pooling[mul_cnt * 5 + mul_b] * mat_b_pooling[mul_b * 5 + mul_a];
            flg_cnt <= 1;
        end
        else begin
          mat_c[mul_cnt * 5 + mul_a] <= mat_c[mul_cnt * 5 + mul_a] + tmp_cnt;
          flg_cnt <= 0;
          
          if (mul_b == 4) begin
            mul_b <= 0;
            if (mul_a == 4) begin
                mul_a <= 0;
                mul_cnt <= mul_cnt + 1;
            end
            else begin
                mul_a <= mul_a + 1;
            end
          end
          else begin
            mul_b <= mul_b + 1;
          end
        end
      end
      else if (mul_cnt == 5) begin
        mul_done <= 1;
        mul_cnt <= 0;
        mul_a   <= 0;
        mul_b   <= 0;
      end
      // for (idx_cnt = 0; idx_cnt < 25; idx_cnt = idx_cnt + 1) begin
      //   mat_c[idx_cnt] <= mat_a_pooling[idx_cnt];
      // end
      // mul_done <= 1;
    end
  end
end

endmodule

module max_finder_9 (
  input clk,
  input reset_n,
  input [3:0] cnt,
  input [8:0] in0,
  input [8:0] in1,
  input [8:0] in2,
  input [8:0] in3,
  input [8:0] in4,
  input [8:0] in5,
  input [8:0] in6,
  input [8:0] in7,
  input [8:0] in8,
  output reg [8:0] max_out
);

always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
    max_out <= 9'd0;
  end 
  else begin
    if (cnt == 4'd0) max_out <= in0;
    if (in0 > max_out) max_out <= in0;
    if (in1 > max_out) max_out <= in1;
    if (in2 > max_out) max_out <= in2;
    if (in3 > max_out) max_out <= in3;
    if (in4 > max_out) max_out <= in4;
    if (in5 > max_out) max_out <= in5;
    if (in6 > max_out) max_out <= in6;
    if (in7 > max_out) max_out <= in7;
    if (in8 > max_out) max_out <= in8;
  end
end

// matrices.mem Testcase 1

endmodule
