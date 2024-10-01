module top_module (
    input  clk,
    input  resetn,  // synchronous reset
    input  in,
    output out
);

  reg [3:0] q;

  always @(posedge clk) begin
    q <= resetn ? {in, q[3:1]} : 4'h0;
  end

  assign out = q[0];

endmodule
