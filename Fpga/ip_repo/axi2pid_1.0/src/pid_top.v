`timescale 1ns / 1ps 
// `define USING_INNER_PWM
`include "pid_error.v"
`include "pid_inc_value.v"
`include "pid_value.v"

module pid_top #(
           parameter CLK_VAL_MHZ = 50,
           parameter VAL_LENGTH = 32
       )(
           input sys_clk,
           input sys_rst_n,

           input wire signed [VAL_LENGTH - 1: 0] target,
           input wire signed [VAL_LENGTH - 1: 0] current_value,
           input wire signed [VAL_LENGTH - 1: 0] int_max,
           input wire signed [VAL_LENGTH - 1: 0] int_min,
           input wire signed [VAL_LENGTH - 1: 0] dif_max,
           input wire signed [VAL_LENGTH - 1: 0] dif_min,
           input wire signed [VAL_LENGTH - 1: 0] uk_max,
           input wire signed [VAL_LENGTH - 1: 0] uk_min,
           input wire signed [VAL_LENGTH - 1: 0] kp,
           input wire signed [VAL_LENGTH - 1: 0] ki,
           input wire signed [VAL_LENGTH - 1: 0] kd,
           output wire signed [VAL_LENGTH - 1: 0] pid_out
       );
wire signed [VAL_LENGTH - 1: 0] ek0;
wire signed [VAL_LENGTH - 1: 0] ek1;
wire signed [VAL_LENGTH - 1: 0] ek2;
wire signed [VAL_LENGTH - 1: 0] int_value;
wire signed [VAL_LENGTH - 1: 0] dif_value;

PID_error #(
              .VAL_LENGTH ( VAL_LENGTH ))
          u_PID_error(
              //ports
              .sys_clk ( sys_clk ),
              .sys_rst_n ( sys_rst_n ),
              .target ( target ),
              .current_value ( current_value ),
              .ek0 ( ek0 ),
              .ek1 ( ek1 )
          );

PID_incr_value #(
                   .VAL_LENGTH ( VAL_LENGTH ))
               u_PID_incr_value(
                   //ports
                   .sys_clk ( sys_clk ),
                   .sys_rst_n ( sys_rst_n ),
                   .ek0 ( ek0 ),
                   .ek1 ( ek1 ),
                   .int_max ( int_max ),
                   .int_min ( int_min ),
                   .dif_max ( dif_max ),
                   .dif_min ( dif_min ),
                   .int_val_f ( int_value ),
                   .dif_val_f ( dif_value )
               );

PID_value #(
              .VAL_LENGTH ( VAL_LENGTH ))
          u_PID_value(
              //ports
              .sys_clk ( sys_clk ),
              .sys_rst_n ( sys_rst_n ),
              .err_val ( ek0 ),
              .int_val ( int_value ),
              .dif_val ( dif_value ),
              .uk_max(uk_max),
              .uk_min(uk_min),
              .kp ( kp ),
              .ki ( ki ),
              .kd ( kd ),
              .uk ( pid_out )
          );

// `ifdef USING_INNER_PWM
// pid_tim #(
//             .CLK_VAL_MHZ ( CLK_VAL_MHZ ))
//         u_pid_tim0(
//             //ports
//             .sys_clk ( sys_clk ),
//             .sys_rst_n ( sys_rst_n ),
//             .ctrl_value (  ),
//             .pwm ( pwm[0] )
//         );
// pid_tim #(
//             .CLK_VAL_MHZ ( CLK_VAL_MHZ ))
//         u_pid_tim1(
//             //ports
//             .sys_clk ( sys_clk ),
//             .sys_rst_n ( sys_rst_n ),
//             .ctrl_value (  ),
//             .pwm ( pwm[1] )
//         );
// pid_tim #(
//             .CLK_VAL_MHZ ( CLK_VAL_MHZ ))
//         u_pid_tim2(
//             //ports
//             .sys_clk ( sys_clk ),
//             .sys_rst_n ( sys_rst_n ),
//             .ctrl_value (  ),
//             .pwm ( pwm[2] )
//         );
// pid_tim #(
//             .CLK_VAL_MHZ ( CLK_VAL_MHZ ))
//         u_pid_tim3(
//             //ports
//             .sys_clk ( sys_clk ),
//             .sys_rst_n ( sys_rst_n ),
//             .ctrl_value (  ),
//             .pwm ( pwm[3] )
//         );
// `endif

endmodule
