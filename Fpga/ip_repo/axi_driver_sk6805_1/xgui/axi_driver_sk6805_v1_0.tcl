# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Division_Factor" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RGB_All_Bit" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Period_Send" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CODE_High_0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CODE_High_1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_HIGHADDR" -parent ${Page_0}


}

proc update_PARAM_VALUE.CODE_High_0 { PARAM_VALUE.CODE_High_0 } {
	# Procedure called to update CODE_High_0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CODE_High_0 { PARAM_VALUE.CODE_High_0 } {
	# Procedure called to validate CODE_High_0
	return true
}

proc update_PARAM_VALUE.CODE_High_1 { PARAM_VALUE.CODE_High_1 } {
	# Procedure called to update CODE_High_1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CODE_High_1 { PARAM_VALUE.CODE_High_1 } {
	# Procedure called to validate CODE_High_1
	return true
}

proc update_PARAM_VALUE.Division_Factor { PARAM_VALUE.Division_Factor } {
	# Procedure called to update Division_Factor when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Division_Factor { PARAM_VALUE.Division_Factor } {
	# Procedure called to validate Division_Factor
	return true
}

proc update_PARAM_VALUE.Period_Send { PARAM_VALUE.Period_Send } {
	# Procedure called to update Period_Send when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Period_Send { PARAM_VALUE.Period_Send } {
	# Procedure called to validate Period_Send
	return true
}

proc update_PARAM_VALUE.RGB_All_Bit { PARAM_VALUE.RGB_All_Bit } {
	# Procedure called to update RGB_All_Bit when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RGB_All_Bit { PARAM_VALUE.RGB_All_Bit } {
	# Procedure called to validate RGB_All_Bit
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.Period_Send { MODELPARAM_VALUE.Period_Send PARAM_VALUE.Period_Send } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Period_Send}] ${MODELPARAM_VALUE.Period_Send}
}

proc update_MODELPARAM_VALUE.Division_Factor { MODELPARAM_VALUE.Division_Factor PARAM_VALUE.Division_Factor } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Division_Factor}] ${MODELPARAM_VALUE.Division_Factor}
}

proc update_MODELPARAM_VALUE.RGB_All_Bit { MODELPARAM_VALUE.RGB_All_Bit PARAM_VALUE.RGB_All_Bit } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RGB_All_Bit}] ${MODELPARAM_VALUE.RGB_All_Bit}
}

proc update_MODELPARAM_VALUE.CODE_High_0 { MODELPARAM_VALUE.CODE_High_0 PARAM_VALUE.CODE_High_0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CODE_High_0}] ${MODELPARAM_VALUE.CODE_High_0}
}

proc update_MODELPARAM_VALUE.CODE_High_1 { MODELPARAM_VALUE.CODE_High_1 PARAM_VALUE.CODE_High_1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CODE_High_1}] ${MODELPARAM_VALUE.CODE_High_1}
}

