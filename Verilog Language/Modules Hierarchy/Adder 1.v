module top_module (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum
);
  wire [15:0] lower_sum, higher_sum;
  wire lower_cout, higher_cout;
  add16 adder1 (
      .a(a[15:0]),
      .b(b[15:0]),
      .cin(1'b0),
      .sum(lower_sum),
      .cout(lower_cout)
  );
  add16 adder2 (
      .a(a[31:16]),
      .b(b[31:16]),
      .cin(lower_cout),
      .sum(higher_sum),
      .cout(higher_cout)
  );

  assign sum = {higher_sum, lower_sum};

endmodule
