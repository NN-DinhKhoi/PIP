`timescale 1ns / 1ps
module datapath #(parameter WIDTH = 16, POINTS = 5) (

input wire clk,
input wire rstN,
input wire [WIDTH-1:0] x_check,
input wire [WIDTH-1:0] y_check,

input wire  [WIDTH-1:0] x_in, 
input wire [WIDTH-1:0] y_in, 

input wire [15:0]CW,
output wire check_all,
output wire load_done,
output wire [WIDTH-1:0] Result
);
	 
//register file 
//0 temp, 1 addr, 2 ocount, 3 d0 
//CW = LOAD WEA WEB WAA WAB RAA RAB CHECK ALUop OutputSignal

wire LOAD, WEA, WEB, CHECK, OS;
wire [1:0] WAA, WAB, RAA, RAB;
wire [2:0] ALUop;
wire [WIDTH-1:0] O_alu, O_check;
//reg en_sort;
assign {LOAD, WEA, WEB, WAA, WAB, RAA, RAB, CHECK, ALUop, OS} = CW;
wire overlap;
wire [WIDTH-1:0] RDA, RDB;
assign Result = (OS) ? ( (!overlap) ? O_alu  : 0 ) : 0;
//assign check_all = (WAB == 2'b01) ? ((O_alu == POINTS) ? 1 : 0 ) : 0;;

alu #(WIDTH) ALU(.alu_op(ALUop), .a(RDA), .b(RDB), .out_alu(O_alu));

check_edge #(WIDTH,POINTS) CE(.clk(clk), .rstN(rstN), .point_x(x_check), .point_y(y_check), 
							  .x_in(x_in), .y_in(y_in), .ADDR(RDA), .load_en(LOAD),  
							  .en(CHECK), .result(O_check),.overlap(overlap), .load_done(load_done));

RegisterFile #(WIDTH,POINTS) RegF(.clk(clk), .rstN(rstN), .LOAD(LOAD),
											 .WEA(WEA), .WEB(WEB), .WAA(WAA), .WAB(WAB),
											 .RAA(RAA), .RAB(RAB), .WDA(O_check), .WDB(O_alu),
											 .RDA(RDA), .RDB(RDB),.check_all(check_all));
								 
endmodule

