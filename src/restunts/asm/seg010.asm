.model medium
nosmart
    include structs.inc
    include custom.inc
    include seg000.inc
    include seg001.inc
    include seg002.inc
    include seg003.inc
    include seg004.inc
    include seg005.inc
    include seg006.inc
    include seg007.inc
    include seg008.inc
    include seg009.inc
    include seg011.inc
    include seg012.inc
    include seg013.inc
    include seg014.inc
    include seg015.inc
    include seg016.inc
    include seg017.inc
    include seg018.inc
    include seg019.inc
    include seg020.inc
    include seg021.inc
    include seg022.inc
    include seg023.inc
    include seg024.inc
    include seg025.inc
    include seg026.inc
    include seg027.inc
    include seg028.inc
    include seg029.inc
    include seg030.inc
    include seg031.inc
    include seg032.inc
    include seg033.inc
    include seg034.inc
    include seg035.inc
    include seg036.inc
    include seg037.inc
    include seg038.inc
    include seg039.inc
    include dseg.inc
    include seg041.inc
seg010 segment byte public 'STUNTSC' use16
    assume cs:seg010
    assume es:nothing, ss:nothing, ds:dseg
    public byte_2CC52
    public start
    public __amsg_exit
    public libsub_quit_to_dos_alt
    public libsub_quit_to_dos
    public loc_2CE06
    public sub_2CE4A
    public sub_2CE77
    public __FF_MSGBANNER
    public __fptrap
    public __chkstk
    public __nullcheck
    public __setargv
    public __setenvp
    public __NMSG_TEXT
    public __NMSG_WRITE
    public __myalloc
    public __dosretax
    public __maperror
    public sub_2D1BC
    public _flushall
    public _printf
    public __flsbuf
    public __getbuf
    public __stbuf
    public __ftbuf
    public _fflush
    public __output
    public off_2D896
    public iprint
    public sprint
    public fprint
    public _outc
    public putpad
    public putbuf
    public _out
    public putsign
    public putprefix
    public getnum
    public flagchar
    public _lseek
    public _write
    public _stackavail
    public unknown_libname_1
    public unknown_libname_2
    public loc_2E0BE
    public __amalloc
    public loc_2E18F
    public __amexpand
    public __amlink
    public __amallocbrk
    public _brkctl
    public sub_2E290
    public _strcat
    public _strcpy
    public _strcmp
    public _strlen
    public _itoa
    public _ultoa
    public _abort
    public _isatty
    public _int86
    public _sprintf
    public _stricmp
    public __cltoasub
    public __cxtoa
    public _abs
    public off_2E59E
    public _raise
    public loc_2E61E
    public loc_2E626
    public loc_2E635
    public _srand
    public _rand
    public _signal
    public __sigentry
    public _strrchr
    public __aFldiv
    public __aFlmul
    public __aFlshr
    public unknown_libname_3
    public __aFFblmul
    public unknown_libname_4
    public unknown_libname_5
    public __aFuldiv
byte_2CC52     db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
start proc near
     r = byte ptr 0

    mov     ah, 30h
    int     21h             ; DOS - GET DOS VERSION
    cmp     al, 2
    jnb     short loc_2CC6C
    int     20h             ; DOS - PROGRAM TERMINATION
loc_2CC6C:
    mov     di, seg dseg
loc_2CC6F:
    ; begin hack the crt startup
    ; assume endseg is linked at the end of the program
    mov si, seg endseg + 1 ; +1 in case endseg is not aligned at 0
    sub si, di
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ; end hack the crt startup
loc_2CC7E:
    cli
    mov     ss, di          ; ss = dseg
    add     sp, 0AD1Eh      ; sp = end of stack in data segment
    sti
    jnb     short _no_stack_overflow; check for overflow and abort if there was more than 64k data+stack
    push    ss
    pop     ds
    call    __FF_MSGBANNER
    xor     ax, ax
    push    ax
    call    __NMSG_WRITE
    mov     ax, 4CFFh
    int     21h             ; DOS - 2+ - QUIT WITH EXIT CODE (EXIT)
_no_stack_overflow:
smart
    and     sp, 0FFFEh
nosmart
    mov     ss:crtsp1, sp
loc_2CCA4:
    mov     ss:crtsp2, sp
    mov     ax, si
loc_2CCAB:
    mov     cl, 4
    shl     ax, cl
    dec     ax
    mov     ss:word_3ED74, ax; ax = (01000h << 4) - 1 = 0ffffh
loc_2CCB4:
    add     si, di
    mov     ds:2, si        ; set memory size in psp?, si = 01000h + dseg
    mov     bx, es          ; es = pspseg on startup
loc_2CCBC:
    sub     bx, si
    neg     bx              ; bx = -(pspseg - si) = -(pspseg - (1000h + dseg))
    mov     ah, 4Ah
    int     21h             ; DOS - 2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
    mov     ss:crtpspseg, ds
    push    ss
    pop     es
    cld
    mov     di, 55CAh       ; offset in dseg where uninitialized data starts
    mov     cx, 0AD20h      ; original size/end of dseg
    sub     cx, di
    xor     ax, ax
    rep stosb               ; initialize uninitialized data to 0
    push    ss
    pop     ds
    call    far ptr loc_2CD28
    push    ss
    pop     ds
    ;call __setenvp    ; -- stunts does not need the environment, and this call trashes our injected code
    nop
    nop
    nop
    nop
    nop
    call    far ptr __setargv
    xor     bp, bp
    push    word_3EE0C
    push    argv            ; p_argv
    push    argc            ; p_argc
    call    stuntsmain
    push    ax
    call    far ptr libsub_quit_to_dos_alt
__cintDIV:
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 3
    mov     ss:crtquitfunction, offset libsub_quit_to_dos_alt
__amsg_exit:
    push    ax
    call    __FF_MSGBANNER
    call    __NMSG_WRITE
    mov     ax, 0FFh
    push    ax
    push    cs
    call    crtquitfunction
    db 0
loc_2CD28:
    mov     ah, 30h
    int     21h             ; DOS - GET DOS VERSION
    mov     crtdosversion, ax
    mov     ax, 3500h
    int     21h             ; DOS - 2+ - GET INTERRUPT VECTOR
    mov     word ptr crtintrvec0, bx
    mov     word ptr crtintrvec0+2, es
    push    cs
    pop     ds
    mov     ax, 2500h
    mov     dx, offset __cintDIV
    int     21h             ; DOS - SET INTERRUPT VECTOR
    push    ss
    pop     ds
    mov     cx, word ptr dword_40C1E+2
    jcxz    short loc_2CD7C
    mov     es, crtpspseg
    mov     si, es:2Ch      ; si = environment segment
    lds     ax, dword_40C22
    mov     dx, ds
    xor     bx, bx
    call    ss:dword_40C1E
    jnb     short loc_2CD6B
    push    ss
    pop     ds
    jmp     __fptrap
loc_2CD6B:
    lds     ax, ss:dword_40C26
    mov     dx, ds
    mov     bx, 3
    call    ss:dword_40C1E
    push    ss
    pop     ds
loc_2CD7C:
    mov     es, crtpspseg
    mov     cx, es:2Ch      ; es:2C = environment segment
    jcxz    short loc_2CDBD
    mov     es, cx
    xor     di, di
loc_2CD8B:
    cmp     byte ptr es:[di], 0
    jz      short loc_2CDBD
    mov     cx, 0Ch
    mov     si, offset aC_file_info; ";C_FILE_INFO"
    repe cmpsb
    jz      short loc_2CDA6
    mov     cx, 7FFFh
    xor     ax, ax
    repne scasb
    jnz     short loc_2CDBD
    jmp     short loc_2CD8B
loc_2CDA6:
    push    es
    push    ds
    pop     es
    pop     ds
    mov     si, di
    mov     di, offset crtfilehandles
    lodsb
    cbw
    xchg    ax, cx
loc_2CDB2:
    lodsb
    inc     al
    jz      short loc_2CDB8
    dec     ax
loc_2CDB8:
    stosb
    loop    loc_2CDB2
    push    ss
    pop     ds
loc_2CDBD:
    mov     bx, 4
loc_2CDC0:
smart
smart
    and     crtfilehandles[bx], 0BFh
nosmart
    mov     ax, 4400h
loc_2CDC8:
    int     21h             ; DOS - 2+ - IOCTL - GET DEVICE INFORMATION
    jb      short loc_2CDD6
    test    dl, 80h
    jz      short loc_2CDD6
smart
    or      crtfilehandles[bx], 40h
nosmart
loc_2CDD6:
    dec     bx
    jns     short loc_2CDC0
    mov     si, offset _flushallptr
    mov     di, offset _flushallptr
    call near ptr sub_2CE77
    mov     si, offset _flushallptr
    mov     di, offset _flushallptr
    call near ptr sub_2CE77
    retf
start endp
libsub_quit_to_dos_alt proc near
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    mov     si, offset unk_42A24
    mov     di, offset unk_42A24
    call near ptr sub_2CE77
    mov     si, offset _flushallptr
    mov     di, offset aNmsg; "<<NMSG>>"
    call near ptr sub_2CE77
    jmp     short loc_2CE06
libsub_quit_to_dos_alt endp
libsub_quit_to_dos proc near
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6

    push    bp
    mov     bp, sp
loc_2CE06:
    mov     si, offset aNmsg; "<<NMSG>>"
    mov     di, offset aNmsg; "<<NMSG>>"
    call near ptr sub_2CE77
    mov     si, offset aNmsg; "<<NMSG>>"
    mov     di, offset aNmsg; "<<NMSG>>"
    call near ptr sub_2CE77
    call    __nullcheck
    or      ax, ax
    jz      short loc_2CE2C
    cmp     [bp+arg_2], 0
    jnz     short loc_2CE2C
    mov     [bp+arg_2], 0FFh
loc_2CE2C:
    mov     cx, 0Fh
    mov     bx, 5
loc_2CE32:
    test    crtfilehandles[bx], 1
    jz      short loc_2CE3D
    mov     ah, 3Eh
    int     21h             ; DOS - 2+ - CLOSE A FILE WITH HANDLE
loc_2CE3D:
    inc     bx
    loop    loc_2CE32
    call near ptr sub_2CE4A
    mov     ax, [bp+arg_2]
    mov     ah, 4Ch
    int     21h             ; DOS - 2+ - QUIT WITH EXIT CODE (EXIT)
libsub_quit_to_dos endp
sub_2CE4A proc near

    mov     cx, word ptr dword_40C1E+2
    jcxz    short loc_2CE57
    mov     bx, 2
    call    dword_40C1E
loc_2CE57:
    push    ds
    lds     dx, crtintrvec0
    mov     ax, 2500h
    int     21h             ; DOS - SET INTERRUPT VECTOR
    pop     ds
    cmp     byte_3EE16, 0
    jz      short locret_2CE76
    push    ds
    mov     al, byte_3EE17
    lds     dx, dword_3EE18
    mov     ah, 25h
    int     21h             ; DOS - SET INTERRUPT VECTOR
    pop     ds
locret_2CE76:
    retn
sub_2CE4A endp
sub_2CE77 proc near

    cmp     si, di
    jnb     short locret_2CE89
    sub     di, 4
    mov     ax, [di]
    or      ax, [di+2]
    jz      short sub_2CE77
    call    dword ptr [di]
    jmp     short sub_2CE77
locret_2CE89:
    retn
sub_2CE77 endp
__FF_MSGBANNER proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    mov     ax, 0FCh ; '¸'
    push    ax
    call    __NMSG_WRITE
    cmp     word_3EE1E, 0
    jz      short loc_2CEA1
    call    dword ptr unk_3EE1C
loc_2CEA1:
    mov     ax, 0FFh
    push    ax
    call    __NMSG_WRITE
    mov     sp, bp
    pop     bp
    retf
__FF_MSGBANNER endp
__fptrap proc near

    mov     ax, 2
    jmp     __amsg_exit
__fptrap endp
__chkstk proc far

    pop     cx
    pop     dx
    mov     bx, sp
    sub     bx, ax
    jb      short loc_2CEC7
    cmp     bx, word_3EE24
    jb      short loc_2CEC7
    mov     sp, bx
    push    dx
    push    cx
    retf
loc_2CEC7:
    mov     ax, word ptr dword_3EE20
    inc     ax
    jnz     short loc_2CED2
    xor     ax, ax
    jmp     __amsg_exit
loc_2CED2:
    push    dx
    push    cx
    jmp     dword_3EE20
__chkstk endp
__nullcheck proc far
     r = byte ptr 0

    push    si
    xor     si, si
    mov     cx, 42h ; 'B'
    xor     ah, ah
    cld
loc_2CEE1:
    lodsb
    xor     ah, al
    loop    loc_2CEE1
    xor     ah, 55h
    jz      short loc_2CEFC
    call    __FF_MSGBANNER
    mov     ax, 1
    push    ax
    call    __NMSG_WRITE
    mov     ax, 1
