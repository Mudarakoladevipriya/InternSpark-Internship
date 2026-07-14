module vending_machine (
    input wire clk,
    input wire rst_n,
    input wire nickel,    // 5 cents
    input wire dime,      // 10 cents
    output reg dispense,  // Item dispensed
    output reg [1:0] change // 00=0c, 01=5c, 10=10c
);

    parameter S_0  = 3'b000,
              S_5  = 3'b001,
              S_10 = 3'b010,
              S_15 = 3'b011,
              S_20 = 3'b100;

    reg [2:0] current_state, next_state;

    // State Transition Logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S_0;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            S_0: begin
                if (dime)       next_state = S_10;
                else if (nickel) next_state = S_5;
                else            next_state = S_0;
            end
            S_5: begin
                if (dime)       next_state = S_15;
                else if (nickel) next_state = S_10;
                else            next_state = S_5;
            end
            S_10: begin
                if (dime)       next_state = S_20;
                else if (nickel) next_state = S_15;
                else            next_state = S_10;
            end
            S_15:               next_state = S_0;
            S_20:               next_state = S_0;
            default:            next_state = S_0;
        endcase
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            S_15: begin
                dispense = 1'b1;
                change   = 2'b00;
            end
            S_20: begin
                dispense = 1'b1;
                change   = 2'b01;
            end
            default: begin
                dispense = 1'b0;
                change   = 2'b00;
            end
        endcase
    end
endmodule
