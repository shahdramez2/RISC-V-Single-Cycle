module Mux_3_1 #(parameter WIDTH = 32)
  (
    input [WIDTH - 1 : 0] in_0,
    input [WIDTH - 1 : 0] in_1,
    input [WIDTH - 1 : 0] in_2,
    input [1:0] sel,

    output reg [WIDTH - 1 : 0] out
  );


 always@(*) begin
    case(sel) 
    0: out = in_0;
    1: out = in_1;
    2: out = in_2;
    default: out = {WIDTH{1'b0}};
    endcase
 end

endmodule : Mux_3_1