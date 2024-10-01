module top_module (
    input clk,
    input areset,  // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);  //  

  parameter LEFT = 1'b0, RIGHT = 1'b1;
  reg state, next_state;

  always @(*) begin
    // State transition logic
    next_state <= ~state & bump_left | bump_left & ~bump_right | state & ~bump_right;
  end

  always @(posedge clk, posedge areset) begin
    // State flip-flops with asynchronous reset
    if (areset) state <= LEFT;
    else state <= next_state;
  end

  // Output logic
  // assign walk_left = (state == ...);
  // assign walk_right = (state == ...);
  assign walk_left  = ~state;
  assign walk_right = state;

endmodule
