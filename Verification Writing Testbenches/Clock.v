module top_module ();

  reg clk;
  initial begin
    clk <= 1'b0;
  end

  dut inst (clk);

  always @(*) begin
    #5 clk <= ~clk;
  end

endmodule
