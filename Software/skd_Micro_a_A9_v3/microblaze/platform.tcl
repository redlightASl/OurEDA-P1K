# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\skd_Micro_a_A9_v3\microblaze\platform.tcl
# 
# OR launch xsct and run below command.
# source I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\skd_Micro_a_A9_v3\microblaze\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {microblaze}\
-hw {I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\sys_wrapper.xsa}\
-out {I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/skd_Micro_a_A9_v3}

platform write
domain create -name {freertos10_xilinx_microblaze_0} -display-name {freertos10_xilinx_microblaze_0} -os {freertos10_xilinx} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {microblaze}
domain active {zynq_fsbl}
domain active {freertos10_xilinx_microblaze_0}
platform generate -quick
platform write
platform generate
platform active {microblaze}
platform config -updatehw {I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/sys_wrapper.xsa}
platform generate -domains 
