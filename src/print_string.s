.section .data
prefix: .ascii "Hello \0“ # Must be terminated manually
.set prefix_len,.-prefix # Calculate length as current address
# minus start address of string
postfix: .asciz ", how are you?\n“ # Automatically terminated
.set postfix_len,.-postfix
error: .string "Program parameter(s) incorrect\n“ # Auto-terminated
.set error_len,.-error
.section .text
.globl _start
_start:
movq %rsp,%rbp
# Check parameter count
cmpq $2,0(%rbp)
jne print_error
# Print prefix
movq $1,%rdi # File descriptor of STDOUT
movq $prefix,%rsi # Print prefix
movq $prefix_len,%rdx # Length of string
movq $1,%rax # Write to stream
syscall
# Print parameter 1
movq $0,%rdx # Set count to 0
movq 16(%rbp),%rsi # Retrieve start address
len_loop:
cmpb $0,(%rsi,%rdx,1) # Retrieve first byte of string
je end_len # If zero -> End of string
incq %rdx # One more character found
jmp len_loop # Continue loop
end_len:
movq $1,%rdi # File descriptor of STDOUT
movq 16(%ebp),%rsi # Print parameter 1
# EDX (=Length of string) has been calculated above!
mov1 $1,%rax # Write to stream
syscall
# Print postfix
movq $1,%rdi # File descriptor of STDOUT
movq $postfix,%rsi # print postfix
movq $postfix_len,%rdx # Length of string
movq $1,%rax # Write to stream
syscall
jmp program_end
print_error:
movq $1,%rdi # File descriptor of STDOUT
movq $error,%rsi # print postfix
movq $error_len,%rdx # Length of string
movq $1,%rax # Write to stream
syscall
program_end: # Terminate program
movq $0,%rdi
movq $60,%rax
syscall
