`default_nettype none
module top_module (
    input  a,
    input  b,
    input  c,
    input  d,
    output out,
    output out_n
);

  wire or_in1, or_in2;

  assign or_in1 = a & b;
  assign or_in2 = c & d;
  assign out = or_in1 | or_in2;
  assign out_n = ~out;

endmodule
