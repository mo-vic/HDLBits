module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    // Use FSM from Fsm_serial
    parameter IDLE = 4'h0, START = 4'h1, FIRST = 4'h2, SECOND = 4'h3, 
            THIRD = 4'h4, FOURTH = 4'h5, FIFTH = 4'h6, SIXTH = 4'h7, 
            SEVENTH = 4'h8, EIGHTH = 4'h9, PARITY = 4'ha, STOP = 4'hb, WAIT = 4'hc;
    
    reg [3:0] state, next_state;
    reg odd;
    
    always @(*) begin
        case (state)
            IDLE: next_state <= in ? IDLE : START;
            START: next_state <= FIRST;
            FIRST: next_state <= SECOND;
            SECOND: next_state <= THIRD;
            THIRD: next_state <= FOURTH;
            FOURTH: next_state <= FIFTH;
            FIFTH: next_state <= SIXTH;
            SIXTH: next_state <= SEVENTH;
            SEVENTH: next_state <= EIGHTH;
            EIGHTH: next_state <= PARITY;
            PARITY: next_state <= in ? STOP : WAIT;
            STOP: next_state <= in ? IDLE : START;
            WAIT: next_state <= in ? IDLE : WAIT;
            default: next_state <= state;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    assign done = ~|(state ^ STOP) & ~odd;

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        out_byte <= (|(state ^ EIGHTH) & |(state ^ PARITY)) ? {in, out_byte[7:1]} : out_byte;
    end

    // New: Add parity checking.
    parity(.clk(clk), .reset(~|(next_state ^ START)), .in(in), .odd(odd));

endmodule
