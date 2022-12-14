#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "xparameters.h"
#include "led.h"
#include "xil_io.h"
#include "queue.h"
#include "xgpio.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include "axi2gpio.h"
#include "xil_printf.h"
#include "xintc.h"
#include "semphr.h"
#include "BasicCtrl.h"
#include "PL_Device.h"
#include "axi_wt931_decoder.h"

static ControlData_t ctrdata;
static PwmVal_t      pwmval;
static ReportData_t  report;

#define control_bytes 30

static TaskHandle_t LEDTask;
static TaskHandle_t PWMTask;
static TaskHandle_t UARTTxTask;
static TaskHandle_t UARTRxTask;
static TaskHandle_t SENSORTask;
static void ledTask( void *pvParameters );
static void pwmTask( void *pvParameters );
static void uartTxTask( void *pvParameters );
static void uartRxTask( void *pvParameters );
static void sensorTask( void *pvParameters );

static void uart_handler(void *CallbackRef);
static void uart_init();
static ControlData_t control_analysis();
static void report_analysis(ReportData_t* SendData,uint32_t *ReportData);
static void matrixing(PwmVal_t* ThrusterTemp,u32* pwmval);

int main()
{
		uart_init();
		xTaskCreate( 	ledTask, 					/* The function that implements the task. */
						( const char * ) "LED", 		/* Text name for the task, provided to assist debugging only. */
						configMINIMAL_STACK_SIZE, 	/* The stack allocated to the task. */
						NULL, 						/* The task parameter is not used, so set to NULL. */
						tskIDLE_PRIORITY,			/* The task runs at the idle priority. */
						&LEDTask );
		xTaskCreate( 	pwmTask, 					/* The function that implements the task. */
						( const char * ) "PWM", 		/* Text name for the task, provided to assist debugging only. */
						configMINIMAL_STACK_SIZE, 	/* The stack allocated to the task. */
						NULL, 						/* The task parameter is not used, so set to NULL. */
						tskIDLE_PRIORITY,			/* The task runs at the idle priority. */
						&PWMTask );
		xTaskCreate( 	uartTxTask, 					/* The function that implements the task. */
						( const char * ) "UARTTx", 		/* Text name for the task, provided to assist debugging only. */
						configMINIMAL_STACK_SIZE+1024, 	/* The stack allocated to the task. */
						NULL, 						/* The task parameter is not used, so set to NULL. */
						tskIDLE_PRIORITY,			/* The task runs at the idle priority. */
						&UARTTxTask );
		xTaskCreate( 	uartRxTask, 					/* The function that implements the task. */
						( const char * ) "UARTRx", 		/* Text name for the task, provided to assist debugging only. */
						configMINIMAL_STACK_SIZE, 	/* The stack allocated to the task. */
						NULL, 						/* The task parameter is not used, so set to NULL. */
						tskIDLE_PRIORITY,			/* The task runs at the idle priority. */
						&UARTRxTask );
		xTaskCreate( 	sensorTask, 					/* The function that implements the task. */
						( const char * ) "SENSOR", 		/* Text name for the task, provided to assist debugging only. */
						configMINIMAL_STACK_SIZE, 	/* The stack allocated to the task. */
						NULL, 						/* The task parameter is not used, so set to NULL. */
						tskIDLE_PRIORITY,			/* The task runs at the idle priority. */
						&SENSORTask );
		vTaskStartScheduler();
}

static void ledTask( void *pvParameters )
{
	const TickType_t x500msecond = pdMS_TO_TICKS( DELAY_500m_SECOND );
	static u32 led_state=0x00000000;
	for(;;)
	{
		if(led_state==0x00000000)
		{
			led_state=0x00000001;
		}
		else
		{
			led_state=0x00000000;
		}
		LED_mWriteReg(AXI_LED,LED0,led_state);
		vTaskDelay( x500msecond );
	}
}

