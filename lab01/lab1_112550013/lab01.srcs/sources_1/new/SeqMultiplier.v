`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/09 19:14:27
// Design Name: 
// Module Name: SeqMultiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SeqMultiplier(
    input wire clk,
    input wire enable,
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [15:0] C
    );
    
reg [15:0] prod; 
reg [7:0] mult;
reg [3:0] counter;
wire shift;
assign C = prod;
assign shift = |(counter^7); //1 if counter<7; 0 if counter==7
/*
Every bit of counter exclusive or 7(4'b0111), and or together
ex: When counter = 4'd2 = 4'b0010, then counter^7 = 4'b0101, shift = 0|1|0|1 = 1
That is, only when counter^7 == 4'b0000 --> counter == 7 will shift be 0. 
*/

always @(posedge clk) begin
  if (!enable) begin
    mult <= B;
    prod <= 0;
    counter <= 0;
  end
  else begin
    mult <= mult << 1;
    prod <= (prod + (A & {8{mult[7]}})) << shift;
    counter <= counter + shift;
  end
end

endmodule
