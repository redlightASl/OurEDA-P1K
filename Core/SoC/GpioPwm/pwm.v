`timescale 1ns/1ps


module pwm #(
           parameter CNT_LENGTH = 16
       )(
           input wire sys_clk,
           input wire sys_rst_n,
           input wire sys_en,
           input wire [CNT_LENGTH - 1: 0] max_val,
           input wire [CNT_LENGTH - 1: 0] duty_cycle,

           output wire pwm_pos,
           output wire pwm_neg
       );
reg [CNT_LENGTH - 1: 0] cnt;

assign pwm_pos = (cnt >= duty_cycle) ? 1'b1 : 1'b0;
assign pwm_neg = (cnt < duty_cycle) ? 1'b1 : 1'b0;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        cnt <= {CNT_LENGTH{1'b0}};
    end
    else begin
        if (sys_en) begin
            if (cnt >= max_val) begin
                cnt <= {CNT_LENGTH{1'b0}}; //exceed
            end
            else begin
                cnt <= cnt + 1'b1;
            end
        end
        else begin
            cnt <= {CNT_LENGTH{1'b0}};
        end
    end
end

endmodule
