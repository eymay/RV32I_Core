import cocotb
from generic_tests import generic_rtype_test

@cocotb.test()
async def add_test(dut):
    await generic_rtype_test(dut, lambda x,y: x+y, "add")

@cocotb.test()
async def sub_test(dut):
    await generic_rtype_test(dut, lambda x,y: x-y, "sub")
#shifts on the value in
#register rs1 by the shift amount held in the lower 5 bits of register rs2
@cocotb.test()
async def sll_test(dut):
    await generic_rtype_test(dut, lambda x,y: x<<y, "sll")

@cocotb.test()
async def slt_test(dut):
    await generic_rtype_test(dut, lambda x,y: 1 if x<y else 0, "slt")

@cocotb.test()
async def sltu_test(dut):
    await generic_rtype_test(dut, lambda x,y: 1 if (x+2**32)<(y+2**32) else 0, "sltu")

@cocotb.test()
async def xor_test(dut):
    await generic_rtype_test(dut, lambda x,y: x^y, "xor")

@cocotb.test()
async def srl_test(dut):
    await generic_rtype_test(dut, lambda x,y: (x % 0x100000000) >> y, "srl")

@cocotb.test()
async def sra_test(dut):
    await generic_rtype_test(dut, lambda x,y: x>>y, "sra")

@cocotb.test()
async def or_test(dut):
    await generic_rtype_test(dut, lambda x,y: x|y, "or")

@cocotb.test()
async def and_test(dut):
    await generic_rtype_test(dut, lambda x,y: x&y, "and")
