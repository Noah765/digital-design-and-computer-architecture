module ClockDivider #(
  parameter COUNTER_SIZE = 25
) (
  input  clk_in,
  input  reset,
  output clk_out
);
  reg [COUNTER_SIZE-1:0] count;

  always @(posedge clk_in)
    if (reset) count <= 0;
    else count <= count + 1;

  assign clk_out = &count;
endmodule
