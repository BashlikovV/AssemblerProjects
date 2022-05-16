        org 100h

Start:

        mov ah,0Fh
        int 10h

        mov [BOldMode],al
        mov [BOldPage],ah

        ; set video mode = mov ax,0003h
        mov ax,0013h
        int 10h

        push $A000
        pop es

        xor di,di           ; заполнение экрана белым
        mov al,$0F          ; указатель на 0й пиксель
        mov cx,320*200      ; число закрашиваемых строк
        rep stosb

        xor di,di           ; черный левый прямоугольнник
        mov al,00h          ; цвет
        mov cx,200          ; число закрашиваемых строк
.C1:
        push cx
        mov cx,60           ; число строк
        rep stosb
        add di,320 - 60     ; переход на след строку
        pop cx
        loop .C1

        mov di,320 - 60     ; черный правый прямоугольник
        mov al,00h          ; цвет
        mov cx,200          ; число строк
.C2:
        push cx
        mov cx,60           ; число строк
        rep stosb
        add di,320 - 60     ; переход на след строку
        pop cx
        loop .C2

        mov di, 200 - 15 + 60   ; верхняя правая часть
        mov al,20h            ; 200: размер квадрата
        mov cx,15             ; 15: половина размера синей линии
        mov bx,15             ; 60 - отступ от левого края: (320 - 200) / 2
                              ; cx - количество строк, bx - длинна первой строки
C1:
        push cx
        mov cx,bx             ; половина рисуемой строки
        inc bx
        rep stosb
        sub di,bx            ; 320 - bx = di: длинна поля - длинна линии
        add di,320
        pop cx
        loop C1

                             ; покраска основной части в синий цвет
        mov cx,170           ; cx = 170 = 200 - 15 - 15: 15 - количество строк сверху и снизу
C2:
        push cx
        mov cx,30            ; 30 - длинна строки
        rep stosb
        add di,320           ; di = 320 - lдлинна строки - 1
        sub di,30
        dec di
        pop cx
        loop C2
                             ; левая нижняя часть флага
        mov cx,15            ; cx - количество строк
        mov bx,30            ; bx - длинна строк
C3:
        push cx
        mov cx,bx
        dec bx
        rep stosb
        add di,320           ; di = 320 - длинна линии - 1
        sub di,bx
        dec di
        pop cx
        loop C3

;---------------------------------------------------------------;
        mov di,60  ; верхняя правая часть
        mov al,20h            ; 200: размер квадрата
        mov cx,15             ; 15: половина размера синей линии
        mov bx,15             ; 60: (320 - 200) / 2
                              ; cx - количество строк, bx - длинна первой строки
C4:
        push cx
        mov cx,bx             ; половина рисуемой строки
        dec bx
        rep stosb         ; 320 - bx = di: длинна поля - длинна линии
        add di, 320
        sub di, bx
        pop cx
        loop C4
;--------------------------------;
        mov di, 60
        mov al, 20h
        mov cx, 15
        mov bx, 14

C5:
        push cx
        inc bx
        mov  cx, bx
        rep stosb
        add di, 320
        sub di, bx
        pop cx
        loop C5
;------------------------------;
        mov cx, 170

C6:
        push cx
        mov cx,30            ; 30 - длинна строки
        rep stosb
        add di,320           ; di = 320 - lдлинна строки - 1
        sub di,30
        inc di
        pop cx
        loop C6
                             ; левая нижняя часть флага
        mov cx,15            ; cx - количество строк
        mov bx,30            ; bx - длинна строк

        mov cx,15            ; cx - количество строк
        mov bx,30            ; bx - длинна строк
C7:
        push cx
        mov cx,bx
        dec bx
        rep stosb
        add di,320           ; di = 320 - длинна линии - 1
        sub di,bx
        pop cx
        loop C7


;---------------------------------------------------------------------;

        mov ax,0c08h
        int 21h
        test al,al
        jnz @F
        mov ah,08h
        int 21h
@@:

        movzx ax,[BOldMode]
        int 10h

        mov ah,05h
        mov al,[BOldPage]
        int 10h

ret

BOldMode db ?
BOldPage db ?