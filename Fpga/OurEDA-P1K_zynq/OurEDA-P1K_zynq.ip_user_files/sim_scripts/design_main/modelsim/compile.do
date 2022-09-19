vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_8
vlib modelsim_lib/msim/processing_system7_vip_v1_0_10
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/lib_cdc_v1_0_2
vlib modelsim_lib/msim/proc_sys_reset_v5_0_13

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_8 modelsim_lib/msim/axi_vip_v1_1_8
vmap processing_system7_vip_v1_0_10 modelsim_lib/msim/processing_system7_vip_v1_0_10
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap lib_cdc_v1_0_2 modelsim_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 modelsim_lib/msim/proc_sys_reset_v5_0_13

vlog -work xilinx_vip  -incr -sv -L axi_vip_v1_1_8 -L processing_system7_vip_v1_0_10 -L xilinx_vip "+incdir+D:/xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axi_infrastructure_v1_1_0  -incr "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ec67/hdl" "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/34f8/hdl" "+incdir+D:/xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_8  -incr -sv -L axi_vip_v1_1_8 -L processing_system7_vip_v1_0_10 -L xilinx_vip "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ec67/hdl" "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/34f8/hdl" "+incdir+D:/xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/94c3/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_10  -incr -sv -L axi_vip_v1_1_8 -L processing_system7_vip_v1_0_10 -L xilinx_vip "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ec67/hdl" "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/34f8/hdl" "+incdir+D:/xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/34f8/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ec67/hdl" "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/34f8/hdl" "+incdir+D:/xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../bd/design_main/ip/design_main_processing_system7_0_0/sim/design_main_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2  -93 \
"../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13  -93 \
"../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../bd/design_main/ip/design_main_proc_sys_reset_0_0/sim/design_main_proc_sys_reset_0_0.vhd" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ec67/hdl" "+incdir+../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/34f8/hdl" "+incdir+D:/xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../bd/design_main/sim/design_main.v" \

vlog -work xil_defaultlib \
"glbl.v"