loc_2CEFC:
    pop     si
    retf
__nullcheck endp
__setargv proc near

    pop     word ptr dword_3EE26
    pop     word ptr dword_3EE26+2
    mov     dx, 2
    cmp     byte ptr crtdosversion, dl
    jz      short loc_2CF38
    mov     es, crtpspseg
    mov     es, word ptr es:2Ch; es:2c = environemtn segment
    mov     crtenvseg, es
    xor     ax, ax
    cwd
    mov     cx, 8000h
    xor     di, di
loc_2CF24:
    repne scasb
    scasb
    jnz     short loc_2CF24
    inc     di
    inc     di
    mov     word_3EE0E, di
    mov     cx, 0FFFFh
    repne scasb
    not     cx
    mov     dx, cx
loc_2CF38:
    mov     di, 1
    mov     si, 81h ; 'Å'
    mov     ds, crtpspseg
loc_2CF42:
    lodsb
    cmp     al, 20h ; ' '
    jz      short loc_2CF42
    cmp     al, 9
    jz      short loc_2CF42
    cmp     al, 0Dh
    jz      short loc_2CFBE
    or      al, al
    jz      short loc_2CFBE
    inc     di
loc_2CF54:
    dec     si
loc_2CF55:
    lodsb
    cmp     al, 20h ; ' '
    jz      short loc_2CF42
    cmp     al, 9
    jz      short loc_2CF42
    cmp     al, 0Dh
    jz      short loc_2CFBE
    or      al, al
    jz      short loc_2CFBE
    cmp     al, 22h ; '"'
    jz      short loc_2CF8E
    cmp     al, 5Ch ; '\'
    jz      short loc_2CF71
    inc     dx
    jmp     short loc_2CF55
loc_2CF71:
    xor     cx, cx
loc_2CF73:
    inc     cx
    lodsb
    cmp     al, 5Ch ; '\'
    jz      short loc_2CF73
    cmp     al, 22h ; '"'
    jz      short loc_2CF81
    add     dx, cx
    jmp     short loc_2CF54
loc_2CF81:
    mov     ax, cx
    shr     cx, 1
    adc     dx, cx
    test    al, 1
    jnz     short loc_2CF55
    jmp     short loc_2CF8E
loc_2CF8D:
    dec     si
loc_2CF8E:
    lodsb
    cmp     al, 0Dh
    jz      short loc_2CFBE
    or      al, al
    jz      short loc_2CFBE
    cmp     al, 22h ; '"'
    jz      short loc_2CF55
    cmp     al, 5Ch ; '\'
    jz      short loc_2CFA2
    inc     dx
    jmp     short loc_2CF8E
loc_2CFA2:
    xor     cx, cx
loc_2CFA4:
    inc     cx
    lodsb
    cmp     al, 5Ch ; '\'
    jz      short loc_2CFA4
    cmp     al, 22h ; '"'
    jz      short loc_2CFB2
    add     dx, cx
    jmp     short loc_2CF8D
loc_2CFB2:
    mov     ax, cx
    shr     cx, 1
    adc     dx, cx
    test    al, 1
    jnz     short loc_2CF8E
    jmp     short loc_2CF55
loc_2CFBE:
    push    ss
    pop     ds
    mov     argc, di
    add     dx, di
    inc     di
    shl     di, 1
    add     dx, di
smart
    and     dl, 0FEh
nosmart
    sub     sp, dx
    mov     ax, sp
    mov     argv, ax
    mov     bx, ax
    add     di, bx
    push    ss
    pop     es
    mov     ss:[bx], di
    inc     bx
    inc     bx
    lds     si, dword ptr word_3EE0E
loc_2CFE4:
    lodsb
    stosb
    or      al, al
    jnz     short loc_2CFE4
    mov     si, 81h ; 'Å'
    mov     ds, ss:crtpspseg
    jmp     short loc_2CFF7
loc_2CFF4:
    xor     ax, ax
    stosb
loc_2CFF7:
    lodsb
    cmp     al, 20h ; ' '
    jz      short loc_2CFF7
    cmp     al, 9
    jz      short loc_2CFF7
    cmp     al, 0Dh
    jnz     short loc_2D007
    jmp     loc_2D086
loc_2D007:
    or      al, al
    jnz     short loc_2D00E
    jmp     short loc_2D086
    ; align 2
    db 144
loc_2D00E:
    mov     ss:[bx], di
    inc     bx
    inc     bx
loc_2D013:
    dec     si
loc_2D014:
    lodsb
    cmp     al, 20h ; ' '
    jz      short loc_2CFF4
    cmp     al, 9
    jz      short loc_2CFF4
    cmp     al, 0Dh
    jz      short loc_2D083
    or      al, al
    jz      short loc_2D083
    cmp     al, 22h ; '"'
    jz      short loc_2D050
    cmp     al, 5Ch ; '\'
    jz      short loc_2D030
    stosb
    jmp     short loc_2D014
loc_2D030:
    xor     cx, cx
loc_2D032:
    inc     cx
    lodsb
    cmp     al, 5Ch ; '\'
    jz      short loc_2D032
    cmp     al, 22h ; '"'
    jz      short loc_2D042
    mov     al, 5Ch ; '\'
    rep stosb
    jmp     short loc_2D013
loc_2D042:
    mov     al, 5Ch ; '\'
    shr     cx, 1
    rep stosb
    jnb     short loc_2D050
    mov     al, 22h ; '"'
    stosb
    jmp     short loc_2D014
loc_2D04F:
    dec     si
loc_2D050:
    lodsb
    cmp     al, 0Dh
    jz      short loc_2D083
    or      al, al
    jz      short loc_2D083
    cmp     al, 22h ; '"'
    jz      short loc_2D014
    cmp     al, 5Ch ; '\'
    jz      short loc_2D064
    stosb
    jmp     short loc_2D050
loc_2D064:
    xor     cx, cx
loc_2D066:
    inc     cx
    lodsb
    cmp     al, 5Ch ; '\'
    jz      short loc_2D066
    cmp     al, 22h ; '"'
    jz      short loc_2D076
    mov     al, 5Ch ; '\'
    rep stosb
    jmp     short loc_2D04F
loc_2D076:
    mov     al, 5Ch ; '\'
    shr     cx, 1
    rep stosb
    jnb     short loc_2D014
    mov     al, 22h ; '"'
    stosb
    jmp     short loc_2D050
loc_2D083:
    xor     ax, ax
    stosb
loc_2D086:
    push    ss
    pop     ds
    mov     word ptr [bx], 0
    jmp     dword_3EE26
__setargv endp
__setenvp proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    push    bp
    mov     ds, crtpspseg
    xor     cx, cx
    mov     ax, cx
    mov     bp, cx
    mov     di, cx
    dec     cx              ; cx = 0ffffh
    mov     si, word ptr ds:2Ch; psp:2c = environment segment
    or      si, si
    jz      short loc_2D0B9
    mov     es, si
    cmp     byte ptr es:0, 0
    jz      short loc_2D0B9 ; empty environment?
loc_2D0B3:
    repne scasb
    inc     bp              ; count x=y strings in environment
    scasb                   ; two nulls in a row = end of environment
    jnz     short loc_2D0B3
loc_2D0B9:
    inc     bp              ; bp = number of envirment strings
    xchg    ax, di          ; set ax to number of bytes in environent, di to 0
    inc     ax
smart
    and     al, 0FEh
nosmart
    mov     di, bp          ; di = number of environment strings
    shl     bp, 1
    add     ax, bp          ; ax = ((envsize+1)&FFFE) + numstrings*2
    push    ss
    pop     ds
    push    di
    mov     di, 9
    call near ptr __myalloc
    pop     di
    mov     cx, di          ; cx = number of environment strings
    mov     di, bp          ; bp = old crtsp1 (was changed in myalloc)
    add     di, ax          ; ax = old bp = numstrings*2
    mov     word_3EE0C, bp
    push    ds
    pop     es
    mov     ds, si
    xor     si, si
    dec     cx
    jcxz    short loc_2D0F4
loc_2D0E1:
    cmp     word ptr [si], 433Bh; if the env string does not start with "C;" (or ;C) put its ofs at ds:bp
    jz      short loc_2D0EC
    mov     [bp+0], di
    inc     bp
    inc     bp
loc_2D0EC:
    lodsb
    stosb
    or      al, al
    jnz     short loc_2D0EC
    loop    loc_2D0E1
loc_2D0F4:
    mov     [bp+0], cx
    push    ss
    pop     ds
    pop     bp
    mov     sp, bp
    pop     bp
    retf
__setenvp endp
__NMSG_TEXT proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    push    ds
    pop     es
    mov     dx, [bp+arg_0]
    mov     si, 54C6h
loc_2D10B:
    lodsw
    cmp     ax, dx
    jz      short loc_2D120
    inc     ax
    xchg    ax, si
    jz      short loc_2D120
    xchg    ax, di
    xor     ax, ax
    mov     cx, 0FFFFh
    repne scasb
    mov     si, di
    jmp     short loc_2D10B
loc_2D120:
    xchg    ax, si
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf    2
__NMSG_TEXT endp
__NMSG_WRITE proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    di
    push    [bp+arg_0]
    call    __NMSG_TEXT
    or      ax, ax
    jz      short loc_2D14D
    xchg    ax, dx
    mov     di, dx
    xor     ax, ax
    mov     cx, 0FFFFh
    repne scasb
    not     cx
    dec     cx
    mov     bx, 2
    mov     ah, 40h
    int     21h             ; DOS - 2+ - WRITE TO FILE WITH HANDLE
loc_2D14D:
    pop     di
    mov     sp, bp
    pop     bp
    retf    2
__NMSG_WRITE endp
__myalloc proc near

    mov     dx, ax
    add     ax, crtsp1
    jb      short loc_2D191
    cmp     word_3ED74, ax
    jnb     short loc_2D187
    add     ax, 0Fh
    push    ax
    rcr     ax, 1
    mov     cl, 3
    shr     ax, cl
    mov     cx, ds
    mov     bx, crtpspseg
    sub     cx, bx
    add     ax, cx
    mov     es, bx
    mov     bx, ax
    mov     ah, 4Ah
    int     21h             ; DOS - 2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
    pop     ax
    jb      short loc_2D191
smart
    and     al, 0F0h
nosmart
    dec     ax
    mov     word_3ED74, ax
loc_2D187:
    xchg    ax, bp
    mov     bp, crtsp1
    add     crtsp1, dx
    retn
loc_2D191:
    mov     ax, di
    jmp     __amsg_exit
__dosret0:
    jb      short loc_2D1AB
loc_2D198:
    xor     ax, ax
    mov     sp, bp
    pop     bp
    retf
__dosreturn:
    jnb     short loc_2D198
    push    ax
    call near ptr sub_2D1BC
    pop     ax
    mov     sp, bp
    pop     bp
    retf
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12
__dosretax:
    jnb     short loc_2D1B2
loc_2D1AB:
    call near ptr sub_2D1BC
    mov     ax, 0FFFFh
    cwd
loc_2D1B2:
    mov     sp, bp
    pop     bp
    retf
__myalloc endp
__maperror proc far

    xor     ah, ah
    call near ptr sub_2D1BC
    retf
__maperror endp
sub_2D1BC proc near

    mov     byte_3EDF0, al
    or      ah, ah
    jnz     short loc_2D1E6
    cmp     byte ptr crtdosversion, 3
    jb      short loc_2D1D7
    cmp     al, 22h ; '"'
    jnb     short loc_2D1DB
    cmp     al, 20h ; ' '
    jb      short loc_2D1D7
    mov     al, 5
    jmp     short loc_2D1DD
    db 144
loc_2D1D7:
    cmp     al, 13h
    jbe     short loc_2D1DD
loc_2D1DB:
    mov     al, 13h
loc_2D1DD:
    mov     bx, 36BAh
    xlat
loc_2D1E1:
    cbw
    mov     word_3EDE5, ax
    retn
loc_2D1E6:
    mov     al, ah
    jmp     short loc_2D1E1
sub_2D1BC endp
_flushall proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     si, 36D0h
    sub     di, di
    jmp     short loc_2D210
    ; align 2
    db 144
loc_2D1FA:
    test    byte ptr [si+6], 83h
    jz      short loc_2D20D
    push    si              ; FILE *
    call    _fflush
    add     sp, 2
    inc     ax
    jz      short loc_2D20D
    inc     di
loc_2D20D:
    add     si, 8
