`timescale 1ns / 1ps


module shift #(
    parameter integer DEPTH = 480
)(
    input  wire              clk,
    input  wire              reset,
    input  wire signed [15:0] data_in,
    output wire signed [15:0] data_out
);

    reg signed [15:0] line_buffer [0:DEPTH-1];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < DEPTH; i = i + 1)
                line_buffer[i] <= 16'sd0;
        end else begin
            for (i = DEPTH-1; i > 0; i = i - 1)
                line_buffer[i] <= line_buffer[i-1];
            line_buffer[0] <= data_in;
        end
    end

    assign data_out = line_buffer[DEPTH-1];

endmodule
