module top_module (
    input  clk,
    input  d,
    output q
);

  wire i1_out, i2_out;
  my_dff instance1 (
      .clk(clk),
      .d  (d),
      .q  (i1_out)
  );
  my_dff instance2 (
      .clk(clk),
      .d  (i1_out),
      .q  (i2_out)
  );
  my_dff instance3 (
      .clk(clk),
      .d  (i2_out),
      .q  (q)
  );

endmodule
