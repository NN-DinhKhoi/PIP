//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
//Date        : Wed Dec 11 19:34:16 2024
//Host        : DESKTOP-R9-7945HX running 64-bit major release  (build 9200)
//Command     : generate_target multiply_wrapper.bd
//Design      : multiply_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module multiply_wrapper
   (A_0,
    B_0,
    CE_0,
    CLK_0,
    P_0);
  input [15:0]A_0;
  input [15:0]B_0;
  input CE_0;
  input CLK_0;
  output [31:0]P_0;

  wire [15:0]A_0;
  wire [15:0]B_0;
  wire CE_0;
  wire CLK_0;
  wire [31:0]P_0;

  multiply multiply_i
       (.A_0(A_0),
        .B_0(B_0),
        .CE_0(CE_0),
        .CLK_0(CLK_0),
        .P_0(P_0));
endmodule
