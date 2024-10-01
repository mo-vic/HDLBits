module top_module (
    input clk,
    input d,
    input ar,  // asynchronous reset
    output reg q
);

  always @(posedge clk or posedge ar) begin
    q <= ar ? 1'b0 : d;
  end

endmodule
