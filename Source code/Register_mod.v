`timescale 1ns / 1ps


module pipe_reg16(
    input  wire              clk,
    input  wire              reset,
    input  wire signed [15:0] d,
    output reg  signed [15:0] q
);
always @(posedge clk) begin
    if (reset) q <= 16'sd0;
    else       q <= d;
end
endmodule
