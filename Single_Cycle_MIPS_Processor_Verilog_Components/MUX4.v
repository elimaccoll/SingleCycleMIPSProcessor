`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:42:50 PM
// Design Name: 
// Module Name: MUX4
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


module MUX4(input wire RegDst,
            input wire [1:0] rd_addr,
            input wire [1:0] rt_addr,
            output reg [1:0] WriteAddr);
    
    always @(RegDst, rd_addr, rt_addr)
    begin
        if(RegDst == 0)
             WriteAddr <= rt_addr;
        else
             WriteAddr <= rd_addr;
    end
endmodule

