	# PURPOSE:  This program converts a number into a hexadecimal string.
	#

	# VARIABLES: The registers have the following uses:
	#
	# rdx - loop counter
	# rdi - sum of ASCII codes
	# rax - number
	# rbx - one digit
	# rcx - ASCII code of digit
	#
	# The following memory locations are used:
	#
	# number     - contains the number to convert to hex
	# hex_number - contains the converted number
	# table      - helper table for conversion to hexadecimal
	#

.section .data
number:		.quad 0xf12345A7
hex_number:	.asciz "________" # eight underscores to make sure there is enough space for four bytes
table:		.ascii "0123456789ABCDEF"

.section .text
.globl _start

_start:
    movq $8, %rdx            # initializing loop counter
    movq $0, %rdi            # initializing sum of the ASCII codes
    movq number(,%rdi,8), %rax    # storing number in register

start_loop:	                  # start loop
	cmpq $0, %rdx             # check to see if we've hit the end
	je loop_exit              # go to exit

	decq %rdx                 # decrement the loop counter

    mov %rax, %rbx            # saving number in another register
    and $15, %rbx             # getting last digit

    shr %rax                  # shift left to get next digit
    shr %rax
    shr %rax
    shr %rax

    movb table(,%rbx, 1), %cl   # getting ASCII code for digit
    movb %cl, hex_number(,%rdx, 1)  # setting character in string
    add %rcx, %rdi                  # summing ASCII codes
    jmp start_loop                  # go to loop start

loop_exit:
    movq $60, %rax                # 60 is the exit() syscall
    syscall
