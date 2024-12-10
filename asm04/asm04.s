; asm04/asm04.s
section .bss
    number resb 10

section .text
    global _start

_start:
    ; Lire depuis l'entrée standard
    mov rax, 0          ; syscall: sys_read
    mov rdi, 0          ; stdin
    mov rsi, number     ; buffer
    mov rdx, 10         ; taille max
    syscall

    ; Convertir ASCII en entier
    mov rax, 0          ; Initialiser le nombre
    mov rbx, number
convert_loop:
    movzx rcx, byte [rbx]
    cmp rcx, 10         ; Vérifier fin de la chaîne
    je verification
    sub rcx, '0'        ; Convertir ASCII en entier
    imul rax, rax, 10
    add rax, rcx
    inc rbx
    jmp convert_loop

verification:
    test rax, 1         ; Tester si le nombre est impair
    jz retour
    mov rax, 1          ; Retourner 1 si impair
    jmp exit

retour:
    mov rax, 0          ; Retourner 0 si pair

exit:
    mov rdi, rax        ; Code de sortie
    mov rax, 60         ; syscall: exit
    syscall
