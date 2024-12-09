section .data
    msg db "1337", 10   ; "1337" saut de ligne
    len equ $ - msg

section .text
global _start

_start:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, msg        ; adresse du message
    mov rdx, len        ; taille du message
    syscall

    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; rdi = 0 (code retour)
    syscall
