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
    include seg008.inc
    include seg009.inc
    include seg010.inc
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
seg007 segment byte public 'STUNTSC' use16
    assume cs:seg007
    assume es:nothing, ss:nothing, ds:dseg
    public audio_add_driver_timer
    public audio_remove_driver_timer
    public pad_id
    public audio_init_engine
    public audio_op_unk
    public audio_function2
    public audio_driver_timer
    public audio_op_unk2
    public nopsub_27220
    public nopsub_2726C
    public nopsub_272B0
    public audio_function2_wrap
    public audio_op_unk3
    public audio_op_unk4
    public audio_op_unk5
    public audio_op_unk6
    public audio_op_unk7
    public nopsub_27489
algn_26BAD:
    ; align 2
    db 144
audio_add_driver_timer proc far

    mov     bx, offset audiotimers
loc_26BB1:
    jmp     short loc_26BB9
loc_26BB3:
    mov     byte ptr [bx], 0
loc_26BB6:
    add     bx, 4Ch ; 'L'
loc_26BB9:
    cmp     bx, 6AD0h
loc_26BBD:
    jb      short loc_26BB3
loc_26BBF:
    mov     word_42240, 16h
loc_26BC5:
    mov     ax, offset audio_driver_timer
loc_26BC8:
    mov     dx, seg seg007
    push    dx
loc_26BCC:
    push    ax
loc_26BCD:
    call    timer_reg_callback
loc_26BD2:
    pop     bx
    pop     bx
locret_26BD4:
    retf
audio_add_driver_timer endp
audio_remove_driver_timer proc far
     r = byte ptr 0

    push    si
loc_26BD6:
    mov     si, offset audiotimers
loc_26BD9:
    jmp     short loc_26BEF
loc_26BDB:
    cmp     byte ptr [si], 1
loc_26BDE:
    jnz     short loc_26BE9
loc_26BE0:
    push    word ptr [si+2]
loc_26BE3:
    call    sub_374DE
loc_26BE8:
    pop     bx
loc_26BE9:
    mov     byte ptr [si], 0
loc_26BEC:
    add     si, 4Ch ; 'L'
loc_26BEF:
    cmp     si, 6AD0h
loc_26BF3:
    jb      short loc_26BDB
    mov     ax, offset audio_driver_timer
    mov     dx, seg seg007
    push    dx
loc_26BFC:
    push    ax
    call    timer_remove_callback
    pop     bx
    pop     bx
loc_26C04:
    pop     si
    retf
audio_remove_driver_timer endp
pad_id proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    push    si
loc_26C0A:
    les     bx, [bp+arg_0]
    mov     ax, es:[bx]
    mov     dx, es:[bx+2]
loc_26C14:
    mov     word_42242, ax
loc_26C17:
    mov     word_42244, dx
    mov     byte_42246, 0
    sub     si, si
loc_26C22:
    cmp     byte ptr word_42242[si], 0
    jnz     short loc_26C2E
loc_26C29:
    mov     byte ptr word_42242[si], 20h ; ' '
loc_26C2E:
    inc     si
    cmp     si, 4
    jl      short loc_26C22
    mov     ax, offset word_42242
    pop     si
    mov     sp, bp
    pop     bp
    retf
pad_id endp
audio_init_engine proc far
    var_18 = dword ptr -24
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_8 = dword ptr -8
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18

    push    bp
    mov     bp, sp
    sub     sp, 18h
    push    di
    push    si
    mov     di, 0FFFFh
    sub     dx, dx
    mov     bx, offset audiotimers
    jmp     short loc_26C5D
loc_26C4E:
    or      di, di
    jge     short loc_26C63
    cmp     byte ptr [bx], 0
    jnz     short loc_26C59
    mov     di, dx
loc_26C59:
    add     bx, 4Ch ; 'L'
    inc     dx
loc_26C5D:
    cmp     bx, offset word_42240; end of audiotimer
    jb      short loc_26C4E
loc_26C63:
    or      di, di
    jge     short loc_26C6A
    jmp     loc_26EE4
loc_26C6A:
    mov     ax, di
    mov     cx, 4Ch ; 'L'
    imul    cx
    add     ax, offset audiotimers
    mov     [bp+var_14], ax
    add     ax, 1Ch
    mov     [bp+var_12], ax
    mov     [bp+var_10], ds
    mov     cx, [bp+arg_2]
    mov     dx, [bp+arg_4]
    mov     word ptr [bp+var_8], cx
    mov     word ptr [bp+var_8+2], dx
    mov     [bp+var_4], ax
    mov     [bp+var_2], 0
    mov     [bp+var_E], di
    jmp     short loc_26CB5
