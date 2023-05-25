#include <stdio.h>
#include <stdint.h>

uint32_t square( register int32_t n)
{
    // handle negative input
    if (n < 0)
        n = -n;
 
    // Initialize result
    register uint32_t res = n;
 
    // Add n to res n-1 times
    for (register uint32_t i = 1; i < n; i++)
        res += n;
 
    return res;
}

int main() {

    for (int i = -20; i<20; i++) {
        printf("i=%d s=%d\n", i, square(i));
    }
}

/*
square:
        addi    sp,sp,-16
        sw      s0,12(sp)
        sw      s1,8(sp)
        sw      s2,4(sp)
        addi    s0,sp,16
        mv      a5,a0
        bge     a5,zero,.L2
        neg     a5,a5
.L2:
        mv      s2,a5
        li      s1,1
        j       .L3
.L4:
        mv      a4,a5
        add     s2,s2,a4
        addi    s1,s1,1
.L3:
        mv      a4,a5
        bltu    s1,a4,.L4
        mv      a5,s2
        mv      a0,a5
        lw      s0,12(sp)
        lw      s1,8(sp)
        lw      s2,4(sp)
        addi    sp,sp,16
        jr      ra

*/

/*

ff010113 // TODO: dis, llvm ters cikti veriyor le->be 
00812623
00912423
01212223
01010413
00050793
0007d463
40f007b3
00078913
00100493
0100006f
00078713
00e90933
00148493
00078713
fee4e8e3
00090793
00078513
00c12403
00812483
00412903
01010113
00008067

*/

/*

square:
 addi	sp,sp,-16
 sw	s0,12(sp)
 sw	s1,8(sp)
 sw	s2,4(sp)
 addi	s0,sp,16
 mv	a5,a0
 bgez	a5,20 <.L2>
    R_RISCV_BRANCH .L2
 neg	a5,a5
.L2:
 mv	s2,a5
.LBB2:
 li	s1,1
 j	38 <.L3>
    R_RISCV_JAL .L3
.L4:
 mv	a4,a5
 add	s2,s2,a4
 addi	s1,s1,1
.L3:
 mv	a4,a5
 bltu	s1,a4,2c <.L4>
    R_RISCV_BRANCH .L4
.LBE2:
 mv	a5,s2
 mv	a0,a5
 lw	s0,12(sp)
 lw	s1,8(sp)
 lw	s2,4(sp)
 addi	sp,sp,16
 ret
 
*/