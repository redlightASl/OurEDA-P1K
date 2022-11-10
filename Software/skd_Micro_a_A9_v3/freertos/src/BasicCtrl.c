#include "BasicCtrl.h"
#include <math.h>


void MoveControl(PwmVal_t *ThrusterTemp, uint16_t StraightNum,
		uint16_t RotateNum, uint16_t VerticalNum, uint8_t ModeNum)
{
	uint8_t AFlag = 0;
	uint8_t BFlag = 0;
	uint8_t CFlag = 0;
	uint8_t DFlag = 0;
	uint8_t SFlag = 0;


#if (NUMBER_OF_VERTICAL_THRUSTER == 2) && (NUMBER_OF_HORIZENTAL_THRUSTER == 4)
	switch (ModeNum)
	{
	case NORMAL_MODE:
		//Horizental Control
		AFlag = (RotateNum > StraightNum);
		BFlag = ((RotateNum + StraightNum) > (2 * PWM_MIDDLE_POSITION));
		CFlag = (RotateNum > PWM_MIDDLE_POSITION);
		DFlag = (StraightNum > PWM_MIDDLE_POSITION);
		SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
		switch (SFlag)
		{
		case 0:
		case 15:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) (RotateNum);
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) (RotateNum);
			ThrusterTemp->HorizontalThruster[2] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			ThrusterTemp->HorizontalThruster[3] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			break;
		case 7:
		case 8:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) (StraightNum);
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) (StraightNum);
			ThrusterTemp->HorizontalThruster[2] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			ThrusterTemp->HorizontalThruster[3] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			break;
		case 5:
		case 10:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[2] = (uint32_t) (StraightNum);
			ThrusterTemp->HorizontalThruster[3] = (uint32_t) (StraightNum);
			break;
		case 1:
		case 14:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[2] = (uint32_t) (((2
					* PWM_MIDDLE_POSITION) - RotateNum));
			ThrusterTemp->HorizontalThruster[3] = (uint32_t) (((2
					* PWM_MIDDLE_POSITION) - RotateNum));
			break;
		}
		//Veritical Control
		ThrusterTemp->VerticalThruster[0] = (uint32_t) (VerticalNum);
		ThrusterTemp->VerticalThruster[1] = (uint32_t) (VerticalNum);
		break;
	case SIDEPUSH_MODE:
		//Horizental Control
		ThrusterTemp->HorizontalThruster[0] = (uint32_t) ((2
				* PWM_MIDDLE_POSITION) - RotateNum);
		ThrusterTemp->HorizontalThruster[1] = (uint32_t) (RotateNum);
		ThrusterTemp->HorizontalThruster[2] = (uint32_t) ((2
				* PWM_MIDDLE_POSITION) - RotateNum);
		ThrusterTemp->HorizontalThruster[3] = (uint32_t) (RotateNum);
		//Veritical Control
		ThrusterTemp->VerticalThruster[0] = (uint32_t) (VerticalNum);
		ThrusterTemp->VerticalThruster[1] = (uint32_t) (VerticalNum);
		break;
	case PITCH_MODE: //Unavailable in 6axis ROV
		break;
	case ROLL_MODE: //Unavailable in 6axis ROV
		break;
	case MIX_MODE: //Unavailable in 6axis ROV
		break;
	default:
		break;
	}

#else if (NUMBER_OF_VERTICAL_THRUSTER == 4) && (NUMBER_OF_HORIZENTAL_THRUSTER == 4)
    switch (ModeNum)
    {
    case NORMAL_MODE:
        //Horizental Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > 2 * PWM_MIDDLE_POSITION);
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 7:
        case 8:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 5:
        case 10:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            break;
        }
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)(VerticalNum);
        break;
    case SIDEPUSH_MODE:
        //Horizental Control
        ThrusterTemp.HorizontalThruster[0] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
        ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
        ThrusterTemp.HorizontalThruster[2] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
        ThrusterTemp.HorizontalThruster[3] = (uint32_t)(RotateNum);
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)(VerticalNum);
        break;
    case PITCH_MODE:
        //Horizental Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > 2 * PWM_MIDDLE_POSITION);
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 7:
        case 8:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 5:
        case 10:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            break;
        }
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        break;
    case ROLL_MODE:
        //Horizental Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > 2 * PWM_MIDDLE_POSITION);
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 7:
        case 8:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 5:
        case 10:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            break;
        }
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        break;
    case MIX_MODE:
        //Horizental Control
        ThrusterTemp.HorizontalThruster[0] = PWM_MIDDLE_POSITION;
        ThrusterTemp.HorizontalThruster[1] = PWM_MIDDLE_POSITION;
        ThrusterTemp.HorizontalThruster[2] = PWM_MIDDLE_POSITION;
        ThrusterTemp.HorizontalThruster[3] = PWM_MIDDLE_POSITION;
        //Veritical Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > (2 * PWM_MIDDLE_POSITION));
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            break;
        case 7:
        case 8:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            break;
        case 5:
        case 10:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
            break;
        }
        break;
    default:
        break;
    }
