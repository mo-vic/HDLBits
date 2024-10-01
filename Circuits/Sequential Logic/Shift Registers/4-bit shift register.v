module top_module (
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

  always @(posedge clk or posedge areset) begin
    if (areset) q <= 4'h0;
    else q <= load ? data : ena ? {1'b0, q[3:1]} : q;
  end

endmodule
