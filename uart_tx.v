module uart_tx(
    input clk,
    input reset,
    input tx_start,
    input [7:0] data_in,

    output reg tx,
    output reg tx_done
);

reg [7:0] data_reg;
reg [3:0] bit_index;

reg [1:0] state;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state <= IDLE;
        tx <= 1'b1;
        tx_done <= 1'b0;
        data_reg <= 8'b0;
        bit_index <= 4'd0;
    end

    else
    begin

        case(state)

        
        // IDLE STATE
       
        IDLE:
        begin
            tx <= 1'b1;
            tx_done <= 1'b0;

            if(tx_start)
            begin
                data_reg <= data_in;
                state <= START;
            end
        end

    
        // START BIT
      
        START:
        begin
            tx <= 1'b0;
            bit_index <= 0;
            state <= DATA;
        end

      
        // DATA BITS
    
        DATA:
        begin

            tx <= data_reg[bit_index];

            if(bit_index == 7)
            begin
                state <= STOP;
            end
            else
            begin
                bit_index <= bit_index + 1;
            end

        end


        // STOP BIT
        STOP:
        begin
            tx <= 1'b1;
            tx_done <= 1'b1;
            state <= IDLE;
        end

        endcase

    end

end

endmodule