#endif
}

/*
PwmVal_t MoveControl( uint16_t StraightNum,
		uint16_t RotateNum, uint16_t VerticalNum, uint8_t ModeNum)
{
	uint8_t AFlag = 0;
	uint8_t BFlag = 0;
	uint8_t CFlag = 0;
	uint8_t DFlag = 0;
	uint8_t SFlag = 0;

	PwmVal_t ThrusterTemp;

#if (NUMBER_OF_VERTICAL_THRUSTER == 2) && (NUMBER_OF_HORIZENTAL_THRUSTER == 4)
	switch (ModeNum)
	{
	case NORMAL_MODE:
		//Horizental Control
		AFlag = (RotateNum > StraightNum);
		BFlag = ((RotateNum + StraightNum) > (2 * PWM_MIDDLE_POSITION));
		CFlag = (RotateNum > PWM_MIDDLE_POSITION);
		DFlag = (StraightNum > PWM_MIDDLE_POSITION);
		SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
		switch (SFlag)
		{
		case 0:
		case 15:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) (RotateNum);
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) (RotateNum);
			ThrusterTemp->HorizontalThruster[2] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			ThrusterTemp->HorizontalThruster[3] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			break;
		case 7:
		case 8:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) (StraightNum);
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) (StraightNum);
			ThrusterTemp->HorizontalThruster[2] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			ThrusterTemp->HorizontalThruster[3] =
					(uint32_t) ((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
			break;
		case 5:
		case 10:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[2] = (uint32_t) (StraightNum);
			ThrusterTemp->HorizontalThruster[3] = (uint32_t) (StraightNum);
			break;
		case 1:
		case 14:
			ThrusterTemp->HorizontalThruster[0] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[1] = (uint32_t) ((RotateNum
					+ StraightNum - PWM_MIDDLE_POSITION));
			ThrusterTemp->HorizontalThruster[2] = (uint32_t) (((2
					* PWM_MIDDLE_POSITION) - RotateNum));
			ThrusterTemp->HorizontalThruster[3] = (uint32_t) (((2
					* PWM_MIDDLE_POSITION) - RotateNum));
			break;
		}
		//Veritical Control
		ThrusterTemp->VerticalThruster[0] = (uint32_t) (VerticalNum);
		ThrusterTemp->VerticalThruster[1] = (uint32_t) (VerticalNum);
		break;
	case SIDEPUSH_MODE:
		//Horizental Control
		ThrusterTemp->HorizontalThruster[0] = (uint32_t) ((2
				* PWM_MIDDLE_POSITION) - RotateNum);
		ThrusterTemp->HorizontalThruster[1] = (uint32_t) (RotateNum);
		ThrusterTemp->HorizontalThruster[2] = (uint32_t) ((2
				* PWM_MIDDLE_POSITION) - RotateNum);
		ThrusterTemp->HorizontalThruster[3] = (uint32_t) (RotateNum);
		//Veritical Control
		ThrusterTemp->VerticalThruster[0] = (uint32_t) (VerticalNum);
		ThrusterTemp->VerticalThruster[1] = (uint32_t) (VerticalNum);
		break;
	case PITCH_MODE: //Unavailable in 6axis ROV
		break;
	case ROLL_MODE: //Unavailable in 6axis ROV
		break;
	case MIX_MODE: //Unavailable in 6axis ROV
		break;
	default:
		break;
	}

#else if (NUMBER_OF_VERTICAL_THRUSTER == 4) && (NUMBER_OF_HORIZENTAL_THRUSTER == 4)
    switch (ModeNum)
    {
    case NORMAL_MODE:
        //Horizental Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > 2 * PWM_MIDDLE_POSITION);
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 7:
        case 8:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 5:
        case 10:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            break;
        }
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)(VerticalNum);
        break;
    case SIDEPUSH_MODE:
        //Horizental Control
        ThrusterTemp.HorizontalThruster[0] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
        ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
        ThrusterTemp.HorizontalThruster[2] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
        ThrusterTemp.HorizontalThruster[3] = (uint32_t)(RotateNum);
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)(VerticalNum);
        break;
    case PITCH_MODE:
        //Horizental Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > 2 * PWM_MIDDLE_POSITION);
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 7:
        case 8:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 5:
        case 10:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            break;
        }
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        break;
    case ROLL_MODE:
        //Horizental Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > 2 * PWM_MIDDLE_POSITION);
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 7:
        case 8:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)((PWM_MIDDLE_POSITION - RotateNum + StraightNum));
            break;
        case 5:
        case 10:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.HorizontalThruster[0] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[1] = (uint32_t)((RotateNum + StraightNum - PWM_MIDDLE_POSITION));
            ThrusterTemp.HorizontalThruster[2] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            ThrusterTemp.HorizontalThruster[3] = (uint32_t)(((2 * PWM_MIDDLE_POSITION) - RotateNum));
            break;
        }
        //Veritical Control
        ThrusterTemp.VerticalThruster[0] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[1] = (uint32_t)(VerticalNum);
        ThrusterTemp.VerticalThruster[2] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        ThrusterTemp.VerticalThruster[3] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - VerticalNum);
        break;
    case MIX_MODE:
        //Horizental Control
        ThrusterTemp.HorizontalThruster[0] = PWM_MIDDLE_POSITION;
        ThrusterTemp.HorizontalThruster[1] = PWM_MIDDLE_POSITION;
        ThrusterTemp.HorizontalThruster[2] = PWM_MIDDLE_POSITION;
        ThrusterTemp.HorizontalThruster[3] = PWM_MIDDLE_POSITION;
        //Veritical Control
        AFlag = (RotateNum > StraightNum);
        BFlag = ((RotateNum + StraightNum) > (2 * PWM_MIDDLE_POSITION));
        CFlag = (RotateNum > PWM_MIDDLE_POSITION);
        DFlag = (StraightNum > PWM_MIDDLE_POSITION);
        SFlag = AFlag * 8 + BFlag * 4 + CFlag * 2 + DFlag;
        switch (SFlag)
        {
        case 0:
        case 15:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(RotateNum);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(RotateNum);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            break;
        case 7:
        case 8:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(StraightNum);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(StraightNum);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)(PWM_MIDDLE_POSITION - RotateNum + StraightNum);
            break;
        case 5:
        case 10:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)(StraightNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)(StraightNum);
            break;
        case 1:
        case 14:
            ThrusterTemp.VerticalThruster[0] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[1] = (uint32_t)(RotateNum + StraightNum - PWM_MIDDLE_POSITION);
            ThrusterTemp.VerticalThruster[2] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
            ThrusterTemp.VerticalThruster[3] = (uint32_t)((2 * PWM_MIDDLE_POSITION) - RotateNum);
            break;
        }
        break;
    default:
        break;
    }
#endif

    return ThrusterTemp;
}

*/
void CaptureReportData(ReportData_t SendData, uint8_t *ReportTransmit)
{
	ReportTransmit[0] = (uint8_t) (SendData.FrameHead);
	ReportTransmit[1] = (uint8_t) ((SendData.CabinFunction)
			| (SendData.WaterDetect << 1));
	ReportTransmit[2] = (uint8_t) ((SendData.CabinTemperature & 0xFF00) >> 8);
	ReportTransmit[3] = (uint8_t) (SendData.CabinTemperature & 0x00FF);
	ReportTransmit[4] =
			(uint8_t) ((SendData.CabinBarometric & 0xFF000000) >> 24);
	ReportTransmit[5] =
			(uint8_t) ((SendData.CabinBarometric & 0x00FF0000) >> 16);
	ReportTransmit[6] =
			(uint8_t) ((SendData.CabinBarometric & 0x0000FF00) >> 8);
	ReportTransmit[7] = (uint8_t) (SendData.CabinBarometric & 0x000000FF);
	ReportTransmit[8] = (uint8_t) ((SendData.CabinHumidity & 0xFF00) >> 8);
	ReportTransmit[9] = (uint8_t) (SendData.CabinHumidity & 0x00FF);
	ReportTransmit[10] = (uint8_t) ((SendData.AccNum[0] & 0xFF00) >> 8);
	ReportTransmit[11] = (uint8_t) (SendData.AccNum[0] & 0x00FF);
	ReportTransmit[12] = (uint8_t) ((SendData.AccNum[1] & 0xFF00) >> 8);
	ReportTransmit[13] = (uint8_t) (SendData.AccNum[1] & 0x00FF);
	ReportTransmit[14] = (uint8_t) ((SendData.AccNum[2] & 0xFF00) >> 8);
	ReportTransmit[15] = (uint8_t) (SendData.AccNum[2] & 0x00FF);
	ReportTransmit[16] = (uint8_t) ((SendData.RotNum[0] & 0xFF00) >> 8);
	ReportTransmit[17] = (uint8_t) (SendData.RotNum[0] & 0x00FF);
	ReportTransmit[18] = (uint8_t) ((SendData.RotNum[1] & 0xFF00) >> 8);
	ReportTransmit[19] = (uint8_t) (SendData.RotNum[1] & 0x00FF);
	ReportTransmit[20] = (uint8_t) ((SendData.RotNum[2] & 0xFF00) >> 8);
	ReportTransmit[21] = (uint8_t) (SendData.RotNum[2] & 0x00FF);
	ReportTransmit[22] = (uint8_t) ((SendData.EulNum[0] & 0xFF00) >> 8);
	ReportTransmit[23] = (uint8_t) (SendData.EulNum[0] & 0x00FF);
	ReportTransmit[24] = (uint8_t) ((SendData.EulNum[1] & 0xFF00) >> 8);
	ReportTransmit[25] = (uint8_t) (SendData.EulNum[1] & 0x00FF);
	ReportTransmit[26] = (uint8_t) ((SendData.EulNum[2] & 0xFF00) >> 8);
	ReportTransmit[27] = (uint8_t) (SendData.EulNum[2] & 0x00FF);
	ReportTransmit[28] = (uint8_t) ((SendData.MagNum[0] & 0xFF00) >> 8);
	ReportTransmit[29] = (uint8_t) (SendData.MagNum[0] & 0x00FF);
	ReportTransmit[30] = (uint8_t) ((SendData.MagNum[0] & 0xFF00) >> 8);
	ReportTransmit[31] = (uint8_t) (SendData.MagNum[0] & 0x00FF);
	ReportTransmit[32] = (uint8_t) ((SendData.MagNum[0] & 0xFF00) >> 8);
	ReportTransmit[33] = (uint8_t) (SendData.MagNum[0] & 0x00FF);
	ReportTransmit[34] = (uint8_t) ((SendData.SonarHeight & 0xFF000000) >> 24);
	ReportTransmit[35] = (uint8_t) ((SendData.SonarHeight & 0x00FF0000) >> 16);
	ReportTransmit[36] = (uint8_t) ((SendData.SonarHeight & 0x0000FF00) >> 8);
	ReportTransmit[37] = (uint8_t) (SendData.SonarHeight & 0x000000FF);
	ReportTransmit[38] = (uint8_t) ((SendData.SonarConfidence & 0xFF00) >> 8);
	ReportTransmit[39] = (uint8_t) (SendData.SonarConfidence & 0x00FF);
	ReportTransmit[40] = (uint8_t) ((SendData.WaterTemperature & 0xFF00) >> 8);
	ReportTransmit[41] = (uint8_t) (SendData.WaterTemperature & 0x00FF);
	ReportTransmit[42] = (uint8_t) ((SendData.WaterDepth & 0xFF00) >> 8);
	ReportTransmit[43] = (uint8_t) (SendData.WaterDepth & 0x00FF);
//	ReportTransmit[34] = 0x00;
//	ReportTransmit[35] = 0x00;
//	ReportTransmit[36] = 0x00;
//	ReportTransmit[37] = 0x00;
//	ReportTransmit[38] = 0x00;
//	ReportTransmit[39] = 0x00;
//	ReportTransmit[40] = 0x00;
//	ReportTransmit[41] = 0x00;
//	ReportTransmit[42] = 0x00;
//	ReportTransmit[43] = 0x00;
	ReportTransmit[44] = (uint8_t) 0x00;
	ReportTransmit[45] = (uint8_t) ((SendData.FrameEnd & 0xFF00) >> 8);
	ReportTransmit[46] = (uint8_t) (SendData.FrameEnd & 0x00FF);
}

