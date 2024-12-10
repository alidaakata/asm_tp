; asm07/asm07.s
section .bss
    number resb 10

section .text
    global _start

_start:
    ; Lire l'entrée
    mov rax, 0          ; sys_read
    mov rdi, 0
    mov rsi, number
    mov rdx, 10
    syscall

    ; Convertir ASCII en entier
    mov rbx, number
    call str_to_int

    ; Vérifier si le nombre est premier
    mov rdi, rax        ; rdi = nombre
    call is_prime

    ; Sortie avec le code de retour
    mov rdi, rax
    mov rax, 60         ; sys_exit
    syscall

; Fonction : vérifier si le nombre est premier
is_prime:
    cmp rdi, 2
    jl not_prime
    mov rcx, 2
check_loop:
    mov rax, rdi
    xor rdx, rdx
    div rcx
    test rdx, rdx
    jz not_prime
    inc rcx
    cmp rcx, rdi
    jl check_loop
    mov rax, 0          ; Premier
    ret
not_prime:
    mov rax, 1          ; Non premier
    ret

; Fonction : convertir une chaîne en entier
str_to_int:
    xor rax, rax
convert_loop:
    movzx rcx, byte [rbx]
    cmp rcx, 10
    je end_convert
    sub rcx, '0'
    imul rax, rax, 10
    add rax, rcx
    inc rbx
    jmp convert_loop
end_convert:
    ret
