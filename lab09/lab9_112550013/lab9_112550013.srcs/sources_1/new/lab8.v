`timescale 1ns / 1ps

module lab9(
    // General system I/O ports
    input        clk,
    input        reset_n,
    input  [3:0] usr_btn,
    output [3:0] usr_led,

    // 1602 LCD Module Interface
    output       LCD_RS,
    output       LCD_RW,
    output       LCD_E,
    output [3:0] LCD_D
);

    localparam [1:0] S_MAIN_INIT = 2'b00,
                     S_MAIN_CRACK = 2'b01,
                     S_MAIN_SHOW = 2'b10;

    wire       btn_level, btn_pressed;
    reg        prev_btn_level;
    reg  [1:0] P, P_next;
    reg        password_found;
    reg [55:0] timer;
    reg [255:0] passwd_hash = 256'hf120bb5698d520c5691b6d603a00bfd662d13bf177a04571f9d10c0745dfa2a5; // 000000000
    // reg [255:0] passwd_hash = 256'h7e09d41e8e1979275e2bf8aa6a2f0fab4637d096fede31226bbbd5e2774072f5; // 000000001
    // reg [255:0] passwd_hash = 256'h19d982e34e78d5667f80c8ef7085a003a7c3534e2f9a52398fdc4c67cdc80a83; // 997543965
    // reg [255:0] passwd_hash = 256'h092e9a31e3f92c369a6c8514fd6607dc1e386e0d05288fc859339563c33b47a7; // 362718362
    // reg [255:0] passwd_hash = 256'h26a08bd87c8fa4b67cfd16b923bd86f1e7cf34f75e3e3ce27fa27f3a33dfbc62; // 532412679
    reg [71:0] found_password;
    reg [71:0] password_candidate [0:9];
    reg [71:0] password_buffer [0:9];
    reg [511:0] message_candidate [0:9];
    reg start_sha256 [0:9];
    wire valid_sha256 [0:9];
    wire [255:0] candidate_hash [0:9];
    reg [127:0] row_A;
    reg [127:0] row_B;

    integer i;

    generate
        genvar idx;
        for (idx = 0; idx < 10; idx = idx + 1) begin : sha256_instances
            sha256 sha_inst(
                .clk(clk),
                .reset_n(~reset_n),
                .message(message_candidate[idx]),
                .start(start_sha256[idx]),
                .hash_output(candidate_hash[idx]),
                .valid(valid_sha256[idx])
            );
        end
    endgenerate

    function [511:0] format_message;
        input [71:0] passwd;
        reg [511:0] msg;
        begin
            msg = 512'd0;
            msg[511 -: 72] = passwd;
            msg[511 - 72] = 1'b1;
            msg[63:0] = 64'd72;
            format_message = msg;
        end
    endfunction

    function [71:0] increment_password;
        input [71:0] passwd;
        reg   [7:0] digits [8:0];
        integer     j;
        reg         carry;
        begin
            for (j = 0; j < 9; j = j + 1) begin
                digits[j] = passwd[j*8 +: 8];
            end
            carry = 1;
            for (j = 0; j < 9; j = j + 1) begin
                if (carry) begin
                    if (digits[j] == "9") begin
                        digits[j] = "0";
                        carry = 1;
                    end else begin
                        digits[j] = digits[j] + 1;
                        carry = 0;
                    end
                end
            end
            increment_password = {
                digits[8], digits[7], digits[6], digits[5],
                digits[4], digits[3], digits[2], digits[1], digits[0]
            };
        end
    endfunction

    debounce btn_db0(
        .clk(clk),
        .btn_input(usr_btn[3]),
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

    always @(posedge clk) begin
        if (~reset_n)
            prev_btn_level <= 0;
        else
            prev_btn_level <= btn_level;
    end
    assign btn_pressed = (btn_level == 1 && prev_btn_level == 0);

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n)
            P <= S_MAIN_INIT;
        else
            P <= P_next;
    end

    always @(*) begin
        case (P)
            S_MAIN_INIT:
                if (btn_pressed)
                    P_next = S_MAIN_CRACK;
                else
                    P_next = S_MAIN_INIT;
            S_MAIN_CRACK:
                if (password_found || timer == 56'hFFFFFFFFFFFFFF)
                    P_next = S_MAIN_SHOW;
                else
                    P_next = S_MAIN_CRACK;
            S_MAIN_SHOW:
                if (btn_pressed)
                    P_next = S_MAIN_INIT;
                else
                    P_next = S_MAIN_SHOW;
            default:
                P_next = S_MAIN_INIT;
        endcase
    end

    integer cnt;
    always @(posedge clk or negedge reset_n) begin
        if (~reset_n || P == S_MAIN_INIT) begin
            password_found <= 0;
            password_candidate[0] <= "000000000";
            password_candidate[1] <= "100000000";
            password_candidate[2] <= "200000000";
            password_candidate[3] <= "300000000";
            password_candidate[4] <= "400000000";
            password_candidate[5] <= "500000000";
            password_candidate[6] <= "600000000";
            password_candidate[7] <= "700000000";
            password_candidate[8] <= "800000000";
            password_candidate[9] <= "900000000";
            for (i = 0; i < 10; i = i + 1) begin
                message_candidate[i] <= format_message(password_candidate[i]);
                start_sha256[i] <= 1'b1;
                password_buffer[i] <= password_candidate[i];
            end
            cnt = 0;
        end else if (P == S_MAIN_CRACK && !password_found) begin
            for (i = 0; i < 10; i = i + 1) begin
                if (start_sha256[i]) begin
                    start_sha256[i] <= 1'b0;
                end else if (valid_sha256[i]) begin
                    if (candidate_hash[i] == passwd_hash) begin
                        password_found <= 1;
                        found_password <= password_buffer[i];
                    end else begin
                        password_candidate[i] <= increment_password(password_candidate[i]);
                        message_candidate[i] <= format_message(password_candidate[i]);
                        password_buffer[i] <= password_candidate[i];
                        start_sha256[i] <= 1'b1;
                    end
                end
            end
        end
    end

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n || P == S_MAIN_INIT)
            timer <= 56'd0;
        else if (P == S_MAIN_CRACK && !password_found)
            timer <= timer + 1;
    end

    always @(posedge clk) begin
        if (P == S_MAIN_INIT) begin
            row_A <= "Press BTN3 to   ";
            row_B <= "start cracking  ";
        end else if (P == S_MAIN_CRACK) begin
            row_A <= "Cracking...     ";
            // row_A <= {"Pwd:", password_candidate[9], "   "};
            row_B <= {"T:", to_hex_str(timer)};
        end else if (P == S_MAIN_SHOW) begin
            row_A <= {"Pwd:", found_password, "   "};
            row_B <= {"T:", to_hex_str(timer)};
        end
    end

    function [111:0] to_hex_str;
        input [55:0] num;
        reg [3:0] nibble;
        reg [7:0] char;
        integer k;
        begin
            for (k = 0; k < 14; k = k + 1) begin
                nibble = num[(55 - k*4) -: 4];
                case (nibble)
                    4'h0: char = "0";
                    4'h1: char = "1";
                    4'h2: char = "2";
                    4'h3: char = "3";
                    4'h4: char = "4";
                    4'h5: char = "5";
                    4'h6: char = "6";
                    4'h7: char = "7";
                    4'h8: char = "8";
                    4'h9: char = "9";
                    4'hA: char = "A";
                    4'hB: char = "B";
                    4'hC: char = "C";
                    4'hD: char = "D";
                    4'hE: char = "E";
                    4'hF: char = "F";
                    default: char = "0";
                endcase
                to_hex_str[(111 - k*8) -: 8] = char;
            end
        end
    endfunction

    assign usr_led = 4'b0000;

endmodule
