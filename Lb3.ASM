        org 100h

Start:
        mov     ah, 09h
        mov     dx, InputStr
        int     21h

        mov     ah, 02h
        mov     dl, 10
        int     21h

        mov     ah, 02h
        mov     dl, 13
        int     21h

        mov     bx, 0
        mov     dx, 0

.Sycle:
        mov     cl, 0
        mov     cl, byte[ArrayOfInt + bx]

        cmp     bx, 5   ;количество проходов
        je      .Set

        cmp     cl, 7
        jg      .Setting        ;если больше 7 - замена

        Inc     bx

        cmp     cl, 7
        jl      .Sycle          ;если меньше 7 - вернуться

        cmp     cl, 7
        je      .Sycle          ;если равно 7 - вернуться

.Set:
        mov     bx, 0
        push    dx
        jmp     .ExitSycle


.Setting:
        add      dx, 1
        mov      byte[ArrayOfInt + bx], 7
        Inc      bx
        jmp      .Sycle

.ExitSycle:
        cmp     bx, 5
        je      .Exit

        mov     ah, 02h
        mov     dl, byte[ArrayOfInt + bx]
        add     dx, 48
        inc     bx
        int     21h

        jmp     .ExitSycle

.Exit:
        mov     ah, 02h
        mov     dl, 10
        int     21h

        mov     ah, 09h
        mov     dx, StrOutput
        int     21h

        pop     dx
        add     dx, 48

        mov     ah, 02h
        ;mov     dx, Counter
        int     21h

        mov      ah, 08h
        int      21h
        ret

InputStr db 'Array is $'
StrOutput db 'Counter = $'
ArrayOfInt db 9, 2, 9, 6, 10
Counter: db 0000b