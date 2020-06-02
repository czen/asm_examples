# System call numbers
.equ SYS_OPEN, 2
.equ SYS_READ, 0
.equ SYS_WRITE, 1
.equ SYS_CLOSE, 3
.equ SYS_EXIT, 60
.equ O_RDONLY, 0 # Open file options - read-only
.equ O_CREAT_WRONLY_TRUNC, 03101 # Open file options - these are:
# CREAT - create file if not exising
# WRONLY - only write to this file
# TRUNC - destroy current contents
.equ O_PERMS, 0666 # Read & Write perms. for everyone
# End-of-file result status
.equ END_OF_FILE, 0 # This is the return value of read()
# which means we've hit the end of
# the file
.section .data
chars:		.ascii "    "
.equ SPACE, ' '

error: .string "Program parameter(s) incorrect\n" # Auto-terminated
.set error_len,.-error
error1: .string "Unexpected error\n" # Auto-terminated
.set error1_len,.-error1

.section .bss
.equ BUFFER_SIZE, 4
.lcomm BUFFER_DATA, BUFFER_SIZE
.lcomm OUTPUT_DATA, BUFFER_SIZE
.section .text
.globl _start

_start:
        movq %rsp,%rbp
        # Check parameter count
        cmpq $2,0(%rbp)  # must have exactly 1 argument
        # gnu asm makes _start have parameters on stack, not conventionally in rdi, etc.
        jne print_error
        movq 8(%rbp), %r8 # key in r8
        movq $0, %rcx

encrypt_loop:
        movq $0, %rdi # input stream descriptor
        movq $BUFFER_DATA, %rsi
        movq $BUFFER_SIZE, %rdx
        movq $SYS_READ, %rax
        syscall
        cmpq $END_OF_FILE, %rax
        # je loop_end
        jl print_other_error
        movq $0, %rcx
        cmpb $SPACE, BUFFER_DATA(,%rcx,1)
        je loop_end
        movq $BUFFER_DATA, %rdi
        xor %r8, %rdi
        
        movq %rdi, chars(,%rcx,1)

        movq $1,%rdi # File descriptor of STDOUT
        movq $chars,%rsi
        movq $4,%rdx # Length of string
        movq $1,%rax # Write to stream
        syscall

loop_end:
        jmp program_end

print_other_error:
        movq $1,%rdi # File descriptor of STDOUT
        movq $error1,%rsi 
        movq $error1_len,%rdx # Length of string
        movq $1,%rax # Write to stream
        syscall
print_error:
        movq $1,%rdi # File descriptor of STDOUT
        movq $error,%rsi 
        movq $error_len,%rdx # Length of string
        movq $1,%rax # Write to stream
        syscall
program_end: # Terminate program
        movq $0,%rdi
        movq $60,%rax
        syscall
