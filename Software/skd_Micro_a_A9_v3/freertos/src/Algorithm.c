#include "Algorithm.h"
#include <stdlib.h>


#define SUM 1
#define CRC 2
#define PARITY 3
#define EVEN 4

#define GET_BIT_N_VAL(data, n) (0x1 & (( *((data) + (n)/8) & (0x1 << ((n)%8)) ) >> ((n)%8)))

static uint8_t XorCaculate(uint8_t *CacString, uint8_t CacStringSize);
#ifdef CRC_LUT
static void Crc8Caculate_LUT_Init(void);
#else
static uint8_t Crc8Caculate(uint8_t *CacString, uint8_t CacStringSize);
#endif
static uint8_t ParityCalculate(uint8_t *CacString, uint8_t CacStringSize);

/**
 * @brief 异或运算
 * @param  CacString        待校验数据
 * @param  CacStringSize    待校验数据长度
 * @return uint8_t 异或运算值
 */
static uint8_t XorCaculate(uint8_t *CacString, uint8_t CacStringSize)
{
	uint8_t CacResult = CacString[0];
	for (uint8_t i = 1; i < CacStringSize; ++i)
	{
		CacResult ^= CacString[i];
	}
	return CacResult;
}

#ifdef CRC_LUT
uint8_t crc8_lut[256];
/**
 * @brief construct CRC8 Look-Up-Table
 */
static void Crc8Caculate_LUT_Init(void)
{
    uint8_t crc = 0;
    for (uint16_t i = 0; i < 256; i++)
    {
        crc = i;
        for (uint8_t j = 0; j < 8; j++)
        {
            crc = (crc << 1) ^ ((crc & 0x80) ? 0x07 : 0);
        }
        crc8_lut[i] = crc & 0xFF;
    }
}
#else
/**
 * @brief CRC8校验
 * @param  CacString        待校验数据
 * @param  CacStringSize    待校验数据长度
 * @return uint8_t CRC8运算值
 */
static uint8_t Crc8Caculate(uint8_t *CacString, uint8_t CacStringSize)
{
	const uint16_t CRC8_POLY = 0x0107; // X^8+X^2+X^1+1
	uint8_t CacResult;
	for (int num = CacStringSize; num > 0; num--)
	{
		CacResult = CacResult ^ (*CacString++ << 8);
		for (uint8_t i = 0; i < 8; i++)
		{
			if (CacResult & 0x8000)
			{
				CacResult = (CacResult << 1) ^ CRC8_POLY;
			}
			else
			{
				CacResult <<= 1;
			}
		}
		CacResult &= 0xFFFF;
	}
	return CacResult;
}
#endif

/**
 * @brief 奇偶运算
 * @param  CacString        待校验数据
 * @param  CacStringSize    待校验数据长度
 * @return uint8_t 奇偶运算结果
 */
static uint8_t ParityCalculate(uint8_t *CacString, uint8_t CacStringSize)
{
	uint8_t CacResult = 0;
	for (uint8_t i = 0; i < CacStringSize; i++)
	{
		CacResult += CacResult + GET_BIT_N_VAL((CacString), i);
	}
	if (CacResult % 2 == 0)
	{
		return ROV_TRUE;
	}
	else
	{
		return ROV_FALSE;
	}
}

/**
 * @brief
 * @param  rx_data          MyParamdoc
 * @param  data_size        MyParamdoc
 * @param  sum_check_bit    MyParamdoc
 * @return uint8_t
 */
uint8_t SumCheck(uint8_t *rx_data, uint8_t data_size, uint8_t sum_check_bit)
{
	uint8_t i = 0;
	uint8_t data_sum = 0;

	for (i = 0; i < data_size - 1; i++)
	{
		data_sum += rx_data[i];
	}

	if (data_sum == sum_check_bit)
	{
		return ROV_TRUE; //true
	}
	else
	{
		return ROV_FALSE; //false
	}
}

void initPID(Algorithm_PID_t Pid, uint8_t mode, float_t fb_gain)
{
	Pid->mode = mode;
	Pid->FeedBack_gain = fb_gain;
#ifdef FIXED_PID_PARAMETER
//    if ()
//    {
//        Pid->Kp = ;
//        Pid->Ki = ;
//        Pid->Kd = ;
//    }
//    else
//    {
//
//    }
#else
	Pid->Kp = 0.5;
	Pid->Ki = 0.3;
	Pid->Kd = 0.7;
	Pid->IntDecay = 10;
	Pid->IntMinValue = -30;
	Pid->IntMaxValue = 30;
	Pid->DifMinValue = -50;
	Pid->DifMaxValue = 50;
	Pid->OutMinValue = -100;
	Pid->OutMaxValue = -100;
	Pid->Error = 0.0;
	Pid->LastError = 0.0;
	Pid->Output = 0.0;
#endif
}

