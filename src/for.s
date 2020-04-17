		.section .data
		.section .text
		.globl _start
_start:
.equ    END, 7
        movq $0,%rax # End result - initialize with 0
        # FOR-LOOP
        movq $2,%rcx # Initialize loop counter
for_start:
        cmpq $END,%rcx # At the end of the loop?
        jg for_end # If not, go to end
        addq %rcx,%rax # Add current index to result
        incq %rcx # Increment loop counter
        jmp for_start # Go to loop begin
for_end:
        movq %rax, %rdi  # result = 27
        movq $60, %rax # 60 is the exit() syscall
		syscall 
