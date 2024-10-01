module top_module (
    input [254:0] in,
    output reg [7:0] out
);

  always @(*) begin
    integer i;
    out = 8'b0;
    for (i = 0; i <= 254; i = i + 1) if (in[i] == 1'b1) out = out + 8'b00000001;
  end

endmodule
