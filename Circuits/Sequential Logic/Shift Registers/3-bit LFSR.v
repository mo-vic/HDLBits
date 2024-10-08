module top_module (
    input      [2:0] SW,   // R
    input      [1:0] KEY,  // L and clk
    output reg [2:0] LEDR
);  // Q

  always @(posedge KEY[0]) begin
    LEDR <= KEY[1] ? {SW[2], SW[1], SW[0]} : {LEDR[1] ^ LEDR[2], LEDR[0], LEDR[2]};
  end

endmodule
