

/***************************** Include Files *******************************/
#include "axi_wt931_decoder.h"

/************************** Function Definitions ***************************/

void wt931_GetAcc(IMUData_t* imu_data)
{
	uint32_t acc_data1;
	uint32_t acc_data2;

	acc_data1 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG0_OFFSET);
	acc_data2 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG1_OFFSET);

	imu_data->acc_x = (uint16_t)((acc_data1 & 0xFFFF0000) >> 16);
	imu_data->acc_y = (uint16_t)((acc_data1 & 0x0000FFFF) >> 0);
	imu_data->acc_z = (uint16_t)((acc_data2 & 0xFFFF0000) >> 16);
}

void wt931_GetRot(IMUData_t* imu_data)
{
	uint32_t rot_data1;
	uint32_t rot_data2;

	rot_data1 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG1_OFFSET);
	rot_data2 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG2_OFFSET);

	imu_data->rot_x = (uint16_t)((rot_data1 & 0x0000FFFF) >> 0);
	imu_data->rot_y = (uint16_t)((rot_data2 & 0xFFFF0000) >> 16);
	imu_data->rot_z = (uint16_t)((rot_data2 & 0x0000FFFF) >> 0);
}

void wt931_GetEul(IMUData_t* imu_data)
{
	uint32_t eul_data1;
	uint32_t eul_data2;

	eul_data1 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG3_OFFSET);
	eul_data2 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG4_OFFSET);

	imu_data->eul_x = (uint16_t)((eul_data1 & 0xFFFF0000) >> 16);
	imu_data->eul_y = (uint16_t)((eul_data1 & 0x0000FFFF) >> 0);
	imu_data->eul_z = (uint16_t)((eul_data2 & 0xFFFF0000) >> 16);
}

void wt931_GetMag(IMUData_t* imu_data)
{
	uint32_t mag_data1;
	uint32_t mag_data2;

	mag_data1 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG4_OFFSET);
	mag_data2 = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG5_OFFSET);

	imu_data->mag_x = (uint16_t)((mag_data1 & 0x0000FFFF) >> 0);
	imu_data->mag_y = (uint16_t)((mag_data2 & 0xFFFF0000) >> 16);
	imu_data->mag_z = (uint16_t)((mag_data2 & 0x0000FFFF) >> 0);
}

void wt931_GetTemp(IMUData_t* imu_data)
{
	uint32_t temp_data;
	temp_data = AXI_WT931_DECODER_mReadReg(AXI_WT931_DECODER_BASEADDR,
		AXI_WT931_DECODER_S00_AXI_SLV_REG6_OFFSET);
	imu_data->temperature = (uint16_t)((temp_data & 0xFFFF0000) >> 16);
}

