module top_module (
    input  clk,
    input  reset,  // Synchronous reset
    input  in,
    output disc,
    output flag,
    output err
);

  parameter NONE = 4'h0, ONE = 4'h1, TWO = 4'h2, THREE = 4'h3, FOUR = 4'h4, 
              FIVE = 4'h5, SIX = 4'h6, DISC = 4'h8, FLAG = 4'h9, ERROR = 4'ha;

  reg [3:0] state, next_state;

  always @(*) begin
    case (state)
      NONE: next_state = in ? ONE : NONE;
      ONE: next_state = in ? TWO : NONE;
      TWO: next_state = in ? THREE : NONE;
      THREE: next_state = in ? FOUR : NONE;
      FOUR: next_state = in ? FIVE : NONE;
      FIVE: next_state = in ? SIX : DISC;
      SIX: next_state = in ? ERROR : FLAG;
      DISC: next_state = in ? ONE : NONE;
      FLAG: next_state = in ? ONE : NONE;
      ERROR: next_state = in ? ERROR : NONE;
      default: next_state = state;
    endcase
  end

  always @(posedge clk) begin
    if (reset) state <= NONE;
    else state <= next_state;
  end

  assign disc = ~|(state ^ DISC);
  assign flag = ~|(state ^ FLAG);
  assign err  = ~|(state ^ ERROR);

endmodule
