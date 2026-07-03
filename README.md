<div align="center">
  <h1>4-Bit Counter Formal Verification</h1>
  <p><strong>A complete Cadence JasperGold Formal Verification setup for a 4-bit synchronous counter.</strong></p>
</div>

---

## 📌 Overview
This repository serves as a practical demonstration of **Formal Verification (FV)** applied to RTL design. It features a simple 4-bit synchronous up-counter written in SystemVerilog, verified against mathematical properties using **Cadence JasperGold**.

This project proves the core functionality of the counter (reset, count, and hold behaviors) without relying on traditional dynamic simulation or testbenches.

## 📁 Repository Structure
```text
├── counter.sv           # RTL Design: 4-bit up-counter
├── counter_props.sv     # SystemVerilog Assertions (SVA) properties
├── run_jg.tcl           # JasperGold TCL automation script
├── Makefile             # Make targets for running the proof
└── logs/                # JasperGold execution logs and coverage reports
```

## 🛠️ Verification Plan
The verification environment utilizes SVA bounds to the RTL design. The following properties are mathematically proven by the formal engine:

| Property Name | Type | Description | Result |
| :--- | :---: | :--- | :---: |
| `a_reset` | Assert | Verifies that activating the asynchronous reset immediately clears the counter to `4'b0000`. | ✅ Proven |
| `a_count` | Assert | Verifies that when `en` is HIGH, the counter increments by exactly 1 on the next clock edge. | ✅ Proven |
| `a_hold` | Assert | Verifies that when `en` is LOW, the counter retains its previous value on the next clock edge. | ✅ Proven |

## 🚀 Running the Verification

You need access to Cadence JasperGold to run the proofs. A `Makefile` is provided for convenience.

```bash
# 1. Clean previous JasperGold databases and logs
make clean

# 2. Run the proof silently in batch mode
make prove

# 3. Open the JasperGold GUI for debugging and visual analysis
make gui
```

## 🧠 Technical Deep-Dive: Formal Reset Phase
By default, JasperGold sets a global reset expression and evaluates properties only *after* the reset sequence is complete. This makes any assertion precondition that relies on an active reset (e.g., `!rst_n`) inherently **unreachable** during the standard proof phase, leading to vacuous passes.

### The Fix
To ensure the reset property is actively covered and not vacuous, this project utilizes the `reset -formal` TCL command:
```tcl
reset -formal {rst_n == 1'b0} -bound 1
```
This forces JasperGold to execute the reset sequence *during* the formal analysis phase, ensuring that assertions are checked and the reset precondition is fully **covered**.

## 📄 Logs & Reports
All properties have been formally proven and covered. You can view the raw proof logs and coverage matrices in the [`logs/`](logs/) directory.
