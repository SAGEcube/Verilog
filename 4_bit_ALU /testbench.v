`timescale 1ns/1ps
module tb_alu4;
    reg  [3:0] a, b, op;
    wire [3:0] y;
    wire cf, bf, vf, zf, sf, pf;

    // Instantiate ALU
    ALU_4_BIT uut (
        .a(a), .b(b), .op(op), 
        .y(y), .cf(cf), .bf(bf), .vf(vf), .zf(zf), .sf(sf), .pf(pf)
    );

    integer i;

    initial begin
        // dump waveform for GTKWave
        $dumpfile("alu4_tb.vcd");  
        $dumpvars(0, tb_alu4);

        // monitor changes
        $monitor("T=%0t | a=%h b=%h op=%h -> y=%h | CF=%b BF=%b VF=%b ZF=%b SF=%b PF=%b", 
                  $time, a, b, op, y, cf, bf, vf, zf, sf, pf);

        // Test cases
        a = 4'h0; b = 4'h0; op = 4'h0; #5;

        // 5 and 3 with all ops
        a = 4'h5; b = 4'h3;
        for (i=0; i<16; i=i+1) begin 
            op = i[3:0]; 
            #10; 
        end

        // 7 and 1 with all ops
        a = 4'h7; b = 4'h1;
        for (i=0; i<16; i=i+1) begin 
            op = i[3:0]; 
            #10; 
        end

        // 8 and 8 with all ops
        a = 4'h8; b = 4'h8;
        for (i=0; i<16; i=i+1) begin 
            op = i[3:0]; 
            #10; 
        end

        // F and 1 with all ops
        a = 4'hF; b = 4'h1;
        for (i=0; i<16; i=i+1) begin 
            op = i[3:0]; 
            #10; 
        end

        $finish;
    end
endmodule
