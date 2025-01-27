[BITS 16]
[ORG 0500h]

pusha
    call Define_Window
popa
    jmp Return

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
    call Border_UP
    LineUp:
        int 10h
        inc cx
        cmp cx, bx
        jne LineUp  
        call Border_RightDown
        mov bx, word[Window_PositionY]
        call Border_Left
    LineLeft:
        int 10h
        dec dx
        cmp dx, bx
        jne LineLeft
        call BackColor
        jmp Return
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
        ; call Border_Left
        Line_LeftBar:
            int 10h
            dec dx
            cmp dx, bx 
            jne Line_LeftBar
            call BackColor
            call ButtonsBar
            jmp Return
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
    call Border_Right
    LineRigth:
        int 10h
        inc dx
        cmp dx, bx
        jne LineRigth
        mov bx, word[Window_PositionX]
        call Border_Down
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
ButtonsBar:
    mov bx, word[Window_PositionX]
    mov word[SavePositionX], bx
    mov bx, word[Window_PositionY]
    mov word[SavePositionY], bx
    mov bx, word[Window_Width]
    mov word[SaveWidth], bx
    mov bx, word[Window_Height]
    mov word[SaveHeigth], bx
    Button0:
        cmp byte[Button_Close], 1
        je Close
    Button1:
        cmp byte[Button_Maximize], 1
        je Maximize
    Button2:
        cmp byte[Button_Minimize],1
        je Minimize
        jmp Return
Close:
    mov al, 42
    mov dx, 7
    call ButtonProperty
    call Define_Window
    mov ah, 0Ch
    mov al, 30
    sub cx, 2
    sub dx, 2
    int 10h
    dec cx
    dec dx
    int 10h
    dec cx
    dec dx
    int 10h
    add cx, 2
    int 10h
    sub cx, 2
    add dx, 2
    int 10h
    jmp Button1
Maximize:
    mov al, 25
    mov dx, 15
    call ButtonProperty
    call Define_Window
    mov ah, 0Ch
    mov al, 30
    sub cx, 2
    sub dx, 2
    int 10h 
    dec cx
    int 10h
    dec cx
    int 10h
    dec dx 
    int 10h 
    dec dx 
    int 10h
    inc cx 
    int 10h
    inc cx
    int 10h
    inc dx 
    int 10h
    jmp Button2
Minimize:
    mov al, 25
    mov dx, 23
    call ButtonProperty
    call Define_Window
    mov ah, 0Ch
    mov al, 30
    sub cx, 2
    sub dx, 2
    int 10h
    dec cx
    int 10h
    dec cx
    int 10h
    jmp Return
ButtonProperty:
    mov byte[Window_Bar], 0
    mov byte[Window_BorderColor], al 
    mov byte[Window_Back_Color], al 
    mov ax, word[SavePositionX]
    mov cx, word[SaveWidth]
    add ax, cx
    sub ax, dx
    mov word[Window_PositionX], ax 
    mov ax, word[SavePositionY]
    add ax, 1
    mov word[Window_PositionY], ax
    mov word[Window_Width], 6
    mov word[Window_Height], 6
ret

Border_UP:
    cmp byte[Window_Border], 1
    jne Return
    mov al, byte[Window_Border_Up] 
ret
Border_Right:
    cmp byte[Window_Border], 1
    jne Return
    mov al, byte[Window_Border_Rigth] 
ret
Border_Down:
    cmp byte[Window_Border], 1
    jne Return
    mov al, byte[Window_Border_Down] 
ret 
Border_Left:
    cmp byte[Window_Border], 1
    jne Return
    mov al, byte[Window_Border_Left] 
ret

Return:
ret