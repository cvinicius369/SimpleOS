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
    mov byte[Window_Bar], 1    ; janela com barra ativada
    mov word[Window_PositionX], 5    ; posicao X
    mov word[Window_PositionY], 5    ; posicao y
    mov word[Window_Width], 100  ; pixels de largura
    mov word[Window_Height], 100  ; pixels de altura
    mov byte[Window_BorderColor], 21   ; uma cor clara
    mov byte[Window_BarColor], 16   ; cor da barra
    mov byte[Window_Back_Color], 55   ; azul escuro
    mov byte[Button_Close], 1    ; botao Close ativado
    mov byte[Button_Maximize], 1    ; botao Maximize ativado
    mov byte[Button_Minimize], 1    ; botao Minimize ativado

    ; configuracao de leitura de disco
    mov byte[Sector], 3    ; Numero do setor
    mov byte[Drive], 80h
    mov byte[NumSectors], 2
    mov word[SegmentAddr], 0800h
    mov word[OffsetAddr], 0500h
    call Read_Disk
    call WindowAddress

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