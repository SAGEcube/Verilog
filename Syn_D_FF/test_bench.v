`timescale 1ns / 1ps

module flipflop_tb;

reg clk;
reg rst;
reg in;
wire out;

// Instantiate the DUT (Device Under Test)
flipflop uut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
);

// Clock generation: Toggle every 5 ns (100 MHz)
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Stimulus
initial begin
    // Waveform dump
    $dumpfile("flipflop.vcd");   // Output file for waveform
    $dumpvars(0, flipflop_tb);   // Dump everything in this module

    // Monitor outputs
    $monitor("Time: %0t | clk=%b rst=%b in=%b -> out=%b", $time, clk, rst, in, out);

    // Initialize inputs
    rst = 1; in = 0; #12;
    rst = 0; in = 1; #10;
    in  = 0; #10;
    in  = 1; #10;
    rst = 1; #10;
    rst = 0; in = 0; #10;

    $finish;  // End simulation
end

endmodule