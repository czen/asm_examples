.section .data
dec_number:	.asciz "______________" # 14 underscores
table:		.ascii "0123456789ABCDEF"
.section .text
.globl _start

_start:
    movq $11,%rdi
    movq $10000000, %rsi
    call e
    # movq %rax,%rdi
    # movq $60,%rax
    # syscall
    movq %rax, %rdi
    movq $dec_number, %rsi
    call int_to_string

    movq $1,%rdi # File descriptor of STDOUT
    movq $dec_number,%rsi # print dec_number
    movq $14,%rdx # Length of string
    movq $1,%rax # Write to stream
    syscall

    movq $0,%rdi
    movq $60,%rax
    syscall

.type e,@function
e:
        pushq %rbp # standard function stuff - we have to
        # restore %rbp to its prior state before
        # returning, so we have to push it
        movq %rsp,%rbp # This is because we don't want to modify
        # the stack pointer, so we use %rbp.
     
        movq %rsi, %r12 # numerator
        movq $0, %r13  # result
        movq $0, %r14 # r14 = counter
        movq %rdi, %r15 # r15 = n
        
series_loop:
        cmpq %r15, %r14 # counting from 0 to %rdi
        jg return_e
        movq %r14, %rdi
        call factorial
        
        movq %rax, %rcx
        movq %r12, %rax
        movq $0, %rdx    # don't forget to clear upper part of divident
        divq %rcx        # %rax/%rcx
                         # remainder in %rdx
                         # quatient in %rax
        addq %rax, %r13                       
            
                
        inc %r14
        jmp series_loop

return_e:
        movq %r13, %rax
        movq %rbp, %rsp # standard function return stuff - we
        popq %rbp # have to restore %rbp and %rsp to where
        # they were before the function started
        ret # return from the function

.type factorial,@function
factorial:
        pushq %rbp # standard function stuff - we have to
        # restore %rbp to its prior state before
        # returning, so we have to push it
        movq %rsp,%rbp # This is because we don't want to modify
        # the stack pointer, so we use %rbp.
        pushq %rbx # Save RBX (used for multiplication)
        # Note: We could easily use e.g. R11 to
        # avoid needing the stack!
check_base_case0:
        movq $1,%rax
        cmpq $0,%rdi # If the number is 0, we return 1
        je end_factorial
check_base_case1:
        cmpq $1,%rdi # If the number is 1, that is our base
        je end_factorial # case, and we simply return (1 is
        # already in %rax as the return value)
        pushq %rdi # save our own parameter for later
        decq %rdi # decrease the value
        call factorial # call factorial
        popq %rbx # retrieve our own parameter
        imulq %rbx,%rax # multiply it by the result of the last
        # call to factorial (in %rax); the answer
        # is stored in %rax, which is good since
        # that's where return values go.
end_factorial:
        popq %rbx # restore old value
        movq %rbp,%rsp # standard function return stuff - we
        popq %rbp # have to restore %rbp and %rsp to where
        # they were before the function started
        ret # return from the function

.type int_to_string,@function
int_to_string:
    pushq %rbp # standard function stuff - we have to
    # restore %rbp to its prior state before
    # returning, so we have to push it
    movq %rsp,%rbp # This is because we don't want to modify
    # the stack pointer, so we use %rbp.
    pushq %rbx # save rbx

    movq $8, %rcx            # initializing loop counter
    movq $10, %r10           # base
    movq %rdi, %rax           # storing number in register
    movq $0, %rdi            # initializing sum of the ASCII codes

start_loop:	                  # start loop
	cmpq $0, %rcx             # check to see if we've hit the end
	je loop_exit              # go to exit

	decq %rcx                 # decrement the loop counter

    movq $0, %rdx    # don't forget to clear upper part of divident
    divq %r10        # divide %rax by 10
                     # remainder in %rdx = next digit
                     # quatient in %rax = remaining number
    movq %rdx, %rbx                     
    
    movb table(,%rbx, 1), %dl   # getting ASCII code for digit
    movb %dl, dec_number(,%rcx, 1)  # setting character in string
    add %rdx, %rdi                  # summing ASCII codes
    jmp start_loop                  # go to loop start

loop_exit:
    movq $0, %rax
    popq %rbx
    movq %rbp,%rsp # standard function return stuff - we
    popq %rbp # have to restore %rbp and %rsp to where
    ret
