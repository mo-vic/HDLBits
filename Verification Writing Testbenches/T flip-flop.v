module top_module ();
  reg clk, reset, t;
  wire q;

  tff inst (
      clk,
      reset,
      t,
      q
  );

  initial begin
    clk <= 1'b0;
    reset <= 1'b0;
    t <= 1'b0;

    #10 reset <= 1'b1;
    #10 reset <= 1'b0;
    #5 t <= 1'b1;
  end

  always @(*) begin
    #5 clk <= ~clk;
  end

endmodule
