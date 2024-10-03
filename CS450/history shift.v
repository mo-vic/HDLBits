module top_module (
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

  always @(posedge clk or posedge areset) begin
    if (areset) predict_history <= 32'h0;
    else begin
      predict_history <= train_mispredicted ? {train_history[30:0], train_taken} : predict_valid ? {predict_history[30:0], predict_taken} : predict_history;
    end
  end

endmodule
