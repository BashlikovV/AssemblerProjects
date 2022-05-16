        org 100h

        mov ax, 0013h
        int 10h

        push $A000
        pop es

        mov cx, 320 * 75
        mov di, 0
        mov si, 320
drawLoop:
        mov ax, 15 ;fill screen with color

        stosb
loop drawLoop

        mov     cx, 320 * 75
        mov     di, 320 * 75
        mov     si, 320

drawLoop_2:
        mov     ax, 1

        stosb
loop    drawLoop_2

        mov     cx, 320 * 75
        mov     di, 320 * 140
        mov     si, 320

drawLoop_3:
        mov     ax, 15

        stosb
loop    drawLoop_3


        mov ah, 08h
        int 21h
ret