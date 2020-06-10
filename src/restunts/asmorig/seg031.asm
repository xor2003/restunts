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
    include seg027.inc
    include seg028.inc
    include seg029.inc
    include seg030.inc
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
seg031 segment byte public 'STUNTSC' use16
    assume cs:seg031
    assume es:nothing, ss:nothing, ds:dseg
    public file_load_shape2d_nofatal2
    public file_combine_and_find
    public file_find_next_alt
    public nullsub_1
    public nullsub_2
    public init_main
    public random_wait
    public load_palandcursor
    public get_0
    public mmgr_alloc_resbytes
    public mmgr_get_res_ofs_diff_scaled
    public mmgr_get_chunk_size_bytes
file_load_shape2d_nofatal2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_39E15:
    mov     bp, sp
loc_39E17:
    push    [bp+arg_0]
loc_39E1A:
    call    file_load_shape2d_nofatal_thunk
loc_39E1F:
    add     sp, 2
    pop     bp
    retf
file_load_shape2d_nofatal2 endp
file_combine_and_find proc far
    var_50 = byte ptr -80
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10

    push    bp
loc_39E25:
    mov     bp, sp
loc_39E27:
    sub     sp, 50h
loc_39E2A:
    lea     ax, [bp+var_50]
    push    ax              ; char *
loc_39E2E:
    push    [bp+arg_4]      ; int
loc_39E31:
    push    word ptr [bp+arg_0+2]
loc_39E34:
    push    word ptr [bp+arg_0]; char *
loc_39E37:
    call    file_build_path
loc_39E3C:
    add     sp, 8
loc_39E3F:
    lea     ax, [bp+var_50]
loc_39E42:
    push    ax
loc_39E43:
    call    file_find
loc_39E48:
    mov     sp, bp
loc_39E4A:
    pop     bp
    retf
file_combine_and_find endp
file_find_next_alt proc far

    call    file_find_next
    retf
file_find_next_alt endp
nullsub_1 proc far

    retf
    ; align 2
    db 144
nullsub_1 endp
nullsub_2 proc far

    retf
    ; align 2
    db 144
nullsub_2 endp
init_main proc far
    var_argcmd = word ptr -30
    var_timerdelta3 = word ptr -28
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_argmode4 = byte ptr -18
    var_timerdelta2 = word ptr -16
    var_argnosound = byte ptr -14
    var_timerdelta1 = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_argunknown = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_argc = word ptr 6
    arg_argv = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 1Eh
loc_39E5C:
    push    di
    push    si
    call    kb_init_interrupt
loc_39E63:
    call    kb_shift_checking2
loc_39E68:
    call    kb_call_readchar_callback
    mov     ax, offset do_mrl_textres
    mov     dx, seg seg008
    push    dx
loc_39E74:
    push    ax
    mov     ax, 7
    push    ax
loc_39E79:
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_joy_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 0Ah
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_key_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 0Bh
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_mof_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 3200h
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_pau_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 10h
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_pau_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 70h ; 'p'
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_dos_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 11h
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_sonsof_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 13h
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     ax, offset do_dos_restext
    mov     dx, seg seg008
    push    dx
    push    ax
    mov     ax, 18h
    push    ax
    call    kb_reg_callback
    add     sp, 6
    mov     video_flag1_is1, 1
    mov     video_flag2_is1, 1
    mov     video_flag3_isFFFF, 0FFFFh
    mov     video_flag4_is1, 1
    call    mmgr_alloc_a000
    mov     video_flag5_is0, 0
    mov     video_flag6_is1, 1
    mov     textresprefix, 'e'
    mov     [bp+var_argmode4], 0
    mov     [bp+var_argnosound], 0
    mov     [bp+var_argunknown], 0
    mov     si, 1
    jmp     short loc_39F63
loc_39F5E:
    mov     [bp+var_argmode4], 1
loc_39F62:
    inc     si
loc_39F63:
    cmp     [bp+arg_argc], si
    jg      short loc_39F6B
    jmp     loc_3A07A
loc_39F6B:
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     ax, [bx]
    mov     [bp+var_argcmd], ax
    mov     bx, ax
    cmp     byte ptr [bx], 2Fh ; '/'
    jnz     short loc_39F62
    mov     al, [bx+1]
    cbw
    cmp     ax, 68h ; 'h'
loc_39F87:
    jz      short loc_39F5E
    cmp     ax, 6Eh ; 'n'
    jnz     short loc_39F91
    jmp     loc_3A046
loc_39F91:
    cmp     ax, 73h ; 's'
    jnz     short loc_39F62
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     ax, [bx]
    mov     [bp+var_argcmd], ax
    mov     bx, ax
    mov     al, [bx+2]
    cbw
    mov     bx, ax
    test    g_ascii_props[bx], 1
    jz      short loc_39FC8
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     bx, [bx]
    mov     al, [bx+2]
    cbw
    add     ax, 20h ; ' '
    jmp     short loc_39FD7
    ; align 2
    db 144
