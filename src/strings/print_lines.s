.section .data
text: .asciz "Quick\nbrown\nfox\njumped\n\over\nthe\nlazy\nbrown \n dog\n" # Automatically terminated
.set text_len,.-text
.equ LINE_BREAK, '\n'

.section .text
.globl _start

_start:
        movq %rsp,%rbp
        movq $0, %rdx
        movq $text, %rsi
        
        movq $0, %r8
print_loop:
        movq %r8, %rdx
len_loop:
        movb (%rsi,%rdx,1), %al
        cmpb $LINE_BREAK, %al
        je end_len 
        cmpb $0, %al
        je program_end
        incq %rdx
        jmp len_loop 
end_len:        
        incq %rdx
        movq $1,%rdi # File descriptor of STDOUT
        lea text(,%r8,1),%rsi
        movq $1,%rax # Write to stream
        syscall

        addq %rdx, %r8

        jmp print_loop       

program_end: # Terminate program
        movq $0,%rdi
        movq $60,%rax
        syscall
