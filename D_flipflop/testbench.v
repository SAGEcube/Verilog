`timescale 1ns/1ps

module tb;
  wire q;
  wire qn;
  reg clk;
  reg d;

  // Instantiate DUT
  D_FF dut (.clk(clk), .d(d), .q(q), .qn(qn));

  // Clock generation (10ns period)
  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    $monitor("Time=%0t | d=%b | q=%b | qn=%b", $time, d, q, qn);

    // Initialize
    clk = 0;
    d = 0;

    // Stimulus
    #12 d = 1;
    #10 d = 0;
    #10 d = 1;
    #10 d = 0;
    #20;

    $finish;
  end
endmodule
