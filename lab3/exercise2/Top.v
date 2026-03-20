module Top (
  input      [3:0] a,
  input      [3:0] b,
  input      [1:0] display,
  output reg [3:0] enable,
  output     [6:0] segments,
  output           overflow
);
  wire [4:0] s;

  always @(*)
    case (display)
      2'b00:   enable = 4'b1110;
      2'b01:   enable = 4'b1101;
      2'b10:   enable = 4'b1011;
      2'b11:   enable = 4'b0111;
      default: enable = 4'b0000;
    endcase
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
