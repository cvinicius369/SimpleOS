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
    __CreateWindow 1,1,1,1,16,28,53,5,10,200,150
    __ShowWindow 1
    __CreateField Text1,0,55,30,55,60,100,8
    __ShowField 1
    __CreateField Text2,0,55,30,55,72,100,8
    __ShowField 1
    __CreateField Text3,0,55,30,55,84,100,8
    __ShowField 1
    __CreateButton Button1, "Entrar", 55, 55, 90, 98, 25, 8
    __ShowButton 1
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