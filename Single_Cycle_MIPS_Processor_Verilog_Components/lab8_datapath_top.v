`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2020 09:47:58 PM
// Design Name: 
// Module Name: pdatapath_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Lab8_Datapath(
		input wire clk,
		input wire top_pb_clk,
        input wire rst_general,
		output [3:0] disp_en,
		output [6:0] seg7_output
    );
	
	wire [7:0] alu_input1, alu_input2;
    wire [7:0] alu_output;
    wire [2:0] ALUOp;
    wire       alu_ovf;
    wire       take_branch;
	
    
    wire [15:0] instruction;
    //insturction fields
    wire [3:0] opcode;
    wire [1:0] rs_addr;
    wire [1:0] rt_addr;
    wire [1:0] rd_addr;
    wire [7:0] immediate;
    //control signals
    wire RegDst;
    wire RegWrite;
    wire ALUSrc1;
    wire ALUSrc2;
    wire MemWrite;
    wire MemToReg;

    wire [1:0] regfile_write_address;//destination register address
    wire [8:0] regfile_write_data;//result data
    wire [8:0] read_data1;//source register1 data
    wire [8:0] read_data2;//source register2 data

    wire [8:0] alu_result;
    wire [7:0] zero_register;
    wire [8:0] data_mem_out;

    wire pb_clk_debounced;
	wire [7:0] pc;

	assign zero_register = 8'b0;//ZERO constant
	assign alu_result = {alu_ovf, alu_output};


		// Debounce
		debounce debounce_clk(
						.clk_in(clk),
						.rst_in(rst_general),
						.sig_in(top_pb_clk),
						.sig_debounced_out(pb_clk_debounced)
						);		
  
		// 7-Segment display module
	   	Adaptor_display display(.clk(clk), 				// system clock
							.input_value(alu_output),		// 8-bit input [7:0] value to display
							.disp_en(disp_en),			// output [3:0] 7 segment display enable
							.seg7_output(seg7_output));		// output [6:0] 7 segment signals
							
		/* Instantiate all other modules */
    program_counter p_counter(
        .pb_clk_debounced(pb_clk_debounced),
        .rst_general(rst_general),
        .immediate(immediate),
        .take_branch(take_branch),
        .pc(pc));
        
    instr_mem instruction_memory (
        .a(pc),      // input wire [7 : 0] a
        .spo(instruction)  // output wire [15 : 0] spo
        );
   	//**********Instantiate Your instruction decoder here**********//
    inst_decoder decoder(
        .instruction(instruction),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .MemtoReg(MemToReg),
        .opcode(opcode),
        .rs_addr(rs_addr),
        .rd_addr(rd_addr),
        .rt_addr(rt_addr),
        .immediate(immediate));
    
	//**********Instantiate Your alu-regfile here**********//
    eightbit_alu alu(
        .sel(ALUOp),
        .a(alu_input1),
        .b(alu_input2),
        .f(alu_output),
        .ovf(alu_ovf),
        .take_branch(take_branch)
        );
        
    reg_file register_file(
        .rst(rst_general),
        .clk(pb_clk_debounced),
        .wr_en(RegWrite),
        .rd0_addr(rs_addr),
        .rd1_addr(rt_addr),
        .wr_addr(regfile_write_address),
        .wr_data(regfile_write_data),
        .rd0_data(read_data1),
        .rd1_data(read_data2)
        );

 	//**********Instantiate Your data memory here**********//
	data_memory data_memory(
          .a(alu_output),      // input wire [7 : 0] a
          .d(read_data2),      // input wire [8 : 0] d
          .clk(pb_clk_debounced),  // input wire clk
          .we(MemWrite),    // input wire we
          .spo(data_mem_out) // output wire [8 : 0] spo
          );

	//**********Mux for regfile_writedata**********//
	 MUX1 MUX_1(
        .ALUSrc1(ALUSrc1), 
        .ReadData1(read_data1),
        .input1(alu_input1),
        .zero_register(zero_register)
        );
     
     MUX2 MUX_2(
        .ALUSrc2(ALUSrc2), 
        .ReadData2(read_data2),
        .Instr_i(immediate),
        .input2(alu_input2)
        );
        
     MUX3 MUX_3(
        .DataMemOut(data_mem_out),
        .result(alu_result),
        .MemtoReg(MemToReg),
        .WriteData(regfile_write_data)
        );

	//**********Mux for RegDST**********//
     MUX4 MUX_4(
        .RegDst(RegDst),
        .rd_addr(rd_addr),
        .rt_addr(rt_addr),
        .WriteAddr(regfile_write_address)
        );

      //********** Instantiate the VIO here **********//
     vio_0 vio( 
	      .clk(clk),
          .probe_in0(alu_output),
          .probe_in1(alu_ovf),
          .probe_in2(take_branch),
          .probe_in3(read_data1),
          .probe_in4(read_data2),
          .probe_in5(alu_input1),
          .probe_in6(alu_input2),
          .probe_in7(regfile_write_data),
          .probe_in8(data_mem_out),
          .probe_in9(opcode),
          .probe_in10(rs_addr),
          .probe_in11(rt_addr),
          .probe_in12(rd_addr),
          .probe_in13(immediate),
          .probe_in14(RegDst),
          .probe_in15(RegWrite),
          .probe_in16(ALUSrc1),
          .probe_in17(ALUSrc2),
          .probe_in18(ALUOp),
          .probe_in19(MemWrite),
          .probe_in20(MemToReg),
          .probe_in21(pc),
          .probe_in22(instruction)
          );
endmodule
