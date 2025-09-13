`timescale 1ns/1ps 

module tb();
  reg [3:0] d;
  reg [1:0] sel;
  wire y;

  // Instance of 4:1 MUX in dataflow modeling
  mux4_data D1(.y(y), .d(d), .sel(sel));

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    $monitor("Time=%0t | Output: y=%b | Inputs: d=%b sel=%b", $time, y, d, sel);

    // Apply test values
    d = 4'b1010; sel = 2'b00; #10; 
    sel = 2'b01; #10;              
    sel = 2'b10; #10;              
    sel = 2'b11; #10;              

    d = 4'b1101; sel = 2'b00; #10; 
    sel = 2'b01; #10;              
    sel = 2'b10; #10;              
    sel = 2'b11; #10;              

    $finish;
  end
endmodule
