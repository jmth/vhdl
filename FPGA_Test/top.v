// top.v - simple LED counter for FPGA
// Assumptions:
// - The board provides a clock input named `clk` (map your actual clock pin in the .cst file)
// - The LED pins are exposed as an 8-bit bus named `led` (map these signal names to board pins in io_tangnano9k.cst)
// If your .cst uses different signal names (for example LED0..LED7), either rename the
// outputs here or change the pin names in the .cst to match `led[0]`..`led[7]`.

module top (
    input  clk,            // external clock (map this pin in .cst)
    output [5:0] led       // 6 LEDs (led[0] is LSB, led[5] is MSB)
);

    // 6-bit free-running counter. It counts 0..63 and directly drives the 6 LEDs.
    // Note: counting on every FPGA clock edge may be very fast; this matches your
    // request to make the counter 6 bits only. If you want visible slow blinking,
    // either feed a slower clock or add a wider prescaler.

    // Use a wider counter for slower blinking (24 bits => bits 23 downto 0)
    localparam COUNTER_WIDTH = 8;
    reg [COUNTER_WIDTH-1:0] counter = 0;

    always @(posedge clk) begin
        counter <= counter + 1'b1;
    end

    // Directly present the counter on the LED pins
    // Use the top 6 bits of the counter. previous code referenced bit 24 which is out of range
    // for a 24-bit counter (0..23). Use COUNTER_WIDTH-1 downto COUNTER_WIDTH-6 instead.
    assign led[5:0] = counter[COUNTER_WIDTH-1:COUNTER_WIDTH-6]; // upper 6 bits for visible blinking

endmodule
