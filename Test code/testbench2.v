`timescale 1ns / 1ps

module shift_testbench;

    // Inputs
    reg clk;
    reg [15:0] data_in;
    
    // Outputs
    wire [15:0] data_out;
    
    // Parameter for Testing: 
    // We override the 480 depth with a smaller number (e.g., 5) 
    // just to verify the shifting logic works correctly.
    parameter TEST_DEPTH = 5;

    // Instantiate the Unit Under Test (UUT)
    // Using named association and parameter overriding
    shift #(.DEPTH(TEST_DEPTH)) uut (
        .clk(clk),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    // Clock generation: 10ns high, 10ns low = 50MHz
    always #10 clk = ~clk;

    integer i;

    initial begin
        // Initialize Inputs
        clk = 0;
        data_in = 0;

        // Wait for global reset
        #100;
        
        // Feed data into the shift register
        // We will feed more values than the depth to see data come out
        for (i = 1; i <= 10; i = i + 1) begin
            @(posedge clk);
            data_in <= i * 10; // Input: 10, 20, 30, 40...
            $display("Time: %t | In: %d | Out: %d", $time, data_in, data_out);
        end

        // Wait a few more cycles to observe the final values exiting
        repeat (TEST_DEPTH) @(posedge clk);
        
        $display("Simulation Complete.");
        $finish;
    end
      
endmodule