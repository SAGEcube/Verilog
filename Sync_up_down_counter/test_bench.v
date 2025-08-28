`timescale 1ns/1ps

module testbench;
  reg clk;
  reg in;
  reg rst;
  wire [7:0] count;

  // Instantiate the counter
  Sync_up_down uut (
    .clk(clk),
    .in(in),
    .rst(rst),
    .count(count)
  );

  // Clock generation: 10ns period
  always #5 clk = ~clk;

  initial begin
    // Dumping for GTKWave
    $dumpfile("testbench.vcd");
    $dumpvars(0, testbench);

    // Initialize
    clk = 0;
    rst = 1;
    in  = 0;  // start with up counter
    #10 rst = 0;

    // Run up counter for a while
    #100 in = 1;   // switch to down counter

    // Run down counter for a while
    #100 in = 0;   // back to up counter

    #50 $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time=%0t | clk=%b | rst=%b | in=%b | count=%b",
             $time, clk, rst, in, count);
  end

endmodule