static u32 pwm[8];
static void pwmTask( void *pvParameters )
{
	const TickType_t x10msecond = pdMS_TO_TICKS( DELAY_10m_SECOND );
    u32 pwm_val0=0x010F423F;//50hz,pwm_en=1
    u32 pwm_val1=0x010F423F;
    u32 pwm_val2=0x010F423F;
    u32 pwm_val3=0x010F423F;
    u32 pwm_val4=0x010F423F;
    u32 pwm_val5=0x010F423F;
    u32 pwm_val6=0x010F423F;
    u32 pwm_val7=0x010F423F;

	AXI2GPIO_mWriteReg(AXI_PWM,pwm0,pwm_val0);
	AXI2GPIO_mWriteReg(AXI_PWM,pwm1,pwm_val1);
	AXI2GPIO_mWriteReg(AXI_PWM,pwm2,pwm_val2);
	AXI2GPIO_mWriteReg(AXI_PWM,pwm3,pwm_val3);
	AXI2GPIO_mWriteReg(AXI_PWM,pwm4,pwm_val4);
	AXI2GPIO_mWriteReg(AXI_PWM,pwm5,pwm_val5);
	AXI2GPIO_mWriteReg(AXI_PWM,pwm6,pwm_val6);
	AXI2GPIO_mWriteReg(AXI_PWM,pwm7,pwm_val7);
	for(;;)
	{
		matrixing(&pwmval,pwm);
		AXI2GPIO_mWriteReg(AXI_PWM,duc0,pwm[0]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc1,pwm[1]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc2,pwm[2]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc3,pwm[3]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc4,pwm[4]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc5,pwm[5]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc6,pwm[6]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc7,pwm[7]);
		/*
		AXI2GPIO_mWriteReg(AXI_PWM,duc0,pwmval.HorizontalThruster[0]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc1,pwmval.HorizontalThruster[1]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc2,pwmval.HorizontalThruster[2]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc3,pwmval.HorizontalThruster[3]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc4,pwmval.VerticalThruster[0]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc5,pwmval.VerticalThruster[1]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc6,pwmval.VerticalThruster[2]);
		AXI2GPIO_mWriteReg(AXI_PWM,duc7,pwmval.VerticalThruster[3]);
		*/
		vTaskDelay( x10msecond );
	}
}

//1000000/20000=50
static void matrixing(PwmVal_t* ThrusterTemp,u32* pwmval)
{
	pwmval[0]=(ThrusterTemp->HorizontalThruster[0])*50;
	pwmval[1]=(ThrusterTemp->HorizontalThruster[1])*50;
	pwmval[2]=ThrusterTemp->VerticalThruster[0]*50;
	pwmval[3]=(3000-ThrusterTemp->VerticalThruster[1])*50;

	pwmval[4]=ThrusterTemp->HorizontalThruster[2]*50;
	pwmval[5]=ThrusterTemp->HorizontalThruster[3]*50;
	pwmval[6]=ThrusterTemp->VerticalThruster[2]*50;
	pwmval[7]=ThrusterTemp->VerticalThruster[3]*50;
}

static u8 tx_data[47]="";
static u16 tx_cnt=0;
static u8 tx_done=1;
static void uartTxTask(void *pvParameters)
{
	const TickType_t x5msecond = pdMS_TO_TICKS( DELAY_5m_SECOND );
    u32 isr_status;
	for(;;)
	{
		isr_status = XUartLite_ReadReg(XPAR_AXI_UARTLITE_0_BASEADDR,XUL_STATUS_REG_OFFSET);

		if(!tx_done)
		{
			if(isr_status&Tx_EMPTY)
			{
				XUartLite_Send(&Uart,&tx_data[tx_cnt],1);
				//XUartLite_WriteReg(XPAR_AXI_UARTLITE_0_BASEADDR,XUL_TX_FIFO_OFFSET,(u8)tx_data[tx_cnt]);
				tx_cnt=tx_cnt+1;
			}
		}
		if(tx_cnt>=47)
		{
			tx_done=1;
		}

			vTaskDelay( x5msecond  );

	}
}

static u8 Rd_order[30]="";
static u8 Rx_Cnt=0;
static u8 recv_goon=0;
static u8 end_flag=0;
static void detect_head()
{
		if(Rd_order[0]==0x21)
		{
			end_flag=end_flag+1;
		}
		if(Rd_order[0]==0x25&&end_flag==1)
		{
			recv_goon=1;
			end_flag=0;
		}
		else
		{
			recv_goon=0;
		}
}