ReportData_t ReportDataAnalysis(uint8_t *ReportReceive)
{
	ReportData_t temp_report;

	for (uint8_t i = 0; i < Slave_UART_RXLen * 2; i++)
	{
		if ((ReportReceive[i] == 0x25) && (ReportReceive[i + 45] == 0xFF)
				&& (ReportReceive[i + 46] == 0xFF)
				&& (ReportReceive[i + 44] == 0x00))
		{
			temp_report.FrameHead = (uint8_t) ReportReceive[i];
			temp_report.CabinFunction = (uint8_t) (ReportReceive[i + 1] & 0x01);
			temp_report.WaterDetect = (uint8_t) (ReportReceive[i + 1] & 0x02);

			temp_report.CabinTemperature =
					((uint16_t) ReportReceive[i + 2] << 8)
							| ((uint16_t) ReportReceive[i + 3]);
			temp_report.CabinBarometric = (((uint32_t) ReportReceive[i + 4])
					<< 24) | (((uint32_t) ReportReceive[i + 5]) << 16)
					| (((uint32_t) ReportReceive[i + 6]) << 8)
					| ((uint32_t) ReportReceive[i + 7]);
			temp_report.CabinHumidity = ((uint16_t) ReportReceive[i + 8] << 8)
					| ((uint16_t) ReportReceive[i + 9]);

			temp_report.AccNum[0] = ((uint16_t) ReportReceive[i + 10] << 8)
					| ((uint16_t) ReportReceive[i + 11]);
			temp_report.AccNum[1] = ((uint16_t) ReportReceive[i + 12] << 8)
					| ((uint16_t) ReportReceive[i + 13]);
			temp_report.AccNum[2] = ((uint16_t) ReportReceive[i + 14] << 8)
					| ((uint16_t) ReportReceive[i + 15]);
			temp_report.RotNum[0] = ((uint16_t) ReportReceive[i + 16] << 8)
					| ((uint16_t) ReportReceive[i + 17]);
			temp_report.RotNum[1] = ((uint16_t) ReportReceive[i + 18] << 8)
					| ((uint16_t) ReportReceive[i + 19]);
			temp_report.RotNum[2] = ((uint16_t) ReportReceive[i + 20] << 8)
					| ((uint16_t) ReportReceive[i + 21]);
			temp_report.EulNum[0] = ((uint16_t) ReportReceive[i + 22] << 8)
					| ((uint16_t) ReportReceive[i + 23]);
			temp_report.EulNum[1] = ((uint16_t) ReportReceive[i + 24] << 8)
					| ((uint16_t) ReportReceive[i + 25]);
			temp_report.EulNum[2] = ((uint16_t) ReportReceive[i + 26] << 8)
					| ((uint16_t) ReportReceive[i + 27]);
			temp_report.MagNum[0] = ((uint16_t) ReportReceive[i + 28] << 8)
					| ((uint16_t) ReportReceive[i + 29]);
			temp_report.MagNum[1] = ((uint16_t) ReportReceive[i + 30] << 8)
					| ((uint16_t) ReportReceive[i + 31]);
			temp_report.MagNum[2] = ((uint16_t) ReportReceive[i + 32] << 8)
					| ((uint16_t) ReportReceive[i + 33]);

			temp_report.SonarHeight = (((uint32_t) ReportReceive[i + 34]) << 24)
					| (((uint32_t) ReportReceive[i + 35]) << 16)
					| (((uint32_t) ReportReceive[i + 36]) << 8)
					| ((uint32_t) ReportReceive[i + 37]);
			temp_report.SonarConfidence =
					((uint16_t) ReportReceive[i + 38] << 8)
							| ((uint16_t) ReportReceive[i + 39]);

			temp_report.WaterTemperature = ((uint16_t) ReportReceive[i + 40]
					<< 8) | ((uint16_t) ReportReceive[i + 41]);
			temp_report.WaterDepth = ((uint16_t) ReportReceive[i + 42] << 8)
					| ((uint16_t) ReportReceive[i + 43]);

			temp_report.IdTest = (uint16_t) ReportReceive[i + 44];
			temp_report.FrameEnd = ((uint16_t) ReportReceive[i + 45] << 8)
					| ((uint16_t) ReportReceive[i + 46]);
		}
	}
	return temp_report;
}

