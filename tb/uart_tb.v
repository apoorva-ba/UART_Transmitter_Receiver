`timescale 1ns/1ps

module uart_tx_tb;

// Inputs
reg clk;
reg reset;
reg tx_start;
reg [7:0] data_in;

// Outputs
wire tx;
wire tx_done;

// Instantiate UART Transmitter
uart_tx uut (
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .data_in(data_in),
    .tx(tx),
    .tx_done(tx_done)
);


always #5 clk = ~clk;


initial
begin

    // Initialize signals
    clk = 0;
    reset = 1;
    tx_start = 0;
    data_in = 8'b00000000;

    // Hold reset
    #20;

    // Release reset
    reset = 0;

    // Wait for some time
    #10;

    // Load data
    data_in = 8'b11001010;

    // Start transmission
    tx_start = 1;

    #10;

    // Remove start signal
    tx_start = 0;

    // Wait until transmission completes
    #120;

    $finish;

end

// Display Results
initial
begin

    $display("Time\tclk\treset\ttx_start\tTX\tDone");

    $monitor("%0t\t%b\t%b\t%b\t\t%b\t%b",
              $time, clk, reset, tx_start, tx, tx_done);

end

// Dump waveform
initial
begin
    $dumpfile("uart_tx.vcd");
    $dumpvars(0, uart_tx_tb);
end

endmodule