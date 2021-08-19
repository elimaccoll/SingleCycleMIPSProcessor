`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:42:11 PM
// Design Name: 
// Module Name: MUX3
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


module MUX3(input wire [8:0] DataMemOut,
            input wire [8:0] result,
            input wire MemtoReg,
            output reg [8:0] WriteData);

    always @(DataMemOut, result, MemtoReg)
        begin
            if(MemtoReg == 0) 
                 WriteData = result;
            else
                 WriteData = DataMemOut;
        end
endmodule

