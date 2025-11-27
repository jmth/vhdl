`timescale 1ns/1ps

// test.tsb - simple testbench for top.v
// Simulates the `top` module for 3 seconds and writes a VCD file (test.vcd).

module tb_top;
    // Testbench clock and DUT wires
    reg clk;
    wire [5:0] led;

    // Instantiate the design under test
    top uut (
        .clk(clk),
        .led(led)
    );

    // Clock generation: use 27 MHz clock
    // Period = 1e9 ns / 27e6 = ~37.037037 ns
    real PERIOD_NS = 1000000000.0 / 27000000.0; // ns
    real HALF = PERIOD_NS / 2.0;

    initial begin
        clk = 0;
        forever #(HALF) clk = ~clk;
    end

    // Run simulation for 3 seconds
    initial begin
        $display("Starting simulation at %0t ns", $time);
        $dumpfile("test.vcd");
        $dumpvars(0, tb_top);
        $monitor("%0t ns : clk=%b led=%b", $time, clk, led);

        // 10 us = 10_000 ns
        #10000;

        $display("Ending simulation at %0t ns", $time);
        $finish;
    end

endmodule
