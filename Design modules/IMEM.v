module IMEM 
#(parameter INSTR_WIDTH = 32,
			PC_WIDTH = 32)
(
	input      [PC_WIDTH-3:0]    PC,
	output reg [INSTR_WIDTH-1:0] instruction
	);

//memory declaration
reg [INSTR_WIDTH-1:0] IMEM [0:1023]; 

initial begin
    $readmemh("riscvtest.mem", IMEM);
end

always@(PC) begin
    instruction = IMEM[PC];
end

endmodule