static void uartRxTask(void *pvParameters)
{
	const TickType_t x1msecond = pdMS_TO_TICKS( DELAY_1m_SECOND );
	u32 isr_status;
	u8 i=0;
	for(;;)
	{
	    //??????????????
	    isr_status = XUartLite_ReadReg(XPAR_AXI_UARTLITE_0_BASEADDR ,
	                                   XUL_STATUS_REG_OFFSET);
	    if(isr_status & RX_NOEMPTY){  //????FIFO????????
	    	        //????????
	        	//Rd_order[Rx_Cnt]=XUartLite_ReadReg(XPAR_AXI_UARTLITE_0_BASEADDR ,
	        	                                   // XUL_RX_FIFO_OFFSET);

	    	    	XUartLite_Recv(&Uart, &Rd_order[Rx_Cnt],1);
	    			if(Rx_Cnt==0)
	    			{
	    				detect_head();
	    			}
					if(recv_goon)
					{
						Rx_Cnt++;
					}
	   }

	    if(Rx_Cnt>=control_bytes)
	   	{
	    	if(Rd_order[29]==0x21)
	    	{
	   	    	ctrdata=control_analysis();
	   	    	//MoveControl(&pwmval, ctrdata.StraightNum,ctrdata.RotateNum, ctrdata.VerticalNum, ctrdata.Mode);
	   	    	//ControlDataAnalysis(ctrdata, &pwmval,ctrdata.Mode);
	   	    	pwmval.HorizontalThruster[0]=ctrdata.StraightNum;
	   	    	pwmval.HorizontalThruster[1]=ctrdata.RotateNum;
	   	    	pwmval.VerticalThruster[0]=ctrdata.VerticalNum;
	   	    	pwmval.VerticalThruster[1]=ctrdata.VerticalNum;
	   	    	recv_goon=0;
	   	    	//XUartLite_WriteReg(XPAR_AXI_UARTLITE_0_BASEADDR,XUL_TX_FIFO_OFFSET, pwmval.VerticalThruster[0]);
	   	    	//XUartLite_WriteReg(XPAR_AXI_UARTLITE_0_BASEADDR,XUL_TX_FIFO_OFFSET, ctrdata.VerticalNum); //????????
	   	    	Rx_Cnt=0;
	   	    	end_flag=1;

	   			for(i=0;i<control_bytes;i++)
	   			{
	   				Rd_order[i]=0x00;
	   			}
	    	}
	    	else
	    	{
	   			for(i=0;i<control_bytes;i++)
	   			{
	   				Rd_order[i]=0x00;
	   			}
	    	}

	   	 }
		vTaskDelay( x1msecond  );
	}
}


static void sensorTask(void *pvParameters)
{
	const TickType_t x5msecond = pdMS_TO_TICKS( DELAY_5m_SECOND );
	u16 report_data[13]={0}; //data_accx,data_accy,data_accz,data_rotx,data_roty,data_rotz,data_eulx,data_euly,data_eulz,data_magx,data_magy,data_magz,data_tem,data_recvdone;
	for(;;)
	{
		//acc x y z
		report_data[0]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,accxy)&0xFFFF0000)>>16);
		report_data[1]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,accxy)&0x0000FFFF));
		report_data[2]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,accz_rotx)&0xFFFF0000)>>16);
		//rot x y z
		report_data[3]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,accz_rotx)&0x0000FFFF));
		report_data[4]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,rotyz)&0xFFFF0000)>>16);
		report_data[5]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,rotyz)&0x0000FFFF));
		//eul x y z
		report_data[6]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,eulxy)&0xFFFF0000)>>16);
		report_data[7]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,eulxy)&0x0000FFFF));
		report_data[8]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,eulz_magx)&0xFFFF0000)>>16);
		//mag x y z
		report_data[9]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,eulz_magx)&0x0000FFFF));
		report_data[10]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,magyz)&0xFFFF0000)>>16);
		report_data[11]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,magyz)&0x0000FFFF));

		report_data[12]=(u16)((AXI_WT931_DECODER_mReadReg(AXI_sensor,temp_h)&0xFFFF0000)>>16);

		//report_analysis(&report,report_data);
		//CaptureReportData(report,tx_data);
		report_analysis(&report,report_data);
		if(tx_done)
		{
			CaptureReportData(report,tx_data);
			tx_cnt=0;
			tx_done=0;
		}



		//xil_printf("acc_x:%d,acc_y:%d,acc_z:%d\r\n",data_accx,data_accy,data_accz);
		//xil_printf("rot_x:%d,rot_y:%d,rot_z:%d\r\n",data_rotx,data_roty,data_rotz);
		//xil_printf("eul_x:%d,eul_y:%d,eul_z:%d\r\n",data_eulx,data_euly,data_eulz);
		//xil_printf("mag_x:%d,mag_y:%d,mag_z:%d\r\n",data_magx,data_magy,data_magz);
		//xil_printf("tempature:%d\r\n",data_tem);
		//xil_printf("\r\n");
		vTaskDelay( x5msecond  );
	}
}

static void uart_init()
{
	  //??????????????
	    XUartLite_Initialize(&Uart , UART_DEVICE_ID);
	    //????????????????
	    XIntc_Initialize(&Intc, INTC_ID);
	    //????????????
	    XIntc_Connect(&Intc, UART_INTR_ID,(XInterruptHandler)uart_handler,&Uart);
	    //????????
	    XUartLite_EnableInterrupt(&Uart);
	    //??????????????
	    XIntc_Start(&Intc, XIN_REAL_MODE);
	    //??????????????
	    XIntc_Enable(&Intc,UART_INTR_ID);
	    //??????????????????????????
	    Xil_ExceptionInit();
	        Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
	                (Xil_ExceptionHandler)XIntc_InterruptHandler , &Intc);
	        Xil_ExceptionEnable();

}


