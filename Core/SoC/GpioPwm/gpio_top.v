`timescale 1ns / 1ps


module gpio_top#(
           parameter GPIO_PORT_NUM = 32,
           parameter CNT_LENGTH = 16,
           parameter TIM_NUM = 8
       )(
           input wire sys_clk,
           input wire sys_rst_n,

           input wire [TIM_NUM - 1: 0] pwm_en,
           input wire [CNT_LENGTH - 1: 0] max_val_0,
           input wire [CNT_LENGTH - 1: 0] max_val_1,
           input wire [CNT_LENGTH - 1: 0] max_val_2,
           input wire [CNT_LENGTH - 1: 0] max_val_3,
           input wire [CNT_LENGTH - 1: 0] max_val_4,
           input wire [CNT_LENGTH - 1: 0] max_val_5,
           input wire [CNT_LENGTH - 1: 0] max_val_6,
           input wire [CNT_LENGTH - 1: 0] max_val_7,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_0,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_1,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_2,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_3,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_4,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_5,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_6,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_7,
           input wire [CNT_LENGTH - 1: 0] duty_cycle_8,

           input wire [GPIO_PORT_NUM - 1: 0] ctrl_in_sel,
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_af_sel,
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_od_sel,
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_lo_sel,
           input wire [GPIO_PORT_NUM - 1: 0] ctrl_af_in,
           input wire [GPIO_PORT_NUM - 1: 0] gpio_output,
           output wire [GPIO_PORT_NUM - 1: 0] gpio_input,
           inout wire [GPIO_PORT_NUM - 1: 0] io
       );

wire [TIM_NUM - 1: 0] pwm_pos;
wire [TIM_NUM - 1: 0] pwm_neg;

reg [GPIO_PORT_NUM - TIM_NUM - TIM_NUM - TIM_NUM - 1: 0] gpio_af_low;
reg [GPIO_PORT_NUM - TIM_NUM - TIM_NUM - TIM_NUM - 1: 0] gpio_af_high;
assign gpio_af_low = 'b0;
assign gpio_af_high = 'b1;

pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_0 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[0]),
        .max_val(max_val_0),
        .duty_cycle(duty_cycle_0),
        .pwm_pos(pwm_pos[0]),
        .pwm_neg(pwm_neg[0])
    );
pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_1 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[1]),
        .max_val(max_val_1),
        .duty_cycle(duty_cycle_1),
        .pwm_pos(pwm_pos[1]),
        .pwm_neg(pwm_neg[1])
    );
pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_2 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[2]),
        .max_val(max_val_2),
        .duty_cycle(duty_cycle_2),
        .pwm_pos(pwm_pos[2]),
        .pwm_neg(pwm_neg[2])
    );
pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_3 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[3]),
        .max_val(max_val_3),
        .duty_cycle(duty_cycle_3),
        .pwm_pos(pwm_pos[3]),
        .pwm_neg(pwm_neg[3])
    );
pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_4 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[4]),
        .max_val(max_val_4),
        .duty_cycle(duty_cycle_4),
        .pwm_pos(pwm_pos[4]),
        .pwm_neg(pwm_neg[4])
    );
pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_5 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[5]),
        .max_val(max_val_5),
        .duty_cycle(duty_cycle_5),
        .pwm_pos(pwm_pos[5]),
        .pwm_neg(pwm_neg[5])
    );
pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_6 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[6]),
        .max_val(max_val_6),
        .duty_cycle(duty_cycle_6),
        .pwm_pos(pwm_pos[6]),
        .pwm_neg(pwm_neg[6])
    );
pwm #(
        .CNT_LENGTH(CNT_LENGTH)
    ) pwm_tim_7 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .sys_en(pwm_en[7]),
        .max_val(max_val_7),
        .duty_cycle(duty_cycle_7),
        .pwm_pos(pwm_pos[7]),
        .pwm_neg(pwm_neg[7])
    );

//pwm_pos pwm_neg low high
//8bits 8bits 8bits 8bits
gpio #(
         .GPIO_PORT_NUM(GPIO_PORT_NUM)
     )gpio_inst(
         .sys_clk(sys_clk),
         .sys_rst_n(sys_rst_n),

         .ctrl_in_sel(ctrl_in_sel),
         .ctrl_af_sel(ctrl_af_sel),
         .ctrl_od_sel(ctrl_od_sel),
         .ctrl_lo_sel(ctrl_lo_sel),
         .ctrl_af_in({pwm_pos, pwm_neg, gpio_af_low, gpio_af_high}),
         .gpio_output(gpio_output),
         .gpio_input(gpio_input),
         .io(io)
     );


endmodule
