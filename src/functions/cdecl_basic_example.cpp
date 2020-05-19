#include <cstdio>
  extern "C"  int foo(int,int);

asm(
".global foo\n"
"foo:\n"
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

int main(int argc, char* argv[]) {
    printf("%d",foo(3,4));
    return 0;
}
