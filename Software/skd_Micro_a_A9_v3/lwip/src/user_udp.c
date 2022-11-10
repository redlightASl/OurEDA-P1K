#include "user_udp.h"
#include "xuartps.h"

struct udp_pcb *connected_pcb = NULL;
static struct pbuf *pbuf_to_be_sent = NULL;

static unsigned local_port = 7;      
static unsigned remote_port = 8080; 
volatile unsigned udp_connected_flag = 0;  

extern u8 recv[30];
extern u8 recv_done;

void udp_recv_callback(void *arg, struct udp_pcb *tpcb,
           struct pbuf *p, ip_addr_t *addr, u16_t port)
{
	err_t err;
	//xil_printf("Received from %d.%d.%d.%d port %d\r\n", (addr->addr) & 0xFF,
			//(addr->addr>>8) & 0xFF, (addr->addr>>16) & 0xFF, (addr->addr>>24) & 0xFF, port);
	struct pbuf *p_temp = p;
	pbuf_copy_partial(p_temp, (void*)recv, 30, 0);
	p_temp=p_temp->next;
	pbuf_free(p);     
	recv_done=1;
	return;
}


int user_udp_init(void)
{
	struct udp_pcb *pcb;
	ip_addr_t ipaddr;
	err_t err;
	udp_connected_flag = 0;


	pcb = udp_new();
	if (!pcb) {
		//xil_printf("Error Creating PCB.\r\n");
		return -1;
	}

	err = udp_bind(pcb, IP_ADDR_ANY, local_port);
	if (err != ERR_OK) {
		//xil_printf("Unable to bind to port %d\r\n", local_port);
		return -2;
	}

	IP4_ADDR(&ipaddr, 192, 168, 1, 100);
	err = udp_connect(pcb, &ipaddr, remote_port);
	if (err != ERR_OK) {
		//xil_printf("Unable to connect remote port.\r\n");
		return -3;
	}
	else {
		//xil_printf("Connected Success.\r\n");
		connected_pcb = pcb;
		udp_connected_flag = 1;
	}
	udp_recv(pcb, udp_recv_callback, NULL);  

	return 0;
}



extern u8 report[47];

void udp_printf(void)
{
	err_t err;
	char send_buff[14] = "Hello World!\r\n";  
	struct udp_pcb *tpcb = connected_pcb;
	if (!tpcb) {
		//xil_printf("error connect.\r\n");
	}

	pbuf_to_be_sent = pbuf_alloc(PBUF_TRANSPORT, 47, PBUF_POOL);
	memset(pbuf_to_be_sent->payload, 0, 47);
	memcpy(pbuf_to_be_sent->payload, (u8 *)report, 47);

	err = udp_send(tpcb, pbuf_to_be_sent);
	if (err != ERR_OK) {
		//xil_printf("Error on udp send : %d\r\n", err);
		pbuf_free(pbuf_to_be_sent);
		return;
	}
	pbuf_free(pbuf_to_be_sent);  
}
