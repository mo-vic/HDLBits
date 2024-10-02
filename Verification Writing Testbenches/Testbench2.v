module top_module ();
  reg clk;
  reg in;
  reg [2:0] s;
  wire out;

  q7 inst (
      clk,
      in,
      s,
      out
  );

  initial begin
    clk <= 1'b0;
    in  <= 1'b0;
    s   <= 3'd2;

    in  <= #20 1'b1;
    in  <= #30 1'b0;
    in  <= #40 1'b1;
    in  <= #70 1'b0;

    s   <= #10 3'd6;
    s   <= #20 3'd2;
    s   <= #30 3'd7;
    s   <= #40 3'd0;
  end

  always @(*) begin
    #5 clk <= ~clk;
  end

endmodule
