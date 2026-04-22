module ALUTest ();
  // Inputs
  reg [3:0] alu_op;
  reg [31:0] a;
  reg [31:0] b;

  // Outputs
  wire [31:0] result;
  wire zero;

  // Test clock
  reg clk;

  // Expected outputs
  reg [31:0] exp_result;
  wire exp_zero;

  // Vector and Error counts
  reg [10:0] vec_cnt, err_cnt;

  // Test vectors
  reg [99:0] testvec[0:99];

  // The test clock generation
  always begin
    clk = 1;
    #50;  // clk is 1 for 50 ns
    clk = 0;
    #50;  // clk is 0 for 50 ns
  end

  // Initialization
  initial begin
    $readmemh("testvectors.txt", testvec);

    err_cnt = 0;  // number of errors
    vec_cnt = 0;  // number of vectors
  end

  assign exp_zero = &(~exp_result);

  // Tests
  always @(posedge clk) begin
    // Wait 20 ns, so that we can safely apply the inputs
    #20;

    // Assign the signals from the testvec array
    {alu_op, a, b, exp_result} = testvec[vec_cnt];

    // Wait another 60ns after which we will be at 80ns
    #60;

    // Check if output is not what we expect to see
    if ((result !== exp_result) | (zero !== exp_zero)) begin
      $display("Error at %5d ns: Alu_op %b a = %h b = %h", $time, alu_op, a, b);
      $display("       %h (%h expected)", result, exp_result);
      $display(" Zero: %b (%b expected)", zero, exp_zero);
      err_cnt = err_cnt + 1;
    end

    vec_cnt = vec_cnt + 1;

    // We use === so that we can also test for X
    if ((testvec[vec_cnt][99:96] === 4'bxxxx)) begin
      // End of test, no more entries...
      $display("%d tests completed with %d errors", vec_cnt, err_cnt);

      // Wait so that we can see the last result
      #20;

      // Terminate simulation
      $finish;
    end
  end

  BadALU uut (
    .alu_op(alu_op),
    .a(a),
    .b(b),
    .result(result),
    .zero(zero)
  );
endmodule
