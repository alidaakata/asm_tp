section .bss
    res resb 10             ; Réserver 10 octets pour stocker le résultat sous forme de chaîne

section .text
    global _start

_start:
    ; Récupérer les arguments (les deux nombres)
    mov rsi, [rsp + 16]    ; Premier argument (le premier nombre)
    mov rdi, [rsp + 24]    ; Deuxième argument (le deuxième nombre)

    ; Convertir les arguments de chaîne en entier
    call str2int           ; Convertir le premier argument (rsi) en entier (dans rax)
    mov rbx, rax           ; Sauvegarder le premier nombre dans rbx

    mov rsi, [rsp + 24]    ; Recharger le deuxième argument (rsi)
    call str2int           ; Convertir le deuxième argument (rsi) en entier (dans rax)

    ; Additionner les deux nombres
    add rax, rbx           ; Additionner rax (le second nombre) et rbx (le premier nombre)

    ; Convertir le résultat de l'entier vers la chaîne
    mov rsi, res           ; Réserver l'espace pour la chaîne du résultat
    call int2str           ; Convertir le résultat en chaîne ASCII

    ; Afficher le résultat
    mov rax, 1             ; syscall: sys_write
    mov rdi, 1             ; file descriptor: stdout
    mov rdx, 10            ; Taille maximum de la chaîne (10 caractères)
    syscall

    ; Retourner 0
    mov rax, 60            ; syscall: sys_exit
    xor rdi, rdi           ; code de sortie 0
    syscall

; Convertir une chaîne en entier (par exemple, "10" -> 10)
str2int:
    xor rax, rax           ; Réinitialiser rax (le résultat de l'entier)
    xor rcx, rcx           ; Réinitialiser rcx (index de caractère)

.loop:
    movzx rdx, byte [rsi + rcx]  ; Charger le caractère suivant
    test rdx, rdx               ; Vérifier si c'est la fin de la chaîne (NULL)
    jz .done
    sub rdx, '0'                ; Convertir le caractère en chiffre (ASCII -> nombre)
    imul rax, rax, 10           ; Multiplier rax par 10 (décalage à gauche)
    add rax, rdx                ; Ajouter le chiffre courant à rax
    inc rcx                     ; Passer au caractère suivant
    jmp .loop

.done:
    ret

; Convertir un entier en chaîne (par exemple, 25 -> "25")
int2str:
    mov rcx, 10                ; Diviser par 10 pour obtenir les chiffres
    xor rbx, rbx               ; Réinitialiser rbx (index pour la chaîne)
    add rsi, 10                ; Décaler vers la fin de la chaîne
    mov byte [rsi], 0          ; Ajouter un caractère NULL pour terminer la chaîne

.loop2:
    dec rsi                     ; Décrémenter l'adresse de la chaîne
    xor rdx, rdx                ; Réinitialiser rdx (le reste)
    div rcx                     ; Diviser rax par 10, quotient dans rax, reste dans rdx
    add dl, '0'                 ; Convertir le chiffre du reste en caractère ASCII
    mov [rsi], dl               ; Sauvegarder ce caractère dans la chaîne
    inc rbx                     ; Incrémenter l'index
    test rax, rax               ; Vérifier si le quotient est zéro
    jnz .loop2                  ; Si ce n'est pas zéro, répéter

    ret
