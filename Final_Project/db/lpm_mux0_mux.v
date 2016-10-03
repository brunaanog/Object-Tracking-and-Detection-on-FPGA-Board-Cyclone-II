//lpm_mux CASCADE_CHAIN="MANUAL" DEVICE_FAMILY="Cyclone II" IGNORE_CASCADE_BUFFERS="OFF" LPM_SIZE=2 LPM_WIDTH=10 LPM_WIDTHS=1 data result sel
//VERSION_BEGIN 9.0 cbx_lpm_mux 2008:05:19:10:30:36:SJ cbx_mgl 2009:01:29:16:12:07:SJ  VERSION_END
//CBXI_INSTANCE_NAME="main_lpm_mux0_inst5_lpm_mux_lpm_mux_component"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2009 Altera Corporation
//  Your use of Altera Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Altera Program License 
//  Subscription Agreement, Altera MegaCore Function License 
//  Agreement, or other applicable license agreement, including, 
//  without limitation, that your use is for the sole purpose of 
//  programming logic devices manufactured by Altera and sold by 
//  Altera or its authorized distributors.  Please refer to the 
//  applicable agreement for further details.



//synthesis_resources = lut 10 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  lpm_mux0_mux
	( 
	data,
	result,
	sel) /* synthesis synthesis_clearbox=1 */;
	input   [19:0]  data;
	output   [9:0]  result;
	input   [0:0]  sel;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [19:0]  data;
	tri0   [0:0]  sel;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [9:0]  result_node;
	wire  [0:0]  sel_node;
	wire  [1:0]  w_data102w;
	wire  [1:0]  w_data114w;
	wire  [1:0]  w_data18w;
	wire  [1:0]  w_data30w;
	wire  [1:0]  w_data42w;
	wire  [1:0]  w_data4w;
	wire  [1:0]  w_data54w;
	wire  [1:0]  w_data66w;
	wire  [1:0]  w_data78w;
	wire  [1:0]  w_data90w;

	assign
		result = result_node,
		result_node = {((sel_node & w_data114w[1]) | ((~ sel_node) & w_data114w[0])), ((sel_node & w_data102w[1]) | ((~ sel_node) & w_data102w[0])), ((sel_node & w_data90w[1]) | ((~ sel_node) & w_data90w[0])), ((sel_node & w_data78w[1]) | ((~ sel_node) & w_data78w[0])), ((sel_node & w_data66w[1]) | ((~ sel_node) & w_data66w[0])), ((sel_node & w_data54w[1]) | ((~ sel_node) & w_data54w[0])), ((sel_node & w_data42w[1]) | ((~ sel_node) & w_data42w[0])), ((sel_node & w_data30w[1]) | ((~ sel_node) & w_data30w[0])), ((sel_node & w_data18w[1]) | ((~ sel_node) & w_data18w[0])), ((sel_node & w_data4w[1]) | ((~ sel_node) & w_data4w[0]))},
		sel_node = {sel[0]},
		w_data102w = {data[18], data[8]},
		w_data114w = {data[19], data[9]},
		w_data18w = {data[11], data[1]},
		w_data30w = {data[12], data[2]},
		w_data42w = {data[13], data[3]},
		w_data4w = {data[10], data[0]},
		w_data54w = {data[14], data[4]},
		w_data66w = {data[15], data[5]},
		w_data78w = {data[16], data[6]},
		w_data90w = {data[17], data[7]};
endmodule //lpm_mux0_mux
//VALID FILE
