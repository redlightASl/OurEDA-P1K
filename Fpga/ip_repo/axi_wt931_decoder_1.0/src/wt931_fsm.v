`timescale 1ns/1ps

module wt931_fsm
       #(
           parameter CLK_FRE = 50,
           parameter BAUD_RATE = 115200
       )
       (
           input wire clk,
           input wire rst_n,

           input wire rxd_pin,

           output reg [15: 0] data_acc_x,
           output reg [15: 0] data_acc_y,
           output reg [15: 0] data_acc_z,
           output reg [15: 0] data_rot_x,
           output reg [15: 0] data_rot_y,
           output reg [15: 0] data_rot_z,
           output reg [15: 0] data_eul_x,
           output reg [15: 0] data_eul_y,
           output reg [15: 0] data_eul_z,
           output reg [15: 0] data_mag_x,
           output reg [15: 0] data_mag_y,
           output reg [15: 0] data_mag_z,
           output reg [15: 0] data_tem
       );

localparam STATE_IDLE = 3'b001;
localparam STATE_RECV = 3'b010;
localparam STATE_CALC = 3'b100;

localparam ST_FRAME_HEAD = 5'b00001;
localparam ST_REC_CODE = 5'b00010;
localparam ST_FETCH = 5'b00100;
localparam ST_SUMCHECK = 5'b01000;
localparam ST_WRITE_BACK = 5'b10000;

localparam DATA_ERR = 4'b0000;
localparam DATA_ACC = 4'b0001;
localparam DATA_ROT = 4'b0010;
localparam DATA_EUL = 4'b0100;
localparam DATA_MAG = 4'b1000;

reg [2: 0] state = STATE_IDLE;
reg [4: 0] wt931_state = ST_FRAME_HEAD;
reg [3: 0] data_kind_flag = DATA_ERR;
reg [2: 0] fetch_cnt = 3'b0;

reg rx_en;
wire rx_ready;
wire [7: 0] recv_wire;
reg [7: 0] data_recv;

reg [15: 0] acc_x;
reg [15: 0] acc_y;
reg [15: 0] acc_z;
reg [15: 0] acc_temp;
reg [15: 0] rot_x;
reg [15: 0] rot_y;
reg [15: 0] rot_z;
reg [15: 0] rot_temp;
reg [15: 0] eul_x;
reg [15: 0] eul_y;
reg [15: 0] eul_z;
reg [15: 0] eul_temp;
reg [15: 0] mag_x;
reg [15: 0] mag_y;
reg [15: 0] mag_z;
reg [15: 0] mag_temp;

//1 stage FSM
always @(posedge clk) begin
    if (!rst_n) begin
        data_acc_x <= 16'b0;
        data_acc_y <= 16'b0;
        data_acc_z <= 16'b0;
        data_rot_x <= 16'b0;
        data_rot_y <= 16'b0;
        data_rot_z <= 16'b0;
        data_eul_x <= 16'b0;
        data_eul_y <= 16'b0;
        data_eul_z <= 16'b0;
        data_mag_x <= 16'b0;
        data_mag_y <= 16'b0;
        data_mag_z <= 16'b0;
        data_tem <= 16'b0;

        acc_x <= 16'b0;
        acc_y <= 16'b0;
        acc_z <= 16'b0;
        acc_temp <= 16'b0;
        rot_x <= 16'b0;
        rot_y <= 16'b0;
        rot_z <= 16'b0;
        rot_temp <= 16'b0;
        eul_x <= 16'b0;
        eul_y <= 16'b0;
        eul_z <= 16'b0;
        eul_temp <= 16'b0;
        mag_x <= 16'b0;
        mag_y <= 16'b0;
        mag_z <= 16'b0;
        mag_temp <= 16'b0;

        rx_en <= 1'b0;
        data_recv <= 8'b0;
        state <= STATE_IDLE;

        fetch_cnt <= 3'b0;
        data_kind_flag <= DATA_ERR;
        wt931_state <= ST_FRAME_HEAD;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                // if (rx_ready) begin
                //     state <= STATE_CALC;
                //     data_recv <= recv_wire;
                //     rx_en <= 1'b1; //read uart
                // end
                // else begin
                //     state <= STATE_IDLE;
                //     data_recv <= data_recv;
                //     rx_en <= 1'b0; //read uart
                // end
                state <= STATE_RECV;
            end
            STATE_RECV: begin
                // rx_en <= 1'b0; //read uart done
                // state <= STATE_CALC;
                if (rx_ready) begin
                    state <= STATE_CALC;
                    data_recv <= recv_wire;
                    rx_en <= 1'b1; //read uart
                end
                else begin
                    state <= STATE_RECV;
                    data_recv <= data_recv;
                    rx_en <= 1'b0; //read uart
                end
            end
            STATE_CALC: begin //deal with number analysis
                rx_en <= 1'b0; //read uart done //!
                state <= STATE_IDLE; //calculate one byte once
                case (wt931_state)
                    ST_FRAME_HEAD: begin //recv '0x55'
                        if (data_recv == 8'h55) begin
                            wt931_state <= ST_REC_CODE;
                        end
                        else begin
                            wt931_state <= ST_FRAME_HEAD;
                        end
                    end
                    ST_REC_CODE: begin //check data belonging
                        case (data_recv)
                            8'h51: begin //acc
                                data_kind_flag <= DATA_ACC;
                                wt931_state <= ST_FETCH;
                            end
                            8'h52: begin //rot
                                data_kind_flag <= DATA_ROT;
                                wt931_state <= ST_FETCH;
                            end
                            8'h53: begin //eul
                                data_kind_flag <= DATA_EUL;
                                wt931_state <= ST_FETCH;
                            end
                            8'h54: begin //mag
                                data_kind_flag <= DATA_MAG;
                                wt931_state <= ST_FETCH;
                            end
                            default: begin //no correct recognize-code
                                data_kind_flag <= DATA_ERR;
                                wt931_state <= ST_FRAME_HEAD;
                            end
                        endcase
                    end
                    ST_FETCH: begin
                        case (data_kind_flag)
                            DATA_ACC: begin //acc data
                                case (fetch_cnt)
                                    3'b000: begin
                                        acc_x[7: 0] <= data_recv;
                                    end
                                    3'b001: begin
                                        acc_x[15: 8] <= data_recv;
                                    end
                                    3'b010: begin
                                        acc_y[7: 0] <= data_recv;
                                    end
                                    3'b011: begin
                                        acc_y[15: 8] <= data_recv;
                                    end
                                    3'b100: begin
                                        acc_z[7: 0] <= data_recv;
                                    end
                                    3'b101: begin
                                        acc_z[15: 8] <= data_recv;
                                    end
                                    3'b110: begin
                                        acc_temp[7: 0] <= data_recv;
                                    end
                                    3'b111: begin
                                        acc_temp[15: 8] <= data_recv;
                                    end
                                    default: begin
                                    end
                                endcase
                            end
                            DATA_ROT: begin
                                case (fetch_cnt) //rot data
                                    3'b000: begin
                                        rot_x[7: 0] <= data_recv;
                                    end
                                    3'b001: begin
                                        rot_x[15: 8] <= data_recv;
                                    end
                                    3'b010: begin
                                        rot_y[7: 0] <= data_recv;
                                    end
                                    3'b011: begin
                                        rot_y[15: 8] <= data_recv;
                                    end
                                    3'b100: begin
                                        rot_z[7: 0] <= data_recv;
                                    end
                                    3'b101: begin
                                        rot_z[15: 8] <= data_recv;
                                    end
                                    3'b110: begin
                                        rot_temp[7: 0] <= data_recv;
                                    end
                                    3'b111: begin
                                        rot_temp[15: 8] <= data_recv;
                                    end
                                    default: begin
                                    end
                                endcase
                            end
                            DATA_EUL: begin
                                case (fetch_cnt) //eul data
                                    3'b000: begin
                                        eul_x[7: 0] <= data_recv;
                                    end
                                    3'b001: begin
                                        eul_x[15: 8] <= data_recv;
                                    end
                                    3'b010: begin
                                        eul_y[7: 0] <= data_recv;
                                    end
                                    3'b011: begin
                                        eul_y[15: 8] <= data_recv;
                                    end
                                    3'b100: begin
                                        eul_z[7: 0] <= data_recv;
                                    end
                                    3'b101: begin
                                        eul_z[15: 8] <= data_recv;
                                    end
                                    3'b110: begin
                                        eul_temp[7: 0] <= data_recv;
                                    end
                                    3'b111: begin
                                        eul_temp[15: 8] <= data_recv;
                                    end
                                    default: begin
                                    end
                                endcase
                            end
                            DATA_MAG: begin
                                case (fetch_cnt) //mag data
                                    3'b000: begin
                                        mag_x[7: 0] <= data_recv;
                                    end
                                    3'b001: begin
                                        mag_x[15: 8] <= data_recv;
                                    end
                                    3'b010: begin
                                        mag_y[7: 0] <= data_recv;
                                    end
                                    3'b011: begin
                                        mag_y[15: 8] <= data_recv;
                                    end
                                    3'b100: begin
                                        mag_z[7: 0] <= data_recv;
                                    end
                                    3'b101: begin
                                        mag_z[15: 8] <= data_recv;
                                    end
                                    3'b110: begin
                                        mag_temp[7: 0] <= data_recv;
                                    end
                                    3'b111: begin
                                        mag_temp[15: 8] <= data_recv;
                                    end
                                    default: begin
                                    end
                                endcase
                            end
                            default: begin //data error, restart
                                wt931_state <= ST_FRAME_HEAD; 
                            end
                        endcase
                        if (fetch_cnt == 3'b111) begin
                            wt931_state <= ST_SUMCHECK;
                            fetch_cnt <= 3'b0;
                        end
                        else begin
                            wt931_state <= ST_FETCH;
                            fetch_cnt <= fetch_cnt + 1'd1;
                        end
                    end
                    ST_SUMCHECK: begin
                        // case (data_kind_flag)
                        //     DATA_ACC: begin //acc
                        //         sum_check_byte <= 8'h55 + 8'h51 + acc_x[15: 8] + acc_x[7: 0] + acc_y[15: 8] + acc_y[7: 0] + acc_z[15: 8] + acc_z[7: 0] + acc_temp[15: 8] + acc_temp[7: 0];
                        //     end
                        //     DATA_ROT: begin //rot
                        //         sum_check_byte <= 8'h55 + 8'h51 + rot_x[15: 8] + rot_x[7: 0] + rot_y[15: 8] + rot_y[7: 0] + rot_z[15: 8] + rot_z[7: 0] + rot_temp[15: 8] + rot_temp[7: 0];
                        //     end
                        //     DATA_EUL: begin //eul
                        //         sum_check_byte <= 8'h55 + 8'h51 + eul_x[15: 8] + eul_x[7: 0] + eul_y[15: 8] + eul_y[7: 0] + eul_z[15: 8] + eul_z[7: 0] + eul_temp[15: 8] + eul_temp[7: 0];
                        //     end
                        //     DATA_MAG: begin //mag
                        //         sum_check_byte <= 8'h55 + 8'h51 + mag_x[15: 8] + mag_x[7: 0] + mag_y[15: 8] + mag_y[7: 0] + mag_z[15: 8] + mag_z[7: 0] + mag_temp[15: 8] + mag_temp[7: 0];
                        //     end
                        //     default: begin
                        //         sum_check_byte <= 8'h00;
                        //     end
                        // endcase
                        // if (data_recv == sum_check_byte) begin
                        //     wt931_state <= ST_WRITE_BACK;
                        // end
                        // else begin
                        //     wt931_state <= ST_FRAME_HEAD; //error data, re-recv
                        // end
                        //?do not check data
                        wt931_state <= ST_WRITE_BACK;
                    end
                    ST_WRITE_BACK: begin
                        case (data_kind_flag)
                            DATA_ACC: begin //acc
                                data_acc_x <= acc_x;
                                data_acc_y <= acc_y;
                                data_acc_z <= acc_z;
                                data_tem <= acc_temp;
                            end
                            DATA_ROT: begin //rot
                                data_rot_x <= rot_x;
                                data_rot_y <= rot_y;
                                data_rot_z <= rot_z;
                                data_tem <= rot_temp;
                            end
                            DATA_EUL: begin //eul
                                data_eul_x <= eul_x;
                                data_eul_y <= eul_y;
                                data_eul_z <= eul_z;
                                data_tem <= eul_temp;
                            end
                            DATA_MAG: begin //mag
                                data_mag_x <= mag_x;
                                data_mag_y <= mag_y;
                                data_mag_z <= mag_z;
                                data_tem <= mag_temp;
                            end
                            default: begin
                            end
                        endcase
                        wt931_state <= ST_FRAME_HEAD; //successful recv
                    end
                    default: begin
                        wt931_state <= ST_FRAME_HEAD;
                    end
                endcase
            end
            default: begin
                data_acc_x <= 16'b0;
                data_acc_y <= 16'b0;
                data_acc_z <= 16'b0;
                data_rot_x <= 16'b0;
                data_rot_y <= 16'b0;
                data_rot_z <= 16'b0;
                data_eul_x <= 16'b0;
                data_eul_y <= 16'b0;
                data_eul_z <= 16'b0;
                data_mag_x <= 16'b0;
                data_mag_y <= 16'b0;
                data_mag_z <= 16'b0;
                data_tem <= 16'b0;

                acc_x <= 16'b0;
                acc_y <= 16'b0;
                acc_z <= 16'b0;
                acc_temp <= 16'b0;
                rot_x <= 16'b0;
                rot_y <= 16'b0;
                rot_z <= 16'b0;
                rot_temp <= 16'b0;
                eul_x <= 16'b0;
                eul_y <= 16'b0;
                eul_z <= 16'b0;
                eul_temp <= 16'b0;
                mag_x <= 16'b0;
                mag_y <= 16'b0;
                mag_z <= 16'b0;
                mag_temp <= 16'b0;

                rx_en <= 1'b0;
                data_recv <= 8'b0;
                state <= STATE_IDLE;

                fetch_cnt <= 3'b0;
                data_kind_flag <= DATA_ERR;
                wt931_state <= ST_FRAME_HEAD;
            end
        endcase
    end
end

wire uart_rx_clk;
uart_clk_gen #(
                 .CLK_FRE ( CLK_FRE ),
                 .BAUD_RATE ( BAUD_RATE ))
             u_uart_clk_gen(
                 //ports
                 .sys_clk ( clk ),
                 .sys_rst_n ( rst_n ),
                 .uart_rx_clk ( uart_rx_clk ),
                 .uart_tx_clk ( )
             );

uart_rx u_uart_rx(
            //ports
            .sys_clk ( clk ),
            .uart_rx_clk ( uart_rx_clk ),
            .sys_rst_n ( rst_n ),

            .rx_en( rx_en ),
            .rx_busy ( ),
            .rx_ready ( rx_ready ),

            .rxd ( rxd_pin ),
            .rx_data ( recv_wire )
        );

endmodule

