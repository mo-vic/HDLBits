module top_module (
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out
);  //

  // State transition logic: next_state = f(state, in)
  assign next_state[1] = (~in & state[0]) | (in & state[1] & ~state[0]);
  assign next_state[0] = in;

  // Output logic:  out = f(state) for a Moore state machine
  assign out = &state;

endmodule
