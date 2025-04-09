`timescale 1ns / 1ps
module RegisterFile #(parameter WIDTH = 16, POINTS = 4)(
	input wire clk,
	input wire rstN,
	input wire LOAD, WEA, WEB,
	input wire [1:0] WAA, WAB, RAA, RAB,
	input wire [WIDTH-1:0] WDA, WDB,
	output reg [WIDTH-1:0] RDA, RDB,
	output check_all
	);
	//register file 
	//0 temp, 1 addr, 2 ocount, 3 d0 
	reg [WIDTH-1:0] RF [3:0];
	assign check_all = (RF[1] >= POINTS) ? 1 : 0;
	always @(posedge clk or negedge rstN) begin
		if(~rstN) begin
			RF[0] <= {WIDTH{1'b0}};
			RF[1] <= {WIDTH{1'b0}};
			RF[2] <= {WIDTH{1'b0}};
			RF[3] <= {WIDTH{1'b0}};
		end
		else begin
			if(LOAD) begin
				RF[WAA] <= {WIDTH{1'b0}};
				RF[WAB] <= {WIDTH{1'b0}};
		   end
			else begin
				if(WEA) RF[WAA] <= WDA;
				if(WEB) RF[WAB] <= WDB;
//				RDA <= RF[RAA];
//				RDB <= RF[RAB];
			end
			
		end
	end
	
    always @(*) begin
            if(!LOAD) begin
                RDA = RF[RAA];
                RDB = RF[RAB];
            end
    end
endmodule
