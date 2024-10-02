module top_module (
    input clk,
    input resetn,  // active-low synchronous reset
    input [3:1] r,  // request
    output [3:1] g  // grant
);

  parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

  reg [1:0] state, next_state;

  always @(*) begin
    case (state)
      A: next_state = r[1] ? B : r[2] ? C : r[3] ? D : A;
      B: next_state = r[1] ? B : A;
      C: next_state = r[2] ? C : A;
      D: next_state = r[3] ? D : A;
    endcase
  end

  always @(posedge clk) begin
    if (resetn) state <= next_state;
    else state <= A;
  end

  assign g = {~|(state ^ D), ~|(state ^ C), ~|(state ^ B)};

endmodule
