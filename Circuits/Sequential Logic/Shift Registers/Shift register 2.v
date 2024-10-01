module top_module (
    input  [3:0] SW,
    input  [3:0] KEY,
    output [3:0] LEDR
);  //

  MUXDFF muxdff3 (
      .clk(KEY[0]),
      .w  (KEY[3]),
      .E  (KEY[1]),
      .R  (SW[3]),
      .L  (KEY[2]),
      .q  (LEDR[3])
  );
  MUXDFF muxdff2 (
      .clk(KEY[0]),
      .w  (LEDR[3]),
      .E  (KEY[1]),
      .R  (SW[2]),
      .L  (KEY[2]),
      .q  (LEDR[2])
  );
  MUXDFF muxdff1 (
      .clk(KEY[0]),
      .w  (LEDR[2]),
      .E  (KEY[1]),
      .R  (SW[1]),
      .L  (KEY[2]),
      .q  (LEDR[1])
  );
  MUXDFF muxdff0 (
      .clk(KEY[0]),
      .w  (LEDR[1]),
      .E  (KEY[1]),
      .R  (SW[0]),
      .L  (KEY[2]),
      .q  (LEDR[0])
  );

endmodule

module MUXDFF (
    input clk,
    input w,
    input E,
    input R,
    input L,
    output reg q
);

  always @(posedge clk) begin
    q <= L ? R : (E ? w : q);
  end

endmodule
