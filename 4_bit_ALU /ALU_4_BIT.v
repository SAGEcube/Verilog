module ALU_4_BIT(
  input  [3:0] a,
  input  [3:0] b,
  input  [3:0] op,
  output reg [3:0] y,
  output reg cf,
  output reg bf,
  output reg vf,
  output reg zf,
  output reg sf,
  output reg pf
);

  reg [4:0] t;
  reg [4:0] u;

  always @(*) begin
    y  = 4'b0000;
    cf = 1'b0;
    bf = 1'b0;
    vf = 1'b0;

    case(op)
      4'b0000: begin // ADD
        t  = {1'b0,a} + {1'b0,b};
        y  = t[3:0];
        cf = t[4];
        vf = ~(a[3]^b[3]) & (a[3]^y[3]);
      end

      4'b0001: begin // SUB
        u  = {1'b0,a} + {1'b0,~b} + 5'b00001;
        y  = u[3:0];
        cf = u[4];
        bf = ~u[4];
        vf = (a[3]^b[3]) & (a[3]^y[3]);
      end

      4'b0010: y = a & b;
      4'b0011: y = a | b;
      4'b0100: y = a ^ b;
      4'b0101: y = ~a;

      4'b0110: begin // INC
        t  = {1'b0,a} + 5'b00001;
        y  = t[3:0];
        cf = t[4];
        vf = (~a[3]) & (a[3]^y[3]);
      end

      4'b0111: begin // DEC
        u  = {1'b0,a} + 5'b11111;
        y  = u[3:0];
        cf = u[4];
        bf = ~u[4];
        vf = (a[3]) & (a[3]^y[3]);
      end

      4'b1000: begin // SHL
        y  = {a[2:0],1'b0};
        cf = a[3];
        vf = a[3]^y[3];
      end

      4'b1001: begin // SHR
        y  = {1'b0,a[3:1]};
        cf = a[0];
      end

      4'b1010: begin // ROL
        y  = {a[2:0],a[3]};
        cf = a[3];
      end

      4'b1011: begin // ROR
        y  = {a[0],a[3:1]};
        cf = a[0];
      end

      4'b1100: y = a;
      4'b1101: y = b;

      4'b1110: begin // CMP
        u  = {1'b0,a} + {1'b0,~b} + 5'b00001;
        y  = u[3:0];
        cf = u[4];
        bf = ~u[4];
        vf = (a[3]^b[3]) & (a[3]^y[3]);
      end

      4'b1111: y = 4'b0000;

      default: y = 4'b0000;
    endcase

    zf = (y == 4'b0000);
    sf = y[3];
    pf = ~^y;
  end
endmodule
