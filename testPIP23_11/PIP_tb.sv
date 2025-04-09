`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 10:11:07 PM
// Design Name: 
// Module Name: PIP_tb
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


module PIP_tb #(parameter WIDTH = 16, POINTS = 5);

reg clk;
reg rstN;
reg Enable;
reg [WIDTH-1:0] x_check;
reg [WIDTH-1:0] y_check;
reg  [WIDTH-1:0] x_in; 
reg [WIDTH-1:0] y_in; 
wire finished;
wire [WIDTH-1:0] Result;
PIP #(WIDTH,POINTS) PIP (clk,rstN,Enable,x_check,y_check,x_in,y_in,finished,Result);

initial begin
    rstN = 0;
    clk = 1;
    forever #10 clk = ~clk;
end
initial begin
    Enable = 0;
    x_check = 16'b0000000000000000;
    y_check = 16'b0000000000000000;
    x_in = 16'b0000000000000000;
    y_in = 16'b0000000000000000;
    #15;
    rstN=1;
    #20;
    Enable = 1;
    #20;
    x_check = 16'b0000000000000100;
    y_check = 16'b0000000000000100;
    x_in = 16'b0000000000000010;
    y_in = 16'b0000000000000110;
    #20;
    x_in = 16'b0000000000000011;
    y_in = 16'b0000000000000011;
    #20;
    x_in = 16'b0000000000000011;
    y_in = 16'b0000000000000010;
    #20;
    x_in = 16'b0000000000000110;
    y_in = 16'b0000000000000011;
    #20;
    x_in = 16'b0000000000000110;
    y_in = 16'b0000000000000101;
//    x_in = '{
//        16'b0000000000000010,
//        16'b0000000000000011,
//        16'b0000000000000011,
//        16'b0000000000000110,
//        16'b0000000000000110

       
//    };   
//    y_in = '{
//        16'b0000000000000110,
//        16'b0000000000000011,
//        16'b0000000000000010,
//        16'b0000000000000011, 
//        16'b0000000000000101
      
//    };
    #20;
    Enable = 0;
end




endmodule
