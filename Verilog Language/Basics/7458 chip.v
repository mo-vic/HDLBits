module top_module (
    input  p1a,
    p1b,
    p1c,
    p1d,
    p1e,
    p1f,
    output p1y,
    input  p2a,
    p2b,
    p2c,
    p2d,
    output p2y
);

  wire and1_out, and2_out, and3_out, and4_out;

  assign and1_out = p1a & p1b & p1c;
  assign and2_out = p1d & p1e & p1f;
  assign p1y = and1_out | and2_out;

  assign and3_out = p2a & p2b;
  assign and4_out = p2c & p2d;
  assign p2y = and3_out | and4_out;

endmodule
