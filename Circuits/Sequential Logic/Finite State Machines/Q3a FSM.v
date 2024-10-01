module top_module (
    input clk,
    input reset,  // Synchronous reset
    input s,
    input w,
    output reg z
);
  parameter A = 1'b0, B = 1'b1;

  // FSM for counting clocks
  parameter CZERO = 2'b00, CONE = 2'b01, CTWO = 2'b10, CTHREE = 2'b11;

  // FSM for counting bits
  parameter BZERO = 2'b00, BONE = 2'b01, BTWO = 2'b10, BTHREE = 2'b11;

  reg state, next_state;
  reg [1:0] cstate, next_cstate;
  reg [1:0] bstate, next_bstate;

  always @(*) begin
    case (state)
      A: next_state = s ? B : A;
      B: next_state = B;
    endcase
  end

  always @(*) begin
    case (cstate)
      CZERO:  next_cstate = (state ^ B) ? CZERO : CONE;
      CONE:   next_cstate = (state ^ B) ? CZERO : CTWO;
      CTWO:   next_cstate = (state ^ B) ? CZERO : CTHREE;
      CTHREE: next_cstate = (state ^ B) ? CZERO : CONE;
    endcase
  end

  always @(*) begin
    case (bstate)
      BZERO:  next_bstate = (state ^ B) ? BZERO : w ? BONE : BZERO;
      BONE:   next_bstate = (state ^ B) ? BZERO : w ? BTWO : BONE;
      BTWO:   next_bstate = (state ^ B) ? BZERO : w ? BTHREE : BTWO;
      BTHREE: next_bstate = (state ^ B) ? BZERO : w ? BONE : BZERO;
    endcase
  end

  always @(posedge clk) begin
    if (reset) begin
      state <= A;
      cstate <= CZERO;
      bstate <= BZERO;
      z <= 1'b0;
    end else begin
      state <= next_state;
      cstate <= next_cstate;
      bstate <= (cstate ^ CTWO) ? next_bstate : BZERO;
      z <= ~|(cstate ^ CTWO) & ((~|(bstate ^ BTWO) & ~w) | (~|(bstate ^ BONE) & w));
    end
  end


endmodule
