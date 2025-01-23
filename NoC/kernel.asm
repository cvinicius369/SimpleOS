; =================================
; KERNEL OF SYSTEM
; BY CAIO VINICIUS
; =================================
[BITS 16]          ; Diretriz 16 BITS
[ORG 0000h]        ; Endereco 0000h:0800h definido no bootloader

jmp OSMain

; D I R E T I V A S   E   I N C L U S O E S 
%INCLUDE "Hardware/wmemory.lib"
%INCLUDE "Hardware/monitor.lib"           ; Inclusao da biblioteca monitor.lib
%INCLUDE "Hardware/disk.lib"
%INCLUDE "Hardware/win16.lib"

OSMain:
    call ConfigSegment
    call ConfigStack
    call VGA.SetVideoMode
    call DrawBackground
    call EffectInit
    call GrafficInterface
    jmp END

; K E R N E L   F U N C T I O N S
GrafficInterface:
    ; configuracao de leitura de disco
    __LoadInterface
    __CreateWindow 1,1,1,1,16,21,55,5,5,100,100
    __ShowWindow 1

    mov byte[Window_Bar], 0
    mov word[Window_PositionX], 20
    mov word[Window_PositionY], 20
    mov word[Window_Width], 65
    mov word[Window_Height], 65
    mov byte[Window_Back_Color], 21
    mov byte[Window_BorderColor], 55
    mov byte[Window_Border], 1
    mov byte[Window_Border_Rigth], 29
    mov byte[Window_Border_Down], 29
    mov byte[Window_Border_Left], 0
    mov byte[Window_Border_Up], 0
    call WindowAddress
ret
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