// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Nov 25 14:23:36 2020
// Host        : vm-18-Xilinx running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top instr_mem -prefix
//               instr_mem_ instr_mem_stub.v
// Design      : instr_mem
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *)
module instr_mem(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[7:0],spo[15:0]" */;
  input [7:0]a;
  output [15:0]spo;
endmodule
