`timescale 1ns / 1ps


module PID_value#(
           parameter VAL_LENGTH = 32
       )(
           input wire sys_clk,
           input wire sys_rst_n,

           input wire signed [VAL_LENGTH - 1: 0] err_val,
           input wire signed [VAL_LENGTH - 1: 0] int_val,
           input wire signed [VAL_LENGTH - 1: 0] dif_val,
           input wire signed [VAL_LENGTH - 1: 0] kp,
           input wire signed [VAL_LENGTH - 1: 0] ki,
           input wire signed [VAL_LENGTH - 1: 0] kd,
           input wire signed [VAL_LENGTH - 1: 0] uk_max,
           input wire signed [VAL_LENGTH - 1: 0] uk_min,

           output wire signed [VAL_LENGTH - 1: 0] uk
       );
reg signed [VAL_LENGTH - 1: 0] uk_w;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        uk_w <= {VAL_LENGTH{1'd0}};
    end
    else begin
        uk_w <= err_val * kp + int_val * ki + dif_val * kd;
    end
end

assign uk = (uk_w > uk_max) ? (uk_max) : ((uk_w < uk_min) ? uk_min : uk_w);

endmodule
