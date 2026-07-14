read_verilog vending_machine.v
hierarchy -top vending_machine
proc; opt; fsm; opt; memory; opt; techmap; opt
dfflibmap -liberty osu018_stdcells.lib
abc -liberty osu018_stdcells.lib
clean
write_verilog vending_machine_synth.v
