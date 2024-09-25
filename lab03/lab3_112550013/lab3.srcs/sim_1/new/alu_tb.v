/*********************************************************************
 * Stimulus for the ALU design - Verilog Training Course
 *********************************************************************/
 
`timescale 1ns / 1ns
module alu_test;
  wire [7:0] alu_out;
  wire zero;
  wire overflow;
  wire parity;
  wire sign;
  
  reg  [7:0] data, accum;
  reg  [2:0] opcode;
  
  wire [7:0] mask;
  
  reg reset;
  
  
// Instantiate the ALU.  Named mapping allows the designer to have freedom
//    with the order of port declarations

  alu   alu1 (.alu_out(alu_out), .zero(zero), .overflow(overflow), .parity(parity), .sign(sign),               //outputs from ALU
	      .opcode(opcode), .data(data & mask), .accum(accum & mask), .reset(reset)); //inputs to ALU

  //define mnemonics to represent opcodes
  `define PASSA    3'b000
  `define ADD      3'b001
  `define SUB      3'b010
  `define SHIFT    3'b011
  `define XOR      3'b100
  `define ABS      3'b101
  `define MUL      3'b110
  `define FLIPSIGN 3'b111
  
// define strobe
  `define strobe 10
  
// To perform a 4-bit multiplication, set the first 4 bits of the input to 4'b0000 when opcode is 3'b110 (Multiplication)
assign mask = (opcode == 3'b110)? 8'h0f: 8'hff;


// pattern generate
initial
begin
  reset = 0;
  # `strobe;
  reset = 1;
  # `strobe;
  reset = 0;

  // testcase 1
  # `strobe;
  opcode = 3'b001;
  accum = 8'h7F;
  data = 8'h01;
  # 1
  check_outputs;
  
  // testcase 2
  # `strobe;
  opcode = 3'b010;
  accum = 8'h80;
  data = 8'hFF;
  # 1
  check_outputs;
  
  
  //testcase 3
  # `strobe;
  opcode = 3'b110;
  accum = 8'h07;
  data = 8'hFC;
  # 1
  check_outputs;
  
  
end

task check_outputs ;
  begin
    $display("                           OPCODE     DATA      ACCUM  |  ALU_OUT         ZERO      OVERFLOW      PARITY      SIGN");
    $display("===============================================================================================================================");
    casez (opcode)
        `PASSA  : begin
                   $display("PASS ACCUM OPERATION:",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `ADD    : begin
                   $display("ADD OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `SUB    : begin
                   $display("SUB OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `SHIFT  : begin
                   $display("SHIFT OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `XOR   :  begin
                   $display("XOR OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
		`ABS    : begin
                   $display("ABS OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
		`MUL    : begin
                   $display("MUL OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `FLIPSIGN: begin
                   $display("FLIPSIGN OPERATION :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        default : begin
                   $display("UNKNOWN OPERATION   :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
    endcase
    $display("");
  end
  endtask
  
  
  

endmodule
 
 

