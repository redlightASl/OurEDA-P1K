`timescale 1ns/1ps


module gpio #(
           parameter GPIO_PORT_NUM = 32
       )(
           input wire sys_clk,
           input wire sys_rst_n,

           input wire [GPIO_PORT_NUM - 1: 0] ctrl_in_sel,  //0, out; 1, in(hi-z)
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_af_sel,  //0, normal-io; 1, alter-function
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_od_sel,  //0, push-pull; 1, open-drain
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_lo_sel,  //0, no latch; 1, latch

           input wire [GPIO_PORT_NUM - 1: 0] ctrl_af_in,  //0, no af; 1, af pin out

           input wire [GPIO_PORT_NUM - 1: 0] gpio_output,  //output data register,wr
           output wire [GPIO_PORT_NUM - 1: 0] gpio_input,  //input data register,r

           inout wire [GPIO_PORT_NUM - 1: 0] io
       );
reg [GPIO_PORT_NUM - 1: 0] in_reg;

wire [GPIO_PORT_NUM - 1: 0] out_wire;
wire [GPIO_PORT_NUM - 1: 0] out_wire_t;

genvar i;

generate
    for (i = 0;i < GPIO_PORT_NUM - 1;i = i + 1) begin
        assign io[i] = ctrl_in_sel[i] ? 1'bz : out_wire[i]; //IO pin control

        assign out_wire[i] = ctrl_af_sel[i] ? ctrl_af_in[i] : out_wire_t[i]; //alter function

        always @(posedge sys_clk or negedge sys_rst_n) begin //open-drain control
            if (!sys_rst_n) begin
                out_wire_t[i] <= gpio_output[i];
            end
            else begin
                if (ctrl_od_sel[i]) begin
                    out_wire_t[i] <= ~gpio_output[i];
                end
                else begin
                    out_wire_t[i] <= ~gpio_output[i];
                end
            end
        end

        assign gpio_input[i] = in_reg[i];

        always @(posedge sys_clk or negedge sys_rst_n) begin //lock select
            if (!sys_rst_n) begin
                in_reg[i] <= io[i];
            end
            else begin
                if (ctrl_lo_sel[i]) begin
                    in_reg[i] <= in_reg[i];
                end
                else begin
                    in_reg[i] <= io[i];
                end
            end
        end
    end
endgenerate
endmodule
