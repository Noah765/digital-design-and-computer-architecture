module ALU (
  input  [ 3:0] alu_op,
  input  [31:0] a,
  input  [31:0] b,
  output [31:0] result,
  output        zero
);
  reg [31:0] logic_out;
  always @(*)
    case (alu_op[1:0])
      2'b00:   logic_out = a & b;
      2'b01:   logic_out = a | b;
      2'b10:   logic_out = a ^ b;
      2'b11:   logic_out = ~(a | b);
      default: logic_out = 32'b0;
    endcase

  wire [31:0] adder_out;
  ThirtyTwoBitAdder adder (
    .a (a),
    .b (alu_op[1] ? ~b : b),
    .ci(alu_op[1]),
    .s (adder_out)
  );
  wire [31:0] arithmetic_out = alu_op[3] ? {31'b0, adder_out[31]} : adder_out;

  assign result = alu_op[2] ? logic_out : arithmetic_out;
  assign zero   = ~|result;
endmodule
