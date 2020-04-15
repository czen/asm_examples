.section .data
.section .text
.globl _start

_start:
    movq $10, %rdi # caller puts 1 parameter into RDI
    call sum
    movq %rax, %rdi # caller reads return value from RAX
    movq $60, %rax
    syscall         # return RDI

.type sum, function
sum:
    push %rbp        # System V x64 calling convention
    movq %rsp, %rbp  #
    subq $8, %rsp    # this frame will have 1 local variable
    movq %rdi, %rax  # read 1 parameter from RDI
    push %rax        # remember RAX
    cmp $0,%rax      # compare RAX to 0
    jl minus         # if RAX < 0 goto minus
    cmp $0,%rax      # compare RAX to 0
    je ret_null      # if RAX == 0 goto ret_null
    dec %rax         # n = n - 1
    movq %rax, %rdi  # put next value into RDI for call
    call sum         # recursive call
    popq %rdi        # get old n from stack
    addq %rdi, %rax  # s = n + sum(n-1)
    movq %rbp, %rsp  # System V x64 calling convention
    popq %rbp        # restore base pointer
    ret

minus:
    movq $-1, %rax
    movq %rbp, %rsp # System V x64 calling convention
    popq %rbp
    ret

ret_null:
    movq $0, %rax
    movq %rbp, %rsp # System V x64 calling convention
    popq %rbp
    ret
