        org 100h

Start:
        mov     ah, 0Fh
        int     10h
        mov     [bOldMode], al
        mov     [bOldMode], bh

        mov     ax, 0013h       ;00h, 03h
        int     10h

        push    $A000
        pop     es
        ;xor     di, di
        ;mov     al, 60h
        ;mov     cx, 320 * 200
        ;rep stosb
       ; ==============
        ;xor     di, di
        ;mov     cx, 200
;.RowLoop:
        ;push    cx
        ;mov     cx, 256
        ;xor     al, al

;.ColLoop:
        ;stosb
        ;inc     al
        ;loop    .ColLoop

        ;add     di, 320 - 256
        ;pop     cx
        ;loop    .RowLoop

        mov     cx, 320 * 200
        xor     di, di
        mov     si, 320

.DrawLoop:
        xor     dx, dx
        mov     ax, di
        div     si
        xor     ax, dx
        stosb
        loop    .DrawLoop

        mov     ax, 0C08h
        int     21h
        test    al, al
        jnz     @F
        mov     ah, 08h
        int     21h

@@:
        movzx     ax, [bOldMode]
        int       10h
        mov       ah, 05h
        mov       al, [bOldPage]
        int       10h
        ret

bOldMode        db      ?
bOldPage        db      ?