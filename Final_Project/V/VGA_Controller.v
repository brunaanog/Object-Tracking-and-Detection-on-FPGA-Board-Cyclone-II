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
// Major Functions:	VGA_Controller
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
// --------------------------------------------------------------------

module	VGA_Controller(	//	Host Side
						iRead_DATA1,
						iRead_DATA2,
						iRead_DATA3,
						iRead_DATA4,
						oRequest,
						//	VGA Side
						oSubR,
						oSubG,
						oSubB,
						oFrameR,
						oFrameG,
						oFrameB,
						oVGA_H_SYNC,
						oVGA_V_SYNC,
						oVGA_SYNC,
						oVGA_BLANK,
						

						//	Control Signal
						iCLK,
						iRST_N
						);

`include "VGA_Param.h"

//	Host Side
input	unsigned	[14:0]	iRead_DATA1;
input	unsigned	[14:0]	iRead_DATA2;
input	unsigned	[14:0]	iRead_DATA3;
input	unsigned	[14:0]	iRead_DATA4;

output	reg			oRequest;
//	VGA Side
output	reg	[9:0]	oSubR;
output	reg	[9:0]	oSubG;
output	reg	[9:0]	oSubB;
output	reg	[9:0]	oFrameR;
output	reg	[9:0]	oFrameG;
output	reg	[9:0]	oFrameB;
output	reg			oVGA_H_SYNC;
output	reg			oVGA_V_SYNC;
output	reg			oVGA_SYNC;
output	reg			oVGA_BLANK;

wire		[9:0]	mSubR;
wire		[9:0]	mSubG;
wire		[9:0]	mSubB;
wire		[9:0]	mFrameR;
wire		[9:0]	mFrameG;
wire		[9:0]	mFrameB;
reg					mVGA_H_SYNC;
reg					mVGA_V_SYNC;
wire				mVGA_SYNC;
wire				mVGA_BLANK;

//	Control Signal
input				iCLK;
input				iRST_N;
//input 				iZOOM_MODE_SW;

//	Internal Registers and Wires
reg		[12:0]		H_Cont;
reg		[12:0]		V_Cont;

wire	[12:0]		v_mask;

assign v_mask = 13'd0;

wire	unsigned	[9:0]	Read_Red;
wire	unsigned	[9:0]	Read_Green;
wire	unsigned	[9:0]	Read_Blue;

//Dif
//assign Read_Red =iRead_DATA2[9:0] - iRead_DATA4[9:0];
//assign Read_Green = {iRead_DATA1[14:10] , iRead_DATA2[14:10] } - {iRead_DATA3[14:10] , iRead_DATA4[14:10]};
//assign Read_Blue = (iRead_DATA1[9:0] - iRead_DATA3[9:0]);

//Modulo dif
assign Read_Red = ((iRead_DATA2[9:0] > iRead_DATA4[9:0] ) ) ? (iRead_DATA2[9:0] - iRead_DATA4[9:0]) : (iRead_DATA4[9:0] - iRead_DATA2[9:0]);// iRead_DATA2[9:0];//
assign Read_Green =({iRead_DATA1[14:10] , iRead_DATA2[14:10]} > {iRead_DATA3[14:10] , iRead_DATA4[14:10]}) ? {iRead_DATA1[14:10] , iRead_DATA2[14:10] } - {iRead_DATA3[14:10] , iRead_DATA4[14:10]} : {iRead_DATA3[14:10], iRead_DATA4[14:10]} - {iRead_DATA1[14:10], iRead_DATA2[14:10]}; //{iRead_DATA1[14:10], iRead_DATA2[14:10]}; //
assign Read_Blue = (iRead_DATA1[9:0] > iRead_DATA3[9:0]) ? (iRead_DATA1[9:0] - iRead_DATA3[9:0]) : (iRead_DATA3[9:0] - iRead_DATA1[9:0]); // iRead_DATA1[9:0];


//Directo
//assign Read_Red  = iRead_DATA2[9:0];
//assign Read_Green = {iRead_DATA1[14:10] , iRead_DATA2[14:10]};
//assign Read_Blue = iRead_DATA1[9:0];


////////////////////////////////////////////////////////

assign	mVGA_BLANK	=	mVGA_H_SYNC & mVGA_V_SYNC;
assign	mVGA_SYNC	=	1'b0;

assign	mSubR	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	(Read_Red)	:	0;
assign	mSubG	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	Read_Green	:	0;
assign	mSubB	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	Read_Blue	:	0;
						
assign	mFrameR	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iRead_DATA2[9:0]	:	0;
assign	mFrameG	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	{iRead_DATA1[14:10] , iRead_DATA2[14:10]}	:	0;
assign	mFrameB	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iRead_DATA1[9:0]	:	0;

always@(posedge iCLK or negedge iRST_N)
	begin
		if (!iRST_N)
			begin
				oSubR <= 0;
				oSubG <= 0;
                oSubB <= 0;
                oFrameR <= 0;
                oFrameG <= 0;
                oFrameB <= 0;
				oVGA_BLANK <= 0;
				oVGA_SYNC <= 0;
				oVGA_H_SYNC <= 0;
				oVGA_V_SYNC <= 0; 
			end
		else
			begin
				oSubR <= mSubR;
				oSubG <= mSubG;
                oSubB <= mSubB;
                oFrameR  <= mFrameR;
                oFrameG  <= mFrameG;
                oFrameB  <= mFrameB;
				oVGA_BLANK <= mVGA_BLANK;
				oVGA_SYNC <= mVGA_SYNC;
				oVGA_H_SYNC <= mVGA_H_SYNC;
				oVGA_V_SYNC <= mVGA_V_SYNC;				
			end               
	end



//	Pixel LUT Address Generator
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	oRequest	<=	0;
	else
	begin
		if(	H_Cont>=X_START-2 && H_Cont<X_START+H_SYNC_ACT-2 &&
			V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT )
		oRequest	<=	1;
		else
		oRequest	<=	0;
	end
end

//	H_Sync Generator, Ref. 25.175 MHz Clock
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		H_Cont		<=	0;
		mVGA_H_SYNC	<=	0;
	end
	else
	begin
		//	H_Sync Counter
		if( H_Cont < H_SYNC_TOTAL )
		H_Cont	<=	H_Cont+1;
		else
		H_Cont	<=	0;
		//	H_Sync Generator
		if( H_Cont < H_SYNC_CYC )
		mVGA_H_SYNC	<=	0;
		else
		mVGA_H_SYNC	<=	1;
	end
end

//	V_Sync Generator, Ref. H_Sync
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		V_Cont		<=	0;
		mVGA_V_SYNC	<=	0;
	end
	else
	begin
		//	When H_Sync Re-start
		if(H_Cont==0)
		begin
			//	V_Sync Counter
			if( V_Cont < V_SYNC_TOTAL ) 
			V_Cont	<=	V_Cont+1;
			else
			V_Cont	<=	0;
			//	V_Sync Generator
			if(	V_Cont < V_SYNC_CYC )
			mVGA_V_SYNC	<=	0;
			else
			mVGA_V_SYNC	<=	1;
		end
	end
end

endmodule