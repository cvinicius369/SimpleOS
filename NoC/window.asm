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
    jmp Window_WithBar
WindowNoBar: 
    mov bx, word[Window_Width]
    add bx, cx 
    LineUp:
        int 10h
        inc cx
        cmp cx, bx
        jne LineUp  
       call Border_RightDown
        mov bx, word[Window_PositionY]
    LineLeft:
        int 10h
        dec dx
        cmp dx, bx
        jne LineLeft
        call BackColor
        jmp Rets
ret
Rets:
    ret
Window_WithBar:
    mov al, byte[Window_BarColor]
    mov bx, word[Window_Width]
    add bx, cx 
    push ax
    mov ax, dx
    add ax, 9
    mov [State_WindowBar], ax 
    pop ax
    Paint_Bar:
        int 10h
        inc cx 
        cmp cx, bx 
        jne Paint_Bar
        int 10h
        inc dx 
        inc al
        cmp dx, word[State_WindowBar]
        jne BackColumn
        mov al, byte[Window_BorderColor]
        call Border_RightDown
        mov bx, word[Window_PositionY]
        add bx, 8
        Line_LeftBar:
            int 10h
            dec dx
            cmp dx, bx 
            jne Line_LeftBar
            call BackColor
            ; call ButtonsBar
            jmp Rets
    BackColumn:
        mov cx, word[Window_PositionX]
        mov bx, word[Window_Width]
        add bx, cx
        push bx
        mov bx, word[State_WindowBar]
        sub bx, 6
        cmp dx, bx
        ja Inc_ColorAgain
        pop bx 
        jmp Paint_Bar
    Inc_ColorAgain:
        pop bx 
        inc al
        jmp Paint_Bar

Border_RightDown:
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
ret

BackColor:
    mov al, byte[Window_Back_Color]
    mov cx, word[Window_PositionX]
    mov dx, word[Window_PositionY]
    cmp byte[Window_Bar], 1
    je WithBar
    jmp NoBar
WithBar:
    add dx, 9
    mov word[Back_InitialPosition_Y], dx 
    add word[Back_InitialPosition_Y], 1
    jmp Salt
NoBar:
    inc dx
    mov word[Back_InitialPosition_Y], dx
Salt:
    inc cx
    mov word[Back_InitialPosition_X], cx
Initial:
    mov cx, word[Back_InitialPosition_X]
    mov bx, word[Window_Width]
    add bx, cx
    sub bx, 1
Columns:
    int 10h
    inc cx
    cmp cx, bx
    jne Columns
    mov bx, word[Window_Height]
    add bx, word[Back_InitialPosition_Y]
    sub bx, 1
Rows:
    inc dx
    cmp dx, bx
    jne Initial
ret
ReturnKernel:
    ret