module FullFourBitAdder (
  input  [3:0] a,
  input  [3:0] b,
  input        ci,
  output [3:0] s,
  output       co
);
  wire [4:0] s1, s2;

  FourBitAdder g1 (
    .a(a),
    .b(b),
    .s(s1)
  );
  FourBitAdder g2 (
    .a(s1[3:0]),
    .b({3'b0, ci}),
    .s(s2)
  );

  assign s  = s2[3:0];
  assign co = s1[4] | s2[4];
endmodule
