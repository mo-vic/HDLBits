module top_module (
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
  wire [31:0] xored;
  wire [15:0] lower_sum, higher_sum;
  wire lower_cout, higher_cout;

  assign xored = {32{sub}} ^ b;

  add16 adder1 (
      .a(a[15:0]),
      .b(xored[15:0]),
      .cin(sub),
      .sum(lower_sum),
      .cout(lower_cout)
  );
  add16 adder2 (
      .a(a[31:16]),
      .b(xored[31:16]),
      .cin(lower_cout),
      .sum(higher_sum),
      .cout(higher_cout)
  );

  assign sum = {higher_sum, lower_sum};

endmodule
