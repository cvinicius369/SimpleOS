; =================================
; KERNEL OF SYSTEM
; BY CAIO VINICIUS
; =================================
[BITS 16]
[ORG 0000h]
jmp Main
; I N C L U S I O N S  A N D  D I R E C T I V E S 
%INCLUDE "Hardware/monitor.lib"

; I N I T I A L I Z I N G  S Y S T E M
Main:
    call ConfigSegments
    call ConfigStacks
    call VGA.SetVideoMode
    call DrawBackground
    call EffectInit
    jmp END

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