`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:50 10/21/2021 
// Design Name: 
// Module Name:    DFF_DATA_OUTPUT 
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
module DFF_DATA_OUTPUT(
	input data_clk,
	input save_data,
	input reset,
	
	input [11:0] DFF_ERROR_0_0, // 12nm only has 10 bits of possible errors instead of 14 as in 22nm (CHIP0)
	input [11:0] DFF_ERROR_0_1, // 12nm LS_CNT has only 12 counting bits for a maximum count of 4095 which was never seen before while testing 22nm
	input [11:0] DFF_ERROR_0_2,
	input [11:0] DFF_ERROR_0_3,
	input [11:0] DFF_ERROR_0_4,
	input [11:0] DFF_ERROR_0_5,
	input [11:0] DFF_ERROR_0_6,
	input [11:0] DFF_ERROR_0_7,
	input [11:0] DFF_ERROR_0_8,
	input [11:0] DFF_ERROR_0_9,
	input [11:0] DFF_ERROR_1_0, // 12nm only has 10 bits of possible errors instead of 14 as in 22nm (CHIP1)
	input [11:0] DFF_ERROR_1_1, // 12nm LS_CNT has only 12 counting bits for a maximum count of 4095 which was never seen before while testing 22nm
	input [11:0] DFF_ERROR_1_2,
	input [11:0] DFF_ERROR_1_3,
	input [11:0] DFF_ERROR_1_4,
	input [11:0] DFF_ERROR_1_5,
	input [11:0] DFF_ERROR_1_6,
	input [11:0] DFF_ERROR_1_7,
	input [11:0] DFF_ERROR_1_8,
	input [11:0] DFF_ERROR_1_9,
	
	output reg DATA_OUT
    );
	 
	reg [9:0] output_count;	// stores how many clks have occured
	reg [7:0] output_count_12;	// resets after each 12 bits in order to change which data is outputted
	
	initial begin
		output_count <= 10'd0;
		output_count_12 <= 8'd0;
	end
	
	reg [11:0] DFF_ERROR_0_0_SAVE; // Chip 0 save
	reg [11:0] DFF_ERROR_0_1_SAVE;
	reg [11:0] DFF_ERROR_0_2_SAVE;
	reg [11:0] DFF_ERROR_0_3_SAVE;
	reg [11:0] DFF_ERROR_0_4_SAVE;
	reg [11:0] DFF_ERROR_0_5_SAVE;
	reg [11:0] DFF_ERROR_0_6_SAVE;
	reg [11:0] DFF_ERROR_0_7_SAVE;
	reg [11:0] DFF_ERROR_0_8_SAVE;
	reg [11:0] DFF_ERROR_0_9_SAVE;
	reg [11:0] DFF_ERROR_1_0_SAVE; // Chip 1 save
	reg [11:0] DFF_ERROR_1_1_SAVE;
	reg [11:0] DFF_ERROR_1_2_SAVE;
	reg [11:0] DFF_ERROR_1_3_SAVE;
	reg [11:0] DFF_ERROR_1_4_SAVE;
	reg [11:0] DFF_ERROR_1_5_SAVE;
	reg [11:0] DFF_ERROR_1_6_SAVE;
	reg [11:0] DFF_ERROR_1_7_SAVE;
	reg [11:0] DFF_ERROR_1_8_SAVE;
	reg [11:0] DFF_ERROR_1_9_SAVE;
	
	reg [11:0] chain_select;
	
	
	initial begin
		chain_select <= DFF_ERROR_0_SAVE;
	end

	
	
	// logic to save the current error counts to then proceed to data output
	always @ (posedge save_data)
		begin
			DFF_ERROR_0_0_SAVE <= DFF_ERROR_0_0; // chip 0
			DFF_ERROR_0_1_SAVE <= DFF_ERROR_0_1;
			DFF_ERROR_0_2_SAVE <= DFF_ERROR_0_2;
			DFF_ERROR_0_3_SAVE <= DFF_ERROR_0_3;
			DFF_ERROR_0_4_SAVE <= DFF_ERROR_0_4;
			DFF_ERROR_0_5_SAVE <= DFF_ERROR_0_5;
			DFF_ERROR_0_6_SAVE <= DFF_ERROR_0_6;
			DFF_ERROR_0_7_SAVE <= DFF_ERROR_0_7;
			DFF_ERROR_0_8_SAVE <= DFF_ERROR_0_8;
			DFF_ERROR_0_9_SAVE <= DFF_ERROR_0_9;
			DFF_ERROR_1_0_SAVE <= DFF_ERROR_1_0; //chip 1
			DFF_ERROR_1_1_SAVE <= DFF_ERROR_1_1;
			DFF_ERROR_1_2_SAVE <= DFF_ERROR_1_2;
			DFF_ERROR_1_3_SAVE <= DFF_ERROR_1_3;
			DFF_ERROR_1_4_SAVE <= DFF_ERROR_1_4;
			DFF_ERROR_1_5_SAVE <= DFF_ERROR_1_5;
			DFF_ERROR_1_6_SAVE <= DFF_ERROR_1_6;
			DFF_ERROR_1_7_SAVE <= DFF_ERROR_1_7;
			DFF_ERROR_1_8_SAVE <= DFF_ERROR_1_8;
			DFF_ERROR_1_9_SAVE <= DFF_ERROR_1_9;
		end
	
	// increase the data count and increase C select line after each frequency has been read
	always @ (posedge data_clk)
		if (~reset) begin // if reset, start from DFF0 on Chip 0
			output_count <= 10'd0;
			output_count_12 <= 8'd0;
			chain_select <= DFF_ERROR_0_0_SAVE;
		end
		else begin
			case(output_count) // every 12 bits read, move to the next set of DFF ERROR counts
				10'd11: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_1_SAVE;
				end
				10'd23: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_2_SAVE;
				end
				10'd35: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_3_SAVE;
				end
				10'd47: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_4_SAVE;
				end
				10'd59: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_5_SAVE;
				end
				10'd71: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_6_SAVE;
				end
				10'd83: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_7_SAVE;
				end
				10'd95: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_8_SAVE;
				end
				10'd107: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_9_SAVE;
				end
				10'd119: begin // end of Chip 0 chains and start of Chip 1 chains
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_0_SAVE;
				end
				10'd131: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_1_SAVE;
				end
				10'd143: begin 
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_2_SAVE;
				end
				10'd155: begin 
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_3_SAVE;
				end
				10'd167: begin 
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_4_SAVE;
				end
				10'd179: begin 
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_5_SAVE;
				end
				10'd191: begin 
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_6_SAVE;
				end
				10'd203: begin 
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_7_SAVE;
				end
				10'd215: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_8_SAVE;
				end
				10'd227: begin
					output_count <= output_count + 1'b1;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_1_9_SAVE;
				end
				10'd239: begin // end of chain, go back to chip 0, chain 0, restart count
					output_count <= 10'd0;
					output_count_12 <= 8'd0;
					chain_select <= DFF_ERROR_0_0_SAVE;
				end
				default: begin // when not at the end of a chain, count up
					output_count <= output_count + 1'b1;
					output_count_12 <= output_count_12 + 1'b1;
					chain_select <= chain_select;
				end
			endcase
		end
			
	 // now begin outputting the correct data to the output	
	initial begin
		DATA_OUT = 1'd0;
	end
	
	always @ (posedge data_clk)
		if (~reset)
			DATA_OUT = 1'b0;
		else begin
			case(output_count_12)		// now toggle between all the different data selects for the output, there are 12*10 bits to send
				8'd0    :   DATA_OUT = chain_select[0];
				8'd1    :   DATA_OUT = chain_select[1];
				8'd2    :   DATA_OUT = chain_select[2];
				8'd3    :   DATA_OUT = chain_select[3];
				8'd4    :   DATA_OUT = chain_select[4];
				8'd5    :   DATA_OUT = chain_select[5];
				8'd6    :   DATA_OUT = chain_select[6];
				8'd7    :   DATA_OUT = chain_select[7];
				8'd8    :   DATA_OUT = chain_select[8];
				8'd9    :   DATA_OUT = chain_select[9];
				8'd10   :   DATA_OUT = chain_select[10];
				8'd11   :   DATA_OUT = chain_select[11];
				default :	DATA_OUT = 1'b0;	// just set to 0 for default
			endcase
		end


endmodule
