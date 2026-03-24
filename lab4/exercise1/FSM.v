module FSM (
  input            clk,
  input            reset,
  input            enable,
  input            left,
  input            right,
  output reg [5:0] lights
);
  reg [2:0] state, nextstate;

  parameter OFF = 3'b000;
  parameter L1 = 3'b001;
  parameter L2 = 3'b010;
  parameter L3 = 3'b011;
  parameter R1 = 3'b100;
  parameter R2 = 3'b101;
  parameter R3 = 3'b110;

  always @(posedge clk)
    if (reset) state <= OFF;
    else if (enable) state <= nextstate;

  always @(*)
    case (state)
      OFF: begin
        if (left) nextstate = L1;
        else if (right) nextstate = R1;
        else nextstate = OFF;
      end
      L1:      nextstate = L2;
      L2:      nextstate = L3;
      L3:      nextstate = OFF;
      R1:      nextstate = R2;
      R2:      nextstate = R3;
      R3:      nextstate = OFF;
      default: nextstate = OFF;
    endcase

  always @(*)
    case (state)
      OFF:     lights = 6'b000_000;
      L1:      lights = 6'b001_000;
      L2:      lights = 6'b011_000;
      L3:      lights = 6'b111_000;
      R1:      lights = 6'b000_100;
      R2:      lights = 6'b000_110;
      R3:      lights = 6'b000_111;
      default: lights = 6'b000_000;
    endcase
endmodule
