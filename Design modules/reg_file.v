module reg_file
#(parameter ADDR_WIDTH = 32,
			REG_WIDTH = 32)
(
	input clk, reset_n,
	input RegWEn,
	input      [REG_WIDTH-1:0]  DataD,
	input      [ADDR_WIDTH-1:0] AddrD,
	input 	   [ADDR_WIDTH-1:0] AddrA,
	input 	   [ADDR_WIDTH-1:0] AddrB,
	output 	   [REG_WIDTH-1:0]  DataA,
	output 	   [REG_WIDTH-1:0]  DataB
	); 


reg [REG_WIDTH-1:0] reg_file [0:2**ADDR_WIDTH-1];


integer i;

/****************synchronous write ******************/
always@(posedge clk, negedge reset_n) begin
	if(~reset_n) 
		for(i=0; i< 2**ADDR_WIDTH; i=i+1)
			reg_file[i] <= 0;
	else if (RegWEn) begin
		if(AddrD != 0)
			reg_file[AddrD] <= DataD;	 
		else 
			reg_file[AddrD] <= reg_file[AddrD];
	end
	
end

/****************asynchronous read ******************/
assign DataA = reg_file[AddrA];
assign DataB = reg_file[AddrB];
endmodule