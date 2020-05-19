#include <cstdio>

#define CDECL __attribute__((cdecl))
#define STDCALL __attribute__((stdcall))
#define SYSCALL __attribute__((syscall))
#define FASTCALL __attribute__((fastcall))
#define PASCAL __attribute__((pascal))

extern "C" int CDECL  foo_cdecl(int,int);
extern "C" int STDCALL  foo_stdcall(int,int);
extern "C" int FASTCALL  foo_fastcall(int,int);
extern "C" int PASCAL  foo_pascal(int,int);

// 64-bit version
// but gcc refuses to compile cdecl in x86-64
// asm(
// ".global foo\n"
// "foo:\n"
//     "pushq	%rbp\n"
//  	"movq	%rsp, %rbp\n"
//  	"movq	%rdi, %rax\n"
//  	"leaq	(%rax,%rax), %rcx\n"
//  	"movq	%rsi, %rdx\n"
//  	"movq	%rdx, %rax\n"
//  	"addq	%rax, %rax\n"
//  	"addq	%rdx, %rax\n"
//  	"leaq	(%rax,%rcx), %rax\n"
//  	"popq	%rbp\n"
//  	"ret\n"
// );

// 32-bit version
asm(
".global foo_sysv\n"
"foo_sysv:\n"
    "pushl	%ebp\n"
 	"movl	%esp, %ebp\n"
 	"movl	%edi, %eax\n"
 	"leal	(%eax,%eax), %ecx\n"
 	"movl	%esi, %edx\n"
 	"movl	%edx, %eax\n"
 	"addl	%eax, %eax\n"
 	"addl	%edx, %eax\n"
 	"leal	(%eax,%ecx), %eax\n"
 	"popl	%ebp\n"
 	"ret\n"
);

// cdecl parameters on stack
asm(
".global foo_cdecl\n"
"foo_cdecl:\n"
    "pushl	%ebp\n"
 	"movl	%esp, %ebp\n"
 	"movl	8(%ebp), %eax\n"
 	"leal	(%eax,%eax), %ecx\n"
 	"movl	12(%ebp), %edx\n"
 	"movl	%edx, %eax\n"
 	"addl	%eax, %eax\n"
 	"addl	%edx, %eax\n"
 	"leal	(%eax,%ecx), %eax\n"
 	"popl	%ebp\n"
 	"ret\n"
);

// stdcall parameters on stack
asm(
".global foo_stdcall\n"
"foo_stdcall:\n"
    "pushl	%ebp\n"
 	"movl	%esp, %ebp\n"
 	"movl	8(%ebp), %eax\n"
 	"leal	(%eax,%eax), %ecx\n"
 	"movl	12(%ebp), %edx\n"
 	"movl	%edx, %eax\n"
 	"addl	%eax, %eax\n"
 	"addl	%edx, %eax\n"
 	"leal	(%eax,%ecx), %eax\n"
 	"popl	%ebp\n"
 	"ret\n"
);

// fastcall, first  2 parameters in ecx, edx
asm(
".global foo_fastcall\n"
"foo_fastcall:\n"
    "pushl	%ebp\n"
 	"movl	%esp, %ebp\n"
 	"movl   %ecx, %eax\n"
 	"leal	(%eax,%eax), %ecx\n"
 	"movl	%edx, %eax\n"
 	"addl	%eax, %eax\n"
 	"addl	%edx, %eax\n"
 	"leal	(%eax,%ecx), %eax\n"
 	"popl	%ebp\n"
 	"ret\n"
);

// pascal parameters on stack
asm(
".global foo_pascal\n"
"foo_pascal:\n"
    "pushl	%ebp\n"
 	"movl	%esp, %ebp\n"
 	"movl	8(%ebp), %eax\n"
 	"leal	(%eax,%eax), %ecx\n"
 	"movl	12(%ebp), %edx\n"
 	"movl	%edx, %eax\n"
 	"addl	%eax, %eax\n"
 	"addl	%edx, %eax\n"
 	"leal	(%eax,%ecx), %eax\n"
 	"popl	%ebp\n"
 	"ret\n"
);

int main(int argc, char* argv[]) {
    printf("%d\n",foo_cdecl(3,4));
    printf("%d\n",foo_stdcall(3,4));
    printf("%d\n",foo_fastcall(3,4));
    printf("%d\n",foo_pascal(3,4));
    return 0;
}
