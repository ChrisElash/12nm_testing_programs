`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:10 07/23/2021 
// Design Name: 
// Module Name:    RO_DATA_OUTPUT 
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
module RO_DATA_OUTPUT(
	input data_clk,
	input reset,
	
	input [31:0] INV_COUNT,
	input [31:0] NAND_COUNT,
	input [31:0] NOR_COUNT,
	input [31:0] CLK_COUNT,
	
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
		if (~reset)
			begin
				output_count <= 8'd0;
				C <= 2'd0;
			end
		else if (output_count == 8'd127)	// 128 data bits 
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
		if (~reset)
			begin
				DATA_OUT = 8'd0;
			end
		else
			begin
				case(output_count)		// now toggle between all the different data selects for the output, there are 96 bits to send
					8'd0    :   DATA_OUT = INV_COUNT[0];
					8'd1    :   DATA_OUT = INV_COUNT[1];
					8'd2    :   DATA_OUT = INV_COUNT[2];
					8'd3    :   DATA_OUT = INV_COUNT[3];
					8'd4    :   DATA_OUT = INV_COUNT[4];
					8'd5    :   DATA_OUT = INV_COUNT[5];
					8'd6    :   DATA_OUT = INV_COUNT[6];
					8'd7    :   DATA_OUT = INV_COUNT[7];
					8'd8    :   DATA_OUT = INV_COUNT[8];
					8'd9    :   DATA_OUT = INV_COUNT[9];
					8'd10   :   DATA_OUT = INV_COUNT[10];
					8'd11   :   DATA_OUT = INV_COUNT[11];
					8'd12   :   DATA_OUT = INV_COUNT[12];
					8'd13   :   DATA_OUT = INV_COUNT[13];
					8'd14   :   DATA_OUT = INV_COUNT[14];
					8'd15   :   DATA_OUT = INV_COUNT[15];
					8'd16   :   DATA_OUT = INV_COUNT[16];
					8'd17   :   DATA_OUT = INV_COUNT[17];
					8'd18   :   DATA_OUT = INV_COUNT[18];
					8'd19   :   DATA_OUT = INV_COUNT[19];
					8'd20   :   DATA_OUT = INV_COUNT[20];
					8'd21   :   DATA_OUT = INV_COUNT[21];
					8'd22   :   DATA_OUT = INV_COUNT[22];
					8'd23   :   DATA_OUT = INV_COUNT[23];
					8'd24   :   DATA_OUT = INV_COUNT[24];
					8'd25   :   DATA_OUT = INV_COUNT[25];
					8'd26   :   DATA_OUT = INV_COUNT[26];
					8'd27   :   DATA_OUT = INV_COUNT[27];
					8'd28   :   DATA_OUT = INV_COUNT[28];
					8'd29   :   DATA_OUT = INV_COUNT[29];
					8'd30   :   DATA_OUT = INV_COUNT[30];
					8'd31   :   DATA_OUT = INV_COUNT[31];
					8'd32   :   DATA_OUT = NAND_COUNT[0];
					8'd33   :   DATA_OUT = NAND_COUNT[1];
					8'd34   :   DATA_OUT = NAND_COUNT[2];
					8'd35   :   DATA_OUT = NAND_COUNT[3];
					8'd36   :   DATA_OUT = NAND_COUNT[4];
					8'd37   :   DATA_OUT = NAND_COUNT[5];
					8'd38   :   DATA_OUT = NAND_COUNT[6];
					8'd39   :   DATA_OUT = NAND_COUNT[7];
					8'd40   :   DATA_OUT = NAND_COUNT[8];
					8'd41   :   DATA_OUT = NAND_COUNT[9];
					8'd42   :   DATA_OUT = NAND_COUNT[10];
					8'd43   :   DATA_OUT = NAND_COUNT[11];
					8'd44   :   DATA_OUT = NAND_COUNT[12];
					8'd45   :   DATA_OUT = NAND_COUNT[13];
					8'd46   :   DATA_OUT = NAND_COUNT[14];
					8'd47   :   DATA_OUT = NAND_COUNT[15];
					8'd48   :   DATA_OUT = NAND_COUNT[16];
					8'd49   :   DATA_OUT = NAND_COUNT[17];
					8'd50   :   DATA_OUT = NAND_COUNT[18];
					8'd51   :   DATA_OUT = NAND_COUNT[19];
					8'd52   :   DATA_OUT = NAND_COUNT[20];
					8'd53   :   DATA_OUT = NAND_COUNT[21];
					8'd54   :   DATA_OUT = NAND_COUNT[22];
					8'd55   :   DATA_OUT = NAND_COUNT[23];
					8'd56   :   DATA_OUT = NAND_COUNT[24];
					8'd57   :   DATA_OUT = NAND_COUNT[25];
					8'd58   :   DATA_OUT = NAND_COUNT[26];
					8'd59   :   DATA_OUT = NAND_COUNT[27];
					8'd60   :   DATA_OUT = NAND_COUNT[28];
					8'd61   :   DATA_OUT = NAND_COUNT[29];
					8'd62   :   DATA_OUT = NAND_COUNT[30];
					8'd63   :   DATA_OUT = NAND_COUNT[31];
					8'd64   :   DATA_OUT = NOR_COUNT[0];
					8'd65   :   DATA_OUT = NOR_COUNT[1];
					8'd66   :   DATA_OUT = NOR_COUNT[2];
					8'd67   :   DATA_OUT = NOR_COUNT[3];
					8'd68   :   DATA_OUT = NOR_COUNT[4];
					8'd69   :   DATA_OUT = NOR_COUNT[5];
					8'd70   :   DATA_OUT = NOR_COUNT[6];
					8'd71   :   DATA_OUT = NOR_COUNT[7];
					8'd72   :   DATA_OUT = NOR_COUNT[8];
					8'd73   :   DATA_OUT = NOR_COUNT[9];
					8'd74   :   DATA_OUT = NOR_COUNT[10];
					8'd75   :   DATA_OUT = NOR_COUNT[11];
					8'd76   :   DATA_OUT = NOR_COUNT[12];
					8'd77   :   DATA_OUT = NOR_COUNT[13];
					8'd78   :   DATA_OUT = NOR_COUNT[14];
					8'd79   :   DATA_OUT = NOR_COUNT[15];
					8'd80   :   DATA_OUT = NOR_COUNT[16];
					8'd81   :   DATA_OUT = NOR_COUNT[17];
					8'd82   :   DATA_OUT = NOR_COUNT[18];
					8'd83   :   DATA_OUT = NOR_COUNT[19];
					8'd84   :   DATA_OUT = NOR_COUNT[20];
					8'd85   :   DATA_OUT = NOR_COUNT[21];
					8'd86   :   DATA_OUT = NOR_COUNT[22];
					8'd87   :   DATA_OUT = NOR_COUNT[23];
					8'd88   :   DATA_OUT = NOR_COUNT[24];
					8'd89   :   DATA_OUT = NOR_COUNT[25];
					8'd90   :   DATA_OUT = NOR_COUNT[26];
					8'd91   :   DATA_OUT = NOR_COUNT[27];
					8'd92   :   DATA_OUT = NOR_COUNT[28];
					8'd93   :   DATA_OUT = NOR_COUNT[29];
					8'd94   :   DATA_OUT = NOR_COUNT[30];
					8'd95   :   DATA_OUT = NOR_COUNT[31];
					8'd96	:	DATA_OUT = CLK_COUNT[0];
					8'd97	:	DATA_OUT = CLK_COUNT[1];
					8'd98	:	DATA_OUT = CLK_COUNT[2];
					8'd99	:	DATA_OUT = CLK_COUNT[3];
					8'd100	:	DATA_OUT = CLK_COUNT[4];
					8'd101	:	DATA_OUT = CLK_COUNT[5];
					8'd102	:	DATA_OUT = CLK_COUNT[6];
					8'd103	:	DATA_OUT = CLK_COUNT[7];
					8'd104	:	DATA_OUT = CLK_COUNT[8];
					8'd105	:	DATA_OUT = CLK_COUNT[9];
					8'd106	:	DATA_OUT = CLK_COUNT[10];
					8'd107	:	DATA_OUT = CLK_COUNT[11];
					8'd108	:	DATA_OUT = CLK_COUNT[12];
					8'd109	:	DATA_OUT = CLK_COUNT[13];
					8'd110	:	DATA_OUT = CLK_COUNT[14];
					8'd111	:	DATA_OUT = CLK_COUNT[15];
					8'd112	:	DATA_OUT = CLK_COUNT[16];
					8'd113	:	DATA_OUT = CLK_COUNT[17];
					8'd114	:	DATA_OUT = CLK_COUNT[18];
					8'd115	:	DATA_OUT = CLK_COUNT[19];
					8'd116	:	DATA_OUT = CLK_COUNT[20];
					8'd117	:	DATA_OUT = CLK_COUNT[21];
					8'd118	:	DATA_OUT = CLK_COUNT[22];
					8'd119	:	DATA_OUT = CLK_COUNT[23];
					8'd120	:	DATA_OUT = CLK_COUNT[24];
					8'd121	:	DATA_OUT = CLK_COUNT[25];
					8'd122	:	DATA_OUT = CLK_COUNT[26];
					8'd123	:	DATA_OUT = CLK_COUNT[27];
					8'd124	:	DATA_OUT = CLK_COUNT[28];
					8'd125	:	DATA_OUT = CLK_COUNT[29];
					8'd126	:	DATA_OUT = CLK_COUNT[30];
					8'd127	:	DATA_OUT = CLK_COUNT[31];
					default :	DATA_OUT = 8'd0;	// just set to 0 for default
				endcase
			end





endmodule
