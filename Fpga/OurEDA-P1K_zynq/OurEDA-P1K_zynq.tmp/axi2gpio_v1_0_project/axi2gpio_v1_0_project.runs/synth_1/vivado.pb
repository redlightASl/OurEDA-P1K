
>
Refreshing IP repositories
234*coregenZ19-234h px? 
?
 Loaded user IP repository '%s'.
1135*coregen2P
<f:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2pid_1.02default:defaultZ19-1700h px? 
?
 Loaded user IP repository '%s'.
1135*coregen2Q
=f:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.02default:defaultZ19-1700h px? 
?
 Loaded user IP repository '%s'.
1135*coregen2P
<f:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2dvp_1.02default:defaultZ19-1700h px? 
?
 Loaded user IP repository '%s'.
1135*coregen2P
<f:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2iic_1.02default:defaultZ19-1700h px? 
?
 Loaded user IP repository '%s'.
1135*coregen2Q
=f:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2uart_1.02default:defaultZ19-1700h px? 
|
"Loaded Vivado IP repository '%s'.
1332*coregen23
D:/xilinx/Vivado/2020.2/data/ip2default:defaultZ19-2313h px? 
?
?The host OS only allows 260 characters in a normal path. The IP cache path is more than 80 characters. If you experience issues with IP caching, please consider changing the IP cache to a location with a shorter path. Alternately consider using the OS subst command to map part of the path to a drive letter. 
Current IP cache path is %s 2293*coregen2?
?f:/Git_repository/OurEDA/OurEDA-P1K/Fpga/OurEDA-P1K_zynq/OurEDA-P1K_zynq.tmp/axi2gpio_v1_0_project/axi2gpio_v1_0_project.cache/ip2default:defaultZ19-4995h px? 
z
Command: %s
53*	vivadotcl2I
5synth_design -top axi2gpio_v1_0 -part xc7z010clg400-12default:defaultZ4-113h px? 
:
Starting synth_design
149*	vivadotclZ4-321h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7z0102default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7z0102default:defaultZ17-349h px? 
?
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
22default:defaultZ8-7079h px? 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px? 
`
#Helper process launched with PID %s4824*oasys2
117522default:defaultZ8-7075h px? 
?
%s*synth2?
rStarting Synthesize : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
?
synthesizing module '%s'%s4497*oasys2!
axi2gpio_v1_02default:default2
 2default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
42default:default8@Z8-6157h px? 
c
%s
*synth2K
7	Parameter GPIO_PORT_NUM bound to: 32 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter CNT_LENGTH bound to: 16 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter TIM_NUM bound to: 8 - type: integer 
2default:defaulth p
x
? 
j
%s
*synth2R
>	Parameter C_S00_AXI_DATA_WIDTH bound to: 32 - type: integer 
2default:defaulth p
x
? 
i
%s
*synth2Q
=	Parameter C_S00_AXI_ADDR_WIDTH bound to: 6 - type: integer 
2default:defaulth p
x
? 
?
synthesizing module '%s'%s4497*oasys2)
axi2gpio_v1_0_S00_AXI2default:default2
 2default:default2o
YF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0_S00_AXI.v2default:default2
42default:default8@Z8-6157h px? 
c
%s
*synth2K
7	Parameter GPIO_PORT_NUM bound to: 32 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter CNT_LENGTH bound to: 16 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter TIM_NUM bound to: 8 - type: integer 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter C_S_AXI_DATA_WIDTH bound to: 32 - type: integer 
2default:defaulth p
x
? 
g
%s
*synth2O
;	Parameter C_S_AXI_ADDR_WIDTH bound to: 6 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter ADDR_LSB bound to: 2 - type: integer 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter OPT_MEM_ADDR_BITS bound to: 3 - type: integer 
2default:defaulth p
x
? 
?
default block is never used226*oasys2o
YF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0_S00_AXI.v2default:default2
4662default:default8@Z8-226h px? 
?
synthesizing module '%s'%s4497*oasys2
gpio_top2default:default2
 2default:default2b
LF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio_top.v2default:default2
42default:default8@Z8-6157h px? 
c
%s
*synth2K
7	Parameter GPIO_PORT_NUM bound to: 32 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter CNT_LENGTH bound to: 16 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter TIM_NUM bound to: 8 - type: integer 
2default:defaulth p
x
? 
?
synthesizing module '%s'%s4497*oasys2
pwm2default:default2
 2default:default2]
GF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/pwm.v2default:default2
42default:default8@Z8-6157h px? 
`
%s
*synth2H
4	Parameter CNT_LENGTH bound to: 16 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pwm2default:default2
 2default:default2
12default:default2
12default:default2]
GF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/pwm.v2default:default2
42default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
gpio2default:default2
 2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
