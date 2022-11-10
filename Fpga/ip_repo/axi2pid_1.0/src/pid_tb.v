`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/10/03 16:20:35
// Design Name:
// Module Name: pid_tb
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
`include "./pid_top.v"

module pid_tb();
// pid_top Parameters
parameter PERIOD = 10;
parameter CLK_VAL_MHZ = 50;
parameter VAL_LENGTH = 32;

// pid_top Inputs
reg sys_clk = 0;
reg sys_rst_n = 0;
reg signed [VAL_LENGTH - 1: 0] target = 0;
reg signed [VAL_LENGTH - 1: 0] current_value = 0;
reg signed [VAL_LENGTH - 1: 0] int_max = 0;
reg signed [VAL_LENGTH - 1: 0] int_min = 0;
reg signed [VAL_LENGTH - 1: 0] dif_max = 0;
reg signed [VAL_LENGTH - 1: 0] dif_min = 0;
reg signed [VAL_LENGTH - 1: 0] uk_max = 0;
reg signed [VAL_LENGTH - 1: 0] uk_min = 0;
reg signed [VAL_LENGTH - 1: 0] kp = 0;
reg signed [VAL_LENGTH - 1: 0] ki = 0;
reg signed [VAL_LENGTH - 1: 0] kd = 0;

// pid_top Outputs
wire signed [VAL_LENGTH - 1: 0] pid_out;


initial begin
    forever
        #(PERIOD / 2) sys_clk = ~sys_clk;
end


integer stage = 0;
always @(posedge sys_clk) begin
    case (stage)
        0: begin
            sys_rst_n = 1'b0;
            target = 1357;
            int_max = 50;
            int_min = -50;
            dif_max = 20;
            dif_min = -20;
            uk_max = 2500;
            uk_min = 500;
            kp = 1;
            ki = 3;
            kd = 2;
            stage = 1;
        end
        1: begin
            sys_rst_n = 1'b1;
            stage = 2;
        end
        2: begin
            current_value = pid_out / 10;
            stage = 2;
        end
        default: begin
            stage = 0;
        end
    endcase
end


pid_top #(
            .CLK_VAL_MHZ ( CLK_VAL_MHZ ),
            .VAL_LENGTH ( VAL_LENGTH ))
        u_pid_top_inst (
            .sys_clk ( sys_clk ),
            .sys_rst_n ( sys_rst_n ),
            .target ( target [VAL_LENGTH - 1: 0] ),
            .current_value ( current_value [VAL_LENGTH - 1: 0] ),
            .int_max ( int_max [VAL_LENGTH - 1: 0] ),
            .int_min ( int_min [VAL_LENGTH - 1: 0] ),
            .dif_max ( dif_max [VAL_LENGTH - 1: 0] ),
            .dif_min ( dif_min [VAL_LENGTH - 1: 0] ),
            .uk_max(uk_max),
            .uk_min(uk_min),
            .kp ( kp [VAL_LENGTH - 1: 0] ),
            .ki ( ki [VAL_LENGTH - 1: 0] ),
            .kd ( kd [VAL_LENGTH - 1: 0] ),

            .pid_out ( pid_out [VAL_LENGTH - 1: 0] )
        );

initial begin
    $dumpfile("pid_tb.vcd");
    $dumpvars();
    #1000;
    $finish();
    $stop();
end

endmodule



