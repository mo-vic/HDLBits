module top_module (
    input clk,
    input reset,
    output reg [3:0] q
);

  always @(posedge clk) begin
    q <= reset ? 4'h1 : ((q[3] & ~q[2] & q[1] & ~q[0]) ? 4'h1 : q + 4'b0001);
  end

endmodule
