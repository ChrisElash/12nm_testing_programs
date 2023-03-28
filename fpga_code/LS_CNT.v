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
	input RST, // Active High
	input CREST_IN,
	input RPG_IN,
	output reg [11:0] ERR_CNT,
	output reg comp_out
	);
	
reg [5:0] comp;
reg comp_en;
reg pulse_delay;
reg pulse;
reg comp_start;
reg comp_in_pulse;

always @ (posedge CLK or posedge RST) // push comp_in to comp buffer and pop MSB off the buffer or reset comp buffer 
	if (RST)
		comp <= 6'b000000;
	else
		comp <= {comp[5:1], CREST_IN};

assign comp_in_pulse = comp[1] & ~comp[2]; // if two conncurrent bits pulse, start compare

always @ (posedge CLK or posedge RST) // enable compare on pulse
	if (RST)
		comp_en <= 1'b0;
	else if (comp_in_pulse)
		comp_en <= 1'b1;
	else
		comp_en <= comp_en;

always @ (posedge CLK) begin // delay the pulse one and two clks
	pulse_delay <= comp_en;
	pulse <= comp_en &~ pulse_delay;
end

always @ (posedge CLK or posedge RST) // create a start signal to start the input and output comparing based on if RPG_IN and pulse are both high
	if (RST)
		comp_start <= 1'b0;
	else if (RPG_IN & pulse)
		comp_start <= 1'b1;
	else
		comp_start = comp_start;

always @ (posedge CLK) // if RPG_IN and pulse are high do a comparision of RPG_IN and comp_in
	if (comp_start)
		comp_out <= comp_in ^ RPG_IN;
	else
		comp_out <= 1'b0;

always @ (posedge CLK or posedge RST)
	if (RST)
		ERR_CNT <= 0;
	else if (comp_out == 1) // if comp_in != rpg_in
		ERR_CNT <= ERR_CNT + 1;

endmodule