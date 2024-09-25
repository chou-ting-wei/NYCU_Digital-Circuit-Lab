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
  
  // testcase 3
  # `strobe;
  opcode = 3'b110;
  accum = 8'h07;
  data = 8'hFC;
  # 1
  check_outputs;

// ============================================================
// Additional PASSA(000) test cases
// ============================================================

$display("Testcase PASSA-1 (50 => 50)");
# `strobe;
opcode = `PASSA;
accum = 8'd50;
data = 8'd50;
# 1
check_outputs;

$display("Testcase PASSA-2 (-50 => -50)");
# `strobe;
opcode = `PASSA;
accum = 8'b11001110;
data = 8'd50;
# 1
check_outputs;

$display("Testcase PASSA-3 (0 => 0)");
# `strobe;
opcode = `PASSA;
accum = 8'd0;
data = 8'd0;
# 1
check_outputs;

// ============================================================
// Additional ADD(001) test cases
// ============================================================

$display("Testcase ADD-1 (55 + 5 = 60)");
# `strobe;
opcode = `ADD;
accum = 8'd55;       
data = 8'd5;      
#1
check_outputs;

$display("Testcase ADD-2 (-128 + 30 = -98)");
# `strobe;
opcode = `ADD;
accum = 8'h80;     
data = 8'd30;       
#1
check_outputs;

$display("Testcase ADD-3 (-10 + 10 = 0)");
# `strobe;
opcode = `ADD;
accum = 8'hF6;     
data = 8'd10;       
#1
check_outputs;

$display("Testcase ADD-4 (127 + 1 = 127)");
# `strobe;
opcode = `ADD;
accum = 8'd127;      
data = 8'd1;         
#1
check_outputs;

$display("Testcase ADD-5 (-128 + -1 = -128)");
# `strobe;
opcode = `ADD;
accum = 8'h80;        
data = 8'hFF;       
#1
check_outputs;

// ============================================================
// Additional SUB(010) test cases
// ============================================================

$display("Testcase SUB-1 (-10 - 5 = -15)");
# `strobe;
opcode = `SUB;
accum = 8'hF6;       
data = 8'd5;      
#1
check_outputs;

$display("Testcase SUB-2 (30 - 20 = 10)");
# `strobe;
opcode = `SUB;
accum = 8'd30;     
data = 8'd20;       
#1
check_outputs;

$display("Testcase SUB-3 (10 - 10 = 0)");
# `strobe;
opcode = `SUB;
accum = 8'd10;     
data = 8'd10;       
#1
check_outputs;

$display("Testcase SUB-4 (127 - (-1) = 127)");
# `strobe;
opcode = `SUB;
accum = 8'd127;      
data = 8'hFF;        
#1
check_outputs;

$display("Testcase SUB-5 (-128 - 1 = -128)");
# `strobe;
opcode = `SUB;
accum = 8'h80;       
data = 8'd1;         
#1
check_outputs;

// ============================================================
// Additional SHIFT(011) test cases
// ============================================================

$display("Testcase SHIFT-1 (50 >>> 2 = 12)");
# `strobe;
opcode = `SHIFT;
accum = 8'd50;     
data = 8'd2;      
#1
check_outputs;

$display("Testcase SHIFT-2 (-40 >>> 3 = -5)");
# `strobe;
opcode = `SHIFT;
accum = 8'b11011000;    
data = 8'd3;     
#1
check_outputs;

// ============================================================
// Additional XOR(100) test cases
// ============================================================

$display("Testcase XOR-1 (50 ^ 20 = 38)");
# `strobe;
opcode = `XOR;
accum = 8'd50;      
data = 8'd20;       
#1
check_outputs;

$display("Testcase XOR-2 (-30 ^ 15 = -19)");
# `strobe;
opcode = `XOR;
accum = 8'b11100010;    
data = 8'd15;           
#1
check_outputs;

// ============================================================
// Additional ABS(101) test cases
// ============================================================

$display("Testcase ABS-1 (abs(-50) = 50)");
# `strobe;
opcode = `ABS;
accum = 8'b11001110;    
data = 8'd0;        
#1
check_outputs;

$display("Testcase ABS-2 (abs(50) = 50)");
# `strobe;
opcode = `ABS;
accum = 8'd50;     
data = 8'd0;         
#1
check_outputs;

$display("Testcase ABS-3 (abs(0) = 0)");
# `strobe;
opcode = `ABS;
accum = 8'd0;     
data = 8'd0;         
#1
check_outputs;

// ============================================================
// Additional MUL(110) test cases
// ============================================================

$display("Testcase MUL-1 (7 * 7 = 49)");
# `strobe;
opcode = `MUL;
accum = 8'd7;       
data = 8'd7;     
#1
check_outputs;

$display("Testcase MUL-2 ((-8) * (-8) = 64)");
# `strobe;
opcode = `MUL;
accum = 8'h08;       
data = 8'h08;     
#1
check_outputs;

$display("Testcase MUL-3 (7 * (-8) = -56)");
# `strobe;
opcode = `MUL;
accum = 8'd7;    
data = 8'h08;    
#1
check_outputs;

// ============================================================
// Additional FLIPSIGN(111) test cases
// ============================================================

$display("Testcase FLIPSIGN-1 (-50 => 50)");
# `strobe;
opcode = `FLIPSIGN;
accum = 8'b11001110;   
data = 8'd0;         
#1
check_outputs;

$display("Testcase FLIPSIGN-2 (50 => -50)");
# `strobe;
opcode = `FLIPSIGN;
accum = 8'd50;      
data = 8'd0;         
#1
check_outputs;

$display("Testcase FLIPSIGN-3 (0 => 0)");
# `strobe;
opcode = `FLIPSIGN;
accum = 8'd0;       
data = 8'd0;         
#1
check_outputs;

// ============================================================
// Additional UNKNOWN(xxx) test cases
// ============================================================

$display("Testcase UNKNOWN (UNKNOWN OPERATION)");
# `strobe;
opcode = 3'bxxx;
accum = 8'd0;       
data = 8'd0;         
#1
check_outputs;

