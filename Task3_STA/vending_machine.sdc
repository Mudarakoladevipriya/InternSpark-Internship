create_clock -period 10 -name clk [get_ports clk]
set_input_delay 2.5 -min -rise [get_ports {nickel dime}] -clock clk
set_input_delay 4.5 -max -fall [get_ports {nickel dime}] -clock clk
set_input_transition 0.5 -min -rise [get_ports {nickel dime}] -clock clk
set_input_transition 1.5 -max -fall [get_ports clk] -clock clk
set_load -pin_load 4 [get_ports {dispense change}]
set_output_delay 2 -min -rise [get_ports {dispense change}] -clock clk
