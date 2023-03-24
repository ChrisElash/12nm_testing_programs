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
	
	input [31:0] DFF_ERROR_0,
	input [31:0] DFF_ERROR_1,
	input [31:0] DFF_ERROR_2,
	input [31:0] DFF_ERROR_3,
	input [31:0] DFF_ERROR_4,
	input [31:0] DFF_ERROR_5,
	input [31:0] DFF_ERROR_6,
	input [31:0] DFF_ERROR_7,
	input [31:0] DFF_ERROR_8,
	input [31:0] DFF_ERROR_9,
	input [31:0] DFF_ERROR_10,
	input [31:0] DFF_ERROR_11,
	input [31:0] DFF_ERROR_12,
	input [31:0] DFF_ERROR_13,
	
	output reg DATA_OUT
    );
	 
	reg [9:0] output_count;	// stores how many clks have occured
	reg [7:0] output_count_32;	// resets after each 32 bits in order to change which data is outputted
	
	initial begin
		output_count <= 10'd0;
		output_count_32 <= 8'd0;
	end
	
	
	reg [31:0] DFF_ERROR_0_SAVE;
	reg [31:0] DFF_ERROR_1_SAVE;
	reg [31:0] DFF_ERROR_2_SAVE;
	reg [31:0] DFF_ERROR_3_SAVE;
	reg [31:0] DFF_ERROR_4_SAVE;
	reg [31:0] DFF_ERROR_5_SAVE;
	reg [31:0] DFF_ERROR_6_SAVE;
	reg [31:0] DFF_ERROR_7_SAVE;
	reg [31:0] DFF_ERROR_8_SAVE;
	reg [31:0] DFF_ERROR_9_SAVE;
	reg [31:0] DFF_ERROR_10_SAVE;
	reg [31:0] DFF_ERROR_11_SAVE;
	reg [31:0] DFF_ERROR_12_SAVE;
	reg [31:0] DFF_ERROR_13_SAVE;
	
	reg [31:0] chain_select;
	
	
	initial begin
		chain_select <= DFF_ERROR_0_SAVE;
	end

	
	
	// logic to save the current error counts to then proceed to data output
	always @ (posedge save_data)
		begin
			DFF_ERROR_0_SAVE <= DFF_ERROR_0;
			DFF_ERROR_1_SAVE <= DFF_ERROR_1;
			DFF_ERROR_2_SAVE <= DFF_ERROR_2;
			DFF_ERROR_3_SAVE <= DFF_ERROR_3;
			DFF_ERROR_4_SAVE <= DFF_ERROR_4;
			DFF_ERROR_5_SAVE <= DFF_ERROR_5;
			DFF_ERROR_6_SAVE <= DFF_ERROR_6;
			DFF_ERROR_7_SAVE <= DFF_ERROR_7;
			DFF_ERROR_8_SAVE <= DFF_ERROR_8;
			DFF_ERROR_9_SAVE <= DFF_ERROR_9;
			DFF_ERROR_10_SAVE <= DFF_ERROR_10;
			DFF_ERROR_11_SAVE <= DFF_ERROR_11;
			DFF_ERROR_12_SAVE <= DFF_ERROR_12;
			DFF_ERROR_13_SAVE <= DFF_ERROR_13;
		end
	
	// increase the data count and increase C select line after each frequency has been read
	always @ (posedge data_clk)
		if (~reset)
			begin
				output_count <= 10'd0;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_0_SAVE;
			end
		else if (output_count == 10'd31)	// 31 data bits 
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_1_SAVE;
			end
		else if (output_count == 10'd63)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_2_SAVE;
			end
		else if (output_count == 10'd95)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_3_SAVE;
			end
		else if (output_count == 10'd127)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_4_SAVE;
			end
		else if (output_count == 10'd159)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_5_SAVE;
			end
		else if (output_count == 10'd191)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_6_SAVE;
			end
		else if (output_count == 10'd223)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_7_SAVE;
			end
		else if (output_count == 10'd255)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_8_SAVE;
			end
		else if (output_count == 10'd287)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_9_SAVE;
			end
		else if (output_count == 10'd319)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_10_SAVE;
			end
		else if (output_count == 10'd351)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_11_SAVE;
			end
		else if (output_count == 10'd383)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_12_SAVE;
			end
		else if (output_count == 10'd415)
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_13_SAVE;
			end
		else if (output_count == 10'd447)		// reached end so go back to DFF0
			begin
				output_count <= 10'd0;
				output_count_32 <= 8'd0;
				chain_select <= DFF_ERROR_0_SAVE;
			end
		else
			begin
				output_count <= output_count + 1'b1;
				output_count_32 <= output_count_32 + 1'b1;
				chain_select <= chain_select;
			end
			
		
	 
	 
	 // now begin outputting the correct data to the output
	
	initial begin
		DATA_OUT = 1'd0;
	end
	
	always @ (posedge data_clk)
		if (~reset)
			begin
				DATA_OUT = 1'd0;
			end
		else
			begin
				case(output_count_32)		// now toggle between all the different data selects for the output, there are 32*13 bits to send
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
					8'd12   :   DATA_OUT = chain_select[12];
					8'd13   :   DATA_OUT = chain_select[13];
					8'd14   :   DATA_OUT = chain_select[14];
					8'd15   :   DATA_OUT = chain_select[15];
					8'd16   :   DATA_OUT = chain_select[16];
					8'd17   :   DATA_OUT = chain_select[17];
					8'd18   :   DATA_OUT = chain_select[18];
					8'd19   :   DATA_OUT = chain_select[19];
					8'd20   :   DATA_OUT = chain_select[20];
					8'd21   :   DATA_OUT = chain_select[21];
					8'd22   :   DATA_OUT = chain_select[22];
					8'd23   :   DATA_OUT = chain_select[23];
					8'd24   :   DATA_OUT = chain_select[24];
					8'd25   :   DATA_OUT = chain_select[25];
					8'd26   :   DATA_OUT = chain_select[26];
					8'd27   :   DATA_OUT = chain_select[27];
					8'd28   :   DATA_OUT = chain_select[28];
					8'd29   :   DATA_OUT = chain_select[29];
					8'd30   :   DATA_OUT = chain_select[30];
					8'd31   :   DATA_OUT = chain_select[31];
					default :	DATA_OUT = 8'd0;	// just set to 0 for default
				endcase
			end


endmodule
