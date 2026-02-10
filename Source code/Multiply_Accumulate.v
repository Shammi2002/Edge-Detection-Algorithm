`timescale 1ns / 1ps

module mac(
    input  wire [7:0]         in,   // unsigned pixel
    input  wire signed [7:0]   w,    // signed weight
    input  wire signed [15:0]  b,    // signed accumulator
    output wire signed [15:0]  out
);
    wire signed [15:0] mult;

    
    assign mult = $signed({1'b0, in}) * w;

    assign out  = mult + b;
endmodule
