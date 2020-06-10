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
seg027 segment byte public 'STUNTSC' use16
    assume cs:seg027
    assume es:nothing, ss:nothing, ds:dseg
    public init_audio_resources
    public load_audio_finalize
    public audio_unk
    public sub_372F4
    public sub_3736A
    public audio_enable_flag2
    public audio_disable_flag2
    public audio_toggle_flag2
    public nopsub_373FE
    public nopsub_37456
    public sub_37470
    public sub_374DE
    public audio_check_flag2
    public audio_check_flag
    public audio_init_chunk2
    public audio_enable_flag6
    public audio_disable_flag6
    public audio_toggle_flag6
    public sub_3771E
    public nopsub_37750
    public audio_driver_func3F
    public sub_37868
    public nopsub_37898
    public nopsub_378AE
    public nopsub_378BC
    public audio_load_driver
    public audiodrv_atexit
    public load_sfx_ge
    public sub_37C38
    public load_sfx_file
    public load_song_file
    public load_voice_file
    public nopsub_37D7A
    public audio_init_chunk
    public audio_map_song_instruments
    public sub_3803C
    public sub_38156
    public sub_38178
    public audio_map_song_tracks
    public off_383A0
    public audioresource_get_dword
    public audioresource_get_word
    public audioresource_copy_4_bytes
init_audio_resources proc far
    var_titlptr = dword ptr -12
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_hdrptr = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_songfileptr = dword ptr 6
    arg_vcefileptr = dword ptr 10
    arg_8 = word ptr 14

    push    bp
loc_370D3:
    mov     bp, sp
loc_370D5:
    sub     sp, 0Ch
loc_370D8:
    push    [bp+arg_8]      ; arg_8 is a string, e.g "TITL"
loc_370DB:
    push    word ptr [bp+arg_songfileptr+2]
loc_370DE:
    push    word ptr [bp+arg_songfileptr]
    call    audioresource_find; audio_find_resource?
    add     sp, 6
    mov     word ptr [bp+var_titlptr], ax
    mov     word ptr [bp+var_titlptr+2], dx
loc_370EF:
    or      dx, ax
    jnz     short loc_370FA
loc_370F3:
    sub     ax, ax
    cwd
    mov     sp, bp
    pop     bp
    retf
loc_370FA:
    mov     ax, offset aHdr1; "hdr1"
    push    ax
    push    word ptr [bp+var_titlptr+2]
    push    word ptr [bp+var_titlptr]
    call    audioresource_find; audio_find_resource? look up "hdr1" in the "TITL" chunk?
    add     sp, 6
    mov     word ptr [bp+var_hdrptr], ax
    mov     word ptr [bp+var_hdrptr+2], dx
    or      ax, dx
    jz      short loc_370F3
    les     bx, [bp+var_hdrptr]
loc_37119:
    cmp     byte ptr es:[bx+5], 1; check header+5 if we already loaded this
    jz      short loc_37172
    push    word ptr [bp+arg_vcefileptr+2]
loc_37123:
    push    word ptr [bp+arg_vcefileptr]
    push    word ptr [bp+var_titlptr+2]
    push    word ptr [bp+var_titlptr]
loc_3712C:
    push    cs
    call near ptr audio_map_song_instruments
    add     sp, 8
loc_37133:
    push    word ptr [bp+var_titlptr+2]
    push    word ptr [bp+var_titlptr]
    push    cs
loc_3713A:
    call near ptr audio_map_song_tracks
    add     sp, 4
    les     bx, [bp+var_hdrptr]
    mov     byte ptr es:[bx+5], 1; set header+5 to 1, = loaded
    les     bx, [bp+var_titlptr]
    mov     al, es:[bx+4]
    sub     ah, ah
    mov     cl, 3
    shl     ax, cl
    add     ax, bx
    mov     dx, es
    inc     ax
    mov     [bp+var_8], ax
    mov     [bp+var_6], dx
    lea     ax, [bp+var_8]
    push    ss
    push    ax
    push    word ptr [bp+var_hdrptr+2]
    push    word ptr [bp+var_hdrptr]
    push    cs
    call near ptr audioresource_copy_4_bytes
    add     sp, 8
loc_37172:
    mov     ax, word ptr [bp+var_hdrptr]
    mov     dx, word ptr [bp+var_hdrptr+2]
    mov     sp, bp
    pop     bp
    retf
init_audio_resources endp
load_audio_finalize proc far
    var_6 = dword ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_Mnote = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    si
    mov     word_4063A, 1
    push    cs
    call near ptr sub_3736A
    mov     ax, word ptr [bp+arg_Mnote]
    or      ax, word ptr [bp+arg_Mnote+2]
    jz      short loc_3720F
    les     bx, [bp+arg_Mnote]
    cmp     byte ptr es:[bx+4], 0
    jnz     short loc_3720F
    cmp     byte ptr es:[bx+5], 1
    jnz     short loc_3720F
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 18h
    mov     word ptr [bp+var_6+2], dx
    mov     word ptr [bp+var_6], ax
    call    [bp+var_6]
    mov     word_44D48, 0
    mov     word_454BA, 80h ; '€'
    les     bx, [bp+arg_Mnote]
    mov     al, es:[bx+6]
    sub     ah, ah
    shl     ax, 1
    shl     ax, 1
    add     ax, 7
    mov     [bp+var_2], ax
    mov     bx, ax
    inc     [bp+var_2]
    mov     si, word ptr [bp+arg_Mnote]
    mov     al, es:[bx+si]
    mov     byte_44290, al
    mov     ax, 20h ; ' '
    push    ax
    mov     al, byte_45950
    sub     ah, ah
    push    ax
    push    [bp+var_2]
    push    es
    push    si
    mov     al, byte_44290
    dec     ax
    push    ax
    sub     ax, ax
    push    ax
    push    cs
    call near ptr audio_init_chunk
    add     sp, 0Eh
    mov     byte_40632, 1
    mov     word_4063A, 0
loc_3720F:
    pop     si
    mov     sp, bp
    pop     bp
    retf
    db 144
    db 144
load_audio_finalize endp
audio_unk proc far
    var_C = word ptr -12
    var_A = dword ptr -10
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    di
    push    si
    mov     byte_40630, 1
    mov     word_4063A, 1
    cmp     byte_40634, 0
    jnz     short loc_37262
    sub     si, si
    mov     di, 8224h
loc_37235:
    cmp     audioflag6, 1
    jz      short loc_37241
    cmp     si, 10h
    jge     short loc_37253
loc_37241:
    mov     al, [di]
    mov     byte_428BE[si], al
loc_37247:
    sub     ax, ax
    push    ax
    push    si
    call    audio_unk2
    add     sp, 4
loc_37253:
    add     di, 4Ch ; 'L'
    inc     si
    cmp     si, 18h
    jl      short loc_37235
    mov     [bp+var_2], si
    jmp     short loc_37286
    ; align 2
    db 144
loc_37262:
    mov     byte_40639, 0
    mov     ax, offset unk_40636
    push    ds
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 3Fh ; '?'
    mov     word ptr [bp+var_A+2], dx
    mov     word ptr [bp+var_A], ax
    call    [bp+var_A]
    add     sp, 6
loc_37286:
    cmp     byte_40634, 0
    jnz     short loc_372E7
    mov     [bp+var_2], 10h
    mov     di, 0A2B6h
    mov     [bp+var_C], 10h