42default:default8@Z8-6157h px? 
c
%s
*synth2K
7	Parameter GPIO_PORT_NUM bound to: 32 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
gpio2default:default2
 2default:default2
22default:default2
12default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
42default:default8@Z8-6155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
gpio_top2default:default2
 2default:default2
32default:default2
12default:default2b
LF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio_top.v2default:default2
42default:default8@Z8-6155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2)
axi2gpio_v1_0_S00_AXI2default:default2
 2default:default2
42default:default2
12default:default2o
YF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0_S00_AXI.v2default:default2
42default:default8@Z8-6155h px? 
?
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
pwm_en2default:default2)
axi2gpio_v1_0_S00_AXI2default:default2.
axi2gpio_v1_0_S00_AXI_inst2default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
612default:default8@Z8-7071h px? 
?
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2.
axi2gpio_v1_0_S00_AXI_inst2default:default2)
axi2gpio_v1_0_S00_AXI2default:default2
272default:default2
262default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
612default:default8@Z8-7023h px? 
?
synthesizing module '%s'%s4497*oasys2
IOBUF2default:default2
 2default:default2K
5D:/xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
362422default:default8@Z8-6157h px? 
[
%s
*synth2C
/	Parameter DRIVE bound to: 12 - type: integer 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter IBUF_LOW_PWR bound to: TRUE - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter SLEW bound to: SLOW - type: string 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
IOBUF2default:default2
 2default:default2
52default:default2
12default:default2K
5D:/xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
362422default:default8@Z8-6155h px? 
?
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
322default:default2
O2default:default2
12default:default2
IOBUF2default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
932default:default8@Z8-689h px? 
?
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
322default:default2
I2default:default2
12default:default2
IOBUF2default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
942default:default8@Z8-689h px? 
?
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
322default:default2
IO2default:default2
12default:default2
IOBUF2default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
952default:default8@Z8-689h px? 
?
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
322default:default2
T2default:default2
12default:default2
IOBUF2default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
962default:default8@Z8-689h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
axi2gpio_v1_02default:default2
 2default:default2
62default:default2
12default:default2g
QF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/hdl/axi2gpio_v1_0.v2default:default2
42default:default8@Z8-6155h px? 
?
%s*synth2?
rFinished Synthesize : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
}Finished Constraint Validation : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Loading part: xc7z010clg400-1
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Loading Part and Timing Information : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
Loading part %s157*device2#
xc7z010clg400-12default:defaultZ21-403h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:06 ; elapsed = 00:00:06 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   16 Bit       Adders := 8     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               32 Bit    Registers := 16    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               16 Bit    Registers := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                6 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                2 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 68    
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   32 Bit        Muxes := 15    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  16 Input   32 Bit        Muxes := 15    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   16 Bit        Muxes := 16    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 191   
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2j
VPart Resources:
DSPs: 80 (col length:40)
BRAMs: 120 (col length: RAMB18 40 RAMB36 20)
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[30]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[30]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[30]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[30]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[29]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[29]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[29]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[29]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[28]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[28]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[28]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[28]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[27]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[27]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[27]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[27]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[26]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[26]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[26]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[26]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[25]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[25]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[25]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[25]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[24]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[24]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[24]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[24]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[23]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[23]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[23]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[23]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[22]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[22]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[22]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[22]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[21]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[21]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[21]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[21]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[20]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[20]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[20]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[20]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[19]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[19]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[19]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[19]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[18]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[18]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[18]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[18]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[17]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[17]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[17]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[17]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[16]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[16]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[16]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[16]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[15]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[15]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[15]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[15]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[14]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[14]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[14]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[14]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[13]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[13]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[13]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[13]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[12]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[12]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[12]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[12]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[11]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[11]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[11]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[11]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[10]2default:default2
1st2default:default2b
Naxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[10]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2"
io_pin_out[10]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2"
io_pin_out[10]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[9]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[9]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[9]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[9]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[8]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[8]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[8]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[8]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[7]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[7]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[7]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[7]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[6]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[6]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[6]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[6]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[5]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[5]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[5]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[5]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[4]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[4]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[4]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[4]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[3]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[3]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[3]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[3]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[2]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[2]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[2]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[2]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[1]2default:default2
1st2default:default2a
Maxi2gpio_v1_0_S00_AXI_inst/u_gpio_top/gpio_inst/p_58_out_inferred/p_58_out[1]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
2multi-driven net on pin %s with %s driver pin '%s'4708*oasys2!
io_pin_out[1]2default:default2
2nd2default:default2
GND2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6859h px? 
?
rmulti-driven net %s is connected to at least one constant driver which has been preserved, other driver is ignored4707*oasys2!
io_pin_out[1]2default:default2^
HF:/Git_repository/OurEDA/OurEDA-P1K/Fpga/ip_repo/axi2gpio_1.0/src/gpio.v2default:default2
292default:default8@Z8-6858h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
{Finished Timing Optimization : Time (s): cpu = 00:00:11 ; elapsed = 00:00:13 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
zFinished Technology Mapping : Time (s): cpu = 00:00:11 ; elapsed = 00:00:13 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
tFinished IO Insertion : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Instances : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Ports : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
Finished Renaming Generated Nets : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px? 
C
%s*synth2+
+------+------+------+
2default:defaulth px? 
C
%s*synth2+
|      |Cell  |Count |
2default:defaulth px? 
C
%s*synth2+
+------+------+------+
2default:defaulth px? 
C
%s*synth2+
|1     |BUFG  |     1|
2default:defaulth px? 
C
%s*synth2+
|2     |LUT1  |     1|
2default:defaulth px? 
C
%s*synth2+
|3     |LUT2  |     1|
2default:defaulth px? 
C
%s*synth2+
|4     |LUT3  |     1|
2default:defaulth px? 
C
%s*synth2+
|5     |LUT4  |     4|
2default:defaulth px? 
C
%s*synth2+
|6     |LUT5  |    32|
2default:defaulth px? 
C
%s*synth2+
|7     |LUT6  |   158|
2default:defaulth px? 
C
%s*synth2+
|8     |MUXF7 |    64|
2default:defaulth px? 
C
%s*synth2+
|9     |MUXF8 |    32|
2default:defaulth px? 
C
%s*synth2+
|10    |FDRE  |   525|
2default:defaulth px? 
C
%s*synth2+
|11    |FDSE  |     1|
2default:defaulth px? 
C
%s*synth2+
|12    |IBUF  |    51|
2default:defaulth px? 
C
%s*synth2+
|13    |IOBUF |     1|
2default:defaulth px? 
C
%s*synth2+
|14    |OBUF  |    72|
2default:defaulth px? 
C
%s*synth2+
+------+------+------+
2default:defaulth px? 
E
%s
*synth2-

Report Instance Areas: 
2default:defaulth p
x
? 
q
%s
*synth2Y
E+------+-----------------------------+----------------------+------+
2default:defaulth p
x
? 
q
%s
*synth2Y
E|      |Instance                     |Module                |Cells |
2default:defaulth p
x
? 
q
%s
*synth2Y
E+------+-----------------------------+----------------------+------+
2default:defaulth p
x
? 
q
%s
*synth2Y
E|1     |top                          |                      |   944|
2default:defaulth p
x
? 
q
%s
*synth2Y
E|2     |  axi2gpio_v1_0_S00_AXI_inst |axi2gpio_v1_0_S00_AXI |   819|
2default:defaulth p
x
? 
q
%s
*synth2Y
E+------+-----------------------------+----------------------+------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Writing Synthesis Report : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
s
%s
*synth2[
GSynthesis finished with 0 errors, 90 critical warnings and 6 warnings.
2default:defaulth p
x
? 
?
%s
*synth2?
}Synthesis Optimization Runtime : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth p
x
? 
?
%s
*synth2?
~Synthesis Optimization Complete : Time (s): cpu = 00:00:14 ; elapsed = 00:00:16 . Memory (MB): peak = 1143.359 ; gain = 0.000
2default:defaulth p
x
? 
B
 Translating synthesized netlist
350*projectZ1-571h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0112default:default2
1143.3592default:default2
0.0002default:defaultZ17-268h px? 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
972default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1226.3912default:default2
0.0002default:defaultZ17-268h px? 
?
!Unisim Transformation Summary:
%s111*project2k
W  A total of 1 instances were transformed.
  IOBUF => IOBUF (IBUF, OBUFT): 1 instance 
2default:defaultZ1-111h px? 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
322default:default2
72default:default2
902default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:192default:default2
00:00:222default:default2
1226.3912default:default2
83.0312default:defaultZ17-268h px? 
u
%s6*runtcl2Y
ESynthesis results are not added to the cache due to CRITICAL_WARNING
2default:defaulth px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2?
?F:/Git_repository/OurEDA/OurEDA-P1K/Fpga/OurEDA-P1K_zynq/OurEDA-P1K_zynq.tmp/axi2gpio_v1_0_project/axi2gpio_v1_0_project.runs/synth_1/axi2gpio_v1_0.dcp2default:defaultZ17-1381h px? 
?
%s4*runtcl2?
pExecuting : report_utilization -file axi2gpio_v1_0_utilization_synth.rpt -pb axi2gpio_v1_0_utilization_synth.pb
2default:defaulth px? 
?
Exiting %s at %s...
206*common2
Vivado2default:default2,
Tue Oct  4 17:03:40 20222default:defaultZ17-206h px? 


End Record