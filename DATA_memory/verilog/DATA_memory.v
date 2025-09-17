module data_memo
#(
  parameter ADDR_WIDTH = 16,
  parameter MEM_FILE   = ""
)
(
  input clk,
  input rst,
  input ren,
  input wen,
  input [2:0] funct3,
  input [31:0] wdata,
  input [ADDR_WIDTH-1:0] addr,
  output reg [31:0] rdata
);

  localparam MEM_BYTES = (1 << ADDR_WIDTH);
  reg [7:0] mem [0:MEM_BYTES-1];

  // Optional preload from file
  initial begin
    if (MEM_FILE != "") $readmemh(MEM_FILE, mem);
  end

  // ----------------------------
  // WRITE logic (only mem[] changes here)
  // ----------------------------
  always @(posedge clk) begin
    if (wen) begin
      case (funct3)
        3'b000: mem[addr]     <= wdata[7:0];        // SB
        3'b001: begin                                // SH
          mem[addr]     <= wdata[7:0];
          mem[addr + 1] <= wdata[15:8];
        end
        3'b010: begin                                // SW
          mem[addr]     <= wdata[7:0];
          mem[addr + 1] <= wdata[15:8];
          mem[addr + 2] <= wdata[23:16];
          mem[addr + 3] <= wdata[31:24];
        end
      endcase
    end
  end

  // ----------------------------
  // READ logic (only rdata changes here)
  // ----------------------------
  always @(posedge clk) begin
    if (rst) begin
      rdata <= 32'b0;
    end else if (ren) begin
      case (funct3)
        3'b000: rdata <= {{24{mem[addr][7]}}, mem[addr]};                    // LB
        3'b001: rdata <= {{16{mem[addr+1][7]}}, mem[addr+1], mem[addr]};     // LH
        3'b010: rdata <= {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}; // LW
        3'b100: rdata <= {24'b0, mem[addr]};                                 // LBU
        3'b101: rdata <= {16'b0, mem[addr+1], mem[addr]};                    // LHU
        default: rdata <= {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
      endcase
    end
  end

endmodule
