module top_module (
    input clk,
    input areset,  // active high asynchronous reset
    input [7:0] d,
    output reg [7:0] q
);

  always @(posedge clk or posedge areset) begin
    q <= areset ? 8'h00 : d;
  end

endmodule
