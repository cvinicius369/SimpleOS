; ==================================
; BOOTLOADER OF SYSTEM
; BY CAIO VINICIUS
; ==================================
[BITS 16]          ; Diretriz 16 BITS
[ORG 7C00h]       ; Endereco do bootloader 7COOBh

call LoadSystem
jmp 0800h:0000h

LoadSystem:
    mov ah, 02h       ; ler discos
    mov al, 1         ; quantidade de setores a ser lido
    mov ch, 0         ; trilha a ser lida
    mov cl, 2         ; setor a ser lido
    mov dh, 0         ; cabecote a ser lido
    mov dl, 80h       ; disco na primeira ordem de boot
    mov bx, 0800h     ; endereco 0800h eh armazenado em bx
    mov es, bx        ; bx eh passado para o segmento extra
    mov bx, 0000h     ; novo endereco para bx
    int 13h           ; interrupçao de disco para realizar leitura
ret

times 510 - ($-$$) db 0   ; preencher os espacos ate 510 bytes
dw 0xAA55                 ; assinatura MBR