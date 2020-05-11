.section .data
.section .text
.globl _start

.type power, @function

power:
        movq $1,%rax
        cmpq $0,%rsi # If the power is 0, we return 1
        je end_power
        movq %rdi,%rax # Prepare local variable for first round
power_loop_start:
        cmpq $1,%rsi # If the power is 1, we are done
        je end_power
        imulq %rdi,%rax # Multiply the current result by the base number
        decq %rsi # Decrease the power
        jmp power_loop_start # Run for the next power
end_power:
        ret # Return to calle

_start:
        movq $2,%rdi # Store first argument
        movq $3,%rsi # Store second argument
        call power # Call the function
        movq %rax,%r12 # Save first result into temporary register
        movq $5,%rdi # Store first argument
        movq $2,%rsi # Store second argument
        call power # Call the function
        movq %rax,%rdi # Save second result into temporary register
        addq %r12,%rdi # The second result is in %r12
        # Add the first one and store in %rdi
        movq $60,%rax # Exit (%rdi is returned)
        syscall
