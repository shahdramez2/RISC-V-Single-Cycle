module ALU #(parameter WIDTH = 32) 
  (
    input [2 : 0] ALUSel,

    input signed [WIDTH - 1 : 0] ALUA,
    input signed [WIDTH - 1 : 0] ALUB,

    output reg signed [WIDTH - 1 : 0] ALUOut
  );

  localparam ADD = 3'b000, SUB = 3'b001, SLL = 3'b010, XOR = 3'b011, SRL = 3'b100, SRA = 3'b101, OR = 3'b110, AND = 3'b111;

  always@(*) begin
    case (ALUSel)
      ADD : ALUOut = ALUA + ALUB;
      SUB : ALUOut = ALUA - ALUB;
      SLL : ALUOut = ALUA << ALUB;
      XOR : ALUOut = ALUA ^ ALUB;
      SRL : ALUOut = ALUA >> ALUB;
      SRA : ALUOut = ALUA >>> ALUB;
      OR : ALUOut = ALUA | ALUB;
      AND : ALUOut = ALUA & ALUB;
      default : ALUOut = 0;
    endcase
  end

endmodule : ALU