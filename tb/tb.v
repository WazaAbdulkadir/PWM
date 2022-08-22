`timescale 1ns / 1ps


module tb();

reg clk;
reg rst;

reg [6:0] duty_cycle_i;


pwm dut (.clk(clk), .rst(rst),.duty_cycle_i(duty_cycle_i));

always #5 clk = ~clk;

initial begin
clk = 1;
rst = 1;
#17;

rst = 0;
#3;

duty_cycle_i = 7'b100_0110; // % 70;
#5000000;

duty_cycle_i = 7'b001_1000; // % 40;
#5000000;

duty_cycle_i = 7'b000_1010; // % 10;
#5000000;


$finish;   

end 

endmodule
