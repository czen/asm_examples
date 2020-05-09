.section .data

.section .text

.globl _start

_start:
push %rbx
movq $5,%rax        #base
movq $3,%rbx        #power

_power:
movq $1,%rdx        #initializing result
cmp $0,%rbx         #power of 0 return 1
je end_result

movq %rax,%rdx      #temporary storage

_powerloop:
cmp $1,%rbx         #if power is 1 base is the answer
je end_result

imulq %rdx,%rax     #current times base
decq %rbx           #power -1
movq %edx,%rdx
jmp _powerloop

end_result:

pop %rbx
mov %rdx, %rdi
mov $60,%rax
syscall

