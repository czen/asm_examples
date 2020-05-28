.section .text
.globl _start

_start:

movq $10,%rcx
movq $10000, %r10
call factorial
movq %rax,%r11
mulq %r11,%r10

if_zero:

movq $1,%rax
cmpq %rcx,$0
je end_function

if_one:

movq $1,%rax
cmpq %rcx,$1
je end_function

factorial:

movq %rcx,%rdx
push %rdx
decq %rdx
call factorial
pop %rdx
imulq %rcx,%rdx

end_function:
ret
movq $60,%rax
syscall
