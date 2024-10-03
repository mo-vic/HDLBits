module top_module (
    input clk,
    input load,
    input [9:0] data,
    output tc
);

  reg [9:0] counter;
  always @(posedge clk) begin
    if (load) counter <= data;
    else counter <= |counter ? counter - 1 : 10'd0;
  end

  assign tc = ~|counter;

endmodule
