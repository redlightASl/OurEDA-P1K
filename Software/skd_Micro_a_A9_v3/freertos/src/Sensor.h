/**
 * @file Sensor.h
 * @brief 提供传感器解析相关算法
 * @author RedlightASl (dddbbbdd@foxmail.com)
 * @version 1.0
 * @date 2022-06-17
 *
 * @copyright Copyright (c) 2022  RedlightASl
 *
 * @par 修改日志:
 * <table>
 * <tr><th>Date    <th>Version  <th>Author  <th>Description
 * <tr><td>2022-06-17  <td>1.0      <td>wangh   <td>Content
 * </table>
 */
#ifndef __ROV_SENSOR_H
#define __ROV_SENSOR_H
#include "Defines.h"

#ifdef __cplusplus
extern "C" {
#endif

#if defined (RTTHREAD_BASE)
    struct DMA_DataStruct
    {
        rt_device_t dev;
        rt_size_t size;
    };
    typedef struct DMA_DataStruct DMA_DataStruct_t;






    struct rov_SensorData
    {
        u8* name; //数据位对应的名字
        u8 count; //数据位位置
        u8 hex_num; //所收取十六进制位的内容

        struct rov_SensorData* previous;
        struct rov_SensorData* next;

    };
    /* 传感器数据类型管理类 */
    typedef struct rov_SensorData* rov_SensorData_t;

    struct rov_Sensor
    {
        rov_SensorData_t data_head; //传感器数据头指针
        u8* huart; //传感器接收串口硬件设备
        ROV_STABLE_MEMORY_SPACE u8* buffer; //传感器接收缓存区指针
        u8 buffer_length; //传感器接收缓存区大小

        void (*ROV_Sensor_Init)(void); //传感器初始化
        void (*ROV_Sensor_Receive)(struct rov_Sensor* sensor); //传感器数据接收

        struct rov_Sensor* previous;
        struct rov_Sensor* next;

    };
    /* 传感器类 */
    typedef struct rov_Sensor* rov_Sensor_t;

    struct rov_SensorInformation
    {
        rov_Sensor_t sensor_head; //传感器头指针
        u8* huart; //上传串口硬件设备
        ROV_STABLE_MEMORY_SPACE u8* buffer; //上传缓存区指针
        u8 buffer_length; //上传缓存区大小

        void (*ROV_SendUp_Init)(void); //上传串口与传感器初始化
        void (*ROV_SendUp)(struct rov_SensorInformation* SendUpUart); //上传数据

        struct rov_SensorInformation* previous;
        struct rov_SensorInformation* next;
    };
    /* 传感器上传类 */
    typedef struct rov_SensorInformation* rov_SensorInformation_t;
#elif defined (FREERTOS_BASE)

#endif

#ifdef SENSOR_DEPTH
struct DepthData
{
	uint16_t WaterTemperature;
	uint32_t WaterPressure;
    uint8_t is_signed;
	uint16_t WaterDepth;
};
typedef struct DepthData DepthData_t;
#endif

#ifdef SENSOR_SONAR
struct SonarData
{
	uint32_t SonarHeight;
	uint32_t SonarDistance;
	uint16_t Confidence;
};
typedef struct SonarData SonarData_t;
#endif

#ifdef SENSOR_IMU
struct IMUData
{
	uint16_t Acceleration[3];
	uint16_t AngularSpeed[3];
	uint16_t EulerAngle[3];
	uint16_t MagneticValue[3];
};
typedef struct IMUData IMUData_t;
#endif

#ifdef SENSOR_CARBIN
struct CarbinData
{
	uint16_t CarbinTemperature;
	uint16_t CarbinHumidity;
	uint32_t CarbinBarometric;
	uint16_t CarbinIllumination;
};
typedef struct CarbinData CarbinData_t;
#endif

#ifdef SENSOR_VIDEO
    struct VideoData
    {
    	uint8_t VedioHead;
    	uint8_t Command;
    	uint8_t VedioEnd;
    };
    typedef struct VideoData VideoData_t;
#endif

#ifdef USING_GY39_SENSOR
void InitGY39(uint8_t *GY39Send);
CarbinData_t ReceiveGY39(uint8_t *GY39Receive);
#endif

#ifdef USING_WT931_SENSOR
IMUData_t ReceiveWT931(uint8_t *WT931Receive);
#endif

#ifdef USING_DEPTH_SENSOR
DepthData_t ReceiveDeep(uint8_t *DeepReceive);
#endif

#ifdef USING_GP30_SENSOR
void InitP30(uint8_t *P30Send);
SonarData_t ReceiveP30(uint8_t *P30Receive);
#endif

#ifdef __cplusplus
}
#endif

#endif
