#include "Sensor.h"

#if defined USING_GP30_SENSOR
void InitP30(uint8_t *P30Send)
{
	//42 52 02 00 78 05 00 00 BB 04 D2 01
	*(P30Send + 0) = 0x42;
	*(P30Send + 1) = 0x52;
	*(P30Send + 2) = 0x02;
	*(P30Send + 3) = 0x00;
	*(P30Send + 4) = 0x05;
	*(P30Send + 5) = 0x00;
	*(P30Send + 6) = 0x00;
	*(P30Send + 7) = 0x00;
	*(P30Send + 8) = 0xBB;
	*(P30Send + 9) = 0x04;
	*(P30Send + 10) = 0xD2;
	*(P30Send + 11) = 0x01;
}

/**
 * @brief 接收声呐传感器数据
 * @return P30Data 声呐传感器数据结构体
 */
SonarData_t ReceiveP30(uint8_t *P30Receive)
{
	SonarData_t RecvP30;
	RecvP30.SonarDistance = 0;

	uint8_t FrameState = 0;
	uint8_t Bytenum = 0;
	uint8_t CheckSum = 0;
	uint8_t datahex[11];

	for (uint8_t i = 0; i < 33; i++)
	{
		if (FrameState == 0)
		{
			if ((P30Receive[i] == 0x42) && (Bytenum == 0))
			{
				CheckSum = P30Receive[i];
				Bytenum = 1;
				continue;
			}
			else if ((P30Receive[i] == 0x52) && (Bytenum == 1))
			{
				CheckSum += P30Receive[i];
				Bytenum = 2;
				FrameState = 1;
				continue;
			}
		}
		else if (FrameState == 1)
		{
			if (Bytenum < 13)
			{
				datahex[Bytenum - 2] = P30Receive[i];
				CheckSum += P30Receive[i];
				Bytenum++;
			}
			else
			{
				if (P30Receive[i] == (CheckSum & 0xFF))
				{
					RecvP30.Confidence = (((uint16_t) datahex[10]) << 8)
							| ((uint16_t) datahex[11]);
					RecvP30.SonarHeight = (((((uint32_t) datahex[6]) << 24)
							| (((uint32_t) datahex[7]) << 16)
							| (((uint32_t) datahex[8]) << 8)
							| ((uint32_t) datahex[9])) / 1000);
				}
				CheckSum = 0;
				Bytenum = 0;
				FrameState = 0;
			}
		}
	}

	return RecvP30;
}
#endif

#ifdef USING_DEPTH_SENSOR

#ifdef USING_ROV_SENSE
DepthData_t ReceiveDeep(uint8_t *DeepReceive)
{
	DepthData_t RecvDeep;

	for (uint8_t i = 0; i < Deep_UART_RXLen; i++)
	{
		if ((DeepReceive[i] == 0x21) && (DeepReceive[i + 10] == 0xFF)
				&& (DeepReceive[i + 11] == 0xFF))
		{
			RecvDeep.WaterTemperature = (((uint16_t) DeepReceive[i + 1]) << 8)
					| ((uint16_t) DeepReceive[i + 2]);
			RecvDeep.WaterPressure = (((uint32_t) DeepReceive[i + 3]) << 24)
					| (((uint32_t) DeepReceive[i + 4]) << 16)
					| (((uint32_t) DeepReceive[i + 5]) << 8)
					| ((uint32_t) DeepReceive[i + 6]);
			RecvDeep.is_signed = DeepReceive[i + 7];
			RecvDeep.WaterDepth = (((uint16_t) DeepReceive[i + 8]) << 8)
					| ((uint16_t) DeepReceive[i + 9]);
		}
	}

	return RecvDeep;
}

#else
DepthData_t ReceiveDeep(uint8_t *DeepReceive)
{
	DepthData_t RecvDeep;

	uint8_t temperature_origin_data[4] =
	{ 0 };
	uint8_t depth_origin_data[3] =
	{ 0 };

	for (int i = 0; i < Deep_UART_RXLen; i++)
	{
		if ((DeepReceive[i] == 'T') && (DeepReceive[i + 1] == '=')) //解析温度
		{
			if ((DeepReceive[i + 2] >= '0') && (DeepReceive[i + 2] <= '9')) //温度为正
			{
				temperature_origin_data[0] = DeepReceive[i + 2] - '0';
				temperature_origin_data[1] = DeepReceive[i + 3] - '0';
				temperature_origin_data[2] = DeepReceive[i + 5] - '0';
				temperature_origin_data[3] = DeepReceive[i + 6] - '0';
			}
			else if (DeepReceive[i + 2] == '-') //温度为负
			{
				temperature_origin_data[0] = DeepReceive[i + 3] - '0';
				temperature_origin_data[1] = DeepReceive[i + 4] - '0';
				temperature_origin_data[2] = DeepReceive[i + 6] - '0';
				temperature_origin_data[3] = DeepReceive[i + 7] - '0';
			}
		}
		else if ((DeepReceive[i] == 'D') && (DeepReceive[i + 1] == '=')) //解析深度
		{
			if (DeepReceive[i + 2] == '-') //深度为负
			{
				RecvDeep.is_signed = 0;
				depth_origin_data[0] = DeepReceive[i + 3] - '0';
				depth_origin_data[1] = DeepReceive[i + 5] - '0';
				depth_origin_data[2] = DeepReceive[i + 6] - '0';
			}
			else if ((DeepReceive[i + 2] >= '0') && (DeepReceive[i + 2] <= '9')) //深度为正
			{
				RecvDeep.is_signed = 1;
				depth_origin_data[0] = DeepReceive[i + 2] - '0';
				depth_origin_data[1] = DeepReceive[i + 4] - '0';
				depth_origin_data[2] = DeepReceive[i + 5] - '0';
			}
		}
	}

	RecvDeep.WaterTemperature = (temperature_origin_data[0] * 1000)
			+ (temperature_origin_data[1] * 100)
			+ (temperature_origin_data[2] * 10) + (temperature_origin_data[3]);

	RecvDeep.WaterDepth = (depth_origin_data[0] * 100)
			+ (depth_origin_data[1] * 10) + (depth_origin_data[2]);

	return RecvDeep;
}
#endif

