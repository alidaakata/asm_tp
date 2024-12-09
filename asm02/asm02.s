section .bss
    input resb 5        ; Buffer pour l'entrée utilisateur (4 octets pour "42" + 1 pour '\n')

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
    mov rdx, 5          ; nombre max d'octets (4 caractères + '\n')
    syscall

    ; Comparaison avec "42\n"
    mov al, [input]
    cmp al, '4'         ; comparer premier caractère avec '4'
    jne error           ; si ce n'est pas '4', aller à l'erreur
    mov al, [input + 1] ; comparer deuxième caractère avec '2'
    cmp al, '2'
    jne error           ; si ce n'est pas '2', aller à l'erreur
    mov al, [input + 2] ; comparer troisième caractère avec '\n'
    cmp al, 10          ; '\n' a le code ASCII 10
    jne error           ; si ce n'est pas '\n', aller à l'erreur

    ; Afficher "1337"
    mov rax, 1
    mov rdi, 1
    mov rsi, correct
    mov rdx, len_correct
    syscall

    ; Retourner 0 (indique succès)
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; code de sortie 0
    syscall

error:
    ; Retourner 1 (indique échec)
    mov rax, 60         ; syscall: exit
    mov rdi, 1          ; code de sortie 1
    syscall