loc_26C99:
    les     bx, [bp+var_8]
    add     word ptr [bp+var_8], 1
    jnb     short loc_26CA7
    add     word ptr [bp+var_8+2], 1000h
loc_26CA7:
    mov     al, es:[bx]
    mov     bx, [bp+var_4]
    inc     [bp+var_4]
    mov     [bx], al
    inc     [bp+var_2]
loc_26CB5:
    cmp     [bp+var_2], 30h ; '0'
    jl      short loc_26C99
    mov     di, [bp+var_12]
    mov     es, [bp+var_10]
    cmp     byte ptr es:[di+6], 0
    jz      short loc_26CCB
    jmp     loc_26E61
loc_26CCB:
    push    word ptr es:[di+0Ah]
    push    word ptr es:[di+8]
    mov     si, es
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    call    locate_shape_fatal
    add     sp, 6
    mov     es, si
    mov     es:[di+8], ax
    mov     es:[di+0Ah], dx
    push    word ptr es:[di+12h]
    push    word ptr es:[di+10h]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+10h], ax
    mov     es:[di+12h], dx
    push    word ptr es:[di+16h]
    push    word ptr es:[di+14h]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+14h], ax
    mov     es:[di+16h], dx
    push    word ptr es:[di+1Ah]
    push    word ptr es:[di+18h]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+18h], ax
    mov     es:[di+1Ah], dx
    push    word ptr es:[di+1Eh]
    push    word ptr es:[di+1Ch]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+1Ch], ax
    mov     es:[di+1Eh], dx
    push    word ptr es:[di+22h]
    push    word ptr es:[di+20h]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+20h], ax
    mov     es:[di+22h], dx
    push    word ptr es:[di+26h]
    push    word ptr es:[di+24h]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+24h], ax
    mov     es:[di+26h], dx
    push    word ptr es:[di+2Ah]
    push    word ptr es:[di+28h]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+28h], ax
    mov     es:[di+2Ah], dx
    push    word ptr es:[di+2Eh]
    push    word ptr es:[di+2Ch]
    push    cs
    call near ptr pad_id
    pop     bx
    pop     bx
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_C]
    push    [bp+arg_A]
    call    init_audio_resources
    add     sp, 0Ah
    mov     es, si
    mov     es:[di+2Ch], ax
    mov     es:[di+2Eh], dx
    mov     byte ptr es:[di+6], 1
loc_26E61:
    mov     si, [bp+var_14]
    mov     ax, 7Fh ; ''
    push    ax
    mov     ax, 0FFFFh
    push    ax
    call    sub_37470
    pop     bx
    pop     bx
    mov     [si+2], ax
    mov     byte ptr [si+1], 0
    mov     word ptr [si+4], 0
    sub     ax, ax
    mov     [si+8], ax
    mov     [si+6], ax
    mov     byte ptr [si+0Ah], 0
    mov     es, [bp+var_10]
    mov     ax, es:[di]
    mov     cx, es
    les     bx, es:[di+8]
    mov     dl, es:[bx+0Fh]
    mov     word ptr [bp+var_18], di
    mov     word ptr [bp+var_18+2], cx
    mov     cl, es:[bx+0Eh]
    sub     ch, ch
    mov     bx, dx
    sub     dx, dx
    div     cx
    mov     cl, 4
    sub     bh, bh
    shl     bx, cl
    add     ax, bx
    mov     [si+0Ch], ax
    mov     byte ptr [si+0Eh], 0FFh
    mov     ax, 0FFFFh
    mov     [si+10h], ax
    mov     [si+12h], ax
    mov     [si+14h], ax
    mov     [si+16h], ax
    les     bx, [bp+var_18]
    mov     ax, es:[bx]
    mov     [si+18h], ax
    sub     al, al
    mov     [si+1Ah], al
    mov     [si+1Bh], al
    mov     byte ptr [si], 1
    mov     ax, [bp+var_E]
    jmp     short loc_26EEE
loc_26EE4:
    mov     ax, offset aInitengineAllHandlesUsed_; "InitEngine: All handles used."
    push    ax
    call    far ptr fatal_error
    pop     bx
