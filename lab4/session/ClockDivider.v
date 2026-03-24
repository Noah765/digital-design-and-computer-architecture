module ClockDivider (
  input  clk_in,
  input  reset,
  output clk_out
);
  reg [24:0] count;

  always @(posedge clk_in)
    if (reset) count <= 0;
    else count <= count + 1;

  assign clk_out = &count;
endmodule