end

task check_outputs ;
  begin
    $display("                           OPCODE     DATA      ACCUM  |  ALU_OUT         ZERO      OVERFLOW      PARITY      SIGN");
    $display("===============================================================================================================================");
    casez (opcode)
        `PASSA  : begin
                   $display("PASSA: %d => %d", $signed(accum[7:0]), $signed(alu_out[7:0]));
                   $display("PASS ACCUM OPERATION:",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `ADD    : begin
                   $display("ADD: %d + %d = %d", $signed(accum[7:0]), $signed(data[7:0]), $signed(alu_out[7:0]));
                   $display("ADD OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `SUB    : begin
                   $display("SUB: %d - %d = %d", $signed(accum[7:0]), $signed(data[7:0]), $signed(alu_out[7:0]));
                   $display("SUB OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `SHIFT  : begin
                   $display("SHIFT: %d >>> %d = %d", $signed(accum[7:0]), $signed(data[7:0]), $signed(alu_out[7:0]));
                   $display("SHIFT OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `XOR   :  begin
                   $display("XOR: %d ^ %d = %d", $signed(accum[7:0]), $signed(data[7:0]), $signed(alu_out[7:0]));
                   $display("XOR OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
		`ABS    : begin
		           $display("ABS: abs(%d) = %d", $signed(accum[7:0]), $signed(alu_out[7:0]));
                   $display("ABS OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
		`MUL    : begin
		           $display("MUL: %d * %d = %d", $signed(accum[3:0]), $signed(data[3:0]), $signed(alu_out[7:0]));
                   $display("MUL OPERATION       :",
                            "      %b     %b   %b  |   %b          %b          %b          %b          %b",
                            opcode, data, accum, alu_out, zero, overflow, parity, sign);
                  end
        `FLIPSIGN: begin
                   $display("FLIPSIGN: %d => %d", $signed(accum[7:0]), $signed(alu_out[7:0]));
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
 
 

