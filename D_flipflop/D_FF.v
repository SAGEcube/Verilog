module D_FF(
  output reg q,
  output reg qn,
  input clk,
  input d
);

  always @(posedge clk) begin
    q  <= d;
    qn <= ~d;
  end

endmodule
