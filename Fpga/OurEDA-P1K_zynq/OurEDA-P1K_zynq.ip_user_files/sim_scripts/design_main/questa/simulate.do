onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib design_main_opt

do {wave.do}

view wave
view structure
view signals

do {design_main.udo}

run -all

quit -force
