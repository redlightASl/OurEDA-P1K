-makelib xcelium_lib/xilinx_vip -sv \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "D:/xilinx/Vivado/2020.2/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_8 -sv \
  "../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/94c3/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/processing_system7_vip_v1_0_10 -sv \
  "../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/34f8/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_main/ip/design_main_processing_system7_0_0/sim/design_main_processing_system7_0_0.v" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_13 \
  "../../../../OurEDA-P1K_zynq.gen/sources_1/bd/design_main/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_main/ip/design_main_proc_sys_reset_0_0/sim/design_main_proc_sys_reset_0_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_main/sim/design_main.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

