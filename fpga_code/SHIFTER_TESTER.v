`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date:    12:32:00 3/29/2023 
// Design Name: 
// Module Name:    SHIFTER_TESTER 
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
module SHIFTER_TESTER(
    input CLK,
    input RST,
    input SHIFT_OUT0,
    input SHIFT_OUT1,
    output SHIFT_INPUT0;
    output SHIFT_INPUT1;
    output reg [11:0] SHIFT_ERROR_COUNT0,
    output reg [11:0] SHIFT_ERROR_COUNT1,
);

// the input to the shifter will only be high so a low outut is a SET
assign SHIFT_INPUT0 <= 1'b1; 
assign SHIFT_INPUT1 <= 1'b1;

always @ (negedge SHIFT_OUT0) // using the shifter output as initializing signal, as if a negative edge happens there is a SET occurence
    SHIFT_ERROR_COUNT0 <= SHIFT_ERROR_COUNT0 + 12'd1;

always @ (negedge SHIFT_OUT1)
    SHIFT_ERROR_COUNT1 <= SHIFT_ERROR_COUNT1 + 12'd1;

endmodule
