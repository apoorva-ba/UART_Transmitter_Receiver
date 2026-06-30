module uart_top(

input clk,
input reset,
input tx_start,
input [7:0] data_in,

output [7:0] data_out,
output tx_done,
output rx_done

);

// Internal wire connecting TX to RX
wire tx_wire;

// UART Transmitter
uart_tx transmitter(

    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .data_in(data_in),
    .tx(tx_wire),
    .tx_done(tx_done)

);

// UART Receiver
uart_rx receiver(

    .clk(clk),
    .reset(reset),
    .rx(tx_wire),
    .data_out(data_out),
    .rx_done(rx_done)

);

endmodule