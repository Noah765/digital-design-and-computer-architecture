module FullAdder (
  input  a,
  input  b,
  input  ci,
  output s,
  output co
);
  wire ab, aob, aobci;

  xor g1 (s, a, b, ci);
  and g2 (ab, a, b);
  or g3 (aob, a, b);
  and g4 (aobci, aob, ci);
  or g5 (co, ab, aobci);
endmodule
