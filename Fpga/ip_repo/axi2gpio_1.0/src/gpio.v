`timescale 1ns/1ps


module gpio #(
           parameter GPIO_PORT_NUM = 32
       )(
           input wire sys_clk,
           input wire sys_rst_n,

        //    input wire [GPIO_PORT_NUM - 1: 0] ctrl_in_sel,  //0, out; 1, in(hi-z)
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_af_sel,  //0, normal-io; 1, alter-function
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_od_sel,  //0, push-pull; 1, open-drain
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_lo_sel,  //0, no latch; 1, latch

           input wire [GPIO_PORT_NUM - 1: 0] ctrl_af_in,  //0, no af; 1, af pin out

           input wire [GPIO_PORT_NUM - 1: 0] gpio_output_val,  //output data register, wr
           output wire [GPIO_PORT_NUM - 1: 0] gpio_input_val,  //input data register, r

           input wire [GPIO_PORT_NUM - 1: 0] io_pin_in, //input pin
           output wire [GPIO_PORT_NUM - 1: 0] io_pin_out //output pin
       );
reg [GPIO_PORT_NUM - 1: 0] gpio_input_reg;
reg [GPIO_PORT_NUM - 1: 0] gpio_output_reg;

genvar i;
generate
    for (i = 0;i < GPIO_PORT_NUM - 1;i = i + 1) begin
        assign io_pin_out[i] = ctrl_af_sel[i] ? ctrl_af_in[i] : gpio_output_reg[i]; //alter function control

        always @(posedge sys_clk or negedge sys_rst_n) begin //open-drain control
            if (!sys_rst_n) begin
                gpio_output_reg[i] <= gpio_output_val[i];
            end
            else begin
                if (ctrl_od_sel[i]) begin
                    gpio_output_reg[i] <= ~gpio_output_val[i];
                end
                else begin
                    gpio_output_reg[i] <= gpio_output_val[i];
                end
            end
        end

        assign gpio_input_val[i] = gpio_input_reg[i]; //input driver wire

        always @(posedge sys_clk or negedge sys_rst_n) begin //lock control
            if (!sys_rst_n) begin
                gpio_input_reg[i] <= io_pin_in[i];
            end
            else begin
                if (ctrl_lo_sel[i]) begin
                    gpio_input_reg[i] <= gpio_input_reg[i];
                end
                else begin
                    gpio_input_reg[i] <= io_pin_in[i];
                end
            end
        end
    end
endgenerate
endmodule
