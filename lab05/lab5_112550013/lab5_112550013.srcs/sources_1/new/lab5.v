`timescale 1ns / 1ps
/////////////////////////////////////////////////////////
module lab5(
  input clk,
  input reset_n,
  input [3:0] usr_btn,      // button 
  input [3:0] usr_sw,       // switches
  output [3:0] usr_led,     // led
  output LCD_RS,
  output LCD_RW,
  output LCD_E,
  output [3:0] LCD_D
);

assign usr_led = 4'b0000; // turn off led

//reg [127:0] row_A = "Press BTN3 to   "; // Initialize the text of the first row. 
//reg [127:0] row_B = "show a message.."; // Initialize the text of the second row.

reg [127:0] row_A;
reg [127:0] row_B;

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
    
//always @(posedge clk) begin
//  if (~reset_n) begin
    // Initialize the text when the user hit the reset button
//    row_A = "Press BTN3 to   ";
//    row_B = "show a message..";
//  end else if (usr_btn[3]) begin
//    row_A <= "Hello, World!   ";
//    row_B <= "Demo of the LCD.";
//  end
//end

reg [26:0] counter_1s = 0;
reg clk_1s = 0;

always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        counter_1s <= 0;
        clk_1s <= 0;
    end 
    else if (counter_1s == 50_000_000 - 1) begin
        counter_1s <= 0;
        clk_1s <= ~clk_1s;
    end 
    else begin
        counter_1s <= counter_1s + 1;
    end
end

reg [27:0] counter_2s = 0;
reg clk_2s = 0;

always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        counter_2s <= 0;
        clk_2s <= 0;
    end 
    else if(counter_2s == 100_000_000 - 1) begin
        counter_2s <= 0;
        clk_2s <= ~clk_2s;
    end 
    else begin
        counter_2s <= counter_2s + 1;
    end
end

wire game_start = (usr_sw[0] == 0); 
wire col1_enable = game_start && (usr_sw[3] == 1); 
wire col2_enable = game_start && (usr_sw[2] == 1); 
wire col3_enable = game_start && (usr_sw[1] == 1);

reg [3:0] col1_curr = 1;
reg [3:0] col1_next = 2;

always @(posedge clk_1s, negedge reset_n) begin
    if(!reset_n) begin
        col1_curr <= 1;
        col1_next <= 2;
    end 
    else if(col1_enable) begin
        col1_curr <= col1_next;
        col1_next <= (col1_next == 9) ? 1 : col1_next + 1;
    end
end

reg [3:0] col2_curr = 9;
reg [3:0] col2_next = 8;

always @(posedge clk_2s, negedge reset_n) begin
    if (!reset_n) begin
        col2_curr <= 9;
        col2_next <= 8;
    end 
    else if(col2_enable) begin
        col2_curr <= col2_next;
        col2_next <= (col2_next == 1) ? 9 : col2_next - 1;
    end
end

reg [3:0] col3_sequence [0:8];
initial begin
    col3_sequence[0] = 5;
    col3_sequence[1] = 3;
    col3_sequence[2] = 7;
    col3_sequence[3] = 1;
    col3_sequence[4] = 9;
    col3_sequence[5] = 2;
    col3_sequence[6] = 8;
    col3_sequence[7] = 4;
    col3_sequence[8] = 6;
end

reg [3:0] col3_index = 0;
reg [3:0] col3_curr;
reg [3:0] col3_next;

always @(posedge clk_1s, negedge reset_n) begin
    if(!reset_n) begin
        col3_index <= 0;
        col3_curr <= col3_sequence[0];
        col3_next <= col3_sequence[1];
    end 
    else if(col3_enable) begin
        col3_curr = col3_next;
        col3_index = (col3_index == 8) ? 0 : col3_index + 1;
        col3_next = col3_sequence[(col3_index + 1) % 9];
    end
end

function [7:0] num_to_ascii;
    input [3:0] num;
    begin
        num_to_ascii = num + 8'd48; // ASCII '0' is 48
    end
endfunction

wire all_switches_down = (usr_sw == 4'b0000);
reg game_over = 0;
reg [127:0] outcome_message;

always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        game_over <= 0;
        outcome_message <= "                ";
    end 
    else if (all_switches_down && !game_over) begin
        game_over <= 1;
        if ((col1_curr == col2_curr) && (col2_curr == col3_curr)) begin
            outcome_message <= "   Jackpots!    ";
        end else if ((col1_curr == col2_curr) || (col1_curr == col3_curr) || (col2_curr == col3_curr)) begin
            outcome_message <= "   Free Game!   ";
        end else begin
            outcome_message <= "     Loser!     ";
        end
    end 
//    else if (!all_switches_down) begin
//        game_over <= 0; 
//    end
end

reg err = 0;
reg [3:0] sw_prev;

always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        err <= 0;
        sw_prev <= 4'b1111;
    end 
    else if(!err && !game_over && !game_start && ((usr_sw[3:1] != 3'b111))) begin
        err <= 1;
    end
    else begin
        sw_prev <= usr_sw;
        if(!err && !game_over && ((sw_prev[0] == 0 && usr_sw[0] == 1) ||(sw_prev[1] == 0 && usr_sw[1] == 1) || (sw_prev[2] == 0 && usr_sw[2] == 1) || (sw_prev[3] == 0 && usr_sw[3] == 1))) begin
            err <= 1;
        end
    end
end

always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        row_A <= {" | ", num_to_ascii(col1_next), " | ", num_to_ascii(col2_next), " | ", num_to_ascii(col3_next), " |  "};
        row_B <= {" | ", num_to_ascii(col1_curr), " | ", num_to_ascii(col2_curr), " | ", num_to_ascii(col3_curr), " |  "};
    end 
    else begin
        if(err) begin
            row_A <= "     ERROR      ";
            row_B <= "  game stopped  ";
        end 
        else if(game_over) begin
            row_A <= outcome_message;
            row_B <= "   Game over    ";
        end 
        else begin
            row_A <= {" | ", num_to_ascii(col1_next), " | ", num_to_ascii(col2_next), " | ", num_to_ascii(col3_next), " |  "};
            row_B <= {" | ", num_to_ascii(col1_curr), " | ", num_to_ascii(col2_curr), " | ", num_to_ascii(col3_curr), " |  "};
        end
    end
end

endmodule
