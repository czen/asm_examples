# -----------------------------------------------------------------------------
# A 64-bit command line application to compute x^y.
#
# Syntax: power x y
# x and y are integers
# -----------------------------------------------------------------------------

        .global main

        .text
main:
        push    %r12                    # save callee-save registers
        push    %r13
        push    %r14
        # By pushing 3 registers our stack is already aligned for calls
        # stack should be 16-byte aligned
                                        # rdi - first argument = total number of arguments
        cmp     $3, %rdi                # must have exactly two arguments
                                        # 1: name of executable (pow)
                                        # 2: first argument
                                        # 3: second argument
                                        # main(argc, argv[])
        jne     error1
                                        # rsi - second argument
        mov     %rsi, %r12              # argv

# We will use ecx to count down form the exponent to zero, esi to hold the
# value of the base, and eax to hold the running product.

        mov     16(%r12), %rdi          # argv[2]
        call    atoi                    # y in eax
        cmp     $0, %eax                # disallow negative exponents
        jl      error2                  
                                        # rNNd is lower 32 bits of rNN, rNNw is lower 16 bits, rNNb is lower 8 bits
        mov     %eax, %r13d             # y in r13d

        mov     8(%r12), %rdi           # argv
        call    atoi                    # x in eax
        mov     %eax, %r14d             # x in r14d

        mov     $1, %eax                # start with answer = 1
check:
        test    %r13d, %r13d            # we're counting y downto 0
                                        # test is bitwise and on two arguments, sets flags SF, ZF, PF
                                        # test discards its result
        jz      gotit                   # done if (r13d == 0) goto gotit
        imul    %r14d, %eax             # multiply in another x
        dec     %r13d
        jmp     check
gotit:                                  # print report on success
        mov     $answer, %rdi 
        movslq  %eax, %rsi              # we were calculating result as 32-bit signed integer in 2's complement
                                        # now convert it inplace to 64-bit signed integer by extending upper bits
        xor     %rax, %rax
        call    printf                  # printf("%d\n", eax)
        jmp     done
error1:                                 # print error message
        mov     $badArgumentCount, %edi
        call    puts                    # puts just takes one argument - pointer to string
                                        # easier then printf
        jmp     done
error2:                                 # print error message
        mov     $negativeExponent, %edi
        call    puts
done:                                   # restore saved registers
        pop     %r14
        pop     %r13
        pop     %r12
        ret

answer:
        .asciz  "%d\n"
badArgumentCount:
        .asciz  "Requires exactly two arguments\n"
negativeExponent:
        .asciz  "The exponent may not be negative\n"
