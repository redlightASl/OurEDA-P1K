
#ifndef AXI_WT931_DECODER_H
#define AXI_WT931_DECODER_H


/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"

#include "xparameters.h"

#define AXI_WT931_DECODER_BASEADDR XPAR_AXI_WT931_DECODER_0_S00_AXI_BASEADDR

#define AXI_WT931_DECODER_S00_AXI_SLV_REG0_OFFSET 0
#define AXI_WT931_DECODER_S00_AXI_SLV_REG1_OFFSET 4
#define AXI_WT931_DECODER_S00_AXI_SLV_REG2_OFFSET 8
#define AXI_WT931_DECODER_S00_AXI_SLV_REG3_OFFSET 12
#define AXI_WT931_DECODER_S00_AXI_SLV_REG4_OFFSET 16
#define AXI_WT931_DECODER_S00_AXI_SLV_REG5_OFFSET 20
#define AXI_WT931_DECODER_S00_AXI_SLV_REG6_OFFSET 24


/**************************** Type Definitions *****************************/
/**
 *
 * Write a value to a AXI_WT931_DECODER register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the AXI_WT931_DECODERdevice.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void AXI_WT931_DECODER_mWriteReg(u32 BaseAddress, unsigned RegOffset, u32 Data)
 *
 */
#define AXI_WT931_DECODER_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/**
 *
 * Read a value from a AXI_WT931_DECODER register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the AXI_WT931_DECODER device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	u32 AXI_WT931_DECODER_mReadReg(u32 BaseAddress, unsigned RegOffset)
 *
 */
#define AXI_WT931_DECODER_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes ****************************/
/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the AXI_WT931_DECODER instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus AXI_WT931_DECODER_Reg_SelfTest(void * baseaddr_p);


struct IMUData {
	uint16_t acc_x;
	uint16_t acc_y;
	uint16_t acc_z;

	uint16_t rot_x;
	uint16_t rot_y;
	uint16_t rot_z;

	uint16_t eul_x;
	uint16_t eul_y;
	uint16_t eul_z;

	uint16_t mag_x;
	uint16_t mag_y;
	uint16_t mag_z;

	uint16_t temperature;
};
typedef struct IMUData IMUData_t;

void wt931_GetAcc(IMUData_t* imu_data);
void wt931_GetRot(IMUData_t* imu_data);
void wt931_GetEul(IMUData_t* imu_data);
void wt931_GetMag(IMUData_t* imu_data);
void wt931_GetTemp(IMUData_t* imu_data);


#endif // AXI_WT931_DECODER_H