loc_3729A:
    mov     si, di
    push    word ptr [si+12h]
    push    word ptr [si+10h]
    push    word ptr [si+2Ah]
    push    si
    mov     al, [si+2Ch]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 27h ; '''
    mov     word ptr [bp+var_A+2], dx
    mov     word ptr [bp+var_A], ax
    call    [bp+var_A]
    add     sp, 0Ah
    add     di, 2Eh ; '.'
    dec     [bp+var_C]
    jnz     short loc_3729A
    mov     [bp+var_4], si
    mov     ax, 0A2B6h
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 30h ; '0'
    mov     word ptr [bp+var_A+2], dx
    mov     word ptr [bp+var_A], ax
    call    [bp+var_A]
    add     sp, 2
loc_372E7:
    mov     word_4063A, 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audio_unk endp
sub_372F4 proc far
    var_6 = dword ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    si
    mov     byte_40630, 1
    mov     word_4063A, 1
    cmp     byte_40634, 0
    jnz     short loc_37336
    sub     si, si
loc_3730F:
    cmp     audioflag6, 1
    jz      short loc_3731B
    cmp     si, 10h
    jge     short loc_3732B
loc_3731B:
    mov     al, byte_428BE[si]
    sub     ah, ah
    push    ax
    push    si
    call    audio_unk2
    add     sp, 4
loc_3732B:
    inc     si
    cmp     si, 18h
    jl      short loc_3730F
    mov     [bp+var_2], si
    jmp     short loc_3735A
loc_37336:
    mov     byte_40639, 64h ; 'd'
    mov     ax, offset unk_40636
    push    ds
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 3Fh ; '?'
    mov     word ptr [bp+var_6+2], dx
    mov     word ptr [bp+var_6], ax
    call    [bp+var_6]
    add     sp, 6
loc_3735A:
    mov     word_4063A, 0
    mov     byte_40630, 0
    pop     si
    mov     sp, bp
    pop     bp
    retf
sub_372F4 endp
sub_3736A proc far

    mov     word_4063A, 1
    mov     byte_40632, 0
    mov     ax, 0Fh
    push    ax
    sub     ax, ax
    push    ax
    call    audio_driver_func1E
    add     sp, 4
    sub     ax, ax
    push    ax
    mov     al, byte_45950
    sub     ah, ah
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    mov     ax, 0Fh
    push    ax
    sub     ax, ax
    push    ax
    push    cs
    call near ptr audio_init_chunk
    add     sp, 0Eh
    mov     byte_44290, 0
    call    sub_39700
    mov     word_4063A, 0
    retf
    ; align 2
    db 144
sub_3736A endp
audio_enable_flag2 proc far

    mov     audioflag2, 1
    retf
audio_enable_flag2 endp
audio_disable_flag2 proc far

    mov     audioflag2, 0
    mov     word_4063A, 1
    cmp     byte_44290, 0
    jz      short loc_373DC
    mov     al, byte_44290
    sub     ah, ah
    dec     ax
    push    ax
    sub     ax, ax
    push    ax
    call    audio_driver_func1E
    add     sp, 4
loc_373DC:
    call    sub_39700
    mov     word_4063A, 0
    retf
audio_disable_flag2 endp
audio_toggle_flag2 proc far

    cmp     audioflag2, 1
    jnz     short loc_373F6
    push    cs
    call near ptr audio_disable_flag2
    sub     ax, ax
    retf
loc_373F6:
    push    cs
    call near ptr audio_enable_flag2
    mov     ax, 1
    retf
audio_toggle_flag2 endp
nopsub_373FE proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    cmp     byte_40630, 1
    jz      short loc_37414
    cmp     audioflag2, 0
    jnz     short loc_3741E
loc_37414:
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_3741E:
    mov     [bp+var_2], 0
    mov     al, byte_44290
    sub     ah, ah
    or      ax, ax
    jz      short loc_37414
    mov     di, ax
    mov     si, 81FCh
    mov     cx, [bp+var_2]
loc_37434:
    mov     ax, [si]
    or      ax, [si+2]
    jz      short loc_37446
    sub     ax, ax
    mov     [bp+var_2], cx
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_37446:
    add     si, 4Ch ; 'L'
    inc     cx
    mov     ax, cx
    cmp     ax, di
    jb      short loc_37434
    mov     [bp+var_2], cx
    jmp     short loc_37414
    ; align 2
    db 144
nopsub_373FE endp
nopsub_37456 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    push    [bp+arg_2]
    push    [bp+arg_0]
    push    cs
    call near ptr audio_check_flag2
    add     sp, 8
    pop     bp
    retf
nopsub_37456 endp
sub_37470 proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = byte ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    cmp     [bp+arg_0], 0FFFFh
    jnz     short loc_374CE
    mov     si, 10h
    mov     di, 86BCh
    mov     cx, [bp+arg_0]
loc_37487:
    cmp     cx, 0FFFFh
    jnz     short loc_374A5
    mov     ax, [di]
    or      ax, [di+2]
    jnz     short loc_3749C
    cmp     byte_45D9A[si], 0
    jnz     short loc_3749C
loc_3749A:
    mov     cx, si
loc_3749C:
    add     di, 4Ch ; 'L'
    inc     si
    cmp     si, 17h
    jle     short loc_37487
loc_374A5:
    mov     [bp+var_2], si
    mov     [bp+arg_0], cx
    cmp     cx, 0FFFFh
    jz      short loc_374C5
    mov     bx, cx
    mov     byte_45D9A[bx], 1
    mov     ax, 4Ch ; 'L'
    imul    cx
loc_374BC:
    mov     bx, ax
    mov     al, [bp+arg_2]
    mov     (audiochunks_unk+24h)[bx], al
loc_374C5:
    mov     ax, [bp+arg_0]
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_374CE:
    mov     bx, [bp+arg_0]
    mov     byte_45D9A[bx], 1
    mov     ax, 4Ch ; 'L'
    imul    bx
    jmp     short loc_374BC
    ; align 2
    db 144
sub_37470 endp
sub_374DE proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    cmp     [bp+arg_0], 0FFFFh
    jle     short loc_374F7
    mov     bx, [bp+arg_0]
    mov     byte_45D9A[bx], 0
    push    bx
    push    cs
    call near ptr audio_init_chunk2
    add     sp, 2
loc_374F7:
    pop     bp
    retf
    ; align 2
    db 144
sub_374DE endp
audio_check_flag2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = byte ptr 12

    push    bp
    mov     bp, sp
    mov     al, byte_45948
    sub     ah, ah
    push    ax
    mov     al, [bp+arg_6]
    push    ax
    push    [bp+arg_4]
    push    [bp+arg_2]
    push    [bp+arg_0]
    push    cs
    call near ptr audio_check_flag
    add     sp, 0Ah
    pop     bp
    retf
    ; align 2
    db 144
audio_check_flag2 endp
audio_check_flag proc far
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = byte ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    di
    push    si
    cmp     audioflag6, 0
    jnz     short loc_37532
loc_37529:
    mov     ax, 0FFFFh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_37532:
    mov     ax, word ptr [bp+arg_0]
    or      ax, word ptr [bp+arg_0+2]
    jz      short loc_37529
    les     bx, [bp+arg_0]
    cmp     byte ptr es:[bx+5], 1
loc_37542:
    jnz     short loc_37529
    cmp     byte_45948, 0
    jz      short loc_37568
    mov     al, byte_45948
    sub     ah, ah
    mov     cx, ax
    mov     ax, [bp+arg_8]
    mov     dx, cx
    mov     cl, 7
    shl     ax, cl
    mov     cx, dx
    sub     dx, dx
    div     cx
    dec     ax
    mov     [bp+arg_8], ax
    jmp     short loc_3756D
    ; align 2
    db 144
loc_37568:
    mov     [bp+arg_8], 0
loc_3756D:
    cmp     [bp+arg_4], 0FFFFh
    jz      short loc_37576
    jmp     loc_37609
loc_37576:
    mov     si, 10h
    mov     di, offset audiochunks_unk2
    mov     cx, [bp+arg_4]
loc_3757F:
    cmp     cx, 0FFFFh
    jnz     short loc_3759D
    mov     ax, [di]
    or      ax, [di+2]
    jnz     short loc_37594
    cmp     byte_45D9A[si], 0
    jnz     short loc_37594
    mov     cx, si
loc_37594:
    add     di, 4Ch ; 'L'
    inc     si
loc_37598:
    cmp     si, 17h
    jle     short loc_3757F
loc_3759D:
    mov     [bp+var_4], si
    mov     [bp+arg_4], cx
    cmp     cx, 0FFFFh
    jnz     short loc_37609
    mov     cx, 0FFh
    mov     di, 10h
    mov     si, 86E0h
    mov     dx, [bp+arg_4]
loc_375B4:
    mov     al, [si]
    sub     ah, ah
    cmp     ax, cx
    ja      short loc_375CB
    mov     ax, offset byte_45D9A
    or      ax, ax
    jnz     short loc_375CB
    mov     al, [si]
    sub     ah, ah
    mov     cx, ax
    mov     dx, di
loc_375CB:
    add     si, 4Ch ; 'L'
    inc     di
    cmp     di, 17h
    jl      short loc_375B4
    mov     [bp+var_4], di
    mov     [bp+arg_4], dx
    mov     [bp+var_6], cx
    cmp     dx, 0FFFFh
    jz      short loc_37609
    mov     ax, 4Ch ; 'L'
    imul    dx
    mov     bx, ax
    mov     al, [bp+arg_6]
    cmp     (audiochunks_unk+24h)[bx], al
    ja      short loc_37609
    mov     bx, [bp+arg_4]
    cmp     byte_45D9A[bx], 0
    jz      short loc_37601
    mov     byte_45D9A[bx], 0
loc_37601:
    push    bx
    push    cs
    call near ptr audio_init_chunk2
    add     sp, 2
loc_37609:
    cmp     [bp+arg_4], 0FFFFh
    jnz     short loc_37612
    jmp     loc_37529
loc_37612:
    les     bx, [bp+arg_0]
    mov     al, es:[bx+6]
    sub     ah, ah
    shl     ax, 1
    shl     ax, 1
    add     ax, 8
    mov     [bp+var_2], ax
    mov     al, [bp+arg_6]
    sub     ah, ah
    push    ax
    push    [bp+arg_8]
    push    [bp+var_2]
    push    es
    push    bx
    push    [bp+arg_4]
    push    [bp+arg_4]
    push    cs
    call near ptr audio_init_chunk
    add     sp, 0Eh
    mov     ax, [bp+arg_4]
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audio_check_flag endp
audio_init_chunk2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    cmp     [bp+arg_0], 10h
    jl      short loc_37694
    cmp     [bp+arg_0], 17h
    jg      short loc_37694
    mov     ax, 4Ch ; 'L'
loc_3765C:
    imul    [bp+arg_0]
    mov     bx, ax
    sub     ax, ax
    mov     word ptr (audiochunks_unk+2)[bx], ax
    mov     word ptr audiochunks_unk[bx], ax
    push    [bp+arg_0]
    push    [bp+arg_0]
    call    audio_driver_func1E
    add     sp, 4
    sub     ax, ax
    push    ax
    mov     al, byte_45948
    sub     ah, ah
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    push    [bp+arg_0]
    push    [bp+arg_0]
    push    cs
    call near ptr audio_init_chunk
    add     sp, 0Eh
loc_37694:
    pop     bp
    retf
audio_init_chunk2 endp
audio_enable_flag6 proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    cmp     audioflag6, 1
    jz      short loc_376C5
    mov     si, 10h
loc_376A7:
    mov     al, byte_428D6[si]
    sub     ah, ah
    push    ax
    push    si
    call    audio_unk2
    add     sp, 4
    inc     si
    cmp     si, 18h
    jl      short loc_376A7
    mov     [bp+var_2], si
    mov     audioflag6, 1
loc_376C5:
    pop     si
    mov     sp, bp
    pop     bp
    retf
audio_enable_flag6 endp
audio_disable_flag6 proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
loc_376D2:
    cmp     audioflag6, 0
    jz      short loc_37702
    mov     si, 10h
    mov     di, (offset audiochunks_unk2+28h)
loc_376DF:
    mov     al, [di]
    mov     byte_428D6[si], al
    sub     ax, ax
    push    ax
    push    si
    call    audio_unk2
    add     sp, 4
    add     di, 4Ch ; 'L'
    inc     si
    cmp     si, 18h
    jl      short loc_376DF
    mov     [bp+var_2], si
    mov     audioflag6, 0
loc_37702:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_disable_flag6 endp
audio_toggle_flag6 proc far

    cmp     audioflag6, 1
    jnz     short loc_37716
    push    cs
    call near ptr audio_disable_flag6
    sub     ax, ax
    retf
loc_37716:
    push    cs
    call near ptr audio_enable_flag6
    mov     ax, 1
    retf
audio_toggle_flag6 endp
sub_3771E proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    cmp     audioflag6, 0
    jnz     short loc_3772E
loc_37728:
    mov     ax, 1
    pop     bp
    retf
    ; align 2
    db 144
loc_3772E:
    cmp     [bp+arg_0], 10h
    jl      short loc_37728
    cmp     [bp+arg_0], 17h
    jg      short loc_37728
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    mov     ax, word ptr audiochunks_unk[bx]
    or      ax, word ptr (audiochunks_unk+2)[bx]
    jz      short loc_37728
    sub     ax, ax
    pop     bp
    retf
sub_3771E endp
nopsub_37750 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     ax, 4Ch ; 'L'
    mul     [bp+arg_0]
    mov     bx, ax
    mov     ax, [bp+arg_2]
    mov     dx, [bp+arg_4]
loc_37761:
    mov     word ptr (audiochunks_unk+48h)[bx], ax
    mov     word ptr (audiochunks_unk+4Ah)[bx], dx
    pop     bp
    retf
    ; align 2
    db 144
nopsub_37750 endp
audio_driver_func3F proc far
    var_A = dword ptr -10
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    si
    cmp     byte_40634, 0
    jnz     short loc_377C6
    mov     al, byte_45950
    sub     ah, ah
    mov     [bp+var_2], ax
    or      ax, ax
    jg      short loc_37789
    jmp     loc_37820
loc_37789:
    mov     ax, [bp+arg_0]
    cwd
    mov     [bp+var_6], ax
    mov     [bp+var_4], dx
    mov     si, [bp+var_2]
loc_37796:
    mov     word_4063A, 1
    push    si
    push    cs
    call near ptr sub_37868
    add     sp, 2
    mov     word_4063A, 0
    push    [bp+var_4]
    push    [bp+var_6]
    call    timer_copy_counter; Stores a copy of the timer counter with the given ticks added.
    add     sp, 4
    call    timer_wait_for_dx
    sub     si, 2
    or      si, si
    jg      short loc_37796
    jmp     short loc_3781D
loc_377C6:
    mov     si, 64h ; 'd'
    mov     ax, [bp+arg_0]
    cwd
    mov     [bp+var_6], ax
    mov     [bp+var_4], dx
loc_377D3:
    mov     word_4063A, 1
    mov     ax, si
    mov     byte_40639, al
    mov     ax, offset unk_40636
    push    ds
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 3Fh ; '?'
    mov     word ptr [bp+var_A+2], dx
    mov     word ptr [bp+var_A], ax
    call    [bp+var_A]
    add     sp, 6
    mov     word_4063A, 0
    push    [bp+var_4]
    push    [bp+var_6]
    call    timer_copy_counter; Stores a copy of the timer counter with the given ticks added.
    add     sp, 4
    call    timer_wait_for_dx
    sub     si, 2
    or      si, si
    jg      short loc_377D3
loc_3781D:
    mov     [bp+var_2], si
loc_37820:
    push    cs
    call near ptr sub_3736A
    cmp     byte_40634, 0
    jz      short loc_37862
    mov     ax, 32h ; '2'
    cwd
    push    dx
    push    ax
    call    timer_copy_counter; Stores a copy of the timer counter with the given ticks added.
    add     sp, 4
    call    timer_wait_for_dx
    mov     byte_40639, 64h ; 'd'
    mov     ax, offset unk_40636
    push    ds
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 3Fh ; '?'
    mov     word ptr [bp+var_A+2], dx
    mov     word ptr [bp+var_A], ax
    call    [bp+var_A]
    add     sp, 6
loc_37862:
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audio_driver_func3F endp
sub_37868 proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    sub     si, si
    mov     di, [bp+arg_0]
    jmp     short loc_37883
    ; align 2
    db 144
loc_37878:
    push    di
    push    si
    call    audio_unk2
    add     sp, 4
    inc     si
loc_37883:
    mov     ax, si
    mov     cl, byte_44290
    sub     ch, ch
    cmp     ax, cx
    jb      short loc_37878
    mov     [bp+var_2], si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_37868 endp
nopsub_37898 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     al, byte ptr [bp+arg_0]
    mov     byte_45950, al
    push    [bp+arg_0]
    push    cs
    call near ptr sub_37868
    add     sp, 2
    pop     bp
    retf
    ; align 2
    db 144
nopsub_37898 endp
nopsub_378AE proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    mov     al, byte_44D06[bx]
    sub     ah, ah
    pop     bp
    retf
nopsub_378AE endp
nopsub_378BC proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    mov     al, byte_44ACA[bx]
    sub     ah, ah
    pop     bp
    retf
nopsub_378BC endp
audio_load_driver proc far
    var_C = dword ptr -12
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    di
    push    si
    cmp     [bp+arg_4], 473Ah
    jnz     short loc_378DE
    mov     byte_40635, 1
loc_378DE:
    mov     ax, word ptr audiodriverbinary
    or      ax, word ptr audiodriverbinary+2
    jz      short loc_378EE
    push    cs
    call near ptr audiodrv_atexit
    jmp     short loc_378FE
    ; align 2
    db 144
loc_378EE:
    mov     ax, offset audiodrv_atexit
    mov     dx, seg seg027
    push    dx
    push    ax
    call    add_exit_handler
    add     sp, 4
loc_378FE:
    sub     ax, ax
    mov     word ptr audiodriverbinary+2, ax
    mov     word ptr audiodriverbinary, ax
    push    ds
    pop     es
    mov     di, word ptr [bp+arg_0]
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
    dec     cx
    mov     [bp+var_8], cx
    or      cx, cx
    jz      short loc_37932
    mov     dx, word ptr [bp+arg_0]
loc_3791F:
    mov     bx, cx
    mov     si, dx
    cmp     byte ptr [bx+si], 5Ch ; '\'
    jz      short loc_3792F
    cmp     byte ptr [bx+si], 3Ah ; ':'
    jz      short loc_3792F
    loop    loc_3791F
loc_3792F:
    mov     [bp+var_8], cx
loc_37932:
    cmp     [bp+var_8], 0
    jz      short loc_3793B
    inc     [bp+var_8]
loc_3793B:
    mov     si, [bp+var_8]
    add     si, word ptr [bp+arg_0]
    mov     al, [si]
    mov     audiodriverstring2, al
    mov     al, [si+1]
    mov     audiodriverstring2+1, al
    mov     audiodriverstring2+2, 0
    mov     ax, offset unk_4063E
    push    ax              ; int
    mov     ax, offset aDrv ; "drv"
    push    ax
    push    word ptr [bp+arg_0]; char *
    call    audio_make_filename
    add     sp, 6
    mov     [bp+var_6], ax
    push    ax
    call    file_load_binary_nofatal
    add     sp, 2
    mov     word ptr audiodriverbinary, ax
    mov     word ptr audiodriverbinary+2, dx
    mov     byte_45950, 7Fh ; ''
    mov     byte_45948, 7Fh ; ''
    or      ax, dx
    jnz     short loc_37988
    jmp     loc_37A52
loc_37988:
    call    audiodriverbinary
    mov     byte_459D2, al
    or      al, al
    jz      short loc_37997
    cmp     al, 0FFh
    jnz     short loc_379A2
loc_37997:
    mov     ax, 2
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    db 144
    db 144
loc_379A2:
    cmp     byte_459D2, 7Fh ; ''
    jbe     short loc_379B8
    mov     byte_459D2, 10h
    mov     byte_40634, 1
    mov     byte_40635, 0
loc_379B8:
    push    cs
    call near ptr sub_38178
    mov     ax, offset audiodriver_timer
    mov     dx, seg seg028
    push    dx
    push    ax
    call    timer_reg_callback
    add     sp, 4
    cmp     byte_40634, 0
    jz      short loc_37A35
    mov     ax, offset aMt32_plb; "mt32.plb"
    push    ax
    call    file_load_binary_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jz      short loc_37A35
    push    dx
    push    [bp+var_4]
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 42h ; 'B'
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 4
    push    [bp+var_2]
    push    [bp+var_4]
    call    mmgr_release
    add     sp, 4
    mov     byte_40639, 64h ; 'd'
    mov     ax, offset unk_40636
    push    ds
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 3Fh ; '?'
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 6
loc_37A35:
    mov     byte_40630, 0
    mov     audioflag2, 1
    mov     byte_40632, 0
    mov     audioflag6, 1
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_37A52:
    mov     ax, offset aCanTFindDriver; "Can't find driver!\n"
    push    ax
    call    far ptr fatal_error
    add     sp, 2
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_load_driver endp
audiodrv_atexit proc far
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    mov     word_4063A, 1
    mov     ax, word ptr audiodriverbinary
    or      ax, word ptr audiodriverbinary+2
    jnz     short loc_37A7C
    jmp     loc_37B09
loc_37A7C:
    mov     ax, 0Ch
    mov     dx, seg seg028
    push    dx
    push    ax
    call    timer_remove_callback
    add     sp, 4
    mov     audioflag2, 0
    mov     audioflag6, 0
    cmp     byte_40634, 0
    jz      short loc_37AC1
    mov     byte_40639, 64h ; 'd'
    mov     ax, 4EC6h
    push    ds
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 3Fh ; '?'
    mov     word ptr [bp+var_4+2], dx
    mov     word ptr [bp+var_4], ax
    call    [bp+var_4]
    add     sp, 6
loc_37AC1:
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 6
    mov     word ptr [bp+var_4+2], dx
    mov     word ptr [bp+var_4], ax
    call    [bp+var_4]
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 3
    mov     word ptr [bp+var_4+2], dx
    mov     word ptr [bp+var_4], ax
    call    [bp+var_4]
    push    word ptr audiodriverbinary+2
    push    word ptr audiodriverbinary
    call    mmgr_release
    add     sp, 4
    sub     ax, ax
    mov     word ptr audiodriverbinary+2, ax
    mov     word ptr audiodriverbinary, ax
    mov     byte_40634, 0
    mov     byte_40635, 0
loc_37B09:
    mov     word_4063A, 0
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audiodrv_atexit endp
load_sfx_ge proc far
    var_8 = byte ptr -8
    var_7 = byte ptr -7
    var_6 = byte ptr -6
    var_5 = byte ptr -5
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
    push    [bp+arg_4]      ; int
    push    [bp+arg_2]
    push    [bp+arg_0]      ; char *
    call    audio_make_filename
    add     sp, 6
    push    ax
    call    file_load_binary_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jz      short loc_37B48
loc_37B3E:
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
loc_37B46:
    pop     bp
    retf
loc_37B48:
    mov     [bp+var_8], 50h ; 'P'
loc_37B4C:
    mov     bx, [bp+arg_2]
    mov     al, [bx]
    mov     [bp+var_7], al
    mov     al, [bx+1]
    mov     [bp+var_6], al
    mov     [bp+var_5], 0
    push    [bp+arg_4]      ; int
    lea     ax, [bp+var_8]
    push    ax
    push    [bp+arg_0]      ; char *
    call    audio_make_filename
    add     sp, 6
    push    ax
    call    file_decomp_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jnz     short loc_37B3E
    mov     ax, offset aGe  ; "ge"
    push    ax              ; int
    push    [bp+arg_2]
    push    [bp+arg_0]      ; char *
    call    audio_make_filename
    add     sp, 6
    push    ax
    call    file_load_binary_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jnz     short loc_37B3E
    mov     ax, offset aGe_0; "ge"
    push    ax              ; int
    lea     ax, [bp+var_8]
    push    ax
    push    [bp+arg_0]      ; char *
    call    audio_make_filename
    add     sp, 6
    push    ax
    call    file_decomp_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jz      short loc_37BD1
    jmp     loc_37B3E
loc_37BD1:
    mov     ax, offset aBlankstr
    push    ax              ; int
    push    [bp+arg_2]
    push    [bp+arg_0]      ; char *
    call    audio_make_filename
    add     sp, 6
    push    ax
    call    file_load_binary_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jz      short loc_37BF9
    jmp     loc_37B3E
loc_37BF9:
    mov     ax, offset aBlankstr2
    push    ax              ; int
    lea     ax, [bp+var_8]
    push    ax
    push    [bp+arg_0]      ; char *
    call    audio_make_filename
    add     sp, 6
    push    ax
    call    file_decomp_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jz      short loc_37C22
    jmp     loc_37B3E
loc_37C22:
    push    [bp+arg_0]
    call    file_load_binary_nofatal
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jmp     loc_37B3E
load_sfx_ge endp
sub_37C38 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     word_4063C, ax
    pop     bp
    retf
    ; align 2
    db 144
sub_37C38 endp
load_sfx_file proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    sub     ax, ax
    mov     [bp+var_2], ax
    mov     [bp+var_4], ax
    cmp     byte_40635, 0
    jz      short loc_37C71
    mov     ax, offset audiodriverstring2
    push    ax              ; int
    mov     ax, offset aDsf ; "dsf"
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr load_sfx_ge
    add     sp, 6
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_37C71:
    mov     ax, [bp+var_4]
    or      ax, [bp+var_2]
    jnz     short loc_37C91
    mov     ax, offset audiodriverstring2
    push    ax              ; int
    mov     ax, offset aSfx ; "sfx"
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr load_sfx_ge
    add     sp, 6
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_37C91:
    mov     ax, [bp+var_4]
    or      ax, [bp+var_2]
    jnz     short loc_37CAF
    cmp     word_4063C, 0
    jz      short loc_37CAF
    push    word ptr [bp+arg_0]
    mov     ax, offset aCannotLoadSfxFileS; "cannot load sfx file %s"
    push    ax
    call    far ptr fatal_error
    add     sp, 4
loc_37CAF:
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
load_sfx_file endp
load_song_file proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    sub     ax, ax
    mov     [bp+var_2], ax
    mov     [bp+var_4], ax
    mov     ax, offset audiodriverstring2
    push    ax              ; int
    mov     ax, offset aKms ; "kms"
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr load_sfx_ge
    add     sp, 6
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jnz     short loc_37CFA
    cmp     word_4063C, 0
    jz      short loc_37CFA
    push    word ptr [bp+arg_0]
    mov     ax, offset aCannotLoadSongFileS; "cannot load song file %s"
    push    ax
    call    far ptr fatal_error
    add     sp, 4
loc_37CFA:
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
load_song_file endp
load_voice_file proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    sub     ax, ax
    mov     [bp+var_2], ax
    mov     [bp+var_4], ax
    cmp     byte_40635, 0
    jz      short loc_37D31
    mov     ax, offset audiodriverstring2
    push    ax              ; int
    mov     ax, offset aDvc ; "dvc"
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr load_sfx_ge
    add     sp, 6
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_37D31:
    mov     ax, [bp+var_4]
    or      ax, [bp+var_2]
    jnz     short loc_37D51
    mov     ax, offset audiodriverstring2
    push    ax              ; int
    mov     ax, offset aVce ; "vce"
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr load_sfx_ge
    add     sp, 6
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_37D51:
    mov     ax, [bp+var_4]
    or      ax, [bp+var_2]
    jnz     short loc_37D6F
    cmp     word_4063C, 0
    jz      short loc_37D6F
    push    word ptr [bp+arg_0]
    mov     ax, offset aCannotLoadVoiceFileS; "cannot load voice file %s"
    push    ax
    call    far ptr fatal_error
    add     sp, 4
loc_37D6F:
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
load_voice_file endp
nopsub_37D7A proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    mov     ax, offset audiodriverstring2
    push    ax              ; int
    mov     ax, offset aSlb ; "slb"
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr load_sfx_ge
    add     sp, 6
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jnz     short loc_37DB2
    cmp     word_4063C, 0
    jz      short loc_37DB2
    push    word ptr [bp+arg_0]
    mov     ax, offset aCannotLoadSampleFileS; "cannot load sample file %s"
    push    ax
    call    far ptr fatal_error
    add     sp, 4
loc_37DB2:
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
nopsub_37D7A endp
audio_init_chunk proc far
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = byte ptr 16
    arg_C = byte ptr 18

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    di
    push    si
    mov     ax, [bp+arg_0]
    mov     [bp+var_6], ax
    mov     ax, [bp+arg_2]
    cmp     [bp+var_6], ax
    jle     short loc_37DD5
    jmp     loc_37EBA
loc_37DD5:
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, offset audiochunks_unk
    mov     [bp+var_A], ax
    mov     di, [bp+var_6]
loc_37DE4:
    mov     si, [bp+var_A]
    sub     ax, ax
    mov     [si+4Ah], ax
    mov     [si+48h], ax
    mov     byte ptr [si+22h], 7Fh ; ''
    mov     ax, di
    mov     [si+23h], al
    mov     byte ptr [si+16h], 0Fh
    mov     byte_44D06[di], 0
    mov     byte_44ACA[di], 0
    mov     byte ptr [si+32h], 0
    mov     byte ptr [si+4], 0
    mov     al, [bp+arg_C]
    mov     [si+24h], al
    mov     byte ptr [si+15h], 0
    sub     ax, ax
    mov     [si+1Ah], ax
    mov     [si+18h], ax
    mov     byte ptr [si+1Ch], 0
    mov     [si+20h], ax
    mov     [si+1Eh], ax
    mov     al, [bp+arg_A]
    mov     [si+28h], al
    mov     byte ptr [si+25h], 0
    mov     word ptr [si+26h], 0
    mov     byte ptr [si+29h], 0
    mov     byte ptr [si+2Ah], 0
    mov     byte ptr [si+2Bh], 0
    mov     byte ptr [si+2Ch], 0
    mov     byte ptr [si+47h], 0FFh
    mov     ax, [bp+arg_4]
    or      ax, [bp+arg_6]
    jz      short loc_37EA0
    mov     ax, [bp+arg_8]
    add     ax, [bp+arg_4]
    mov     dx, [bp+arg_6]
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    push    dx
    push    ax
    push    cs
    call near ptr audioresource_get_dword
    add     sp, 4
    add     ax, 4
    mov     [si+5], ax
    mov     [si+7], dx
    push    [bp+var_2]
    push    [bp+var_4]
    push    cs
    call near ptr audioresource_get_dword
    add     sp, 4
    add     ax, 4
    mov     [si], ax
    mov     [si+2], dx
    add     [bp+arg_8], 5
    mov     ax, [bp+arg_4]
    mov     dx, [bp+arg_6]
    add     ax, 7
    mov     [si+2Eh], ax
    mov     [si+30h], dx
    jmp     short loc_37EA7
loc_37EA0:
    sub     ax, ax
    mov     [si+2], ax
    mov     [si], ax
loc_37EA7:
    add     [bp+var_A], 4Ch ; 'L'
    inc     di
    cmp     di, [bp+arg_2]
    jg      short loc_37EB4
    jmp     loc_37DE4
loc_37EB4:
    mov     [bp+var_6], di
    mov     [bp+var_8], si
loc_37EBA:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_init_chunk endp
audio_map_song_instruments proc far
    var_22 = word ptr -34
    var_20 = word ptr -32
    var_1E = word ptr -30
    var_numsomething = word ptr -28
    var_1A = word ptr -26
    var_hdrptr = dword ptr -22
    var_12 = word ptr -18
    var_counter = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_namebuf = byte ptr -10
    var_6 = byte ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_songtitlptr = dword ptr 6
    arg_vceptr = dword ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 22h
    push    di
    push    si
    mov     [bp+var_6], 0
    mov     ax, offset aHdr1_0; "hdr1"
    push    ax
    push    word ptr [bp+arg_songtitlptr+2]
    push    word ptr [bp+arg_songtitlptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr [bp+var_hdrptr], ax
    mov     word ptr [bp+var_hdrptr+2], dx
    or      ax, dx
    jnz     short loc_37EEB
    jmp     loc_38036
loc_37EEB:
    mov     [bp+var_counter], 0
    les     bx, [bp+var_hdrptr]
    mov     al, es:[bx+6]   ; counter is compared to this - numsomething?
    sub     ah, ah
    or      ax, ax
    jnz     short loc_37F00
    jmp     loc_37F87
loc_37F00:
    mov     [bp+var_numsomething], ax
    mov     [bp+var_1E], 0
    mov     ax, bx
    add     ax, 7
    mov     [bp+var_22], ax ; ax = hdrptr + 7 = instrument names; which are to be replaced with pointers to the instruments in the vce?
    mov     [bp+var_20], dx
loc_37F13:
    mov     [bp+var_12], 0
    mov     di, [bp+var_1E]
    sub     cx, cx
    mov     [bp+var_1A], ds
    lds     si, [bp+var_hdrptr]
loc_37F23:
    mov     bx, di
    add     bx, cx
    mov     al, [bx+si+7]
    mov     bx, cx
    add     bx, bp
    mov     ss:[bx+var_namebuf], al
    inc     cx
    cmp     cx, 4
    jl      short loc_37F23
    mov     ds, [bp+var_1A]
    mov     [bp+var_12], cx
    mov     ax, [bp+var_22]
    mov     dx, [bp+var_20]
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    lea     ax, [bp+var_namebuf]
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     [bp+var_E], ax
    mov     [bp+var_C], dx
    lea     ax, [bp+var_E]
    push    ss
    push    ax
    push    [bp+var_2]
    push    [bp+var_4]
    push    cs
    call near ptr audioresource_copy_4_bytes
    add     sp, 8
    add     [bp+var_1E], 4
    add     [bp+var_22], 4
    inc     [bp+var_counter]
    mov     ax, [bp+var_numsomething]
    cmp     [bp+var_counter], ax
    jb      short loc_37F13
loc_37F87:
    mov     ax, offset aBasd; "BASD"
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr basdres, ax
    mov     word ptr basdres+2, dx
    mov     ax, offset aSnar; "SNAR"
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr snarres, ax
    mov     word ptr snarres+2, dx
    mov     ax, offset aTomm; "TOMM"
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr tommres, ax
    mov     word ptr tommres+2, dx
    mov     ax, offset aRide; "RIDE"
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr rideres, ax
    mov     word ptr rideres+2, dx
    mov     ax, offset aCrsh; "CRSH"
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr crshres, ax
    mov     word ptr crshres+2, dx
    mov     ax, offset aChht; "CHHT"
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr chhtres, ax
    mov     word ptr chhtres+2, dx
    mov     ax, offset aOhht; "OHHT"
    push    ax
    push    word ptr [bp+arg_vceptr+2]
    push    word ptr [bp+arg_vceptr]
    call    audioresource_find
    add     sp, 6
    mov     word ptr ohhtres, ax
    mov     word ptr ohhtres+2, dx
loc_38036:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_map_song_instruments endp
sub_3803C proc far
    var_22 = word ptr -34
    var_20 = word ptr -32
    var_1C = word ptr -28
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = byte ptr -10
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 22h
    push    di
    push    si
    mov     ax, [bp+arg_4]
    or      ax, [bp+arg_6]
    jnz     short loc_3804F
    jmp     loc_3814F
loc_3804F:
    mov     ax, word ptr [bp+arg_0]
    or      ax, word ptr [bp+arg_0+2]
    jnz     short loc_3805A
    jmp     loc_3814F
loc_3805A:
    les     bx, [bp+arg_0]
    mov     al, es:[bx+4]
    sub     ah, ah
    mov     [bp+var_22], ax
    mov     [bp+var_14], ax
    mov     [bp+var_16], 0
    or      ax, ax
    jnz     short loc_38075
    jmp     loc_3814F
loc_38075:
    mov     [bp+var_20], 0
loc_3807A:
    mov     [bp+var_18], 0
    mov     di, [bp+var_20]
    sub     cx, cx
    mov     [bp+var_1C], ds
    lds     si, [bp+arg_0]
loc_3808A:
    mov     bx, di
    add     bx, cx
loc_3808E:
    mov     al, [bx+si+6]
    mov     bx, cx
    add     bx, bp
    mov     ss:[bx+var_A], al
    inc     cx
    cmp     cx, 4
    jl      short loc_3808A
    mov     ds, [bp+var_1C]
    mov     [bp+var_18], cx
    lea     ax, [bp+var_A]
    push    ax
    push    word ptr [bp+arg_0+2]
    push    word ptr [bp+arg_0]
    call    audioresource_find
    add     sp, 6
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    les     bx, [bp+var_4]
    cmp     byte ptr es:[bx+5], 3
    jz      short loc_380CE
    cmp     byte ptr es:[bx+5], 6
    jnz     short loc_38137
loc_380CE:
    cmp     byte ptr es:[bx+0Ah], 0
    jnz     short loc_38137
    mov     [bp+var_18], 0
    mov     ax, bx
    mov     dx, es
    add     ax, 6
    mov     cx, 2
    lea     di, [bp+var_A]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    repne movsw
    pop     ds
    mov     [bp+var_18], 4
    mov     ax, bx
    add     ax, 6
    mov     [bp+var_E], ax
    mov     [bp+var_C], dx
    lea     ax, [bp+var_A]
    push    ax
    push    [bp+arg_6]
    push    [bp+arg_4]
    call    locate_shape_nofatal
    add     sp, 6
    mov     [bp+var_12], ax
    mov     [bp+var_10], dx
    or      ax, dx
    jz      short loc_38137
    lea     ax, [bp+var_12]
    push    ss
    push    ax
    push    [bp+var_C]
    push    [bp+var_E]
    push    cs
    call near ptr audioresource_copy_4_bytes
    add     sp, 8
    les     bx, [bp+var_4]
    mov     byte ptr es:[bx+0Ah], 0FFh
loc_38137:
    add     [bp+var_20], 4
    inc     [bp+var_16]
    les     bx, [bp+arg_0]
    mov     al, es:[bx+4]
    sub     ah, ah
    cmp     ax, [bp+var_16]
    jbe     short loc_3814F
    jmp     loc_3807A
loc_3814F:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sub_3803C endp
sub_38156 proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 2
    mov     ax, 2Eh ; '.'
    imul    [bp+arg_0]
    add     ax, offset unk_45A26
    mov     [bp+var_2], ax
    mov     bx, ax
    mov     word ptr [bx+0Ch], 1
    mov     word ptr [bx+0Eh], 0
    mov     sp, bp
    pop     bp
    retf
sub_38156 endp
sub_38178 proc far
    var_10 = dword ptr -16
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    di
    push    si
    mov     word_4063A, 1
    sub     ax, ax
    push    ax
    mov     ax, 7Fh ; ''
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    mov     ax, 17h
    push    ax
    sub     ax, ax
    push    ax
    push    cs
    call near ptr audio_init_chunk
    add     sp, 0Eh
    mov     [bp+var_2], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jz      short loc_38221
    mov     di, 0A2B7h
    mov     [bp+var_6], 0A2B6h
    mov     [bp+var_8], 0A2B8h
    mov     [bp+var_A], 0A2C6h
    mov     [bp+var_C], 0A2E2h
    mov     si, [bp+var_2]
loc_381C8:
    push    si
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 1Eh
    mov     word ptr [bp+var_10+2], dx
    mov     word ptr [bp+var_10], ax
    call    [bp+var_10]
    add     sp, 2
    mov     byte ptr [di], 0
    mov     bx, [bp+var_6]
    mov     byte ptr [bx], 0FFh
    mov     bx, [bp+var_8]
    mov     byte ptr [bx], 0
    mov     bx, [bp+var_A]
    sub     ax, ax
    mov     [bx+2], ax
    mov     [bx], ax
    mov     bx, [bp+var_C]
    mov     byte ptr [bx], 0FFh
    add     di, 2Eh ; '.'
    add     [bp+var_6], 2Eh ; '.'
    add     [bp+var_8], 2Eh ; '.'
    add     [bp+var_A], 2Eh ; '.'
    add     [bp+var_C], 2Eh ; '.'
    inc     si
    mov     ax, si
    mov     cl, byte_459D2
    sub     ch, ch
    cmp     ax, cx
loc_3821C:
    jb      short loc_381C8
    mov     [bp+var_2], si
loc_38221:
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 18h
    mov     word ptr [bp+var_10+2], dx
    mov     word ptr [bp+var_10], ax
    call    [bp+var_10]
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 6
    mov     word ptr [bp+var_10+2], dx
    mov     word ptr [bp+var_10], ax
    call    [bp+var_10]
    mov     word_4063A, 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sub_38178 endp
audio_map_song_tracks proc far
    var_counter_shl2 = word ptr -50
    var_30 = word ptr -48
    var_2E = word ptr -46
    var_2C = word ptr -44
    var_counter = word ptr -42
    var_chunknamesofs = word ptr -40
    var_chunknamesseg = word ptr -38
    var_24 = byte ptr -36
    var_firstchunkdataofs = word ptr -34
    var_firstchunkdataseg = word ptr -32
    var_1E = word ptr -30
    var_1C = word ptr -28
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_numchunks = word ptr -22
    var_14 = dword ptr -20
    var_10 = word ptr -16
    var_E = word ptr -14
    var_namebuf = byte ptr -12
    var_8 = byte ptr -8
    var_chunkofsofs = word ptr -6
    var_chunkofsseg = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_chunkofs = word ptr 6
    arg_chunkseg = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 32h
    push    di
    push    si
    mov     [bp+var_8], 0
    mov     ax, [bp+arg_chunkofs]
    mov     dx, [bp+arg_chunkseg]
    add     ax, 4
    push    dx
    push    ax
    push    cs
    call near ptr audioresource_get_word
    add     sp, 4
    mov     [bp+var_numchunks], ax
    mov     ax, [bp+arg_chunkofs]
    mov     dx, [bp+arg_chunkseg]
    add     ax, 6
loc_3827E:
    mov     [bp+var_chunknamesofs], ax
loc_38281:
    mov     [bp+var_chunknamesseg], dx
    mov     ax, [bp+var_numchunks]
    shl     ax, 1
    shl     ax, 1
loc_3828B:
    add     ax, [bp+var_chunknamesofs]
    mov     [bp+var_chunkofsofs], ax
    mov     [bp+var_chunkofsseg], dx
loc_38294:
    mov     ax, [bp+var_numchunks]
    mov     cl, 3
    shl     ax, cl
    add     ax, [bp+arg_chunkofs]
    add     ax, 6
    mov     [bp+var_firstchunkdataofs], ax
    mov     [bp+var_firstchunkdataseg], dx
    mov     [bp+var_counter], 0
    jmp     loc_383C9
    ; align 2
    db 144
loc_382B0:
    inc     word ptr [bp+var_14]
loc_382B3:
    les     bx, [bp+var_14]
    test    byte ptr es:[bx], 80h
    jnz     short loc_382B0
    inc     word ptr [bp+var_14]
    mov     bx, word ptr [bp+var_14]
    mov     al, es:[bx]
    sub     ah, ah
    sub     ax, 0D9h ; 'Ù'
    cmp     ax, 11h
    jbe     short loc_382D2
    jmp     loc_3837E
loc_382D2:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_383A0[bx]
_trkdata_case13:
    add     word ptr [bp+var_14], 2
    mov     ax, 4
    push    ax
    lea     ax, [bp+var_namebuf]
    push    ss
    push    ax
    push    es
    push    word ptr [bp+var_14]
    call    audioresource_copy_n_bytes
    add     sp, 0Ah
    push    [bp+var_chunknamesseg]
    push    [bp+var_chunknamesofs]
    lea     ax, [bp+var_namebuf]
    push    ax
    push    [bp+var_numchunks]
    sub     ax, ax
    push    ax
    call    audioresource_get_chunk_index
    add     sp, 0Ah
    mov     [bp+var_2E], ax
    cmp     ax, 0FFFFh
    jz      short loc_3834A
    shl     ax, 1
    shl     ax, 1
    add     ax, [bp+var_chunkofsofs]
    mov     dx, [bp+var_chunkofsseg]
    push    dx
    push    ax
    push    cs
    call near ptr audioresource_get_dword
    add     sp, 4
    mov     [bp+var_1E], ax
    mov     [bp+var_1C], dx
    add     ax, [bp+var_firstchunkdataofs]
    mov     dx, [bp+var_firstchunkdataseg]
    mov     [bp+var_10], ax
    mov     [bp+var_E], dx
    lea     ax, [bp+var_10]
    push    ss
    push    ax
    push    word ptr [bp+var_14+2]
    push    word ptr [bp+var_14]
    push    cs
    call near ptr audioresource_copy_4_bytes
    add     sp, 8
loc_3834A:
    add     word ptr [bp+var_14], 4
_parse_trackdata:
    mov     ax, [bp+var_1A]
    mov     dx, [bp+var_18]
    cmp     word ptr [bp+var_14], ax
    jnb     short loc_383C6
    jmp     loc_382B3
_trkdata_case3__5_7__9_11_16_17:
    add     word ptr [bp+var_14], 2
    jmp     short _parse_trackdata
_trkdata_case6_12:
    add     word ptr [bp+var_14], 3
    jmp     short _parse_trackdata
_trkdata_case14_15:
    inc     word ptr [bp+var_14]
    les     bx, [bp+var_14]
    inc     word ptr [bp+var_14]
    mov     al, es:[bx]
    mov     [bp+var_2], al
    sub     ah, ah
    add     word ptr [bp+var_14], ax
    jmp     short _parse_trackdata
loc_3837E:
    mov     bx, word ptr [bp+var_14]
    mov     al, es:[bx]
    sub     ah, ah
    cmp     ax, 80h ; '€'
    jb      short loc_3838E
    inc     word ptr [bp+var_14]
loc_3838E:
    inc     word ptr [bp+var_14]
    mov     bx, word ptr [bp+var_14]
    test    byte ptr es:[bx], 80h
    jnz     short loc_3838E
_trkdata_case0_1_2_10:
    inc     word ptr [bp+var_14]
    jmp     short _parse_trackdata
    ; align 2
    db 144
off_383A0     dw offset _trkdata_case0_1_2_10
    dw offset _trkdata_case0_1_2_10
    dw offset _trkdata_case0_1_2_10
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case6_12
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case0_1_2_10
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case6_12
    dw offset _trkdata_case13
    dw offset _trkdata_case14_15
    dw offset _trkdata_case14_15
    dw offset _trkdata_case3__5_7__9_11_16_17
    dw offset _trkdata_case3__5_7__9_11_16_17
    jmp     short _parse_trackdata
loc_383C6:
    inc     [bp+var_counter]
loc_383C9:
    mov     ax, [bp+var_numchunks]
    cmp     [bp+var_counter], ax
    jl      short loc_383D4
    jmp     loc_384F4
loc_383D4:
    mov     ax, [bp+var_counter]
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_counter_shl2], ax
    add     ax, [bp+var_chunkofsofs]
    mov     dx, [bp+var_chunkofsseg]
    push    dx
    push    ax
    push    cs
    call near ptr audioresource_get_dword
    add     sp, 4
    add     ax, [bp+var_firstchunkdataofs]
    mov     dx, [bp+var_firstchunkdataseg]
    mov     word ptr [bp+var_14], ax
    mov     word ptr [bp+var_14+2], dx
    lea     ax, [bp+var_14]
    push    ss
    push    ax
    push    cs
    call near ptr audioresource_get_dword
    add     sp, 4
    add     ax, word ptr [bp+var_14]
    mov     dx, word ptr [bp+var_14+2]
    mov     [bp+var_1A], ax
    mov     [bp+var_18], dx
    add     word ptr [bp+var_14], 4
    mov     ax, 4
    push    ax
loc_38419:
    mov     ax, offset aHdr1_1; "hdr1"
    push    ds
    push    ax
    mov     ax, [bp+var_counter_shl2]
    add     ax, [bp+var_chunknamesofs]
    mov     dx, [bp+var_chunknamesseg]
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    call    audioresource_compare_chunknames
    add     sp, 0Ch
    or      ax, ax          ; ax = 1, found hdr1 at the counter index
    jnz     short _patch_hdrdata_trackptrs
    jmp     _parse_trackdata
_patch_hdrdata_trackptrs:
    add     word ptr [bp+var_14], 2
    les     bx, [bp+var_14]
    mov     al, es:[bx]
    mov     [bp+var_24], al
    sub     ah, ah
    shl     ax, 1
loc_3844C:
    shl     ax, 1
    inc     ax
    add     word ptr [bp+var_14], ax
    mov     bx, word ptr [bp+var_14]
    mov     al, es:[bx]
    mov     [bp+var_24], al
    inc     word ptr [bp+var_14]
    mov     [bp+var_2C], 0
    sub     ah, ah
    or      ax, ax
    jnz     short loc_3846C
loc_38469:
    jmp     loc_383C6
loc_3846C:
    mov     [bp+var_30], ax
    mov     di, [bp+var_2C]
loc_38472:
    mov     ax, 4
    push    ax
    lea     ax, [bp+var_namebuf]
    push    ss
    push    ax
    push    word ptr [bp+var_14+2]
    push    word ptr [bp+var_14]
    call    audioresource_copy_n_bytes
    add     sp, 0Ah
    push    [bp+var_chunknamesseg]
    push    [bp+var_chunknamesofs]
    lea     ax, [bp+var_namebuf]
    push    ax
    push    [bp+var_numchunks]
    sub     ax, ax
    push    ax
    call    audioresource_get_chunk_index
    add     sp, 0Ah
    mov     si, ax
    cmp     si, 0FFFFh
    jz      short loc_384DF
    shl     ax, 1
    shl     ax, 1
    add     ax, [bp+var_chunkofsofs]
    mov     dx, [bp+var_chunkofsseg]
    push    dx
    push    ax
    push    cs
    call near ptr audioresource_get_dword
    add     sp, 4
    mov     [bp+var_1E], ax
    mov     [bp+var_1C], dx
    add     ax, [bp+var_firstchunkdataofs]
    mov     dx, [bp+var_firstchunkdataseg]
    mov     [bp+var_10], ax
    mov     [bp+var_E], dx
    lea     ax, [bp+var_10]
    push    ss
    push    ax
    push    word ptr [bp+var_14+2]
    push    word ptr [bp+var_14]
    push    cs
    call near ptr audioresource_copy_4_bytes
    add     sp, 8
loc_384DF:
    add     word ptr [bp+var_14], 5
    inc     di
    mov     ax, di
    cmp     ax, [bp+var_30]
    jb      short loc_38472
    mov     [bp+var_2C], di
    mov     [bp+var_2E], si
    jmp     loc_383C6
loc_384F4:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_map_song_tracks endp
audioresource_get_dword proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_farptr = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
loc_38500:
    les     bx, [bp+arg_farptr]
    mov     ax, es:[bx]
    mov     dx, es:[bx+2]
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    mov     sp, bp
    pop     bp
    retf
audioresource_get_dword endp
audioresource_get_word proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 2
    les     bx, [bp+arg_0]
    mov     ax, es:[bx]
loc_38520:
    mov     [bp+var_2], ax
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audioresource_get_word endp
audioresource_copy_4_bytes proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = dword ptr 10

    push    bp
    mov     bp, sp
    les     bx, [bp+arg_4]
    inc     word ptr [bp+arg_4]
    mov     al, es:[bx]
loc_38534:
    les     bx, [bp+arg_0]
    inc     word ptr [bp+arg_0]
    mov     es:[bx], al
loc_3853D:
    les     bx, [bp+arg_4]
    inc     word ptr [bp+arg_4]
    mov     al, es:[bx]
    les     bx, [bp+arg_0]
    inc     word ptr [bp+arg_0]
    mov     es:[bx], al
    les     bx, [bp+arg_4]
loc_38552:
    inc     word ptr [bp+arg_4]
    mov     al, es:[bx]
    les     bx, [bp+arg_0]
    inc     word ptr [bp+arg_0]
    mov     es:[bx], al
    les     bx, [bp+arg_4]
    mov     al, es:[bx]
    les     bx, [bp+arg_0]
    mov     es:[bx], al
    pop     bp
    retf
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 8
    push    di
    push    si
    mov     al, audioflag6
    sub     ah, ah
    push    ax
    mov     al, byte_40632
    push    ax
    mov     al, audioflag2
    push    ax
    mov     al, byte_40630
    push    ax
    mov     ax, 4FA3h
    push    ax
    call    nopsub_3219D
    add     sp, 0Ah
    mov     al, byte_45948
    sub     ah, ah
    push    ax
    mov     al, byte_45950
    push    ax
    mov     ax, 4FD5h
    push    ax
    call    nopsub_3219D
    add     sp, 6
    sub     si, si
    mov     di, 8214h
    mov     word ptr [bp-6], 81FCh
loc_385B6:
    push    word ptr [di+2]
    push    word ptr [di]
    mov     bx, [bp-6]
    push    word ptr [bx+2]
    push    word ptr [bx]
    push    si
    mov     ax, 4FFBh
    push    ax
    call    nopsub_3219D
    add     sp, 0Ch
    add     di, 4Ch ; 'L'
    add     word ptr [bp-6], 4Ch ; 'L'
    inc     si
    cmp     si, 18h
    jl      short loc_385B6
    mov     [bp-2], si
    mov     ax, 5010h
    push    ax
loc_385E4:
    call    nopsub_3219D
    add     sp, 2
loc_385EC:
    call    flush_stdin
loc_385F1:
    sub     si, si
loc_385F3:
    mov     di, 0A2C2h
loc_385F6:
    mov     word ptr [bp-4], 0A2BEh
loc_385FB:
    mov     word ptr [bp-8], 0A2B7h
loc_38600:
    push    word ptr [di+2]
loc_38603:
    push    word ptr [di]
    mov     bx, [bp-4]
loc_38608:
    push    word ptr [bx+2]
loc_3860B:
    push    word ptr [bx]
    mov     bx, [bp-8]
    mov     al, [bx]
loc_38612:
    sub     ah, ah
    push    ax
    push    si
loc_38616:
    mov     ax, 501Dh
    push    ax
loc_3861A:
    call    nopsub_3219D
loc_3861F:
    add     sp, 0Eh
loc_38622:
    add     di, 2Eh ; '.'
loc_38625:
    add     word ptr [bp-4], 2Eh ; '.'
loc_38629:
    add     word ptr [bp-8], 2Eh ; '.'
    inc     si
loc_3862E:
    cmp     si, 10h
loc_38631:
    jl      short loc_38600
loc_38633:
    mov     [bp-2], si
loc_38636:
    pop     si
    pop     di
loc_38638:
    mov     sp, bp
loc_3863A:
    pop     bp
    retf
audioresource_copy_4_bytes endp
seg027 ends
end
