`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2024 17:20:21
// Design Name: 
// Module Name: sequential_binary_multiplier
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
module sequential_binary_multiplier(
    multiplicand, multiplier, start, clock, reset_b,
    ready, product
    );

parameter dp_width = 5; //datapath width
output [2*dp_width-1:0] product;
output ready;    

input [dp_width-1:0] multiplier, multiplicand;
input clock, start, reset_b;

parameter cnt_size = 3;
parameter s_idle = 3'b001, s_add = 3'b010, s_shift = 3'b100;

reg [2:0] state, next_state;
reg [dp_width-1:0] A, B, Q;  // B - multiplicand, Q - multiplier
reg [cnt_size-1:0] P;        //count to detect completion
reg load_regs, add_regs, shift_regs, decr_p;
reg C;     // Carry

assign product = {A, Q};
wire zero = (P==0);
wire ready = (state == s_idle);

always @(posedge clock, negedge reset_b) begin
    if (~reset_b) state <= s_idle; else state <= next_state;
end

always @(state, start, Q[0], zero) begin
    next_state = s_idle;
    load_regs = 0;
    decr_p = 0;
    add_regs = 0;
    shift_regs = 0;
    case (state)
         s_idle: begin if (start) next_state = s_add; load_regs = 1; end
         s_add: begin next_state = s_shift; decr_p = 1; if (Q[0]) add_regs = 1; end
         s_shift: begin shift_regs = 1; if (zero) next_state = s_idle;
         else next_state = s_add; end
         default : next_state = s_idle;
     endcase
end

// Operations
always @(posedge clock) begin
    if(load_regs) begin
        P <= dp_width;
        A <= 0;
        C <= 0;
        B <= multiplicand;
        Q <= multiplier;
    end
    if(add_regs) {C, A} <= A + B;
    if(shift_regs){C, A, Q} <= {C, A, Q} >> 1;
    if(decr_p) P <= P-1;
end

endmodule





