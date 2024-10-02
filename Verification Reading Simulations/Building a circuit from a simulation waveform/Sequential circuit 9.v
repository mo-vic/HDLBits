module top_module (
    input clk,
    input a,
    output [3:0] q
);

  always @(posedge clk) begin
    if (a) q <= 4'h4;
    else q <= |(q ^ 4'h6) ? q + 1 : 4'h0;
  end

endmodule
