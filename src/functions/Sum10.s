.section .data
.section .text
.globl _start

.type sum, @function
sum:
        pushq %rbp # Save old base pointer
        movq %rsp,%rbp # Make stack pointer the base pointer

        addq %rcx,%rax
        addq %rdx,%rax
        addq %r9,%rax
        addq %r9,%rax
        addq %rdi,%rax
        addq %rsi,%rax
        addq 16(%rbp),%rax
        addq 24(%rbp),%rax
        addq 32(%rbp),%rax
        addq 40(%rbp),%rax

end_sum:
        
        movq %rbp,%rsp # Restore the stack pointer
        popq %rbp # Restore the base pointer
        ret

_start:
        movq $1,%rcx
        movq $2,%rdx
        movq $3,%r8
        movq $4,%r9

        pushq $5
        pushq $6
        pushq $7
        pushq $8

        movq $2,%rdi # Store first argument
        movq $3,%rsi # Store second argument
        call sum # Call the function

        subq $32,%rsp

        movq %rax,%rdi 

        movq $60,%rax # Exit (%rdi is returned)
        syscall
