`timescale 1ns / 1ps


module PID_error #(
           parameter VAL_LENGTH = 32
       )(
           input wire sys_clk,
           input wire sys_rst_n,

           input wire signed [VAL_LENGTH - 1: 0] target,
           input wire signed [VAL_LENGTH - 1: 0] current_value,
           output wire signed [VAL_LENGTH - 1: 0] ek0,
           output reg signed [VAL_LENGTH - 1: 0] ek1
       );

assign ek0 = target - current_value; //calculate error

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        ek1 <= {VAL_LENGTH{1'd0}};
    end
    else begin
        ek1 <= ek0;
    end
end
endmodule
