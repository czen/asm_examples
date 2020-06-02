.section .data
text1: .string "kayak"
text2: .string "racecar"
text3: .string "rotor"
text4: .string "rodent"
text5: .string "plumbus"
text6: .string "p l um bus"

.equ SPACE, ' '

.section .text
.type isPalindrome,@function
isPalindrome:
pushq %rbp
movq %rsp,%rbp
# Get Parameters and initialize counter
# word in RDI
# calculate string length
movq $0,%rdx # Set count to 0
# start address of string already in rdi
movq %rdi, %rsi # remember address as scasb will increase it
movq $-1, %rcx 
cld          # clear direction flag (forward/upward)
movb $0, %al # set the value 0 to look for
repne scasb  # repeat while not eaual a scan for %al
notq %rcx    # invert rcx
decq %rcx    # decrement by one
movq %rcx, %rdx # store as length
decq %rdx    # index of last element

movq %rsi, %rdi
movq $0,%rcx # Current index
movq $0,%rax # Ensure the upper 48 Bits are empty

loop:

movb (%rdi,%rcx,1),%al # Get next letter
movb (%rdi,%rdx,1),%ah # Get next letter from the end

check_left:
cmpb $SPACE,%al
je space_left
jmp check_right

space_left: 
incq %rcx 

check_right:
cmpb $SPACE,%ah
je space_right
jmp no_space

space_right: 
decq %rdx

no_space:
incq %rcx # Increment loop index
decq %rdx # decrement last letter index

cmpq %rcx, %rdx
jle success
cmpb %al,%ah 
je loop
# Difference -> no palindrome
jmp fail

success:
movq $1, %rax
movq %rbp,%rsp
popq %rbp
ret

fail:
movq $0, %rax
movq %rbp,%rsp
popq %rbp
ret

.global _start
_start:
movq $text3,%rdi
call isPalindrome
movq %rax, %rdi
movq $60,%rax
syscall
