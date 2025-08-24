`timescale 1ns / 1ps

module test_bench;
   reg we, clk;
   reg [3:0] waddr, raddr1, raddr2;
   reg [15:0] wdata;
   wire [15:0] rdata1, rdata2;
  
   // Instantiate Register File
   reg_file uut (
      .clk(clk), .we(we),
      .waddr(waddr), .raddr1(raddr1), .raddr2(raddr2),
      .wdata(wdata), .rdata1(rdata1), .rdata2(rdata2)
   );
  
   // Clock Generation
   initial begin 
      clk = 0;
      forever #5 clk = ~clk;
   end 
  
   // Stimulus
   initial begin 
      $dumpfile("test_bench.vcd");   // waveform file
      $dumpvars(0, test_bench);      // dump everything
      
      we = 0; waddr = 0; raddr1 = 0; raddr2 = 0; wdata = 0;
    
      // Write 0x1234 into register 2
      #10 we = 1; waddr = 4'd2; wdata = 16'h1234;
      #10 we = 0;

      // Write 0xABCD into register 7
      #10 we = 1; waddr = 4'd7; wdata = 16'hABCD;
      #10 we = 0;

      // Read from reg2 and reg7
      #10 raddr1 = 4'd2; raddr2 = 4'd7;

      // Write 0xF00D into register 15
      #10 we = 1; waddr = 4'd15; wdata = 16'hF00D;
      #10 we = 0;

      // Read from reg15 and reg2
      #10 raddr1 = 4'd15; raddr2 = 4'd2;

      // End simulation
      #50 $finish;
   end 
endmodule
