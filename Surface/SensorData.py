
class SensorImu:
    def __init__(self):
        self.acc = [0, 0, 0]
        self.rot = [0, 0, 0]
        self.eul = [0, 0, 0]
        self.mag = [0, 0, 0]

    def imu_decode(self, raw_data):
        self.acc[0] = raw_data[1]
        self.acc[1] = raw_data[2]
        self.acc[2] = raw_data[3]
        self.rot[0] = raw_data[4]
        self.rot[1] = raw_data[5]
        self.rot[2] = raw_data[6]
        self.eul[0] = raw_data[7]
        self.eul[1] = raw_data[8]
        self.eul[2] = raw_data[9]
        self.mag[0] = raw_data[10]
        self.mag[1] = raw_data[11]
        self.mag[2] = raw_data[12]

    def imu_get_acc(self):
        return self.acc

    def imu_get_rot(self):
        return self.rot

    def imu_get_eul(self):
        return self.eul

    def imu_get_mag(self):
        return self.mag


# class SensorData:
#     def __init__(self):
#         self.SensorImu
#         SensorImu