#endif

#ifdef USING_GY39_SENSOR
void InitGY39(uint8_t *GY39Send)
{
	*(GY39Send + 0) = 0xA5;
	*(GY39Send + 1) = 0x82;
	*(GY39Send + 2) = 0x27;
}

CarbinData_t ReceiveGY39(uint8_t *GY39Receive)
{
	CarbinData_t RecvGY39;

	if ((GY39Receive[0] == 0x5A) && (GY39Receive[1] == 0x5A)
			&& (GY39Receive[2] == 0x45))
	{
		RecvGY39.CarbinTemperature = (((uint16_t) (GY39Receive[4]) << 8)
				| ((uint16_t) GY39Receive[5]));
		RecvGY39.CarbinBarometric = ((((uint32_t) GY39Receive[6]) << 24)
				| (((uint32_t) GY39Receive[7]) << 16)
				| (((uint32_t) GY39Receive[8]) << 8)
				| ((uint32_t) GY39Receive[9]));
		RecvGY39.CarbinHumidity = ((((uint16_t) GY39Receive[10]) << 8)
				| ((uint16_t) GY39Receive[11]));
		RecvGY39.CarbinIllumination = 0x0000;
	}

	return RecvGY39;
}
#endif

#ifdef USING_WT931_SENSOR
IMUData_t ReceiveWT931(uint8_t *WT931Receive)
{
	IMUData_t RecvWT931;

	for (uint8_t i = 0; i < AXIS_UART_RXLen; i++)
	{
		if (i > AXIS_UART_RXLen - 11)
		{
			break;
		}

		if (WT931Receive[i] == 0x55)
		{
			switch (WT931Receive[i + 1])
			{
			case 0x51:
				RecvWT931.Acceleration[0] = ((uint16_t) WT931Receive[i + 2]
						| (((uint16_t) WT931Receive[i + 3]) << 8));
				RecvWT931.Acceleration[1] = ((uint16_t) WT931Receive[i + 4]
						| (((uint16_t) WT931Receive[i + 5]) << 8));
				RecvWT931.Acceleration[2] = ((uint16_t) WT931Receive[i + 6]
						| (((uint16_t) WT931Receive[i + 7]) << 8));
				break;
			case 0x52:
				RecvWT931.AngularSpeed[0] = ((uint16_t) WT931Receive[i + 2]
						| (((uint16_t) WT931Receive[i + 3]) << 8));
				RecvWT931.AngularSpeed[1] = ((uint16_t) WT931Receive[i + 4]
						| (((uint16_t) WT931Receive[i + 5]) << 8));
				RecvWT931.AngularSpeed[2] = ((uint16_t) WT931Receive[i + 6]
						| (((uint16_t) WT931Receive[i + 7]) << 8));
				break;
			case 0x53:
				RecvWT931.EulerAngle[0] = ((uint16_t) WT931Receive[i + 2]
						| (((uint16_t) WT931Receive[i + 3]) << 8));
				RecvWT931.EulerAngle[1] = ((uint16_t) WT931Receive[i + 4]
						| (((uint16_t) WT931Receive[i + 5]) << 8));
				RecvWT931.EulerAngle[2] = ((uint16_t) WT931Receive[i + 6]
						| (((uint16_t) WT931Receive[i + 7]) << 8));
				break;
			case 0x54:
				RecvWT931.MagneticValue[0] = ((uint16_t) WT931Receive[i + 2]
						| (((uint16_t) WT931Receive[i + 3]) << 8));
				RecvWT931.MagneticValue[1] = ((uint16_t) WT931Receive[i + 4]
						| (((uint16_t) WT931Receive[i + 5]) << 8));
				RecvWT931.MagneticValue[2] = ((uint16_t) WT931Receive[i + 6]
						| (((uint16_t) WT931Receive[i + 7]) << 8));
				break;
			default:
				continue;
				break;
			}
		}
		else
		{
			continue;
		}
	}

	return RecvWT931;
}
#endif

