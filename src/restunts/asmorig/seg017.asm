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
    include seg010.inc
    include seg011.inc
    include seg012.inc
    include seg013.inc
    include seg014.inc
    include seg015.inc
    include seg016.inc
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
seg017 segment byte public 'STUNTSC' use16
    assume cs:seg017
    assume es:nothing, ss:nothing, ds:dseg
    public mouse_set_pixratio
    public mouse_init
    public mouse_set_minmax
    public mouse_set_position
    public mouse_get_state
    public nopsub_36A9A
    public nopsub_36ACA
mouse_set_pixratio proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
loc_368AB:
    mov     bp, sp
loc_368AD:
    mov     word ptr regs_x86, 0Fh
loc_368B3:
    mov     ax, [bp+arg_0]
loc_368B6:
    mov     word ptr regs_x86+4, ax
loc_368B9:
    mov     ax, [bp+arg_2]
loc_368BC:
    mov     word ptr regs_x86+6, ax
loc_368BF:
    mov     ax, offset regs_x86
loc_368C2:
    push    ax
    push    ax              ; union REGS *
loc_368C4:
    mov     ax, 33h         ; int 33,f = set mouse mickey pixel ratio
    push    ax              ; int
loc_368C8:
    call    _int86
loc_368CD:
    add     sp, 6
loc_368D0:
    pop     bp
    retf
mouse_set_pixratio endp
mouse_init proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
loc_368D3:
    mov     bp, sp
loc_368D5:
    sub     sp, 2
loc_368D8:
    mov     word ptr regs_x86, 0C201h
loc_368DE:
    mov     ax, offset regs_x86
    push    ax
loc_368E2:
    push    ax              ; union REGS *
loc_368E3:
    mov     ax, 15h         ; int 15,c201 = enable ps2 pointing device
loc_368E6:
    push    ax              ; int
loc_368E7:
    call    _int86
loc_368EC:
    add     sp, 6
loc_368EF:
    mov     word ptr regs_x86, 0
    mov     ax, 921Ah
    push    ax
    push    ax              ; union REGS *
loc_368FA:
    mov     ax, 33h         ; int 33,0 = mouse reset/get mouse installed
    push    ax              ; int
    call    _int86
loc_36903:
    add     sp, 6
    mov     ax, word ptr regs_x86
    mov     [bp+var_2], ax
loc_3690C:
    mov     ax, word ptr regs_x86+2
    mov     word_45D7C, ax
loc_36912:
    cmp     [bp+var_2], 0
loc_36916:
    jz      short loc_36955
loc_36918:
    cmp     [bp+arg_0], 140h
    jnz     short loc_36928
    mov     mousehorscale, 1
    jmp     short loc_3692E
    ; align 2
    db 144
loc_36928:
    mov     mousehorscale, 0
loc_3692E:
    mov     ax, [bp+arg_2]
    dec     ax
    push    ax
    mov     ax, [bp+arg_0]
    dec     ax
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    cs
    call near ptr mouse_set_minmax
    add     sp, 8
    mov     ax, 10h
    push    ax
    push    ax
    push    cs
    call near ptr mouse_set_pixratio
    add     sp, 4
loc_3694F:
    mov     word_40318, 0FFFFh
loc_36955:
    mov     ax, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
mouse_init endp
mouse_set_minmax proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
loc_3695D:
    mov     bp, sp
loc_3695F:
    mov     word ptr regs_x86, 7
loc_36965:
    mov     ax, [bp+arg_0]
loc_36968:
    mov     cl, byte ptr mousehorscale
loc_3696C:
    shl     ax, cl
loc_3696E:
    mov     word ptr regs_x86+4, ax
loc_36971:
    mov     ax, [bp+arg_4]
    shl     ax, cl
    mov     word ptr regs_x86+6, ax
    mov     ax, offset regs_x86
    push    ax
    push    ax              ; union REGS *
    mov     ax, 33h         ; int 33,0 = mouse reset/get mouse installed
    push    ax              ; int
    call    _int86
    add     sp, 6
    mov     word ptr regs_x86, 8
    mov     ax, [bp+arg_2]
    mov     word ptr regs_x86+4, ax
    mov     ax, [bp+arg_6]
    mov     word ptr regs_x86+6, ax
    mov     ax, offset regs_x86
    push    ax
    push    ax              ; union REGS *
    mov     ax, 33h         ; int 33, 8 = set mouse vert min/max
    push    ax              ; int
    call    _int86
    add     sp, 6
    pop     bp
locret_369AE:
    retf
    ; align 2
    db 144