loc_2D210:
    cmp     word_3EF58, si
    jnb     short loc_2D1FA
    mov     ax, di
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
_flushall endp
_printf proc far
    var_8 = word ptr -8
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = byte ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    di
    push    si
    mov     si, 36D8h
    lea     ax, [bp+arg_2]
    mov     [bp+var_4], ax
    push    si
    call    __stbuf
    add     sp, 2
    mov     di, ax
    lea     ax, [bp+arg_2]
    push    ax
    push    [bp+arg_0]
    push    si
    call    __output
    add     sp, 6
    mov     [bp+var_8], ax
    push    si              ; FILE *
    push    di              ; int
    call    __ftbuf
    add     sp, 4
    mov     ax, [bp+var_8]
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
_printf endp
__flsbuf proc far
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    di
    push    si
    mov     si, [bp+arg_2]
    mov     al, [si+7]
    cbw
    mov     [bp+var_6], ax
    mov     ax, si
    sub     ax, 36D0h
    mov     cl, 3
    sar     ax, cl
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, 3770h
    mov     [bp+var_8], ax
    test    byte ptr [si+6], 83h
    jz      short loc_2D295
    test    byte ptr [si+6], 40h
    jz      short loc_2D2A0
loc_2D295:
smart
    or      byte ptr [si+6], 20h
nosmart
    mov     ax, 0FFFFh
    jmp     loc_2D3B7
    ; align 2
    db 144
loc_2D2A0:
    test    byte ptr [si+6], 1
    jnz     short loc_2D295
smart
    or      byte ptr [si+6], 2
nosmart
smart
smart
    and     byte ptr [si+6], 0EFh
nosmart
    sub     ax, ax
    mov     [si+2], ax
    mov     di, ax
    mov     [bp+var_4], di
    test    byte ptr [si+6], 0Ch
    jnz     short loc_2D31F
    mov     bx, si
    sub     bx, 36D0h
    mov     cl, 3
    sar     bx, cl
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    byte ptr [bx+3770h], 1
    jnz     short loc_2D31F
    cmp     si, 36D8h
    jz      short loc_2D2E3
    cmp     si, 36E0h
    jnz     short loc_2D318
loc_2D2E3:
    push    [bp+var_6]      ; int
    call    _isatty
    add     sp, 2
    or      ax, ax
    jnz     short loc_2D31F
    inc     word_3EE3E
    cmp     si, 36D8h
    jnz     short loc_2D302
    mov     ax, 891Eh
    jmp     short loc_2D305
    ; align 2
    db 144
loc_2D302:
    mov     ax, 0AA62h
loc_2D305:
    mov     [si+4], ax
    mov     [si], ax
    mov     bx, [bp+var_8]
    mov     word ptr [bx+2], 200h
    mov     byte ptr [bx], 1
    jmp     short loc_2D31F
    ; align 2
    db 144
loc_2D318:
    push    si
    call near ptr __getbuf
    add     sp, 2
loc_2D31F:
    test    byte ptr [si+6], 8
    jnz     short loc_2D33E
    mov     bx, si
    sub     bx, 36D0h
    mov     cl, 3
    sar     bx, cl
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    byte ptr [bx+3770h], 1
    jz      short loc_2D392
loc_2D33E:
    mov     di, [si]
    sub     di, [si+4]
    mov     ax, [si+4]
    inc     ax
    mov     [si], ax
    mov     bx, [bp+var_8]
    mov     ax, [bx+2]
    dec     ax
    mov     [si+2], ax
    or      di, di
    jle     short loc_2D36C
    push    di
    push    word ptr [si+4] ; void *
    push    [bp+var_6]      ; int
    call    _write
    add     sp, 6
    mov     [bp+var_4], ax
    jmp     short loc_2D387
    ; align 2
    db 144
loc_2D36C:
    mov     bx, [bp+var_6]
    test    byte ptr [bx+3684h], 20h
    jz      short loc_2D387
    mov     ax, 2
    push    ax              ; int
    sub     ax, ax
    push    ax
    push    ax              ; __int32
    push    bx              ; int
    call    _lseek
    add     sp, 8
loc_2D387:
    mov     bx, [si+4]
    mov     al, [bp+arg_0]
    mov     [bx], al
    jmp     short loc_2D3AA
    ; align 2
    db 144
loc_2D392:
    mov     di, 1
    mov     ax, di
    push    ax
    lea     ax, [bp+arg_0]
    push    ax              ; void *
    push    [bp+var_6]      ; int
    call    _write
    add     sp, 6
    mov     [bp+var_4], ax
loc_2D3AA:
    cmp     [bp+var_4], di
    jz      short loc_2D3B2
    jmp     loc_2D295
loc_2D3B2:
    mov     al, [bp+arg_0]
    sub     ah, ah
loc_2D3B7:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
__flsbuf endp
__getbuf proc near
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 4

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    mov     ax, [bp+arg_0]
    sub     ax, 36D0h
    mov     cl, 3
    sar     ax, cl
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, 3770h
    mov     [bp+var_2], ax
    mov     ax, 200h
    push    ax
    call    unknown_libname_2; MS Quick C v1.0/v2.01 & MSC v5.1 DOS run-time & graphic
    add     sp, 2
    mov     bx, [bp+arg_0]
    mov     [bx+4], ax
    or      ax, ax
    jz      short loc_2D402
smart
    or      byte ptr [bx+6], 8
nosmart
    mov     bx, [bp+var_2]
    mov     word ptr [bx+2], 200h
    jmp     short loc_2D418
    ; align 2
    db 144
loc_2D402:
    mov     bx, [bp+arg_0]
smart
    or      byte ptr [bx+6], 4
nosmart
    mov     ax, [bp+var_2]
    inc     ax
    mov     [bx+4], ax
    mov     bx, [bp+var_2]
    mov     word ptr [bx+2], 1
loc_2D418:
    mov     bx, [bp+arg_0]
    mov     si, bx
    mov     ax, [si+4]
    mov     [bx], ax
    mov     word ptr [bx+2], 0
    pop     si
    mov     sp, bp
    pop     bp
    retn
__getbuf endp
__stbuf proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    mov     si, [bp+arg_0]
    inc     word_3EE3E
    cmp     si, 36D8h
    jnz     short loc_2D448
    mov     [bp+var_2], 891Eh
    jmp     short loc_2D453
    ; align 2
    db 144
loc_2D448:
    cmp     si, 36E0h
    jnz     short loc_2D472
    mov     [bp+var_2], 0AA62h
loc_2D453:
    test    byte ptr [si+6], 0Ch
    jnz     short loc_2D472
    mov     bx, si
    sub     bx, 36D0h
    mov     cl, 3
    sar     bx, cl
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    byte ptr [bx+3770h], 1
    jz      short loc_2D476
loc_2D472:
    sub     ax, ax
    jmp     short loc_2D4AB
loc_2D476:
    mov     ax, si
    sub     ax, 36D0h
    mov     cl, 3
    sar     ax, cl
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, 3770h
    mov     [bp+var_4], ax
    mov     ax, [bp+var_2]
    mov     [si+4], ax
    mov     [si], ax
    mov     bx, [bp+var_4]
    mov     ax, 200h
    mov     [bx+2], ax
    mov     [si+2], ax
    mov     byte ptr [bx], 1
smart
    or      byte ptr [si+6], 2
nosmart
    mov     ax, 1
loc_2D4AB:
    pop     si
    mov     sp, bp
    pop     bp
    retf
__stbuf endp
__ftbuf proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = dword ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    cmp     [bp+arg_0], 0
    jz      short loc_2D51C
    cmp     word ptr [bp+arg_2], 36D8h
    jz      short loc_2D4CB
    cmp     word ptr [bp+arg_2], 36E0h
    jnz     short loc_2D549
loc_2D4CB:
    mov     bx, word ptr [bp+arg_2]
    mov     al, [bx+7]
    cbw
    push    ax              ; int
    call    _isatty
    add     sp, 2
    or      ax, ax
    jz      short loc_2D549
    mov     ax, word ptr [bp+arg_2]
    sub     ax, 36D0h
    mov     cl, 3
    sar     ax, cl
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, 3770h
    mov     [bp+var_2], ax
    push    word ptr [bp+arg_2]; FILE *
    call    _fflush
    add     sp, 2
    mov     bx, [bp+var_2]
    mov     byte ptr [bx], 0
    mov     word ptr [bx+2], 0
    mov     bx, word ptr [bp+arg_2]
    mov     si, bx
    sub     ax, ax
    mov     [si], ax
    mov     [bx+4], ax
    jmp     short loc_2D549
    ; align 2
    db 144
loc_2D51C:
    mov     bx, word ptr [bp+arg_2]
    cmp     word ptr [bx+4], 891Eh
    jz      short loc_2D52D
    cmp     word ptr [bx+4], 0AA62h
    jnz     short loc_2D549
loc_2D52D:
    mov     al, [bx+7]
    cbw
    push    ax              ; int
    call    _isatty
    add     sp, 2
    or      ax, ax
    jz      short loc_2D549
    push    word ptr [bp+arg_2]; FILE *
    call    _fflush
    add     sp, 2
loc_2D549:
    pop     si
    mov     sp, bp
    pop     bp
    retf
__ftbuf endp
_fflush proc far
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     si, [bp+arg_0]
    sub     di, di
    mov     al, [si+6]
smart
    and     al, 3
nosmart
    cmp     al, 2
    jnz     short loc_2D5AC
    test    byte ptr [si+6], 8
    jnz     short loc_2D583
    mov     bx, si
    sub     bx, 36D0h
    mov     cl, 3
    sar     bx, cl
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    byte ptr [bx+3770h], 1
    jz      short loc_2D5AC
loc_2D583:
    mov     ax, [si]
    sub     ax, [si+4]
    mov     [bp+var_4], ax
    or      ax, ax
    jle     short loc_2D5AC
    push    ax
    push    word ptr [si+4] ; void *
    mov     al, [si+7]
    cbw
    push    ax              ; int
    call    _write
    add     sp, 6
    cmp     ax, [bp+var_4]
    jz      short loc_2D5AC
smart
    or      byte ptr [si+6], 20h
nosmart
    mov     di, 0FFFFh
loc_2D5AC:
    mov     ax, [si+4]
    mov     [si], ax
    mov     word ptr [si+2], 0
    mov     ax, di
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
_fflush endp
__output proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    mov     ax, 164h
    call    __chkstk
    push    di
    push    si
    mov     si, [bp+8]
    lea     ax, [bp-162h]
    mov     off_428B6, ax
    mov     ax, [bp+0Ah]
    mov     word_428A6, ax
    mov     ax, [bp+6]
    mov     off_4289A, ax
    mov     word_428B0, 0
    mov     word_428AE, 0
    jmp     loc_2D877
loc_2D5F0:
    cmp     byte ptr [si], 25h ; '%'
    jz      short loc_2D5F8
    jmp     loc_2D85A
loc_2D5F8:
    mov     word_428B2, 1
    sub     ax, ax
    mov     word_428A2, ax
    mov     word_4289E, ax
    mov     word_428AC, ax
    mov     word_428A0, ax
    mov     word_428AA, ax
    mov     word_428A8, ax
    mov     word_4289C, ax
    mov     word_42898, ax
    mov     word_428A4, ax
    mov     word_428BC, 20h ; ' '
    cmp     byte ptr [si+1], 30h ; '0'
    jnz     short loc_2D663
    inc     si
    mov     word_428BC, 30h ; '0'
    jmp     short loc_2D663
loc_2D630:
    cmp     byte ptr [si], 2Bh ; '+'
    jnz     short loc_2D642
    inc     word_428A2
    mov     word_428A8, 0
    jmp     short loc_2D663
    ; align 2
    db 144
loc_2D642:
    cmp     byte ptr [si], 20h ; ' '
    jnz     short loc_2D654
    cmp     word_428A2, 0
    jnz     short loc_2D663
    inc     word_428A8
    jmp     short loc_2D663
loc_2D654:
    inc     word_42898
    jmp     short loc_2D663
loc_2D65A:
    cmp     byte ptr [si], 2Dh ; '-'
    jnz     short loc_2D630
    inc     word_428A4
loc_2D663:
    inc     si
    mov     al, [si]
    cbw
    push    ax
    push    cs
    call near ptr flagchar
    add     sp, 2
    or      ax, ax
    jnz     short loc_2D65A
    push    si
    mov     ax, offset word_428B8
    push    ax
    push    cs
    call near ptr getnum
    add     sp, 4
    mov     si, ax
    cmp     word_428B8, 0
    jge     short loc_2D694
    inc     word_428A4
    mov     ax, word_428B8
    neg     ax
    mov     word_428B8, ax
loc_2D694:
    cmp     byte ptr [si], 2Eh ; '.'
    jnz     short loc_2D6BD
    inc     word_428AA
    inc     si
    push    si
    mov     ax, offset word_428B2
    push    ax
    push    cs
    call near ptr getnum
    add     sp, 4
    mov     si, ax
    cmp     word_428B2, 0
    jge     short loc_2D6BD
    mov     word_428B2, 1
    dec     word_428AA
loc_2D6BD:
    mov     al, [si]
    cbw
    cmp     ax, 46h ; 'F'
    jz      short loc_2D6F8
    cmp     ax, 4Eh ; 'N'
    jz      short loc_2D700
    cmp     ax, 68h ; 'h'
    jz      short loc_2D6F0
    cmp     ax, 6Ch ; 'l'
    jnz     short loc_2D6DA
    mov     word_428A0, 2
