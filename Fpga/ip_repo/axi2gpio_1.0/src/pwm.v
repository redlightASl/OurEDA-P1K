`timescale 1ns/1ps


module pwm #(
           parameter CNT_LENGTH = 16
       )(
           input wire pwm_clk,
           input wire pwm_rst_n,
           input wire pwm_en,
           input wire [CNT_LENGTH - 1: 0] max_val,
           input wire [CNT_LENGTH - 1: 0] duty_cycle,

           output wire pwm_pos,
           output wire pwm_neg
       );
reg [CNT_LENGTH - 1: 0] cnt;

assign pwm_pos = (cnt >= duty_cycle) ? 1'b1 : 1'b0;
assign pwm_neg = (cnt < duty_cycle) ? 1'b1 : 1'b0;

always @(posedge pwm_clk or negedge pwm_rst_n) begin
    if (!pwm_rst_n) begin
        cnt <= {CNT_LENGTH{1'b0}};
    end
    else begin
        if (pwm_en) begin
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
