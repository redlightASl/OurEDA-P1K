`timescale 1ns / 1ps


module PID_incr_value #(
           parameter VAL_LENGTH = 32
       )(
           input wire sys_clk,
           input wire sys_rst_n,

           input wire signed [VAL_LENGTH - 1: 0] ek0,
           input wire signed [VAL_LENGTH - 1: 0] ek1,
           input wire signed [VAL_LENGTH - 1: 0] int_max,
           input wire signed [VAL_LENGTH - 1: 0] int_min,
           input wire signed [VAL_LENGTH - 1: 0] dif_max,
           input wire signed [VAL_LENGTH - 1: 0] dif_min,

           output wire signed [VAL_LENGTH - 1: 0] int_val_f,
           output wire signed [VAL_LENGTH - 1: 0] dif_val_f
       );
reg signed [VAL_LENGTH - 1: 0] int_val;
wire signed [VAL_LENGTH - 1: 0] dif_val;

//calculate integratal value
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        int_val <= {VAL_LENGTH{1'd0}};
    end
    else begin
        int_val <= int_val + ek0;
    end
end

assign int_val_f = (int_val > int_max) ? (int_max) : ((int_val < int_min) ? int_min : int_val);

//calculate differential value
assign dif_val = ek0 - ek1;
assign dif_val_f = (dif_val > dif_max) ? (dif_max) : ((dif_val < dif_min) ? dif_min : dif_val);

endmodule
