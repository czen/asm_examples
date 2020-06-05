.section data
format: .asciz "%10.10f\n"
.text
.global main
# .type _e, @function
_e:
        pushq %rbp
        movq %rsp, %rbp
        # counter in %rdi
        subq $32, %rsp
        movq $1, -8(%rbp) # divizor here
        movq $1, -16(%rbp) # divident here

        pxor %xmm0, %xmm0 # zero xmm0
        movsd %xmm0, -24(%rbp) # sum here
        movq $0, %rcx # loop counter

.sum_loop:
        cmpq %rdi, %rcx
        jge .end_loop
        incq %rcx

        pxor %xmm0, %xmm0
        cvtsi2sdl -16(%rbp), %xmm0 # 1 in xmm0
        cvtsi2sdl -8(%rbp), %xmm1 # divizor in xmm1
        divsd %xmm0, %xmm1 # 1/divizor
        movsd -24(%rbp), %xmm0 # load old sum in xmm0
        addsd %xmm0, %xmm1 # new sum in xmm1
        movsd %xmm1, -24(%rbp)
        
        movq -8(%rbp), %rsi
        imulq %rcx, %rsi
        movq %rsi, -8(%rbp)
        jmp .sum_loop

        
.end_loop:
        movsd -24(%rbp), %xmm0
        movq %rbp, %rsp
        popq %rbp
        ret

main:
        pushq %rbp
        movq %rsp, %rbp
        movq $10, %rdi
        call _e
        # subq $8, %rsp
.after_e: 
        pushq $0
        # push %rbx

        movq    %xmm0, %rax
        movsd    %xmm0, -8(%rbp)
        movq    %rax, %xmm0
        movq    %rax, %rsi
        lea  format(%rip), %rdi 
        movq    $0, %rax
        call    printf

        # pop %rbx
        movq %rbp, %rsp
        popq %rbp
        ret
        # movq %rbp, %rsp
        # movq $0, %rdi
        # movq $60, %rax
        # syscall


