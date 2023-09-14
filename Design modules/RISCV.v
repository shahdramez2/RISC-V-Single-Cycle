module RISCV 
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
    input reset_n
  );

  /****************Signals Declaration****************************/
  
  //CPU signals
  wire [PC_WIDTH-1:0] PC_out_Imem;
  
  //Inst memory signals
  wire [INST_WIDTH-1:0] inst_wrapper;
  
  //DATA memory signals
  wire [DATA_WIDTH-1:0] DataR_wrapper;

  wire [DATA_WIDTH-1:0] DataW_Dmem;
  wire [DATA_WIDTH-1:0] addr_Dmem;
  wire                  MemRW_wrapper;
  /****************Instantiations****************************/
    
    CPU_wrapper #(
      .INST_WIDTH(INST_WIDTH),
      .IMMSEL_WIDTH(IMMSEL_WIDTH),
      .PC_WIDTH(PC_WIDTH),
      .DATA_WIDTH(DATA_WIDTH),
      .DATAMEM_ADDR_WIDTH(DATAMEM_ADDR_WIDTH),
      .ALUSEL_WIDTH(ALUSEL_WIDTH)
    ) inst_CPU_wrapper (
      .clk           (clk),
      .reset_n       (reset_n),
      .inst_wrapper  (inst_wrapper),
      .DataR_wrapper (DataR_wrapper),
      .DataW_Dmem    (DataW_Dmem),
      .addr_Dmem     (addr_Dmem),
      .MemRW_wrapper (MemRW_wrapper),
      .PC_out_Imem   (PC_out_Imem)
    );

    //Instruction memory instantiation
    IMEM #(.INSTR_WIDTH(INST_WIDTH), .PC_WIDTH(PC_WIDTH)) IMEM_inst(
      .PC(PC_out_Imem[31:2]),
      .instruction(inst_wrapper)
    );

    //Data memoy instantiation
    DMEM #(.WIDTH(DATA_WIDTH), .ADDRESS(DATAMEM_ADDR_WIDTH)) DMEM_inst (
      .clk(clk),
      .reset_n(reset_n),
      .MemRW(MemRW_wrapper),
      .Addr(addr_Dmem),
      .DataW(DataW_Dmem),
      .DataR(DataR_wrapper)
    );



endmodule 