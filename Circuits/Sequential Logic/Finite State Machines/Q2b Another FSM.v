module top_module (
    input  clk,
    input  resetn,  // active-low synchronous reset
    input  x,
    input  y,
    output f,
    output g
);

  // FSM states for f
  parameter A = 4'h0, B = 4'h1;
  // FSM states for monitoring x
  parameter C = 4'h2, D = 4'h3, E = 4'h4, F = 4'h5;
  // FSM states for monitoring y
  parameter G = 4'h6, H = 4'h7, I = 4'h8;

  reg [3:0] state, next_state;

  always @(*) begin
    case (state)
      A: next_state = B;
      B: next_state = C;
      C: next_state = x ? D : C;
      D: next_state = x ? D : E;
      E: next_state = x ? F : C;
      F: next_state = y ? G : H;
      G: next_state = G;
      H: next_state = y ? G : I;
      I: next_state = I;
      default: next_state = state;
    endcase
  end

  always @(posedge clk) begin
    if (resetn) state <= next_state;
    else state <= A;
  end

  assign f = ~|(state ^ B);
  assign g = ~|(state ^ F) | ~|(state ^ G) | ~|(state ^ H);

endmodule
