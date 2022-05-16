        org 100h

Start:

        mov ah,0Fh
        int 10h

        mov [BOldMode],al
        mov [BOldPage],ah

        ; set video mode = mov ax,0003h
        mov ax,0013h
        int 10h

        push $A000
        pop es

        xor di,di           ; ���������� ������ �����
        mov al,$0F
        mov cx,320*200
        rep stosb

        xor di,di           ; p������� ����� ��������������
        mov al,00h
        mov cx,200
.C1:
        push cx
        mov cx,60
        rep stosb
        add di,320 - 60
        pop cx
        loop .C1

        mov di,320 - 60     ; ������ ������ �������������
        mov al,00h
        mov cx,200
.C2:
        push cx
        mov cx,60
        rep stosb
        add di,320 - 60
        pop cx
        loop .C2

        mov di, 200 - 15 + 60   ; ������� ������ �����
        mov al,20h            ; 200: ������ ��������
        mov cx,15             ; 15: �������� ������� ����� �����
        mov bx,15             ; 60: (320 - 200) / 2
                              ; cx - ���������� �����, bx - ������ ������ ������
C1:
        push cx
        mov cx,bx
        inc bx
        rep stosb
        sub di,bx            ; 320 - bx = di: ������ ���� - ������ �����
        add di,320
        pop cx
        loop C1

                             ; �������� �������� ����� � ����� ����
        mov cx,170           ; cx = 170 = 200 - 15 - 15: 15 - ���������� ����� ������ � �����
C2:
        push cx
        mov cx,30            ; 30 - ������ ������
        rep stosb
        add di,320           ; di = 320 - l������ ������ - 1
        sub di,30
        dec di
        pop cx
        loop C2
                             ; ����� ������ ����� �����
        mov cx,15            ; cx - ���������� �����
        mov bx,30            ; bx - ������ �����
C3:
        push cx
        mov cx,bx
        dec bx
        rep stosb
        add di,320           ; di = 320 - ������ ����� - 1
        sub di,bx
        dec di
        pop cx
        loop C3

;---------------------------------------------------------------;
        mov di, -11   ; ������� ������ �����
        mov al,20h            ; 200: ������ ��������
        mov cx,15             ; 15: �������� ������� ����� �����
        mov bx,15             ; 60: (320 - 200) / 2
                              ; cx - ���������� �����, bx - ������ ������ ������
C4:
        push cx
        mov cx,bx
        inc bx
        rep stosb
        sub di,bx            ; 320 - bx = di: ������ ���� - ������ �����
        sub di,320
        pop cx
        loop C4

                             ; �������� �������� ����� � ����� ����
        mov cx,170          ; cx = 170 = 200 - 15 - 15: 15 - ���������� ����� ������ � �����
C5:
        push cx
        mov cx,30            ; 30 - ������ ������
        rep stosb
        sub di,320           ; di = 320 - l������ ������ - 1
        sub di,30
        dec di
        pop cx
        loop C5
                             ; ����� ������ ����� �����
        mov cx,15            ; cx - ���������� �����
        mov bx,30            ; bx - ������ �����
C6:
        push cx
        mov cx,bx
        dec bx
        rep stosb
        sub di,320           ; di = 320 - ������ ����� - 1
        sub di,bx
        dec di
        pop cx
        loop C6
;---------------------------------------------------------------------;

        mov ax,0c08h
        int 21h
        test al,al
        jnz @F
        mov ah,08h
        int 21h
@@:

        movzx ax,[BOldMode]
        int 10h

        mov ah,05h
        mov al,[BOldPage]
        int 10h

ret

BOldMode db ?
BOldPage db ?