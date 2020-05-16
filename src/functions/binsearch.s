		.section .data
		
arr: 
		.quad 1,2,5,24,67,68,71,92,97,111,221,367,380,400,423,438,0
.set    len,(.-arr-1)/8 
		.section .text
		.globl _start
_start:

        movq $0, %rdi   # search from beginning of array
		movq $len-1, %rsi # to end of array
		movq $111, %rdx # search for 367
call_binsearch:       
		call binsearch
		
		movq %rax, %rdi # return result as process return code
		movq $60, %rax # 60 is the exit() syscall
		syscall

binsearch: 
        push %rbp
		movq %rsp, %rbp
		# binsearch(left, right, value)
		# left = rdi, right = rsi, value = rdx
		cmpq %rdi, %rsi
		jz one_remaining
		movq %rsi, %rcx # right = rcx
		subq %rdi, %rcx # %rcx = right-left
		shr  %rcx       # %rcx = (right-left)/2
        add %rdi, %rcx  # %rcx = left + (right-left)/2
		cmpq %rdx, arr(,%rcx,8) # arr[(right-left)/2] - value?
		jz found # if arr[(right-left)/2] - value == 0 goto found
		jg left  # if arr[(right-left)/2] - value > 0 goto left
		jl right # if arr[(right-left)/2] - value < 0 goto right
left:  
        #movq %rdi, %rdi   # rdi already there       
		movq %rcx, %rsi # right = (right-left)/2
        dec %rsi
		# value = rdx is still there
		call binsearch
		jmp return_result # result in rax

right:	
        movq %rcx, %rdi # left = (right-left)/2
        inc %rdi
		#movq %rsi, %rsi # rsi already there       
		# value = rdx is still there
		call binsearch
		jmp return_result # result in rax	
		
one_remaining:
        cmpq %rdx, arr(,%rsi, 8) 		
		jz found
		jg not_found # todo: replace with 1 instruction
		jl not_found
found:
        movq $1, %rax
		jmp return_result

not_found:
        movq $0, %rax		
		jmp return_result
		
return_result:		
		movq %rbp, %rsp
		pop %rbp
        ret
	
