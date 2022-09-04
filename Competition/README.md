# 基于ZYNQ硬件加速RISC-V软核控制的水下机器人

基于Xilinx Zynq-7010搭建的水下机器人控制系统，PS部分搭载嵌入式Linux系统实现网络通讯和视频推流功能；PL部分实现自研RV32I处理器控制水下推进器并实时采集舱内外传感器数据，通过EMIO与PS通讯；实现DVP总线控制器和一组ISP设备用于水下视频采集和图像增强，图像使用AXI-Stream传输给PS并从以太网推流到上位机。如果时间允许还会移植脉动阵列卷积加速器到PL，配合PS部分实现基于YOLOv5-N（r6.1）的水下图像识别。

* 硬件

    核心板最小系统移植√

    FPGA四相电源电路（全部LDO解决）

    推进器、舵机功率电源电路（MP4423的24V转12V6A解决方案）

    百兆以太网电路（RTL8211E跑百兆，千兆不会画）

    电力载波电路

    数字摄像头电路（暂定DVP，MIPI不会画）

    传感器电路

    外围电路

* PS

    用petalinux完成核心板的嵌入式linux移植

    以太网、USB设备树

    EMIO、AXI驱动

    移植openwrt到7010

    移植mjpg-streamer或motion

    移植ser2net

    移植xilinx-opencv库

* PL

    * RV32I软核编写

        单周期测试√

        三级流水：取指-译码-执行

        CPU封装IP

        外设UART-Lite√

        外设PWM控制√

        外设PID√

        CPU不支持中断

    * 软核配套DMA编写

    * 软核配套ITCM、DTCM编写

    * DVP总线控制器编写√

    * 直方图统计√

    * 直方图均衡化（基于Verilog或HLS？）

    * 传感器解析状态机编写

        九轴传感器

        水深水温传感器

        

        

        

        

        


​    