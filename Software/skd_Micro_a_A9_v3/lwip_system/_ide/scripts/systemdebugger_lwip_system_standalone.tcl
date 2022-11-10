# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\skd_Micro_a_A9_v3\lwip_system\_ide\scripts\systemdebugger_lwip_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source I:\FPGA\OurEDA_P1K\micro_blaze_ps_v1\skd_Micro_a_A9_v3\lwip_system\_ide\scripts\systemdebugger_lwip_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Platform Cable USB II 13724327082d01" && level==0 && jtag_device_ctx=="jsn-DLC10-13724327082d01-13722093-0"}
fpga -file I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/skd_Micro_a_A9_v3/lwip/_ide/bitstream/sys_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/skd_Micro_a_A9_v3/ARM/export/ARM/hw/sys_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/skd_Micro_a_A9_v3/lwip/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*A9*#0"}
dow I:/FPGA/OurEDA_P1K/micro_blaze_ps_v1/skd_Micro_a_A9_v3/lwip/Debug/lwip.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
