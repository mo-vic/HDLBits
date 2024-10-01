module A (
    input  x,
    input  y,
    output z
);

  assign z = (x ^ y) & x;

endmodule

module B (
    input  x,
    input  y,
    output z
);

  assign z = ~(x ^ y);

endmodule

module top_module (
    input  x,
    input  y,
    output z
);
  wire IA1_out, IA2_out, IB1_out, IB2_out;
  wire or_out, and_out;

  A
      IA1 (
          .x(x),
          .y(y),
          .z(IA1_out)
      ),
      IA2 (
          .x(x),
          .y(y),
          .z(IA2_out)
      );
  B
      IB1 (
          .x(x),
          .y(y),
          .z(IB1_out)
      ),
      IB2 (
          .x(x),
          .y(y),
          .z(IB2_out)
      );

  assign or_out = IA1_out | IB1_out;
  assign and_out = IA2_out & IB2_out;

  assign z = or_out ^ and_out;

endmodule
