`timescale 1ns/1ps

module tb_data_memo;

  // Parameters
  localparam ADDR_WIDTH = 8;   // 256 bytes memory for testing
  localparam MEM_FILE   = "";

  // Testbench signals
  reg clk;
  reg rst;
  reg ren;
  reg wen;
  reg [2:0] funct3;
  reg [31:0] wdata;
  reg [ADDR_WIDTH-1:0] addr;
  wire [31:0] rdata;

  // Instantiate the DUT (Device Under Test)
  data_memo #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_FILE(MEM_FILE)
  ) uut (
    .clk(clk),
    .rst(rst),
    .ren(ren),
    .wen(wen),
    .funct3(funct3),
    .wdata(wdata),
    .addr(addr),
    .rdata(rdata)
  );

  // Clock generator (10 ns period)
  always #5 clk = ~clk;

  // Test sequence
  initial begin
    // Dump for GTKWave
    $dumpfile("tb_data_memo.vcd");
    $dumpvars(0, tb_data_memo);

    // Initialize signals
    clk = 0;
    rst = 1;
    ren = 0;
    wen = 0;
    funct3 = 3'b000;
    addr = 0;
    wdata = 0;

    // Reset for 2 cycles
    #10;
    rst = 0;

    // ------------------------
    // Test store byte (SB)
    // ------------------------
    #10;
    addr = 8'h10;
    wdata = 32'h000000AA;
    funct3 = 3'b000; // SB
    wen = 1;
    #10 wen = 0;

    // Test load byte (LB)
    #10;
    addr = 8'h10;
    funct3 = 3'b000; // LB
    ren = 1;
    #10 ren = 0;
    $display("LB from 0x10 = %h", rdata);

    // ------------------------
    // Test store halfword (SH)
    // ------------------------
    #10;
    addr = 8'h20;
    wdata = 32'h0000BEEF;
    funct3 = 3'b001; // SH
    wen = 1;
    #10 wen = 0;

    // Test load halfword (LH)
    #10;
    addr = 8'h20;
    funct3 = 3'b001; // LH
    ren = 1;
    #10 ren = 0;
    $display("LH from 0x20 = %h", rdata);

    // ------------------------
    // Test store word (SW)
    // ------------------------
    #10;
    addr = 8'h30;
    wdata = 32'hDEADBEEF;
    funct3 = 3'b010; // SW
    wen = 1;
    #10 wen = 0;

    // Test load word (LW)
    #10;
    addr = 8'h30;
    funct3 = 3'b010; // LW
    ren = 1;
    #10 ren = 0;
    $display("LW from 0x30 = %h", rdata);

    // ------------------------
    // End simulation
    // ------------------------
    #20;
    $finish;
  end

endmodule
