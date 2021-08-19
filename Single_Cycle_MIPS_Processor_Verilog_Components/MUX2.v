`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:41:27 PM
// Design Name: 
// Module Name: MUX2
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


module MUX2(input wire ALUSrc2,
            input wire [8:0] ReadData2,
            input wire [7:0] Instr_i,
            output reg [7:0] input2);
        
    always @(ReadData2,ALUSrc2,Instr_i)
        begin
            if(ALUSrc2 == 0) 
                 input2 = ReadData2;
            else
                 input2 = Instr_i;
        end
endmodule