loc_2D6DA:
    cmp     word_428A0, 0
    jnz     short loc_2D6E6
    cmp     byte ptr [si], 4Ch ; 'L'
    jnz     short loc_2D6E7
loc_2D6E6:
    inc     si
loc_2D6E7:
    cmp     byte ptr [si], 0
    jnz     short loc_2D708
    jmp     loc_2D87F
    ; align 2
    db 144
loc_2D6F0:
    mov     word_428A0, 1
    jmp     short loc_2D6DA
loc_2D6F8:
    mov     word_428A0, 10h
    jmp     short loc_2D6DA
loc_2D700:
    mov     word_428A0, 8
    jmp     short loc_2D6DA
loc_2D708:
    mov     al, [si]
    cbw
    mov     [bp-164h], ax
    cmp     ax, 45h ; 'E'
    jz      short loc_2D71E
    cmp     ax, 47h ; 'G'
    jz      short loc_2D71E
    cmp     ax, 58h ; 'X'
    jnz     short loc_2D727
loc_2D71E:
    inc     word_4289E
    add     word ptr [bp-164h], 20h ; ' '
loc_2D727:
    mov     ax, [bp-164h]
    sub     ax, 63h ; 'c'
    cmp     ax, 15h
    jbe     short loc_2D736
    jmp     loc_2D850
loc_2D736:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_2D896[bx]
loc_2D73E:
    mov     bx, word_428A6
    mov     bx, [bx]
    mov     ax, word_428AE
    mov     [bx], ax
loc_2D749:
    add     word_428A6, 2
    jmp     loc_2D8C2
    ; align 2
    db 144
loc_2D752:
    inc     word_428AC
loc_2D756:
    mov     word_42898, 0
    mov     ax, 0Ah
loc_2D75F:
    push    ax
    push    cs
    call near ptr iprint
loc_2D764:
    add     sp, 2
    jmp     loc_2D8C2
loc_2D76A:
    mov     ax, 8
    jmp     short loc_2D75F
    ; align 2
    db 144
loc_2D770:
    inc     word_4289C
    inc     word_4289E
    cmp     word_428AA, 0
    jnz     short loc_2D788
    mov     word_428B4, 1
    jmp     short loc_2D78E
    ; align 2
    db 144
loc_2D788:
    mov     word_428B4, 0
loc_2D78E:
    inc     word_428AA
    mov     word_428B2, 4
    cmp     word_428A0, 8
    jnz     short loc_2D7A2
    jmp     loc_2D82E
loc_2D7A2:
    sub     ax, ax
    mov     word_428A0, ax
    mov     [bp-4], ax
    cmp     word_428B8, ax
    jz      short loc_2D7D7
    mov     ax, word_428B8
    mov     [bp-4], ax
    cmp     word_428A4, 0
    jz      short loc_2D7C6
    mov     word_428B8, 0
    jmp     short loc_2D7D7
    ; align 2
    db 144
loc_2D7C6:
    sub     word_428B8, 5
    mov     ax, word_428B8
    or      ax, ax
    jge     short loc_2D7D4
    sub     ax, ax
loc_2D7D4:
    mov     word_428B8, ax
loc_2D7D7:
    add     word_428A6, 2
    mov     ax, 10h
    push    ax
    push    cs
    call near ptr iprint
    add     sp, 2
    mov     ax, 3Ah ; ':'
    push    ax
    push    cs
    call near ptr _outc
    add     sp, 2
    cmp     word ptr [bp-4], 0
    jz      short loc_2D81A
    cmp     word_428A4, 0
    jz      short loc_2D814
    mov     ax, [bp-4]
    sub     ax, 5
    mov     word_428B8, ax
    or      ax, ax
    jge     short loc_2D80E
    sub     ax, ax
loc_2D80E:
    mov     word_428B8, ax
    jmp     short loc_2D81A
    ; align 2
    db 144
loc_2D814:
    mov     word_428B8, 0
loc_2D81A:
    sub     word_428A6, 4
    mov     ax, 10h
    push    ax
    push    cs
    call near ptr iprint
    add     sp, 2
    jmp     loc_2D749
    ; align 2
    db 144
loc_2D82E:
    mov     ax, 10h
    jmp     loc_2D75F
loc_2D834:
    sub     ax, ax
loc_2D836:
    push    ax
    push    cs
    call near ptr sprint
    jmp     loc_2D764
loc_2D83E:
    mov     ax, 1
    jmp     short loc_2D836
    ; align 2
    db 144
loc_2D844:
    push    word ptr [bp-164h]
    push    cs
    call near ptr fprint
    jmp     loc_2D764
    ; align 2
    db 144
loc_2D850:
    cmp     word_428A0, 0
    jz      short loc_2D85A
    mov     ax, si
    dec     si
loc_2D85A:
    mov     di, si
loc_2D85C:
    inc     di
    cmp     byte ptr [di], 0
    jz      short loc_2D867
    cmp     byte ptr [di], 25h ; '%'
    jnz     short loc_2D85C
loc_2D867:
    mov     ax, di
    sub     ax, si
    push    ax
    push    ds
    push    si
    push    cs
    call near ptr putbuf
    add     sp, 6
    mov     si, di
loc_2D877:
    cmp     byte ptr [si], 0
    jz      short loc_2D87F
    jmp     loc_2D5F0
loc_2D87F:
    cmp     word_428AE, 0
    jnz     short loc_2D8E0
    mov     bx, off_4289A
    test    byte ptr [bx+6], 20h
    jz      short loc_2D8E0
loc_2D890:
    mov     ax, 0FFFFh
    jmp     short loc_2D8E3
    ; align 2
    db 144
off_2D896     dw offset loc_2D83E
    dw offset loc_2D756
    dw offset loc_2D844
    dw offset loc_2D844
    dw offset loc_2D844
    dw offset loc_2D850
    dw offset loc_2D756
    dw offset loc_2D850
    dw offset loc_2D850
    dw offset loc_2D850
    dw offset loc_2D850
    dw offset loc_2D73E
    dw offset loc_2D76A
    dw offset loc_2D770
    dw offset loc_2D850
    dw offset loc_2D850
    dw offset loc_2D834
    dw offset loc_2D850
    dw offset loc_2D752
    dw offset loc_2D850
    dw offset loc_2D850
    dw offset loc_2D82E
loc_2D8C2:
    cmp     word_428B0, 0
    jz      short loc_2D8DC
    cmp     word_428AE, 0
    jnz     short loc_2D8E0
    mov     bx, off_4289A
    test    byte ptr [bx+6], 20h
    jnz     short loc_2D890
    jmp     short loc_2D8E0
loc_2D8DC:
    inc     si
    jmp     short loc_2D877
    ; align 2
    db 144
loc_2D8E0:
    mov     ax, word_428AE
loc_2D8E3:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
__output endp
iprint proc far
    var_18 = byte ptr -24
    var_C = word ptr -12
    var_8 = word ptr -8
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 18h
    push    di
    push    si
    cmp     [bp+arg_0], 0Ah
    jz      short loc_2D8FC
    inc     word_428AC
loc_2D8FC:
    cmp     word_428A0, 2
    jz      short loc_2D90A
    cmp     word_428A0, 10h
    jnz     short loc_2D920
loc_2D90A:
    mov     bx, word_428A6
    mov     ax, [bx]
    mov     dx, [bx+2]
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    add     word_428A6, 4
    jmp     short loc_2D94A
loc_2D920:
    cmp     word_428AC, 0
    jz      short loc_2D938
    mov     bx, word_428A6
    mov     ax, [bx]
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], 0
    jmp     short loc_2D945
    ; align 2
    db 144
loc_2D938:
    mov     bx, word_428A6
    mov     ax, [bx]
    cwd
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
loc_2D945:
    add     word_428A6, 2
loc_2D94A:
    cmp     word_42898, 0
    jz      short loc_2D95E
    mov     ax, word ptr [bp+var_4]
    or      ax, word ptr [bp+var_4+2]
    jz      short loc_2D95E
    mov     ax, [bp+arg_0]
    jmp     short loc_2D960
loc_2D95E:
    sub     ax, ax
loc_2D960:
    mov     word_428BA, ax
    mov     si, off_428B6
    cmp     word_428AC, 0
    jnz     short loc_2D998
    cmp     word ptr [bp+var_4+2], 0
    jge     short loc_2D998
    cmp     [bp+arg_0], 0Ah
    jnz     short loc_2D991
    mov     byte ptr [si], 2Dh ; '-'
    inc     si
    mov     ax, word ptr [bp+var_4]
    mov     dx, word ptr [bp+var_4+2]
    neg     ax
    adc     dx, 0
    neg     dx
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
loc_2D991:
    mov     [bp+var_8], 1
    jmp     short loc_2D99D
loc_2D998:
    mov     [bp+var_8], 0
loc_2D99D:
    lea     ax, [bp+var_18]
    mov     di, ax
    push    [bp+arg_0]
    push    di              ; char *
    push    word ptr [bp+var_4+2]
    push    word ptr [bp+var_4]; unsigned __int32
    call    far ptr _ultoa
    add     sp, 8
    cmp     word_428AA, 0
    jz      short loc_2D9DE
    push    di              ; char *
    call    _strlen
    add     sp, 2
    mov     cx, word_428B2
    sub     cx, ax
    mov     [bp+var_C], cx
    jmp     short loc_2D9D4
    ; align 2
    db 144
loc_2D9D0:
    mov     byte ptr [si], 30h ; '0'
    inc     si
loc_2D9D4:
    mov     ax, cx
    dec     cx
    or      ax, ax
    jg      short loc_2D9D0
    mov     [bp+var_C], cx
loc_2D9DE:
    mov     cx, word_4289E
loc_2D9E2:
    mov     al, [di]
    mov     [si], al
    or      cx, cx
    jz      short loc_2D9F1
    cmp     al, 61h ; 'a'
    jl      short loc_2D9F1
    sub     byte ptr [si], 20h ; ' '
loc_2D9F1:
    inc     si
    inc     di
    cmp     byte ptr [di-1], 0
    jnz     short loc_2D9E2
    cmp     word_428AC, 0
    jnz     short loc_2DA14
    mov     ax, word_428A2
    or      ax, word_428A8
    jz      short loc_2DA14
    cmp     [bp+var_8], 0
    jnz     short loc_2DA14
    mov     ax, 1
    jmp     short loc_2DA16
loc_2DA14:
    sub     ax, ax
loc_2DA16:
    push    ax
    push    cs
    call near ptr _out
    add     sp, 2
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
iprint endp
sprint proc far
    var_E = dword ptr -14
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    di
    push    si
    cmp     [bp+arg_0], 0
    jz      short loc_2DA46
    mov     si, 1
    mov     ax, word_428A6
    mov     [bp+var_8], ax
    mov     [bp+var_6], ds
    add     word_428A6, 2
    jmp     loc_2DAD7
loc_2DA46:
    cmp     word_428A0, 10h
    jnz     short loc_2DA64
    mov     bx, word_428A6
    mov     ax, [bx]
    mov     dx, [bx+2]
    mov     [bp+var_8], ax
    mov     [bp+var_6], dx
    add     word_428A6, 4
    jmp     short loc_2DA78
    ; align 2
    db 144
loc_2DA64:
    mov     bx, word_428A6
loc_2DA68:
    mov     ax, [bx]
    mov     [bp+var_4], ax
    mov     [bp+var_8], ax
    mov     [bp+var_6], ds
    add     word_428A6, 2
loc_2DA78:
    cmp     word_428A0, 10h
    jnz     short loc_2DA8C
    mov     ax, [bp+var_8]
    or      ax, [bp+var_6]
    jnz     short loc_2DA9B
    mov     ax, 37EAh
    jmp     short loc_2DA95
loc_2DA8C:
    cmp     [bp+var_4], 0
    jnz     short loc_2DA9B
    mov     ax, 37F1h
loc_2DA95:
    mov     [bp+var_8], ax
    mov     [bp+var_6], ds
loc_2DA9B:
    mov     ax, [bp+var_8]
    mov     dx, [bp+var_6]
    mov     word ptr [bp+var_E], ax
    mov     word ptr [bp+var_E+2], dx
    sub     si, si
    cmp     word_428AA, si
    jz      short loc_2DACB
    mov     cx, word_428B2
    jmp     short loc_2DAC3
    ; align 2
    db 144
loc_2DAB6:
    les     bx, [bp+var_E]
    inc     word ptr [bp+var_E]
    cmp     byte ptr es:[bx], 0
    jz      short loc_2DAD7
    inc     si
loc_2DAC3:
    cmp     cx, si
    jle     short loc_2DAD7
    jmp     short loc_2DAB6
    ; align 2
    db 144
loc_2DACA:
    inc     si
loc_2DACB:
    les     bx, [bp+var_E]
    inc     word ptr [bp+var_E]
    cmp     byte ptr es:[bx], 0
    jnz     short loc_2DACA
