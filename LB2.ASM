        org 100h
Start:
        ;вывод строки
        mov     ah, 09h
        mov     dx, StartStr
        int     21h

        ;ввод строки
        mov     ah, 0ah
        mov     dx, bufInput
        int     21h

        ;
        mov     ah, 09h
        mov     dx, NewLine
        int     21h

        ;Проверка на длинну
        mov     bx, word[bufInput+1]
        cmp     bx, 4h
        js      Start.notCorrect

        ;Второй символ буква?
        mov     ch, byte[bufInput+3]
        cmp     ch, 'a' ;cравниваем с 'a'
        js      Start.notCorrect

        ;L-1 символ цифра?
        ;mov     bx, word[bufInput+1]
        ;mov     ch, byte[bufInput+bx-1]
        ;cmp     ch, '1' ;;L-1 сравниваем с '1'

        mov      bh, [bufInput+1]
        mov      [var], bh

        mov      bp, bufInput-2
        mov      dx, 0
        mov      dl, [var]
        add      bp, dx

        mov      bh, [bp]
        jmp      testNum

        js      Start.notCorrect

        ;Проверка на равные символы
        mov     bl, byte[bufInput+3];2
        cmp     bl, byte[bufInput+5];4
        je      Start.Correct


.notCorrect:
        mov     ah, 09h
        mov     dx, strNo
        int     21h
        jmp     Start.EndLabel

.Correct:
        mov     ah, 09h
        mov     dx, strYes
        int     21h
        jmp     Start.EndLabel

.EndLabel:
        mov     ax, 0c08h
        int     21h
        test    al, al
        jnz     @F
        mov     ah, 08h
        int     21h

@@:
        ret


set3:
        mov bh, [bufInput+4]
        mov bl, 3

testNum:
        cmp      bh, 65
        jl       skip

        cmp      bh, 122
        jg       skip

        cmp      bh, 91
        je       skip

        cmp      bh, 92
        je       skip

        cmp      bh, 93
        je       skip

        cmp      bh, 94
        je       skip

        cmp      bh, 95
        je       skip

        cmp      bh, 96
        je       skip

        cmp      bh, 96
        je       skip

        cmp      bl, 3
        jne      set3

;===Everything is ok===;

        mov ah, 09h
        mov dx, yes
        int 21h

        mov ah, 08h
        int 21h

ret

StartStr db "Enter new line: $"
NewLine db 10, 13, '$'
bufInput db 9, 0, 9 dup(?)
var db 0
strNo db "No$"
strYes db "Yes$"