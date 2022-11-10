`timescale 1ns / 1ps


//50Hz, T=20ms
module pid_tim #(
           parameter CLK_VAL_MHZ = 50
       )(
           input wire sys_clk,
           input wire sys_rst_n,
           input wire [15: 0] ctrl_value,
           output wire pwm
       );
localparam MAX_VAL = 1_000_000;

//divider xMHz -> x/x==1MHz
reg [7: 0] div_cnt;
reg div_clk;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        div_cnt <= 8'b0;
        div_clk <= 1'b0;
    end
    else begin
        if (div_cnt >= CLK_VAL_MHZ) begin
            div_cnt <= 8'b0; //exceed
            div_clk <= 1'b1; //trigger every 1us
        end
        else begin
            div_cnt <= div_cnt + 1'b1;
            div_clk <= 1'b0;
        end
    end
end

//driver pwm
reg [31: 0] cnt;
wire [31: 0] ctrl_value_extend;

assign ctrl_value_extend = {16'b0, ctrl_value};
assign pwm = (cnt <= ctrl_value_extend) ? 1'b1 : 1'b0;
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        cnt <= 32'b0;
    end
    else begin
        if (cnt >= MAX_VAL) begin
            cnt <= 32'b0; //exceed
        end
        else begin
            if (div_clk) begin
                cnt <= cnt + 1'b1;
            end
            else begin
                cnt <= cnt;
            end
        end
    end
end
endmodule
