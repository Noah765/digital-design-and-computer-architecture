module Top (
  input        clk,
  input        reset,
  input        left,
  input        right,
  output [5:0] lights
);
  wire       fsm_enable;
  wire [5:0] light_values;
  ClockDivider #(25) fsm_enable_clock (
    .clk_in (clk),
    .reset  (reset),
    .clk_out(fsm_enable)
  );
  FSM fsm (
    .clk   (clk),
    .reset (reset),
    .enable(fsm_enable),
    .left  (left),
    .right (right),
    .lights(light_values)
  );

  AnimatedLED rc (
    .clk    (clk),
    .reset  (reset),
    .value  (light_values[0]),
    .display(lights[0])
  );
  AnimatedLED rb (
    .clk    (clk),
    .reset  (reset),
    .value  (light_values[1]),
    .display(lights[1])
  );
  AnimatedLED ra (
    .clk    (clk),
    .reset  (reset),
    .value  (light_values[2]),
    .display(lights[2])
  );
  AnimatedLED la (
    .clk    (clk),
    .reset  (reset),
    .value  (light_values[3]),
    .display(lights[3])
  );
  AnimatedLED lb (
    .clk    (clk),
    .reset  (reset),
    .value  (light_values[4]),
    .display(lights[4])
  );
  AnimatedLED lc (
    .clk    (clk),
    .reset  (reset),
    .value  (light_values[5]),
    .display(lights[5])
  );
endmodule