loc_2DAD7:
    mov     di, word_428B8
    sub     di, si
    cmp     word_428A4, 0
    jnz     short loc_2DAEC
    push    di
    push    cs
    call near ptr putpad
    add     sp, 2
loc_2DAEC:
    push    si
    push    [bp+var_6]
    push    [bp+var_8]
    push    cs
    call near ptr putbuf
    add     sp, 6
    cmp     word_428A4, 0
    jz      short loc_2DB09
    push    di
    push    cs
    call near ptr putpad
    add     sp, 2
loc_2DB09:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sprint endp
fprint proc far
    var_4 = byte ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    mov     ax, word_428A6
    mov     [bp+var_2], ax
    cmp     [bp+arg_0], 67h ; 'g'
    jz      short loc_2DB28
    cmp     [bp+arg_0], 47h ; 'G'
    jnz     short loc_2DB2C
loc_2DB28:
    mov     al, 1
    jmp     short loc_2DB2E
loc_2DB2C:
    sub     al, al
loc_2DB2E:
    mov     [bp+var_4], al
    cmp     word_428AA, 0
    jnz     short loc_2DB3E
    mov     word_428B2, 6
loc_2DB3E:
    cmp     [bp+var_4], 0
    jz      short loc_2DB51
    cmp     word_428B2, 0
    jnz     short loc_2DB51
    mov     word_428B2, 1
loc_2DB51:
    push    word_4289E
    push    word_428B2
    push    [bp+arg_0]
    push    off_428B6
    push    [bp+var_2]
    call    off_3EF84
    add     sp, 0Ah
    cmp     byte ptr [bp-4], 0
    jz      short loc_2DB82
    cmp     word_42898, 0
    jnz     short loc_2DB82
    push    off_428B6
    call    off_3EF88
    add     sp, 2
loc_2DB82:
    cmp     word_42898, 0
    jz      short loc_2DB9B
    cmp     word_428B2, 0
    jnz     short loc_2DB9B
    push    off_428B6
    call    off_3EF90
    add     sp, 2
loc_2DB9B:
    add     word_428A6, 8
    mov     word_428BA, 0
    mov     ax, word_428A2
    or      ax, word_428A8
    jz      short loc_2DBC2
    push    word ptr [bp-2]
    call    off_3EF94
    add     sp, 2
    or      ax, ax
    jz      short loc_2DBC2
    mov     ax, 1
    jmp     short loc_2DBC4
loc_2DBC2:
    sub     ax, ax
loc_2DBC4:
    push    ax
    push    cs
    call near ptr _out
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
fprint endp
_outc proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    cmp     word_428B0, 0
    jnz     short loc_2DC0A
    mov     bx, off_4289A
    dec     word ptr [bx+2]
    js      short loc_2DBF0
    mov     al, byte ptr [bp+arg_0]
    mov     si, [bx]
    inc     word ptr [bx]
    mov     [si], al
    sub     ah, ah
    jmp     short loc_2DBFC
    ; align 2
    db 144
loc_2DBF0:
    push    bx              ; FILE *
    push    [bp+arg_0]      ; int
    call    __flsbuf
    add     sp, 4
loc_2DBFC:
    inc     ax
loc_2DBFD:
    jnz     short loc_2DC06
    inc     word_428B0
    jmp     short loc_2DC0A
    ; align 2
    db 144
loc_2DC06:
    inc     word_428AE
loc_2DC0A:
    pop     si
    pop     bp
    retf
    ; align 2
    db 144
_outc endp
putpad proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    cmp     word_428B0, 0
    jnz     short loc_2DC68
    mov     si, [bp+arg_0]
    or      si, si
    jle     short loc_2DC68
    jmp     short loc_2DC3D
loc_2DC26:
    push    off_4289A       ; FILE *
    push    word_428BC      ; int
    call    __flsbuf
    add     sp, 4
loc_2DC36:
    inc     ax
    jnz     short loc_2DC3D
    inc     word_428B0
loc_2DC3D:
    mov     ax, si
    dec     si
    or      ax, ax
    jle     short loc_2DC5A
    mov     bx, off_4289A
    dec     word ptr [bx+2]
    js      short loc_2DC26
    mov     al, byte ptr word_428BC
    mov     di, [bx]
    inc     word ptr [bx]
    mov     [di], al
    sub     ah, ah
    jmp     short loc_2DC36
loc_2DC5A:
    cmp     word_428B0, 0
    jnz     short loc_2DC68
    mov     ax, [bp+arg_0]
    add     word_428AE, ax
loc_2DC68:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
putpad endp
putbuf proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    mov     si, [bp+arg_4]
    cmp     word_428B0, 0
    jnz     short loc_2DCD2
    jmp     short loc_2DCA0
loc_2DC82:
    push    off_4289A       ; FILE *
    les     bx, [bp+arg_0]
    mov     al, es:[bx]
    cbw
    push    ax              ; int
    call    __flsbuf
    add     sp, 4
loc_2DC96:
    inc     ax
    jnz     short loc_2DC9D
    inc     word_428B0
loc_2DC9D:
    inc     word ptr [bp+arg_0]
loc_2DCA0:
    mov     ax, si
    dec     si
    or      ax, ax
    jz      short loc_2DCC4
    mov     bx, off_4289A
    dec     word ptr [bx+2]
    js      short loc_2DC82
    les     bx, [bp+arg_0]
    mov     al, es:[bx]
    mov     bx, off_4289A
    mov     di, [bx]
    inc     word ptr [bx]
    mov     [di], al
    sub     ah, ah
    jmp     short loc_2DC96
loc_2DCC4:
    cmp     word_428B0, 0
    jnz     short loc_2DCD2
    mov     ax, [bp+arg_4]
    add     word_428AE, ax
loc_2DCD2:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
putbuf endp
_out proc far
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    di
    push    si
    mov     si, off_428B6
    sub     ax, ax
    mov     [bp+var_4], ax
    mov     [bp+var_6], ax
    cmp     word_428BC, 30h ; '0'
    jnz     short loc_2DD0B
    cmp     word_428AA, ax
    jz      short loc_2DD0B
    cmp     word_4289C, ax
    jz      short loc_2DD05
    cmp     word_428B4, ax
    jnz     short loc_2DD0B
loc_2DD05:
    mov     word_428BC, 20h ; ' '
loc_2DD0B:
    mov     di, word_428B8
    push    si              ; char *
    call    _strlen
    add     sp, 2
    mov     [bp+var_8], ax
    sub     di, ax
    sub     di, [bp+arg_0]
    cmp     word_428A4, 0
    jnz     short loc_2DD40
    cmp     byte ptr [si], 2Dh ; '-'
    jnz     short loc_2DD40
    cmp     word_428BC, 30h ; '0'
    jnz     short loc_2DD40
    lodsb
    cbw
    push    ax
    push    cs
    call near ptr _outc
    add     sp, 2
    dec     [bp+var_8]
loc_2DD40:
    cmp     word_428BC, 30h ; '0'
    jz      short loc_2DD52
    or      di, di
    jle     short loc_2DD52
    cmp     word_428A4, 0
    jz      short loc_2DD6D
loc_2DD52:
    cmp     [bp+arg_0], 0
    jz      short loc_2DD5F
    inc     [bp+var_6]
    push    cs
    call near ptr putsign
loc_2DD5F:
    cmp     word_428BA, 0
    jz      short loc_2DD6D
    inc     [bp+var_4]
    push    cs
    call near ptr putprefix
loc_2DD6D:
    cmp     word_428A4, 0
    jnz     short loc_2DD9D
    push    di
    push    cs
    call near ptr putpad
    add     sp, 2
    cmp     [bp+arg_0], 0
    jz      short loc_2DD8C
    cmp     [bp+var_6], 0
    jnz     short loc_2DD8C
    push    cs
    call near ptr putsign
loc_2DD8C:
    cmp     word_428BA, 0
    jz      short loc_2DD9D
    cmp     [bp+var_4], 0
    jnz     short loc_2DD9D
    push    cs
    call near ptr putprefix
loc_2DD9D:
    push    [bp+var_8]
    push    ds
    push    si
    push    cs
    call near ptr putbuf
    add     sp, 6
    cmp     word_428A4, 0
    jz      short loc_2DDBE
    mov     word_428BC, 20h ; ' '
    push    di
    push    cs
    call near ptr putpad
    add     sp, 2
loc_2DDBE:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
_out endp
putsign proc far

    cmp     word_428A2, 0
    jz      short loc_2DDD0
    mov     ax, 2Bh ; '+'
    jmp     short loc_2DDD3
loc_2DDD0:
    mov     ax, 20h ; ' '
loc_2DDD3:
    push    ax
    push    cs
    call near ptr _outc
    add     sp, 2
    retf
putsign endp
putprefix proc far

    mov     ax, 30h ; '0'
    push    ax
    push    cs
    call near ptr _outc
    add     sp, 2
    cmp     word_428BA, 10h
    jnz     short locret_2DE05
    cmp     word_4289E, 0
    jz      short loc_2DDFA
    mov     ax, 58h ; 'X'
    jmp     short loc_2DDFD
loc_2DDFA:
    mov     ax, 78h ; 'x'
loc_2DDFD:
    push    ax
    push    cs
    call near ptr _outc
    add     sp, 2
locret_2DE05:
    retf
putprefix endp
getnum proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     si, [bp+arg_2]
    mov     [bp+var_2], 1
    cmp     byte ptr [si], 2Ah ; '*'
    jnz     short loc_2DE2A
    mov     bx, word_428A6
    mov     di, [bx]
    add     word_428A6, 2
    inc     si
    jmp     short loc_2DE71
    ; align 2
    db 144
loc_2DE2A:
    cmp     byte ptr [si], 2Dh ; '-'
    jnz     short loc_2DE35
    mov     [bp+var_2], 0FFFFh
    inc     si
loc_2DE35:
    sub     di, di
    cmp     byte ptr [si], 30h ; '0'
    jl      short loc_2DE71
    cmp     byte ptr [si], 39h ; '9'
    jg      short loc_2DE71
    cmp     word_428AA, di
    jnz     short loc_2DE52
    cmp     byte ptr [si], 30h ; '0'
    jnz     short loc_2DE52
    mov     word_428BC, 30h ; '0'
loc_2DE52:
    mov     al, [si]
    cbw
    mov     cx, di
    shl     cx, 1
    shl     cx, 1
    add     cx, di
    shl     cx, 1
    add     cx, ax
    sub     cx, 30h ; '0'
    mov     di, cx
    inc     si
    cmp     byte ptr [si], 30h ; '0'
    jl      short loc_2DE71
    cmp     byte ptr [si], 39h ; '9'
    jle     short loc_2DE52
loc_2DE71:
    mov     ax, [bp+var_2]
    imul    di
    mov     di, ax
    mov     bx, [bp+arg_0]
    mov     [bx], di
    mov     ax, si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
getnum endp
flagchar proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    mov     si, 37F8h
    mov     cl, [bp+arg_0]
    jmp     short loc_2DE97
    ; align 2
    db 144
loc_2DE96:
    inc     si
loc_2DE97:
    cmp     byte ptr [si], 0
    jz      short loc_2DEA6
    cmp     cl, [si]
    jnz     short loc_2DE96
    mov     ax, 1
    jmp     short loc_2DEA8
    ; align 2
    db 144
loc_2DEA6:
    sub     ax, ax
loc_2DEA8:
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
flagchar endp
_lseek proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 4
    mov     bx, [bp+arg_0]
    cmp     bx, word_3EDF2
    jb      short loc_2DEC2
    mov     ax, 900h
    jmp     short loc_2DEEC
loc_2DEC2:
    test    [bp+arg_6], 8000h
    jz      short loc_2DF11
    cmp     [bp+arg_8], 0
    jz      short loc_2DEE9
    xor     cx, cx
    mov     dx, cx
    mov     ax, 4201h
    int     21h             ; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
    jb      short loc_2DF25
    test    [bp+arg_8], 2
    jnz     short loc_2DEEF
    add     ax, [bp+arg_2]
    adc     dx, [bp+arg_6]
    jns     short loc_2DF11
loc_2DEE9:
    mov     ax, 1600h
loc_2DEEC:
    stc
    jmp     short loc_2DF25
loc_2DEEF:
    mov     [bp+var_2], dx
    mov     [bp+var_4], ax
    mov     dx, cx
    mov     ax, 4202h
    int     21h             ; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
    add     ax, [bp+arg_2]
    adc     dx, [bp+arg_6]
    jns     short loc_2DF11
    mov     cx, [bp+var_2]
    mov     dx, [bp+var_4]
    mov     ax, 4200h
    int     21h             ; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
    jmp     short loc_2DEE9
loc_2DF11:
    mov     dx, [bp+arg_2]
loc_2DF14:
    mov     cx, [bp+arg_6]
    mov     al, byte ptr [bp+arg_8]
loc_2DF1A:
    mov     ah, 42h
loc_2DF1C:
    int     21h             ; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
    jb      short loc_2DF25