loc_39FC8:
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     bx, [bx]
    mov     al, [bx+2]
    cbw
loc_39FD7:
    cmp     ax, 73h ; 's'
    jnz     short loc_3A022
    mov     bx, [bp+var_argcmd]
    mov     al, [bx+3]
    cbw
    mov     bx, ax
    test    g_ascii_props[bx], 1
    jz      short loc_3A000
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     bx, [bx]
    mov     al, [bx+3]
    cbw
    add     ax, 20h ; ' '
    jmp     short loc_3A00F
loc_3A000:
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     bx, [bx]
    mov     al, [bx+3]
    cbw
loc_3A00F:
    cmp     ax, 62h ; 'b'
    jnz     short loc_3A022
    mov     audiodriverstring, 61h ; 'a'
    mov     audiodriverstring+1, 64h ; 'd'
    jmp     loc_39F62
    ; align 2
    db 144
loc_3A022:
    mov     ax, [bp+arg_argv]
    mov     cx, si
    shl     cx, 1
    add     ax, cx
    mov     [bp+var_argcmd], ax
    mov     bx, ax
    mov     bx, [bx]
    mov     al, [bx+2]
    mov     audiodriverstring, al
    mov     bx, [bp+var_argcmd]
    mov     bx, [bx]
    mov     al, [bx+3]
    mov     audiodriverstring+1, al
    jmp     loc_39F62
loc_3A046:
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     bx, [bx]
    cmp     byte ptr [bx+2], 73h ; 's'
    jnz     short loc_3A05E
    mov     [bp+var_argnosound], 1
    jmp     loc_39F62
loc_3A05E:
    mov     bx, [bp+arg_argv]
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     bx, [bx]
    cmp     byte ptr [bx+2], 64h ; 'd'
    jz      short loc_3A072
    jmp     loc_39F62
loc_3A072:
    mov     [bp+var_argunknown], 1
    jmp     loc_39F62
    ; align 2
    db 144
loc_3A07A:
    call    video_set_mode_13h
    cmp     [bp+var_argmode4], 0
    jz      short loc_3A08A
    call    video_set_mode4
loc_3A08A:
    call    timer_setup_interrupt
    call    sprite_copy_2_to_1_clear
    mov     ax, 0C8h ; 'È'
    push    ax
    mov     ax, 140h
    push    ax
    call    mouse_init
    add     sp, 4
    sub     ax, ax
    push    ax              ; int
    push    ax
    mov     ax, offset audiodriverstring
    push    ax              ; char *
    call    audio_load_driver
    add     sp, 6
    or      ax, ax
    jz      short loc_3A0C9
    call    audio_stop_unk
    mov     ax, 1
    push    ax
    call    far ptr libsub_quit_to_dos_alt
    add     sp, 2
loc_3A0C9:
    cmp     [bp+var_argnosound], 0
    jz      short loc_3A0D9
    call    audio_toggle_flag2
    call    audio_toggle_flag6
loc_3A0D9:
    mov     ax, offset do_dea_textres
    mov     dx, seg seg008
    push    dx
    push    ax
    call    set_criterr_handler
    add     sp, 4
    push    cs
    call near ptr load_palandcursor
    call    sprite_copy_2_to_1
    mov     ax, 120
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 320
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    call    timer_get_delta_alt
    sub     si, si
loc_3A10F:
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    inc     si
    cmp     si, 0Fh
    jl      short loc_3A10F
    call    timer_get_delta_alt
    mov     [bp+var_timerdelta1], ax
    mov     ax, 60
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 320
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    sub     si, si
loc_3A140:
    mov     [bp+var_A], 0
    mov     [bp+var_8], 0
    mov     [bp+var_6], 0
    mov     [bp+var_4], 0
    sub     di, di
loc_3A156:
    mov     [bp+var_1A], di
    mov     [bp+var_18], di
    lea     ax, [bp+var_A]
    push    ax
    lea     ax, [bp+var_1A]
    push    ax
    call    rect_adjust_from_point
    add     sp, 4
    inc     di
    cmp     di, 190h
    jl      short loc_3A156
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    inc     si
    cmp     si, 0Fh
    jl      short loc_3A140
    call    timer_get_delta_alt
    mov     [bp+var_timerdelta2], ax
    sub     si, si
    jmp     short loc_3A1AB
loc_3A190:
    inc     di
loc_3A191:
    cmp     di, 0FFh
    jge     short loc_3A1AA
    lea     ax, [bp+var_A]
    push    ax
    lea     ax, [bp+var_1A]
    push    ax
    call    rect_adjust_from_point
    add     sp, 4
    jmp     short loc_3A190
    ; align 2
    db 144
