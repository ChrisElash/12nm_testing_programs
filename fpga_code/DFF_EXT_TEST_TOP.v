`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04/14/2023
// Design Name: 
// Module Name:    DFF_EXT_TEST_TOP
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

module DFF_EXT_TEST_TOP(
    input CLK_50M,
    output enable, // EXT == 1'b0, INT == 1'b1
    output DAT_DUT,

    // RPi Signals
    input save_data_dff_pi,
    input data_clk_dff_pi,
    output data_out_dff_pi,
    input reset_RO_pi;
    input read_data_RO_pi;
    input data_clk_RO_pi;
    input data_out_RO_pi;

    // Output From TestChip Chains
    input DB_DFFQ0_0,
    input DB_DFFQ0_1,
    input DB_DFFQ0_2,
    input DB_DFFQ0_3,
    input DB_DFFQ0_4,
    input DB_DFFQ0_5,
    input DB_DFFQ0_6,
    input DB_DFFQ0_7,
    input DB_DFFQ0_8,
    input DB_DFFQ0_9,
    input DB_DFFQ1_0,
    input DB_DFFQ1_1,
    input DB_DFFQ1_2,
    input DB_DFFQ1_3,
    input DB_DFFQ1_4,
    input DB_DFFQ1_5,
    input DB_DFFQ1_6,
    input DB_DFFQ1_7,
    input DB_DFFQ1_8,
    input DB_DFFQ1_9,

    // RO Module Signals
    // Chip 0
    input O_INV0;
    input O_NAND0;
    input O_NOR0;
    input DividerOutput0;
    // Chip 1
    input O_INV0;
    input O_NAND0;
    input O_NOR0;
    input DividerOutput0;
    // Shared
    output [1:0] C; // Internal Clock Gen Freqency Control
);

// CLK GEN wires
wire RST_B;
wire CLK_MUXOUT;
wire CLK_400M;
wire clk_100m;
wire CLK_100K;
wire clk_50m_sys;

// Wire to pass error count from LS_CNT to Output circuit
wire [11:0] ERR_CNT_DFFQ0_0;
wire [11:0] ERR_CNT_DFFQ0_1;
wire [11:0] ERR_CNT_DFFQ0_2;
wire [11:0] ERR_CNT_DFFQ0_3;
wire [11:0] ERR_CNT_DFFQ0_4;
wire [11:0] ERR_CNT_DFFQ0_5;
wire [11:0] ERR_CNT_DFFQ0_6;
wire [11:0] ERR_CNT_DFFQ0_7;
wire [11:0] ERR_CNT_DFFQ0_8;
wire [11:0] ERR_CNT_DFFQ0_9;
wire [11:0] ERR_CNT_DFFQ1_0;
wire [11:0] ERR_CNT_DFFQ1_1;
wire [11:0] ERR_CNT_DFFQ1_2;
wire [11:0] ERR_CNT_DFFQ1_3;
wire [11:0] ERR_CNT_DFFQ1_4;
wire [11:0] ERR_CNT_DFFQ1_5;
wire [11:0] ERR_CNT_DFFQ1_6;
wire [11:0] ERR_CNT_DFFQ1_7;
wire [11:0] ERR_CNT_DFFQ1_8;
wire [11:0] ERR_CNT_DFFQ1_9;

wire comp_out0_0, comp_out0_1, comp_out0_2, comp_out0_3, comp_out0_4, comp_out0_5, comp_out0_6, comp_out0_7, comp_out0_8, comp_out0_9;
wire comp_out1_0, comp_out1_1, comp_out1_2, comp_out1_3, comp_out1_4, comp_out1_5, comp_out1_6, comp_out1_7, comp_out1_8, comp_out1_9;

assign enable == 1'b1;
assign DAT_DUT == 1'b1;

wire w_rst;
wire RST_PER;
assign RST_PER = ~reset_RO_pi;
assign w_rst = ~(RST_B & ~RST_PER);

CLK_GEN_TOP CLK_GEN_TOP(
    .CLK_50M(CLK_50M),
    .CLK_CTL(2'b10),
    .CLK_400M(CLK_400M),
    .clk_100m(clk_100m),
    .CLK_MUXOUT(CLK_MUXOUT),
    .CLK_100K(CLK_100K),
    .CLK_REG(clk_50m_sys),
    .RST_B(RST_B)
);

DATA_GEN DATA_GEN(
    .CLK(CLK_MUXOUT),
    .RST_B(~w_rst),
    .NS_DAT_CTL(2'b01),
    .NS_DAT_OUT(DAT_DUT)
);

// Compare Testing Result and Testing Input

LS_CNT LS_CNT_DFF0_0(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_0),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_0),
    .comp_out(comp_out0_0)
);
LS_CNT LS_CNT_DFF0_1(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_1),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_1),
    .comp_out(comp_out0_1)
);
LS_CNT LS_CNT_DFF0_2(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_2),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_2),
    .comp_out(comp_out0_2)
);
LS_CNT LS_CNT_DFF0_3(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_3),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_3),
    .comp_out(comp_out0_3)
);
LS_CNT LS_CNT_DFF0_4(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_4),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_4),
    .comp_out(comp_out0_4)
);
LS_CNT LS_CNT_DFF0_5(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_5),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_5),
    .comp_out(comp_out0_5)
);
LS_CNT LS_CNT_DFF0_6(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_6),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_6),
    .comp_out(comp_out0_6)
);
LS_CNT LS_CNT_DFF0_7(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_7),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_7),
    .comp_out(comp_out0_7)
);
LS_CNT LS_CNT_DFF0_8(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_8),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_8),
    .comp_out(comp_out0_8)
);
LS_CNT LS_CNT_DFF0_9(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ0_9),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ0_9),
    .comp_out(comp_out0_9)
);
LS_CNT LS_CNT_DFF1_0(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_0),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_0),
    .comp_out(comp_out1_0)
);
LS_CNT LS_CNT_DFF1_1(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_1),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_1),
    .comp_out(comp_out1_1)
);
LS_CNT LS_CNT_DFF1_2(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_2),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_2),
    .comp_out(comp_out1_2)
);
LS_CNT LS_CNT_DFF1_3(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_3),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_3),
    .comp_out(comp_out1_3)
);
LS_CNT LS_CNT_DFF1_4(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_4),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_4),
    .comp_out(comp_out1_4)
);
LS_CNT LS_CNT_DFF1_5(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_5),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_5),
    .comp_out(comp_out1_5)
);
LS_CNT LS_CNT_DFF1_6(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_6),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_6),
    .comp_out(comp_out1_6)
);
LS_CNT LS_CNT_DFF1_7(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_7),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_7),
    .comp_out(comp_out1_7)
);
LS_CNT LS_CNT_DFF1_8(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_8),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_8),
    .comp_out(comp_out1_8)
);
LS_CNT LS_CNT_DFF1_9(
    .CLK(CLK_MUXOUT),
    .RST(w_rst),
    .Q(DB_DFFQ1_9),
    .DATA(DAT_DUT),
    .ERR_CNT(ERR_CNT_DFFQ1_9),
    .comp_out(comp_out1_9)
);

// Data Management and Data Output Modules For Tests
// Signals For Data Modules
wire [31:0] INV_COUNT0;
wire [31:0] NAND_COUNT0;
wire [31:0] NOR_COUNT0;
wire [31:0] DividerOutput_COUNT0;
wire [31:0] INV_COUNT1;
wire [31:0] NAND_COUNT1;
wire [31:0] NOR_COUNT1;
wire [31:0] DividerOutput_COUNT1;

// Module Frequency Counting for RO outputs: CHIP0 & CHIP1
RO_FREQ_COUNTER RO_FREQ_COUNTER0(
    .CLK(CLK_MUXOUT),
    .read_data(read_data_RO_pi),
    .O_INV(O_INV0),
    .O_NAND(O_NAND0),
    .O_NOR(O_NOR0),
    .DividerOutput(DividerOutput0),
    .INV_COUNT(INV_COUNT0),
    .NAND_COUNT(NAND_COUNT0),
    .NOR_COUNT(NOR_COUNT0),
    .DividerOutput_COUNT(DividerOutput_COUNT0)
);
RO_FREQ_COUNTER RO_FREQ_COUNTER1(
    .CLK(CLK_MUXOUT),
    .read_data(read_data_RO_pi),
    .O_INV(O_INV1),
    .O_NAND(O_NAND1),
    .O_NOR(O_NOR1),
    .DividerOutput(DividerOutput1),
    .INV_COUNT(INV_COUNT1),
    .NAND_COUNT(NAND_COUNT1),
    .NOR_COUNT(NOR_COUNT1),
    .DividerOutput_COUNT(DividerOutput_COUNT1)
);
// Modules For Outputting RO COUNTs: CHIP0 & CHIP1
RO_DATA_OUTPUT RO_DATA_OUTPUT0(
    .data_clk(data_clk_RO_pi),
    .reset(reset_RO_pi),
    .INV_COUNT0(INV_COUNT0),
    .NAND_COUNT0(NAND_COUNT0),
    .NOR_COUNT0(NOR_COUNT0),
    .DividerOutput_COUNT0(DividerOutput_COUNT0),
    .INV_COUNT1(INV_COUNT1),
    .NAND_COUNT1(NAND_COUNT1),
    .NOR_COUNT1(NOR_COUNT1),
    .DividerOutput_COUNT1(DividerOutput_COUNT1),

    .C(C),
    .DATA_OUT(data_out_RO_pi),
);
// Modules For Controlling/Collecting Error Counts for the Internal Shifter Blocks
SHIFTER_TESTER SHIFTER_TESTER(

);
SHIFTER_OUTPUT SHIFTER_OUTPUT(
    
);
// Module For Outputting ERROR count Data Collecteted by LS_CNT Modules
DFF_DATA_OUTPUT DFF_DATA_OUTPUT(

);

endmodule
