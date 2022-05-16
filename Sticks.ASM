        include 'macro\proc16.inc'
        ;include 'Randomize.asm'

struc String Params&
{
  local length
  . db length,  Params
  length = $ - . - 1
}


alLeft    = 0
alCenter  = 1
alRight   = 2

        org 100h

Start:
        cld
        stdcall    Screen.SetMode, $0003
        mov     bx, ax

        stdcall    Screen.WriteString, strHello, 12, alLeft, $90
        stdcall    Keyboard.ReadKey

        push    bx
        stdcall    Screen.SetMode, bx
        ret

proc Screen.WriteString uses es si di,\
     ofsString, nLine, alAlign, bAttr: BYTE

        push    $B800
        pop     es
        mov     di, 80 * 2
        imul    di, [nLine]

        mov     si, [ofsString]
        lodsb
        movzx   cx, al
        mov     ax, [alAlign]
        cmp     ax, alLeft
        je      .DoWriteString

        mov     dx, 80
        sub     dx, cx

        cmp     ax, alRight
        je      @F

        shr      dx, 1

.@@:
        shl     dx, 1
        add     di, dx

.DoWriteString:
        mov     ah, byte[bAttr]
.WriteLoop:
        lodsb
        stosw
        loop    .WriteLoop
        ret
endp

proc Screen.SetMode uses si di,\
     wModeInfo

        mov     ah, 0Fh
        int     10h
        mov     dl, al  ;;Mode number
        mov     dh, bh  ;;Page number

        movzx   ax, byte[wModeInfo]
        int     10h
        mov     ah, 05h
        mov     al, byte[wModeInfo + 1]
        int     10h

        mov     ax, dx

        ret
endp

proc Keyboard.ReadKey
        mov     ax, $0c08
        int     21h
        movzx   cx, al
        test    al, al
        jnz     @F
        mov     ah, $08
        int     21h
        mov     ch, al
@@:
        mov     ax, cx
        ret
endp

strHello        String 'Welcome to the club body!'
