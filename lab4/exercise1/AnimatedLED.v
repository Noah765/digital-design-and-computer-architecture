module AnimatedLED (
  input  clk,
  input  reset,
  input  value,
  output display
);
  reg [7:0] brightness;
  assign active = value & ~&brightness | ~value & |brightness;
  wire change_brightness;
  ClockDivider #(17) change_brightness_clock (
    .clk_in (clk),
    .reset  (reset | ~active),
    .clk_out(change_brightness)
  );
  always @(posedge clk)
    if (reset) brightness <= 0;
    else if (change_brightness)
      if (value) brightness <= brightness + 1;
      else brightness <= brightness - 1;

  reg [7:0] counter;
  wire reset_counter;
  ClockDivider #(8) reset_counter_clock (
    .clk_in (clk),
    .reset  (reset),
    .clk_out(reset_counter)
  );
  always @(posedge clk)
    if (reset) counter <= 0;
    else if (reset_counter) counter <= brightness;
    else if (|counter) counter <= counter - 1;

  assign display = counter > 0;
endmodule
