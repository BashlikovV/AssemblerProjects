        org 100h

        mov ax, 0013h
        int 10h

        push $A000
        pop es

        mov cx, 320 * 150
        mov di, 320*50
        mov si, 320
drawLoop:
        mov ax, 4 ;fill screen with color

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