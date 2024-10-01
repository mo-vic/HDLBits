module top_module (
    input clk,
    input areset,  // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

  parameter LEFT = 3'b000, RIGHT = 3'b001, LFALL = 3'b010, RFALL = 3'b011, LDIG = 3'b100, RDIG = 3'b101;

  reg [2:0] state, next_state;

  always @(*) begin
    case (state)
      LEFT: next_state = ground ? dig ? LDIG : (bump_left ? RIGHT : LEFT) : LFALL;
      RIGHT: next_state = ground ? dig ? RDIG : (bump_right ? LEFT : RIGHT) : RFALL;
      LFALL: next_state = ground ? LEFT : LFALL;
      RFALL: next_state = ground ? RIGHT : RFALL;
      LDIG: next_state = ground ? LDIG : LFALL;
      RDIG: next_state = ground ? RDIG : RFALL;
      default: next_state = state;
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
        digging = 1'b0;
      end
      RIGHT: begin
        walk_left = 1'b0;
        walk_right = 1'b1;
        aaah = 1'b0;
        digging = 1'b0;
      end
      LFALL: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b1;
        digging = 1'b0;
      end
      RFALL: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b1;
        digging = 1'b0;
      end
      LDIG: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b1;
      end
      RDIG: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b1;
      end
      default: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
      end
    endcase
  end

endmodule