smart
smart
    and     byte ptr [bx+3684h], 0FDh
nosmart
loc_2DF25:
    jmp     __dosretax
_lseek endp
_write proc far
    var_8 = word ptr -8
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 8
    mov     bx, [bp+arg_0]
    cmp     bx, word_3EDF2
    jb      short loc_2DF3E
    mov     ax, 900h
    stc
loc_2DF3B:
    jmp     __dosretax
loc_2DF3E:
    test    byte ptr [bx+3684h], 20h
    jz      short loc_2DF50
    mov     ax, 4202h
    xor     cx, cx
    mov     dx, cx
    int     21h             ; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
    jb      short loc_2DF3B
loc_2DF50:
    test    byte ptr [bx+3684h], 80h
    jz      short loc_2DFC7
    mov     dx, [bp+arg_2]
    push    ds
    pop     es
    xor     ax, ax
    mov     [bp+var_2], ax
    mov     [bp+var_4], ax
    cld
    push    di
    push    si
    mov     di, dx
    mov     si, dx
    mov     [bp+var_8], sp
    mov     cx, [bp+arg_4]
    jcxz    short loc_2DFC9
    mov     al, 0Ah
    repne scasb
    jnz     short loc_2DFC5
    call    _stackavail
    cmp     ax, 0A8h ; '®'
    jbe     short loc_2DFCB
    sub     sp, 2
    mov     bx, sp
loc_2DF88:
    mov     dx, 200h
    cmp     ax, 228h
    jnb     short loc_2DF93
    mov     dx, 80h ; 'Ä'
loc_2DF93:
    sub     sp, dx
    mov     dx, sp
    mov     di, dx
    push    ss
    pop     es
    mov     cx, [bp+arg_4]
loc_2DF9E:
    lodsb
    cmp     al, 0Ah
    jz      short loc_2DFAF
loc_2DFA3:
    cmp     di, bx
    jz      short loc_2DFC0
loc_2DFA7:
    stosb
    loop    loc_2DF9E
    call near ptr loc_2DFD0
    jmp     short loc_2E010
loc_2DFAF:
    mov     al, 0Dh
    cmp     di, bx
    jnz     short loc_2DFB8
    call near ptr loc_2DFD0
loc_2DFB8:
    stosb
    mov     al, 0Ah
    inc     [bp+var_4]
    jmp     short loc_2DFA3
loc_2DFC0:
    call near ptr loc_2DFD0
    jmp     short loc_2DFA7
loc_2DFC5:
    pop     si
    pop     di
loc_2DFC7:
    jmp     short loc_2E01E
loc_2DFC9:
    jmp     short loc_2E010
loc_2DFCB:
    xor     ax, ax
    jmp     __amsg_exit
loc_2DFD0:
    push    ax
    push    bx
    push    cx
    mov     cx, di
    sub     cx, dx
    jcxz    short loc_2DFE9
    mov     bx, [bp+arg_0]
    mov     ah, 40h
    int     21h             ; DOS - 2+ - WRITE TO FILE WITH HANDLE
    jb      short loc_2DFEF
    add     [bp+var_2], ax
    or      ax, ax
    jz      short loc_2DFEF
    var_8 = word ptr -8
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
loc_2DFE9:
    pop     cx
    pop     bx
    pop     ax
    mov     di, dx
    retn
loc_2DFEF:
    add     sp, 8
    jnb     short loc_2DFF8
    mov     ah, 9
    jmp     short loc_2E016
loc_2DFF8:
    test    byte ptr [bx+3684h], 40h
    jz      short loc_2E00A
    mov     bx, [bp+arg_2]
    cmp     byte ptr [bx], 1Ah
    jnz     short loc_2E00A
    clc
    jmp     short loc_2E016
loc_2E00A:
    stc
    mov     ax, 1C00h
    jmp     short loc_2E016
loc_2E010:
    mov     ax, [bp+var_2]
    sub     ax, [bp+var_4]
loc_2E016:
    mov     sp, [bp+var_8]
    pop     si
    pop     di
loc_2E01B:
    jmp     __dosretax
loc_2E01E:
    mov     cx, [bp+arg_4]
    or      cx, cx
    jnz     short loc_2E02A
    mov     ax, cx
    jmp     __dosretax
loc_2E02A:
    mov     dx, [bp+arg_2]
    mov     ah, 40h
    int     21h             ; DOS - 2+ - WRITE TO FILE WITH HANDLE
    jnb     short loc_2E037
    mov     ah, 9
    jmp     short loc_2E01B
loc_2E037:
    or      ax, ax
    jnz     short loc_2E01B
    test    byte ptr [bx+3684h], 40h
    jz      short loc_2E04C
    mov     bx, dx
    cmp     byte ptr [bx], 1Ah
    jnz     short loc_2E04C
    clc
    jmp     short loc_2E01B
loc_2E04C:
    stc
    mov     ax, 1C00h
    jmp     short loc_2E01B
_write endp
_stackavail proc far

    pop     cx
    pop     dx
    mov     ax, word_3EE24
    cmp     ax, sp
    jnb     short loc_2E062
    sub     ax, sp
    neg     ax
loc_2E05F:
    push    dx
    push    cx
    retf
loc_2E062:
    xor     ax, ax
    jmp     short loc_2E05F
_stackavail endp
unknown_libname_1 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    or      bx, bx
    jz      short loc_2E074
smart
    or      byte ptr [bx-2], 1
nosmart
loc_2E074:
    mov     sp, bp
    pop     bp
    retf
unknown_libname_1 endp
unknown_libname_2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     bx, 37FEh
    cmp     word ptr [bx], 0
    jnz     short loc_2E0AE
    push    ds
    pop     es
    mov     ax, 5
    call near ptr __amallocbrk
    jnz     short loc_2E094
    xor     ax, ax
    cwd
    jmp     short loc_2E0B8
loc_2E094:
    inc     ax
smart
    and     al, 0FEh
nosmart
    mov     word_3EF6E, ax
    mov     word_3EF70, ax
    xchg    ax, si
    mov     word ptr [si], 1
    add     si, 4
    mov     word ptr [si-2], 0FFFEh
    mov     word_3EF74, si
loc_2E0AE:
    mov     cx, [bp+arg_0]
    mov     ax, ds
    mov     es, ax
    call near ptr __amalloc
loc_2E0B8:
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_2E0BE:
    jmp     loc_2E18F
unknown_libname_2 endp
__amalloc proc near

    inc     cx
    jz      short loc_2E0BE
smart
    and     cl, 0FEh
nosmart
    cmp     cx, 0FFEEh
    jnb     short loc_2E0BE
    mov     si, [bx+2]
    cld
    lodsw
    mov     di, si
    test    al, 1
    jz      short loc_2E119
loc_2E0D7:
    dec     ax
    cmp     ax, cx
    jnb     short loc_2E0F1
    mov     dx, ax
    add     si, ax
    lodsw
    test    al, 1
    jz      short loc_2E119
    add     ax, dx
    add     ax, 2
    mov     si, di
    mov     [si-2], ax
    jmp     short loc_2E0D7
loc_2E0F1:
    mov     di, si
    jz      short loc_2E101
    add     di, cx
    mov     [si-2], cx
    sub     ax, cx
    dec     ax
    mov     [di], ax
    jmp     short loc_2E106
loc_2E101:
    add     di, cx
    dec     byte ptr [si-2]
loc_2E106:
    mov     ax, si
    mov     dx, ds
    mov     cx, ss
    cmp     dx, cx
    jz      short loc_2E115
    mov     es:word_3EF7C, ds
loc_2E115:
    mov     [bx+2], di
    retn
loc_2E119:
    mov     es:byte_3EF82, 2
loc_2E11F:
    cmp     ax, 0FFFEh
    jz      short loc_2E149
    mov     di, si
    add     si, ax
loc_2E128:
    lodsw
    test    al, 1
    jz      short loc_2E11F
    mov     di, si
loc_2E12F:
    dec     ax
    cmp     ax, cx
    jnb     short loc_2E0F1
    mov     dx, ax
    add     si, ax
    lodsw
    test    al, 1
    jz      short loc_2E11F
    add     ax, dx
    add     ax, 2
    mov     si, di
    mov     [si-2], ax
    jmp     short loc_2E12F
loc_2E149:
    mov     ax, [bx+8]
    or      ax, ax
    jz      short loc_2E154
    mov     ds, ax
    jmp     short loc_2E168
loc_2E154:
    dec     es:byte_3EF82
    jz      short loc_2E16C
    mov     ax, ds
    mov     di, ss
    cmp     ax, di
    jz      short loc_2E168
    mov     ds, es:word_3EF78
loc_2E168:
    mov     si, [bx]
    jmp     short loc_2E128
loc_2E16C:
    mov     si, [bx+6]
    xor     ax, ax
    call near ptr __amlink
    cmp     ax, si
    jz      short loc_2E185
smart
    and     al, 1
nosmart
    inc     ax
    inc     ax
    cbw
    call near ptr __amlink
    jz      short loc_2E18F
    dec     byte ptr [di-2]
loc_2E185:
    call near ptr __amexpand
    jz      short loc_2E18F
loc_2E18A:
    xchg    ax, si
    dec     si
    dec     si
loc_2E18D:
    jmp     short loc_2E128
loc_2E18F:
    mov     ax, ds
    mov     cx, ss
    cmp     ax, cx
    jz      short loc_2E19B
    mov     es:word_3EF7C, ax
loc_2E19B:
    mov     ax, [bx]
    mov     [bx+2], ax
    xor     ax, ax
    cwd
    retn
__amalloc endp
__amexpand proc near

    push    cx
    mov     ax, [di-2]
    test    al, 1
    jz      short loc_2E1AF
    sub     cx, ax
    dec     cx
loc_2E1AF:
    inc     cx
    inc     cx
    mov     dx, 7FFFh
loc_2E1B4:
    cmp     dx, es:word_3EF7E
    jbe     short loc_2E1BF
    shr     dx, 1
    jnz     short loc_2E1B4
loc_2E1BF:
    mov     ax, cx
    add     ax, si
    jb      short loc_2E1DA
    add     ax, dx
    jb      short loc_2E1D6
    not     dx
    and     ax, dx
    sub     ax, si
    call near ptr __amlink
    jnz     short loc_2E1DC
    not     dx
loc_2E1D6:
    shr     dx, 1
    jnz     short loc_2E1BF
loc_2E1DA:
    xor     ax, ax
loc_2E1DC:
    pop     cx
    retn
__amexpand endp
__amlink proc near

    push    dx
    push    cx
    call near ptr __amallocbrk
    jz      short loc_2E1FD
    push    di
    mov     di, si
    mov     si, ax
    add     si, dx
    mov     word ptr [si-2], 0FFFEh
    mov     [bx+6], si
    mov     dx, si
    sub     dx, di
    dec     dx
    mov     [di-2], dx
    pop     ax
loc_2E1FD:
    pop     cx
    pop     dx
    retn
__amlink endp
__amallocbrk proc near
     r = byte ptr 0

    push    bx
    push    ax
    xor     dx, dx
    push    ds
    push    dx
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    push    es
    pop     ds
    call    _brkctl
    add     sp, 8
    cmp     dx, 0FFFFh
    pop     ds
    pop     dx
    pop     bx
    jz      short locret_2E220
    or      dx, dx
locret_2E220:
    retn
    ; align 2
    db 0
__amallocbrk endp
_brkctl proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    push    si
    push    di
    push    es
    cmp     [bp+arg_4], 0
    jnz     short loc_2E266
    mov     di, 360Ah
    mov     dx, [bp+arg_2]
    mov     ax, [bp+arg_0]
    dec     ax
    jnz     short loc_2E241
    call near ptr sub_2E290
    jb      short loc_2E266
    jmp     short loc_2E289
loc_2E241:
    mov     si, word_3EDCA
    dec     ax
    jz      short loc_2E259
    cmp     si, di
    jz      short loc_2E259
    mov     ax, [si+2]
    mov     [bp+arg_8], ax
    push    si
    call near ptr sub_2E290
    pop     si
    jnb     short loc_2E289
loc_2E259:
    add     si, 4
    cmp     si, 365Ah
    jnb     short loc_2E266
    or      dx, dx
    jnz     short loc_2E26C
loc_2E266:
    mov     ax, 0FFFFh
    cwd
    jmp     short loc_2E289
loc_2E26C:
    mov     bx, dx
    add     bx, 0Fh
    rcr     bx, 1
    mov     cl, 3
    shr     bx, cl
    mov     ah, 48h
    int     21h             ; DOS - 2+ - ALLOCATE MEMORY
    jb      short loc_2E266
    xchg    ax, dx
    mov     [si], ax
    mov     [si+2], dx
    mov     word_3EDCA, si
    xor     ax, ax
loc_2E289:
    pop     es
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
_brkctl endp
sub_2E290 proc near

    mov     cx, [bp+0Eh]
    mov     si, di
