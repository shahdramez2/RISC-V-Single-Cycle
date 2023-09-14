module ALU_control_unit
#(parameter ALUSEL_WIDTH = 3)
(
	input [2:0]ALUOp,
	input func7_bit5,
	input opcode_bit5,
	input [2:0] func3,
	output reg [ALUSEL_WIDTH-1:0] ALUSel
	);

/****************ALUOp Values ******************/
localparam RI_type_ALUOp  = 0,
		   JALR_ALUOp     = 1,
		   S_type_ALUOp   = 2,
		   SB_type_ALUOp  = 3,
		   U_type_ALUOp   = 4,
		   UJ_type_ALUOp  = 5;

localparam ADD = 0,
		   SUB = 1,
		   SLL = 2,
		   XOR = 3,
		   SRL = 4,
		   SRA = 5,
		   OR  = 6,
		   AND = 7;

always@(*) begin

    ALUSel = 3'b0;
    
	case(ALUOp)
	
	RI_type_ALUOp:
		case(func3)
		3'b000: 
			if(~opcode_bit5) 
				ALUSel = ADD;
			else if(func7_bit5)
				ALUSel = SUB;
			else 
				ALUSel = ADD;

		3'b001: ALUSel = SLL;
		3'b010: ALUSel = ADD;  //load
		3'b100: ALUSel = XOR;
		3'b101: if(func7_bit5)
					ALUSel = SRA;
				else 
					ALUSel = SRL;
		3'b110: ALUSel = OR;
		3'b111: ALUSel = AND;
        default: ALUSel = 3'b0;
		endcase
		
	JALR_ALUOp:    ALUSel = ADD;
	S_type_ALUOp:  ALUSel = ADD;
	SB_type_ALUOp: ALUSel = ADD;
	U_type_ALUOp:  ALUSel = ADD; 
	UJ_type_ALUOp: ALUSel = ADD;
	default: ALUSel = 3'b0;
	endcase
end
endmodule