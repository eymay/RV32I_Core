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
        addi    x2,x2,-16
        sw      x8,12(x2)
        sw      x9,8(x2)
        sw      x18,4(x2)
        addi    x8,x2,16
        mv      x15,x10
        bge     x15,zero,.L2
        neg     x15,x15
.L2:
        mv      x18,x15
        li      x9,1
        j       .L3
.L4:
        mv      x14,x15
        add     x18,x18,x14
        addi    x9,x9,1
.L3:
        mv      x14,x15
        bltu    x9,x14,.L4
        mv      x15,x18
        mv      x10,x15
        lw      x8,12(x2)
        lw      x9,8(x2)
        lw      x18,4(x2)
        addi    x2,x2,16
        jr      x1

*/

/*

ff010113
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




/* same thing but with regular register notation

square:
        addi    x2, x2, -16            ff010113                
        sw      x8, 12(x2)             00812623                
        sw      x9, 8(x2)              00912423                
        sw      x18, 4(x2)             01212223                
        addi    x8, x2, 16             01010413                
        addi    x15, x10, 0            00050793               
        bge     x15, x0, .L2           0007d463                   
        sub     x15, 0,  x15           40f007b3                
.L2:                                                                 
        addi    x18, x15 , 0           00078913                   
        addi    x9, x0,  1             00100493               
        jal     x0, .L3                0100006f            
.L4:                                                                               
        addi    x14, x15, 0            00078713                              
        add     x18, x18, x14          00e90933                  
        addi    x9, x9, 1              00148493              
.L3:                                                                               
        addi    x14, x15, 0            00078713                
        bltu    x9, x14, .L4           fee4e8e3                 
        addi    x15, x18, 0            00090793                
        addi    x10, x15, 0            00078513                
        lw      x8, 12(x2)             00c12403               
        lw      x9, 8(x2)              00812483              
        lw      x18, 4(x2)             00412903               
        addi    x2, x2, 16             01010113               
        jr      x1                     00008067                     

*/



square:            
bge  x15, x0, 8   ->    bge  x15, x0, 40           0007d463 -> 0207d463
jal  x0, 16       ->    jal  x0, 80                0100006f -> 0500006f
bltu x9, x14, -16 ->    bltu x9, x14, -80          fee4e8e3 -> fae4e8e3

bge     x15, x0, .L2


bge     x15, x0, 8