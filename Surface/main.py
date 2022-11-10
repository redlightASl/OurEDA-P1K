from Joystick import *
from SensorData import SensorImu

import threading
import time
import socket
import sys
import logging

import struct


REMOTE_HOST = '192.168.238.33'
REMOTE_PORT = 8080
LOCAL_HOST = ""
LOCAL_PORT = 2333

#UDP
udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
udp_socket.bind((LOCAL_HOST, LOCAL_PORT))

# recv_data = '0:0:0:0:0'


imu_data = SensorImu()

def data_analysis(recv_data):
    # bin_data = ord(bin_data)
    data_tuple = struct.unpack(str(len(recv_data))+'B', recv_data)
    FrameHead = data_tuple[0]
    FrameEnd_1 = data_tuple[-1]
    FrameEnd_2 = data_tuple[-2]
    if FrameHead == 0x25 and FrameEnd_1 == 0xFF and FrameEnd_2 == 0xFF:
        imu_data.imu_decode(data_tuple)

    imu_eul = imu_data.imu_get_eul()

    print(imu_eul[0], imu_eul[1], imu_eul[2])
    # return bin_data

    
def send_msg(udp_socket, dest_ip, dest_port, f_b, l_r, u_d1):
    """发送消息"""
    # 获取要发送的内容
    x = str(f_b)
    y = str(l_r)
    z1 = str(u_d1)
    x = x.rjust(3,'0') #0补齐四位
    y = y.rjust(3,'0')
    z1 = z1.rjust(3,'0')
    
    send_data_array = [0] * 30
    send_data_array[0] = 0x25
    send_data_array[1] = (int(x) & 0x0000ff00) >> 8
    send_data_array[2] = (int(x) & 0x000000ff) >> 0
    send_data_array[3] = (int(y) & 0x0000ff00) >> 8
    send_data_array[4] = (int(y) & 0x000000ff) >> 0
    send_data_array[5] = (int(z1) & 0x0000ff00) >> 8
    send_data_array[6] = (int(z1) & 0x000000ff) >> 0
    send_data_array[29] = 0x21

    send_data = struct.pack("%dB" % (len(send_data_array)), *send_data_array)
    udp_socket.sendto(send_data, (dest_ip, dest_port))

    
    # for i in range(0,30):
    #     if i == 0: # 0x25
    #         send_data = '25'
    #     elif i == 1: # straight
    #         send_data = x
    #     elif i == 2: # rotate
    #         send_data = y
    #     elif i == 3: # vertical
    #         send_data = z1
    #     elif i == 29: # 0x21    
    #         send_data = '21'
    #     else:
    #         send_data = '0'
    #     send_data = int(send_data)
    #     print(send_data)
        # udp_socket.sendto(send_data.encode(), (dest_ip, dest_port))
    
    # send_data_string = '25' + ' ' + x + ' ' + y + ' ' + z1 + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '00' + ' ' + '21' 
    
    # print(send_data_string)
    # send_data = str2bin(send_data_string)
    
    # udp_socket.sendto(send_data.encode(), (dest_ip, dest_port))
    # send_data = ''
    time.sleep(0.1)


def recv_msg(udp_socket):
    """接收数据"""
    # recvData = udp_socket.recv(1024).decode()
    recvData = data_analysis(udp_socket.recv(1024))
    time.sleep(0.05)
    return recvData
    

class Control:

    def __init__(self):
        # self.url = "http://192.168.129.33:8081/"
        logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s|%(levelname)s|%(message)s',
                    datefmt='%d-%b-%H:%M:%S',
                    filename='data.log',
                    filemode='w')
        

    def send_controldata(self):
        """发指令"""
        global recv_data
        # value = get_value()
        # countime = 0
        
        while True:
            # temp_value = next(value)
            # countime = countime + 1
            
            # #推进器PWM值
            # L = 0
            # R = 0
            # x = int(my_map(temp_value[1],-1,1,500,2500))
            # y = int(my_map(temp_value[0],-1,1,500,2500))
            # z = int(my_map(temp_value[3],1,-1,500,2500))
            
            # if x>=1500 and y>=1500 and x>=y:   #1
            #     L = x
            #     R = y-x+1500
            # elif x>=1500 and y>1500 and x<y:   #2
            #     L = y
            #     R = y-x+1500
            # elif x<1500 and y>1500 and x+y>=3000:   #3
            #     L = x+y-1500
            #     R = y
            # elif x<1500 and y>1500 and x+y<3000:   #4
            #     L = x+y-1500
            #     R = 3000-x
            # elif x<=1500 and y<=1500 and x<y:   #5
            #     L = x
            #     R = y-x+1500
            # elif x<=1500 and y<1500 and x>=y:   #6
            #     L = y
            #     R = y-x+1500
            # elif x>1500 and y<1500 and x+y<3000:   #7
            #     L = x+y-1500
            #     R = y
            # elif x>1500 and y<1500 and x+y>=3000:   #8
            #     L = x+y-1500
            #     R = 3000-x
            # else:
            #     L = 1500
            #     R = 1500
            
            # L1 = int(my_map(L,500,2500,1100,1900))
            # R1 = int(my_map(R,500,2500,1100,1900))
            # z1 = int(my_map(z,500,2500,1900,1100))
            
            # send_msg(udp_socket, REMOTE_HOST, REMOTE_PORT, L1 , R1, z1)
            # print("send_data: Left:{} Right:{} vertical:{}".format(L1, R1, z1))
            
            # recv_data = recv_msg(udp_socket)
            
            recv_msg(udp_socket)
            
            


if __name__ == "__main__":
    control = Control()
    th = threading.Thread(target=control.send_controldata)
    th.start()
