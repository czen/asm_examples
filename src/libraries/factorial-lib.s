.section .text
.globl factorial
.type factorial,@function
factorial:
        pushq %rbp # Standard function stuff
        movq %rsp,%rbp
        subq $8, %rsp
do_recursive:
        pushq %rdi # Save original value (function
        # might overwrite it - caller save!)
        decq %rdi # Decrease the value
        call factorial@PLT # Recursively call factorial
        # Add '@PLT' to force generation of PIC
        # (Position Independent Code), which
        # is necessary for shared libraries.
        popq %rdi # %rax has the return value, so we reload our
        # parameter into %rdi
        imulq %rdi,%rax
end_factorial:
        movq %rbp,%rsp # Standard function return stuff
        popq %rbp
        ret # Return from the function
