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

module top_module (
    input [99:0] a,
    b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);

  wire [99:0] fa_cin;
  assign fa_cin[0] = cin;

  // FA adders[99:0] (.a(a), .b(b), .cin(fa_cin), .cout(cout), .sum(sum));

  generate
    genvar i;
    for (i = 0; i <= 99; i = i + 1)
      begin: adder
        FA (.a(a[i]), .b(b[i]), .cin(fa_cin[i]), .cout(cout[i]), .sum(sum[i]));
      end
  endgenerate

  always @(*) begin
    integer i;
    for (i = 1; i <= 99; i = i + 1) fa_cin[i] = cout[i-1];
  end

endmodule
