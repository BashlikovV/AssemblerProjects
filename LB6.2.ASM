       ;ƒальний вызов, передача переменными
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
ResNum dw ?

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

        call far    Procedures:StrToInt        ;ax - число

        mov     [strNum_1], ax

        call far    Procedures:CalcNum_1

        mov     ah, 09h
        mov     dx, strInput_2
        int     21h

        mov     ah, 0ah
        mov     dx, bufInput
        int     21h

        mov     ah, 09h
        mov     dx, strNewLine
        int     21h

        call far    Procedures:StrToInt

        mov     [StrNum_2], ax

        call far   Procedures:CalcNum_2

        call far   Procedures:CalcRes

        mov     ah, 02h
        int     21h

        retf

segment Procedures
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

        retf


CalcNum_1:
        mov    cx, [strNum_1]
        mov    ax, cx   ;первый множитель в ax
        mov    bx, ax   ;второй множитель в bx
        mul    bx  ; ax = ax * bx A^2


        mov     bx, cx
        mul     ebx

        mov    [strNum_1], ax

        retf

CalcNum_2:
        mov     ax, [StrNum_2]
        mov     bx, ax
        mul     bx

        mov     [StrNum_2], ax

        retf

CalcRes:
        mov     ax, [strNum_1]
        mov     bx, [StrNum_2]
        sub     ax, bx

        mov     [ResNum], ax

        call    intToStrAndDisp

        retf

intToStrAndDisp:
        aam

        mov     ax, [ResNum]

        add     ax, '00'
        mov     dl, ah
        mov     dh, al

        mov     ah, 02h
        int     21h

        mov     dl, dh
        int     21h
        retf