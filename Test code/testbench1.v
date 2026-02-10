`timescale 1ns / 1ps
module conv_test;

    parameter integer N = 480;
    parameter integer M = 857;
    parameter integer TOTAL_PIXELS = N*M;

    reg clk;
    reg reset;
    reg [7:0] pxl_in;

    wire signed [15:0] reg_22;
    wire [7:0]         pxl_out;
    wire               valid;

    reg [7:0] image_data [0:TOTAL_PIXELS-1];

    integer file_out;
    integer i;
    integer valid_count;

    conv #(.N(N), .M(M)) uut (
        .clk(clk), .reset(reset), .pixel_in(pxl_in),
        .reg_22(reg_22), .pixel_out(pxl_out), .valid(valid)
    );

    always #10 clk = ~clk;  // 20ns period

    initial begin
        clk = 0;
        reset = 1;
        pxl_in = 0;
        valid_count = 0;

        // init memory to 0
        for (i=0; i<TOTAL_PIXELS; i=i+1) image_data[i] = 8'h00;

        $display("Reading image01.hex...");
        $readmemh("image01.hex", image_data);

        if (^image_data[0] === 1'bX) begin
            $display("image01.hex not loaded (image_data[0]=X). Put file in xsim run dir.");
            $finish;
        end
        $display("image01.hex OK. First=%h Last=%h", image_data[0], image_data[TOTAL_PIXELS-1]);

        file_out = $fopen("output_pixels.hex", "w");
        if (file_out == 0) begin
            $display(" Could not open output_pixels.hex");
            $finish;
        end
        $display("Opened output_pixels.hex handle=%0d", file_out);

        
        repeat (10) @(posedge clk);
        reset <= 0;

        // stream all pixels
        for (i=0; i<TOTAL_PIXELS; i=i+1) begin
            @(posedge clk);
            pxl_in <= image_data[i];
            if ((i % 50000) == 0) $display("Streaming i=%0d time=%t", i, $time);
        end

        
        repeat (2*N + 200) @(posedge clk);

        $display("DONE. valid_count=%0d", valid_count);
        $fclose(file_out);
        $finish;
    end

    
    always @(posedge clk) begin
        if (!reset) begin
            if (valid) begin
                $fwrite(file_out, "%02h\n", pxl_out);
                valid_count <= valid_count + 1;
            end else begin
                $fwrite(file_out, "00\n");
            end
        end
    end

endmodule
