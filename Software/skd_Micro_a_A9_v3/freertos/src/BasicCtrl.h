/**
 * @file BasicCtrl.h
 * @brief 鎻愪緵濮挎�佹帶鍒剁浉鍏崇畻娉�
 * @author RedlightASl (dddbbbdd@foxmail.com)
 * @version 1.0
 * @date 2022-06-17
 *
 * @copyright Copyright (c) 2022  RedlightASl
 *
 * @par 淇敼鏃ュ織:
 * <table>
 * <tr><th>Date    <th>Version  <th>Author  <th>Description
 * <tr><td>2022-06-17  <td>1.0      <td>wangh   <td>Content
 * </table>
 */
#ifndef __ROV_BASIC_CTRL_H
#define __ROV_BASIC_CTRL_H
#include "Defines.h"

#define SIDE_PUSH_CODE 0x01
#define DIR_CODE 0x02
#define DEEP_CODE 0x04
#define POWER_CODE 0x08

#ifdef __cplusplus
extern "C" {
#endif

struct ReportData {
	uint8_t FrameHead; //甯уご0x25
	uint8_t CabinFunction; //浠撲綅
	uint8_t WaterDetect; //婕忔按妫�娴�
	uint16_t CabinTemperature; //鑸卞唴娓╁害
	uint32_t CabinBarometric; //鑸卞唴姘斿帇
	uint16_t CabinHumidity; //鑸卞唴婀垮害
	uint16_t AccNum[3]; //鍔犻�熷害
	uint16_t RotNum[3]; //瑙掗�熷害
	uint16_t EulNum[3]; //娆ф媺瑙�
	uint16_t MagNum[3]; //纾佸満
	uint32_t SonarHeight; //澹板憪楂樺害
	uint16_t SonarConfidence; //澹板憪纭俊搴�
	uint16_t WaterTemperature; //姘存俯
	uint16_t WaterDepth; //姘存繁
	uint8_t IdTest; //鏍￠獙
	uint16_t FrameEnd; //甯у熬0xFFFF
};
typedef struct ReportData ReportData_t;

struct ControlData {
	uint8_t FrameHead; //甯уご0x25
	uint16_t StraightNum; //鍓嶈繘
	uint16_t RotateNum; //杞悜
	uint16_t VerticalNum; //鍨傜洿鍗囬檷
	uint16_t LightNum; //鐏厜
	uint16_t PanNum; //浜戝彴
	uint16_t ConveyNum; //浼犻�佸甫
	uint16_t ArmNum[6]; //鏈烘鑷�
	uint16_t RestNum; //淇濈暀浣峆WM
	uint8_t Mode; //妯″紡
	uint8_t IdTest; //鏍￠獙
	uint8_t FrameEnd; //甯у熬0x21
};
typedef struct ControlData ControlData_t;

struct PwmVal {
	u32 HorizontalThruster[NUMBER_OF_HORIZENTAL_THRUSTER]; //姘村钩鏂瑰悜鎺ㄨ繘鍣�
	u32 VerticalThruster[NUMBER_OF_VERTICAL_THRUSTER]; //鍨傜洿鏂瑰悜鎺ㄨ繘鍣�
	u32 LightServo; //鐏厜
	u32 PanServo; //浜戝彴
	u32 ConveyServo; //浼犻�佸甫
	u32 ArmServo[6]; //鏈烘鑷�
	u32 RestServo; //淇濈暀浣峆WM
};
typedef struct PwmVal PwmVal_t;


void MoveControl(PwmVal_t *ThrusterTemp, uint16_t StraightNum,
		uint16_t RotateNum, uint16_t VerticalNum, uint8_t ModeNum);
void CaptureReportData(ReportData_t SendData, uint8_t *ReportTransmit);
ReportData_t ReportDataAnalysis(uint8_t *ReportReceive);
//ControlData_t CaptureControlData(uint8_t *CommandReceive);
void CaptureControlData(ControlData_t* CaptureData, uint8_t *CommandReceive);
void ControlDataAnalysis(ControlData_t controller, PwmVal_t *temp_pwm, uint8_t ModeNum);
void ControlDataGenerate(ControlData_t controller, uint8_t *CommandTransmit);



#ifdef __cplusplus
}
#endif

#endif
