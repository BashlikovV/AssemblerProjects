        ;Ближний вызов, передача через стек
        org 100h

Start:
        mov     ah, 09h
        mov     dx, strInput_1
        int     21h

        mov     ah, 0ah
        mov     dx, bufInput
        int     21h

        mov     ah, 09h
        mov     dx, strNewLine
        int     21h

        call    StrToInt        ;ax - число

        push    ax
        call    CalcNum_1

        mov     [strNum_1], ax

        mov     ah, 09h
        mov     dx, strInput_2
        int     21h

        mov     ah, 0ah
        mov     dx, bufInput
        int     21h

        mov     ah, 09h
        mov     dx, strNewLine
        int     21h

        call    StrToInt

        push    ax
        call    CalcNum_2

        mov     [StrNum_2], ax

        mov     ax, [strNum_1]
        mov     bx, [StrNum_2]
        sub     ax, bx

        call    intToStrAndDisp

        mov     ah, 08h
        int     21h

        ret

StrToInt:
        mov     cl, [bufInput + 1]
        mov     ch, 0
        mov     si, 2
        mov     ax, 0
        mov     di, 10
        .LoopLabel1:
        mul     di
        mov     bl, [bufInput + si]
        sub     bl, 48
        mov     bh, 0
        add     ax, bx
        inc     si
        loop .LoopLabel1
        ret


CalcNum_1:
        push bp
        mov     bp, sp

        mov    cx, [bp+4]
        mov    bx, cx   ;второй множитель в bx
        mul    bx  ; ax = ax * bx A^2
        mul    bx
        pop    bp

retn 2

CalcNum_2:
        push bp
        mov     bp, sp

        mov    cx, [bp+4]
        mov    bx, cx   ;второй множитель в bx
        mul    bx  ; ax = ax * bx A^2
        pop    bp

retn 2

intToStrAndDisp:
        aam

        ;mov     ax, [ResNum]
        pop      ax

        add     ax, '00'
        mov     dl, ah
        mov     dh, al

        mov     ah, 02h
        int     21h

        mov     dl, dh
        int     21h
        ret

strInput_1 db 'Enter a number_1: $'
strInput_2 db 'Enter a number_2: $'
strOutput db 'Result: $'
strNewLine db 13, 10, '$'
bufInput db 5, 0, 5 dup (?)
strNum_1 dw ?
StrNum_2 Dw ?
ResNum dw ?
