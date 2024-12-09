section .data
    correct db "1337", 10
    len_correct equ $ - correct

section .text
global _start

_start:
    ; Récupérer l'adresse du premier paramètre
    mov rsi, [rsp + 16] ; argv[1]
    cmp byte [rsi], '4'
    jne error
    cmp byte [rsi + 1], '2'
    jne error
    cmp byte [rsi + 2], 0
    jne error

    ; Affichage "1337"
    mov rax, 1
    mov rdi, 1
    mov rsi, correct
    mov rdx, len_correct
    syscall

    ; Retourne 0
    mov rax, 60
    xor rdi, rdi
    syscall

error:
    ; Retourne 1
    mov rax, 60
    mov rdi, 1
    syscall
