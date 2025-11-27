`timescale 1ns/1ps

// test.tb - fixed testbench for top.v
// Simulates the `top` module for a short time and writes a VCD file (test.vcd).

module test;
    // Testbench clock and DUT wires
    reg clk;
    wire [5:0] led;

    // Instantiate the design under test
    top uut (
        .clk(clk),
        .led(led)
    );

    // Clock generation: use 27 MHz clock
    // Period ~= 37 ns (integer ns)
    localparam integer PERIOD_NS = 1000000000 / 27000000; // ns (integer)
    localparam integer HALF = PERIOD_NS / 2;

    initial begin
        clk = 0;
        forever #(HALF) clk = ~clk;
    end

    // Run simulation for a short time
    initial begin
        $display("Starting simulation at %0t ns", $time);
        $dumpfile("test.vcd");
        $dumpvars(0, test);
        $monitor("%0t ns : clk=%b led=%b", $time, clk, led);

        // 10 us = 10_000 ns
        #10000;

        $display("Ending simulation at %0t ns", $time);
        $finish;
    end

endmodule
