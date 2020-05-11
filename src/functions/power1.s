.section .data
.section .text
.globl _start

.type power, @function
power:
        pushq %rbp # Save old base pointer
        movq %rsp,%rbp # Make stack pointer the base pointer
        subq $8,%rsp # Get room for our local storage
        pushq %rbx # Preserve callee-safe register
        movq %rdi,%rbx # Put first argument in %rbx
        movq %rsi,%rcx # Put second argument in %rcx
        movq %rbx,-8(%rbp) # Store current result
power_loop_start:
        cmpq $1,%rcx # If the power is 1, we are done
        je end_power
        movq -8(%rbp),%rax # Move the current result into %rax
        imulq %rbx,%rax # Multiply the current result by the base number
        movq %rax,-8(%rbp) # Store the current result
        decq %rcx # Decrease the power
        jmp power_loop_statr # Run for the next power
end_power:
        movq -8(%rbp),%rax # Return value goes in %rax
        popq %rbx # Restore callee-safe registers
        movq %rbp,%rsp # Restore the stack pointer
        popq %rbp # Restore the base pointer
        ret

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
