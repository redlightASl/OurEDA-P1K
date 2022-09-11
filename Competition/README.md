# 基于Zynq硬件加速RISC-V软核控制的水下机器人

基于Xilinx Zynq-7010的水下机器人（ROV/AUV）单芯片解决方案，使用单片Zynq取代传统ROV中常见的高性能ARM+高实时性MCU架构，并利用FPGA将原本需要外接加速器的图像处理功能集成到片上，从而节省宝贵的舱内空间。PS搭载嵌入式Linux，负责高性能的USB摄像头采集、水下图像处理、网络视频推流任务。PL构建RV32I软核，三级流水双发射优化性能-面积比，配备TCM、内核定时器，支持外部中断，配套GPIO、UART、PWM、I2C、DVP-DMA、ISP加速器外设。SoC通过AXI接口读写PS端DDR数据并使用EMIO串口接收PS端转发指令与上位机实时通信，负责高实时性的水下机器人姿态控制、多传感器数据采集、DVP摄像头图像ISP任务。拟根据脉动阵列架构实现卷积加速器，配合PS部分完成基于YOLOv7的水下目标识别任务

* 硬件

    核心板最小系统移植√

    FPGA四相电源电路（全部LDO解决）√

    推进器、舵机功率电源电路（MP4423的24V转12V6A解决方案）√

    百兆以太网电路（RTL8211E跑百兆，千兆不会画）√

    电力载波电路√

    数字摄像头电路（暂定DVP，MIPI不会画）√

    传感器电路√

    外围电路√

    PCB layout

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