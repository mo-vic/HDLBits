module top_module (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

  wire ss_cout, mm_cout, hh_cout;

  always @(posedge hh_cout) begin
    pm = reset ? 1'b0 : ~pm;
  end

  bcdcount60 ss_counter (
      clk,
      reset,
      ena,
      ss_cout,
      ss
  );
  bcdcount60 mm_counter (
      clk,
      reset,
      ss_cout,
      mm_cout,
      mm
  );
  bcdcount12 hh_counter (
      clk,
      reset,
      mm_cout & ss_cout,
      hh_cout,
      hh
  );

endmodule

module bcdcount12 (
    input clk,
    input reset,
    input enable,
    output cout,
    output [7:0] q
);

  wire cout1, cout2;
  wire [3:0] reset_val1;
  wire [3:0] reset_val2;

  assign cout = q == 8'h12 ? 1'b1 : 1'b0;
  assign {reset_val2, reset_val1} = reset ? 8'h12 : cout ? 8'h01 : 8'h00;

  bcdcount counter1 (
      clk,
      reset,
      cout,
      reset_val1,
      enable,
      cout1,
      q[3:0]
  );
  bcdcount counter2 (
      clk,
      reset,
      cout,
      reset_val2,
      (cout | cout1) & enable,
      cout2,
      q[7:4]
  );

endmodule

module bcdcount60 (
    input clk,
    input reset,
    input enable,
    output cout,
    output [7:0] q
);

  wire cout1, cout2;

  assign cout = q == 8'h59 ? 1'b1 : 1'b0;

  bcdcount counter1 (
      clk,
      reset,
      cout,
      4'h0,
      enable,
      cout1,
      q[3:0]
  );
  bcdcount counter2 (
      clk,
      reset,
      cout,
      4'h0,
      cout1 & enable,
      cout2,
      q[7:4]
  );

endmodule

module bcdcount (
    input clk,
    input reset,
    input overflow,
    input [3:0] reset_val,
    input enable,
    output cout,
    output reg [3:0] q
);

  assign cout = (q[3] & ~q[2] & ~q[1] & q[0]) ? 1'b1 : 1'b0;

  always @(posedge clk) begin
    q <= reset ? reset_val : (enable ? overflow ? reset_val : (q[3] & ~q[2] & ~q[1] & q[0]) ? 4'h0 : q + 1 : q);
  end

endmodule