loc_3A1AA:
    inc     si
loc_3A1AB:
    cmp     si, 92h ; '’'
    jge     short loc_3A1B6
    sub     di, di
    jmp     short loc_3A191
    ; align 2
    db 144
loc_3A1B6:
    call    timer_get_delta_alt
    mov     [bp+var_timerdelta3], ax
    mov     ax, [bp+var_timerdelta1]
    cmp     [bp+var_timerdelta2], ax
    jle     short loc_3A1CE
    mov     timertestflag, 0
    jmp     short loc_3A1D4
loc_3A1CE:
    mov     timertestflag, 1
loc_3A1D4:
    cmp     [bp+var_timerdelta3], 4Bh ; 'K'
    jge     short loc_3A1E2
    mov     framespersec2, 14h
    jmp     short loc_3A1E8
loc_3A1E2:
    mov     framespersec2, 0Ah
loc_3A1E8:
    cmp     [bp+var_timerdelta3], 23h ; '#'
    jge     short loc_3A1F6
    mov     timertestflag2, 0
    jmp     short loc_3A22B
    ; align 2
    db 144
loc_3A1F6:
    cmp     [bp+var_timerdelta3], 37h ; '7'
    jge     short loc_3A204
    mov     timertestflag2, 1
    jmp     short loc_3A22B
    ; align 2
    db 144
loc_3A204:
    cmp     [bp+var_timerdelta3], 4Bh ; 'K'
    jge     short loc_3A212
    mov     timertestflag2, 2
    jmp     short loc_3A22B
    ; align 2
    db 144
loc_3A212:
    cmp     [bp+var_timerdelta3], 64h ; 'd'
    jl      short loc_3A21F
    cmp     timertestflag, 0
    jnz     short loc_3A226
loc_3A21F:
    mov     timertestflag2, 3
    jmp     short loc_3A22B
loc_3A226:
    mov     timertestflag2, 4
loc_3A22B:
    mov     ax, framespersec2
    mov     framespersec, ax
    mov     ax, timertestflag
    mov     timertestflag_copy, ax
    push    cs
    call near ptr random_wait
    sub     ax, ax
    push    ax
    push    material_patlist2_ptr
    push    material_patlist_ptr
    push    material_clrlist2_ptr
    push    material_clrlist_ptr
    call    copy_material_list_pointers
    add     sp, 0Ah
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
init_main endp
random_wait proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    call    video_get_status
    mov     si, ax
    sub     di, di
    jmp     short loc_3A277
    ; align 2
    db 144
loc_3A270:
    cmp     di, 12000
    jge     short loc_3A280
    inc     di
loc_3A277:
    call    video_get_status
    cmp     ax, si
    jz      short loc_3A270
loc_3A280:
    cmp     di, 1024
    jnz     short loc_3A29A
    mov     bx, 46Ch
    mov     al, [bx]
    cbw
    mov     di, ax
    jmp     short loc_3A29A
loc_3A290:
    call    _rand
    call    get_kevinrandom
loc_3A29A:
    mov     ax, di
    dec     di
    or      ax, ax
    jnz     short loc_3A290
smart
    and     di, 0FFh
nosmart
    jmp     short loc_3A2B2
    ; align 2
    db 144
loc_3A2A8:
    call    get_kevinrandom
    call    _rand
loc_3A2B2:
    mov     ax, di
    dec     di
    or      ax, ax
    jnz     short loc_3A2A8
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
random_wait endp
load_palandcursor proc far
    var_312 = word ptr -786
    var_310 = dword ptr -784
    var_30C = word ptr -780
    var_30A = word ptr -778
    var_308 = word ptr -776
    var_306 = word ptr -774
    var_304 = dword ptr -772
    var_300 = byte ptr -768
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 312h
    push    si
    mov     ax, offset aSdmain; "sdmain"
    push    ax
loc_3A2CC:
    call    file_load_shape2d_fatal_thunk
    add     sp, 2
    mov     [bp+var_30C], ax
    mov     [bp+var_30A], dx
    mov     ax, offset aPal ; "!pal"
    push    ax
    push    dx
    push    [bp+var_30C]
    call    locate_shape_fatal
loc_3A2EA:
    add     sp, 6
loc_3A2ED:
    mov     word ptr [bp+var_304], ax
    mov     word ptr [bp+var_304+2], dx
    add     word ptr [bp+var_304], 10h
    mov     [bp+var_308], 0
