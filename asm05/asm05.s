section .text
    global _start

_start:
    ; Charger le premier argument (la chaîne passée en paramètre)
    mov rsi, [rsp + 16]   ; rsi pointe sur le 1er argument (la chaîne)
    mov rax, 1            ; syscall: sys_write
    mov rdi, 1            ; file descriptor: stdout
    mov rdx, 0            ; Compteur de taille (sera calculé)

compte_taille:
    cmp byte [rsi + rdx], 0  ; Vérifier si on est à la fin de la chaîne (null byte)
    je afficher_chaine       ; Si oui, on peut afficher la chaîne
    inc rdx                  ; Incrémenter la taille
    jmp compte_taille        ; Recommencer la boucle

afficher_chaine:
    syscall                ; Appel système pour écrire la chaîne

    ; Sortie du programme
    mov rax, 60            ; syscall: exit
    xor rdi, rdi           ; Code de retour 0
    syscall