//ControlData_t CaptureControlData(uint8_t *CommandReceive)
//{
//	ControlData_t CaptureData;
//
//	for (uint8_t i = 0; i < Master_UART_RXLen; i++)
//	{
//		if ((CommandReceive[i] == 0x25) && (CommandReceive[i + 29] == 0x21)
//				&& (CommandReceive[i + 28] == 0x00))
//		{
//			CaptureData.FrameHead = (CommandReceive[i]);
//			CaptureData.StraightNum = ((CommandReceive[i + 1] << 8)
//					| CommandReceive[i + 2]);
//			CaptureData.RotateNum = ((CommandReceive[i + 3] << 8)
//					| CommandReceive[i + 4]);
//			CaptureData.VerticalNum = ((CommandReceive[i + 5] << 8)
//					| CommandReceive[i + 6]);
//			CaptureData.LightNum = ((CommandReceive[i + 7] << 8)
//					| CommandReceive[i + 8]);
//			CaptureData.PanNum = ((CommandReceive[i + 9] << 8)
//					| CommandReceive[i + 10]);
//			CaptureData.ConveyNum = ((CommandReceive[i + 11] << 8)
//					| CommandReceive[i + 12]);
//
//			CaptureData.ArmNum[0] = ((CommandReceive[i + 13] << 8)
//					| CommandReceive[i + 14]);
//			CaptureData.ArmNum[1] = ((CommandReceive[i + 15] << 8)
//					| CommandReceive[i + 16]);
//			CaptureData.ArmNum[2] = ((CommandReceive[i + 17] << 8)
//					| CommandReceive[i + 18]);
//			CaptureData.ArmNum[3] = ((CommandReceive[i + 19] << 8)
//					| CommandReceive[i + 20]);
//			CaptureData.ArmNum[4] = ((CommandReceive[i + 21] << 8)
//					| CommandReceive[i + 22]);
//			CaptureData.ArmNum[5] = ((CommandReceive[i + 23] << 8)
//					| CommandReceive[i + 24]);
//			CaptureData.RestNum = ((CommandReceive[i + 25] << 8)
//					| CommandReceive[i + 26]);
//			CaptureData.Mode = CommandReceive[i + 27];
//			CaptureData.IdTest = CommandReceive[i + 28];
//			CaptureData.FrameEnd = (CommandReceive[i + 29]);
//		}
//		else
//		{
//			continue;
//		}
//	}
//
//	return CaptureData;
//}

