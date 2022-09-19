onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+design_main -L xilinx_vip -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_8 -L processing_system7_vip_v1_0_10 -L xil_defaultlib -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_13 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.design_main xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {design_main.udo}

run -all

endsim

quit -force
