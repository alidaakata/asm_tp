section .data
    correct db "1337", 10
    len_correct equ $ - correct

section .text
global _start

_start:
    ; Vérifier que nous avons au moins un argument
    mov rdi, [rsp + 8]    ; rdi pointe sur argc
    cmp rdi, 1             ; On vérifie si argc > 1
    jle error              ; Si argc <= 1, on va directement à l'erreur

    ; Récupérer l'adresse du premier paramètre (argv[1])
    mov rsi, [rsp + 16]    ; rsi pointe sur argv[1]

    ; Comparaison avec "42"
    cmp byte [rsi], '4'    ; Vérifier si le premier caractère est '4'
    jne error              ; Si ce n'est pas '4', aller à l'erreur
    cmp byte [rsi + 1], '2' ; Vérifier si le deuxième caractère est '2'
    jne error              ; Si ce n'est pas '2', aller à l'erreur
    cmp byte [rsi + 2], 0   ; Vérifier la fin de la chaîne (doit être '\0')
    jne error              ; Si ce n'est pas la fin de la chaîne, aller à l'erreur

    ; Affichage "1337"
    mov rax, 1             ; syscall: write
    mov rdi, 1             ; stdout
    mov rsi, correct       ; buffer contenant "1337\n"
    mov rdx, len_correct   ; taille de la chaîne "1337\n"
    syscall

    ; Retourne 0 (indique succès)
    mov rax, 60            ; syscall: exit
    xor rdi, rdi           ; code de sortie 0
    syscall

error:
    ; Retourne 1 (indique échec)
    mov rax, 60            ; syscall: exit
    mov rdi, 1             ; code de sortie 1
    syscall
