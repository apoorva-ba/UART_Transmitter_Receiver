`timescale 1ns/1ps

module uart_rx_tb;

// Inputs
reg clk;
reg reset;
reg rx;

// Outputs
wire [7:0] data_out;
wire rx_done;

// Instantiate Receiver
uart_rx uut(
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .data_out(data_out),
    .rx_done(rx_done)
);

// Clock Generation
always #5 clk = ~clk;

// Test Procedure
initial
begin

    clk = 0;
    reset = 1;
    rx = 1;          // UART line is idle HIGH

    #20;
    reset = 0;

    #10;

    // Start Bit
    rx = 0;

    // Data = 8'b11001010
    // UART sends LSB first

    #10 rx = 0;   // D0
    #10 rx = 1;   // D1
    #10 rx = 0;   // D2
    #10 rx = 1;   // D3
    #10 rx = 0;   // D4
    #10 rx = 0;   // D5
    #10 rx = 1;   // D6
    #10 rx = 1;   // D7

    // Stop Bit
    #10 rx = 1;

    #30;

    $finish;

end

// Monitor Output
initial
begin

    $display("Time\tRX\tData_Out\tRX_Done");

    $monitor("%0t\t%b\t%h\t\t%b",
             $time, rx, data_out, rx_done);

end

// Dump Waveform
initial
begin
    $dumpfile("uart_rx.vcd");
    $dumpvars(0, uart_rx_tb);
end

endmodule