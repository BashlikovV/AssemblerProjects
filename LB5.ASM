        org 100h

Start:
        mov     ah, 09h
        mov     dx, StartStr
        int     21h

        mov     ah, 02h
        mov     dl, 10
        int     21h

        mov     ah, 02h
        mov     dl, 13
        int     21h

        mov     al, 'l'
        mov     di, string
        mov     cx, 13

Again:
        repnz   scasb
        cmp    cx, 0
        je     exit


        mov     ax, 13 ;;
        sub     ax, cx
        jmp     IntToStr

exit:
        mov     ah, 08h
        int     21h
        ret

IntToStr:
        aam ;меняет местами

        add     ax, '00'
        mov     dl, ah
        mov     dh, al

        mov     ah, 02h
        int     21h

        mov     dl, dh
        int     21h
        mov     al, 'l'
        jmp     Again


string db 'Hello strting$'
StartStr db 'enter the desired letter$'
EndStr db 'End$'
readln db 9, 0, 10 dup ('$')
Save dw 0