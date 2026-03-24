module Top (
  input        clk,
  input        reset,
  input        left,
  input        right,
  output [5:0] lights
);
  wire enable;

  ClockDivider g1 (
    .clk_in (clk),
    .reset  (reset),
    .clk_out(enable)
  );
  FSM g2 (
    .clk   (clk),
    .reset (reset),
    .enable(enable),
    .left  (left),
    .right (right),
    .lights(lights)
  );
endmodule
