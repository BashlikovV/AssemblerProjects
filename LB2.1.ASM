        org 100h

start:
        ;вывод строки
        mov      ah, 09h
        mov      dx, writeln
        int      21h

        ;ввод строки
        mov      ah, 0ah
        mov      dx, readln
        int      21h

        ;вывод
        mov      ah, 02h
        mov      dl, 10
        int      21h

        ;вывод
        mov      ah, 02h
        mov      dl, 13
        int      21h

;проверка второго и четвертого символа

        mov      al, [readln+3]
        mov      bl, [readln+5]

        cmp      al, bl
        jne      skip

;проверка на длинну

        mov      al, [readln+1]
        cmp      al, 5h
        jl       skip

;нахождение символа N-1

        mov      bh, [readln+1]
        mov      [var], bh

        mov      bp, readln-2
        mov      dx, 0
        mov      dl, [var]
        add      bp, dx

        mov      bh, [bp]
        jmp      testNum

set3:
        mov      bh, [readln+4]
        mov      bl, 3

;ошибка если N-1 не буква

testNum:
        ;от ASCII-48 = 0
        cmp      bh, 48
        jl       skip

        ;до ASCII-57 = 9
        cmp      bh, 57
        jg       skip

        cmp      bl, 3
        jne      set3

;если все в порядке

        mov      ah, 09h
        mov      dx, yes
        int      21h

        mov      ah, 08h
        int      21h
        ret

skip:
        mov      ah, 09h
        mov      dx, no
        int      21h

        mov      ah, 08h
        int      21h
        ret

writeln: db "Enter the text: $"
readln db 9, 0, 10 dup ('$')
yes db 'Yes$'
no db 'No$'
var db 0