module top_module (
    input [99:0] a,
    b,
    input sel,
    output [99:0] out
);

  assign out = ({100{~sel}} & a) | ({100{sel}} & b);

endmodule
