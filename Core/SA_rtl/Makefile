SYTHESYS := iverilog
SIMULATOR := vvp
WAVE_DISPLAY := gtkwave

SIM_DIR := .
# SIM_LIB := 
BUILD_DIR := ${SIM_DIR}/build
INC_DIR := -y ${SIM_DIR} -y ${SIM_DIR}/Conv2d -y ${SIM_DIR}/ConvDW -y ${SIM_DIR}/Linear -y ${SIM_DIR}/Relu -y ${SIM_DIR}/SystolicArray -y ${SIM_DIR}/Softmax
INC_FILE := -l ${SIM_DIR}/Linear/linear.v -l ${SIM_DIR}/SystolicArray/systolic_array_top.v
SIM_TARGET_TOP := ${SIM_DIR}/
BUILD_FILE := ${SIM_DIR}/build/wave.v.out

.PHONY: default
default: compile sim

.PHONY: relu
relu:
	${SYTHESYS} -o ${BUILD_FILE} ${INC_DIR} -l ${SIM_DIR}/Relu/relu.v -l ${SIM_DIR}/Relu/simple_relu.v ${SIM_DIR}/Relu/relu_tb.v
	make sim

.PHONY: linear
linear:
	${SYTHESYS} -o ${BUILD_FILE} ${INC_DIR} -l ${SIM_DIR}/Linear/linear.v -l ${SIM_DIR}/SystolicArray/systolic_array_top.v ${SIM_DIR}/Linear/linear_tb.v
	make sim
	
.PHONY: sa
sa:
	${SYTHESYS} -o ${BUILD_FILE} ${INC_DIR} -l ${SIM_DIR}/SystolicArray/systolic_array_top.v ${SIM_DIR}/SystolicArray/systolic_array_top_tb.v
	make sim

.PHONY: conv
conv:
#${SYTHESYS} -o ${BUILD_FILE} ${INC_DIR} -l ${SIM_DIR}/Conv2d/conv2d_feature.v -l ${SIM_DIR}/SystolicArray/systolic_array_top.v ${SIM_DIR}/Conv2d/conv2d_feature_tb.v
	${SYTHESYS} -o ${BUILD_FILE} ${INC_DIR} -l ${SIM_DIR}/Conv2d/conv2d_feature.v -l ${SIM_DIR}/Conv2d/conv2d_channel.v -l ${SIM_DIR}/SystolicArray/systolic_array_top.v ${SIM_DIR}/Conv2d/conv2d_channel_tb.v
	make sim

.PHONY: softmax
softmax:
	${SYTHESYS} -o ${BUILD_FILE} ${INC_DIR} -l ${SIM_DIR}/Softmax/softmax.v ${SIM_DIR}/Softmax/softmax_tb.v
	make sim

.PHONY: compile
compile:
	${SYTHESYS} -o ${BUILD_FILE} ${INC_DIR} ${INC_FILE} ${SIM_TARGET_TOP}

.PHONY: sim
sim:
	${SIMULATOR} -n ${BUILD_FILE}

.PHONY: visual
visual:
	${WAVE_DISPLAY} tb.vcd

.PHONY: clean
clean:
# rm -r ${BUILD_DIR}/*
	rm ${SIM_DIR}/*.vcd
