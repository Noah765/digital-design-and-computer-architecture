module TwoOneMux (
  input  [1:0] in,
  input        sel,
  output       out
);
  wire nsel, w1, w2;
  not g1 (nsel, sel);

  and g2 (w1, in[0], nsel);
  and g3 (w2, in[1], sel);
  or g4 (out, w1, w2);
endmodule
