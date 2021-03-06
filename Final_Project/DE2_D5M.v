// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2 D5M VGA
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
// --------------------------------------------------------------------

module DE2_D5M
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		color_mode,								//	Toggle Switch[17]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		bkg_saved,						//	Flag to indicate bkg on sdram
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		SubR,   						//	VGA Red[9:0]
		SubG,	 						//	VGA Green[9:0]
		SubB,  						//	VGA Blue[9:0]
		currFrame_R,
		currFrame_G,
		currFrame_B,
		BKG_Gray,
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_27;				//	27 MHz
input			CLOCK_50;				//	50 MHz
input			EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]

input		color_mode;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]
///////////////////////		SDRAM Interface	////////////////////////
inout	[15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output	[11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
output			bkg_saved;				//	Flag to indicate bkg on sdram
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	SubR;   				//	VGA Red[9:0]
output	[9:0]	SubG;	 				//	VGA Green[9:0]
output	[9:0]	SubB;   				//	VGA Blue[9:0]
output	[9:0]	currFrame_R;
output	[9:0]	currFrame_G;
output	[9:0]	currFrame_B;
output	[11:0]	BKG_Gray;				//	background gray pixel
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1
///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================

//	CCD
wire	[11:0]	CCD_DATA;
wire			CCD_SDAT;
wire			CCD_SCLK;
wire			CCD_FLASH;
wire			CCD_FVAL;
wire			CCD_LVAL;
wire			CCD_PIXCLK;
wire			CCD_MCLK;				//	CCD Master Clock

wire	unsigned	[15:0]	Read_DATA1;
wire	unsigned	[15:0]	Read_DATA2;
wire	unsigned	[15:0]	Read_DATA3;
wire	unsigned	[15:0]	Read_DATA4;

wire			VGA_CTRL_CLK;
wire	[11:0]	mCCD_DATA;
wire			mCCD_DVAL;
wire			mCCD_DVAL_d;
wire	[15:0]	X_Cont;
wire	[15:0]	Y_Cont;
wire	[9:0]	X_ADDR;
wire	[31:0]	Frame_Cont;
wire			DLY_RST_0;
wire			DLY_RST_1;
wire			DLY_RST_2;
wire			Read;
reg		[11:0]	rCCD_DATA;
reg				rCCD_LVAL;
reg				rCCD_FVAL;
wire	[11:0]	sCCD_R;
wire	[11:0]	sCCD_G;
wire	[11:0]	sCCD_B;
wire			sCCD_DVAL;
wire	[9:0]	SubR;   				//	VGA Red[9:0]
wire	[9:0]	SubG;	 				//	VGA Green[9:0]
wire	[9:0]	SubB;   				//	VGA Blue[9:0]
wire	[9:0]	currFrame_R;
wire	[9:0]	currFrame_G;
wire	[9:0]	currFrame_B;

reg		[1:0]	rClk;
wire			sdram_ctrl_clk;

//=============================================================================
// Structural coding
//=============================================================================
assign	CCD_DATA[0]	=	GPIO_1[13];
assign	CCD_DATA[1]	=	GPIO_1[12];
assign	CCD_DATA[2]	=	GPIO_1[11];
assign	CCD_DATA[3]	=	GPIO_1[10];
assign	CCD_DATA[4]	=	GPIO_1[9];
assign	CCD_DATA[5]	=	GPIO_1[8];
assign	CCD_DATA[6]	=	GPIO_1[7];
assign	CCD_DATA[7]	=	GPIO_1[6];
assign	CCD_DATA[8]	=	GPIO_1[5];
assign	CCD_DATA[9]	=	GPIO_1[4];
assign	CCD_DATA[10]=	GPIO_1[3];
assign	CCD_DATA[11]=	GPIO_1[1];
assign	GPIO_1[16]	=	CCD_MCLK;
assign	CCD_FVAL	=	GPIO_1[22];
assign	CCD_LVAL	=	GPIO_1[21];
assign	CCD_PIXCLK	=	GPIO_1[0];
assign	GPIO_1[19]	=	1'b1;  // tRIGGER
assign	GPIO_1[17]	=	DLY_RST_1;


//assign	LEDR		=	SW;
assign	LEDG		=	Y_Cont;

assign	VGA_CTRL_CLK=	rClk[0];
assign	VGA_CLK		=	~rClk[0];

//test
wire[3:0]Full;
wire[3:0]Empty;

//wire SubtractedRed = Read_DATA2[9:0] - Read_DATA4[9:0];
//wire SubtractedGreen = {Read_DATA1[14:10] - Read_DATA3[14:10],Read_DATA2[14:10] - Read_DATA4[14:10]};
//wire SubtractedBlue = Read_DATA1[9:0] - Read_DATA3[9:0];

reg state1; 

always@(posedge ~CCD_PIXCLK) state1 <= ((bkg_saved & ~(VGA_VS)) | state1);// & bkg_saved; // & bkg_saved � usado para o reset do state1
//begin
	
	//if(!DLY_RST_0)
	//begin
		//state1 <= 0;
		//bkg_saved <= 0;
	//end
//end

always@(posedge CLOCK_50)	rClk	<=	rClk+1;


always@(posedge CCD_PIXCLK)
begin
	rCCD_DATA	<=	CCD_DATA;
	rCCD_LVAL	<=	CCD_LVAL;
	rCCD_FVAL	<=	CCD_FVAL;
end

VGA_Controller		u1	(	//	Host Side
							.oRequest(Read),
							.iRead_DATA1(Read_DATA1), //2
							.iRead_DATA2(Read_DATA2), //1 2
							.iRead_DATA3(Read_DATA3), //1
							.iRead_DATA4(Read_DATA4),
							
							//	VGA Side
							.oSubR(SubR),
							.oSubG(SubG),
							.oSubB(SubB),
							.oFrameR(currFrame_R),
							.oFrameG(currFrame_G),
							.oFrameB(currFrame_B),
							.oVGA_H_SYNC(VGA_HS),
							.oVGA_V_SYNC(VGA_VS),
							.oVGA_SYNC(VGA_SYNC),
							.oVGA_BLANK(VGA_BLANK),
							

							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST_2)
						);
						
						



Reset_Delay			u2	(	.iCLK(CLOCK_50),
							.iRST(KEY[0]),
							.oRST_0(DLY_RST_0),
							.oRST_1(DLY_RST_1),
							.oRST_2(DLY_RST_2)
						);

CCD_Capture			u3	(	.oDATA(mCCD_DATA),
							.oDVAL(mCCD_DVAL),
							.oX_Cont(X_Cont),
							.oY_Cont(Y_Cont),
							.oFrame_Cont(Frame_Cont),
							.iDATA(rCCD_DATA),
							.iFVAL(rCCD_FVAL),
							.iLVAL(rCCD_LVAL),
							.iSTART(!KEY[3]),
							.iEND(!KEY[2]),
							.iCLK(CCD_PIXCLK),
							.iRST(DLY_RST_2)
						);

RAW2RGB				u4	(	.iCLK(CCD_PIXCLK),
							.iRST(DLY_RST_1),
							.iDATA(mCCD_DATA),
							.iDVAL(mCCD_DVAL),
							.oRed(sCCD_R),
							.oGreen(sCCD_G),
							.oBlue(sCCD_B),
							.oDVAL(sCCD_DVAL),
							.iX_Cont(X_Cont),
							.iY_Cont(Y_Cont)
						);

SEG7_LUT_8 			u5	(	
							.oSEG0(HEX2),.oSEG1(HEX3),
							.oSEG2(HEX4),.oSEG3(HEX5),
							.oSEG4(HEX6),.oSEG5(HEX7),
							.iDIG(Frame_Cont[31:0])
						);

/*sdram_pll 			u6	(
							.inclk0(CLOCK_50),
							.c0(sdram_ctrl_clk),
							.c1(DRAM_CLK)
						);*/

assign CCD_MCLK = rClk[0];

Sdram_Control_8Port	u7 (
						.REF_CLK(CLOCK_50),
						.RESET_N(1'b1),
						
						.oBkg_saved(bkg_saved),
						
						//FIFO Write Side 1
						.WR1_DATA({1'b0, sCCD_G[11:7], sCCD_B[11:2]}),
						.WR1(sCCD_DVAL & state1), //sCCD_DVAL
						.WR1_ADDR(0),
						.WR1_MAX_ADDR(640*480),
						.WR1_LENGTH(9'h100),
						.WR1_LOAD(!DLY_RST_0),
						.WR1_CLK(~CCD_PIXCLK),
						.WR1_FULL(Full[0]),
						
						//FIFO Write Side 2
						.WR2_DATA({1'b0,sCCD_G[6:2],sCCD_R[11:2]}),
						.WR2(sCCD_DVAL & state1),//sCCD_DVAL & state1),
						.WR2_ADDR(22'h100000),
						.WR2_MAX_ADDR(22'h100000+640*480),
						.WR2_LENGTH(9'h100),
						.WR2_LOAD(!DLY_RST_0),
						.WR2_CLK(~CCD_PIXCLK),
						.WR2_FULL(Full[1]),
						
						//	FIFO Write Side 3
						.WR3_DATA(	{1'b0, sCCD_G[11:7], sCCD_B[11:2]}), //mudar 4'h0,VGA_Gray[11:0]
						.WR3(sCCD_DVAL &(!bkg_saved)), //mudar
						.WR3_ADDR(22'h200000),
						.WR3_MAX_ADDR(22'h200000+640*480),
						.WR3_LENGTH(9'h100),
						.WR3_LOAD(!DLY_RST_0), 
						.WR3_CLK(~CCD_PIXCLK), //mudar
						
						
						//	FIFO Write Side 4
						.WR4_DATA(	{1'b0,sCCD_G[6:2],sCCD_R[11:2]}), //mudar 4'h0,VGA_Gray[11:0]
						.WR4(sCCD_DVAL &(!bkg_saved)), //mudar
						.WR4_ADDR(22'h300000),
						.WR4_MAX_ADDR(22'h300000+640*480),
						.WR4_LENGTH(9'h100),
						.WR4_LOAD(!DLY_RST_0), 
						.WR4_CLK(~CCD_PIXCLK), //mudar
						
						//FIFO Read Side 1
						.RD1_DATA(Read_DATA1),
						.RD1(Read & state1),
						.RD1_ADDR(0),
						.RD1_MAX_ADDR(640*480),
						.RD1_LENGTH(9'h100),
						.RD1_LOAD(!DLY_RST_0),
						.RD1_CLK(~VGA_CTRL_CLK),
						.RD1_EMPTY(Empty[0]),
						
						//FIFO Read Side 2
						.RD2_DATA(Read_DATA2),
						.RD2(Read & state1),
						.RD2_ADDR(22'h100000),
						.RD2_MAX_ADDR(22'h100000+640*480),
						.RD2_LENGTH(9'h100),
						.RD2_LOAD(!DLY_RST_0),
						.RD2_CLK(~VGA_CTRL_CLK),
						.RD2_EMPTY(Empty[1]),
						
						//	FIFO Read Side 3
						.RD3_DATA(Read_DATA3 ), //mudar
						.RD3(Read & state1), //Read 1'b0
						.RD3_ADDR(22'h200000),
						.RD3_MAX_ADDR(22'h200000+640*480),
						.RD3_LENGTH(9'h100),
				        .RD3_LOAD(!DLY_RST_0), //mudar
						.RD3_CLK(~VGA_CTRL_CLK), //mudar
						
						//	FIFO Read Side 4
						.RD4_DATA(Read_DATA4 ), //mudar
						.RD4(Read & state1), //Read 1'b0
						.RD4_ADDR(22'h300000),
						.RD4_MAX_ADDR(22'h300000+640*480),
						.RD4_LENGTH(9'h100),
				        .RD4_LOAD(!DLY_RST_0), //mudar
						.RD4_CLK(~VGA_CTRL_CLK), //mudar
						
						//SDRAM Side
						.SA(DRAM_ADDR),
						.BA({DRAM_BA_1,DRAM_BA_0}),
						.CS_N(DRAM_CS_N),
						.CKE(DRAM_CKE),
						.RAS_N(DRAM_RAS_N),
						.CAS_N(DRAM_CAS_N),
						.WE_N(DRAM_WE_N),
						.DQ(DRAM_DQ),
						.DQM({DRAM_UDQM,DRAM_LDQM}),
						.SDR_CLK(DRAM_CLK)
					);


/*Sdram_Control_4Port	u7	(	//	HOST Side						
						    .REF_CLK(CLOCK_50),
						    .RESET_N(1'b1),
							.CLK(sdram_ctrl_clk),

							//	FIFO Write Side 1
							.WR1_DATA({1'b0,sCCD_G[11:7],sCCD_B[11:2]}),
							.WR1(sCCD_DVAL),
							.WR1_ADDR(0),
							.WR1_MAX_ADDR(640*480),
							.WR1_LENGTH(9'h100),
							.WR1_LOAD(!DLY_RST_0),
							.WR1_CLK(~CCD_PIXCLK),

							//	FIFO Write Side 2
							.WR2_DATA(	{1'b0,sCCD_G[6:2],sCCD_R[11:2]}),
							.WR2(sCCD_DVAL),
							.WR2_ADDR(22'h100000),
							.WR2_MAX_ADDR(22'h100000+640*480),
							.WR2_LENGTH(9'h100),
							.WR2_LOAD(!DLY_RST_0),
							.WR2_CLK(~CCD_PIXCLK),
							
							//	FIFO Write Side 3
							/*.WR3_DATA(	{4'h0,VGA_Gray[11:0]}), //mudar
							.WR3(sCCD_DVAL), //mudar
							.WR3_ADDR(22'h200000),
							.WR3_MAX_ADDR(22'h200000+640*480),
							.WR3_LENGTH(9'h100),
							.WR3_LOAD(!DLY_RST_0), 
							.WR3_CLK(~CCD_PIXCLK), //mudar
							.stopFifo3(bkg_saved),


							//	FIFO Read Side 1
						    .RD1_DATA(Read_DATA1),
				        	.RD1(Read),
				        	.RD1_ADDR(0),
							.RD1_MAX_ADDR(640*480),
							.RD1_LENGTH(9'h100),
							.RD1_LOAD(!DLY_RST_0),
							.RD1_CLK(~VGA_CTRL_CLK),
							
							//	FIFO Read Side 2
						    .RD2_DATA(Read_DATA2),
							.RD2(Read),
							.RD2_ADDR(22'h100000),
							.RD2_MAX_ADDR(22'h100000+640*480),
							.RD2_LENGTH(9'h100),
				        	.RD2_LOAD(!DLY_RST_0),
							.RD2_CLK(~VGA_CTRL_CLK),
							
							//	FIFO Read Side 3
						    /*.RD3_DATA(Read_DATA3), //mudar
							.RD3(Read&(stopWriteFifo3)), //Read 1'b0
							.RD3_ADDR(22'h200000),
							.RD3_MAX_ADDR(22'h200000+640*480),
							.RD3_LENGTH(9'h100),
				        	.RD3_LOAD(!DLY_RST_0), //mudar
							.RD3_CLK(~VGA_CTRL_CLK), //mudar
							
							//	SDRAM Side
						    .SA(DRAM_ADDR),
						    .BA({DRAM_BA_1,DRAM_BA_0}),
        					.CS_N(DRAM_CS_N),
        					.CKE(DRAM_CKE),
        					.RAS_N(DRAM_RAS_N),
        					.CAS_N(DRAM_CAS_N),
        					.WE_N(DRAM_WE_N),
        					.DQ(DRAM_DQ),
        					.DQM({DRAM_UDQM,DRAM_LDQM})
        					
        				
						);
*/


I2C_CCD_Config 		u8	(	//	Host Side
							.iCLK(CLOCK_50),
							.iRST_N(DLY_RST_2),
							//.iZOOM_MODE_SW(SW[16]),
							.iEXPOSURE_ADJ(KEY[1]),
							//.iEXPOSURE_DEC_p(SW[0]),
							//	I2C Side
							.I2C_SCLK(GPIO_1[24]),
							.I2C_SDAT(GPIO_1[23])
						);

endmodule