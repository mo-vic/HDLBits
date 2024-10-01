module top_module (
    input  clk,
    input  in,
    input  reset,  // Synchronous reset
    output done
);

  parameter IDLE = 4'h0, START = 4'h1, FIRST = 4'h2, SECOND = 4'h3, 
            THIRD = 4'h4, FOURTH = 4'h5, FIFTH = 4'h6, SIXTH = 4'h7, 
            SEVENTH = 4'h8, EIGHTH = 4'h9, STOP = 4'ha, WAIT = 4'hb;

  reg [3:0] state, next_state;

  always @(*) begin
    case (state)
      IDLE: next_state <= in ? IDLE : START;
      START: next_state <= FIRST;
      FIRST: next_state <= SECOND;
      SECOND: next_state <= THIRD;
      THIRD: next_state <= FOURTH;
      FOURTH: next_state <= FIFTH;
      FIFTH: next_state <= SIXTH;
      SIXTH: next_state <= SEVENTH;
      SEVENTH: next_state <= EIGHTH;
      EIGHTH: next_state <= in ? STOP : WAIT;
      STOP: next_state <= in ? IDLE : START;
      WAIT: next_state <= in ? IDLE : WAIT;
      default: next_state <= state;
    endcase
  end

  always @(posedge clk) begin
    if (reset) state <= IDLE;
    else state <= next_state;
  end

  assign done = ~|(state ^ STOP);

endmodule
