`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:40:45 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input wire rst, clk, wr_en,
    input wire [1:0] rd0_addr, rd1_addr, wr_addr,
    input wire [8:0] wr_data, 
    output wire [8:0] rd0_data, rd1_data);
reg [8:0] reg0, reg1, reg2, reg3;
  
assign rd0_data = rd0_addr == 0 ? reg0 :
        rd0_addr == 1 ? reg1 :
        rd0_addr == 2 ? reg2 :
        rd0_addr == 3 ? reg3 : 0;
        
assign rd1_data = rd1_addr == 0 ? reg0 :
       rd1_addr == 1 ? reg1 :
       rd1_addr == 2 ? reg2 :
       rd1_addr == 3 ? reg3 : 0;

always @(posedge clk) begin
    if (rst==1)begin
         reg0<=0;
         reg1<=0;
         reg2<=0;
         reg3<=0;
      end
    else begin
     if(wr_en)
      case (wr_addr)
        2'b00: begin
          reg0 <= wr_data;
        end
        2'b01: begin
          reg1 <= wr_data;
        end
        2'b10: begin
          reg2 <= wr_data;
        end
        2'b11: begin
          reg3 <= wr_data;
        end
      endcase 
     end
 end
endmodule

