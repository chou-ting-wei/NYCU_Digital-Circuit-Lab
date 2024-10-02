`timescale 1ns / 1ps
module lab4(
  input  clk,            // System clock at 100 MHz
  input  reset_n,        // System reset signal, in negative logic
  input  [3:0] usr_btn,  // Four user pushbuttons
  output [3:0] usr_led   // Four yellow LEDs
);

//assign usr_led = usr_btn;

wire [3:0] btn_pressed;
wire [3:0] gray;

// De-bouncing CKT
debounce_counter C0(
    .clk(clk),
    .reset(reset_n),
    .noisy_signal(usr_btn[0]),
    .debounced_signal(btn_pressed[0])
);
debounce_counter C1(
    .clk(clk),
    .reset(reset_n),
    .noisy_signal(usr_btn[1]),
    .debounced_signal(btn_pressed[1])
);
debounce_counter C2(
    .clk(clk),
    .reset(reset_n),
    .noisy_signal(usr_btn[2]),
    .debounced_signal(btn_pressed[2])
);
debounce_counter C3(
    .clk(clk),
    .reset(reset_n),
    .noisy_signal(usr_btn[3]),
    .debounced_signal(btn_pressed[3])
);

// Gray CKT
gray_gen G1(
    .clk(clk),
    .reset(reset_n),
    .btn0(btn_pressed[0]),             
    .btn1(btn_pressed[1]),   
    .gray(gray)
);

// PWM CKT
pwm_gen P1(
    .clk(clk),
    .reset(reset_n),
    .btn2(btn_pressed[2]),             
    .btn3(btn_pressed[3]),   
    .gray(gray),
    .usr_led(usr_led)    
);

endmodule

module debounce_counter (
    input wire clk,            
    input wire reset,          
    input wire noisy_signal,   
    output reg debounced_signal 
);

reg [15:0] counter; 
reg stable_signal;  

parameter MAX_COUNT = 16'hFFFF; 

always @(posedge clk, negedge reset) begin
    if (reset == 0) begin
        counter <= 16'b0;
        debounced_signal <= 1'b0;
        stable_signal <= 1'b0;
    end
    else begin
        if (noisy_signal == stable_signal) begin
            if (counter < MAX_COUNT) begin
                counter <= counter + 1;
            end
            else begin
                debounced_signal <= stable_signal;
            end
        end
        else begin
            counter <= 16'b0;
            stable_signal <= noisy_signal;
        end
    end
end
endmodule

// BTN1/BTN0 increases/decreases the counter value
module gray_gen (
    input wire clk,              
    input wire reset, 
    input wire btn0,             
    input wire btn1,
    output reg [3:0] gray  
);

reg [3:0] counter;
reg btn0_prev, btn1_prev;
always @(posedge clk, negedge reset) begin
    if (reset == 0) begin
        counter <= 4'd0;
        btn0_prev <= 1'b0;
        btn1_prev <= 1'b0;
    end
    else begin
        if (btn0 && !btn0_prev) begin
            if (counter > 4'd0) begin
                counter <= counter - 1;
            end
        end
        if (btn1 && !btn1_prev) begin
            if (counter < 4'd15) begin
                counter <= counter + 1;
            end
        end
        btn0_prev <= btn0;
        btn1_prev <= btn1;
    end
end

always @ (counter) begin
    gray = (counter >> 1) ^ counter;
end
endmodule

// BTN2/BTN3 increases/decreases the brightness of the LEDs
module pwm_gen (
    input wire clk,              
    input wire reset,            
    input wire btn2,             
    input wire btn3,
    input wire [3:0] gray,
    output reg [3:0] usr_led     
);

reg [31:0] counter = 0;     
reg [2:0] cycle_index = 0; 

reg [31:0] cycles[4:0];
initial begin
    cycles[0] = 32'd5000;    // 5%
    cycles[1] = 32'd25000;   // 25%
    cycles[2] = 32'd50000;   // 50%
    cycles[3] = 32'd75000;   // 75%
    cycles[4] = 32'd100000;  // 100%
end

reg [31:0] pwm_on_time = 32'd5000;

always @(posedge clk, negedge reset) begin
    if (reset == 0) begin
        counter <= 0;
        usr_led <= 4'b0000;  
    end
    else begin
        if (counter < 32'd100000)
            counter <= counter + 1;
        else
            counter <= 0;

        if (counter < pwm_on_time)
            usr_led <= gray; 
        else
            usr_led <= 4'b0000; 
    end
end

reg btn2_prev, btn3_prev;
always @(posedge clk, negedge reset) begin
    if (reset == 0) begin
        cycle_index <= 0;    
        pwm_on_time <= cycles[0];
        btn2_prev <= 1'b0;
        btn3_prev <= 1'b0;
    end
    else begin
        if (btn2 && !btn2_prev) begin
            if (cycle_index < 4) begin
                cycle_index <= cycle_index + 1;
                pwm_on_time <= cycles[cycle_index + 1];
            end
        end
        if (btn3 && !btn3_prev) begin
            if (cycle_index > 0) begin
                cycle_index <= cycle_index - 1;
                pwm_on_time <= cycles[cycle_index - 1];
            end
        end

        btn2_prev <= btn2;
        btn3_prev <= btn3;
    end
end
endmodule