loc_26EEE:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_init_engine endp
audio_op_unk proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    di
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     si, ax
    add     si, offset audiotimers
    cmp     byte ptr [si], 1
    jnz     short loc_26F67
    cmp     byte ptr [si+1], 0
    jnz     short loc_26F67
    lea     bx, [si+1Ch]
    push    word ptr [bx+0Ah]
    push    word ptr [bx+8]
    push    word ptr [si+2]
    mov     di, bx
    call    sub_38CF8
    add     sp, 6
    mov     ax, [di]
    les     bx, [di+8]
    mov     cl, es:[bx+0Eh]
    sub     ch, ch
    sub     dx, dx
    div     cx
    mov     cl, 4
    mov     dl, es:[bx+0Fh]
    sub     dh, dh
    shl     dx, cl
    add     ax, dx
    mov     [si+0Ch], ax
    push    word ptr [si+2]
    push    ax
    call    sub_39050
    pop     bx
    pop     bx
    mov     [si+12h], ax
    mov     al, 1
    mov     [si+1], al
    mov     [si+1Ah], al
    sub     ax, ax
    push    ax
    push    word ptr [si+2]
    call    audio_unk2
    pop     bx
    pop     bx
loc_26F67:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_op_unk endp
audio_function2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     si, ax
    add     si, offset audiotimers
    cmp     byte ptr [si], 1
    jnz     short loc_26F9E
    cmp     byte ptr [si+1], 1
    jnz     short loc_26F9E
    push    word ptr [si+12h]
    call    sub_38156
    pop     bx
    mov     word ptr [si+12h], 0FFFFh
    mov     byte ptr [si+1], 0
    mov     byte ptr [si+1Ah], 1
loc_26F9E:
    pop     si
    mov     sp, bp
    pop     bp
    retf
audio_function2 endp
audio_driver_timer proc far
    var_4 = word ptr -4
    var_1 = byte ptr -1
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    call    compare_ds_ss
    or      ax, ax
    jnz     short loc_26FB7
    jmp     loc_27127
loc_26FB7:
    inc     word_3EB2A
    cmp     word_3EB2A, 2
    jge     short loc_26FCC
    cmp     byte_40634, 0
    jz      short loc_26FCC
    jmp     loc_27127
loc_26FCC:
    mov     [bp+var_4], 0
    mov     si, offset audiotimers
loc_26FD4:
    cmp     byte ptr [si], 0
    jnz     short loc_26FDC
    jmp     loc_2710B
loc_26FDC:
    cmp     audioflag6, 0
    jnz     short loc_26FE6
    jmp     loc_2710B
loc_26FE6:
    mov     cl, 4
    mov     al, [si+0Ah]
    sub     ah, ah
    shl     ax, cl
    mov     dx, [si+4]
    mov     bx, dx
    shl     dx, 1
    add     dx, bx
    shl     dx, 1
    add     dx, bx
    add     ax, dx
    mov     cl, 3
    shr     ax, cl
    mov     [si+4], ax
    mov     cl, 4
    shr     ax, cl
    mov     [bp+var_1], al
    cmp     al, [si+0Eh]
    jnz     short loc_27017
    cmp     byte ptr [si+1Ah], 0
    jz      short loc_2705D
loc_27017:
    mov     al, [bp+var_1]
    sub     ah, ah
    push    ax
    push    word ptr [si+2]
    mov     di, ax
    call    audio_unk2
    add     sp, 4
    mov     ax, di
    sub     di, 0Ah
    jns     short loc_27033
    sub     di, di
loc_27033:
    cmp     word ptr [si+14h], 0FFFFh
    jz      short loc_27045
    push    di
    push    word ptr [si+14h]
    call    audio_unk2
    add     sp, 4
loc_27045:
    cmp     word ptr [si+16h], 0FFFFh
    jz      short loc_27057
    push    di
    push    word ptr [si+16h]
    call    audio_unk2
    add     sp, 4
loc_27057:
    mov     al, [bp+var_1]
    mov     [si+0Eh], al
loc_2705D:
    mov     ax, [si+6]
    mov     dx, [si+8]
    mov     cx, ax
    mov     bx, dx
    shl     ax, 1
    rcl     dx, 1
    add     ax, cx
    adc     dx, bx
    shl     ax, 1
    rcl     dx, 1
    add     ax, cx
    adc     dx, bx
    mov     cx, [si+0Ch]
    sub     bx, bx
    shl     cx, 1
    rcl     bx, 1
    shl     cx, 1
    rcl     bx, 1
    shl     cx, 1
    rcl     bx, 1
    shl     cx, 1
    rcl     bx, 1
    add     cx, ax
    adc     bx, dx
    shr     bx, 1
    rcr     cx, 1
    shr     bx, 1
    rcr     cx, 1
    shr     bx, 1
    rcr     cx, 1
    mov     [si+6], cx
    mov     [si+8], bx
    shr     bx, 1
    rcr     cx, 1
    shr     bx, 1
    rcr     cx, 1
    shr     bx, 1
    rcr     cx, 1
    shr     bx, 1
    rcr     cx, 1
    mov     di, cx
    cmp     cx, [si+10h]
    jnz     short loc_270BF
    cmp     byte ptr [si+1Ah], 0
    jz      short loc_270D4
