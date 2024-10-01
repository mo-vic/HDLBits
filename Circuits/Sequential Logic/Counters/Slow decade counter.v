module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

  always @(posedge clk) begin
    q <= reset ? 4'h0 : (slowena ? (q[3] & ~q[2] & ~q[1] & q[0]) ? 4'h0 : q + 1 : q);
  end

endmodule
