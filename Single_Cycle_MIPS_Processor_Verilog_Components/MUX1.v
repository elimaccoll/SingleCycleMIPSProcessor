`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:41:07 PM
// Design Name: 
// Module Name: MUX1
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


module MUX1(input wire ALUSrc1, 
           input wire[8:0] ReadData1, 
           input wire[7:0] zero_register,
           output reg[7:0] input1);
           
    always @(ReadData1,ALUSrc1)
    begin
        if(ALUSrc1 == 0)
             input1 = ReadData1;
        else
             input1 = zero_register;
    end
endmodule

