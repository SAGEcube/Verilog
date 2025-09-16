module ImmGen_tb;
    reg [31:0] instr;
    wire [31:0] imm;

    ImmGen uut(.instr(instr), .imm_out(imm));

    initial begin
        instr = 32'b000000000100_00010_000_00011_0010011; // ADDI x3, x2, 4
        #10 $display("I-type imm: %d", imm);

        instr = 32'b0000001_00011_00100_010_00101_0100011; // SW x3, 8(x4)
        #10 $display("S-type imm: %d", imm);

        instr = 32'b0000000_00110_00111_000_00000_1100011; // BEQ x7, x6, imm
        #10 $display("B-type imm: %d", imm);

        instr = 32'b00000000000000000001_00010_0110111;    // LUI x2, 1
        #10 $display("U-type imm: %d", imm);

        instr = 32'b00000000000100000000_00000_1101111;    // JAL x0, 1
        #10 $display("J-type imm: %d", imm);
    end
endmodule
