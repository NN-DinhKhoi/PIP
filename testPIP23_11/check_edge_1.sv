module check_edge #(WIDTH = 16, POINTS = 4)(
    input wire [WIDTH-1:0] point_x, point_y,
	 input wire [WIDTH-1:0] x_in[0:POINTS-1], 
	 input wire [WIDTH-1:0] y_in[0:POINTS-1],
	 input wire [WIDTH-1:0] ADDR,
	 input wire en,
    output reg [WIDTH-1:0] result
);
	 localparam int scale = 100;
    reg signed [2*WIDTH-1:0] x_intersection;
    always @(*) begin
	 result = 0;
	 if(en) begin
		  if(ADDR == POINTS -1)begin
		      if (y_in[ADDR] != y_in[0]) begin
            if ((point_y >= (y_in[ADDR] < y_in[0] ? y_in[ADDR] : y_in[0])) &&
                (point_y < (y_in[ADDR] > y_in[0] ? y_in[ADDR] : y_in[0]))) begin
                x_intersection = (x_in[ADDR] * scale) +
                        ((point_y - y_in[ADDR]) * scale * (x_in[0] - x_in[ADDR])) / 
                        (y_in[0] - y_in[ADDR]);

                if (x_intersection >= point_x * scale) begin
                    result = 1;
                end
            end
				end
		  end
        else begin
				if (y_in[ADDR] != y_in[ADDR+1]) begin
            if ((point_y >= (y_in[ADDR] < y_in[ADDR+1] ? y_in[ADDR] : y_in[ADDR+1])) &&
                (point_y < (y_in[ADDR] > y_in[ADDR+1] ? y_in[ADDR] : y_in[ADDR+1]))) begin
                x_intersection = (x_in[ADDR] * scale) +
                        ((point_y - y_in[ADDR]) * scale * (x_in[ADDR+1] - x_in[ADDR])) / 
                        (y_in[ADDR+1] - y_in[ADDR]);

                if (x_intersection >= point_x * scale) begin
                    result = 1;
                end
            end
				end
		  end
    end
	 end
endmodule
