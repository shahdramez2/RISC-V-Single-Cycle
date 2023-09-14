module BranchComp 
#(parameter REG_WIDTH = 32)
(
	input signed [REG_WIDTH-1:0] R0,
	input signed [REG_WIDTH-1:0] R1,
	output reg BrEq,
	output reg BrLT
);


always@(*) begin
    //default values 
	BrEq = 1'b0;
	BrLT = 1'b0;

	if(R0 == R1) 
		BrEq = 1'b1;
	
	if(R0 < R1)
		BrLT = 1'b1;
end
endmodule

