		.section .data
		.section .text
		.globl _start
_start:
.equ END, 7
        movq $0,%rax # End result - initialize with 0
        # WHILE-LOOP
        movq $2,%rcx # Initialize loop counter
while_start:
        cmpq $END,%rcx # At the end of the loop?
        jge while_end # If not, go to end
        addq %rcx,%rax # Add current index to result
        incq %rcx # Increment loop counter
        jmp while_start # Go to loop begin
while_end:
        movq %rax, %rdi  # result = 20
        movq $60, %rax # 60 is the exit() syscall
		syscall 
