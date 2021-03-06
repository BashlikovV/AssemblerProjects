        Format MZ
        entry Main:Start

segment DataSegment
strInput_1 db 'Enter a number_1: $'
strInput_2 db 'Enter a number_2: $'
strOutput db 'Result: $'
strNewLine db 13, 10, '$'
bufInput db 5, 0, 5 dup (?)
strNum_1 dw ?
StrNum_2 Dw ?

segment Main
Start:
        mov     ax, DataSegment
        mov     ds, ax

        mov     ah, 09h
        mov     dx, strInput_1
        int     21h

        mov     ah, 0ah
        mov     dx, bufInput
        int     21h

        mov     ah, 09h
        mov     dx, strNewLine
        int     21h

        call    StrToInt        ;ax - �����
        call    CalcNum_1

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
        call    CalcNum_2

        call    CalcRes

        mov     ah, 02h
        int     21h

        retf

StrToInt:
        push bp
        mov     bp, sp

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

        mov     sp, bp
        pop     bp

        ret


CalcNum_1:
        mov    cx, ax
        mov    ax, ax   ;������ ��������� � ax
        mov    bx, ax   ;������ ��������� � bx
        mul    bx  ; ax = ax * bx A^2


        mov     bx, cx
        mul     ebx

        mov    [strNum_1], ax

        ret

CalcNum_2:
        mov     ax, ax
        mov     bx, ax
        mul     bx

        mov     [StrNum_2], ax

        ret

CalcRes:
        mov     ax, [strNum_1]
        mov     bx, [StrNum_2]
        sub     ax, bx

        call    intToStrAndDisp

        ret

intToStrAndDisp:
        aam

        add     ax, '00'
        mov     dl, ah
        mov     dh, al

        mov     ah, 02h
        int     21h

        mov     dl, dh
        int     21h
        retf