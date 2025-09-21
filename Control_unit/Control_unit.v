module control_unit
  (
    input [6:0] opcode,
    output reg Regwrite,
    output reg ALUsrc,
    output reg Memread,
    output reg Memwrite,
    output reg Memtoreg,
    output reg Branch,
    output reg Jump,
    output reg [1:0] ALUop
  );
  
  always @(*) begin
    case (opcode)
      7'b0110011: begin  // R-type
        Regwrite = 1;
        ALUsrc   = 0;
        Memread  = 0;
        Memwrite = 0;
        Memtoreg = 0;
        Branch   = 0;
        Jump     = 0;
        ALUop    = 2'b10;
      end
      
      7'b0010011: begin  // I-type
        Regwrite = 1;
        ALUsrc   = 1;
        Memread  = 0;
        Memwrite = 0;
        Memtoreg = 0;
        Branch   = 0;
        Jump     = 0;
        ALUop    = 2'b11;
      end
      
      7'b0000011: begin  // load
        Regwrite = 1;
        ALUsrc   = 1;
        Memread  = 1;
        Memwrite = 0;
        Memtoreg = 1;
        Branch   = 0;
        Jump     = 0;
        ALUop    = 2'b00;
      end
      
      7'b0100011: begin // store
        Regwrite = 0;
        ALUsrc   = 1;
        Memread  = 0;
        Memwrite = 1;
        Memtoreg = 0;
        Branch   = 0;
        Jump     = 0;
        ALUop    = 2'b00;
      end
      
      7'b1100011: begin // branch
        Regwrite = 0;
        ALUsrc   = 0;
        Memread  = 0;
        Memwrite = 0;
        Memtoreg = 0;
        Branch   = 1;
        Jump     = 0;
        ALUop    = 2'b01;
      end
      
      7'b1101111: begin // Jal
        Regwrite = 1;
        ALUsrc   = 0;
        Memread  = 0;
        Memwrite = 0;
        Memtoreg = 0;
        Branch   = 0;
        Jump     = 1;
        ALUop    = 2'b00;
      end
      
      7'b1100111: begin // Jalr
        Regwrite = 1;
        ALUsrc   = 1;
        Memread  = 0;
        Memwrite = 0;
        Memtoreg = 0;
        Branch   = 0;
        Jump     = 1;
        ALUop    = 2'b00;
      end
      
      default: begin 
        Regwrite = 0;
        ALUsrc   = 0;
        Memread  = 0;
        Memwrite = 0;
        Memtoreg = 0;
        Branch   = 0;
        Jump     = 0;
        ALUop    = 2'b00;
      end
    endcase
  end 
endmodule
