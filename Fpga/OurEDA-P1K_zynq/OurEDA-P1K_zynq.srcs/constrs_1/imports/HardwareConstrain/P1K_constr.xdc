# PL IO
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports beep_pin]
# set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports button_pin]
set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports SYS_GLOBAL_RESET]

# PL Thruster
set_property -dict {PACKAGE_PIN V20 IOSTANDARD LVCMOS33} [get_ports Thruster_A1]
set_property -dict {PACKAGE_PIN W20 IOSTANDARD LVCMOS33} [get_ports Thruster_A2]
set_property -dict {PACKAGE_PIN Y19 IOSTANDARD LVCMOS33} [get_ports Thruster_B1]
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports Thruster_B2]

# PL WT931 9-axis Sensor
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports uart1_tx]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports uart1_rx]

# PL MS5837 Water Depth Sensor
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports i2c0_scl]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports i2c0_sda]

# PL OV5640 DVP
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports i2c1_sda]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports i2c1_scl]

set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports cam_rst]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports dvp_vsync]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports cam_powerdown]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports dvp_href]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports dvp_Y7]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports dvp_xclk]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports dvp_Y6]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports dvp_Y5]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports dvp_pclk]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports dvp_Y4]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports dvp_Y0]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports dvp_Y3]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports dvp_Y1]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports dvp_Y2]

# PS EMIO UART
# set_property -dict {PACKAGE_PIN !?? IOSTANDARD LVCMOS33} [get_ports uart0_tx]
# set_property -dict {PACKAGE_PIN !?? IOSTANDARD LVCMOS33} [get_ports uart0_rx]
