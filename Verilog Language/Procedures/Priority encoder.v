// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

  integer i;
  always @(*) begin
    pos = 2'b0;
    for (i = 3; i >= 0; i = i - 1) if (in[i] == 1) pos = i[1:0];
  end

endmodule
