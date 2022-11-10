`timescale 1ns / 1ps

//find the max value's position
module softmax#(
           parameter BITWIDTH = 8,
           parameter INDEX_WIDTH = 4,
           parameter CLASSES = 10
       )(
           input wire clk,
           input wire rst_n,

           input wire valid,
           output reg ready,

           input signed [BITWIDTH * CLASSES - 1: 0] data_i,
           output reg [INDEX_WIDTH - 1: 0] position_o
       );
localparam IDLE = 2'b01;
localparam BUSY = 2'b10;

//main counter
reg [INDEX_WIDTH - 1: 0] cnt;
reg done;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= {INDEX_WIDTH{1'b0}};
        done <= 1'b0;
    end
    else begin
        if (cnt >= CLASSES) begin
            cnt <= {INDEX_WIDTH{1'b0}};
            done <= 1'b1;
        end
        else begin
            cnt <= cnt + 'd1;
            done <= 1'b0;
        end
    end
end

//FSM
reg [1: 0] current_state;
reg [1: 0] next_state;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current_state <= IDLE;
    end
    else begin
        current_state <= next_state;
    end
end

always @( * ) begin
    case (current_state)
        IDLE: begin
            if (valid) begin //got posedge of valid signal
                next_state = BUSY;
            end
            else begin
                next_state = IDLE;
            end
        end
        BUSY: begin
            if (done) begin //done after all data were scanned
                next_state = IDLE;
            end
            else begin
                next_state = BUSY;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ready <= 1'b1;
    end
    else begin
        if (current_state == IDLE) begin
            ready <= 1'b1;
        end
        else begin
            ready <= 1'b0;
        end
    end
end

//compare logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        position_o <= {INDEX_WIDTH{1'b0}};
    end
    else begin
        if (data_i[(BITWIDTH * CLASSES - 1) - (cnt * BITWIDTH) -: BITWIDTH] > data_i[(BITWIDTH * CLASSES - 1) - (position_o * BITWIDTH) -: BITWIDTH]) begin
            position_o <= cnt;
        end
        else if(ready) begin
            position_o <= {INDEX_WIDTH{1'b0}};
        end
        else begin
            position_o <= position_o;
        end
    end
end

endmodule
