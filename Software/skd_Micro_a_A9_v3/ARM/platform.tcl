# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\skd_Micro_a_A9_v3\ARM\platform.tcl
# 
# OR launch xsct and run below command.
# source I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\skd_Micro_a_A9_v3\ARM\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {ARM}\
-hw {I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\sys_wrapper.xsa}\
-out {I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/skd_Micro_a_A9_v3}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {ARM}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
bsp reload
bsp config stdin "none"
bsp config xil_interrupt "false"
bsp config stdout "none"
bsp setlib -name xilffs -ver 4.7
bsp setlib -name lwip211 -ver 1.7
bsp write
bsp reload
catch {bsp regenerate}
platform generate
platform active {ARM}
platform config -updatehw {I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/sys_wrapper.xsa}
platform generate -domains 
