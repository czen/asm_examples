		.section .data
		.section .text
		.globl _start
_start:
.equ END, 7
        movq $0,%rax # End result - initialize with 0
        # LOOP
        movq $END,%rcx # Initialize loop counter
loop_start:
        addq %rcx,%rax # Add current index to result
        loop loop_start # Decrement RCX and jump to start until it
        # reaches zero
loop_end:
        movq %rax, %rdi  # result = 28
        movq $60, %rax # 60 is the exit() syscall
		syscall 
