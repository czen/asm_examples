#include <cstdio>

//#define CDECL __attribute__((cdecl))
//#define STDCALL __attribute__((stdcall))
//#define SYSCALL __attribute__((syscall))

#define MSCALL __attribute__((ms_abi))

extern "C" int foo_sysv(int,int);
extern "C" int MSCALL foo_ms64(int,int);

// 64-bit version
// but gcc won't compile cdecl in x86-64, it's 32bit only
asm(
".global foo_sysv\n"
"foo_sysv:\n"
    "pushq	%rbp\n"
 	"movq	%rsp, %rbp\n"
 	"movq	%rdi, %rax\n"
 	"leaq	(%rax,%rax), %rcx\n"
 	"movq	%rsi, %rdx\n"
 	"movq	%rdx, %rax\n"
 	"addq	%rax, %rax\n"
 	"addq	%rdx, %rax\n"
 	"leaq	(%rax,%rcx), %rax\n"
 	"popq	%rbp\n"
 	"ret\n"
);

// Microsoft x64 calling convention
// first parameters in rcx, rdx
// next 2 in r8, r9
asm(
".global foo_ms64\n"
"foo_ms64:\n"
    "pushq	%rbp\n"
 	"movq	%rsp, %rbp\n"
 	"movq	%rcx, %rax\n"
 	"leaq	(%rax,%rax), %rcx\n"
 	"movq	%rdx, %rdx\n"
 	"movq	%rdx, %rax\n"
 	"addq	%rax, %rax\n"
 	"addq	%rdx, %rax\n"
 	"leaq	(%rax,%rcx), %rax\n"
 	"popq	%rbp\n"
 	"ret\n"
);

int main(int argc, char* argv[]) {
    printf("%d\n",foo_sysv(3,4));
    printf("%d\n",foo_ms64(3,4));
    return 0;
}
