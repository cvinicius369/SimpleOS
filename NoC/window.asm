[BITS 16]
[ORG 0500h]

pusha
    call Define_Window
popa
    jmp ReturnKernel

; I N C L U S O E S  D E  A R Q U I V O S
%INCLUDE "Hardware/wmemory.lib"

Define_Window:
    mov ah, 0Ch
    mov al, byte[Window_BorderColor]
    mov cx, word[Window_PositionX]
    mov dx, word[Window_PositionY]
    cmp byte[Window_Bar], 0
    je WindowNoBar
    jmp Rets
WindowNoBar: 
    mov bx, word[Window_Width]
    add bx, cx 
    LineUp:
        int 10h
        inc cx
        cmp cx, bx
        jne LineUp
        mov bx, word[Window_Height]
        add bx, dx
    LineRigth:
        int 10h
        inc dx
        cmp dx, bx
        jne LineRigth
        mov bx, word[Window_PositionX]
    LineDown:
        int 10h
        dec cx
        cmp cx, bx
        jne LineDown
        mov bx, word[Window_PositionY]
    LineLeft:
        int 10h
        dec dx
        cmp dx, bx
        jne LineLeft
ret
Rets:
    ret
ReturnKernel:
    ret