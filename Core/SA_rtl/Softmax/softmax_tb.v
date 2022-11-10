`timescale  1ns / 1ps
`include "softmax.v"

module softmax_tb();
parameter BITWIDTH = 8;
parameter CLASSES = 10;
parameter INDEX_WIDTH = 4;

// softmax Inputs
reg clk = 0;
reg rst_n = 0;
reg valid = 0;
reg [BITWIDTH * CLASSES - 1: 0] data_i = 0;

// softmax Outputs
wire ready;
wire [INDEX_WIDTH - 1: 0] position_o;

initial begin
    forever
        #2 clk = ~clk;
end

initial begin

    data_i = {8'h01, 8'h05, 8'h03, 8'h08, 8'h09, 8'h08, 8'h02, 8'h06, 8'h04, 8'h07};
    data_i = {8'h01, 8'h05, 8'h03, 8'h08, 8'h09, 8'h08, 8'h02, 8'h06, 8'h04, 8'h07};
    #5;

end

integer stage = 0;
always @(posedge clk) begin
    case (stage)
        0: begin
            rst_n = 1'b1;
            stage = 1;
        end
        1: begin
            data_i = {8'h01, 8'h02, 8'h03, 8'h08, 8'h07, 8'h03, 8'h02, 8'h05, 8'h00, 8'h09};
            valid = 1'b1;
            stage = 2;
        end
        2: begin
            stage = 3;
        end
        3: begin
            stage = 4;
        end
        4: begin
            if (ready) begin
                valid = 1'b0;
                data_i = 0;
                $display(position_o);
                stage = 5;
            end
            else begin
                stage = 4;
            end
        end
        5: begin
            stage = 5;
        end
        default: begin
            stage = 5;
        end
    endcase
end

initial begin
    $dumpfile("softmax_tb.vcd");
    $dumpvars();
    #1000;
    $finish;
end

softmax #(
            .BITWIDTH ( BITWIDTH ),
            .CLASSES ( CLASSES ),
            .INDEX_WIDTH ( INDEX_WIDTH )
            )
        u_softmax(
            //ports
            .clk ( clk ),
            .rst_n ( rst_n ),
            .valid ( valid ),
            .ready ( ready ),
            .data_i ( data_i ),
            .position_o ( position_o )
        );


endmodule
