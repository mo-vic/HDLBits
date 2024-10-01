module top_module (
    input  clk,
    input  aresetn,  // Asynchronous active-low reset
    input  x,
    output z
);

  parameter STATE1 = 2'b00, STATE2 = 2'b01, STATE3 = 2'b10;

  reg [1:0] state, next_state;

  always @(*) begin
    case (state)
      STATE1:  next_state = x ? STATE2 : STATE1;
      STATE2:  next_state = x ? STATE2 : STATE3;
      STATE3:  next_state = x ? STATE2 : STATE1;
      default: next_state = state;
    endcase
  end

  always @(posedge clk or negedge aresetn) begin
    if (~aresetn) state <= STATE1;
    else state <= next_state;
  end

  assign z = ~|(state ^ STATE3) & x;

endmodule
