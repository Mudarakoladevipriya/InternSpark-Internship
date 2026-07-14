#!/bin/bash 

# Step 1: Compile RTL and Testbench using Verilator 
verilator --binary -j 0 -Wall vending_machine.v vending_machine_tb.v --top vending_machine_tb --timing --trace -CFLAGS "-std=c++20" 

# Step 2: Build directory 
cd obj_dir || { echo "Error: obj_dir not found"; exit 1; } 

# Step 3: Build simulation executable 
make -f Vvending_machine_tb.mk Vvending_machine_tb || { echo "Error: Compilation failed"; exit 1; } 

# Step 4: Run simulation and move VCD to main folder
./Vvending_machine_tb || { echo "Error: Simulation failed"; exit 1; } 
mv vending_machine_tb.vcd ..

# Step 5: Open waveform 
cd ..
gtkwave vending_machine_tb.vcd &
