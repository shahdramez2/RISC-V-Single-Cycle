module Imm_Gen #( parameter WIDTH = 32, IMMSEL_WIDTH = 4)  
  (
  input [IMMSEL_WIDTH-1:0] ImmSel,

  input [(WIDTH - 7) - 1 : 0] IMMInstruction,  // width = 25
  output reg [WIDTH - 1 : 0] ImmExtended  // width = 32
  );

  /*****ImmSel Output Values *******/
  localparam R_type  = 3'b000,
             I_type  = 3'b001,
             JALR    = 3'b010,
             S_type  = 3'b011,
             B_type  = 3'b100,
             U_type  = 3'b101,
             J_type  = 3'b110;

  always@(*) begin
    case (ImmSel)
      R_type        : ImmExtended = {WIDTH{1'b0}};
      I_type, JALR  : ImmExtended = {{(WIDTH - 12){IMMInstruction[24]}}, IMMInstruction[24 : 13]};
      S_type        : ImmExtended = {{(WIDTH - 12){IMMInstruction[24]}}, IMMInstruction[24 : 18], IMMInstruction[4 : 0]};
      B_type        : ImmExtended = {{(WIDTH - 12){IMMInstruction[24]}}, IMMInstruction[24], IMMInstruction[0], IMMInstruction[23 : 18], IMMInstruction[4 : 1], 1'b0};
      U_type        : ImmExtended = {IMMInstruction[24 : 5], {(WIDTH - 20){1'b0}}};
      J_type        : ImmExtended = {{(WIDTH - 21){IMMInstruction[24]}}, IMMInstruction[24], IMMInstruction[12 : 5], IMMInstruction[13], IMMInstruction[23 : 14], 1'b0};
      default       : ImmExtended = {WIDTH{1'b0}};
    endcase
  end

endmodule : Imm_Gen