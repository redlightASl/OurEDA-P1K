#ifndef __ROV_SETUP_H
#define __ROV_SETUP_H
/* 中间件选择 */
//基于 RT-Thread
// #define RTTHREAD_BASE
//基于 FreeRTOS
#define FREERTOS_BASE
//基于 裸机
// #define BAREMETAL_BASE


/* 推进器配置 */
#define NUMBER_OF_HORIZENTAL_THRUSTER 4
#define NUMBER_OF_VERTICAL_THRUSTER 2
#define PWM_MIDDLE_POSITION 1500


/* 传感器模块选择 */
#define SENSOR_IMU
#define SENSOR_DEPTH
#define SENSOR_CARBIN
#define SENSOR_SONAR
// #define SENSOR_VIDEO

#ifdef SENSOR_IMU
#define USING_WT931_SENSOR
// #define USING_BO055_SENSOR
#endif

#ifdef SENSOR_CARBIN
#define USING_GY39_SENSOR
// #define USING_SHT20_SENSOR
#endif

#ifdef SENSOR_SONAR
#define USING_GP30_SENSOR
#endif

#ifdef SENSOR_DEPTH
#define USING_DEPTH_SENSOR
//#define USING_ROV_SENSE
#endif

#ifdef SENSOR_VIDEO
#define USING_DISPLAY
#endif

/* 仓位状态选择 */
//控制仓-汇总数据
#define CtrlSide
//动力仓-控制姿态
//#define PowerSide

/* 串口定义 */
#ifdef SENSOR_IMU
//九轴板
#define AXIS_UART huart3
#define AXIS_UART_RXLen 44
#endif

#ifdef SENSOR_CARBIN
//温湿度大气压
#define TEMPER_UART huart2
#define TEMPER_UART_RXLen 15
#define TEMPER_UART_TXLen 3
#endif

#ifdef SENSOR_DEPTH
//深度解算板
#define Deep_UART huart4
#define Deep_UART_RXLen 15
#endif

#ifdef SENSOR_SONAR
//声呐深度传感器
#define SONAR_HEIGHT_UART huart5
#define SONAR_HEIGHT_UART_TXLen 12
#define SONAR_HEIGHT_UART_RXLen 33
#endif

#ifdef SENSOR_VIDEO
//视频叠加板
#define Avip_UART huart5
#define Avip_UART_TXLEN 31
#endif

//上位主机口
#define Master_UART huart1
#define Master_UART_TXLen 47
#define Master_UART_RXLen 30
#define COMMAND_SIZE 16

//下位从机口
#define Slave_UART huart8
#define Slave_UART_RXLen 47
#define Slave_UART_TXLEN 30

//本机调试口
#define Console_UART huart1

/* 算法控制选择 */
//PID参数固定或动态调节
// #define FIXED_PID_PARAMETER
#ifdef FIXED_PID_PARAMETER
//定向比例系数
#define PID_O_Kp -1.1f
//定向积分系数
#define PID_O_Ki 0.5f
//定向微分系数
#define PID_O_Kd 0.8f
//定深比例系数
#define PID_DEEP_Kp -1.5f
//定深积分系数
#define PID_DEEP_Ki 0.7f
//定深微分系数
#define PID_DEEP_Kd 0.5f
#endif

//是否使用校验位
// #define DATA_IDENTIFY
//使用查表进行CRC校验
// #define CRC_LUT

#endif
