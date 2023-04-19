`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:31 05/11/2015 
// Design Name: 
// Module Name:    CLK_GEN_TOP 
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
module CLK_GEN_TOP(
    input CLK_50M,
    input [1:0] CLK_CTL,
    output CLK_400M,
	output clk_100m, //new 0425
	output  clk_10m,
    output reg CLK_MUXOUT,
	output CLK_100K,
	output CLK_REG, //50MHZ
	output RST_B
    );
	 
	 wire clk_4m;
	 reg clk_1m;
	 reg clk_100k_in;
	 reg clk_10k;
	 reg clk_2m;
	 reg [7:0] cnt_100k;
//	 wire clk_100m, clk_10m;
//	 wire  clk_10m;	
	 
	 CLK_GEN CLK_GEN ( //making output clock allign with the reference clock
    .CLKIN1_IN(CLK_50M), //reference clock, make setting in the .xaw
    .CLKOUT0_OUT(clk_4m), //determined by reference clock and multiply value and clockout_divide in the seeting of .xaw
	 .CLKOUT1_OUT(clk_100m), 
    .CLKOUT2_OUT(clk_10m), 
    .CLKOUT3_OUT(CLK_400M),
	 .CLKOUT4_OUT(CLK_REG), //50MHZ
    .LOCKED_OUT(RST_B) //goes high when the PLL has achived phase allignment and frequency matching
    );
	 
	 
	 //To generate 1MHZ clock, it cannot be generated directly by PLL module CLK_GEN, because the clockout_divide has limitd maximum value 128
	 initial begin
	 clk_2m <= 0;
	 clk_1m <= 0;
	 clk_10k <= 0;
	 end
	 always @ (posedge clk_4m)
	 	clk_2m <= ~clk_2m; //2 clk_4m cycles as one loop
	
	 always @ (posedge clk_2m )
	 	clk_1m <= ~clk_1m; //4MHZ/2/2 = 1MHZ 
		
		
	 //To gnerate 100KHZ clock
	 always @ (posedge clk_4m or negedge RST_B)
	 if (!RST_B)
		cnt_100k <= 0;
	 else if (cnt_100k == 8'd19) //20 clk_4m cycles as one loop
		cnt_100k <= 0;
	 else
		cnt_100k <= cnt_100k + 1;
	 
	 always @ (posedge clk_4m or negedge RST_B)
	 if (!RST_B)
		clk_100k_in <= 0;
	 else if (cnt_100k == 0)
		clk_100k_in <= ~clk_100k_in; //4MHZ/20/2 = 100KHZ
		
	//for testing
	 reg clk_test_50k, clk_test_25k, clk_test_12point5, clk_test_5k, clk_test_100Hz; 
	 reg [3:0] cnt10k, cnt5k;
	 reg [8:0] cnt100Hz;
	 
	 always @ (posedge clk_100k_in or negedge RST_B)
		if (!RST_B)
			clk_test_50k <= 1'b0;
		else
			clk_test_50k <= ~clk_test_50k;	
	
	 always @ (posedge clk_test_50k or negedge RST_B)
		if (!RST_B)
			clk_test_25k <= 1'b0;
		else
			clk_test_25k <= ~clk_test_25k;
			
	 always @ (posedge clk_test_25k or negedge RST_B)
		if (!RST_B)
			clk_test_12point5 <= 1'b0;
		else
			clk_test_12point5 <= ~clk_test_12point5;
	//To gnerate 10KHZ clock		
	always @ (posedge clk_100k_in or negedge RST_B)
		if (!RST_B)
			cnt10k <= 4'd0;
		else if (cnt10k == 4'd4)
			cnt10k <= 4'd0;
		else
			cnt10k <= cnt10k + 4'd1;
	
	always @ (posedge clk_100k_in)begin
		if  (cnt10k == 4'd0)
			clk_10k <= ~clk_10k;
		else
			clk_10k <= clk_10k;	
		end
			
	always @ (posedge clk_100k_in or negedge RST_B)
		if (!RST_B)
			cnt5k <= 4'd0;
		else if (cnt5k == 4'd9)
			cnt5k <= 4'd0;
		else
			cnt5k <= cnt5k + 4'd1;
	
	always @ (posedge clk_100k_in or negedge RST_B)
		if (!RST_B)
			clk_test_5k <= 1'd0;
		else if (cnt5k == 4'd9)
			clk_test_5k <= ~clk_test_5k;
		else
			clk_test_5k <= clk_test_5k;	
			
	always @ (posedge clk_100k_in or negedge RST_B)
		if (!RST_B)
			cnt100Hz <= 9'd0;
		else if (cnt5k == 9'd499)
			cnt100Hz <= 4'd0;
		else
			cnt100Hz <= cnt100Hz + 9'd1;
	
	always @ (posedge clk_100k_in or negedge RST_B)
		if (!RST_B)
			clk_test_100Hz <= 1'd0;
		else if (cnt100Hz == 9'd499)
			clk_test_100Hz <= ~clk_test_5k;
		else
			clk_test_100Hz <= clk_test_100Hz;			
		

		
	 always @ *
	 case (CLK_CTL)
	 2'b00: CLK_MUXOUT = clk_100m;
	 2'b01: CLK_MUXOUT = clk_10m;
	 2'b10: CLK_MUXOUT = clk_1m;
	 2'b11: CLK_MUXOUT = clk_100k_in;
//       2'b11: CLK_MUXOUT = clk_10k;
//	   2'b11: CLK_MUXOUT = clk_10m;

	 //2'b11: CLK_MUXOUT = clk_test_100Hz; //test
	 endcase
	 
	 assign CLK_100K = clk_100k_in; //why need clk_100k_in??? 





			
endmodule
