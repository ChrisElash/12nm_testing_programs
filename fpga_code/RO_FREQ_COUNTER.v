`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:04 07/23/2021 
// Design Name: 
// Module Name:    RO_FREQ_COUNTER 
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
module RO_FREQ_COUNTER(
	input CLK,
	input read_data,	// active low reset for this block
	input O_INV,
	input O_NAND,
	input O_NOR,
	input DividerOutput,
	
	output reg [31:0] INV_COUNT,
	output reg [31:0] NAND_COUNT,
	output reg [31:0] NOR_COUNT,
	output reg [31:0] DividerOutput_COUNT,
    );
	 
	 // So first we need to create a timer that lasts for exactly 0.1s
	 
	 reg count_enable;
	 reg [23:0] clk_counter;
	 
	 initial begin
		count_enable <= 1'b0;	// 0 to stop counting and 1 to count
		clk_counter <= 24'd0; 
	 end
	 
	 always @ (posedge CLK)	// clk should be counting at 1Mhz
		if (~read_data)
			begin
				count_enable <= 1'b0;
				clk_counter <= 24'd0;
			end
		else if (read_data && clk_counter == 24'd100000)		// if counter has gotten here, then 0.1s have elapsed
			begin
				clk_counter <= clk_counter;
				count_enable <= 1'b0;		// bring enable to 0 to stop counting
			end
		else
			begin
			clk_counter <= clk_counter + 1'b1;	// otherwise count up until 0.1 seconds have elapsed
			count_enable <= 1'b1;
			end
			
		

	// now we can count how many rising edges from each RO
	
	// Inverter counter
	always @ (posedge O_INV)
		if (~read_data)	// if read data is low then reset count
			begin
				INV_COUNT <= 32'd0;
			end
		else if (~count_enable)	// if count flag is low then the 0.1s is over and hold count
			begin
				INV_COUNT <= INV_COUNT;
			end
		else
			begin
			INV_COUNT <= INV_COUNT +1'b1;	// otherwise count each rising edge
			end
			
			
	// Nand counter	
	always @ (posedge O_NAND)
		if (~read_data)	// if read data is low then reset count
			begin
				NAND_COUNT <= 32'd0;
			end
		else if (~count_enable)	// if count flag is low then the 0.1s is over and hold count
			begin
				NAND_COUNT <= NAND_COUNT;
			end
		else
			begin
				NAND_COUNT <= NAND_COUNT +1'b1;	// otherwise count each rising edge
			end
			
	// Nor counter	
	always @ (posedge O_NOR)
		if (~read_data)	// if read data is low then reset count
			begin
				NOR_COUNT <= 32'd0;
			end
		else if (~count_enable)	// if count flag is low then the 0.1s is over and hold count
			begin
				NOR_COUNT <= NOR_COUNT;
			end
		else
			begin
				NOR_COUNT <= NOR_COUNT +1'b1;	// otherwise count each rising edge
			end

	// Dividor counter	
	always @ (posedge DividerOutput)
		if (~read_data)	// if read data is low then reset count
			begin
				DividerOutput_COUNT <= 32'd0;
			end
		else if (~count_enable)	// if count flag is low then the 0.1s is over and hold count
			begin
				DividerOutput_COUNT <= DividerOutput_COUNT;
			end
		else
			begin
				DividerOutput_COUNT <= DividerOutput_COUNT + 1'b1;	// otherwise count each rising edge
			end

endmodule
