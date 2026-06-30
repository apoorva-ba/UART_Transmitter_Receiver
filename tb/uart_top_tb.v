`timescale 1ns/1ps

module uart_top_tb;

// Inputs
reg clk;
reg reset;
reg tx_start;
reg [7:0] data_in;

// Outputs
wire [7:0] data_out;
wire tx_done;
wire rx_done;

// Instantiate UART Top Module
uart_top uut (
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .data_in(data_in),
    .data_out(data_out),
    .tx_done(tx_done),
    .rx_done(rx_done)
);

// Clock Generation (10 ns period)
always #5 clk = ~clk;

// Test Sequence
initial
begin
    // Initialize
    clk = 0;
    reset = 1;
    tx_start = 0;
    data_in = 8'h00;

    // Hold reset
    #20;
    reset = 0;

    // Wait
    #20;

    // Load data
    data_in = 8'hCA;

    // Start transmission
    tx_start = 1;

    #10;
    tx_start = 0;

    // Wait for TX and RX to complete
    #150;

    // Display Result
    if(data_out == 8'hCA)
begin
        $display("========================================");
        $display("TEST PASSED");
        $display("Received Data = %h", data_out);
        $display("========================================");
end
    else
begin
        $display("========================================");
        $display("TEST FAILED");
        $display("Received Data = %h", data_out);
        $display("========================================");
end

    $finish;
end

// Monitor Signals
initial
begin
    $monitor("Time=%0t Reset=%b TX_Start=%b Data_In=%h Data_Out=%h TX_Done=%b RX_Done=%b",
              $time, reset, tx_start, data_in, data_out, tx_done, rx_done);
end

// Generate Waveform
initial
begin
    $dumpfile("uart_top.vcd");
    $dumpvars(0, uart_top_tb);
end

endmodule