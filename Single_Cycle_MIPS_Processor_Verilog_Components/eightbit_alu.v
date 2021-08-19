`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:40:20 PM
// Design Name: 
// Module Name: eightbit_alu
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


module eightbit_alu(a,b,sel,f,ovf,take_branch);
    input signed [7:0] a,b;
    input [2:0] sel;
    output [7:0] f;
    output ovf, take_branch;
    reg signed [7:0] f;
    reg ovf, take_branch;

    always @(sel or a or b or f or ovf)begin
        case(sel)
            3'b000: begin   //addition
                 f=a+b;
                 ovf=((~a[7])&(~b[7])&f[7])|(a[7]&b[7]&(~f[7]));
                 take_branch=0;
               end
            3'b001: begin //inv b
                 f=~b;
                 ovf=0;
                 take_branch=0;
               end
            3'b010: begin //and
                 f=a&b;
                 ovf=0;
                 take_branch=0;
               end
            3'b011: begin //or
                 f=a|b;
                 ovf=0;
                 take_branch=0;
               end
            3'b100: begin //arithmetic shift right
                 f=a>>>1;
                 ovf=0;
                 take_branch=0;
               end
            3'b101: begin //logical shift left
                 f=a<<1;
                 ovf=0;
                 take_branch=0;
               end
            3'b110: begin //branch if equal
                 f=0;
                 ovf=0;
                 if(a==b)begin
                    take_branch=1;
                 end
                 else begin
                    take_branch=0;
                 end
               end
            3'b111: begin //branch not equal
                 f=0;
                 ovf=0;
                 if(a!=b)begin
                    take_branch=1;
                 end
                 else begin
                    take_branch=0;
                 end
               end
            default: begin
                 f=0;
                 ovf=0;
                 take_branch=0;
               end
        endcase
      end
endmodule

