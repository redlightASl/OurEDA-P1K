
`timescale 1 ns / 1 ps

module axi2gpio_v1_0 #
       (
           // Users to add parameters here
           parameter GPIO_PORT_NUM = 32,
           parameter CNT_LENGTH = 16,
           parameter TIM_NUM = 8,
           // User parameters ends
           // Do not modify the parameters beyond this line


           // Parameters of Axi Slave Bus Interface S00_AXI
           parameter integer C_S00_AXI_DATA_WIDTH	= 32,
           parameter integer C_S00_AXI_ADDR_WIDTH	= 6
       )
       (
           // Users to add ports here
           inout wire [GPIO_PORT_NUM - 1: 0] io_pin,
           input wire pwm_clk,
           input wire pwm_rst_n,
           input wire pwm_en,
           // User ports ends
           // Do not modify the ports beyond this line


           // Ports of Axi Slave Bus Interface S00_AXI
           input wire s00_axi_aclk,
           input wire s00_axi_aresetn,
           input wire [C_S00_AXI_ADDR_WIDTH - 1 : 0] s00_axi_awaddr,
           input wire [2 : 0] s00_axi_awprot,
           input wire s00_axi_awvalid,
           output wire s00_axi_awready,
           input wire [C_S00_AXI_DATA_WIDTH - 1 : 0] s00_axi_wdata,
           input wire [(C_S00_AXI_DATA_WIDTH / 8) - 1 : 0] s00_axi_wstrb,
           input wire s00_axi_wvalid,
           output wire s00_axi_wready,
           output wire [1 : 0] s00_axi_bresp,
           output wire s00_axi_bvalid,
           input wire s00_axi_bready,
           input wire [C_S00_AXI_ADDR_WIDTH - 1 : 0] s00_axi_araddr,
           input wire [2 : 0] s00_axi_arprot,
           input wire s00_axi_arvalid,
           output wire s00_axi_arready,
           output wire [C_S00_AXI_DATA_WIDTH - 1 : 0] s00_axi_rdata,
           output wire [1 : 0] s00_axi_rresp,
           output wire s00_axi_rvalid,
           input wire s00_axi_rready
       );
wire [GPIO_PORT_NUM - 1: 0] io_pin_in;
wire [GPIO_PORT_NUM - 1: 0] io_pin_out;
wire [GPIO_PORT_NUM - 1: 0] io_pin_t;

// Instantiation of Axi Bus Interface S00_AXI
axi2gpio_v1_0_S00_AXI # (
                          .GPIO_PORT_NUM ( GPIO_PORT_NUM ),
                          .CNT_LENGTH ( CNT_LENGTH ),
                          .TIM_NUM ( TIM_NUM ),
                          .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
                          .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
                      ) axi2gpio_v1_0_S00_AXI_inst (
                          .pwm_clk ( pwm_clk ),   //timer clk
                          .pwm_rst_n ( pwm_rst_n ),   //timer reset
                          .io_pin_in ( io_pin_in ),    //in pin
                          .io_pin_out ( io_pin_out ),   //out pin
                          .io_pin_t (io_pin_t),   //io control

                          .S_AXI_ACLK(s00_axi_aclk),
                          .S_AXI_ARESETN(s00_axi_aresetn),
                          .S_AXI_AWADDR(s00_axi_awaddr),
                          .S_AXI_AWPROT(s00_axi_awprot),
                          .S_AXI_AWVALID(s00_axi_awvalid),
                          .S_AXI_AWREADY(s00_axi_awready),
                          .S_AXI_WDATA(s00_axi_wdata),
                          .S_AXI_WSTRB(s00_axi_wstrb),
                          .S_AXI_WVALID(s00_axi_wvalid),
                          .S_AXI_WREADY(s00_axi_wready),
                          .S_AXI_BRESP(s00_axi_bresp),
                          .S_AXI_BVALID(s00_axi_bvalid),
                          .S_AXI_BREADY(s00_axi_bready),
                          .S_AXI_ARADDR(s00_axi_araddr),
                          .S_AXI_ARPROT(s00_axi_arprot),
                          .S_AXI_ARVALID(s00_axi_arvalid),
                          .S_AXI_ARREADY(s00_axi_arready),
                          .S_AXI_RDATA(s00_axi_rdata),
                          .S_AXI_RRESP(s00_axi_rresp),
                          .S_AXI_RVALID(s00_axi_rvalid),
                          .S_AXI_RREADY(s00_axi_rready)
                      );

// Add user logic here
genvar i;
generate
    for (i = 0;i < GPIO_PORT_NUM;i = i + 1) begin
        // assign io_pin[i] = io_pin_t[i] ? io_pin_out[i] : io_pin_in[i];
        IOBUF #(
            .DRIVE(12),
            .IBUF_LOW_PWR("TRUE"),
            .IOSTANDARD("DEFAULT"),
            .SLEW("SLOW")
            )
        IOB_inst
        (
                .O(io_pin_out[i]),
                .I(io_pin_in[i]),
                .IO(io_pin[i]),
                .T(~io_pin_t[i])
            );
    end
endgenerate



// User logic ends

endmodule
