`timescale 1ns / 1ps
module check_edge #(WIDTH = 16, POINTS = 5)(
     input clk,
     input rstN,
     input wire [WIDTH-1:0] point_x, point_y,
	 input wire [WIDTH-1:0] x_in,
	 input wire [WIDTH-1:0] y_in,
	 input wire [WIDTH-1:0] ADDR,
	 input wire load_en,
	 input wire en,
     output reg [WIDTH-1:0] result,
	 output reg overlap,
	 output reg load_done

);
	 localparam int scale = 100;
    reg signed [2*WIDTH-1:0] x_intersection;
    reg [WIDTH-1:0] x_temp [0:POINTS-1];
    reg [WIDTH-1:0] y_temp [0:POINTS-1];
	reg over = 0;
	assign overlap = over;
//	always @ (*) begin
//	   load_points = 1;
//	end
	reg [POINTS-1:0] load_points;
	always @(posedge clk or negedge rstN )begin
	   if(~rstN) begin
	       load_points <=0 ;
	       load_done <=0;
	   end
	   if(load_en) begin
	       x_temp[load_points] <= x_in;
	       y_temp[load_points] <= y_in;
	       if(load_points == POINTS - 1) load_done <= 1;
	       load_points <= load_points + 1; 
	   end
	end
	
    always @(*) begin
	 result = 0;
        if(en) begin
            if(ADDR == POINTS -1)begin
                if (y_temp[ADDR] != y_temp[0]) begin
                    if ((point_y >= (y_temp[ADDR] < y_temp[0] ? y_temp[ADDR] : y_temp[0])) &&
                        (point_y < (y_temp[ADDR] > y_temp[0] ? y_temp[ADDR] : y_temp[0]))) begin           
                         if ( ((point_y == y_temp[ADDR]) && (point_x == x_temp[ADDR])) || ((point_y == y_temp[0]) && (point_x == x_temp[0])) )begin
                             over = 1;
                         end
                         
                        x_intersection = (x_temp[ADDR] * scale) +
                            ((point_y - y_temp[ADDR]) * scale * (x_temp[0] - x_temp[ADDR])) / 
                            (y_temp[0] - y_temp[ADDR]);
    
                        if (x_intersection > point_x * scale)
                            result = 1;
                        if (x_intersection == point_x * scale)
                            over = 1;
                    end
                end
            end
            else begin
                if (y_temp[ADDR] != y_temp[ADDR+1]) begin
                    if ((point_y >= (y_temp[ADDR] < y_temp[ADDR+1] ? y_temp[ADDR] : y_temp[ADDR+1])) &&
                            (point_y < (y_temp[ADDR] > y_temp[ADDR+1] ? y_temp[ADDR] : y_temp[ADDR+1]))) begin
                         
                         if ( ((point_y == y_temp[ADDR]) && (point_x == x_temp[ADDR])) || ((point_y == y_temp[ADDR+1]) && (point_x == x_temp[ADDR+1])) )begin
                             over = 1;
                         end
                         
                        x_intersection = (x_temp[ADDR] * scale) +
                        ((point_y - y_temp[ADDR]) * scale * (x_temp[ADDR+1] - x_temp[ADDR])) / 
                        (y_temp[ADDR+1] - y_temp[ADDR]);
    
                        if (x_intersection > point_x * scale)
                            result = 1;
                        if (x_intersection == point_x * scale)
                            over = 1;
                    end
                end
            end
       end
	end
endmodule
