module top_module (
    input  clk,
    input  reset,  // Synchronous reset to OFF
    input  j,
    input  k,
    output out
);  //  

  parameter OFF = 1'b0, ON = 1'b1;
  reg state, next_state;

  always @(*) begin
    // State transition logic
    next_state = (j & ~state) | (j & ~k) | (~k & state);
  end

  always @(posedge clk) begin
    // State flip-flops with synchronous reset
    if (reset) state <= OFF;
    else state = next_state;
  end

  // Output logic
  // assign out = (state == ...);
  assign out = state;

endmodule