loc_369B0:
    mov     word ptr regs_x86, 3
    mov     ax, offset regs_x86
    push    ax
    push    ax
    mov     ax, 33h         ; int 33,3 = get mouse pos/but status
    push    ax
loc_369BF:
    call    _int86
    add     sp, 6
    mov     ax, word ptr regs_x86+2
    mov     word_45D7C, ax
    mov     ax, word ptr regs_x86+4
    mov     cl, byte ptr mousehorscale
loc_369D4:
    shr     ax, cl
    mov     word_44D3C, ax
    mov     ax, word ptr regs_x86+6
    mov     word_44D62, ax
    mov     ax, word_45D7C
locret_369E2:
    retf
    ; align 2
    db 144
    inc     showmouse
    cmp     showmouse, 1
    jl      short locret_36A0C
    mov     showmouse, 1
loc_369F5:
    mov     word ptr regs_x86, 1
    mov     ax, offset regs_x86
loc_369FE:
    push    ax
    push    ax
    mov     ax, 33h         ; int 33,1 = show mouse cursor
    push    ax
    call    _int86
    add     sp, 6
locret_36A0C:
    retf
    ; align 2
    db 144
    dec     showmouse
loc_36A12:
    jnz     short locret_36A2B
loc_36A14:
    mov     word ptr regs_x86, 2
    mov     ax, offset regs_x86
    push    ax
    push    ax
    mov     ax, 33h         ; int 33,2 = hide mouse cursor
    push    ax
    call    _int86
    add     sp, 6
locret_36A2B:
    retf
mouse_set_minmax endp
mouse_set_position proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     word ptr regs_x86, 4
    mov     ax, [bp+arg_0]
    mov     word_44D3C, ax
    mov     cl, byte ptr mousehorscale
    shl     ax, cl
    mov     word ptr regs_x86+4, ax
    mov     ax, [bp+arg_2]
    mov     word ptr regs_x86+6, ax
    mov     word_44D62, ax
    mov     ax, 921Ah
    push    ax
    push    ax              ; union REGS *
    mov     ax, 33h         ; int 33, 4 = set mouse cursor
    push    ax              ; int
    call    _int86
    add     sp, 6
    pop     bp
    retf
mouse_set_position endp
mouse_get_state proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     word ptr regs_x86, 3
    mov     ax, 921Ah
    push    ax
    push    ax              ; union REGS *
    mov     ax, 33h         ; int 33, 3 = get mouse position and button
    push    ax              ; int
    call    _int86
loc_36A77:
    add     sp, 6
    mov     bx, [bp+arg_0]
    mov     ax, word ptr regs_x86+2
    mov     [bx], ax
    mov     bx, [bp+arg_2]
    mov     ax, word ptr regs_x86+4
    mov     cl, byte ptr mousehorscale
    shr     ax, cl
    mov     [bx], ax
    mov     bx, [bp+arg_4]
    mov     ax, word ptr regs_x86+6
    mov     [bx], ax
    pop     bp
    retf
mouse_get_state endp
nopsub_36A9A proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     word ptr regs_x86, 7
loc_36AA3:
    mov     ax, [bp+arg_0]
    mov     cl, byte ptr mousehorscale
    sar     ax, cl
    mov     word ptr regs_x86+4, ax
loc_36AAF:
    mov     ax, [bp+arg_2]
loc_36AB2:
    sar     ax, cl
loc_36AB4:
    mov     word ptr regs_x86+6, ax
loc_36AB7:
    mov     ax, 921Ah
    push    ax
    push    ax              ; union REGS *
loc_36ABC:
    mov     ax, 33h ; '3'
    push    ax              ; int
loc_36AC0:
    call    _int86
    add     sp, 6
loc_36AC8:
    pop     bp
    retf
nopsub_36A9A endp
nopsub_36ACA proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
loc_36ACB:
    mov     bp, sp
loc_36ACD:
    mov     word ptr regs_x86, 8
    mov     ax, [bp+arg_0]
loc_36AD6:
    mov     word ptr regs_x86+4, ax
loc_36AD9:
    mov     ax, [bp+arg_2]
loc_36ADC:
    mov     word ptr regs_x86+6, ax
loc_36ADF:
    mov     ax, 921Ah
loc_36AE2:
    push    ax
    push    ax              ; union REGS *
loc_36AE4:
    mov     ax, 33h ; '3'
    push    ax              ; int
loc_36AE8:
    call    _int86
loc_36AED:
    add     sp, 6
loc_36AF0:
    pop     bp
locret_36AF1:
    retf
nopsub_36ACA endp
seg017 ends
end
