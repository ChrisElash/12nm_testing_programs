`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:10 07/23/2021 
// Design Name: 
// Module Name:    RO_DATA_OUTPUT 
// Project Name: 12nm Testing Programs
// Target Devices: Xilinx FPGA, Output Circuit
// Tool versions: 
// Description: Send Count for INV, NAND, NOR, DividorOutput in a serial fashion to RPi
//
// Dependencies: None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RO_DATA_OUTPUT(
	input data_clk,
	input reset,
	
	input [31:0] INV_COUNT0,
	input [31:0] NAND_COUNT0,
	input [31:0] NOR_COUNT0,
	input [31:0] DividerOutput_COUNT0,
	input [31:0] INV_COUNT1,
	input [31:0] NAND_COUNT1,
	input [31:0] NOR_COUNT1,
	input [31:0] DividerOutput_COUNT1,
	
	output reg [1:0] C,
	output reg DATA_OUT
    );
	 
	 
	// keep track of a counter of which bits to send out
	
	// start the select lines at 0
	initial begin
		C <= 2'd0;
	end
	
	reg [7:0] output_count;
	
	initial begin
		output_count <= 8'd0;
	end
	
	// increase the data count and increase C select line after each frequency has been read
	always @ (posedge data_clk)
		if (reset)
			begin
				output_count <= 8'd0;
				C <= 2'd0;
			end
		else if (output_count == 8'd256)	// 128*2 = 256 data bits 
			begin
				output_count <= 8'd0;
				C <= C + 1'd1;
			end
		else 
			begin
				output_count <= output_count + 1'b1;
				C <= C;
			end
		
				
				
	// now begin outputting the correct data to the output
	
	initial begin
		DATA_OUT = 8'd0;
	end
	
	always @ (posedge data_clk)
		if (reset)
			begin
				DATA_OUT = 8'd0;
			end
		else
			begin
				case(output_count)		// now toggle between all the different data selects for the output, there are 128 bits to send
					8'd0    :       DATA_OUT = INV_COUNT0[0];
					8'd1    :       DATA_OUT = INV_COUNT0[1];
					8'd2    :       DATA_OUT = INV_COUNT0[2];
					8'd3    :       DATA_OUT = INV_COUNT0[3];
					8'd4    :       DATA_OUT = INV_COUNT0[4];
					8'd5    :       DATA_OUT = INV_COUNT0[5];
					8'd6    :       DATA_OUT = INV_COUNT0[6];
					8'd7    :       DATA_OUT = INV_COUNT0[7];
					8'd8    :       DATA_OUT = INV_COUNT0[8];
					8'd9    :       DATA_OUT = INV_COUNT0[9];
					8'd10   :       DATA_OUT = INV_COUNT0[10];
					8'd11   :       DATA_OUT = INV_COUNT0[11];
					8'd12   :       DATA_OUT = INV_COUNT0[12];
					8'd13   :       DATA_OUT = INV_COUNT0[13];
					8'd14   :       DATA_OUT = INV_COUNT0[14];
					8'd15   :       DATA_OUT = INV_COUNT0[15];
					8'd16   :       DATA_OUT = INV_COUNT0[16];
					8'd17   :       DATA_OUT = INV_COUNT0[17];
					8'd18   :       DATA_OUT = INV_COUNT0[18];
					8'd19   :       DATA_OUT = INV_COUNT0[19];
					8'd20   :       DATA_OUT = INV_COUNT0[20];
					8'd21   :       DATA_OUT = INV_COUNT0[21];
					8'd22   :       DATA_OUT = INV_COUNT0[22];
					8'd23   :       DATA_OUT = INV_COUNT0[23];
					8'd24   :       DATA_OUT = INV_COUNT0[24];
					8'd25   :       DATA_OUT = INV_COUNT0[25];
					8'd26   :       DATA_OUT = INV_COUNT0[26];
					8'd27   :       DATA_OUT = INV_COUNT0[27];
					8'd28   :       DATA_OUT = INV_COUNT0[28];
					8'd29   :       DATA_OUT = INV_COUNT0[29];
					8'd30   :       DATA_OUT = INV_COUNT0[30];
					8'd31   :       DATA_OUT = INV_COUNT0[31];
					8'd32   :       DATA_OUT = NAND_COUNT0[0];
					8'd33   :       DATA_OUT = NAND_COUNT0[1];
					8'd34   :       DATA_OUT = NAND_COUNT0[2];
					8'd35   :       DATA_OUT = NAND_COUNT0[3];
					8'd36   :       DATA_OUT = NAND_COUNT0[4];
					8'd37   :       DATA_OUT = NAND_COUNT0[5];
					8'd38   :       DATA_OUT = NAND_COUNT0[6];
					8'd39   :       DATA_OUT = NAND_COUNT0[7];
					8'd40   :       DATA_OUT = NAND_COUNT0[8];
					8'd41   :       DATA_OUT = NAND_COUNT0[9];
					8'd42   :       DATA_OUT = NAND_COUNT0[10];
					8'd43   :       DATA_OUT = NAND_COUNT0[11];
					8'd44   :       DATA_OUT = NAND_COUNT0[12];
					8'd45   :       DATA_OUT = NAND_COUNT0[13];
					8'd46   :       DATA_OUT = NAND_COUNT0[14];
					8'd47   :       DATA_OUT = NAND_COUNT0[15];
					8'd48   :       DATA_OUT = NAND_COUNT0[16];
					8'd49   :       DATA_OUT = NAND_COUNT0[17];
					8'd50   :       DATA_OUT = NAND_COUNT0[18];
					8'd51   :       DATA_OUT = NAND_COUNT0[19];
					8'd52   :       DATA_OUT = NAND_COUNT0[20];
					8'd53   :       DATA_OUT = NAND_COUNT0[21];
					8'd54   :       DATA_OUT = NAND_COUNT0[22];
					8'd55   :       DATA_OUT = NAND_COUNT0[23];
					8'd56   :       DATA_OUT = NAND_COUNT0[24];
					8'd57   :       DATA_OUT = NAND_COUNT0[25];
					8'd58   :       DATA_OUT = NAND_COUNT0[26];
					8'd59   :       DATA_OUT = NAND_COUNT0[27];
					8'd60   :       DATA_OUT = NAND_COUNT0[28];
					8'd61   :       DATA_OUT = NAND_COUNT0[29];
					8'd62   :       DATA_OUT = NAND_COUNT0[30];
					8'd63   :       DATA_OUT = NAND_COUNT0[31];
					8'd64   :       DATA_OUT = NOR_COUNT0[0];
					8'd65   :       DATA_OUT = NOR_COUNT0[1];
					8'd66   :       DATA_OUT = NOR_COUNT0[2];
					8'd67   :       DATA_OUT = NOR_COUNT0[3];
					8'd68   :       DATA_OUT = NOR_COUNT0[4];
					8'd69   :       DATA_OUT = NOR_COUNT0[5];
					8'd70   :       DATA_OUT = NOR_COUNT0[6];
					8'd71   :       DATA_OUT = NOR_COUNT0[7];
					8'd72   :       DATA_OUT = NOR_COUNT0[8];
					8'd73   :       DATA_OUT = NOR_COUNT0[9];
					8'd74   :       DATA_OUT = NOR_COUNT0[10];
					8'd75   :       DATA_OUT = NOR_COUNT0[11];
					8'd76   :       DATA_OUT = NOR_COUNT0[12];
					8'd77   :       DATA_OUT = NOR_COUNT0[13];
					8'd78   :       DATA_OUT = NOR_COUNT0[14];
					8'd79   :       DATA_OUT = NOR_COUNT0[15];
					8'd80   :       DATA_OUT = NOR_COUNT0[16];
					8'd81   :       DATA_OUT = NOR_COUNT0[17];
					8'd82   :       DATA_OUT = NOR_COUNT0[18];
					8'd83   :       DATA_OUT = NOR_COUNT0[19];
					8'd84   :       DATA_OUT = NOR_COUNT0[20];
					8'd85   :       DATA_OUT = NOR_COUNT0[21];
					8'd86   :       DATA_OUT = NOR_COUNT0[22];
					8'd87   :       DATA_OUT = NOR_COUNT0[23];
					8'd88   :       DATA_OUT = NOR_COUNT0[24];
					8'd89   :       DATA_OUT = NOR_COUNT0[25];
					8'd90   :       DATA_OUT = NOR_COUNT0[26];
					8'd91   :       DATA_OUT = NOR_COUNT0[27];
					8'd92   :       DATA_OUT = NOR_COUNT0[28];
					8'd93   :       DATA_OUT = NOR_COUNT0[29];
					8'd94   :       DATA_OUT = NOR_COUNT0[30];
					8'd95   :       DATA_OUT = NOR_COUNT0[31];
					8'd96   :       DATA_OUT = DividerOutput_COUNT0[0];
					8'd97   :       DATA_OUT = DividerOutput_COUNT0[1];
					8'd98   :       DATA_OUT = DividerOutput_COUNT0[2];
					8'd99   :       DATA_OUT = DividerOutput_COUNT0[3];
					8'd100  :       DATA_OUT = DividerOutput_COUNT0[4];
					8'd101  :       DATA_OUT = DividerOutput_COUNT0[5];
					8'd102  :       DATA_OUT = DividerOutput_COUNT0[6];
					8'd103  :       DATA_OUT = DividerOutput_COUNT0[7];
					8'd104  :       DATA_OUT = DividerOutput_COUNT0[8];
					8'd105  :       DATA_OUT = DividerOutput_COUNT0[9];
					8'd106  :       DATA_OUT = DividerOutput_COUNT0[10];
					8'd107  :       DATA_OUT = DividerOutput_COUNT0[11];
					8'd108  :       DATA_OUT = DividerOutput_COUNT0[12];
					8'd109  :       DATA_OUT = DividerOutput_COUNT0[13];
					8'd110  :       DATA_OUT = DividerOutput_COUNT0[14];
					8'd111  :       DATA_OUT = DividerOutput_COUNT0[15];
					8'd112  :       DATA_OUT = DividerOutput_COUNT0[16];
					8'd113  :       DATA_OUT = DividerOutput_COUNT0[17];
					8'd114  :       DATA_OUT = DividerOutput_COUNT0[18];
					8'd115  :       DATA_OUT = DividerOutput_COUNT0[19];
					8'd116  :       DATA_OUT = DividerOutput_COUNT0[20];
					8'd117  :       DATA_OUT = DividerOutput_COUNT0[21];
					8'd118  :       DATA_OUT = DividerOutput_COUNT0[22];
					8'd119  :       DATA_OUT = DividerOutput_COUNT0[23];
					8'd120  :       DATA_OUT = DividerOutput_COUNT0[24];
					8'd121  :       DATA_OUT = DividerOutput_COUNT0[25];
					8'd122  :       DATA_OUT = DividerOutput_COUNT0[26];
					8'd123  :       DATA_OUT = DividerOutput_COUNT0[27];
					8'd124  :       DATA_OUT = DividerOutput_COUNT0[28];
					8'd125  :       DATA_OUT = DividerOutput_COUNT0[29];
					8'd126  :       DATA_OUT = DividerOutput_COUNT0[30];
					8'd127  :       DATA_OUT = DividerOutput_COUNT0[31];
					8'd128  :       DATA_OUT = INV_COUNT1[0];
					8'd129  :       DATA_OUT = INV_COUNT1[1];
					8'd130  :       DATA_OUT = INV_COUNT1[2];
					8'd131  :       DATA_OUT = INV_COUNT1[3];
					8'd132  :       DATA_OUT = INV_COUNT1[4];
					8'd133  :       DATA_OUT = INV_COUNT1[5];
					8'd134  :       DATA_OUT = INV_COUNT1[6];
					8'd135  :       DATA_OUT = INV_COUNT1[7];
					8'd136  :       DATA_OUT = INV_COUNT1[8];
					8'd137  :       DATA_OUT = INV_COUNT1[9];
					8'd138  :       DATA_OUT = INV_COUNT1[10];
					8'd139  :       DATA_OUT = INV_COUNT1[11];
					8'd140  :       DATA_OUT = INV_COUNT1[12];
					8'd141  :       DATA_OUT = INV_COUNT1[13];
					8'd142  :       DATA_OUT = INV_COUNT1[14];
					8'd143  :       DATA_OUT = INV_COUNT1[15];
					8'd144  :       DATA_OUT = INV_COUNT1[16];
					8'd145  :       DATA_OUT = INV_COUNT1[17];
					8'd146  :       DATA_OUT = INV_COUNT1[18];
					8'd147  :       DATA_OUT = INV_COUNT1[19];
					8'd148  :       DATA_OUT = INV_COUNT1[20];
					8'd149  :       DATA_OUT = INV_COUNT1[21];
					8'd150  :       DATA_OUT = INV_COUNT1[22];
					8'd151  :       DATA_OUT = INV_COUNT1[23];
					8'd152  :       DATA_OUT = INV_COUNT1[24];
					8'd153  :       DATA_OUT = INV_COUNT1[25];
					8'd154  :       DATA_OUT = INV_COUNT1[26];
					8'd155  :       DATA_OUT = INV_COUNT1[27];
					8'd156  :       DATA_OUT = INV_COUNT1[28];
					8'd157  :       DATA_OUT = INV_COUNT1[29];
					8'd158  :       DATA_OUT = INV_COUNT1[30];
					8'd159  :       DATA_OUT = INV_COUNT1[31];
					8'd160  :       DATA_OUT = NAND_COUNT1[0];
					8'd161  :       DATA_OUT = NAND_COUNT1[1];
					8'd162  :       DATA_OUT = NAND_COUNT1[2];
					8'd163  :       DATA_OUT = NAND_COUNT1[3];
					8'd164  :       DATA_OUT = NAND_COUNT1[4];
					8'd165  :       DATA_OUT = NAND_COUNT1[5];
					8'd166  :       DATA_OUT = NAND_COUNT1[6];
					8'd167  :       DATA_OUT = NAND_COUNT1[7];
					8'd168  :       DATA_OUT = NAND_COUNT1[8];
					8'd169  :       DATA_OUT = NAND_COUNT1[9];
					8'd170  :       DATA_OUT = NAND_COUNT1[10];
					8'd171  :       DATA_OUT = NAND_COUNT1[11];
					8'd172  :       DATA_OUT = NAND_COUNT1[12];
					8'd173  :       DATA_OUT = NAND_COUNT1[13];
					8'd174  :       DATA_OUT = NAND_COUNT1[14];
					8'd175  :       DATA_OUT = NAND_COUNT1[15];
					8'd176  :       DATA_OUT = NAND_COUNT1[16];
					8'd177  :       DATA_OUT = NAND_COUNT1[17];
					8'd178  :       DATA_OUT = NAND_COUNT1[18];
					8'd179  :       DATA_OUT = NAND_COUNT1[19];
					8'd180  :       DATA_OUT = NAND_COUNT1[20];
					8'd181  :       DATA_OUT = NAND_COUNT1[21];
					8'd182  :       DATA_OUT = NAND_COUNT1[22];
					8'd183  :       DATA_OUT = NAND_COUNT1[23];
					8'd184  :       DATA_OUT = NAND_COUNT1[24];
					8'd185  :       DATA_OUT = NAND_COUNT1[25];
					8'd186  :       DATA_OUT = NAND_COUNT1[26];
					8'd187  :       DATA_OUT = NAND_COUNT1[27];
					8'd188  :       DATA_OUT = NAND_COUNT1[28];
					8'd189  :       DATA_OUT = NAND_COUNT1[29];
					8'd190  :       DATA_OUT = NAND_COUNT1[30];
					8'd191  :       DATA_OUT = NAND_COUNT1[31];
					8'd192  :       DATA_OUT = NOR_COUNT1[0];
					8'd193  :       DATA_OUT = NOR_COUNT1[1];
					8'd194  :       DATA_OUT = NOR_COUNT1[2];
					8'd195  :       DATA_OUT = NOR_COUNT1[3];
					8'd196  :       DATA_OUT = NOR_COUNT1[4];
					8'd197  :       DATA_OUT = NOR_COUNT1[5];
					8'd198  :       DATA_OUT = NOR_COUNT1[6];
					8'd199  :       DATA_OUT = NOR_COUNT1[7];
					8'd200  :       DATA_OUT = NOR_COUNT1[8];
					8'd201  :       DATA_OUT = NOR_COUNT1[9];
					8'd202  :       DATA_OUT = NOR_COUNT1[10];
					8'd203  :       DATA_OUT = NOR_COUNT1[11];
					8'd204  :       DATA_OUT = NOR_COUNT1[12];
					8'd205  :       DATA_OUT = NOR_COUNT1[13];
					8'd206  :       DATA_OUT = NOR_COUNT1[14];
					8'd207  :       DATA_OUT = NOR_COUNT1[15];
					8'd208  :       DATA_OUT = NOR_COUNT1[16];
					8'd209  :       DATA_OUT = NOR_COUNT1[17];
					8'd210  :       DATA_OUT = NOR_COUNT1[18];
					8'd211  :       DATA_OUT = NOR_COUNT1[19];
					8'd212  :       DATA_OUT = NOR_COUNT1[20];
					8'd213  :       DATA_OUT = NOR_COUNT1[21];
					8'd214  :       DATA_OUT = NOR_COUNT1[22];
					8'd215  :       DATA_OUT = NOR_COUNT1[23];
					8'd216  :       DATA_OUT = NOR_COUNT1[24];
					8'd217  :       DATA_OUT = NOR_COUNT1[25];
					8'd218  :       DATA_OUT = NOR_COUNT1[26];
					8'd219  :       DATA_OUT = NOR_COUNT1[27];
					8'd220  :       DATA_OUT = NOR_COUNT1[28];
					8'd221  :       DATA_OUT = NOR_COUNT1[29];
					8'd222  :       DATA_OUT = NOR_COUNT1[30];
					8'd223  :       DATA_OUT = NOR_COUNT1[31];
					8'd224  :       DATA_OUT = DividerOutput_COUNT1[0];
					8'd225  :       DATA_OUT = DividerOutput_COUNT1[1];
					8'd226  :       DATA_OUT = DividerOutput_COUNT1[2];
					8'd227  :       DATA_OUT = DividerOutput_COUNT1[3];
					8'd228  :       DATA_OUT = DividerOutput_COUNT1[4];
					8'd229  :       DATA_OUT = DividerOutput_COUNT1[5];
					8'd230  :       DATA_OUT = DividerOutput_COUNT1[6];
					8'd231  :       DATA_OUT = DividerOutput_COUNT1[7];
					8'd232  :       DATA_OUT = DividerOutput_COUNT1[8];
					8'd233  :       DATA_OUT = DividerOutput_COUNT1[9];
					8'd234  :       DATA_OUT = DividerOutput_COUNT1[10];
					8'd235  :       DATA_OUT = DividerOutput_COUNT1[11];
					8'd236  :       DATA_OUT = DividerOutput_COUNT1[12];
					8'd237  :       DATA_OUT = DividerOutput_COUNT1[13];
					8'd238  :       DATA_OUT = DividerOutput_COUNT1[14];
					8'd239  :       DATA_OUT = DividerOutput_COUNT1[15];
					8'd240  :       DATA_OUT = DividerOutput_COUNT1[16];
					8'd241  :       DATA_OUT = DividerOutput_COUNT1[17];
					8'd242  :       DATA_OUT = DividerOutput_COUNT1[18];
					8'd243  :       DATA_OUT = DividerOutput_COUNT1[19];
					8'd244  :       DATA_OUT = DividerOutput_COUNT1[20];
					8'd245  :       DATA_OUT = DividerOutput_COUNT1[21];
					8'd246  :       DATA_OUT = DividerOutput_COUNT1[22];
					8'd247  :       DATA_OUT = DividerOutput_COUNT1[23];
					8'd248  :       DATA_OUT = DividerOutput_COUNT1[24];
					8'd249  :       DATA_OUT = DividerOutput_COUNT1[25];
					8'd250  :       DATA_OUT = DividerOutput_COUNT1[26];
					8'd251  :       DATA_OUT = DividerOutput_COUNT1[27];
					8'd252  :       DATA_OUT = DividerOutput_COUNT1[28];
					8'd253  :       DATA_OUT = DividerOutput_COUNT1[29];
					8'd254  :       DATA_OUT = DividerOutput_COUNT1[30];
					8'd255  :       DATA_OUT = DividerOutput_COUNT1[31];
					default :		DATA_OUT = 8'd0;	// just set to 0 for default
				endcase
			end





endmodule