loc_270BF:
    cmp     word ptr [si+12h], 0FFFFh
    jz      short loc_270D4
    push    di
    push    word ptr [si+12h]
    call    sub_39088
    add     sp, 4
    mov     [si+10h], di
loc_270D4:
    mov     byte ptr [si+1Ah], 0
    cmp     byte ptr [si+1Bh], 0
    jz      short loc_2710B
    cmp     byte ptr [si+1], 0
    jz      short loc_270EE
    push    word ptr [si+14h]
    call    audio_init_chunk2
    jmp     short loc_27104
loc_270EE:
    push    word ptr [si+14h]
    call    sub_3771E
    add     sp, 2
    or      ax, ax
    jz      short loc_2710B
    push    [bp+var_4]
    push    cs
    call near ptr audio_op_unk
loc_27104:
    add     sp, 2
    mov     byte ptr [si+1Bh], 0
loc_2710B:
    add     si, 4Ch ; 'L'
    inc     [bp+var_4]
    cmp     [bp+var_4], 19h
    jge     short loc_2711A
    jmp     loc_26FD4
loc_2711A:
    cmp     word_3EB2A, 2
    jl      short loc_27127
    mov     word_3EB2A, 0
loc_27127:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audio_driver_timer endp
audio_op_unk2 proc far
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18
    arg_E = word ptr 20
    arg_10 = word ptr 22

    push    bp
    mov     bp, sp
    sub     sp, 16h
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, offset audiotimers
    mov     [bp+var_2], ax
    push    [bp+arg_C]
    push    [bp+arg_E]
    push    [bp+arg_A]
    call    polarRadius2D
    add     sp, 4
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_C], ax
    cmp     ax, 1770h
    jle     short loc_27172
    mov     [bp+var_8], 0
    mov     bx, [bp+var_2]
    mov     byte ptr [bx+0Ah], 0
    mov     sp, bp
    pop     bp
    retf
loc_27172:
    push    [bp+arg_6]
    push    [bp+arg_8]
    push    [bp+arg_4]
    call    polarRadius2D
    add     sp, 4
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_A], ax
    sub     ax, [bp+var_C]
    mov     [bp+var_16], ax
    mov     ax, 64h ; 'd'
    xor     dx, dx
    div     [bp+arg_10]
    imul    [bp+var_16]
loc_271A0:
    mov     [bp+var_16], ax
    mov     ax, 7Fh ; ''
    mul     [bp+var_C]
    mov     cx, 1770h
    div     cx
    neg     ax
    add     ax, 7Fh ; ''
    mov     [bp+var_8], ax
    cmp     [bp+var_16], 0
    jle     short loc_271C6
    mov     cl, 4
    mov     ax, [bp+var_8]
    shr     ax, cl
    sub     [bp+var_8], ax
loc_271C6:
    mov     ax, [bp+arg_2]
    mov     bx, [bp+var_2]
    add     bx, 1Ch
    mov     [bp+var_10], bx
    mov     [bp+var_E], ds
    les     bx, [bx+8]
    mov     cl, es:[bx+0Eh]
    sub     ch, ch
    sub     dx, dx
    div     cx
    mov     cl, 4
    mov     dl, es:[bx+0Fh]
    sub     dh, dh
    shl     dx, cl
    add     ax, dx
    mov     [bp+var_14], ax
    mov     ax, 1770h
    sub     ax, [bp+var_16]
    mov     [bp+var_6], ax
    or      ax, ax
    jz      short loc_27213
    mov     ax, 1770h
    mul     [bp+var_14]
    div     [bp+var_6]
    mov     [bp+var_6], ax
    mov     ax, [bp+var_6]
    mov     bx, [bp+var_2]
    mov     [bx+0Ch], ax
loc_27213:
    mov     al, byte ptr [bp+var_8]
    mov     bx, [bp+var_2]
    mov     [bx+0Ah], al
    mov     sp, bp
    pop     bp
    retf
audio_op_unk2 endp
nopsub_27220 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    add     bx, 6364h
    mov     ax, [bx+4]
loc_27233:
    mov     cl, 4
    shr     ax, cl
    push    ax
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    push    word ptr [bx+2Eh]
    push    word ptr [bx+2Ch]
    mov     si, bx
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+14h], ax
    push    ax
    mov     ax, 33BCh
    push    ax
    call    nopsub_3219D
    pop     bx
    pop     bx
    mov     al, 1
    mov     [si+1Ah], al
    mov     [si+1Bh], al
    pop     si
    mov     sp, bp
    pop     bp
    retf
