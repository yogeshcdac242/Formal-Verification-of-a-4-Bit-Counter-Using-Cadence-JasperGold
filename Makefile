# Makefile for Formal Verification using JasperGold

# Variables
TCL_SCRIPT = run_jg.tcl
JG_BIN = jaspergold

.PHONY: all prove gui clean

# Default target runs batch mode
all: prove

# Target to run formal verification in batch mode (no GUI)
prove:
	$(JG_BIN) -batch $(TCL_SCRIPT)

# Target to open JasperGold in GUI mode with the script
gui:
	$(JG_BIN) $(TCL_SCRIPT) &

# Target to clean up generated log files and directories
clean:
	rm -rf jgproject jg.log *~
