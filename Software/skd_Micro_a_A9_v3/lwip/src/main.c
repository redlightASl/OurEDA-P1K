#include "xparameters.h"
#include "xil_exception.h"
#include "xstatus.h"
#include "xuartps.h"
#include "xdebug.h"
#include "xscugic.h"
#include "sleep.h"
#include "user_udp.h"
#include "sys_intr.h"
#include "xscutimer.h"

//uart
XUartPs uart0_inst;		//handle of UART0, to PC
XUartPs_Config *uart0_config;
#define UART0_ID  XPAR_PS7_UART_0_DEVICE_ID		//defined in xparameters.h

XScuTimer Timer;
#define TIMER_DEVICE_ID     XPAR_XSCUTIMER_0_DEVICE_ID
#define TIMER_IRPT_INTR     XPAR_SCUTIMER_INTR
#define TIMER_LOAD_VALUE    0x319750

static  XScuGic Intc;   //GIC
extern unsigned udp_connected_flag;
static void uart_init();
void timer_intr_handler(void *CallBackRef);
void timer_intr_init(XScuGic *intc_ptr,XScuTimer *timer_ptr);
int timer_init(XScuTimer *timer_ptr);
static void detect_head();
static void detect_end();

u8 recv[30]="";	//udp recv buffer
u8 report[47]="";//uart recv from microblaze
u8 recv_cnt=0;
u8 recv_goon=0;

u8 recv_done=0; //udp recv done
int main(void)
{

	struct netif *netif, server_netif;
	ip_addr_t ipaddr, netmask, gw;


	unsigned char mac_ethernet_address [] =
		{0x00, 0x0a, 0x35, 0x00, 0x01, 0x02};

	Init_Intr_System(&Intc);
	Setup_Intr_Exception(&Intc);
	uart_init();

	netif = &server_netif;
	IP4_ADDR(&ipaddr,  192, 168,   1, 10);
	IP4_ADDR(&netmask, 255, 255, 255, 0);
	IP4_ADDR(&gw,      192, 168,   1, 1);

	lwip_init();

	if (!xemac_add(netif, &ipaddr, &netmask, &gw, mac_ethernet_address, XPAR_XEMACPS_0_BASEADDR)) {
			//xil_printf("Error adding N/W interface\r\n");
			return -1;
	}
	netif_set_default(netif);
	netif_set_up(netif);
	user_udp_init();

	while(1)
	{
		if(recv_done)
		{
			XUartPs_Send(&uart0_inst,recv, 30);
			recv_done=0;
		}

		xemacif_input(netif);
		if (udp_connected_flag) {
			if (!(XUartPs_GetChannelStatus(&uart0_inst) & XUARTPS_SR_RXEMPTY)) {	//UART0 rcvd bytes
				XUartPs_Recv(&uart0_inst, &report[recv_cnt], 1);
				if(recv_cnt==0)
				{
					detect_head();
				}
				if(recv_goon)
				{
					recv_cnt++;
				}
				if(recv_cnt>=47)
				{
					detect_end();
					recv_cnt=0;
					recv_goon=0;
				}
			}
		}
	}
	return 0;
}

static u8 end_flag=0;
static void detect_head()
{
		if(report[0]==0xFF)
		{
			end_flag=end_flag+1;
		}
		if(report[0]==0x25&&end_flag==2)
		{
			recv_goon=1;
			end_flag=0;
		}
		else
		{
			recv_goon=0;
		}
}


static void detect_end()
{
	u8 i=0;
	if(report[45]==0xFF&&report[46]==0xFF)
	{
		udp_printf();
		end_flag=2;
		for(i=0;i<47;i++)
		{
			report[i]=0x00;
		}
	}
	else
	{
		for(i=0;i<47;i++)
		{
			report[i]=0x00;
		}
	}
}
static void uart_init()
{
	int status;
	uart0_config = XUartPs_LookupConfig(UART0_ID);
	status = XUartPs_CfgInitialize(&uart0_inst, uart0_config, uart0_config->BaseAddress);
	if (status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	XUartPs_EnableUart(&uart0_inst);
	XUartPs_SetOperMode(&uart0_inst, XUARTPS_OPER_MODE_NORMAL);
	XUartPs_SetBaudRate(&uart0_inst, 115200);
	XUartPs_SetFifoThreshold(&uart0_inst, 1);
}


