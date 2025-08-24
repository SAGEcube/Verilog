`timescale 1ns / 1ps

module testbench;
  reg clk;
  reg rst;
  reg [31:0] pc_next;
  wire [31:0] pc_q;

  // Instantiate DUT
  pc32 uut (
    .clk(clk), 
    .rst(rst), 
    .pc_next(pc_next), 
    .pc_q(pc_q)
  );

  // Clock generator: 10ns period
  always #5 clk = ~clk;

  initial begin
    // Setup waveform dump
    $dumpfile("pc32_tb.vcd");   // VCD file name
    $dumpvars(0, testbench);    // dump all signals in this testbench
    
    // Setup monitor
    $monitor("t=%0t | clk=%b | rst=%b | pc_next=%h | pc_q=%h", 
              $time, clk, rst, pc_next, pc_q);

    // Initialize signals
    clk = 0;
    rst = 1; pc_next = 32'h00000000;
    #10;  
    rst = 0;

    // Test 1: Load next PC = 4
    pc_next = 32'h00000004;
    #10;

    // Test 2: Load next PC = 8
    pc_next = 32'h00000008;
    #10;

    // Test 3: Jump to PC = 100
    pc_next = 32'h00000064;
    #10;

    // Reset again
    rst = 1;
    #10;
    rst = 0;

    // Finish simulation
    #20;
    $finish;   // use $finish instead of $stop for clean end
  end
endmodule
