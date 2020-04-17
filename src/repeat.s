		.section .data
		.section .text
		.globl _start
_start:
.equ END, 7
        movq $0,%rax # End result - initialize with 0
        # REPEAT-LOOP
        movq $2,%rcx # Initialize loop counter
repeat_start:
        addq %rcx,%rax # Add current index to result
        incq %rcx # Increment loop counter
        cmpq $END,%rcx # At the end of the loop?
        jle repeat_start # If not, go to top
repeat_end:
        movq %rax, %rdi  # result = 27
        movq $60, %rax # 60 is the exit() syscall
		syscall 
