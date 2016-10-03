//lpm_compare CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone II" LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=10 ONE_INPUT_IS_CONSTANT="YES" agb dataa datab CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48
//VERSION_BEGIN 9.1SP2 cbx_cycloneii 2010:03:24:20:43:43:SJ cbx_lpm_add_sub 2010:03:24:20:43:43:SJ cbx_lpm_compare 2010:03:24:20:43:43:SJ cbx_mgl 2010:03:24:21:01:05:SJ cbx_stratix 2010:03:24:20:43:43:SJ cbx_stratixii 2010:03:24:20:43:43:SJ  VERSION_END
//CBXI_INSTANCE_NAME="main_lpm_compare1_inst3_lpm_compare_lpm_compare_component"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2010 Altera Corporation
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
module  lpm_compare1_cmpr
	( 
	agb,
	dataa,
	datab) /* synthesis synthesis_clearbox=1 */;
	output   agb;
	input   [9:0]  dataa;
	input   [9:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [9:0]  dataa;
	tri0   [9:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	wire_agb_int;

	always @(dataa or datab)
	begin
		if (dataa > datab) 
			begin
				wire_agb_int = 1'b1;
			end
		else
			begin
				wire_agb_int = 1'b0;
			end
	end
	assign
		agb = wire_agb_int;
endmodule //lpm_compare1_cmpr
//VALID FILE