loc_2E295:
    cmp     [si+2], cx
    jz      short loc_2E2A6
    add     si, 4
    cmp     si, 365Ah
    jnz     short loc_2E295
    stc
    jmp     short locret_2E2E5
loc_2E2A6:
    mov     bx, dx
    add     bx, [si]
    jb      short locret_2E2E5
    mov     dx, bx
    mov     es, cx
    cmp     si, di
    jnz     short loc_2E2BA
    cmp     word_3ED74, bx
    jnb     short loc_2E2E0
loc_2E2BA:
    add     bx, 0Fh
loc_2E2BD:
    rcr     bx, 1
loc_2E2BF:
    shr     bx, 1
    shr     bx, 1
    shr     bx, 1
loc_2E2C5:
    cmp     si, di
    jnz     short loc_2E2D2
    add     bx, cx
    mov     ax, crtpspseg
    sub     bx, ax
    mov     es, ax
loc_2E2D2:
    mov     ah, 4Ah
    int     21h             ; DOS - 2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
    jb      short locret_2E2E5
    cmp     si, di
    jnz     short loc_2E2E0
    mov     word_3ED74, dx
loc_2E2E0:
    xchg    ax, dx
    xchg    ax, [si]
    mov     dx, cx
locret_2E2E5:
    retn
sub_2E290 endp
_strcat proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     dx, di
    mov     bx, si
    mov     ax, ds
    mov     es, ax
    mov     di, [bp+arg_0]
    xor     ax, ax
    mov     cx, 0FFFFh
    repne scasb
    lea     si, [di-1]
    mov     di, [bp+arg_2]
    mov     cx, 0FFFFh
    repne scasb
    not     cx
    sub     di, cx
    xchg    di, si
    mov     ax, [bp+arg_0]
    test    si, 1
    jz      short loc_2E317
    movsb
    dec     cx
loc_2E317:
    shr     cx, 1
    rep movsw
    adc     cx, cx
    rep movsb
    mov     si, bx
    mov     di, dx
    pop     bp
    retf
    ; align 2
    db 0
_strcat endp
_strcpy proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     dx, di
    mov     bx, si
    mov     si, [bp+arg_2]
    mov     di, si
    mov     ax, ds
    mov     es, ax
    xor     ax, ax
    mov     cx, 0FFFFh
    repne scasb
    not     cx
    mov     di, [bp+arg_0]
    mov     ax, di
    test    al, 1
    jz      short loc_2E34A
    movsb
    dec     cx
loc_2E34A:
    shr     cx, 1
    rep movsw
    adc     cx, cx
    rep movsb
    mov     si, bx
    mov     di, dx
    pop     bp
    retf
_strcpy endp
_strcmp proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     dx, di
    mov     bx, si
    mov     ax, ds
    mov     es, ax
    mov     si, [bp+arg_0]
    mov     di, [bp+arg_2]
    xor     ax, ax
    mov     cx, 0FFFFh
    repne scasb
    not     cx
    sub     di, cx
    repe cmpsb
    jz      short loc_2E37D
    sbb     ax, ax
    sbb     ax, 0FFFFh
loc_2E37D:
    mov     si, bx
    mov     di, dx
    pop     bp
    retf
    ; align 2
    db 0
_strcmp endp
_strlen proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     dx, di
    mov     ax, ds
    mov     es, ax
    mov     di, [bp+arg_0]
    xor     ax, ax
    mov     cx, 0FFFFh
    repne scasb
    not     cx
    dec     cx
    xchg    ax, cx
    mov     di, dx
    pop     bp
    retf
    ; align 2
    db 0
_strlen endp
_itoa proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     bl, 1
    mov     cx, [bp+arg_6]
    mov     ax, [bp+arg_2]
    xor     dx, dx
    cmp     cx, 0Ah
    jnz     short loc_2E3B5
    cwd
loc_2E3B5:
    mov     di, [bp+arg_4]
    jmp     __cxtoa
    ; align 2
    db 0
_itoa endp
_ultoa proc near
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     bl, 0
    jmp     __cltoasub
_ultoa endp
_abort proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    mov     ax, 0Ah
    push    ax
    call    __NMSG_WRITE
    mov     ax, 16h
    push    ax              ; int
    call    _raise
    mov     ax, 3
    push    ax
    call    far ptr libsub_quit_to_dos
    mov     sp, bp
    pop     bp
    retf
_abort endp
_isatty proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    cmp     bx, word_3EDF2
    jge     short loc_2E405
    cmp     bx, 0
    jl      short loc_2E405
    test    byte ptr [bx+3684h], 40h
    jz      short loc_2E405
    mov     ax, 1
    jmp     short loc_2E407
loc_2E405:
    xor     ax, ax
loc_2E407:
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
_isatty endp
_int86 proc far
    var_E = dword ptr -14
    var_A = byte ptr -10
    var_9 = byte ptr -9
    var_8 = byte ptr -8
    var_7 = byte ptr -7
    var_6 = byte ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    push    di
    sub     sp, 0Ah
    mov     [bp+var_A], 0CDh ; 'Õ'
    mov     ax, [bp+arg_0]
    mov     [bp+var_9], al
    cmp     al, 25h ; '%'
    jz      short loc_2E42C
    cmp     al, 26h ; '&'
    jz      short loc_2E42C
    mov     [bp+var_8], 0CBh ; 'À'
    jmp     short loc_2E438
loc_2E42C:
    mov     [bp+var_6], 0CBh ; 'À'
    mov     [bp+var_7], 44h ; 'D'
    mov     [bp+var_8], 44h ; 'D'
loc_2E438:
    mov     word ptr [bp+var_E+2], ss
    lea     ax, [bp+var_A]
    mov     word ptr [bp+var_E], ax
    mov     di, [bp+arg_2]
    mov     ax, [di]
    mov     bx, [di+2]
    mov     cx, [di+4]
    mov     dx, [di+6]
    mov     si, [di+8]
    mov     di, [di+0Ah]
    push    bp
    call    [bp+var_E]
    pop     bp
    cld
    push    di
loc_2E45C:
    mov     di, [bp+arg_4]
    mov     [di], ax
    mov     [di+2], bx
    mov     [di+4], cx
    mov     [di+6], dx
    mov     [di+8], si
    pop     word ptr [di+0Ah]
    jb      short loc_2E476
    xor     si, si
    jmp     short loc_2E480
loc_2E476:
    call    __maperror
    mov     si, 1
    mov     ax, [di]
loc_2E480:
    mov     [di+0Ch], si
    add     sp, 0Ah
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
_int86 endp
_sprintf proc far
    var_C = FILE ptr -12
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = byte ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    di
    push    si
    lea     ax, [bp+var_C]
    mov     di, ax
    lea     ax, [bp+arg_4]
    mov     word ptr [bp+var_C._flag], ax
    mov     byte ptr [di+6], 42h ; 'B'
    mov     ax, [bp+arg_0]
    mov     [di+4], ax
    mov     [di], ax
    mov     word ptr [di+2], 7FFFh
    lea     ax, [bp+arg_4]
    push    ax
    push    [bp+arg_2]
    push    di
    call    __output
    add     sp, 6
    mov     si, ax
    dec     word ptr [di+2]
    js      short loc_2E4D2
    sub     al, al
    mov     bx, [di]
    inc     word ptr [di]
    mov     [bx], al
    jmp     short loc_2E4DE
    ; align 2
    db 144
loc_2E4D2:
    push    di              ; FILE *
    sub     ax, ax
    push    ax              ; int
    call    __flsbuf
    add     sp, 4
loc_2E4DE:
    mov     ax, si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
_sprintf endp
_stricmp proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     dx, si
    mov     si, [bp+arg_2]
    mov     bx, [bp+arg_0]
    mov     al, 0FFh
loc_2E4F3:
    or      al, al
    jz      short loc_2E523
    lodsb
    mov     ah, [bx]
    inc     bx
    cmp     ah, al
    jz      short loc_2E4F3
    sub     al, 41h ; 'A'
    cmp     al, 1Ah
    sbb     cl, cl
smart
    and     cl, 20h
nosmart
    add     al, cl
    add     al, 41h ; 'A'
    xchg    ah, al
    sub     al, 41h ; 'A'
    cmp     al, 1Ah
    sbb     cl, cl
smart
    and     cl, 20h
nosmart
    add     al, cl
    add     al, 41h ; 'A'
    cmp     al, ah
    jz      short loc_2E4F3
    sbb     al, al
    sbb     al, 0FFh
loc_2E523:
    cbw
    mov     si, dx
    pop     bp
    retf
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12
__cltoasub:
    mov     cx, [bp+arg_8]
    mov     ax, [bp+arg_2]
    mov     dx, [bp+arg_4]
    mov     di, [bp+arg_6]
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
__cxtoa:
    push    di
    push    ds
    pop     es
    cld
    xchg    ax, bx
    or      al, al
    jz      short loc_2E550
    cmp     cx, 0Ah
    jnz     short loc_2E550
    or      dx, dx
    jns     short loc_2E550
    mov     al, 2Dh ; '-'
    stosb
    neg     bx
    adc     dx, 0
    neg     dx
loc_2E550:
    mov     si, di
loc_2E552:
    xchg    ax, dx
    xor     dx, dx
    or      ax, ax
    jz      short loc_2E55B
    div     cx
