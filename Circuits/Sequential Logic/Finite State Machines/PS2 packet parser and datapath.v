module top_module (
    input clk,
    input [7:0] in,
    input reset,  // Synchronous reset
    output reg [23:0] out_bytes,
    output done
);  //

  // FSM from fsm_ps2
  parameter BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

  reg [1:0] state, next_state;

  // State transition logic (combinational)
  always @(*) begin
    case (state)
      BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
      BYTE2: next_state = BYTE3;
      BYTE3: next_state = DONE;
      DONE:  next_state = in[3] ? BYTE2 : BYTE1;
    endcase
  end

  // State flip-flops (sequential)
  always @(posedge clk) begin
    if (reset) state <= BYTE1;
    else state <= next_state;
  end

  // Output logic
  assign done = &state;

  // New: Datapath to store incoming bytes.
  always @(posedge clk) begin
    out_bytes <= {out_bytes[15:0], in};
  end

endmodule
