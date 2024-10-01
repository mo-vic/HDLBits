module top_module (
    input clk,
    input areset,  // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

  parameter LEFT = 2'b00, RIGHT = 2'b01, LFALL = 2'b10, RFALL = 2'b11;

  reg [1:0] state, next_state;

  always @(*) begin
    case (state)
      LEFT:  next_state = ground ? bump_left ? RIGHT : LEFT : LFALL;
      RIGHT: next_state = ground ? bump_right ? LEFT : RIGHT : RFALL;
      LFALL: next_state = ground ? LEFT : LFALL;
      RFALL: next_state = ground ? RIGHT : RFALL;
    endcase
  end

  always @(posedge clk or posedge areset) begin
    if (areset) state <= LEFT;
    else state <= next_state;
  end

  always @(*) begin
    case (state)
      LEFT: begin
        walk_left = 1'b1;
        walk_right = 1'b0;
        aaah = 1'b0;
      end
      RIGHT: begin
        walk_left = 1'b0;
        walk_right = 1'b1;
        aaah = 1'b0;
      end
      LFALL: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b1;
      end
      RFALL: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b1;
      end
    endcase
  end

endmodule
