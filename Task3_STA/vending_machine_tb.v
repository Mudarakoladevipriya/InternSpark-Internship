`timescale 1ns/1ps

module vending_machine_tb;
    // Inputs
    reg clk;
    reg rst_n;
    reg nickel;
    reg dime;

    // Outputs
    wire dispense;
    wire [1:0] change;

    // Instantiate the Unit Under Test (UUT)
    vending_machine uut (
        .clk(clk),
        .rst_n(rst_n),
        .nickel(nickel),
        .dime(dime),
        .dispense(dispense),
        .change(change)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Waveform dump settings
        $dumpfile("vending_machine_tb.vcd");
        $dumpvars(0, vending_machine_tb);

        // Initialize Inputs
        clk = 0;
        rst_n = 0;
        nickel = 0;
        dime = 0;

        // Apply Reset
        #10;
        rst_n = 1;
        
        // Transaction 1: Insert Nickel (5c)
        #10;
        nickel = 1;
        #10;
        nickel = 0;

        // Transaction 2: Insert Dime (10c)
        #10;
        dime = 1;
        #10;
        dime = 0;

        // Settle states
        #30;
        $finish;
    end
endmodule
