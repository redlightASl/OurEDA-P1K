/**
 * @file Defines.h
 * @brief 进行各种基础数据类型的定义
 * @author RedlightASl (dddbbbdd@foxmail.com)
 * @version 1.0
 * @date 2021-09-13
 *
 * @copyright Copyright (c) 2021  RedlightASl
 *
 * @par 修改日志:
 * <table>
 * <tr><th>Date       <th>Version <th>Author  <th>Description
 * <tr><td>2021-09-13 <td>1.0     <td>wangh     <td>Content
 * </table>
 */
#ifndef __ROV_DEFINES_H
#define __ROV_DEFINES_H
#include "Setup.h"


#if defined ( __CC_ARM )
#define MEM_ALIGN_32BYTES ALIGN_32BYTES
#define ROV_STABLE_MEMORY_SPACE(RAM_DISTRICT) __attribute__((section(RAM_DISTRICT)))
#elif defined ( __ICCARM__ )
#define MEM_ALIGN_32BYTES ALIGN_32BYTES
#endif

#if defined (RTTHREAD_BASE)
#include "rtdef.h"
typedef rt_uint8_t uint8_t; /**<  unsigned 8bit integer type */
typedef rt_uint16_t uint16_t; /**< unsigned 16bit integer type */
typedef rt_uint32_t uint32_t; /**< unsigned 32bit integer type */
typedef rt_uint64_t uint64_t; /**< unsigned 64bit integer type */
typedef rt_int8_t int8_t; /**< signed 8bit integer type */
typedef rt_int16_t int16_t; /**< signed 16bit integer type */
typedef rt_int32_t int32_t; /**< signed 32bit integer type */
typedef rt_int64_t int64_t; /**< signed 64bit integer type */

typedef float float_t; /**< signed 64bit integer type */

#define ROV_TRUE RT_EOK /* RT_EOK == 0 */
#define ROV_FALSE RT_ERROR /* RT_ERROE = 1*/
#elif defined (FREERTOS_BASE)
#include "FreeRTOS.h"
typedef uint8_t uint8_t; /**< unsigned 8bit integer type */
typedef uint16_t uint16_t; /**< unsigned 16bit integer type */
typedef uint32_t uint32_t; /**< unsigned 32bit integer type */
typedef unsigned long long uint64_t; /**< unsigned 64bit integer type */
typedef int8_t int8_t; /**< signed 8bit integer type */
typedef int16_t int16_t; /**< signed 16bit integer type */
typedef int32_t int32_t; /**< signed 32bit integer type */
typedef signed long long int64_t; /**< signed 64bit integer type */

typedef float float_t; /**< signed 64bit integer type */
typedef double double_t; /**< signed 64bit integer type */

#define ROV_TRUE pdTRUE
#define ROV_FALSE pdFALSE
#else
typedef unsigned char uint8_t; /**< unsigned 8bit integer type */
typedef unsigned short uint16_t; /**< unsigned 16bit integer type */
typedef unsigned int uint32_t; /**< unsigned 32bit integer type */
typedef signed char int8_t; /**< signed 8bit integer type */
typedef signed short int16_t; /**< signed 16bit integer type */
typedef signed int int32_t; /**< signed 32bit integer type */

typedef float float_t; /**< signed 64bit integer type */
typedef double double_t; /**< signed 64bit integer type */

#define ROV_TRUE 1
#define ROV_FALSE 0
#endif

typedef volatile unsigned char vu8; /**<  8bit IO__ integer type */
typedef volatile unsigned short vu16; /**< 16bit IO__ integer type */
typedef volatile unsigned int vu32; /**< 32bit IO__ integer type */

typedef enum
{
    NORMAL_MODE = 0, //旋转转向模式
    SIDEPUSH_MODE = 1, //侧推转向模式
    PITCH_MODE = 2, //俯仰模式
    ROLL_MODE = 3, //横滚模式
    MIX_MODE = 4, //融合自转模式
} ThrusterMode; /* 推进器模式 */


#endif
