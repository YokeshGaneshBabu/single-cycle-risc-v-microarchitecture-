# single-cycle-risc-v-microarchitecture-
This repository contains a fully–functional **single-cycle RISC-V processor** implemented in **Verilog HDL**, along with complete testbenches for every module.  
The project demonstrates RTL design, modular architecture, CPU datapath construction, and verification — suitable for both **ASIC** and **FPGA** learning tracks.

---

## 📁 Project Structure
<pre>
modules/
│
├── ALU.v
├── ALUControl.v
├── branch_unit.v
├── control_unit.v
├── data_mem.v
├── imm_gen.v
├── instr_mem.v
├── pc_reg.v
├── regfile.v
├── riscv_cpu.v
testbenches/
│
├── tb_ALU.v
├── tb_ALUControl.v
├── tb_branch_unit.v
├── tb_control_unit.v
├── tb_data_mem.v
├── tb_imm_gen.v
├── tb_instr_mem.v
├── tb_pc_reg.v
├── tb_regfile.v
└── tb_riscv_cpu.v
</pre>

---

## 🚀 Features

### ✔️ Fully Modular RISC-V CPU
- Implements core **RV32I ISA**
- Supports:
  - Arithmetic & logical ops  
  - Load/store  
  - Branching  
  - Immediate instructions  

### ✔️ Clean, Hierarchical Design  
Each processor block is separated for easy debugging & reuse.

### ✔️ Complete Testbench Suite  
Every RTL module includes a dedicated testbench.

### ✔️ Synthesizable for FPGA/ASIC  
RTL is clean and hardware–friendly.

---

## 🧩 Module Overview

### **riscv_cpu.v**
Top-level RISC-V single-cycle processor.

### **instr_mem.v**
Read-only instruction memory.

### **data_mem.v**
Implements load/store memory.

### **regfile.v**
32×32 register file with two read ports & one write port.

### **ALU.v**
Performs arithmetic and logical operations.

### **ALUControl.v**
Maps instruction function fields to ALU operations.

### **control_unit.v**
Generates control signals based on opcode.

### **branch_unit.v**
Evaluates `beq`, `bne`, etc.

### **imm_gen.v**
Generates immediates for I/S/B formats.

### **pc_reg.v**
Program counter register.

---

## 🧪 Testbenches

Each `tb_*.v` file validates its corresponding module:
- ALU ops  
- Branch decisions  
- Register file read/write  
- Immediate generation  
- Data + instruction memory  
- Full CPU execution flow  

Run `tb_riscv_cpu.v` for top-level integration testing.

---

## ▶️ How to Run (Simulation)

### **ModelSim / QuestaSim**
vlib work
vlog *.v
vsim tb_riscv_cpu
add wave *
run -all

### **Icarus Verilog**

iverilog -o cpu_tb tb_riscv_cpu.v *.v
./cpu_tb


---

## 📦 Future Improvements
- Add pipelining (5-stage)  
- Add hazard detection & data forwarding  
- Add instruction + data cache  
- Support RV32IM extensions  

---

## 👤 Author
Designed and implemented as part of an **ASIC design project**.  