void CaptureControlData(ControlData_t* CaptureData, uint8_t *CommandReceive)
{
	for (uint8_t i = 0; i < Master_UART_RXLen; i++)
	{
		if ((CommandReceive[i] == 0x25) && (CommandReceive[i + 29] == 0x21)
				&& (CommandReceive[i + 28] == 0x00))
		{
			CaptureData->FrameHead = (CommandReceive[i]);
			CaptureData->StraightNum = ((CommandReceive[i + 1] << 8)
					| CommandReceive[i + 2]);
			CaptureData->RotateNum = ((CommandReceive[i + 3] << 8)
					| CommandReceive[i + 4]);
			CaptureData->VerticalNum = ((CommandReceive[i + 5] << 8)
					| CommandReceive[i + 6]);
			CaptureData->LightNum = ((CommandReceive[i + 7] << 8)
					| CommandReceive[i + 8]);
			CaptureData->PanNum = ((CommandReceive[i + 9] << 8)
					| CommandReceive[i + 10]);
			CaptureData->ConveyNum = ((CommandReceive[i + 11] << 8)
					| CommandReceive[i + 12]);

			CaptureData->ArmNum[0] = ((CommandReceive[i + 13] << 8)
					| CommandReceive[i + 14]);
			CaptureData->ArmNum[1] = ((CommandReceive[i + 15] << 8)
					| CommandReceive[i + 16]);
			CaptureData->ArmNum[2] = ((CommandReceive[i + 17] << 8)
					| CommandReceive[i + 18]);
			CaptureData->ArmNum[3] = ((CommandReceive[i + 19] << 8)
					| CommandReceive[i + 20]);
			CaptureData->ArmNum[4] = ((CommandReceive[i + 21] << 8)
					| CommandReceive[i + 22]);
			CaptureData->ArmNum[5] = ((CommandReceive[i + 23] << 8)
					| CommandReceive[i + 24]);
			CaptureData->RestNum = ((CommandReceive[i + 25] << 8)
					| CommandReceive[i + 26]);
			CaptureData->Mode = CommandReceive[i + 27];
			CaptureData->IdTest = CommandReceive[i + 28];
			CaptureData->FrameEnd = (CommandReceive[i + 29]);
		}
		else
		{
			continue;
		}
	}
}


