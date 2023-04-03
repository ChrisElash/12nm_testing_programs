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
	input RST, // Active High
	input Q, // Output from TestChip
	input DATA, // Output from Data Gen (Same value that is inputted to Q before being outputted)
	output reg [11:0] ERR_CNT, // Count anytime that Q != DATA
	output reg comp_out // Real Time Comparision Value
	);
	
reg [5:0] comp; // Push/Pop Register
reg comp_en;
reg pulse_delay;
reg pulse;
reg comp_start;
reg comp_in_pulse;

always @ (posedge CLK or posedge RST) // push Q to comp buffer and pop MSB off the buffer or reset comp buffer 
	if (RST)
		comp <= 6'b000000;
	else
		comp <= {comp[4:0], Q}; // Pushes out the MSB and Pushes in the new input

assign comp_in_pulse = comp[1] & ~comp[2]; // Finding Rising Edge of The Push/Pop Register

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

always @ (posedge CLK or posedge RST) // create a start signal to start the input and output comparing based on if DATA and pulse are both high
	if (RST)
		comp_start <= 1'b0;
	else if (DATA & pulse)
		comp_start <= 1'b1;
	else
		comp_start = comp_start;

always @ (posedge CLK) // if DATA and pulse are high do a comparision of DATA and Q (Check Data inputted is the same as the output)
	if (comp_start)
		comp_out <= Q ^ DATA;
	else
		comp_out <= 1'b0;

always @ (posedge CLK or posedge RST)
	if (~RST)
		ERR_CNT <= 0;
	else if (comp_out == 1'b1) // if Q != DATA
		ERR_CNT <= ERR_CNT + 1;

endmodule