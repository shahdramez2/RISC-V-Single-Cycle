module Mux_2_1 #(parameter WIDTH = 32)
  (
    input [WIDTH - 1 : 0] in_0,
    input [WIDTH - 1 : 0] in_1,
    input sel,

    output [WIDTH - 1 : 0] out
  );

  assign out = ( sel == 0) ? in_0 : in_1; 

endmodule : Mux_2_1