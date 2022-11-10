`timescale 1ns / 1ps
`include "pid_tim.v"

module pid_tim_tb();

// pid_tim Parameters
parameter PERIOD = 10;
parameter CLK_VAL_MHZ = 50;

// pid_tim Inputs
reg sys_clk = 0 ;
reg sys_rst_n = 0 ;
reg [15: 0] ctrl_value = 0 ;

// pid_tim Outputs
wire pwm ;


initial begin
    forever
        #(PERIOD / 2) sys_clk = ~sys_clk;
end


integer stage = 0;
always @(posedge sys_clk) begin
    case (stage)
        0: begin
            sys_rst_n = 1'b0;
            ctrl_value = 1500;
            stage = 1;
        end
        1: begin
            sys_rst_n = 1'b1;

            stage = 2;
        end
        2: begin
            stage = 2;
        end
        default: begin
            stage = 0;
        end
    endcase
end

pid_tim #(
            .CLK_VAL_MHZ ( CLK_VAL_MHZ ))
        u_pid_tim_inst (
            .sys_clk ( sys_clk ),
            .sys_rst_n ( sys_rst_n ),
            .ctrl_value ( ctrl_value [15: 0] ),

            .pwm ( pwm )
        );

integer i = 0;
initial begin
    $dumpfile("pwm_tb.vcd");
    $dumpvars();
    for (i = 0;i < 10;i = i + 1) begin
        #1000;
    end
    $finish();
    $stop();
end

endmodule
