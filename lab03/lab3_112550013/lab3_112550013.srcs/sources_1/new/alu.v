`timescale 1ns / 1ps

module alu(
    // DO NOT modify the interface!
    // input signal
    input [7:0] accum,
    input [7:0] data,
    input [2:0] opcode,
    input reset,
    
    // result
    output reg [7:0] alu_out,
    
    // PSW
    output reg zero,
    output reg overflow,
    output reg parity,
    output reg sign
    );

wire [8:0] sum, diff;
wire [15:0] mul_result;

assign sum = {accum[7], accum} + {data[7], data};
assign diff = {accum[7], accum} - {data[7], data};

assign mul_result = $signed(accum[3:0]) * $signed(data[3:0]);

always @(*) begin
    if (reset) begin
        alu_out = 8'b0;
        overflow = 1'b0;
    end 
    else begin
        case (opcode)
            3'b000: begin 
                alu_out = accum;
                overflow = 1'b0;
            end
            3'b001: begin
                if (sum[8] != sum[7]) begin 
                    alu_out = sum[7] ? 8'h7F : 8'h80;
                    overflow = 1'b1;
                end else begin
                    alu_out = sum[7:0];
                    overflow = 1'b0;
                end
            end
            3'b010: begin 
                if (diff[8] != diff[7]) begin 
                    alu_out = diff[7] ? 8'h7F : 8'h80; 
                    overflow = 1'b1;
                end else begin
                    alu_out = diff[7:0];
                    overflow = 1'b0;
                end
            end
            3'b011: begin 
                alu_out = $signed(accum) >>> data[2:0];
                overflow = 1'b0;
            end
            3'b100: begin
                alu_out = accum ^ data;
                overflow = 1'b0;
            end
            3'b101: begin 
                alu_out = accum[7] ? -accum : accum;
                overflow = 1'b0;
            end
            3'b110: begin
                alu_out = mul_result[7:0];
                overflow = 1'b0; 
            end
            3'b111: begin 
                alu_out = -accum;
                overflow = 1'b0;
            end
            default: begin
                alu_out = 8'b0;
                overflow = 1'b0;
            end
        endcase
    end
    
    zero = (alu_out == 8'b0);
    parity = ^alu_out; 
    sign = alu_out[7];
end

endmodule