nopsub_27220 endp
nopsub_2726C proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    add     bx, 6364h
    mov     ax, [bx+4]
    mov     cl, 4
    shr     ax, cl
    push    ax
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    push    word ptr [bx+32h]
    push    word ptr [bx+30h]
    mov     si, bx
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+14h], ax
    mov     byte ptr [si+1Ah], 1
    push    [bp+arg_0]
    push    cs
    call near ptr audio_function2
    pop     bx
    pop     si
    mov     sp, bp
    pop     bp
    retf
nopsub_2726C endp
nopsub_272B0 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    add     bx, 6364h
    mov     ax, [bx+4]
    mov     cl, 4
    shr     ax, cl
    push    ax
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    push    word ptr [bx+36h]
    push    word ptr [bx+34h]
    mov     si, bx
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+14h], ax
    mov     byte ptr [si+1Ah], 1
    push    [bp+arg_0]
    push    cs
    call near ptr audio_function2
    pop     bx
    pop     si
    mov     sp, bp
    pop     bp
    retf
nopsub_272B0 endp
audio_function2_wrap proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    add     bx, offset audiotimers
    mov     ax, [bx+4]
    mov     cl, 4
    shr     ax, cl
    push    ax
    mov     ax, 64h ; 'd'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    push    word ptr [bx+3Ah]
    push    word ptr [bx+38h]
    mov     si, bx
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+14h], ax
    mov     byte ptr [si+1Ah], 1
    push    [bp+arg_0]
    push    cs
    call near ptr audio_function2
    pop     bx
    pop     si
    mov     sp, bp
    pop     bp
    retf
audio_function2_wrap endp
audio_op_unk3 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    add     bx, offset audiotimers
    mov     ax, [bx+4]
    mov     cl, 4
    shr     ax, cl
    push    ax
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    push    word ptr [bx+46h]
    push    word ptr [bx+44h]
    mov     si, bx
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+14h], ax
    mov     byte ptr [si+1Ah], 1
    pop     si
    mov     sp, bp
    pop     bp
    retf
audio_op_unk3 endp
audio_op_unk4 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    add     bx, offset audiotimers
    mov     ax, [bx+4]
    mov     cl, 4
    shr     ax, cl
    push    ax
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    push    word ptr [bx+4Ah]
    push    word ptr [bx+48h]
    mov     si, bx
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+14h], ax
    mov     byte ptr [si+1Ah], 1
    pop     si
    mov     sp, bp
    pop     bp
    retf
audio_op_unk4 endp
audio_op_unk5 proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     si, ax
    add     si, offset audiotimers
    lea     ax, [si+1Ch]
    mov     di, ax
    mov     [bp+var_2], ds
    cmp     word ptr [si+16h], 0FFFFh
    jz      short loc_273DB
    push    word ptr [si+16h]
    call    audio_init_chunk2
    pop     bx
loc_273DB:
    mov     cl, 4
    mov     ax, [si+4]
    shr     ax, cl
    push    ax
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    mov     es, [bp+var_2]
    push    word ptr es:[di+22h]
    push    word ptr es:[di+20h]
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+16h], ax
    mov     byte ptr [si+1Ah], 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_op_unk5 endp
audio_op_unk6 proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     si, ax
    add     si, offset audiotimers
    lea     ax, [si+1Ch]
    mov     di, ax
    mov     [bp+var_2], ds
    cmp     word ptr [si+16h], 0FFFFh
    jz      short loc_27436
    push    word ptr [si+16h]
    call    audio_init_chunk2
    pop     bx
loc_27436:
    mov     cl, 4
    mov     ax, [si+4]
    shr     ax, cl
    push    ax
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    mov     es, [bp+var_2]
    push    word ptr es:[di+26h]
    push    word ptr es:[di+24h]
    call    audio_check_flag
    add     sp, 0Ah
    mov     [si+16h], ax
    mov     byte ptr [si+1Ah], 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_op_unk6 endp
audio_op_unk7 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    push    word ptr (audiotimers+16h)[bx]
    mov     si, ax
    call    audio_init_chunk2
    pop     bx
    mov     word ptr (audiotimers+16h)[si], 0FFFFh
    pop     si
    mov     sp, bp
    pop     bp
    retf
audio_op_unk7 endp
nopsub_27489 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    mov     si, [bx+6378h]
    cmp     si, 0FFFFh
    jle     short loc_274A7
    push    si
    call    sub_3771E
    pop     bx
    jmp     short loc_274AA
loc_274A7:
    mov     ax, 1
loc_274AA:
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
nopsub_27489 endp
seg007 ends
end
