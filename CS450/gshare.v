module top_module (
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

  wire [6:0] index;
  wire [1:0] state;
  reg [1:0] pht[127:0];

  assign index = train_valid ? train_pc ^ train_history : predict_valid ? predict_pc ^ predict_history : 7'd0;
  assign state = pht[index];
  assign predict_taken = pht[predict_pc^predict_history][1];

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      predict_history <= 7'd0;
      for (int i = 0; i < 128; i++) pht[i] <= 2'b01;
    end else begin
      predict_history <= train_valid & train_mispredicted ? {train_history[5:0], train_taken} : predict_valid ? {predict_history[5:0], predict_taken} : predict_history;
      pht[index] <= train_valid ? train_taken ? (&state ? 2'b11 : state + 2'b01) : (|state ? state - 2'b01 : 2'b00) : state;
    end
  end

endmodule

