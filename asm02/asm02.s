section .bss
    input resb 4        ; Buffer pour l'entrée utilisateur

section .data
    correct db "1337", 10
    len_correct equ $ - correct

section .text
global _start

_start:
    ; Lecture de l'entrée
    mov rax, 0          ; syscall: read
    mov rdi, 0          ; stdin
    mov rsi, input      ; buffer
    mov rdx, 4          ; nombre max d'octets
    syscall

    ; Comparaison avec "42\n"
    mov al, [input]
    cmp al, '4'
    jne error
    mov al, [input + 1]
    cmp al, '2'
    jne error

    ; Afficher "1337"
    mov rax, 1
    mov rdi, 1
    mov rsi, correct
    mov rdx, len_correct
    syscall

    ; Retourner 0
    mov rax, 60
    xor rdi, rdi
    syscall

error:
    ; Retourner 1
    mov rax, 60
    mov rdi, 1
    syscall
