module REG 
#(parameter REG_WIDTH = 32)
(
	input clk, reset_n,
	input [REG_WIDTH-1:0] I,
	output reg [REG_WIDTH-1:0] Q
	);

always@(posedge clk, negedge reset_n) begin
	if(~reset_n) 
		Q <= 0;
	else 
		Q<= I;
end
endmodule