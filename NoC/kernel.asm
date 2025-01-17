; =================================
; KERNEL OF SYSTEM
; BY CAIO VINICIUS
; =================================
[BITS 16]          ; Diretriz 16 BITS
[ORG 0x0800]       ; Endereco 0000h:0800h definido no bootloader

; I N C L U S I O N S  A N D  D I R E C T I V E S 
%INCLUDE "Hardware/monitor.lib"           ; Inclusao da biblioteca monitor.lib

; C H A M A D A S  
call Main             ; Chamando a rotina main 
; I N I T I A L I Z I N G  S Y S T E M
Main:                      ; definindo a rotina main
    ; Chamando as demais rotinas
    call ConfigSegments
    call ConfigStacks
    call VGA.SetVideoMode
    call DrawBackground
    call EffectInit
    jmp END                 ; pulando para o final do codigo apos realizar todas as rotinas 

; K E R N E L  F U N C T I O N S
ConfigSegments:
    mov ax, es
    mov ds, ax
ret
ConfigStacks:
    mov ax, 7D00h
    mov ss, ax
    mov sp, 03FEh
ret
END:
    mov ah, 00h 
    int 16h
    mov ax, 0040h
    mov ds, ax 
    mov ax, 1234h
    mov [0072h], ax