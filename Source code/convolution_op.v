`timescale 1ns / 1ps
module conv #(
    parameter integer N = 480,
    parameter integer M = 857
)(
    input  wire        clk,
    input  wire        reset,
    input  wire [7:0]  pixel_in,
    output wire signed [15:0] reg_22,
    output reg  [7:0]  pixel_out,
    output wire        valid
);

    // Pipeline signals
    wire signed [15:0] wire_00, wire_01, wire_02;
    wire signed [15:0] wire_10, wire_11, wire_12;
    wire signed [15:0] wire_20, wire_21, wire_22;

    wire signed [15:0] reg_00, reg_01, reg_02;
    wire signed [15:0] reg_10, reg_11, reg_12;
    wire signed [15:0] reg_20, reg_21;

    wire signed [15:0] sr_0, sr_1;

    localparam signed [7:0] K00 = -1, K01 =  0, K02 =  1;
    localparam signed [7:0] K10 = -2, K11 =  0, K12 =  2;
    localparam signed [7:0] K20 = -1, K21 =  0, K22 =  1;

    mac mac_00(.in(pixel_in), .w(K00), .b(16'sd0), .out(wire_00));
    pipe_reg16 r_00(.clk(clk), .reset(reset), .d(wire_00), .q(reg_00));

    mac mac_01(.in(pixel_in), .w(K01), .b(reg_00), .out(wire_01));
    pipe_reg16 r_01(.clk(clk), .reset(reset), .d(wire_01), .q(reg_01));

    mac mac_02(.in(pixel_in), .w(K02), .b(reg_01), .out(wire_02));
    pipe_reg16 r_02(.clk(clk), .reset(reset), .d(wire_02), .q(reg_02));

    shift #(.DEPTH(N)) row_1(.clk(clk), .reset(reset), .data_in(reg_02), .data_out(sr_0));

    mac mac_10(.in(pixel_in), .w(K10), .b(sr_0), .out(wire_10));
    pipe_reg16 r_10(.clk(clk), .reset(reset), .d(wire_10), .q(reg_10));

    mac mac_11(.in(pixel_in), .w(K11), .b(reg_10), .out(wire_11));
    pipe_reg16 r_11(.clk(clk), .reset(reset), .d(wire_11), .q(reg_11));

    mac mac_12(.in(pixel_in), .w(K12), .b(reg_11), .out(wire_12));
    pipe_reg16 r_12(.clk(clk), .reset(reset), .d(wire_12), .q(reg_12));

    shift #(.DEPTH(N)) row_2(.clk(clk), .reset(reset), .data_in(reg_12), .data_out(sr_1));

    mac mac_20(.in(pixel_in), .w(K20), .b(sr_1), .out(wire_20));
    pipe_reg16 r_20(.clk(clk), .reset(reset), .d(wire_20), .q(reg_20));

    mac mac_21(.in(pixel_in), .w(K21), .b(reg_20), .out(wire_21));
    pipe_reg16 r_21(.clk(clk), .reset(reset), .d(wire_21), .q(reg_21));

    mac mac_22(.in(pixel_in), .w(K22), .b(reg_21), .out(wire_22));
    pipe_reg16 r_22(.clk(clk), .reset(reset), .d(wire_22), .q(reg_22));

    // Magnitude + saturation
    reg [15:0] abs_val;
    always @(*) begin
        abs_val  = reg_22[15] ? (~reg_22 + 16'd1) : reg_22;
        pixel_out = (abs_val > 16'd255) ? 8'hFF : abs_val[7:0];
    end

    
    // latency = 2*N (two line buffers) + 9 (3 regs/row * 3 rows) = 969 cycles
    localparam integer PIPE_LAT = 969;

    reg [31:0] col, row;
    reg        in_region;

    // shift register delay for in_region
    reg [PIPE_LAT:0] vpipe;

    always @(posedge clk) begin
        if (reset) begin
            col <= 0; row <= 0;
            in_region <= 1'b0;
            vpipe <= { (PIPE_LAT+1){1'b0} };
        end else begin
            // Update position for incoming stream (1 pixel/clk)
            if (col == N-1) begin
                col <= 0;
                if (row != M-1) row <= row + 1;
            end else begin
                col <= col + 1;
            end

            // valid region for 3x3 window on input
            in_region <= (row >= 2) && (col >= 2);

            // delay to align with output
            vpipe <= {vpipe[PIPE_LAT-1:0], in_region};
        end
    end

    assign valid = vpipe[PIPE_LAT];

endmodule
