module CPU_wrapper 
#(parameter INST_WIDTH = 32, 
            IMMSEL_WIDTH = 3, 
            PC_WIDTH = 32,
            DATA_WIDTH = 32, 
            DATAMEM_ADDR_WIDTH = 32,
            ALUSEL_WIDTH = 3
)
(
    input clk,
    input reset_n,

    /* The instruction is an input from the Imemory section */
    input [INST_WIDTH-1:0] inst_wrapper,
    /* The Mem_dat is an input from the Dmemory section */
    input [DATA_WIDTH-1:0] DataR_wrapper,

    /* Dmem ports */
    output [DATA_WIDTH-1:0] DataW_Dmem,
    output [DATAMEM_ADDR_WIDTH-1 : 0] addr_Dmem,
    output MemRW_wrapper,

    /* Imem ports*/
    output [PC_WIDTH-1:0] PC_out_Imem
);

/****************Signals Declaration****************************/
//control unit signals
wire PCSel_wrapper;
wire [IMMSEL_WIDTH -1 : 0 ] ImmSel_wrapper;
wire RegWEn_wrapper;
wire BrUn_wrapper;
wire BrEq_wrapper;
wire BrLT_wrapper;
wire BSel_wrapper;
wire [1:0] ASel_wrapper;
wire [1:0] WBSel_wrapper;

//ALU control unit signals
wire [2:0] ALUSel_wrapper;

/****************Instantiations****************************/

    control_unit_wrapper #(
      .INST_WIDTH(INST_WIDTH),
      .IMMSEL_WIDTH(IMMSEL_WIDTH),
      .PC_WIDTH(PC_WIDTH),
      .DATA_WIDTH(DATA_WIDTH),
      .DATAMEM_ADDR_WIDTH(DATAMEM_ADDR_WIDTH)
    ) inst_control_unit_wrapper (
      .inst_wrapper   (inst_wrapper),
      .BrEq_wrapper   (BrEq_wrapper),
      .BrLT_wrapper   (BrLT_wrapper),
      .PCSel_wrapper  (PCSel_wrapper),
      .ImmSel_wrapper (ImmSel_wrapper),
      .RegWEn_wrapper (RegWEn_wrapper),
      .BrUn_wrapper   (BrUn_wrapper),
      .BSel_wrapper   (BSel_wrapper),
      .ASel_wrapper   (ASel_wrapper),
      .MemRW_wrapper  (MemRW_wrapper),
      .WBSel_wrapper  (WBSel_wrapper),
      .ALUSel_wrapper (ALUSel_wrapper)
    );


    Datapath #(
      .INST_WIDTH(INST_WIDTH),
      .IMMSEL_WIDTH(IMMSEL_WIDTH),
      .PC_WIDTH(PC_WIDTH),
      .DATA_WIDTH(DATA_WIDTH),
      .DATAMEM_ADDR_WIDTH(DATAMEM_ADDR_WIDTH),
      .ALUSEL_WIDTH(ALUSEL_WIDTH)
    ) inst_Datapath (
      .clk            (clk),
      .reset_n        (reset_n),
      .PCSel_wrapper  (PCSel_wrapper),
      .ImmSel_wrapper (ImmSel_wrapper),
      .RegWEn_wrapper (RegWEn_wrapper),
      .BrUn_wrapper   (BrUn_wrapper),
      .BSel_wrapper   (BSel_wrapper),
      .ASel_wrapper   (ASel_wrapper),
      .WBSel_wrapper  (WBSel_wrapper),
      .ALUSel_wrapper (ALUSel_wrapper),
      .inst_wrapper   (inst_wrapper),
      .DataR_wrapper  (DataR_wrapper),
      .BrEq           (BrEq_wrapper),
      .BrLT           (BrLT_wrapper),
      .DataW_Dmem     (DataW_Dmem),
      .addr_Dmem      (addr_Dmem),
      .PC_out_Imem    (PC_out_Imem)
    );

endmodule 
