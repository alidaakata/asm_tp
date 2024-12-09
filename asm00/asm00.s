section .text
global _start

_start:
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; rdi = 0 (code retour)
    syscall

