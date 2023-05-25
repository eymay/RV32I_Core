import cocotb
from generic_tests import generic_itype_test


@cocotb.test()
async def addi_test(dut):
    await generic_itype_test(dut, lambda x,y: x+y, "addi", debug=False)

@cocotb.test()
async def slti_test(dut):
    await generic_itype_test(dut, lambda x,y: 1 if x<y else 0, "slti")

@cocotb.test()
async def sltiu_test(dut):
    await generic_itype_test(dut, lambda x,y: 1 if (x+2**32)<(y+2**32) else 0, "sltiu")

@cocotb.test()
async def xori_test(dut):
    await generic_itype_test(dut, lambda x,y: x^y, "xori")

@cocotb.test()
async def ori_test(dut):
    await generic_itype_test(dut, lambda x,y: x|y, "ori")

@cocotb.test()
async def andi_test(dut):
    await generic_itype_test(dut, lambda x,y: x&y, "andi")

#shifts on the value in
#register rs1 by the shift amount held in the lower 5 bits of register rs2
@cocotb.test()
async def slli_test(dut):
    await generic_itype_test(dut, lambda x,y: x<<y, "slli")

@cocotb.test()
async def srli_test(dut):
    await generic_itype_test(dut, lambda x,y: (x % 0x100000000) >> y, "srli")

@cocotb.test()
async def srai_test(dut):
    await generic_itype_test(dut, lambda x,y: x>>y, "srai")
