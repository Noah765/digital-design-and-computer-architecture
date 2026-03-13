module Decoder (
  input  [1:0] in,
  output [3:0] out
);
  wire [1:0] nin;
  not g1 (nin[0], in[0]);
  not g2 (nin[1], in[1]);

  and g3 (out[0], nin[1], nin[0]);
  and g4 (out[1], nin[1], in[0]);
  and g5 (out[2], in[1], nin[0]);
  and g6 (out[3], in[1], in[0]);
endmodule
