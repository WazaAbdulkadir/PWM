`timescale 1ns / 1ps

module pwm(
            input clk,
            input rst,
            input [6:0] duty_cycle_i, // 7 bit çünkü duty cycle yüzde yüz olabiliyor. Dolayýsýyla 100 e kadar saymalý.
            
            output reg pwm_o
            );
            
            
parameter clk_freq = 100_000_000;
parameter pwm_freq = 1000; // sn de 1000 kere = 1 ms periyot  

parameter c_timerlim = clk_freq / pwm_freq; //100_000

wire [31:0] count_high_part_of_duty_cycle;

assign  count_high_part_of_duty_cycle =  (c_timerlim/100) * (duty_cycle_i); // duty_cycle deðiþken olduðu için DSP unit kullanýr. 
 
reg [31:0]timer;  

always @ (posedge clk) begin
        if (rst) begin
            timer <= 32'b0;
        end  
        
        else if (timer == c_timerlim -1) begin
            timer <= 32'b0;
        end 
        
                
        else if (timer < count_high_part_of_duty_cycle -1 ) begin
            pwm_o <= 1'b1;
            timer <= timer + 1;
        end 
        
        else begin
            timer <= timer + 1;
            pwm_o <= 1'b0;
        end 
        
        
end 

endmodule
