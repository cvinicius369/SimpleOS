; =================================
; KERNEL OF SYSTEM
; BY CAIO VINICIUS
; =================================
[BITS 16]          ; Diretriz 16 BITS
[ORG 0000h]        ; Endereco 0000h:0800h definido no bootloader

jmp OSMain

; D I R E T I V A S   E   I N C L U S O E S 
%INCLUDE "Hardware/monitor.lib"           ; Inclusao da biblioteca monitor.lib

OSMain:
    call ConfigSegment
    call ConfigStack
    call VGA.SetVideoMode
    call DrawBackground
    call EffectInit
    jmp END

; K E R N E L   F U N C T I O N S
ConfigSegment:
    mov ax, es    ; guardando o segmento extra em ax
    mov ds, ax
ret
ConfigStack:
    mov ax, 7D00h
    mov ss, ax
    mov sp, 03FEh
ret
END: 
    mov ah, 00h 
    int 16h
    int 19h
    ; mov ax, 0040h
    ; mov ds, ax
    ; mov ax 1234h
    ; mov [0072h], ax
    ; jmp 0FFFFh:0000h