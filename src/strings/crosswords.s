.section .data
text1: .string "Student"
text2: .string "Students"
text3: .string "S ud nt"
text4: .string "s ud nt"
text5: .string "S ud nt "
.equ PLACEHOLDER,' '
.section .text
.type checkWord,@function
checkWord:
pushq %rbp
movq %rsp,%rbp
# Get Parameters and initialize counter
# Candidate RDI
# Slot RSI
movq $0,%rcx # Current index
movq $0,%rax # Ensure the upper 48 Bits are empty
loop:
movb (%rdi,%rcx,1),%al # Get candidate letter
movb (%rsi,%rcx,1),%ah # Get slot letter
incq %rcx # Increment loop index
cmpb $0,%al # Candidate at end?
je candidate_end
cmpb $0,%ah # Slot at end?
je slot_end
cmpb $PLACEHOLDER,%ah # Is it the placeholder?
je loop
cmpb %al,%ah # Compare for match
je loop
# Difference -> No match
# AL and AH are not zero, so we already have cor. return value
jmp end
# Note: Both labels could be replaced by "end", as there is no
# difference at all and
# the correct result is in EAX automatically
candidate_end:
# Both are zero -> Return zero (=already in EAX)
# AH is not zero --> Still end, return not-zero (=already in EAX)
jmp end
slot_end:
# Both are zero -> Return zero (=already in EAX) (cannot happen
# because of previous check!)
# AL is not zero --> Still end, return not-zero (=already in EAX)
jmp end
end:
movq %rbp,%rsp
popq %rbp
ret

.global _start
_start:
movq $text1,%rdi
movq $text3,%rsi
call checkWord
movq $0,%rdi
cmpq $0,%rax
je terminate
movq $-1,%rdi
terminate:
movq $60,%rax
syscall
