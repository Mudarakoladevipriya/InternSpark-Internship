#!/bin/bash

# Step 1: Run Verilator to generate simulation files
verilator --binary -j 0 -Wall alu8_netlist.v osu018_verilator_cells.v alu8_tb.v \
  --top-module alu8_tb --timing \
  -CFLAGS "-std=c++20 -fcoroutines" --trace

# Step 2: Move into the compilation directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }

# Step 3: Build the application using make
make -f Valu8_tb.mk Valu8_tb || { echo "Compilation failed"; exit 1; }

# Step 4: Execute the simulation binary
./Valu8_tb || { echo "Simulation failed"; exit 1; }

# Step 5: View the results using GTKWave
gtkwave alu8_waves.vcd
