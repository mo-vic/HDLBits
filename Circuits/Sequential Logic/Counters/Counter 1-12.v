module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);

  assign c_enable = enable;
  assign {c_load, c_d} = reset ? {1'b1, 4'h1} : ((Q[3] & Q[2] & ~Q[1] & ~Q[0] & enable) ? {1'b1, 4'h1} : {1'b0, Q});

  count4 the_counter (
      clk,
      c_enable,
      c_load,
      c_d,
      Q
  );


endmodule
