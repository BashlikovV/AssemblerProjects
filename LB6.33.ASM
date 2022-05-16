        org 100h
Start:
        mov ah, 09h
        mov dx, writeln1
        int 21h

        mov ah, 0ah
        mov dx, readln1         ;¬вод 1го числа
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, writeln2
        int 21h

        mov ah, 0ah
        mov dx, readln2         ;¬вод 2го числа
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ax, 0
        mov al, [readln1+2]
        sub al, '0'

        mov bx, 0
        mov bl, [readln2+2]
        sub bl, '0'

        push ax
        push bx

        call operations         ;A^3-B^2

        aam

;Str to int
        add ax, '00'
        mov dl, ah
        mov dh, al
                
        mov ah, 02h
        int 21h
                
        mov dl, dh
        int 21h

        mov ah, 08h
        int 21h

ret

operations:
        push bp
        mov bp, sp
        mov ax, [bp+4]
        mov bx, [bp+4]
        mul bx
        mul bx
        mov cx, ax

        mov ax, [bp+6]
        mov bx, [bp+6]
        mul bx
        sub cx, ax
        mov ax, cx

        pop bp
retn 4

        writeln1 db "Enter the number 1: $"
        writeln2 db "Enter the number 2: $"
        newLine db 13, 10, '$'
        readln1 db 2, 0, 2 dup "$"
        readln2 db 2, 0, 2 dup "$"