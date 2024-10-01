module top_module (
    input clk,
    input reset,  // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q
);

  assign ena[1] = q[3] & ~q[2] & ~q[1] & q[0];
  assign ena[2] = q[7] & ~q[6] & ~q[5] & q[4] & ena[1];
  assign ena[3] = q[11] & ~q[10] & ~q[9] & q[8] & ena[2];

  bcdcount counter0 (
      clk,
      reset,
      1'b1,
      q[3:0]
  );
  bcdcount counter1 (
      clk,
      reset,
      ena[1],
      q[7:4]
  );
  bcdcount counter2 (
      clk,
      reset,
      ena[2],
      q[11:8]
  );
  bcdcount counter3 (
      clk,
      reset,
      ena[3],
      q[15:12]
  );

endmodule

module bcdcount (
    input clk,
    input reset,
    input enable,
    output reg [3:0] q
);

  always @(posedge clk) begin
    q <= reset ? 4'h0 : (enable ? (q[3] & ~q[2] & ~q[1] & q[0]) ? 4'h0 : q + 1 : q);
  end

endmodule
