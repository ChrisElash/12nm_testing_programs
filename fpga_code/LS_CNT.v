`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:18 05/13/2015 
// Design Name: 
// Module Name:    LS_CNT 
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
module LS_CNT(
    input CLK,
	input clk_100m,
    input RST_PER,//active high
    input CREST_IN,
    input RPG_IN,
	 input [1:0] CLK_CTRL,
    output reg [31:0] ERR_CNT,
	 output reg comp_out
    );
	 
	 reg crest_sam1;
	 reg crest_sam2;
//	 reg crest_sam3;
	 reg comp_in,comp_in_1,comp_in_2,comp_in_3,comp_in_4,comp_in_5,comp_in_6;
	 reg comp_en;
	 reg pulse_delay;
	 reg pulse;
//	 reg self_cnt_en;
	 reg comp_start1;
	 wire comp_in_pulse;
	 //wire comp_out;
	 
	 always @ (posedge CLK or posedge RST_PER)begin
	 if(RST_PER) begin
		crest_sam1 <= 0;
		crest_sam2 <= 0;
	 end
	 else begin
		crest_sam1 <= CREST_IN;
		crest_sam2 <= crest_sam1;
		end
	 end
	 
		
	 always @ *
	 if (CLK_CTRL == 2'b00)
		comp_in = crest_sam1;
	 else
		comp_in = crest_sam2;
		
	 always @(posedge CLK or posedge RST_PER ) begin
		if (RST_PER)begin
		comp_in_1 <= 1'b0;
		comp_in_2 <= 1'b0;
		comp_in_3 <= 1'b0;
		comp_in_4 <= 1'b0;
		comp_in_5 <= 1'b0;
		comp_in_6 <= 1'b0;
		end
		else begin
		comp_in_1 <= comp_in;
		comp_in_2 <= comp_in_1;
		comp_in_3 <= comp_in_2;
		comp_in_4 <= comp_in_3;
		comp_in_5 <= comp_in_4;
		comp_in_6 <= comp_in_5;
		end
	  end
	 assign	comp_in_pulse = comp_in_2 & ~comp_in_3;
	 
	 always @(posedge CLK or posedge RST_PER)begin
		if (RST_PER)
		comp_en <= 1'b0;
		else if (comp_in_pulse )
		comp_en <= 1'b1;
		else
		comp_en <= comp_en;
		end
	 	 always @(posedge CLK)begin
	    pulse_delay <= comp_en;
		pulse <= comp_en & ~ pulse_delay;	
	 end	
	 
	 always @(posedge CLK or posedge RST_PER)begin
		if (RST_PER)begin
		comp_start1 <= 1'b0;
		end
		else if (pulse&RPG_IN )
		comp_start1 <= 1'b1;
		else
		comp_start1 <= comp_start1;
		end

	 always @ (posedge CLK )begin
		if(comp_start1)
			 comp_out <= comp_in^RPG_IN;
		else
			comp_out <= 1'b0;	 
	 end	
	 
	 	 
	 initial begin
		ERR_CNT <= 0;
	 end
	 
	 always @ (posedge CLK or posedge RST_PER)
	 if (RST_PER)
		ERR_CNT <= 0;
	 else if (comp_out == 1) //if comp_in != rpg_in
		ERR_CNT <= ERR_CNT+1;//+1;


endmodule
