module top_module (
    input  clk,
    input  x,
    output z
);
  wire xor_out, and_out, or_out;
  reg q1, q2, q3;

  assign xor_out = q1 ^ x;
  assign and_out = ~q2 & x;
  assign or_out  = ~q3 | x;

  always @(posedge clk) begin
    q1 <= xor_out;
    q2 <= and_out;
    q3 <= or_out;
  end

  assign z = ~(q1 | q2 | q3);

endmodule
