module FourOneMux (
  input  [3:0] in,
  input  [1:0] sel,
  output       out
);
  wire [1:0] w;

  TwoOneMux g1 (
    .in (in[1:0]),
    .sel(sel[0]),
    .out(w[0])
  );
  TwoOneMux g2 (
    .in (in[3:2]),
    .sel(sel[0]),
    .out(w[1])
  );
  TwoOneMux g3 (
    .in (w),
    .sel(sel[1]),
    .out(out)
  );
endmodule