static void uart_handler(void *CallbackRef)
{
	/*
    u8 Read_data;
    u32 isr_status;

    XUartLite *InstancePtr= (XUartLite *)CallbackRef;
    //??????????????
    isr_status = XUartLite_ReadReg(InstancePtr->RegBaseAddress ,
                                   XUL_STATUS_REG_OFFSET);
    if(isr_status & RX_NOEMPTY){  //????FIFO????????
        //????????
        Read_data=XUartLite_ReadReg(InstancePtr->RegBaseAddress ,
                                    XUL_RX_FIFO_OFFSET);
        //????????
       // XUartLite_WriteReg(InstancePtr->RegBaseAddress ,
                          // XUL_TX_FIFO_OFFSET, Read_data);
    }
    */
}

//analysis function
static ControlData_t  control_analysis()
{
	 ControlData_t controller;

	controller.FrameHead=Rd_order[0];
	controller.StraightNum=((u16)Rd_order[1]<<8)|Rd_order[2];
	controller.RotateNum=((u16)Rd_order[3]<<8)|Rd_order[4];
	controller.VerticalNum=((u16)Rd_order[5]<<8)|Rd_order[6];
	controller.LightNum=((u16)Rd_order[7]<<8)|Rd_order[8];
	controller.PanNum=((u16)Rd_order[9]<<8)|Rd_order[10];
	controller.ConveyNum=((u16)Rd_order[11]<<8)|Rd_order[12];
	controller.ArmNum[0]=((u16)Rd_order[13]<<8)|Rd_order[14];
	controller.ArmNum[1]=((u16)Rd_order[15]<<8)|Rd_order[16];
	controller.ArmNum[2]=((u16)Rd_order[17]<<8)|Rd_order[18];
	controller.ArmNum[3]=((u16)Rd_order[19]<<8)|Rd_order[20];
	controller.ArmNum[4]=((u16)Rd_order[21]<<8)|Rd_order[22];
	controller.ArmNum[5]=((u16)Rd_order[23]<<8)|Rd_order[24];
	controller.RestNum=((u16)Rd_order[25]<<8)|Rd_order[26];
	controller.Mode=Rd_order[27];
	controller.IdTest=Rd_order[28];
	controller.FrameEnd=Rd_order[29];

	 /*
	controller.FrameHead=Rd_order[0];
	controller.StraightNum=((u16)Rd_order[1]<<8)|Rd_order[2];
	controller.RotateNum=((u16)Rd_order[3]<<8)|Rd_order[4];
	controller.VerticalNum=((u16)Rd_order[5]<<8)|Rd_order[6];
	controller.LightNum=((u16)Rd_order[7]<<8)|Rd_order[8];
	controller.PanNum=((u16)Rd_order[9]<<8)|Rd_order[10];
	controller.ConveyNum=((u16)Rd_order[11]<<8)|Rd_order[12];
	controller.ArmNum[0]=0x0000;
	controller.ArmNum[1]=0x0000;
	controller.ArmNum[2]=0x0000;
	controller.ArmNum[3]=0x0000;
	controller.ArmNum[4]=0x0000;
	controller.ArmNum[5]=0x0000;
	controller.RestNum=((u16)Rd_order[13]<<8)|Rd_order[14];
	controller.Mode=Rd_order[15];
	controller.IdTest=Rd_order[16];
	controller.FrameEnd=Rd_order[17];
	*/
	return controller;
}

static void report_analysis(ReportData_t* SendData,uint32_t *ReportData)
{
	SendData->FrameHead=0x25;
	SendData->CabinFunction=0x00;
	SendData->WaterDetect=0x00;
	SendData->CabinTemperature=(u16)ReportData[12];
	SendData->CabinBarometric=0x00000000;
	SendData->CabinHumidity=0x0000;
	SendData->AccNum[0]=(u16)ReportData[0];//(u16)ReportData[0]
	SendData->AccNum[1]=(u16)ReportData[1];
	SendData->AccNum[2]=(u16)ReportData[2];
	SendData->RotNum[0]=(u16)ReportData[3];
	SendData->RotNum[1]=(u16)ReportData[4];
	SendData->RotNum[2]=(u16)ReportData[5];
	SendData->EulNum[0]=(u16)ReportData[6];
	SendData->EulNum[1]=(u16)ReportData[7];
	SendData->EulNum[2]=(u16)ReportData[8];
	SendData->MagNum[0]=(u16)ReportData[9];
	SendData->MagNum[1]=(u16)ReportData[10];
	SendData->MagNum[2]=(u16)ReportData[11];
	SendData->SonarHeight=0x00000000;
	SendData->SonarConfidence=0x0000;
	SendData->WaterTemperature=0x0000;
	SendData->WaterDepth=0x0000;
	SendData->IdTest=0x00;
	SendData->FrameEnd=0xFFFF;

}




