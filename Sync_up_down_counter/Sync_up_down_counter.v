module Sync_up_down(
    input clk,
    input in,        // 0 → up, 1 → down
    input rst,
    output reg [7:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst) 
        count <= 8'b00000000;  // reset to 0
    else begin
        case (in)
            1'b0: begin // UP
                if (count < 8'b11111111)
                    count <= count + 1;
                else
                    count <= 8'b00000000; // wrap around
            end
            1'b1: begin // DOWN
                if (count > 8'b00000000)
                    count <= count - 1;
                else
                    count <= 8'b11111111; // wrap around
            end
            default: count <= 8'b00000000;
        endcase
    end
end

endmodule

