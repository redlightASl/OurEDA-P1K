#ifndef __DISPLAY_H_
#define __DISPLAY_H_
#include "Defines.h"

#if defined (USING_DISPLAY)
//警告1位置
#define POSX_WARN1_HIGH 0x00
#define POSX_WARN1_LOW 0x00
#define POSY_WARN1_HIGH 0x00
#define POSY_WARN1_LOW 0x00
//警告2位置
#define POSX_WARN2_HIGH 0x00
#define POSX_WARN2_LOW 0x00
#define POSY_WARN2_HIGH 0x00
#define POSY_WARN2_LOW 0x00
//水深位置
#define POSX_WATERDEEP_HIGH 0x00
#define POSX_WATERDEEP_LOW 0x00
#define POSY_WATERDEEP_HIGH 0x00
#define POSY_WATERDEEP_LOW 0x00
//姿态位置
#define POSX_ATTITUDE_HIGH 0x00
#define POSX_ATTITUDE_LOW 0x00
#define POSY_ATTITUDE_HIGH 0x00
#define POSY_ATTITUDE_LOW 0x00
//电池电压位置
#define POSX_POWER_HIGH 0x00
#define POSX_POWER_LOW 0x00
#define POSY_POWER_HIGH 0x00
#define POSY_POWER_LOW 0x00

#if defined (RTTHREAD_BASE) //rt-thread libs
#include <rtthread.h>
#include <rtdevice.h>


//字库
extern uint8_t NumLib[15][2];

//漏水指示
extern uint8_t String_WaterOn[2][27];
extern uint8_t String_WaterOff[2][27];

void Init_QL504(rt_device_t uart, uint8_t** init_table, uint8_t init_table_height);
void SendNum_QL504(rt_device_t uart, uint8_t Row, uint8_t Column, uint8_t Number);
void SendString_QL504(rt_device_t uart, uint8_t* StringLib, uint8_t StringLength);
void ClearScreen_QL504(rt_device_t uart);

#endif
#endif
#endif

