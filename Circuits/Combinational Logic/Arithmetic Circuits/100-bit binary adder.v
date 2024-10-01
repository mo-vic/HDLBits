module top_module (
    input [99:0] a,
    b,
    input cin,
    output cout,
    output [99:0] sum
);

  wire [99:0] fa_cin, fa_cout;
  assign fa_cin[0] = cin;

  FA adders[99:0] (
      .a(a),
      .b(b),
      .cin(fa_cin),
      .cout(fa_cout),
      .sum(sum)
  );

  assign fa_cin[99:1] = fa_cout[98:0];
  assign cout = fa_cout[99];

endmodule

module FA (
    input  a,
    b,
    cin,
    output cout,
    sum
);

  assign sum  = a ^ b ^ cin;
  assign cout = (a ^ b) & cin | (a & b);

endmodule

