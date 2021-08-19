`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:44:42 PM
// Design Name: 
// Module Name: inst_decoder
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


module inst_decoder(input wire [15:0] instruction,
                    output reg RegWrite, RegDst, ALUSrc1, ALUSrc2,
                    output reg [2:0] ALUOp,
                    output reg MemWrite, MemtoReg,
                    output [3:0] opcode,
                    output reg [1:0] rs_addr, rt_addr, rd_addr,
                    output reg [7:0] immediate);    
    
    assign opcode = instruction[15:12];
        
    always @ (instruction)
        begin
            case(opcode)
            4'b0000: begin      //lw 
                RegDst <= 1'b0;
                RegWrite <= 1'b1;
                ALUSrc1 <= 1'b0;
                ALUSrc2 <= 1'b1;
                ALUOp <= 3'b000;
                MemWrite <= 1'b0;
                MemtoReg <= 1'b1;
                rs_addr <= instruction[11:10];
                rt_addr <= instruction[9:8];
                immediate <=instruction[7:0];
                end
            4'b0001: begin       //sw
               RegDst <= 1'b0;
               RegWrite <= 1'b0;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1; 
               ALUOp <= 3'b000;
               MemWrite <= 1'b1;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end 
            4'b0010: begin       //add
               RegDst <= 1'b1;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b000;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               rd_addr <= instruction[7:6];
               end 
             4'b0011: begin      //addi
               RegDst <= 1'b0;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1; 
               ALUOp <= 3'b000;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end
             4'b0100: begin      //inv
               RegDst <= 1'b1;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b001;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= 2'b00;
               rt_addr <= instruction[9:8];
               rd_addr <= instruction[7:6];
               end
             4'b0101: begin      //and
               RegDst <= 1'b1;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b010;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               rd_addr <= instruction[7:6];
               end
             4'b0110: begin      //andi
               RegDst <= 1'b0;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1; 
               ALUOp <= 3'b010;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end
             4'b0111: begin      //or
               RegDst <= 1'b1;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b011;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               rd_addr <= instruction[7:6];
               end
             4'b1000: begin      //ori
               RegDst <= 1'b0;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b1; 
               ALUOp <= 3'b011;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end
             4'b1001: begin      //sra
               RegDst <= 1'b0;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b100;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end
             4'b1010: begin      //sll
               RegDst <= 1'b0;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b101;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end
             4'b1011: begin      //beq
               RegDst <= 1'b0;
               RegWrite <= 1'b0;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b110;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end
             4'b1100: begin      //bne
               RegDst <= 1'b0;
               RegWrite <= 1'b0;
               ALUSrc1 <= 1'b0;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b111;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= instruction[11:10];
               rt_addr <= instruction[9:8];
               immediate <=instruction[7:0];
               end
             4'b1101: begin      //clr
               RegDst <= 1'b1;
               RegWrite <= 1'b1;
               ALUSrc1 <= 1'b1;
               ALUSrc2 <= 1'b0; 
               ALUOp <= 3'b010;
               MemWrite <= 1'b0;
               MemtoReg <= 1'b0;
               rs_addr <= 2'b00;
               rt_addr <= instruction[9:8];
               rd_addr <= instruction[9:8];
               end
            endcase  
        end
endmodule

