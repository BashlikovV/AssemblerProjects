        org 100h

        mov     ax, 0013h
        int 10h

        push $A000
        pop     es

        xor     di, di   ;��������� �� 00 �������
        mov     cx, 200  ;����� ������������� �����
        mov     al, $0F ;fill screen with color

C_1:
        push    cx
        mov     cx, 200 ;200 �������� � ������
        rep stosb
        add     di, 120         ;320 - 200 = 120 - ������� � ����� ������
        pop     cx
loop C_1

        xor     di, di
        mov     al, 12h         ;;
        mov     bx, 20          ;����� ������������� ������
        mov     cx, 10          ;����� �����
C_2:
        push    cx
        mov     cx, bx        ;����� ������������� �������� ��� ����
        inc     bx            ;����������� ����� �������� �� 1
        push    cx
        rep stosb
        pop     cx
        add     di, 320       ;������� � ����� ������
        sub     di, cx        ;����� �� cx � ������ ������
        pop     cx

loop C_2

        mov     di, 10 * 320  ;0p 10str - ������ ���������
        mov     cx, 190       ;����� �����
        mov     bx, 30        ;����� ������
Cycle:
        push    cx
        mov     cx, bx        ;����� ������������� ��������
        push    cx
        rep stosb
        pop     cx
        add     di, 320         ;next line
        sub     di, cx         ;����� � ������ ������
        add     di, 1          ;�������� �� ������ ������ �� 1
        pop     cx

loop Cycle

        ;;;------------------------
        mov     di, 320
        mov     al, 20h
        mov     bx, 30
        mov     cx, 10
C_3:
        push    cx
        mov     cx, bx
        inc     bx
        push    cx
        rep stosb
        pop     cx
        add     di, 320
        sub     di, cx
        pop     cx

loop C_3

        mov     di, 195 * 10 ;10p 10str
        mov     cx, 190
        mov     bx, 30
Cycle_2:
        push    cx
        mov     cx, bx
        push    cx
        rep stosb
        pop     cx
        sub     di, 320 ;next line
        sub     di, cx
        add     di, 1
        pop     cx

loop Cycle_2


        mov ah, 08h
        int 21h
ret