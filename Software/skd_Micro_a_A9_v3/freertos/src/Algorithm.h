/**
 * @file Algorithm.h
 * @brief 提供常用的软件算法 
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
#ifndef __ROV_ALGORITHM_H
#define __ROV_ALGORITHM_H
#include "Defines.h"

#ifdef __cplusplus
extern "C" {
#endif

#define BASICCTRL_MAX(x, y) ({\
							typeof(x) _x = (x);\
							typeof(y) _y = (y);\
							(void)(&_x == &_y);\
							_x > _y ? _x : _y;\
							})

#define BASICCTRL_MIN(x, y) ({\
							typeof(x) _x = (x);\
							typeof(y) _y = (y);\
							(void)(&_x == &_y);\
							_x < _y ? _x : _y;\
							})

#define BASICCTRL_RANGE(x, a, b) (BASICCTRL_MIN((BASICCTRL_MAX(x, a)), b))

/**
 * @brief 检查PWM控制数据是否正确
 * @param  pwm_value        待检查的PWM控制数据
 * @param  top_value        上限
 * @param  bottom_value     下限
 * @return u8 1正确；0错误
 */
#define CheckPwmValue(pwm_value, bottom_value, top_value) (((pwm_value <= top_value)\
                                                        &&(pwm_value >= bottom_value))?\
                                                        (1):(0))

/**
 * @brief PWM控制数据限幅
 * @param  pwm_value        要限幅的PWM控制数据
 * @param  top_value        上限
 * @param  bottom_value     下限
 */
#define RestrictPwmValue(pwm_value, bottom_value, top_value) pwm_value=((pwm_value)>=(bottom_value))?\
        (((pwm_value)<=(top_value))?(pwm_value):(top_value)):(bottom_value)

/**
 * @brief 将一个数据从某个区间映射到另一个目标区间
 * @param origin_data 原始数据
 * @param origin_bottom 原始数据下限
 * @param origin_top 原始数据上限
 * @param tatget_bottom 目标数据下限
 * @param target_top 目标数据上限
 * @return 目标区间上的数据值
 */
#define MAP(origin_data,origin_bottom,origin_top,tatget_bottom,target_top) \
            (((origin_data) - (origin_bottom)) * \
            ((target_top) - (tatget_bottom)) / \
            ((origin_top) - (origin_bottom))) + \
            (tatget_bottom)


//#define ABS(x) ({
//			long ret;
//			if (sizeof(x) == sizeof(long)) {
//				long __x = (x);
//				ret = (__x < 0) ? -__x : __x;
//			} else {
//				int __x = (x);
//				ret = (__x < 0) ? -__x : __x;
//			}
//		})


#ifdef CRC_LUT
/**
 * @brief LUT for crc8
 */
#define Crc8Caculate(CRC, C) (((CRC) = (crc8_table[(CRC) ^ (C)])) & 0xFF)
extern uint8_t crc8_lut[256];
#endif

typedef enum
{
	PID_POSITION_MODE = 0,
	PID_ERROR_MODE = 1
} PidAlgorithmMode;

struct Algorithm_PID
{
    uint8_t mode; //PID模式设置

    float_t Target; //目标值
    float_t FeedBack; //反馈值
    float_t FeedBack_gain; //反馈增益

    float_t Error; //误差
    float_t LastError; //上次误差
    float_t DeltaIntegral; //误差的积分
    float_t DeltaDifference; //误差的差分

    float_t Kp; //PID参数p
    float_t Ki; //PID参数i
    float_t Kd; //PID参数d

    float_t IntMinValue; //积分限幅
    float_t IntMaxValue; //积分限幅
    float_t IntDecay; //积分衰减
    float_t DifMinValue; //微分限幅
    float_t DifMaxValue; //微分限幅
    float_t OutMinValue; //输出限幅
    float_t OutMaxValue; //输出限幅

    float_t Output; //输出值
};
typedef struct Algorithm_PID* Algorithm_PID_t; /* PID控制ADT */

//struct Algorithm_PID_int
//{
//    uint8_t mode; //PID模式设置
//
//    int32_t Target; //目标值
//    int32_t FeedBack; //反馈值
//    int32_t FeedBack_gain; //反馈增益
//
//    int32_t Error; //误差
//    int32_t LastError; //上次误差
//    int32_t DeltaIntegral; //误差的积分
//
//    int32_t Kp; //PID参数p
//    int32_t Ki; //PID参数i
//    int32_t Kd; //PID参数d
//
//    int32_t Output; //输出值
//};
//typedef struct Algorithm_PID_int* Algorithm_PID_int_t; /* PID控制ADT */


struct Algorithm_Kalman
{
	float_t x_now; //测量值
    float_t x_last; //上次值
	float_t x_Pre; //预测值
    
    float_t Last_P; //先验估计协方差
    
	float_t Process_R; //测量噪声协方差
	float_t Measure_Q; //过程噪声协方差
    //q增大，动态响应变快，收敛稳定性变差
    //r增大，动态响应变慢，收敛稳定性变好
};
typedef struct Algorithm_Kalman* Algorithm_Kalman_t; /* 一维卡尔曼滤波控制ADT */

uint8_t SumCheck(uint8_t* rx_data, uint8_t data_size, uint8_t sum_check_bit);
void initPID(Algorithm_PID_t Pid, uint8_t mode, float_t fb_gain);
float_t calculatePID_position(Algorithm_PID_t Pid, float_t target, float_t value);
//float_t calculatePID(Algorithm_PID_t Pid, float_t target, float_t value, uint8_t mode);
//int32_t calculatePID_int(Algorithm_PID_int_t Pid, int32_t target, int32_t value);
//void InitKalman(Algorithm_Kalman_t Kalman, f32 Q, f32 R, KalmanMatrix_t P);
//uint16_t KalmanFilter(uint16_t original_value);

// uint8_t ParityCheck(uint8_t* CacString, uint8_t CacStringSize);
// uint16_t PositionalPID(uint16_t target_value, uint16_t actual_value);
// uint16_t IncrementalPID(uint16_t target_value, uint16_t actual_value);


#ifdef __cplusplus
}
#endif

#endif
