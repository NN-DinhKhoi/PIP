`timescale 1ns / 1ps
module PIP #(parameter WIDTH = 16, POINTS = 5) (
input wire clk,
input wire rstN,
input wire Enable,
input wire [WIDTH-1:0] x_check,
input wire [WIDTH-1:0] y_check,
input wire  [WIDTH-1:0] x_in, 
input wire [WIDTH-1:0] y_in, 
output wire finished,
output wire [WIDTH-1:0] Result
);

wire check_all;
wire load_done;
wire [15:0] CW;
controller cu(.*);
datapath #(WIDTH, POINTS) pu(.*);

endmodule
