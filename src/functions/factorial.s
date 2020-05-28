	.file	"factorial.c"
	.text
	.globl	_Z9factoriali
	.type	_Z9factoriali, @function
_Z9factoriali:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
.L2:
	endbr64
	cmpl	$0, -4(%rbp)
	jne	.L6
	movl	$1, %eax
	jmp	.L4
.L6:
	nop
.L3:
	endbr64
	cmpl	$1, -4(%rbp)
	jne	.L7
	movl	$1, %eax
	jmp	.L4
.L7:
	nop
.L5:
	endbr64
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	_Z9factoriali
	imull	-4(%rbp), %eax
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	_Z9factoriali, .-_Z9factoriali
	.section	.rodata
.LC0:
	.string	"factorial(4) = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
.L9:
	endbr64
	movl	$4, %edi
	call	_Z9factoriali
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
