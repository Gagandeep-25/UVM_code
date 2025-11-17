# UVM Code Repository

## Overview

This repository contains **Universal Verification Methodology (UVM)** code examples and components for SystemVerilog testbench development. It serves as a reference library for UVM-based verification environments and reusable verification components.

## Contents

### UVM Components
- UVM testbenches for various DUTs
- UVM base class extensions
- Reusable transaction classes
- Coverage and scoring implementations
- Sequence libraries

### Features

- **Modular Design:** Reusable UVM components
- **Scalable Architecture:** Easy to extend for new projects
- **Best Practices:** Following UVM methodology guidelines
- **Documentation:** Well-commented code
- **Examples:** Complete working examples

## UVM Hierarchy

Each testbench follows standard UVM hierarchy:
```
uvm_top
├── env
│   ├── agent
│   │   ├── driver
│   │   ├── monitor
│   │   └── sequencer
│   |
│   ├── scoreboard
│   └── coverage
├── sequences
└── test
```

## Key UVM Concepts Covered

1. **UVM Components:**
   - uvm_driver
   - uvm_monitor
   - uvm_sequencer
   - uvm_agent
   - uvm_env
   - uvm_test

2. **UVM Transactions:**
   - Transaction objects
   - Randomization
   - Constraints

3. **Verification Features:**
   - Scoreboarding
   - Functional coverage
   - Error checking
   - Report generation

## Getting Started

### Prerequisites
- SystemVerilog simulator (ModelSim, Questa, VCS, etc.)
- UVM libraries (included with simulator)
- Verilog design files (DUT)

### Running Simulations

```bash
vlog -sv <DUT_files> <TB_files>
vsim -L work -L uvm_lib <testbench_top>
run -all
```

## Repository Structure

- **Components:** Reusable UVM components
- **Tests:** Test cases and scenarios
- **Sequences:** Transaction sequences
- **Examples:** Complete working examples

## Verification Flow

1. **Test Setup:** Initialize test environment
2. **Stimulus Generation:** Create transactions via sequences
3. **DUT Execution:** Apply stimulus to DUT
4. **Result Collection:** Monitor DUT outputs
5. **Scoring:** Compare expected vs actual
6. **Coverage Analysis:** Collect coverage metrics
7. **Reporting:** Generate final report

## Learning Resources

- UVM Class Reference Manual
- UVM User's Guide
- IEEE 1800-2017 SystemVerilog Standard
- Verification Academy (accellera.org)

## License

MIT License

## Author

Gagandeep-25
