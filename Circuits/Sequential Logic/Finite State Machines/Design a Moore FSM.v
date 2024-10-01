module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);

  reg [3:1] prev_state;
  reg [3:1] state;
  wire lower;

  always @(posedge clk) begin
    if (reset) begin
      prev_state <= 1'b000;
      state <= 1'b000;
    end else begin
      state <= s;
      prev_state <= s == state ? prev_state : state;
    end
  end

  assign lower = state < prev_state;
  assign dfr   = ~|state | (lower & (state == 3'b001 | state == 3'b011));

  assign fr1   = state[1] & ~state[3] | ~|state;
  assign fr2   = state[1] & ~state[2] | ~|state;
  assign fr3   = ~|state;

endmodule
