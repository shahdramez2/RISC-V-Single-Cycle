module main_control_unit 
#(parameter INST_WIDTH = 32, 
			IMMSEL_WIDTH = 3)


(input [INST_WIDTH-1:0] inst,
 input BrEq,
 input BrLT,
 output reg PCSel,
 output reg [IMMSEL_WIDTH-1:0] ImmSel,
 output reg RegWEn,
 output reg BSel,
 output reg [1:0] ASel,
 output reg MemRW,
 output reg [2:0] ALUOp,
 output reg [1:0] WBSel
 );

/****************Instruction Formats Encoding******************/
localparam R_type  = 7'h33,
		   I_type  = 7'h13,
		   LOAD    = 7'h03,
		   S_type  = 7'h23,
		   JALR    = 7'h67,
		   SB_type = 7'h63,
		   U_type  = 7'h37,
		   UJ_type = 7'h6F;

/****************ALUOp output Values ******************/
localparam RI_type_ALUOp  = 0,
		   JALR_ALUOp     = 1,
		   S_type_ALUOp   = 2,
		   SB_type_ALUOp  = 3,
		   U_type_ALUOp   = 4,
		   UJ_type_ALUOp  = 5;

/****************ImmSel Output Values ******************/
localparam  R_type_ImmSel  = 3'b000,
		    I_type_ImmSel  = 3'b001,
		    JALR_ImmSel    = 3'b010,
	    	S_type_ImmSel  = 3'b011,
		    SB_type_ImmSel = 3'b100,
		    U_type_ImmSel  = 3'b101,
	        UJ_type_ImmSel = 3'b110;


/****************Memory Control Signal******************/
localparam DMEM_READ  = 0,
		   DMEM_WRITE = 1;

/****************SB_type Instruction Encoding************/
localparam BEQ = 3'b000 ,
		   BNE = 3'b001,
		   BLT = 3'b100,
		   BGT = 3'b101;

always@(*) begin
	
	PCSel  = 1'b0;
	ImmSel = 0;
	RegWEn = 1'b1;
	BSel   = 1'b0;
	ASel   = 2'b00;
	MemRW  = 1'b0;
	ALUOp  = 0;
	WBSel  = 0;

	case(inst[6:0])

	R_type: begin
		PCSel = 1'b0;
		ImmSel = R_type_ImmSel;
		RegWEn = 1'b1;
		BSel = 1'b0;
		ASel = 2'b00;
		MemRW = 1'b0;
		ALUOp = RI_type_ALUOp;
		WBSel = 1;

	end
	I_type: begin
		PCSel = 1'b0;
		ImmSel = I_type_ImmSel;
		RegWEn = 1'b1;
		BSel = 1'b1;
		ASel = 2'b00;
		ALUOp = RI_type_ALUOp;
		MemRW = DMEM_READ;
		WBSel = 1;
	end

	LOAD: begin
	    PCSel = 1'b0;
		ImmSel = I_type_ImmSel;
		RegWEn = 1'b1;
		BSel = 1'b1;
		ASel = 2'b00;
		ALUOp = RI_type_ALUOp;
		MemRW = DMEM_READ;
		WBSel = 0;	
	end
	
	JALR: begin
		PCSel = 1'b1;
		ImmSel = JALR_ImmSel;
		RegWEn = 1'b1;
		BSel = 1'b1;
		ASel = 2'b00;
		ALUOp = JALR_ALUOp;
		MemRW = DMEM_READ;
		WBSel = 2;
	end

	S_type: begin
		PCSel = 1'b0;
		ImmSel = S_type_ImmSel;
		RegWEn = 1'b0;
		BSel = 1'b1;
		ASel = 2'b00;
		ALUOp = S_type_ALUOp;
		MemRW = DMEM_WRITE;
		WBSel = 0;
	end

	SB_type: begin
		ImmSel = SB_type_ImmSel;
		RegWEn = 1'b0;
		BSel = 1'b1;
		ASel = 2'b01;
		ALUOp = SB_type_ALUOp;
		MemRW = 1'b0;
		WBSel = 0;

		case(inst[14:12])
        BEQ:
        	if(BrEq)
        		PCSel = 1'b1;
        	else 
        		PCSel = 1'b0;
        BNE: 
        	if(~BrEq)
        		PCSel = 1'b1;
        	else 
        		PCSel = 1'b0;
        BLT:
        	if(BrLT)
        		PCSel = 1'b1;
        	else 
        		PCSel = 1'b0;
        BGT:
        	if(~BrEq & ~BrLT)
        		PCSel = 1'b1;
        	else 
        		PCSel = 1'b0;
        default: PCSel = 1'b0;
		endcase
	end

	U_type: begin
		PCSel = 1'b0;
		ImmSel = U_type_ImmSel;
		RegWEn = 1'b1;
		BSel = 1'b1;
		ASel = 2'b10;
		ALUOp = U_type_ALUOp;
		MemRW = 1'b0;
		WBSel = 1;
	end

	UJ_type: begin
		PCSel = 1'b1;
		ImmSel = UJ_type_ImmSel;
		RegWEn = 1'b1;
		BSel = 1'b1;
		ASel = 2'b01;
		ALUOp = UJ_type_ALUOp;
		MemRW = 1'b0;
		WBSel = 2;
	end
    
    default: begin
    	PCSel = 1'b0;
    	ImmSel = 0;
    	RegWEn = 1'b0;
    	BSel = 1'b0;
    	ASel = 2'b00;
    	ALUOp = 0;
    	MemRW = DMEM_READ;
    	WBSel = 0; 
    end
	endcase
end
endmodule
