module top_module (
    input  clk,
    input  in,
    input  reset,
    output out
);  //

  reg  [1:0] state;
  wire [1:0] next_state;

  // State transition logic
  assign next_state[1] = (~in & state[0]) | (in & state[1] & ~state[0]);
  assign next_state[0] = in;

  // State flip-flops with synchronous reset
  always @(posedge clk) begin
    if (reset) state <= 2'b00;
    else state <= next_state;
  end

  // Output logic
  assign out = &state;

endmodule
