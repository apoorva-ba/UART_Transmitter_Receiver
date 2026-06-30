module uart_rx(

input clk,
input reset,
input rx,

output reg [7:0] data_out,
output reg rx_done

);

reg [7:0] data_reg;
reg [3:0] bit_index;

reg [1:0] state;

parameter IDLE = 2'b00;
parameter DATA = 2'b01;
parameter STOP = 2'b10;

always @(posedge clk or posedge reset)

begin

    if(reset)

    begin

        state <= IDLE;
        data_out <= 8'b0;
        data_reg <= 8'b0;
        bit_index <= 0;
        rx_done <= 0;

    end

    else

    begin

        case(state)

       

        IDLE:

        begin

            rx_done <= 0;

            // Detect Start Bit
            if(rx == 0)

            begin

                bit_index <= 0;
                state <= DATA;

            end

        end

       

        DATA:

        begin

            data_reg[bit_index] <= rx;

            if(bit_index == 7)

                state <= STOP;

            else

                bit_index <= bit_index + 1;

        end

       

        STOP:

        begin

            if(rx == 1)

            begin

                data_out <= data_reg;
                rx_done <= 1;

            end

            state <= IDLE;

        end

        endcase

    end

end

endmodule