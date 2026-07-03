# Clear previous session data
clear -all

# Analyze the design and properties files
analyze -sv counter.sv counter_props.sv

# Elaborate the top-level module
elaborate -top counter

# Setup clocks and resets for the formal engine
clock clk
reset -formal {rst_n == 1'b0} -bound 1

# Prove all assertions in the design
prove -all

# Report the results
report