float_t calculatePID_position(Algorithm_PID_t Pid, float_t target,
		float_t value)
{
	Pid->Target = target;
	Pid->Error = Pid->Target - value; //calculate err(t)

	//only for this work
	if (abs(Pid->Error) > 32768)
	{
		if (value > 32768)
		{
			Pid->Error += 32768;
		}
		else
		{
			Pid->Error -= 32768;
		}
	}

	//calculate integrate
	Pid->DeltaIntegral += Pid->Error;
	if ((Pid->Error < -5) || (Pid->Error > 5))
	{
		Pid->DeltaIntegral -= Pid->IntDecay;
		if (Pid->DeltaIntegral <= 0)
		{
			Pid->DeltaIntegral = 0;
		}
	}

	if (Pid->DeltaIntegral > Pid->IntMaxValue) //restrict integrate
	{
		Pid->DeltaIntegral = Pid->IntMaxValue;
	}
	else if (Pid->DeltaIntegral < Pid->IntMinValue)
	{
		Pid->DeltaIntegral = Pid->IntMinValue;
	}

	//calculate difference
	Pid->DeltaDifference = Pid->Error - Pid->LastError;
	if (Pid->DeltaDifference > Pid->DifMaxValue) //restrict difference
	{
		Pid->DeltaDifference = Pid->DifMaxValue;
	}
	else if (Pid->DeltaDifference < Pid->DifMinValue)
	{
		Pid->DeltaDifference = Pid->DifMinValue;
	}

	Pid->Output = Pid->Kp * Pid->Error + Pid->Ki * Pid->DeltaIntegral
			+ Pid->Kd * Pid->DeltaDifference; //PID

	if (Pid->Output < Pid->OutMinValue) //restrict output
	{
		Pid->Output = Pid->OutMinValue;
	}
	else if (Pid->Output > Pid->OutMaxValue)
	{
		Pid->Output = Pid->OutMaxValue;
	}

	Pid->LastError = Pid->Error; //load err_1(t)
	Pid->FeedBack = Pid->Output * Pid->FeedBack_gain; //load feedback

	return Pid->Output;
}

//float_t calculatePID_error(Algorithm_PID_t Pid, float_t value)
//{
//	Pid->Error = Pid->Target - value; //calculate err(t)
//}

//float_t calculatePID(Algorithm_PID_t Pid, float_t target, float_t value,
//		uint8_t mode)
//{
//	if (mode == PID_POSITION_MODE)
//	{
//		Pid->Target = target;
//		Pid->Error = Pid->Target - value; //calculate err(t)
//
//		//calculate integrate
//		Pid->DeltaIntegral += Pid->Error;
//		if ((Pid->Error < -5) || (Pid->Error > 5))
//		{
//			Pid->DeltaIntegral -= Pid->IntDecay;
//			if (Pid->DeltaIntegral <= 0)
//			{
//				Pid->DeltaIntegral = 0;
//			}
//		}
//
//		if (Pid->DeltaIntegral > Pid->IntMaxValue) //restrict integrate
//		{
//			Pid->DeltaIntegral = Pid->IntMaxValue;
//		}
//		else if (Pid->DeltaIntegral < Pid->IntMinValue)
//		{
//			Pid->DeltaIntegral = Pid->IntMinValue;
//		}
//
//		//calculate difference
//		Pid->DeltaDifference = Pid->Error - Pid->LastError;
//		if (Pid->DeltaDifference > Pid->DifMaxValue) //restrict difference
//		{
//			Pid->DeltaDifference = Pid->DifMaxValue;
//		}
//		else if (Pid->DeltaDifference < Pid->DifMinValue)
//		{
//			Pid->DeltaDifference = Pid->DifMinValue;
//		}
//
//		Pid->Output = Pid->Kp * Pid->Error + Pid->Ki * Pid->DeltaIntegral
//				+ Pid->Kd * Pid->DeltaDifference; //PID
//
//		if (Pid->Output < Pid->OutMinValue) //restrict output
//		{
//			Pid->Output = Pid->OutMinValue;
//		}
//		else if (Pid->Output > Pid->OutMaxValue)
//		{
//			Pid->Output = Pid->OutMaxValue;
//		}
//
//		Pid->LastError = Pid->Error; //load err_1(t)
//		Pid->FeedBack = Pid->Output * Pid->FeedBack_gain; //load feedback
//
//		return Pid->Output;
//	}
//	else if (mode == PID_ERROR_MODE)
//	{
//		Pid->Target = target;
//		Pid->Error = Pid->Target - Pid->FeedBack; //calculate err(t)
//
//		//calculate integrate
//		Pid->DeltaIntegral += Pid->Error;
//		if ((Pid->Error < -5) || (Pid->Error > 5))
//		{
//			Pid->DeltaIntegral -= Pid->IntDecay;
//			if (Pid->DeltaIntegral <= 0)
//			{
//				Pid->DeltaIntegral = 0;
//			}
//		}
//
//		if (Pid->DeltaIntegral > Pid->IntMaxValue) //restrict integrate
//		{
//			Pid->DeltaIntegral = Pid->IntMaxValue;
//		}
//		else if (Pid->DeltaIntegral < Pid->IntMinValue)
//		{
//			Pid->DeltaIntegral = Pid->IntMinValue;
//		}
//
//		//calculate difference
//		Pid->DeltaDifference = Pid->Error - Pid->LastError;
//		if (Pid->DeltaDifference > Pid->DifMaxValue) //restrict difference
//		{
//			Pid->DeltaDifference = Pid->DifMaxValue;
//		}
//		else if (Pid->DeltaDifference < Pid->DifMinValue)
//		{
//			Pid->DeltaDifference = Pid->DifMinValue;
//		}
//
//		Pid->Output = Pid->Kp * Pid->Error + Pid->Ki * Pid->DeltaIntegral
//				+ Pid->Kd * Pid->DeltaDifference; //PID
//
//		if (Pid->Output < Pid->OutMinValue) //restrict output
//		{
//			Pid->Output = Pid->OutMinValue;
//		}
//		else if (Pid->Output > Pid->OutMaxValue)
//		{
//			Pid->Output = Pid->OutMaxValue;
//		}
//
//		Pid->LastError = Pid->Error; //load err_1(t)
//		Pid->FeedBack = Pid->Output * Pid->FeedBack_gain; //load feedback
//
//		return Pid->Output;
//	}
//}

