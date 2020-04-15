.section .data
.section .text
.globl _start

_start:
    movq $13, %rdi # caller puts 1 parameter into RDI
    call fib
    movq %rax, %rdi # caller reads return value from RAX
    movq $60, %rax
    syscall         # return RDI
                    # result is in process return code
                    # but it will be truncated if > 255, return codes are in (0,255)

.type fib, @function
fib:
    push %rbp        # System V x64 calling convention
    movq %rsp, %rbp  #
    # subq $0, %rsp    # this frame will have 0 local variable, all in registers
    movq %rdi, %rcx  # read n parameter from RDI
                     # RCX = n
                     # R9 = fib(n-2)
                     # R10 = fib(n-1)
    movq $0, %r9     # fib(0) = 0
    movq $1, %r10    # fib(1) = 1
    
    cmpq $0, %rcx
    jle ret_null     # if n <= 0 return 0

next:                     
    movq %r10, %rax
    dec %rcx
    cmpq $0, %rcx
    je return_result
    addq %r9, %rax  # add r9 to rax, result in rax
    movq %r10, %r9
    movq %rax, %r10
    jmp next

return_result:
                    # result already in RAX
    movq %rbp, %rsp # System V x64 calling convention
    popq %rbp
    ret

ret_null:
    movq $0, %rax
    movq %rbp, %rsp # System V x64 calling convention
    popq %rbp
    ret
