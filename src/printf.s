# global data  #
    .data
format: .asciz "%d\n"
.text
    .global main
main:
  push %rbx
  lea  format(%rip), %rdi # load efective address 
                          # instead of writing mov $format ...
  mov  $21, %esi           # Writing to ESI zero extends to RSI.
  xor %eax, %eax          # Zeroing EAX is efficient way to clear AL.
  call printf
  pop %rbx
  ret
