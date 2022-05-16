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

        mov     bx, 0
        mov     dx, 0

.Sycle:
        mov     cl, 0
        mov     cl, byte[ArrayOfInt + bx]

        push    bx

        mov     ax, 0000

        mov     al, cl  ; Делимое в регистр al
        mov     bl, 3   ; Делитель в регистр bl
        div     bl

        pop     bx

        cmp     ah, 0
        je      .multiple

        Inc     bx

        cmp     bx, 5
        jl      .Sycle

        cmp     bx, 5
        je      .Exit

.multiple:
        add     dx, 1
        push    dx

        mov     dl, byte[ArrayOfInt + bx]
        add     dx, 48

        mov     ah, 02h
        int     21h

        pop     dx

        Inc     bx

        cmp     bx, 5
        je      .Exit

        jmp     .Sycle

.Exit:
        push    dx

        mov     ah, 02h
        mov     dl, 10
        int     21h

        pop     dx
        add     dx, 48
        mov     ah, 02h
        int     21h

        mov      ah, 08h
        int      21h
        ret



StartStr db 'Array is $'
ArrayOfInt db 9, 6, 5, 3, 6