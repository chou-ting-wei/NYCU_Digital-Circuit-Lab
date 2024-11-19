//
// This module show you how to infer an initialized SRAM block
// in your circuit using the standard Verilog code.  The initial
// values of the SRAM cells is defined in the text file "image.dat"
// Each line defines a cell value. The number of data in image.dat
// must match the size of the sram block exactly.

module sram
#(parameter DATA_WIDTH = 8, ADDR_WIDTH = 16, RAM_SIZE = 65536, FILE = "images.mem")
 (input clk, input we, input en,
  input  [ADDR_WIDTH-1 : 0] addr_1,
  input  [DATA_WIDTH-1 : 0] data_i_1,
  input  [ADDR_WIDTH-1 : 0] addr_2,
  input  [DATA_WIDTH-1 : 0] data_i_2,
  output reg [DATA_WIDTH-1 : 0] data_o_1,
  output reg [DATA_WIDTH-1 : 0] data_o_2);

// Declareation of the memory cells
(* ram_style = "block" *) reg [DATA_WIDTH-1 : 0] RAM [RAM_SIZE - 1:0];

integer idx;

// ------------------------------------
// SRAM cell initialization
// ------------------------------------
// Initialize the sram cells with the values defined in "image.dat."
initial begin
    $readmemh(FILE, RAM);
end

// ------------------------------------
// SRAM read operation
// ------------------------------------
always@(posedge clk)
begin
  if (en & we)
    data_o_1 <= data_i_1;
  else
    data_o_1 <= RAM[addr_1];
end

always@(posedge clk)
begin
  if (en & we)
    data_o_2 <= data_i_2;
  else
    data_o_2 <= RAM[addr_2];
end

// ------------------------------------
// SRAM write operation
// ------------------------------------
always@(posedge clk)
begin
  if (en & we)
    RAM[addr_1] <= data_i_1;
end

always@(posedge clk)
begin
  if (en & we)
    RAM[addr_2] <= data_i_2;
end

endmodule
