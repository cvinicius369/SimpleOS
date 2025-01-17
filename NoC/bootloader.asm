; ==================================
; BOOTLOADER OF SYSTEM
; BY CAIO VINICIUS
; ==================================
[BITS 16]          ; Diretriz 16 BITS
[ORG 7C00Bh]       ; Endereco do bootloader 7COOBh

; C H A M A D A S   D E   R O T I N A S
call LoadSystem    ; Chamada de rotina

; R O T I N A S
LoadSystem:                  ; Definicao de rotina
    mov        al, 1         ; Setor 1 onde sera o kernel do sistema
    mov        ch, 0         ; ler o cabecote 0 - primario
    mov        cl, 2         ; ler o cilindro 2
    mov        dh, 0         ; ler o disco 0 - primario
    mov        dl, 80h       ; usar o disco primario (80h)
    mov        bx, 0800h     ; armazena o endereco 0800h na memoria
    mov        es, bx        ; transfere o endereco 0800h para o segmento, indicando o segmento 0800h
    mov        bx, 0000h     ; armazena o novo endereco na memoria (0000h)
    int        13h           ; chamma a BIOS para interromper e fazer a leitura do disco

    jmp 0000h:0800h
ret                          ; retorna para o proximo comando no escopo global

times 510 - ($-$$) db 0      ; Preenchimento dos espacos restantes
dw 0xAA55                    ; Assinatura MBR que permite o reconhecimento do sistema operacional