`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 17:22:22
// Design Name: 
// Module Name: t_sequential_binary_multiplier
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
module t_sequential_binary_multiplier();

parameter dp_width = 5;
wire [2*dp_width-1:0] product;
wire ready;

reg [dp_width-1:0] multiplier, multiplicand;
reg start, clock, reset_b;

sequential_binary_multiplier M0(multiplicand, multiplier, start, clock, reset_b, ready, product);

initial #2060000 $finish; // Increased simulation time
initial begin clock = 0; #5 forever #5 clock = ~clock; end
initial fork
 reset_b = 1;
 #2 reset_b = 0;
 #3 reset_b = 1;
 join 
 initial begin #5 start = 1; end
initial begin
 #5 multiplicand = 0;
 multiplier = 2;
 repeat (64) #10 begin multiplier = multiplier + 1;
 repeat (64) @ (posedge M0.ready) #5 multiplicand = multiplicand + 5;
 end 
 end 
endmodule