void ControlDataAnalysis(ControlData_t controller, PwmVal_t *temp_pwm,
		uint8_t ModeNum)
{
	MoveControl(temp_pwm, controller.StraightNum, controller.RotateNum,
			controller.VerticalNum, ModeNum);

	temp_pwm->LightServo = controller.LightNum; //light
	temp_pwm->PanServo = controller.PanNum; //pan
	temp_pwm->ConveyServo = controller.ConveyNum; //convey
	temp_pwm->ArmServo[0] = controller.ArmNum[0]; //Horizental
	temp_pwm->ArmServo[1] = controller.ArmNum[1]; //Main
	temp_pwm->ArmServo[2] = controller.ArmNum[2]; //Middle
	temp_pwm->ArmServo[3] = controller.ArmNum[3]; //Front
	temp_pwm->ArmServo[4] = controller.ArmNum[4]; //Grab
	temp_pwm->ArmServo[5] = controller.ArmNum[5]; //rest machine arm
	temp_pwm->RestServo = controller.RestNum; //rest pwm
}

void ControlDataGenerate(ControlData_t controller, uint8_t *CommandTransmit)
{
	CommandTransmit[0] = controller.FrameHead;

	CommandTransmit[1] = (uint8_t) ((controller.StraightNum & 0xFF00) >> 8);
	CommandTransmit[2] = (uint8_t) (controller.StraightNum & 0x00FF);
	CommandTransmit[3] = (uint8_t) ((controller.RotateNum & 0xFF00) >> 8);
	CommandTransmit[4] = (uint8_t) (controller.RotateNum & 0x00FF);
	CommandTransmit[5] = (uint8_t) ((controller.VerticalNum & 0xFF00) >> 8);
	CommandTransmit[6] = (uint8_t) (controller.VerticalNum & 0x00FF);

	CommandTransmit[7] = (uint8_t) ((controller.LightNum & 0xFF00) >> 8);
	CommandTransmit[8] = (uint8_t) (controller.LightNum & 0x00FF);

	CommandTransmit[9] = (uint8_t) ((controller.PanNum & 0xFF00) >> 8);
	CommandTransmit[10] = (uint8_t) (controller.PanNum & 0x00FF);

	CommandTransmit[11] = (uint8_t) ((controller.ConveyNum & 0xFF00) >> 8);
	CommandTransmit[12] = (uint8_t) (controller.ConveyNum & 0x00FF);

	CommandTransmit[13] = (uint8_t) ((controller.ArmNum[0] & 0xFF00) >> 8);
	CommandTransmit[14] = (uint8_t) (controller.ArmNum[0] & 0x00FF);
	CommandTransmit[15] = (uint8_t) ((controller.ArmNum[1] & 0xFF00) >> 8);
	CommandTransmit[16] = (uint8_t) (controller.ArmNum[1] & 0x00FF);
	CommandTransmit[17] = (uint8_t) ((controller.ArmNum[2] & 0xFF00) >> 8);
	CommandTransmit[18] = (uint8_t) (controller.ArmNum[2] & 0x00FF);
	CommandTransmit[19] = (uint8_t) ((controller.ArmNum[3] & 0xFF00) >> 8);
	CommandTransmit[20] = (uint8_t) (controller.ArmNum[3] & 0x00FF);
	CommandTransmit[21] = (uint8_t) ((controller.ArmNum[4] & 0xFF00) >> 8);
	CommandTransmit[22] = (uint8_t) (controller.ArmNum[4] & 0x00FF);
	CommandTransmit[23] = (uint8_t) ((controller.ArmNum[5] & 0xFF00) >> 8);
	CommandTransmit[24] = (uint8_t) (controller.ArmNum[5] & 0x00FF);

	CommandTransmit[25] = (uint8_t) ((controller.RestNum & 0xFF00) >> 8);
	CommandTransmit[26] = (uint8_t) (controller.RestNum & 0x00FF);

	CommandTransmit[27] = controller.Mode;
	CommandTransmit[28] = controller.IdTest;
	CommandTransmit[29] = controller.FrameEnd;
}
