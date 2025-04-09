`timescale 1ns / 1ps


module fxp_multiplier #(parameter DATA_WIDTH = 16, FRACTIONAL = 5) (
input wire clk,
input wire mult_select,
input wire [DATA_WIDTH-1:0] multiplicand,
input wire [DATA_WIDTH-1:0] multiplier,
output wire [DATA_WIDTH-1:0] product
    );

wire [DATA_WIDTH*2-1:0] temp_product;

multiply mult (.A_0(multiplicand), .B_0(multiplier), .CE_0(mult_select), .CLK_0(clk), .P_0(temp_product));

assign product = temp_product >>> FRACTIONAL;    
    
endmodule
