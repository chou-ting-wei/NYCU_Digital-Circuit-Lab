`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
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
//              4. The LCD will then display the sector just been read, and the
//                 first byte of the sector.
//              5. Every time you press usr_btn[2], the next byte will be displayed.
//
// Dependencies: clk_divider, LCD_module, debounce, sd_card
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module sha256 (
    input clk,
    input reset_n,
    input [511:0] message,
    input start,
    output [255:0] hash_output,
    output valid
    );

    wire [255:0] H_initial;
    wire [255:0] H_out;
    wire output_valid;

    sha256_init H0_inst (
        .H_0(H_initial)
    );

    sha256_block block_inst (
        .clk(clk),
        .reset_n(reset_n),
        .H_in(H_initial),
        .M_in(message),
        .input_valid(start),
        .H_out(H_out),
        .output_valid(output_valid)
    );

    assign hash_output = H_out;
    assign valid = output_valid;

endmodule

module sha256_init(
    output [255:0] H_0
    );

    assign H_0 = {
        32'h6A09E667, 32'hBB67AE85, 32'h3C6EF372, 32'hA54FF53A,
        32'h510E527F, 32'h9B05688C, 32'h1F83D9AB, 32'h5BE0CD19
    };

endmodule

module sha256_K_machine (
    input clk,
    input reset_n,
    output [31:0] K
    );

    reg [2047:0] K_register_q;
    wire [2047:0] K_register_d = { K_register_q[2015:0], K_register_q[2047:2016] };
    reg [5:0] round_counter;

    always @(posedge clk or posedge reset_n) begin
        if (reset_n) begin
            K_register_q <= {
                32'h428a2f98, 32'h71374491, 32'hb5c0fbcf, 32'he9b5dba5,
                32'h3956c25b, 32'h59f111f1, 32'h923f82a4, 32'hab1c5ed5,
                32'hd807aa98, 32'h12835b01, 32'h243185be, 32'h550c7dc3,
                32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7, 32'hc19bf174,
                32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6, 32'h240ca1cc,
                32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc, 32'h76f988da,
                32'h983e5152, 32'ha831c66d, 32'hb00327c8, 32'hbf597fc7,
                32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351, 32'h14292967,
                32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc, 32'h53380d13,
                32'h650a7354, 32'h766a0abb, 32'h81c2c92e, 32'h92722c85,
                32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70, 32'hc76c51a3,
                32'hd192e819, 32'hd6990624, 32'hf40e3585, 32'h106aa070,
                32'h19a4c116, 32'h1e376c08, 32'h2748774c, 32'h34b0bcb5,
                32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f, 32'h682e6ff3,
                32'h748f82ee, 32'h78a5636f, 32'h84c87814, 32'h8cc70208,
                32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7, 32'hc67178f2
            };
            round_counter <= 0;
        end else begin
            K_register_q <= K_register_d;
            round_counter <= round_counter + 1;
        end
    end

    assign K = K_register_q[2047:2016];

endmodule

module sha256_W_machine (
    input clk,
    input reset_n,
    input [511:0] M,
    input M_valid,
    output [31:0] W_tm2, W_tm15,
    input [31:0] s1_Wtm2, s0_Wtm15,
    output [31:0] W
    );

    reg [32*16-1:0] W_registers_q;
    wire [32*16-1:0] W_registers_d = {W_registers_q[32*15-1:0], W_next_value};
    wire [31:0] W_t_minus_2 = W_registers_q[32*2-1:32*1];
    wire [31:0] W_t_minus_15 = W_registers_q[32*15-1:32*14];
    wire [31:0] W_tm7 = W_registers_q[32*7-1:32*6];
    wire [31:0] W_tm16 = W_registers_q[32*16-1:32*15];
    wire [31:0] W_next_value = s1_Wtm2 + W_tm7 + s0_Wtm15 + W_tm16;

    assign W_tm2 = W_t_minus_2;
    assign W_tm15 = W_t_minus_15;
    assign W = W_registers_q[32*16-1:32*15];

    always @(posedge clk or posedge reset_n) begin
        if (reset_n) begin
            W_registers_q <= M;
        end else begin
            W_registers_q <= W_registers_d;
        end
    end

endmodule

module sigma0 (
    input wire [31:0] input_word,
    output wire [31:0] s0
    );

    assign s0 = ({input_word[6:0], input_word[31:7]} ^ {input_word[17:0], input_word[31:18]} ^ (input_word >> 3));

endmodule

module sigma1 (
    input wire [31:0] input_word,
    output wire [31:0] s1
    );

    assign s1 = ({input_word[16:0], input_word[31:17]} ^ {input_word[18:0], input_word[31:19]} ^ (input_word >> 10));

endmodule

module sha2_round (
    input [31:0] Kj, Wj,
    input [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
    input [31:0] Ch_result, Maj_result, S0_a, S1_e,
    output [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
    );

    wire [31:0] T1 = h_in + S1_e + Ch_result + Kj + Wj;
    wire [31:0] T2 = S0_a + Maj_result;

    assign a_out = T1 + T2;
    assign b_out = a_in;
    assign c_out = b_in;
    assign d_out = c_in;
    assign e_out = d_in + T1;
    assign f_out = e_in;
    assign g_out = f_in;
    assign h_out = g_in;

endmodule

module sha256_round (
    input [31:0] Kj, Wj,
    input [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
    output [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
    );

    wire [31:0] Ch_result, Maj_result, S0_a, S1_e;

    assign Ch_result = ((e_in & f_in) ^ (~e_in & g_in));
    assign Maj_result = ((a_in & b_in) ^ (a_in & c_in) ^ (b_in & c_in));
    assign S0_a = ({a_in[1:0], a_in[31:2]} ^ {a_in[12:0], a_in[31:13]} ^ {a_in[21:0], a_in[31:22]});
    assign S1_e = ({e_in[5:0], e_in[31:6]} ^ {e_in[10:0], e_in[31:11]} ^ {e_in[24:0], e_in[31:25]});

    sha2_round sha256_round_inner (
        .Kj(Kj), .Wj(Wj),
        .a_in(a_in), .b_in(b_in), .c_in(c_in), .d_in(d_in),
        .e_in(e_in), .f_in(f_in), .g_in(g_in), .h_in(h_in),
        .Ch_result(Ch_result), .Maj_result(Maj_result),
        .S0_a(S0_a), .S1_e(S1_e),
        .a_out(a_out), .b_out(b_out), .c_out(c_out), .d_out(d_out),
        .e_out(e_out), .f_out(f_out), .g_out(g_out), .h_out(h_out)
    );

endmodule

module sha256_block (
    input clk,
    input reset_n,
    input [255:0] H_in,
    input [511:0] M_in,
    input input_valid,
    output [255:0] H_out,
    output output_valid
    );

    reg [6:0] round_counter;
    wire [31:0] a_in = H_in[255:224];
    wire [31:0] b_in = H_in[223:192];
    wire [31:0] c_in = H_in[191:160];
    wire [31:0] d_in = H_in[159:128];
    wire [31:0] e_in = H_in[127:96];
    wire [31:0] f_in = H_in[95:64];
    wire [31:0] g_in = H_in[63:32];
    wire [31:0] h_in = H_in[31:0];

    reg [31:0] a_reg, b_reg, c_reg, d_reg, e_reg, f_reg, g_reg, h_reg;
    wire [31:0] a_next, b_next, c_next, d_next, e_next, f_next, g_next, h_next;
    wire [31:0] W_tm2, W_tm15, s1_Wtm2, s0_Wtm15, Wj, Kj;

    sha256_W_machine W_machine_inst (
        .clk(clk),
        .reset_n(input_valid),
        .M(M_in),
        .M_valid(input_valid),
        .W_tm2(W_tm2),
        .W_tm15(W_tm15),
        .s1_Wtm2(s1_Wtm2),
        .s0_Wtm15(s0_Wtm15),
        .W(Wj)
    );

    sha256_K_machine K_machine_inst (
        .clk(clk),
        .reset_n(input_valid),
        .K(Kj)
    );

    sha256_round round_inst (
        .Kj(Kj),
        .Wj(Wj),
        .a_in(a_reg),
        .b_in(b_reg),
        .c_in(c_reg),
        .d_in(d_reg),
        .e_in(e_reg),
        .f_in(f_reg),
        .g_in(g_reg),
        .h_in(h_reg),
        .a_out(a_next),
        .b_out(b_next),
        .c_out(c_next),
        .d_out(d_next),
        .e_out(e_next),
        .f_out(f_next),
        .g_out(g_next),
        .h_out(h_next)
    );

    sigma0 s0_inst (
        .input_word(W_tm15),
        .s0(s0_Wtm15)
    );

    sigma1 s1_inst (
        .input_word(W_tm2),
        .s1(s1_Wtm2)
    );

    always @(posedge clk or posedge reset_n) begin
        if (reset_n) begin
            a_reg <= a_in;
            b_reg <= b_in;
            c_reg <= c_in;
            d_reg <= d_in;
            e_reg <= e_in;
            f_reg <= f_in;
            g_reg <= g_in;
            h_reg <= h_in;
            round_counter <= 0;
        end else if (input_valid) begin
            a_reg <= a_in;
            b_reg <= b_in;
            c_reg <= c_in;
            d_reg <= d_in;
            e_reg <= e_in;
            f_reg <= f_in;
            g_reg <= g_in;
            h_reg <= h_in;
            round_counter <= 0;
        end else begin
            a_reg <= a_next;
            b_reg <= b_next;
            c_reg <= c_next;
            d_reg <= d_next;
            e_reg <= e_next;
            f_reg <= f_next;
            g_reg <= g_next;
            h_reg <= h_next;
            round_counter <= round_counter + 1;
        end
    end

    assign H_out = {
        a_in + a_reg,
        b_in + b_reg,
        c_in + c_reg,
        d_in + d_reg,
        e_in + e_reg,
        f_in + f_reg,
        g_in + g_reg,
        h_in + h_reg
    };
    assign output_valid = (round_counter == 64);

endmodule
