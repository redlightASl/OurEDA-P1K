`timescale 1ns / 1ps
`include "pwm.v"
// `define DUMP_VCD 

module pwm_tb();

// pwm Parameters
parameter PERIOD = 10;
parameter CNT_LENGTH = 16;

// pwm Inputs
reg pwm_clk = 0;
reg pwm_rst_n = 0;
reg pwm_en = 0;
reg [CNT_LENGTH - 1: 0] max_val = 0;
reg [CNT_LENGTH - 1: 0] duty_cycle = 0;

// pwm Outputs
wire pwm_pos;
wire pwm_neg;


initial begin
    forever
        #(PERIOD / 2) pwm_clk = ~pwm_clk;
end


integer stage = 0;
always @(posedge pwm_clk) begin
    case (stage)
        0: begin
            pwm_rst_n = 1'b0;
            stage = 1;
        end
        1: begin
            pwm_rst_n = 1'b1;
            stage = 2;
        end
        2: begin
            max_val=16'd1000;
            duty_cycle=16'd500;
            pwm_en = 1'b1;
            stage = 2;
        end
        default: begin
            stage = 0;
        end
    endcase
end

pwm #(
        .CNT_LENGTH ( CNT_LENGTH ))
    u_pwm_inst (
        .pwm_clk ( pwm_clk ),
        .pwm_rst_n ( pwm_rst_n ),
        .pwm_en ( pwm_en ),
        .max_val ( max_val [CNT_LENGTH - 1: 0] ),
        .duty_cycle ( duty_cycle [CNT_LENGTH - 1: 0] ),

        .pwm_pos ( pwm_pos ),
        .pwm_neg ( pwm_neg )
    );

integer p=0;
integer q=0;
initial begin
`ifdef DUMP_VCD
    $dumpfile("pwm_tb.vcd");
    $dumpvars();
`endif
    
    forever begin
        #1;
        if(u_pwm_inst.cnt == 300) begin
            $display(pwm_pos);
            p=p+1;
        end
        else if(u_pwm_inst.cnt == 600) begin
            $display(pwm_pos);
            q=q+1;
        end
        else if(u_pwm_inst.cnt >= 800) begin
            $display(p,q);
            $finish();
        end
    end
end

endmodule
