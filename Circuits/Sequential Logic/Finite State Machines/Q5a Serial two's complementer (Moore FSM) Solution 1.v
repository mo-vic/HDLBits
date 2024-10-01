module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

  reg c;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      c <= 1'b1;
      z <= 1'b0;
    end else begin
      c <= ~x & c;
      z <= c ^ ~x;
    end
  end

endmodule
