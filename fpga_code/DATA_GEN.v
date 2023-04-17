`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:27 05/12/2015 
// Design Name: 
// Module Name:    DATA_GEN 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//generate a reference signal use to compare with the testing result
module DATA_GEN(
     input CLK, RST_B,
     input [1:0] NS_DAT_CTL,
     output reg NS_DAT_OUT
    );
	 
	 reg [16:0] ns_ck_cnt;//for generating the checking pattern
	 reg dat_ck;
	 reg dat_halfclk;
	 
	 initial
		dat_halfclk = 1'b0;
	 
	 always @ (posedge CLK or negedge RST_B)
	 if (!RST_B)
		ns_ck_cnt <= 17'b0;
	 else if (ns_ck_cnt == 17'd9999)
		ns_ck_cnt <= 17'b0;
	 else
		ns_ck_cnt <= ns_ck_cnt+1'b1;
	 
	 always @ *
	 if (ns_ck_cnt == 17'd99)
		dat_ck = 1'b1;
	 else
		dat_ck = 1'b0;
		
	 always @ (posedge CLK or negedge RST_B)
	 if (!RST_B)
		dat_halfclk <= 1'b0;
	 else
		dat_halfclk <= ~dat_halfclk;
	 
	 always @ *
	 case(NS_DAT_CTL)
	 2'b00: NS_DAT_OUT = 1'b0;
	 2'b01: NS_DAT_OUT = 1'b1;
	 2'b10: NS_DAT_OUT = dat_halfclk;
	 2'b11: NS_DAT_OUT = dat_ck;
/*	 2'b00: NS_DAT_OUT = dat_halfclk;
	 2'b01: NS_DAT_OUT = dat_ck;
	 2'b10: NS_DAT_OUT = 1'b1;
	 2'b11: NS_DAT_OUT = 1'b1;
*/	 endcase
	 


endmodule
