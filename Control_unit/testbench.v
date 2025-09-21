`timescale 1ns/1ps

module tb_control_unit;
    reg [6:0] opcode;
    wire Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump;
    wire [1:0] ALUop;

    // Instantiate DUT
    control_unit dut (
        .opcode(opcode),
        .Regwrite(Regwrite),
        .ALUsrc(ALUsrc),
        .Memread(Memread),
        .Memwrite(Memwrite),
        .Memtoreg(Memtoreg),
        .Branch(Branch),
        .Jump(Jump),
        .ALUop(ALUop)
    );

    initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, tb_control_unit);

        $display("Time | Opcode   | Regwrite ALUsrc Memread Memwrite Memtoreg Branch Jump ALUop");
        $display("----------------------------------------------------------------------------");

        opcode = 7'b0110011; #10; // R-type
        $display("%4t | R-type   |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        opcode = 7'b0010011; #10; // I-type
        $display("%4t | I-type   |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        opcode = 7'b0000011; #10; // Load
        $display("%4t | Load     |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        opcode = 7'b0100011; #10; // Store
        $display("%4t | Store    |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        opcode = 7'b1100011; #10; // Branch
        $display("%4t | Branch   |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        opcode = 7'b1101111; #10; // JAL
        $display("%4t | JAL      |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        opcode = 7'b1100111; #10; // JALR
        $display("%4t | JALR     |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        opcode = 7'b1111111; #10; // Invalid
        $display("%4t | Invalid  |     %b       %b      %b       %b       %b       %b     %b   %b", 
                  $time, Regwrite, ALUsrc, Memread, Memwrite, Memtoreg, Branch, Jump, ALUop);

        $finish;
    end
endmodule
