format ELF64 executable 3

start:
  mov rax, 1
  mov rdi, 1
  mov rsi, hello
  mov rdx, 13
  syscall

  mov rax, 60
  mov rdi, 69
  syscall

hello:
  file "message.txt"
