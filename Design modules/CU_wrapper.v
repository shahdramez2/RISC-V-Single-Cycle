module control_unit_wrapper #(
  parameter INST_WIDTH = 32, 
            IMMSEL_WIDTH = 3, 
            PC_WIDTH = 32,
            DATA_WIDTH = 32, 
            DATAMEM_ADDR_WIDTH = 32
  ) 
  (
  /* The instruction */
  input [INST_WIDTH-1:0] inst_wrapper,

  /* Opcode decoder ports */
  input BrEq_wrapper,
  input BrLT_wrapper,
  output PCSel_wrapper,
  output [IMMSEL_WIDTH-1:0] ImmSel_wrapper,
  output RegWEn_wrapper,
  output BrUn_wrapper,
  output BSel_wrapper,
  output [1:0] ASel_wrapper,
  output MemRW_wrapper,
  output [1:0] WBSel_wrapper,

  /* ALU decoder port */
  output [2:0] ALUSel_wrapper
  );
  /****************Signals Declaration****************************/
  
  // The only internal signal shared between the two modules  
  wire [2:0] ALUOp_wrapper;
   

  //main control unit instantiation
  main_control_unit #(.INST_WIDTH(INST_WIDTH), .IMMSEL_WIDTH(IMMSEL_WIDTH)) main_control_unit_inst(
    .inst(inst_wrapper),
    .BrEq(BrEq_wrapper),
    .BrLT(BrLT_wrapper),
    .PCSel(PCSel_wrapper),
    .ImmSel(ImmSel_wrapper),
    .RegWEn(RegWEn_wrapper),
    .BSel(BSel_wrapper),
    .ASel(ASel_wrapper),
    .MemRW(MemRW_wrapper),
    .ALUOp(ALUOp_wrapper),
    .WBSel(WBSel_wrapper)
  );
  
  //ALU control unit instantiation
  ALU_control_unit #(.ALUSEL_WIDTH(3)) ALU_control_unit_inst (
    .ALUOp(ALUOp_wrapper),
    .func7_bit5(inst_wrapper[30]),
    .opcode_bit5(inst_wrapper[5]),
    .func3(inst_wrapper[14:12]),
    .ALUSel(ALUSel_wrapper)
  );

endmodule : control_unit_wrapper