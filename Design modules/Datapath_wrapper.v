module Datapath  
  #(
  parameter INST_WIDTH = 32, 
            IMMSEL_WIDTH = 3, 
            PC_WIDTH = 32,
            DATA_WIDTH = 32, 
            DATAMEM_ADDR_WIDTH = 32,
            ALUSEL_WIDTH = 3
  ) 
  (
  input clk,
  input reset_n,

  // Control signals count --> 9 
  /* CU decoder related ports */
  input PCSel_wrapper,
  input [IMMSEL_WIDTH-1:0] ImmSel_wrapper,
  input RegWEn_wrapper,
  input BrUn_wrapper,
  input BSel_wrapper,
  input [1:0] ASel_wrapper,
  input [1:0] WBSel_wrapper,

  /* ALU CU decoder related ports */
  input [ALUSEL_WIDTH-1:0] ALUSel_wrapper,

  /* The instruction is an input from the Imemory section */
  input [INST_WIDTH-1:0] inst_wrapper,
  /* The Mem_dat is an input from the Dmemory section */
  input [DATA_WIDTH-1:0] DataR_wrapper,

  /* CU decoder related ports */
  output BrEq,
  output BrLT,

  // Memories related ports 
  /* Dmem ports */
  output [DATA_WIDTH-1:0] DataW_Dmem,
  output [DATAMEM_ADDR_WIDTH-1 : 0] addr_Dmem,
  /* Imem ports*/
  output [PC_WIDTH-1:0] PC_out_Imem
  );

  /******************************************* INTERNAL SIGNALS *****************************************/
  //imm gen signals
  wire [INST_WIDTH-1:0] ImmExtended_wrapper;

  //PC signals
  wire [PC_WIDTH-1:0] PC_in;
  wire [PC_WIDTH-1:0] PC_out;


  //reg file signals
  wire [INST_WIDTH-1: 0] write_back_wrapper;
  wire [DATA_WIDTH-1:0] DataA_wrapper, DataB_wrapper;

  //ALU control unit signals
  wire [DATA_WIDTH-1:0] ALUA_wrapper;
  wire [DATA_WIDTH-1:0] ALUB_wrapper;
  wire [DATA_WIDTH-1:0] ALUOUT_wrapper;
  
  //control unit signals
  wire BrEq_wrapper;
  wire BrLT_wrapper;

  /******************************************** Instantiations *******************************************/


  //PC instantiation
REG #(.REG_WIDTH(PC_WIDTH)) PC (
  .clk(clk),
  .reset_n(reset_n),
  .I(PC_in),
  .Q(PC_out)
  );



//reg_file instantiation
reg_file #(.ADDR_WIDTH(5), .REG_WIDTH(DATA_WIDTH)) reg_file_inst(
  .clk(clk),
  .reset_n(reset_n),
  .DataD(write_back_wrapper),
  .AddrD(inst_wrapper[11:7]),
  .AddrA(inst_wrapper[19:15]),
  .AddrB(inst_wrapper[24:20]),
  .DataA(DataA_wrapper),
  .RegWEn(RegWEn_wrapper),
  .DataB(DataB_wrapper)
  );


//BranchComp instantiation
BranchComp #(.REG_WIDTH(DATA_WIDTH)) branchcomp_inst(
  .R0(DataA_wrapper),
  .R1(DataB_wrapper),
  .BrEq(BrEq_wrapper),
  .BrLT(BrLT_wrapper)
  );




ALU #(.WIDTH(DATA_WIDTH)) ALU_inst(
  .ALUSel(ALUSel_wrapper),
  .ALUA(ALUA_wrapper),
  .ALUB(ALUB_wrapper),
  .ALUOut(ALUOUT_wrapper)
  ); 


Mux_2_1 #(.WIDTH(DATA_WIDTH)) PC_mux(
  .in_0(PC_out+4),
  .in_1(ALUOUT_wrapper),
  .sel (PCSel_wrapper),
  .out(PC_in)
  );

Mux_3_1 #(.WIDTH(DATA_WIDTH)) ALUA_mux (
  .in_0(DataA_wrapper),
  .in_1(PC_out),
  .in_2(0),
  .sel(ASel_wrapper),
  .out(ALUA_wrapper)
  );

Mux_2_1 #(.WIDTH(DATA_WIDTH)) ALUB_mux (
  .in_0(DataB_wrapper),
  .in_1(ImmExtended_wrapper),
  .sel(BSel_wrapper),
  .out(ALUB_wrapper)
  );


Mux_3_1 #(.WIDTH(DATA_WIDTH)) DataD_mux (
  .in_0(DataR_wrapper),
  .in_1(ALUOUT_wrapper),
  .in_2(PC_out+4),
  .sel(WBSel_wrapper),
  .out(write_back_wrapper)
  );


Imm_Gen #(.IMMSEL_WIDTH(IMMSEL_WIDTH), .WIDTH(INST_WIDTH))  ImmGen_inst(
  .ImmSel(ImmSel_wrapper),
  .IMMInstruction(inst_wrapper[INST_WIDTH-1:7]),
  .ImmExtended(ImmExtended_wrapper)
  );

  assign BrEq = BrEq_wrapper;
  assign BrLT = BrLT_wrapper;
  assign DataW_Dmem = DataB_wrapper;
  assign addr_Dmem = ALUOUT_wrapper;
  assign PC_out_Imem = PC_out;

endmodule : Datapath