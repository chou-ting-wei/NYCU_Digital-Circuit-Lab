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

module tb_sha256;

    reg clk;
    reg rst;
    reg [511:0] message;
    reg start;

    wire [255:0] digest;
    wire done;

    sha256 uut (
        .clk(clk),
        .reset_n(rst),
        .message(message),
        .start(start),
        .hash_output(digest),
        .valid(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        start = 0;
        message = 512'd0;

        #20;
        rst = 0;

        // Test Case 2: Message "0987654321"
        message = {
            80'h30393837363534333231,   // "0987654321" in ASCII (80 bits)
            1'b1,
            {367{1'b0}},
            64'd80
        };

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 0: Message '0987654321'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: 17756315ebd47b7110359fc7b168179bf6f2df3646fcc888bc8aa05c78b38ac1");
        
        if (digest == 256'h17756315ebd47b7110359fc7b168179bf6f2df3646fcc888bc8aa05c78b38ac1) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        // Test Case 1: Message "1234567890"
        message = {
            80'h31323334353637383930,   // "1234567890" in ASCII (80 bits)
            1'b1,                       // Single '1' bit for padding
            {367{1'b0}},                // Pad with zeros to reach 448 bits
            64'd80                      // Message length in bits (big-endian)
        };

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 1: Message '1234567890'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: c775e7b757ede630cd0aa1113bd102661ab38829ca52a6422ab782862f268646");
        
        if (digest == 256'hc775e7b757ede630cd0aa1113bd102661ab38829ca52a6422ab782862f268646) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        // Test Case 2: Message "0987654321"
        message = {
            80'h30393837363534333231,   // "0987654321" in ASCII (80 bits)
            1'b1,
            {367{1'b0}},
            64'd80
        };

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 2: Message '0987654321'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: 17756315ebd47b7110359fc7b168179bf6f2df3646fcc888bc8aa05c78b38ac1");
        
        if (digest == 256'h17756315ebd47b7110359fc7b168179bf6f2df3646fcc888bc8aa05c78b38ac1) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        // Test Case 3: Message "1111111111"
        message = {
            80'h31313131313131313131,   // "1111111111" in ASCII (80 bits)
            1'b1,
            {367{1'b0}},
            64'd80
        };

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 3: Message '1111111111'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: d2d02ea74de2c9fab1d802db969c18d409a8663a9697977bb1c98ccdd9de4372");
        
        if (digest == 256'hd2d02ea74de2c9fab1d802db969c18d409a8663a9697977bb1c98ccdd9de4372) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        // Test Case 4: Message "2222222222"
        message = {
            80'h32323232323232323232,   // "2222222222" in ASCII (80 bits)
            1'b1,
            {367{1'b0}},
            64'd80
        };
        
        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 4: Message '2222222222'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: 965f69baefb60286c60262b40dcf40717a2227eef5db00c9b717d5de24453511");
        
        if (digest == 256'h965f69baefb60286c60262b40dcf40717a2227eef5db00c9b717d5de24453511) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        // Test Case 5: Message "3333333333"
        message = {
            80'h33333333333333333333,   // "3333333333" in ASCII (80 bits)
            1'b1,
            {367{1'b0}},
            64'd80
        };
        
        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 5: Message '3333333333'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: 36ecf9133cf3bb7963d53f30ff300c9f376c7ba12eefa341114563518bea8ec5");
        
        if (digest == 256'h36ecf9133cf3bb7963d53f30ff300c9f376c7ba12eefa341114563518bea8ec5) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        // Test Case 6: Message "4444444444"
        message = {
            80'h34343434343434343434,   // "4444444444" in ASCII (80 bits)
            1'b1,
            {367{1'b0}},
            64'd80
        };
        
        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 6: Message '4444444444'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: f12a38838db97f7767c61d3922fa073656e407f00d8dc7337e5b5d0b009221da");
        
        if (digest == 256'hf12a38838db97f7767c61d3922fa073656e407f00d8dc7337e5b5d0b009221da) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        // Test Case 7: Message "5555555555"
        message = {
            80'h35353535353535353535,   // "5555555555" in ASCII (80 bits)
            1'b1,
            {367{1'b0}},
            64'd80
        };
        
        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);

        #10;
        $display("Test Case 7: Message '5555555555'");
        $display("SHA-256 Digest: %h", digest);
        $display("Expected Digest: a5ad7e6d5225ad00c5f05ddb6bb3b1597a843cc92f6cf188490ffcb88a1ef4ef");
        
        if (digest == 256'ha5ad7e6d5225ad00c5f05ddb6bb3b1597a843cc92f6cf188490ffcb88a1ef4ef) begin
            $display("Test Passed: Digest matches expected value.\n");
        end else begin
            $display("Test Failed: Digest does not match expected value.\n");
        end

        #20;

        $finish;
    end

endmodule
