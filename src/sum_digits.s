.section .data
.section .text
.globl _start

_start:
    movq $13623, %rdi # caller puts 1 parameter into RDI
    call sum_digits
    movq %rax, %rdi # caller reads return value from RAX
    movq $60, %rax
    syscall         # return RDI

.type sum_digits, @function
sum_digits:
    push %rbp        # System V x64 calling convention
    movq %rsp, %rbp  #
    subq $8, %rsp    # this frame will have 1 local variable
    movq %rdi, %r10  # read 1 parameter from RDI
    movq %r10, %rax  # r10 will store current number
    movq $10, %rbx   # base
    movq $0, %rcx    # rcx accumulates sum of digits

    cmpq $0, %r10    # if n <= 0 return 0
    jle ret_null
    
next:
    movq $0, %rdx    # don't forget to clear upper part of divident
    movq %r10, %rax  # clear divident every time
    divq %rbx        # divide %rax by %rbx = 10
                     # remainder in %rdx = next digit
                     # quatient in %rax = remaining number
after_div:    
    movq %rax, %r10
    addq %rdx, %rcx
    cmpq $0, %r10 
    je return_result
    jmp next    

return_result:
    movq %rcx, %rax
    movq %rbp, %rsp # System V x64 calling convention
    popq %rbp
    ret

ret_null:
    movq $0, %rax
    movq %rbp, %rsp # System V x64 calling convention
    popq %rbp
    ret
