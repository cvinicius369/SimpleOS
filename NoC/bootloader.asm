; ==================================
; BOOTLOADER OF SYSTEM
; BY CAIO VINICIUS
; ==================================
[BITS 16]
[ORG 7C00Bh]

call LoadSystem

LoadSystem:
    mov ah, 02h
    mov al, 1      ; Kernel sector
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 80h
    mov bx, 0800h
    mov es, bx
    mov bx, 0000h
    int 13h
ret

times 510 - ($-$$) db 0
dw 0xAA55