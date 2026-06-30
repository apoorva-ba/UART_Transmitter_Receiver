# UART_Transmitter_Receiver
UART Transmitter &amp; Receiver in Verilog HDL with FSM-based design, simulation testbench, and waveform verification.

## Overview

This project implements a Universal Asynchronous Receiver Transmitter (UART) using Verilog HDL. The design includes both UART Transmitter and UART Receiver modules, integrated through a top-level module. The transmitter converts 8-bit parallel data into serial data, while the receiver reconstructs the original 8-bit data from the serial stream. The project is verified using separate testbenches and waveform analysis.

---

## Features

- UART Transmitter (TX)
- UART Receiver (RX)
- Top-level UART integration
- Finite State Machine (FSM) based design
- 8-bit data transmission
- Start and Stop bit implementation
- Separate testbenches for TX, RX, and Top Module
- Waveform verification using simulation


## UART Frame Format


 ---------------------------------------------------------
| Start Bit | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop |
 ---------------------------------------------------------
      0        LSB -------------------------------> MSB    1


UART transmits data serially with:

- 1 Start Bit
- 8 Data Bits
- 1 Stop Bit


## Block Diagram

```
          +------------------+
          |  UART TX Module  |
Data In -->                  |
          +------------------+
                   |
                   | TX
                   |
          +------------------+
          |  UART RX Module  |
          +------------------+
                   |
                   |
                Data Out
```

---

### UART Transmitter

1. Waits in the IDLE state.
2. Detects the `tx_start` signal.
3. Sends a Start Bit (`0`).
4. Transmits 8 data bits serially (LSB first).
5. Sends a Stop Bit (`1`).
6. Asserts `tx_done`.

---

### UART Receiver

1. Waits for the Start Bit.
2. Detects serial input.
3. Receives 8 bits serially.
4. Stores received bits into a register.
5. Detects the Stop Bit.
6. Outputs the received byte and asserts `rx_done`.

---

## Finite State Machines

### UART Transmitter

```
IDLE
  │
  ▼
START
  │
  ▼
DATA
  │
  ▼
STOP
  │
  ▼
IDLE
```


### UART Receiver

```
IDLE
  │
  ▼
DATA
  │
  ▼
STOP
  │
  ▼
IDLE
```

---

## Learning Outcomes

Through this project, I learned:

- UART communication protocol
- Serial data transmission and reception
- Finite State Machine (FSM) design
- Verilog HDL coding
- Testbench development
- Waveform analysis
- RTL design methodology

---

## Author
- Apoorva B A
- ECE Student
