`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/02/08 18:19:00
// Design Name:
// Module Name: pwm_generator
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

/* PWM输出模块 */
module pwm_generator(
           input clk, //时钟信号
           input enable,  //使能信号
           input _rst,  //复位信号
           input [31: 0] duty_cycle,  //占空比控制信号

           output pwm_out,  //正相输出
           output _pwm_out //互补输出
       );

reg [31: 0] cnt; //计数器计数值

//根据占空比和计数值之间的大小关系来输出PWM信号
assign pwm_out = (cnt >= duty_cycle) ? 1'b1 : 1'b0;
assign _pwm_out = (cnt <= duty_cycle) ? 1'b1 : 1'b0;

//周期计数器
always @(posedge clk or negedge _rst) begin
    if (!_rst)
        cnt <= 32'd0;
    else begin
        if (enable) begin
            cnt <= cnt + 32'b1;
        end
    end
end

endmodule
