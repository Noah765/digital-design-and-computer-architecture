module Top (
  input  [3:0] a,
  input  [3:0] b,
  output [6:0] segments,
  output       overflow
);
  wire [4:0] s;

  Adder g1 (
    .a(a),
    .b(b),
    .s(s)
  );
  Decoder g2 (
    .data(s[3:0]),
    .segments(segments)
  );
  assign overflow = s[4];
endmodule
