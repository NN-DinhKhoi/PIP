`timescale 1ns / 1ps
module controller (
input wire clk,
input wire rstN,
input wire Enable,
input wire check_all,
input wire load_done,
output reg [15:0]CW,
output wire finished
);
parameter S0=0, S1=1, S2=2, S3=3, S4=4;
reg [2:0] cur, next;

always @(posedge clk or negedge rstN) begin
    if (~rstN)
        cur <= S0;
    else
        cur <= next;
end
//0 temp, 1 addr, 2 ocount, 3 d0 
//CW = LOAD WEA WEB WAA WAB RAA RAB CHECK ALUop OutputSignal

//S0: IDLE
//S1: addr = 0, Ocount = 0
//S2: Temp = ( CHECK(adrr) ) ? 1 : 0, addr = addr + 1
//S3: Ocount = Ocount + Temp(if add != POINTS -> S2 else -> S4)
//S4: Outport = Ocount, finished
always @(*) begin
	case(cur)
		S0: next = (Enable) ? S1 : S0; 
		S1: next = (load_done) ? S2 : S1;
		S2: next = S3;						 
		S3: next = (check_all) ? S4 : S2;						   
		S4: next = S0;						 
		default:next = S0;
	endcase	
end

always @(*) begin
	case(cur)
		//CW =    LOAD  WEA   WEB    WAA    WAB    RAA    RAB   CHECK ALUop OutputSignal
		S1: CW = {1'b1, 1'b0, 1'b0, 2'b01, 2'b10, 2'bxx, 2'bxx, 1'bx, 3'd5, 1'b0};
		S2: CW = {1'b0, 1'b1, 1'b1, 2'b00, 2'b01, 2'b01, 2'b01, 1'b1, 3'd7, 1'b0};
		S3: CW = {1'b0, 1'b0, 1'b1, 2'bxx, 2'b10, 2'b00, 2'b10, 1'b0, 3'd5, 1'b0};
		S4: CW = {1'b0, 1'b0, 1'b0, 2'bxx, 2'bxx, 2'b11, 2'b10, 1'b0, 3'd4, 1'b1};
		default:CW = 16'h0000;
	endcase	
end
assign finished = (cur == S4) ? 1'b1 : 1'b0;
endmodule