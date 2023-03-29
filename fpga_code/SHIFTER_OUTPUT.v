`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:32:00 3/29/2023 
// Design Name: 
// Module Name:    SHIFTER_OUTPUT 
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
module SHIFTER_OUTPUT(
    input DATA_CLK,
    input RST,
    input SAVE_DATA,

    output [11:0] SHIFT_ERROR0,
    output [11:0] SHIFT_ERROR1,

    output DATA_OUT,
);

reg [9:0] output_count;
reg [7:0] output_count_12;

initial begin
    output_count <= 10'd0;
    output_count_12 <= 8'd0;
end

reg [11:0] SHIFT_ERROR0_SAVE;
reg [11:0] SHIFT_ERROR1_SAVE;

reg [11:0] chain_select;

initial begin
    chain_select <= SHIFT_ERROR0_SAVE;
end

always @ (posedge SAVE_DATA) // save the current error count to send to output
    begin
        SHIFT_ERROR0_SAVE <= SHIFT_ERROR0;
        SHIFT_ERROR1_SAVE <= SHIFT_ERROR1;
    end

always @ (posedge DATA_CLK) // Using a single set of data to select the data in a serial fashion
    if (~RST) begin
        	output_count <= 10'd0;
			output_count_12 <= 8'd0;
			chain_select <= SHIFT_ERROR0_SAVE;
    end
    else begin
        case(output_count)
            10'd11: begin
                output_count <= output_count + 1'b1;
                output_count_12 <= 8'd0;
                chain_select <= SHIFT_ERROR1_SAVE;
            end
            10'd23: begin // end of chains, go back to start
                output_count <= 10'd0;
                output_count_12 <= 8'd0;
                chain_select <= SHIFT_ERROR0_SAVE;
            end
            default: begin // when not at the end of an indiviual chain, count up
                output_count <= output_count + 1'b1;
                output_count_12 <= output_count_12 + 1'b1;
                chain_select <= chain_select;
            end
        endcase
    end

initial begin
    DATA_OUT = 1'd0;
end

always @ (posedge DATA_CLK) begin
    if (~RST)
        DATA_OUT = 1'b0;
    else begin
        case(output_count_12)
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
            8'd10    :   DATA_OUT = chain_select[10];
            8'd11    :   DATA_OUT = chain_select[11];
            8'd12    :   DATA_OUT = chain_select[12];
            default :   DATA_OUT = 1'b0;
        endcase
    end
end

endmodule
