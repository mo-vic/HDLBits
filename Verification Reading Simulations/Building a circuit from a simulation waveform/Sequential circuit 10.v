module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state
);

  wire next_state;

  assign next_state = a & b | b & state | a & state;

  always @(posedge clk) begin
    state <= next_state;
  end

  assign q = ~a & b & ~state | a & ~b & ~state | ~a & ~b & state | a & b & state;

endmodule
