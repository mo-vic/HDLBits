module top_module (
    input  a,
    input  b,
    input  c,
    output out
);  //

  wire nout;
  andgate inst1 (
      nout,
      a,
      b,
      c,
      1'b1,
      1'b1
  );
  assign out = ~nout;

endmodule
