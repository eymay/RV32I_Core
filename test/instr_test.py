import glob
from cocotb_test.simulator import run
import pytest
import os

tests_dir = os.path.dirname(__file__)

txtfiles = []
for file in glob.glob(os.path.join(tests_dir, "../src/*.v")):
    txtfiles.append(file)
#for file in glob.glob(os.path.join(tests_dir, "../src/*.sv")):
#    txtfiles.append(file)
@pytest.mark.skipif(os.getenv("SIM") == "ghdl", reason="Verilog not suported")
# @pytest.mark.parametrize("seed", range(10))
def unit_test_instr_verilog():
    run(verilog_sources=txtfiles, 
        work_dir=os.path.join(tests_dir, "cocotb"),
        toplevel="ALU_system",
        module="unit_test_instrs", waves=True)  # sources  # top level HDL  # name of cocotb test module

if __name__ == "__main__":
    unit_test_instr_verilog()
