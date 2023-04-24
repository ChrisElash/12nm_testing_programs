`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    4/12/2023 
// Design Name: 
// Module Name:    DFF_DATA_SAVE 
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
    input shift_clk,
    input load,
    input Q0,
    input Q1,
    input Q2,
    input Q3,
    input Q4,
    input Q5,
    input Q6,
    input Q7,
    input Q8,
    input Q9,

    output reg [11:0] data0,
    output reg [11:0] data1,
    output reg [11:0] data2,
    output reg [11:0] data3,
    output reg [11:0] data4,
    output reg [11:0] data5,
    output reg [11:0] data6,
    output reg [11:0] data7,
    output reg [11:0] data8,
    output reg [11:0] data9,
);

reg [5:0] bit_count;

always @ (posedge shift_clk) // For future reference this block is just using the PISO block in the testchip to serially grab the internal error count in the error detector
    if(load == 1'b0)
        case(bit_count)
            6'd0: begin // LSB
                data0[0] <= Q0;
                data1[0] <= Q1;
                data2[0] <= Q2;
                data3[0] <= Q3;
                data4[0] <= Q4;
                data5[0] <= Q5;
                data6[0] <= Q6;
                data7[0] <= Q7;
                data8[0] <= Q8;
                data9[0] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd1: begin
                data0[1] <= Q0;
                data1[1] <= Q1;
                data2[1] <= Q2;
                data3[1] <= Q3;
                data4[1] <= Q4;
                data5[1] <= Q5;
                data6[1] <= Q6;
                data7[1] <= Q7;
                data8[1] <= Q8;
                data9[1] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd2: begin
                data0[2] <= Q0;
                data1[2] <= Q1;
                data2[2] <= Q2;
                data3[2] <= Q3;
                data4[2] <= Q4;
                data5[2] <= Q5;
                data6[2] <= Q6;
                data7[2] <= Q7;
                data8[2] <= Q8;
                data9[2] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd3: begin
                data0[3] <= Q0;
                data1[3] <= Q1;
                data2[3] <= Q2;
                data3[3] <= Q3;
                data4[3] <= Q4;
                data5[3] <= Q5;
                data6[3] <= Q6;
                data7[3] <= Q7;
                data8[3] <= Q8;
                data9[3] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd4: begin
                data0[4] <= Q0;
                data1[4] <= Q1;
                data2[4] <= Q2;
                data3[4] <= Q3;
                data4[4] <= Q4;
                data5[4] <= Q5;
                data6[4] <= Q6;
                data7[4] <= Q7;
                data8[4] <= Q8;
                data9[4] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd5: begin
                data0[5] <= Q0;
                data1[5] <= Q1;
                data2[5] <= Q2;
                data3[5] <= Q3;
                data4[5] <= Q4;
                data5[5] <= Q5;
                data6[5] <= Q6;
                data7[5] <= Q7;
                data8[5] <= Q8;
                data9[5] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd6: begin
                data0[6] <= Q0;
                data1[6] <= Q1;
                data2[6] <= Q2;
                data3[6] <= Q3;
                data4[6] <= Q4;
                data5[6] <= Q5;
                data6[6] <= Q6;
                data7[6] <= Q7;
                data8[6] <= Q8;
                data9[6] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd7: begin
                data0[7] <= Q0;
                data1[7] <= Q1;
                data2[7] <= Q2;
                data3[7] <= Q3;
                data4[7] <= Q4;
                data5[7] <= Q5;
                data6[7] <= Q6;
                data7[7] <= Q7;
                data8[7] <= Q8;
                data9[7] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd8: begin
                data0[8] <= Q0;
                data1[8] <= Q1;
                data2[8] <= Q2;
                data3[8] <= Q3;
                data4[8] <= Q4;
                data5[8] <= Q5;
                data6[8] <= Q6;
                data7[8] <= Q7;
                data8[8] <= Q8;
                data9[8] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd9: begin
                data0[9] <= Q0;
                data1[9] <= Q1;
                data2[9] <= Q2;
                data3[9] <= Q3;
                data4[9] <= Q4;
                data5[9] <= Q5;
                data6[9] <= Q6;
                data7[9] <= Q7;
                data8[9] <= Q8;
                data9[9] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd10: begin
                data0[10] <= Q0;
                data1[10] <= Q1;
                data2[10] <= Q2;
                data3[10] <= Q3;
                data4[10] <= Q4;
                data5[10] <= Q5;
                data6[10] <= Q6;
                data7[10] <= Q7;
                data8[10] <= Q8;
                data9[10] <= Q9;
                bit_count <= bit_count + 6'd1;
            end
            6'd11: begin // MSB
                data0[11] <= Q0;
                data1[11] <= Q1;
                data2[11] <= Q2;
                data3[11] <= Q3;
                data4[11] <= Q4;
                data5[11] <= Q5;
                data6[11] <= Q6;
                data7[11] <= Q7;
                data8[11] <= Q8;
                data9[11] <= Q9;
                bit_count <= 6'd0;
            end
        endcase

endmodule
