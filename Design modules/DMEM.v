module DMEM #( parameter WIDTH = 32, ADDRESS = 10 )
  (
  input clk,
  input MemRW,
  input reset_n,

  input [ADDRESS - 1 : 0] Addr ,
  input [WIDTH - 1 : 0] DataW,
  output [ WIDTH - 1 : 0] DataR   
  );

  localparam READ = 0;
  localparam WRITE = 1;

  reg [WIDTH - 1 : 0] dmem [0: 1023];

  integer i;
  
  always@(posedge clk, negedge reset_n) begin
    if(~reset_n) begin

      for(i=0; i < 1024; i=i+1) begin
        dmem[i] <= 'b0;
      end

    end 
    else begin

       if(MemRW == WRITE)
      dmem[Addr] <= DataW; 

    end
  end

  assign DataR = (MemRW == READ) ? dmem[Addr] : 0;
endmodule 