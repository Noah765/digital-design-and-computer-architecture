module FSMTest ();
  // Inputs
  reg reset, left, right;

  // Test clock
  reg clk;

  // Vector count
  reg [10:0] vec_cnt;

  // Test vectors
  reg [2:0] testvec[0:99];

  // Test clock generation
  always begin
    clk = 1;
    #50;
    clk = 0;
    #50;
  end

  // Initialization
  initial begin
    $readmemb("testvectors.txt", testvec);
    vec_cnt = 0;
    reset   = 1;
    #50;
    reset = 0;
  end

  // Tests
  always @(posedge clk) begin
    #20;
    {reset, left, right} = testvec[vec_cnt];
    #20;
    $display("Tested reset = %b left = %b right = %b", reset, left, right);

    vec_cnt = vec_cnt + 1;

    if ((testvec[vec_cnt] === 3'bxxx)) begin
      $finish;
    end
  end

  FSM uut (
    .clk   (clk),
    .reset (reset),
    .enable(1),
    .left  (left),
    .right (right)
  );
endmodule
