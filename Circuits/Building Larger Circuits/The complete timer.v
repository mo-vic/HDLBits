module top_module (
    input            clk,
    input            reset,     // Synchronous reset
    input            data,
    output reg [3:0] count,
    output           counting,
    output           done,
    input            ack
);

  wire shift_ena, count_ena, done_counting;

  reg [9:0] q;

  parameter S = 4'h0, S1 = 4'h1, S11 = 4'h2, S110 = 4'h3,
            B0 = 4'h4, B1 = 4'h5, B2 = 4'h6, B3 = 4'h7,
            Count = 4'h8, Wait = 4'h9;

  reg [3:0] state, next_state;

  always @(*) begin
    case (state)
      S: next_state = data ? S1 : S;
      S1: next_state = data ? S11 : S;
      S11: next_state = data ? S11 : S110;
      S110: next_state = data ? B0 : S;
      B0: next_state = B1;
      B1: next_state = B2;
      B2: next_state = B3;
      B3: next_state = Count;
      Count: next_state = done_counting ? Wait : Count;
      Wait: next_state = ack ? S : Wait;
      default: next_state = state;
    endcase
  end

  always @(posedge clk) begin
    if (reset) state <= S;
    else state <= next_state;
  end

  assign shift_ena = ~|(state ^ B0) | ~|(state ^ B1) | ~|(state ^ B2) | ~|(state ^ B3);
  assign count_ena = ~|(q ^ 10'd999);
  assign done_counting = count_ena & ~|count ? 1'b1 : 1'b0;
  assign counting = ~|(state ^ Count);
  assign done = ~|(state ^ Wait);

  // Counter
  always @(posedge clk) begin
    if (reset) q <= 10'd0;
    else q <= (counting & |(q ^ 10'd999)) ? q + 1 : 10'd0;
  end

  // Shift register and counter
  always @(posedge clk) begin
    if (shift_ena) count <= {count[2:0], data};
    else if (count_ena) count <= count - 1;
    else count <= count;
  end

endmodule
