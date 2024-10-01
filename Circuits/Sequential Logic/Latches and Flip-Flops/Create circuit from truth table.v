module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

  always @(posedge clk) begin
    Q <= (j ^ k) ? (j & ~k) : (j ? ~Q : Q);
  end

endmodule
