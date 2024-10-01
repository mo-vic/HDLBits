module top_module (
    input            clk,
    input            reset,  // Synchronous reset
    input      [7:0] d,
    output reg [7:0] q
);

  always @(posedge clk) begin
    q <= {8{~reset}} & d;
  end

endmodule