//int32_t calculatePID_int(Algorithm_PID_int_t Pid, int32_t target, int32_t value)
//{
//	Pid->Target = target;
//	Pid->Error = Pid->Target - target; //calculate err(t)
//
//	//calculate integrate
//	Pid->DeltaIntegral += Pid->Error;
//	if ((Pid->Error < -5) || (Pid->Error > 5))
//	{
//		Pid->DeltaIntegral -= 10;
//		if (Pid->DeltaIntegral <= 0)
//		{
//			Pid->DeltaIntegral = 0;
//		}
//	}
//
//	if (Pid->DeltaIntegral > 30) //restrict integrate
//	{
//		Pid->DeltaIntegral = 30;
//	}
//	else if (Pid->DeltaIntegral < -30)
//	{
//		Pid->DeltaIntegral = -30;
//	}
//
//	Pid->Output = Pid->Kp * Pid->Error + Pid->Ki * Pid->DeltaIntegral
//			+ Pid->Kd * (Pid->Error - Pid->LastError); //PID
//
//	if (Pid->Output < -200) //restrict output
//	{
//		Pid->Output = -200;
//	}
//	else if (Pid->Output > 200)
//	{
//		Pid->Output = 200;
//	}
//
//	Pid->LastError = Pid->Error; //load err_1(t)
//	Pid->FeedBack = Pid->Output * Pid->FeedBack_gain; //load feedback
//
//	return Pid->Output;
//}

///**
// * @brief
// * @param  Kalman           MyParamdoc
// * @param  P                MyParamdoc
// * @param  R                MyParamdoc
// * @param  Q                MyParamdoc
// */
//void InitKalman(Algorithm_Kalman_t Kalman, float_t P, float_t R, float_t Q)
//{
//    Kalman->Last_P = P;
//    Kalman->Process_R = R;
//    Kalman->Measure_Q = Q;
//}
//
///**
// * @brief
// * @param  Kalman           MyParamdoc
// * @param  original_value   MyParamdoc
// * @return float_t
// */
//float_t KalmanFilter(Algorithm_Kalman_t Kalman, float_t original_value)
//{
//    float_t p_mid = 0.0;
//    float_t kg = 0.0;
//    float_t p_now = 0.0;
//
//    p_mid = Kalman->Last_P + Kalman->Measure_Q;
//    kg = p_mid / (p_mid + Kalman->Process_R);
//
//    Kalman->x_now = Kalman->x_last + kg * (original_value - Kalman->x_last); //最优值估计
//    p_now = (1 - kg) * p_mid; //最优值对应的协方差
//
//    Kalman->Last_P = p_now;
//    Kalman->x_last = Kalman->x_now;
//
//    return Kalman->x_now;
//}

/**
 * @brief 校验位检查
 * @param  String           待校验的数据
 * @param  Method           校验算法
 * @param  StringLength     数据长度
 * @param  IdBitAddr        校验位偏移量
 * @return u8 正确为1；错误为0，如果不开启校验默认为1
 */
static uint8_t IdTest(uint8_t *String, uint8_t Method, uint8_t StringLength,
		uint8_t IdBitAddr)
{
#ifdef DATA_IDENTIFY
    switch (Method)
    {
    case SUM: //加和校验
        break;
    case CRC: //CRC8校验
        break;
    case PARITY: //奇校验
        if (*(String + IdBitAddr) == XorCaculate(String, IdBitAddr))
        {
            return 1;
        }
        else
        {
            return 0;
        }
        break;
    case EVEN: //偶校验
        break;
    default:
        return 0;
        break;
    }
#else
	return 1; //不开启校验时默认成功
#endif
}