loc_2E55B:
    xchg    ax, bx
    div     cx
    xchg    ax, dx
    xchg    dx, bx
    add     al, 30h ; '0'
    cmp     al, 39h ; '9'
    jbe     short loc_2E569
    add     al, 27h ; '''
loc_2E569:
    stosb
    mov     ax, dx
    or      ax, bx
    jnz     short loc_2E552
    mov     [di], al
loc_2E572:
    dec     di
    lodsb
    xchg    al, [di]
    mov     [si-1], al
    lea     ax, [si+1]
    cmp     ax, di
    jb      short loc_2E572
    pop     ax
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
_stricmp endp
_abs proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    cmp     [bp+arg_0], 0
    jl      short loc_2E596
    mov     ax, [bp+arg_0]
    jmp     short loc_2E59B
loc_2E596:
    mov     ax, [bp+arg_0]
    neg     ax
loc_2E59B:
    pop     bp
    retf
    ; align 2
    db 144
off_2E59E     dw offset loc_2E635
    dw offset loc_2E626
    dw offset loc_2E61E
    dw offset loc_2E626
    dw offset loc_2E626
    dw offset loc_2E626
_abs endp
_raise proc far
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    mov     ax, [bp+arg_0]
    cmp     ax, 2
    jnz     short loc_2E5C1
    clc
    int     23h             ; DOS - CONTROL "C" EXIT ADDRESS
    jnb     short loc_2E635
    mov     ah, 4Ch
    int     21h             ; DOS - 2+ - QUIT WITH EXIT CODE (EXIT)
loc_2E5C1:
    cmp     ax, 8
    jnz     short loc_2E5D0
    mov     bx, word ptr dword_40C1E
    or      bx, word ptr dword_40C1E+2
    jz      short loc_2E62F
loc_2E5D0:
    call    __sigentry
    jb      short loc_2E62F
    mov     ax, [bx]
    mov     dx, [bx+2]
    or      dx, dx
    jnz     short loc_2E5F2
    cmp     ax, 1
    ja      short loc_2E5F2
    or      ax, ax
    jnz     short loc_2E635
    mov     bx, cx
loc_2E5EB:
    shl     bx, 1
    jmp     cs:off_2E59E[bx]
loc_2E5F2:
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    push    es
    push    bp
    push    di
    push    si
    mov     cx, [bp+arg_0]
    cmp     cx, 8
    jz      short loc_2E60B
    xor     ax, ax
    mov     [bx], ax
    mov     [bx+2], ax
loc_2E60B:
    mov     ax, 8Ch ; 'å'
    push    ax
    push    cx
    cld
    call    [bp+var_4]
    add     sp, 4
    pop     si
    pop     di
    pop     bp
    pop     es
    jmp     short loc_2E635
    ; align 2
    db 144
loc_2E61E:
    mov     ax, 8Ch ; 'å'
    call    ss:dword_40C26
loc_2E626:
    mov     ax, 3
    push    ax
    call    far ptr libsub_quit_to_dos
loc_2E62F:
    mov     ax, 0FFFFh
    jmp     short loc_2E637
    db 144
loc_2E635:
    xor     ax, ax
loc_2E637:
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
_raise endp
_srand proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     word_3F0A0, ax
    mov     word_3F0A2, 0
    pop     bp
    retf
    ; align 2
    db 144
_srand endp
_rand proc far

    mov     ax, 43FDh
loc_2E651:
    mov     dx, 3
    push    dx
    push    ax
    push    word_3F0A2
loc_2E65A:
    push    word_3F0A0
    call    __aFlmul
loc_2E663:
    add     ax, 9EC3h
loc_2E666:
    adc     dx, 26h ; '&'
    mov     word_3F0A0, ax
    mov     word_3F0A2, dx
    mov     ax, dx
smart
    and     ah, 7Fh
nosmart
    retf
    db 2
    db 4
    db 8
    db 11
    db 15
    db 22
_rand endp
_signal proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 4
    mov     ax, [bp+arg_0]
    cmp     ax, 8
    jnz     short loc_2E69B
    mov     bx, word ptr dword_40C1E
    or      bx, word ptr dword_40C1E+2
    jnz     short loc_2E69B
loc_2E694:
    mov     ax, 1600h
    stc
    jmp     __dosretax
loc_2E69B:
    call    __sigentry
    jb      short loc_2E694
    mov     ax, [bx]
    mov     [bp+var_2], ax
    mov     ax, [bx+2]
    mov     [bp+var_4], ax
    mov     ax, [bp+arg_2]
    mov     dx, [bp+arg_4]
    mov     [bx], ax
    mov     [bx+2], dx
    mov     cx, [bp+arg_0]
    cmp     cx, 2
    jnz     short loc_2E6EC
    or      dx, dx
    jnz     short loc_2E6C8
    or      ax, ax
    jz      short loc_2E6EC
loc_2E6C8:
    cmp     word_3EF98, 0
    jnz     short loc_2E6EC
    push    bx
    mov     al, 23h ; '#'
    mov     ah, 35h
    int     21h             ; DOS - 2+ - GET INTERRUPT VECTOR
    mov     word_3EF98, es
    mov     word_3EF9A, bx
    pop     bx
    mov     dx, 1AF7h
    push    ds
    push    cs
    pop     ds
    mov     al, 23h ; '#'
    mov     ah, 25h
    int     21h             ; DOS - SET INTERRUPT VECTOR
    pop     ds
loc_2E6EC:
    cmp     cx, 8
    jnz     short loc_2E715
    mov     ax, 1B7Bh
    mov     dx, [bx+2]
    or      dx, dx
    jnz     short loc_2E70C
    mov     cx, [bx]
    cmp     cx, 2
    jnb     short loc_2E70C
    mov     ax, 1B76h
    or      cx, cx
    jz      short loc_2E70C
    mov     ax, 1B75h
loc_2E70C:
    mov     dx, cs
    mov     bx, 3
    call    dword_40C1E
loc_2E715:
    mov     ax, [bp+var_2]
    mov     dx, [bp+var_4]
    mov     sp, bp
    pop     bp
    retf
_signal endp
__sigentry proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    lea     bx, ds:1A2Bh
    mov     cx, 6
loc_2E729:
    cmp     cs:[bx], al
    jz      short loc_2E735
    dec     bx
    loop    loc_2E729
    stc
    jmp     short loc_2E743
    db 144
loc_2E735:
    dec     cx
    mov     ax, cx
    shl     ax, 1
    shl     ax, 1
    lea     bx, word_3F0A4
    add     bx, ax
    clc
loc_2E743:
    mov     sp, bp
    pop     bp
    retf
    push    ax
    lahf
    push    ax
    push    ds
    push    dx
    mov     ax, seg dseg
    mov     ds, ax
    cmp     word_3EE14, 0
    jnz     short loc_2E76C
    mov     ax, word_3F0A4
    mov     dx, word_3F0A6
    or      dx, dx
    jnz     short loc_2E799
    cmp     ax, 1
    ja      short loc_2E799
    or      ax, ax
    jnz     short loc_2E7BE
loc_2E76C:
    sub     sp, 4
    push    bp
    mov     bp, sp
    add     bp, 2
    mov     al, 4
loc_2E777:
    mov     dx, [bp+4]
    mov     [bp+0], dx
    inc     bp
    inc     bp
    dec     al
    cmp     al, 0
    jnz     short loc_2E777
    mov     ax, word_3EF9A
    mov     [bp+0], ax
    mov     ax, word_3EF98
    mov     [bp+2], ax
    pop     bp
    pop     dx
    pop     ds
    pop     ax
    sahf
    pop     ax
    stc
    retf
loc_2E799:
    mov     word ptr dword_3F0BC, ax
    mov     word ptr dword_3F0BC+2, dx
    push    es
    push    bp
    push    di
    push    si
    push    cx
    push    bx
    xor     ax, ax
    mov     word_3F0A4, ax
    mov     word_3F0A6, ax
    mov     ax, 2
    push    ax
    cld
    call    dword_3F0BC
    pop     ax
    pop     bx
    pop     cx
    pop     si
    pop     di
    pop     bp
    pop     es
loc_2E7BE:
    pop     dx
    pop     ds
    pop     ax
    sahf
    pop     ax
    clc
    retf
    retf
    jmp     ss:dword_40C26
    push    bx
    push    cx
    push    dx
    push    es
    xor     ah, ah
    push    ax
    mov     ax, 8
    push    ax
    call    __sigentry
    push    ss
    pop     ds
    call    dword ptr [bx]
    add     sp, 4
    pop     es
    pop     dx
    pop     cx
    pop     bx
    retf
    ; align 2
    db 0
    jmp     __aFldiv
    jmp     unknown_libname_3; MS Quick C v1.0/v2.01 & MSC v5.1 DOS run-time & graphic
    jmp     __aFlmul
    jmp     __aFFblmul
    jmp     unknown_libname_4; MS Quick C v1.0/v2.01 & MSC v5.1 DOS run-time & graphic
    jmp     __aFlshr
    jmp     __aFuldiv
    jmp     unknown_libname_5; MS Quick C v1.0/v2.01 & MSC v5.1 DOS run-time & graphic
__sigentry endp
_strrchr proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = byte ptr 8

    push    bp
    mov     bp, sp
    push    di
    push    ds
    pop     es
    mov     di, [bp+arg_0]
    xor     ax, ax
loc_2E81B:
    mov     cx, 0FFFFh
    repne scasb
    inc     cx
    neg     cx
    dec     di
    mov     al, [bp+arg_2]
    std
    repne scasb
    inc     di
    cmp     [di], al
    jz      short loc_2E833
    xor     ax, ax
    jmp     short loc_2E835
loc_2E833:
    mov     ax, di
loc_2E835:
    cld
    pop     di
    mov     sp, bp
    pop     bp
locret_2E83A:
    retf
    ; align 2
    db 0
_strrchr endp
__aFldiv proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
loc_2E83D:
    mov     bp, sp
    push    di
    push    si
    push    bx
    xor     di, di
    mov     ax, [bp+arg_2]
    or      ax, ax
    jge     short loc_2E85C
    inc     di
    mov     dx, [bp+arg_0]
    neg     ax
    neg     dx
    sbb     ax, 0
    mov     [bp+arg_2], ax
    mov     [bp+arg_0], dx
loc_2E85C:
    mov     ax, [bp+arg_6]
    or      ax, ax
    jge     short loc_2E874
    inc     di
    mov     dx, [bp+arg_4]
    neg     ax
    neg     dx
    sbb     ax, 0
    mov     [bp+arg_6], ax
    mov     [bp+arg_4], dx
loc_2E874:
    or      ax, ax
    jnz     short loc_2E88D
    mov     cx, [bp+arg_4]
    mov     ax, [bp+arg_2]
    xor     dx, dx
    div     cx
    mov     bx, ax
    mov     ax, [bp+arg_0]
    div     cx
    mov     dx, bx
    jmp     short loc_2E8C5
loc_2E88D:
    mov     bx, ax
    mov     cx, [bp+arg_4]
    mov     dx, [bp+arg_2]
    mov     ax, [bp+arg_0]
loc_2E898:
    shr     bx, 1
    rcr     cx, 1
    shr     dx, 1
    rcr     ax, 1
    or      bx, bx
    jnz     short loc_2E898
    div     cx
    mov     si, ax
    mul     [bp+arg_6]
    xchg    ax, cx
    mov     ax, [bp+arg_4]
    mul     si
    add     dx, cx
    jb      short loc_2E8C1
    cmp     dx, [bp+arg_2]
    ja      short loc_2E8C1
    jb      short loc_2E8C2
loc_2E8BC:
    cmp     ax, [bp+arg_0]
loc_2E8BF:
    jbe     short loc_2E8C2
loc_2E8C1:
    dec     si
loc_2E8C2:
    xor     dx, dx
    xchg    ax, si
loc_2E8C5:
    dec     di
    jnz     short loc_2E8CF
    neg     dx
    neg     ax
    sbb     dx, 0
loc_2E8CF:
    pop     bx
    pop     si
    pop     di
loc_2E8D2:
    mov     sp, bp
    pop     bp
    retf    8
__aFldiv endp
__aFlmul proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_2]
    mov     bx, [bp+arg_6]
    or      bx, ax
loc_2E8E3:
    mov     bx, [bp+arg_4]
    jnz     short loc_2E8F3
    mov     ax, [bp+arg_0]
    mul     bx
    mov     sp, bp
    pop     bp
locret_2E8F0:
    retf    8
loc_2E8F3:
    mul     bx
    mov     cx, ax
    mov     ax, [bp+arg_0]
    mul     [bp+arg_6]
    add     cx, ax
    mov     ax, [bp+arg_0]
    mul     bx
    add     dx, cx
loc_2E906:
    mov     sp, bp
    pop     bp
    retf    8
__aFlmul endp
__aFlshr proc far

    xor     ch, ch
loc_2E90E:
    jcxz    short locret_2E916
loc_2E910:
    sar     dx, 1
    rcr     ax, 1
    loop    loc_2E910
locret_2E916:
    retf
    ; align 2
    db 0
__aFlshr endp
unknown_libname_3 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    push    [bp+arg_4]
loc_2E921:
    push    [bp+arg_2]
    push    word ptr [bx+2]
    push    word ptr [bx]
    call    __aFldiv
    mov     bx, [bp+arg_0]
    mov     [bx+2], dx
    mov     [bx], ax
    mov     sp, bp
    pop     bp
    retf    6
unknown_libname_3 endp
__aFFblmul proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    push    [bp+arg_4]
    push    [bp+arg_2]
    push    word ptr [bx+2]
    push    word ptr [bx]
    call    __aFlmul
    mov     bx, [bp+arg_0]
    mov     [bx], ax
    mov     [bx+2], dx
    mov     sp, bp
    pop     bp
    retf    6
__aFFblmul endp
unknown_libname_4 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    mov     ax, [bx]
    mov     dx, [bx+2]
    mov     cx, [bp+arg_2]
    call    __aFlshr
    mov     bx, [bp+arg_0]
    mov     [bx], ax
    mov     [bx+2], dx
    mov     sp, bp
    pop     bp
    retf    4
    ; align 2
    db 0
unknown_libname_4 endp
unknown_libname_5 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
loc_2E988:
    push    [bp+arg_4]
    push    [bp+arg_2]
    push    word ptr [bx+2]
    push    word ptr [bx]
    call    __aFuldiv
    mov     bx, [bp+arg_0]
    mov     [bx+2], dx
    mov     [bx], ax
    mov     sp, bp
    pop     bp
    retf    6
unknown_libname_5 endp
__aFuldiv proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    push    bx
    push    si
    mov     ax, [bp+arg_6]
    or      ax, ax
    jnz     short loc_2E9C7
loc_2E9B2:
    mov     cx, [bp+arg_4]
    mov     ax, [bp+arg_2]
    xor     dx, dx
    div     cx
    mov     bx, ax
loc_2E9BE:
    mov     ax, [bp+arg_0]
loc_2E9C1:
    div     cx
loc_2E9C3:
    mov     dx, bx
loc_2E9C5:
    jmp     short loc_2E9FF
loc_2E9C7:
    mov     cx, ax
    mov     bx, [bp+arg_4]
loc_2E9CC:
    mov     dx, [bp+arg_2]
    mov     ax, [bp+arg_0]
loc_2E9D2:
    shr     cx, 1
loc_2E9D4:
    rcr     bx, 1
    shr     dx, 1
loc_2E9D8:
    rcr     ax, 1
loc_2E9DA:
    or      cx, cx
loc_2E9DC:
    jnz     short loc_2E9D2
    div     bx
    mov     si, ax
loc_2E9E2:
    mul     [bp+arg_6]
    xchg    ax, cx
loc_2E9E6:
    mov     ax, [bp+arg_4]
loc_2E9E9:
    mul     si
    add     dx, cx
loc_2E9ED:
    jb      short loc_2E9FB
loc_2E9EF:
    cmp     dx, [bp+arg_2]
loc_2E9F2:
    ja      short loc_2E9FB
    jb      short loc_2E9FC
loc_2E9F6:
    cmp     ax, [bp+arg_0]
loc_2E9F9:
    jbe     short loc_2E9FC
loc_2E9FB:
    dec     si
loc_2E9FC:
    xor     dx, dx
loc_2E9FE:
    xchg    ax, si
loc_2E9FF:
    pop     si
loc_2EA00:
    pop     bx
loc_2EA01:
    mov     sp, bp
loc_2EA03:
    pop     bp
locret_2EA04:
    retf    8
__aFuldiv endp
seg010 ends
end start