loc_3A300:
    mov     bx, [bp+var_308]
    les     si, [bp+var_304]
    mov     al, es:[bx+si]
    mov     si, bx
    mov     [bp+si+var_300], al
    inc     [bp+var_308]
    cmp     [bp+var_308], 300h
    jl      short loc_3A300
    lea     ax, [bp+var_300]
    push    ax
    mov     ax, 100h
    push    ax
    sub     ax, ax
    push    ax
    call    video_set_palette
    add     sp, 6
    mov     ax, offset aSmou; "smou"
    push    ax
    push    [bp+var_30A]
    push    [bp+var_30C]
    call    locate_shape_fatal
    add     sp, 6
    mov     word ptr [bp+var_310], ax
    mov     word ptr [bp+var_310+2], dx
    les     bx, [bp+var_310]
    mov     ax, es:[bx]
    imul    video_flag2_is1
    mov     [bp+var_312], ax
    mov     ax, es:[bx+2]
    mov     [bp+var_306], ax
    push    [bp+var_30A]
    push    [bp+var_30C]
loc_3A36C:
    call    mmgr_free
    add     sp, 4
    mov     ax, 0Fh
    push    ax
    push    [bp+var_306]
    push    [bp+var_312]
loc_3A380:
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr smouspriteptr, ax
    mov     word ptr smouspriteptr+2, dx
    mov     ax, 0Fh
    push    ax
loc_3A393:
    push    [bp+var_306]
    push    [bp+var_312]
    call    sprite_make_wnd
loc_3A3A0:
    add     sp, 6
    mov     word ptr mmouspriteptr, ax
    mov     word ptr mmouspriteptr+2, dx
    mov     ax, 0Fh
    push    ax
    push    [bp+var_306]
    mov     ax, [bp+var_312]
loc_3A3B6:
    add     ax, video_flag2_is1
    push    ax
loc_3A3BB:
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr mouseunkspriteptr, ax
    mov     word ptr mouseunkspriteptr+2, dx
    mov     ax, offset aSdmain_0; "sdmain"
    push    ax
loc_3A3CE:
    call    file_load_shape2d_fatal_thunk
    add     sp, 2
    mov     [bp+var_30C], ax
    mov     [bp+var_30A], dx
    push    word ptr smouspriteptr+2
    push    word ptr smouspriteptr
    call    sprite_set_1_from_argptr
    add     sp, 4
    sub     ax, ax
    push    ax
    push    ax
    mov     ax, offset aSmou_0; "smou"
    push    ax
    push    [bp+var_30A]
    push    [bp+var_30C]
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sprite_shape_to_1
    add     sp, 8
loc_3A410:
    push    word ptr mmouspriteptr+2
    push    word ptr mmouspriteptr
    call    sprite_set_1_from_argptr
    add     sp, 4
    sub     ax, ax
    push    ax
    push    ax
    mov     ax, offset aMmou; "mmou"
    push    ax
    push    [bp+var_30A]
    push    [bp+var_30C]
    call    locate_shape_fatal
    add     sp, 6
loc_3A438:
    push    dx
    push    ax
    call    sprite_shape_to_1
    add     sp, 8
    push    [bp+var_30A]
    push    [bp+var_30C]
    call    mmgr_free
    add     sp, 4
    call    sprite_copy_2_to_1_2
    pop     si
    mov     sp, bp
    pop     bp
    retf
load_palandcursor endp
get_0 proc far

    sub     ax, ax
    retf
    ; align 2
    db 144
get_0 endp
mmgr_alloc_resbytes proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
loc_3A463:
    mov     ax, 10h
    cwd
    push    dx
    push    ax
    push    [bp+arg_4]
    push    [bp+arg_2]
loc_3A46F:
    call    __aFldiv
loc_3A474:
    inc     ax
    push    ax
loc_3A476:
    push    [bp+arg_0]
    call    mmgr_alloc_pages
loc_3A47E:
    add     sp, 4
    pop     bp
locret_3A482:
    retf
    ; align 2
    db 144
mmgr_alloc_resbytes endp
mmgr_get_res_ofs_diff_scaled proc far

    call    mmgr_get_ofs_diff
loc_3A489:
    sub     dx, dx
loc_3A48B:
    mov     cl, 4
loc_3A48D:
    shl     ax, 1
    rcl     dx, 1
loc_3A491:
    dec     cl
    jnz     short loc_3A48D
    retf
mmgr_get_res_ofs_diff_scaled endp
mmgr_get_chunk_size_bytes proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
loc_3A497:
    mov     bp, sp
loc_3A499:
    push    [bp+arg_2]
loc_3A49C:
    push    [bp+arg_0]
loc_3A49F:
    call    mmgr_get_chunk_size
loc_3A4A4:
    add     sp, 4
loc_3A4A7:
    sub     dx, dx
loc_3A4A9:
    mov     cl, 4
loc_3A4AB:
    shl     ax, 1
loc_3A4AD:
    rcl     dx, 1
loc_3A4AF:
    dec     cl
loc_3A4B1:
    jnz     short loc_3A4AB
loc_3A4B3:
    pop     bp
locret_3A4B4:
    retf
mmgr_get_chunk_size_bytes endp
seg031 ends
end
