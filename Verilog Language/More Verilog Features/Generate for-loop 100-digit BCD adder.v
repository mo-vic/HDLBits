module top_module (
    input [399:0] a,
    b,
    input cin,
    output cout,
    output [399:0] sum
);

  wire [99:0] adder_cin;
  wire [99:0] adder_cout;

  assign adder_cin[0] = cin;

  bcd_fadd adders[99:0] (
      .a(a),
      .b(b),
      .cin(adder_cin),
      .cout(adder_cout),
      .sum(sum)
  );

  assign adder_cin[99:1] = adder_cout[98:0];
  assign cout = adder_cout[99];


endmodule
