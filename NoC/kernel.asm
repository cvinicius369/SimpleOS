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
    mov byte[Window_Bar], 0
    mov word[Window_PositionX], 5
    mov word[Window_PositionY], 5
    mov word[Window_Width], 100
    mov word[Window_Height], 150
    mov byte[Window_BorderColor], 55
    mov byte[Sector], 3
    mov byte[Drive], 80h
    mov byte[NumSectors], 1
    mov word[SegmentAddr], 0800h
    mov word[OffsetAddr], 0500h
    call Read_Disk
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