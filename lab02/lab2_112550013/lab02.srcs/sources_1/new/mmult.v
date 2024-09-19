`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/17 17:58:22
// Design Name: 
// Module Name: mmult
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


module mmult(
    input clk, // Clock signal.
    input reset_n, // Reset signal (negative logic).
    input enable, // Activation signal for matrix
    // multiplication (tells the circuit
    // that A and B are ready for use).
    input [0:9*8-1] A_mat, // A matrix.
    input [0:9*8-1] B_mat, // B matrix.
    output valid, // Signals that the output is valid
    // to read.
    output reg [0:9*18-1] C_mat // The result of A x B.
);

reg [7:0] A [0:8];
reg [7:0] B [0:8];
reg [17:0] C [0:8];
reg [1:0] counter;

integer i, j, k, flg;
reg [17:0] temp;

assign valid = flg;

always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        counter <= 0;
        flg = 0;
        for (i = 0; i < 9; i = i + 1) begin
            A[i] <= 0;
            B[i] <= 0;
            C[i] <= 0;
        end 
    end
    else if(enable !== 1) begin
        counter <= 0;
        for (i = 0; i < 9; i = i + 1) begin
            j = (i * 8);
            A[i] <= A_mat[j +: 8];
            B[i] <= B_mat[j +: 8];
            C[i] <= 0;
        end 
    end
    else if (enable & ~(counter==3)) begin
        i = counter;
        for (j = 0; j < 3; j = j + 1) begin
            temp = 0; 
            for (k = 0; k < 3; k = k + 1) begin
                temp = temp + (A[i*3+k] * B[k*3+j]); 
            end
            C[i*3+j] <= temp; 
        end
        counter <= counter + 1;
//        C_mat <= {C[0], C[1], C[2], C[3], C[4], C[5], C[6], C[7], C[8]};
    end
    
    if (counter==3) begin
        C_mat <= {C[0], C[1], C[2], C[3], C[4], C[5], C[6], C[7], C[8]};
        flg = 1;
    end
end

endmodule
