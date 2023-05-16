# RV32I Core

## Designing Control Word
### Control Signals
|5|4|3|2|1|0|
|-|-|-|-|-|-|
| s_inc_imm_i_PC| s_reg_imm_ALU_B| s_ALU_dmem_wregdata| sig_w_ctrl_reg|  sig_r_ctrl_data_mem|  sig_w_ctrl_data_mem |
| PC Select| ALU B Select| Data Mem - ALU Select| Regfile Write |  Data Mem Read|  Data Mem Write |


### Control Word Encoding Table

### Explanations to the Design of Control Words



## Forming the Datapath

### Control Words for Left to Right Modular Multiplication

### Simulation for the Example Program

### Simulation with Different Inputs


## Designing Instruction Decoder
Due to careful selection of control signals in relation to their bit position in instruction word, there is no
Instruction Decoder needed for this project. It can be seen that the bundles of instruction memory outputs are feed to FU, Regfile and so on.


## Program Counter

### Design of Branch Controller
TODO

### Design of PC Module

### Synthesis of PC 

### Post-Synthesis Simulation of PC


## Design of Control Unit

### Integration of PC and ID

### Synthesis of CU

### Simulation of the Example Program

### Post-Synthesis Simulation of CU
