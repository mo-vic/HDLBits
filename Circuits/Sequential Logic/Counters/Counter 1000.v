module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);  //

  reg [3:0] q0;
  reg [3:0] q1;
  reg [3:0] q2;

  assign c_enable[0] = 1'b1;
  assign c_enable[1] = q0[3] & ~q0[2] & ~q0[1] & q0[0];
  assign c_enable[2] = q1[3] & ~q1[2] & ~q1[1] & q1[0] & c_enable[1];

  assign OneHertz = &c_enable & q2[3] & ~q2[2] & ~q2[1] & q2[0];

  bcdcount counter0 (
      clk,
      reset,
      c_enable[0],
      q0
  );
  bcdcount counter1 (
      clk,
      reset,
      c_enable[1],
      q1
  );
  bcdcount counter2 (
      clk,
      reset,
      c_enable[2],
      q2
  );

endmodule
