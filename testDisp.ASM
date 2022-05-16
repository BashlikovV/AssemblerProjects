        org 100h

        mov ax, 0013h
        int 10h

        push $A000
        pop es

        mov cx, 320 * 150
        mov di, 0
        mov si, 320
drawLoop:
        ;sub ax, 160 ; move screen up/down
        ;sub dx, 160 ; move screen left/right

        mov ax, 4 ;fill screen with color

        ;mov ax, 1  ;smth random

        ;xor ax, dx  ;smth random
        ;imul ax, ax ;smth random
        ;add here xor,and,or,mov,imul etc with ax, dx, di and si to get arts

        stosb
loop drawLoop

        mov     cx, 320 * 50
        mov     di, 320*150
        mov     si, 320

drawLoop_2:
        mov     ax, 2

        stosb
loop    drawLoop_2

        mov ah, 08h
        int 21h
ret