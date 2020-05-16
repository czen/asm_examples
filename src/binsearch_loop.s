# T - target value, for us is the biggest value in array
# DX - n - number of elements, this case 20
# LX- m - position of the middle element
# AX - R
# BX - L
#If L > R the search terminates as unsuccessful.
#function binary_search(A, n, T) is
#   L := 0
#    R := n − 1
 #   while L ≤ R do
  #      m := floor((L + R) / 2)
  #      if A[m] < T then
  #          L := m + 1
  #      else if A[m] > T then
   #         R := m - 1
   #     else:
   #         return m
   # return unsuccessfuls


.section .data

data_items:

.quad 1,2,3,4,5,6,7,8,9,10

.section .text

.globl _start

_start:
pushq %rbp
movq %rsp,%rbp

push %rbx
push %r14

movq $10,%rdx
movq $0, %r8

movq $0,%rbx         #L=0
movq %rdx,%rcx        #rdx=10
decq %rcx

while_loop:
cmpq %rcx,%rbx
jg notfound

movq %rcx,%rax     #m=(r+l)/2
ADD %rbx,%rax
shr %rax

movq data_items(,%rax,8), %r14
cmpq %r14, %r8

jz found
jg right_bound
jl left_bound

left_bound:
decq %rax
movq %rax,%rcx
jmp while_loop

right_bound:
incq %rax
movq %rax,%rbx
jmp while_loop

found:
pop %r14
pop %rbx

movq %rbp,%rsp
pop %rbp

movq %rax,%rdi
movq $60, %rax 
syscall

notfound:
pop %r14
pop %rbx

movq %rbp,%rsp
pop %rbp

movq $-1,%rdi
movq $60, %rax 
syscall
