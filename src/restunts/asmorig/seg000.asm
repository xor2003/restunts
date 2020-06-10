.model medium
nosmart
    include structs.inc
    include custom.inc
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
seg000 segment byte public 'STUNTSC' use16
    assume cs:seg000
    assume es:nothing, ss:nothing, ds:dseg
    public ported_stuntsmain_
    public run_intro_looped
    public run_intro
    public load_intro_resources
    public run_menu
    public run_tracks_menu
    public highscore_write_a
    public highscore_text_unk
    public print_highscore_entry
    public enter_hiscore
    public highscore_write_b
    public run_car_menu
    public run_opponent_menu
    public run_option_menu
    public off_1314A
    public end_hiscore
    public security_check
    public set_default_car
ported_stuntsmain_ proc far
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = byte ptr -10
    trkptr = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    p_argc = word ptr 6
    p_argv = dword ptr 8
    envp = dword ptr 12

    push    bp
loc_10001:
    mov     bp, sp
loc_10003:
    sub     sp, 12h
loc_10006:
    push    di
    push    si
loc_10008:
    push    word ptr [bp+p_argv]
loc_1000B:
    push    [bp+p_argc]
loc_1000E:
    call    init_main
    add     sp, 4
loc_10016:
    call    init_div0
loc_1001B:
    sub     si, si
loc_1001D:
    mov     ax, si
loc_1001F:
    shl     ax, 1
    mov     [bp+var_C], ax
    mov     ax, 1Dh
    sub     ax, si
loc_10029:
    mov     [bp+var_E], ax
loc_1002C:
    mov     ax, 1Eh
    imul    [bp+var_E]
    mov     bx, [bp+var_C]
loc_10035:
    mov     trackrows[bx], ax
    mov     ax, 1Eh
    imul    si
loc_1003E:
    mov     bx, [bp+var_C]
loc_10041:
    mov     terrainrows[bx], ax
    mov     ax, [bp+var_E]
    mov     cl, 0Ah
    shl     ax, cl          ; *1024, or tile length
loc_1004C:
    mov     [bp+var_10], ax
    mov     bx, [bp+var_C]
loc_10052:
    mov     trackpos[bx], ax
    mov     bx, [bp+var_C]
    mov     ax, [bp+var_10]
loc_1005C:
    add     ah, 2
    mov     trackcenterpos[bx], ax
loc_10063:
    mov     ax, si
    shl     ax, cl
    mov     [bp+var_12], ax
loc_1006A:
    mov     bx, [bp+var_C]
    mov     terrainpos[bx], ax
    mov     bx, [bp+var_C]
loc_10074:
    mov     ax, [bp+var_12]
    add     ah, 2
    mov     terraincenterpos[bx], ax
    inc     si
    cmp     si, 1Eh
    jl      short loc_1001D
    sub     si, si
loc_10086:
    mov     ax, si
    shl     ax, 1
loc_1008A:
    mov     [bp+var_12], ax
    mov     bx, ax
    mov     ax, si
    mov     cl, 0Ah
    shl     ax, cl
    mov     trackpos2[bx], ax
    mov     bx, [bp+var_12]
    mov     ax, si
    shl     ax, cl
    add     ah, 2
    mov     trackcenterpos2[bx], ax
    inc     si
    cmp     si, 1Eh
    jl      short loc_10086
    mov     ax, offset aMain; "main"
    push    ax
loc_100B1:
    call    file_load_resfile
    add     sp, 2
    mov     word ptr mainresptr, ax
loc_100BC:
    mov     word ptr mainresptr+2, dx
loc_100C0:
    mov     ax, offset aFontdef_fnt; "fontdef.fnt"
loc_100C3:
    push    ax              ; char *
loc_100C4:
    sub     ax, ax
loc_100C6:
    push    ax              ; int
loc_100C7:
    call    file_load_resource; type 0 = binary file
loc_100CC:
    add     sp, 4
loc_100CF:
    mov     word ptr fontdefptr, ax
loc_100D2:
    mov     word ptr fontdefptr+2, dx
    mov     ax, offset aFontn_fnt; "fontn.fnt"
    push    ax              ; char *
    sub     ax, ax
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr fontnptr, ax
    mov     word ptr fontnptr+2, dx
    call    font_set_fontdef
    call    init_polyinfo
    mov     si, 6BF3h       ; bytes to allocate
    mov     ax, si
    cwd
    push    dx
    push    ax
    mov     ax, offset aTrakdata; "trakdata"
    push    ax
    call    mmgr_alloc_resbytes
    add     sp, 6
    mov     [bp+trkptr], ax
    mov     [bp+var_2], dx
    mov     word ptr td01_track_file_cpy, ax
    mov     word ptr td01_track_file_cpy+2, dx
    add     [bp+trkptr], 70Ah; 1802, size of a track file
    mov     ax, [bp+trkptr]
    mov     word ptr td02_penalty_related, ax
    mov     word ptr td02_penalty_related+2, dx
    add     [bp+trkptr], 70Ah
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata3, ax
    mov     word ptr trackdata3+2, dx
    add     [bp+trkptr], 70Ah
    mov     ax, [bp+trkptr]
    mov     word ptr td04_aerotable_pl, ax
    mov     word ptr td04_aerotable_pl+2, dx
    add     [bp+trkptr], 80h
    mov     ax, [bp+trkptr]
    mov     word ptr td05_aerotable_op, ax
    mov     word ptr td05_aerotable_op+2, dx
    add     [bp+trkptr], 80h
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata6, ax
    mov     word ptr trackdata6+2, dx
    add     [bp+trkptr], 80h
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata7, ax
    mov     word ptr trackdata7+2, dx
    add     [bp+trkptr], 80h
loc_10176:
    mov     ax, [bp+trkptr]
    mov     word ptr td08_direction_related, ax
    mov     word ptr td08_direction_related+2, dx
    add     [bp+trkptr], 60h
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata9, ax
    mov     word ptr trackdata9+2, dx
    add     [bp+trkptr], 180h
    mov     ax, [bp+trkptr]
    mov     word ptr td10_track_check_rel, ax
    mov     word ptr td10_track_check_rel+2, dx
    add     [bp+trkptr], 120h
    mov     ax, [bp+trkptr]
    mov     word ptr td11_highscores, ax
    mov     word ptr td11_highscores+2, dx
    add     [bp+trkptr], 16Ch
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata12, ax
    mov     word ptr trackdata12+2, dx
    add     [bp+trkptr], 0F0h
    mov     ax, [bp+trkptr]
    mov     word ptr td13_rpl_header, ax
    mov     word ptr td13_rpl_header+2, dx
    add     [bp+trkptr], 1Ah
    mov     ax, [bp+trkptr]
    mov     word ptr td14_elem_map_main, ax
    mov     word ptr td14_elem_map_main+2, dx
    add     [bp+trkptr], 385h
    mov     ax, [bp+trkptr]
    mov     word ptr td15_terr_map_main, ax
    mov     word ptr td15_terr_map_main+2, dx
    add     [bp+trkptr], 385h
    mov     ax, [bp+trkptr]
    mov     word ptr td16_rpl_buffer, ax
    mov     word ptr td16_rpl_buffer+2, dx
    add     [bp+trkptr], 2EE0h
    mov     ax, [bp+trkptr]
    mov     word ptr td17_trk_elem_ordered, ax
    mov     word ptr td17_trk_elem_ordered+2, dx
    add     [bp+trkptr], 385h
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata18, ax
    mov     word ptr trackdata18+2, dx
    add     [bp+trkptr], 385h
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata19, ax
    mov     word ptr trackdata19+2, dx
    add     [bp+trkptr], 385h
    mov     ax, [bp+trkptr]
    mov     word ptr td20_trk_file_appnd, ax
    mov     word ptr td20_trk_file_appnd+2, dx
    add     [bp+trkptr], 7ACh
    mov     ax, [bp+trkptr]
    mov     word ptr td21_col_from_path, ax
    mov     word ptr td21_col_from_path+2, dx
    add     [bp+trkptr], 385h
    mov     ax, [bp+trkptr]
    mov     word ptr td22_row_from_path, ax
    mov     word ptr td22_row_from_path+2, dx
    add     [bp+trkptr], 385h
    mov     ax, [bp+trkptr]
    mov     word ptr trackdata23, ax
    mov     word ptr trackdata23+2, dx
    add     [bp+trkptr], 30h
    call    init_unknown
    mov     ax, offset aKevin; "kevin"
    push    ax
    call    init_kevinrandom
    add     sp, 2
    mov     ax, offset aDefault_0; "DEFAULT"
    push    ax
    mov     ax, offset gameconfig.game_trackname
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    sub     si, si
    mov     ax, 1
    push    ax
    call    input_do_checking
    add     sp, 2
    mov     ax, 1
    push    ax
    call    input_do_checking
    add     sp, 2
    call    mouse_draw_opaque_check
    mov     kbormouse, 0
    mov     passed_security, 1; originally set to 0 - bypasses the copy protection
    push    cs
    call near ptr set_default_car
    mov     si, 1
    jmp     _do_intro
    nop
_tracks_menu0:
    sub     ax, ax
_tracks_menu_ax:
    push    ax
    push    cs
    call near ptr run_tracks_menu
    add     sp, 2
    jmp     _show_menu
    nop
_do_opp_menu:
    call    check_input
    call    show_waiting
    push    cs
    call near ptr run_opponent_menu
    jmp     _show_menu
    nop
_do_option_menu:
    call    check_input
    call    show_waiting
    push    cs
    call near ptr run_option_menu
    or      al, al
    jnz     short _goto_game1
    jmp     _show_menu
_goto_game1:
    mov     [bp+var_A], 1
    jmp     short _do_game1
    nop
_do_car_menu:
    call    check_input
    call    show_waiting
    sub     ax, ax
    push    ax
    mov     ax, offset gameconfig.game_playertransmission
    push    ax
    mov     ax, offset gameconfig.game_playermaterial
    push    ax
    mov     ax, offset gameconfig
    push    ax
    push    cs
    call near ptr run_car_menu
    add     sp, 8
    jmp     _show_menu
    nop
_do_game0:
    mov     [bp+var_A], 0
_do_game1:
    push    si
    push    di
    mov     di, offset gameconfigcopy
    mov     si, offset gameconfig
    push    ds
    pop     es
    mov     cx, 0Dh
    repne movsw
    pop     di
    pop     si
    sub     si, si
loc_1032F:
    les     bx, td14_elem_map_main
    mov     al, es:[bx+si]
    les     bx, td20_trk_file_appnd
    mov     es:[bx+si], al
    inc     si
    cmp     si, 70Ah
    jl      short loc_1032F
    sub     si, si
loc_10346:
    les     bx, td20_trk_file_appnd
    mov     al, byte_3B80C[si]
    mov     es:[bx+si+70Ah], al
    les     bx, td20_trk_file_appnd
    mov     al, byte_3B85E[si]
    mov     es:[bx+si+75Bh], al
    inc     si
    cmp     si, 51h ; 'Q'
    jl      short loc_10346
    cmp     idle_expired, 0
    jnz     short _find_tedit
    call    track_setup
    or      al, al
    jz      short _sec_check1
    mov     ax, 1
    jmp     _tracks_menu_ax
_sec_check1:
    call    random_wait
    cmp     passed_security, 0
    jnz     short _init_replay
    call    get_super_random
    cwd
    mov     cx, 14h
    idiv    cx
    mov     ax, dx
    cbw
    push    ax
    push    cs
    call near ptr security_check
    add     sp, 2
_init_replay:
    call    audio_unload
    mov     ax, 5780h       ; size to allocate, 20*1120
    cwd
    push    dx
    push    ax
    mov     ax, offset aCvx ; "cvx"
    push    ax
    call    mmgr_alloc_resbytes
    add     sp, 6
    mov     word ptr cvxptr, ax
    mov     word ptr cvxptr+2, dx
    mov     ax, 0FFFFh
    push    ax
    call    init_game_state
    add     sp, 2
    cmp     [bp+var_A], 0
    jnz     short loc_103D1
    jmp     loc_104A6
loc_103D1:
    mov     byte_43966, 0
    jmp     loc_104AC
    nop
_find_tedit:
    mov     ax, offset aTedit__0; "tedit.*"
    push    ax
    call    file_find
    add     sp, 2
    or      ax, ax
    jnz     short _init_replay
_prepare_intro:
    call    audio_unload
_do_intro0:
    sub     si, si
_do_intro:
    mov     ax, 2
    push    ax
    call    ensure_file_exists
    add     sp, 2
    or      si, si
    jz      short loc_1042D
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, offset a_trk; ".trk"
    push    ax              ; int
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, offset byte_3B80C
    push    ax              ; char *
    call    file_build_path
    add     sp, 8
    push    word ptr td14_elem_map_main+2
    push    word ptr td14_elem_map_main
    mov     ax, offset g_path_buf
    push    ax
    call    file_read_fatal
    add     sp, 6
loc_1042D:
    mov     idle_expired, 0
    push    cs
    call near ptr run_intro_looped
    mov     di, ax
    cmp     di, 1Bh
    jnz     short _show_menu
    jmp     _ask_dos
_show_menu:
    mov     ax, 2
    push    ax
    call    ensure_file_exists
    add     sp, 2
    cmp     is_audioloaded, 0
    jnz     short loc_10467
    mov     ax, offset aSlct; "SLCT"
    push    ax
    mov     ax, offset aSkidms_0; "skidms"
    push    ax
    mov     ax, offset aSkidslct; "skidslct"
    push    ax              ; char *
    call    file_load_audiores
    add     sp, 6
loc_10467:
    push    cs
    call near ptr run_menu
    cbw
    cmp     ax, 0FFFFh
    jnz     short loc_10474
    jmp     _prepare_intro
loc_10474:
    or      ax, ax
    jnz     short loc_1047B
    jmp     _do_game0
loc_1047B:
    cmp     ax, 1
    jnz     short loc_10483
    jmp     _do_car_menu
loc_10483:
    cmp     ax, 2
    jnz     short _do_show_menu
    jmp     _do_opp_menu
_do_show_menu:
    cmp     ax, 3
    jnz     short loc_10493
    jmp     _tracks_menu0
loc_10493:
    cmp     ax, 4
    jnz     short loc_1049B
    jmp     _do_option_menu
loc_1049B:
    jmp     short _show_menu
    nop
loc_1049E:
    mov     byte_43966, 4
    jmp     short loc_104AC
    nop
loc_104A6:
    mov     gameconfig.game_recordedframes, 0
loc_104AC:
    call    show_waiting
    call    run_game
    cmp     idle_expired, 0
    jnz     short loc_104D2
    cmp     byte_43966, 0
    jz      short loc_104D2
    push    cs
    call near ptr end_hiscore
    cbw
    or      ax, ax
    jz      short loc_1049E
    cmp     ax, 1
    jz      short loc_104A6
loc_104D2:
    push    si
    push    di
    mov     di, offset gameconfig
    mov     si, offset gameconfigcopy
    push    ds
    pop     es
    mov     cx, 0Dh
    repne movsw
    pop     di
    pop     si
    sub     si, si
loc_104E5:
    les     bx, td20_trk_file_appnd
    mov     al, es:[bx+si]
    les     bx, td14_elem_map_main
    mov     es:[bx+si], al
    inc     si
    cmp     si, 70Ah
    jl      short loc_104E5
    sub     si, si
loc_104FC:
    les     bx, td20_trk_file_appnd
    mov     al, es:[bx+si+70Ah]
    mov     byte_3B80C[si], al
    les     bx, td20_trk_file_appnd
    mov     al, es:[bx+si+75Bh]
    mov     byte_3B85E[si], al
    inc     si
    cmp     si, 51h ; 'Q'
    jl      short loc_104FC
    push    word ptr cvxptr+2
    push    word ptr cvxptr
    call    mmgr_release
    add     sp, 4
    cmp     idle_expired, 0
    jnz     short loc_10536
    jmp     _show_menu
loc_10536:
    jmp     _do_intro0
    nop
_ask_dos:
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aDos ; "dos"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 2
    push    ax
    call    show_dialog
    add     sp, 12h
    cmp     ax, 1
    jge     short loc_10575
    jmp     _do_intro0
loc_10575:
    call    mouse_draw_opaque_check
    call    audio_stop_unk
    call    audiodrv_atexit
    call    kb_exit_handler
    call    kb_shift_checking1
    call    video_set_mode7
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    nop
ported_stuntsmain_ endp
run_intro_looped proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    mov     ax, offset aTitl; "TITL"
    push    ax
    mov     ax, offset aSkidms; "skidms"
    push    ax
    mov     ax, offset aSkidtitl; "skidtitl"
    push    ax              ; char *
    call    file_load_audiores
    add     sp, 6
    mov     ax, offset aSdtitl; "sdtitl"
    push    ax              ; char *
    mov     ax, 2
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr tempdataptr, ax
    mov     word ptr tempdataptr+2, dx
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
    push    cs
    call near ptr run_intro
    mov     si, ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    push    word ptr tempdataptr+2
    push    word ptr tempdataptr
    call    mmgr_free
    add     sp, 4
    or      si, si
    jnz     short loc_1068E
    call    setup_intro
    cbw
    mov     si, ax
    or      si, si
    jnz     short loc_1068E
    mov     ax, offset aSdcred; "sdcred"
    push    ax              ; char *
    mov     ax, 2
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr tempdataptr, ax
    mov     word ptr tempdataptr+2, dx
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
    call    sprite_copy_wnd_to_1_clear
    sub     ax, ax
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    push    cs
    call near ptr load_intro_resources
    cbw
    mov     si, ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    push    word ptr tempdataptr+2
    push    word ptr tempdataptr
    call    mmgr_free
    add     sp, 4
loc_1068E:
    call    audio_unload
loc_10693:
    mov     ax, si
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 4
    db 144
    db 144
run_intro_looped endp
run_intro proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    call    mouse_draw_opaque_check
    call    sprite_copy_2_to_1_clear
    call    mouse_draw_transparent_check
    call    sprite_copy_wnd_to_1_clear
    mov     ax, offset aProd; "prod"
    push    ax
    push    word ptr tempdataptr+2
    push    word ptr tempdataptr
    call    locate_shape_fatal
    add     sp, 6
    mov     bx, ax
    mov     es, dx
    cmp     word ptr es:[bx+0Ah], 0
    jz      short loc_106DE
    mov     waitflag, 0A0h ; '†'
    jmp     short loc_106E4
loc_106DE:
    mov     waitflag, 0B4h ; '¥'
loc_106E4:
    mov     ax, offset aProd_0; "prod"
    push    ax
    push    word ptr tempdataptr+2
    push    word ptr tempdataptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sprite_shape_to_1_alt
    add     sp, 4
    mov     ax, 0FFFFh
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     si, ax
    or      si, si
    jnz     short loc_1077F
    mov     ax, 190h
    push    ax
    call    input_repeat_check
    add     sp, 2
    mov     si, ax
    or      si, si
    jnz     short loc_1077F
    call    sprite_copy_wnd_to_1_clear
    mov     waitflag, 0B4h ; '¥'
    mov     ax, offset aTitl_0; "titl"
    push    ax
    push    word ptr tempdataptr+2
    push    word ptr tempdataptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sprite_shape_to_1_alt
    add     sp, 4
    mov     ax, 0FFFFh
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     si, ax
    or      si, si
    jnz     short loc_1077F
    mov     ax, 190h
    push    ax
    call    input_repeat_check
    add     sp, 2
    mov     si, ax
loc_1077F:
    mov     ax, si
    pop     si
    mov     sp, bp
    pop     bp
    retf
run_intro endp
load_intro_resources proc far
    var_46 = word ptr -70
    var_44 = word ptr -68
    var_40 = word ptr -64
    var_3E = word ptr -62
    var_3A = word ptr -58
    var_38 = word ptr -56
    var_36 = word ptr -54
    var_34 = dword ptr -52
    var_30 = dword ptr -48
    var_C = word ptr -12
    var_A = word ptr -10
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 46h
    push    di
    push    si
    mov     ax, offset aCred; "cred"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_3A], ax
    mov     [bp+var_38], dx
    lea     ax, [bp+var_34]
    push    ax
    mov     ax, offset aArowarrwarw1ar; "arowarrwarw1arw2arw3arw4arw5arw6arw7arw"...
    push    ax
    push    word ptr tempdataptr+2
    push    word ptr tempdataptr
    call    locate_many_resources
    add     sp, 8
    mov     waitflag, 96h ; 'ñ'
    call    sprite_copy_wnd_to_1_clear
    les     bx, [bp+var_30]
    mov     ax, es:[bx+8]
    mov     [bp+var_2], ax
    mov     ax, es:[bx+0Ah]
    mov     [bp+var_4], ax
    mov     ax, es:[bx]
    imul    video_flag1_is1
    mov     [bp+var_3E], ax
    mov     ax, es:[bx+2]
    mov     [bp+var_44], ax
    mov     ax, offset aCre ; "cre"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407DA
    push    word_407D8
    sub     ax, ax
    push    ax
    mov     ax, 78h ; 'x'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGds0; "gds0"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 0Ch
    push    ax
    mov     ax, 3Ch ; '<'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGds1; "gds1"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 14h
    push    ax
    mov     ax, 68h ; 'h'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aDes ; "des"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407DE
    push    word_407DC
    mov     ax, 20h ; ' '
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGdon; "gdon"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 2Ch ; ','
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGkev; "gkev"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 34h ; '4'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGbra; "gbra"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 3Ch ; '<'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGrob; "grob"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 44h ; 'D'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGsta; "gsta"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 0AC74h
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 4Ch ; 'L'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aMus ; "mus"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407EA
    push    word_407E8
    mov     ax, 5Ch ; '\'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGmsy; "gmsy"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 68h ; 'h'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGkri; "gkri"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 70h ; 'p'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGbri; "gbri"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 78h ; 'x'
    push    ax
    mov     ax, 14h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aPro ; "pro"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407E2
    push    word_407E0
    mov     ax, 20h ; ' '
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGkev_0; "gkev"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 2Ch ; ','
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aOpr ; "opr"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407E2
    push    word_407E0
    mov     ax, 38h ; '8'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGbra_0; "gbra"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 40h ; '@'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGric; "gric"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 48h ; 'H'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aArt ; "art"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407E6
    push    word_407E4
    mov     ax, 54h ; 'T'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGmsm; "gmsm"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 60h ; '`'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGdav; "gdav"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 68h ; 'h'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGnic; "gnic"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 70h ; 'p'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     ax, offset aGkev_1; "gkev"
    push    ax
    push    [bp+var_38]
    push    [bp+var_3A]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    push    word_407D6
    push    word_407D4
    mov     ax, 78h ; 'x'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    push    [bp+var_38]
    push    [bp+var_3A]
    call    unload_resource
    add     sp, 4
    mov     ax, 0FFFFh
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    call    sprite_copy_2_to_1_2
    call    timer_get_delta_alt
    mov     si, 14Ah
loc_10D77:
    call    timer_get_delta_alt
    mov     [bp+var_40], ax
    shl     ax, 1
    sub     si, ax
    cmp     [bp+var_2], si
    jle     short loc_10DA0
loc_10D88:
    les     bx, [bp+var_34]
    mov     ax, es:[bx+0Ah]
    mov     [bp+var_4], ax
    mov     [bp+var_36], 0
    sub     si, si
    mov     di, 2
    jmp     loc_10E83
    ; align 2
    db 144
loc_10DA0:
    call    mouse_draw_opaque_check
    push    [bp+var_4]
    push    si
    push    word ptr [bp+var_30+2]
    push    word ptr [bp+var_30]
    call    sprite_putimage_and_alt
    add     sp, 8
    sub     ax, ax
    push    ax
    push    [bp+var_44]
    mov     ax, 20h ; ' '
    push    ax
    push    [bp+var_4]
    mov     ax, [bp+var_3E]
    add     ax, si
    push    ax
    call    sprite_1_unk2
    add     sp, 0Ah
    call    mouse_draw_transparent_check
    push    [bp+var_40]
    call    input_do_checking
    add     sp, 2
    mov     [bp+var_46], ax
    or      ax, ax
    jz      short loc_10D77
    jmp     short loc_10D88
    ; align 2
    db 144
loc_10DEC:
    call    sprite_copy_wnd_to_1
    mov     ax, 0C8h ; '»'
    push    ax
    push    [bp+var_4]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    mov     bx, di
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    push    word ptr [bx-32h]
    push    word ptr [bx-34h]
    call    sprite_shape_to_1_alt
    add     sp, 4
    call    sprite_copy_2_to_1_2
    mov     ax, 0C8h ; '»'
    push    ax
    push    [bp+var_4]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    call    mouse_draw_opaque_check
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
    call    mouse_draw_transparent_check
    add     [bp+var_36], 5
    jmp     short loc_10E7D
loc_10E66:
    call    timer_get_delta_alt
    mov     [bp+var_40], ax
    push    ax
    call    input_do_checking
    add     sp, 2
    mov     [bp+var_46], ax
    add     si, [bp+var_40]
loc_10E7D:
    cmp     [bp+var_36], si
    jg      short loc_10E66
    inc     di
loc_10E83:
    cmp     di, 0Ah
    jge     short loc_10E91
    cmp     [bp+var_46], 0
    jnz     short loc_10E91
    jmp     loc_10DEC
loc_10E91:
    mov     ax, 0C8h ; '»'
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    call    mouse_draw_opaque_check
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_clear_shape
    add     sp, 4
    call    sprite_copy_wnd_to_1
    mov     ax, 0C8h ; '»'
    push    ax
    push    [bp+var_4]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    push    word ptr [bp+var_34+2]
    push    word ptr [bp+var_34]
    call    sprite_shape_to_1_alt
    add     sp, 4
    push    [bp+var_A]
    push    [bp+var_C]
    call    sprite_shape_to_1_alt
    add     sp, 4
    sub     ax, ax
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     [bp+var_46], ax
    or      ax, ax
    jnz     short loc_10F2B
    mov     ax, 1F4h
    push    ax
    call    input_repeat_check
    add     sp, 2
    or      ax, ax
    jz      short loc_10F34
loc_10F2B:
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_10F34:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
load_intro_resources endp
run_menu proc far
    var_selectedmenu = byte ptr -16
    var_menuhit = byte ptr -14
    var_C = byte ptr -12
    var_keycode = word ptr -10
    var_timedelta = word ptr -8
    var_6 = byte ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 10h
    mov     [bp+var_6], 0FFh
    mov     [bp+var_selectedmenu], 0
    mov     [bp+var_C], 0FFh
    call    show_waiting
    mov     waitflag, 0B4h ; '¥'
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
    mov     ax, offset aSdmsel; "sdmsel"
    push    ax              ; char *
    mov     ax, 2
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    call    sprite_copy_wnd_to_1
    mov     ax, offset aScrn; "scrn"
    push    ax
    push    [bp+var_2]
    push    [bp+var_4]
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sprite_shape_to_1_alt
    add     sp, 4
    push    [bp+var_2]
    push    [bp+var_4]
    call    mmgr_free
    add     sp, 4
loc_10FB9:
    mov     al, [bp+var_C]
    cmp     [bp+var_selectedmenu], al
    jz      short loc_10FEF
    mov     al, [bp+var_selectedmenu]
    mov     [bp+var_C], al
    call    sprite_copy_wnd_to_1
    mov     al, [bp+var_6]
    cbw
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     [bp+var_6], 0FEh ; '˛'
    call    sprite_copy_2_to_1_2
    call    sub_29772
loc_10FEF:
    push    word_407D0
    push    word_407CE
    mov     ax, offset menu_buttons_y2
    push    ax
    mov     ax, offset menu_buttons_y1
    push    ax
    mov     ax, offset menu_buttons_x2
    push    ax
    mov     ax, offset menu_buttons_x1
    push    ax
    mov     al, [bp+var_selectedmenu]
    cbw
    push    ax
    call    mouse_timer_sprite_unk
    add     sp, 0Eh
    mov     [bp+var_timedelta], ax
    push    ax
    call    input_checking
    add     sp, 2
    mov     [bp+var_keycode], ax
    mov     ax, offset menu_buttons_y2
    push    ax
    mov     ax, offset menu_buttons_y1
    push    ax
    mov     ax, offset menu_buttons_x2
    push    ax
    mov     ax, offset menu_buttons_x1
    push    ax
    mov     ax, 5
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_menuhit], al
    cmp     al, 0FFh
    jz      short loc_11049
    mov     [bp+var_selectedmenu], al
loc_11049:
    mov     ax, [bp+var_timedelta]
    add     idle_counter, ax
    cmp     idle_counter, 1770h
    jle     short loc_11062
    mov     idle_counter, 0
    inc     idle_expired
loc_11062:
    cmp     idle_expired, 0
    jz      short loc_11072
    mov     [bp+var_selectedmenu], 0; idle expired -> select menu 0 and keycode for enter
    mov     [bp+var_keycode], 0Dh
loc_11072:
    cmp     [bp+var_keycode], 0
    jnz     short loc_1107B
    jmp     loc_10FB9
loc_1107B:
    mov     ax, [bp+var_keycode]
    cmp     ax, 0Dh         ; enter
    jz      short loc_110BA
    cmp     ax, 1Bh         ; esc
    jz      short loc_110B6
    cmp     ax, 20h ; ' '   ; space
    jz      short loc_110BA
    cmp     ax, 4B00h       ; arrow
    jz      short loc_1109A
    cmp     ax, 4D00h       ; arrow opposite direction
    jz      short loc_110AA
    jmp     loc_10FB9
loc_1109A:
    mov     al, [bp+var_selectedmenu]
    cbw
    mov     bx, ax
    mov     al, [bx+280h]
loc_110A4:
    mov     [bp+var_selectedmenu], al
    jmp     loc_10FB9
loc_110AA:
    mov     al, [bp+var_selectedmenu]
    cbw
    mov     bx, ax
    mov     al, [bx+286h]
    jmp     short loc_110A4
loc_110B6:
    mov     [bp+var_selectedmenu], 0FFh
loc_110BA:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    mov     al, [bp+var_selectedmenu]
    cbw
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
run_menu endp
run_tracks_menu proc far
    var_16 = byte ptr -22
    var_14 = byte ptr -20
    var_12 = byte ptr -18
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = byte ptr -10
    var_9 = byte ptr -9
    var_8 = byte ptr -8
    var_7 = byte ptr -7
    var_6 = byte ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    di
    push    si
    mov     ax, 3
    push    ax
    call    ensure_file_exists
    add     sp, 2
    cmp     [bp+arg_0], 0
    jz      short loc_110ED
    jmp     loc_1156A
loc_110ED:
    mov     [bp+var_6], 0FFh
    mov     [bp+var_16], 0
    mov     [bp+var_12], 0FFh
    call    show_waiting
    mov     waitflag, 9Bh ; 'õ'
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
    les     bx, td14_elem_map_main
    mov     al, es:[bx+384h]
    sub     ah, ah
    push    ax
    call    load_skybox
    add     sp, 2
    call    shape3d_load_all
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    mov     ax, 28h ; '('
    push    ax
    push    ax
    call    set_projection
    add     sp, 8
    mov     ax, 0FFFEh
    push    ax
    call    init_game_state
    add     sp, 2
    call    sprite_copy_wnd_to_1
    push    skybox_grd_color
    call    sprite_clear_1_color
    add     sp, 2
    mov     ax, 0C8h ; '»'
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    call    draw_track_preview
    call    shape3d_free_all
    call    unload_skybox
    call    sprite_copy_wnd_to_1
    mov     ax, offset asc_3BA24; "'"
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    mov     ax, offset asc_3BA26; "'"
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 6
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    sub     ax, ax
    push    ax
    push    cs
    call near ptr highscore_write_a
    add     sp, 2
    or      al, al
    jz      short loc_111F9
    jmp     loc_112E5
loc_111F9:
    mov     ax, 34h ; '4'
    imul    word_46170
    mov     di, ax
    les     bx, td11_highscores
    cmp     word ptr es:[bx+di+32h], 0FFFFh
    jnz     short loc_11210
    jmp     loc_112E5
loc_11210:
    mov     ax, offset aHs0 ; "hs0"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 12h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    push    word ptr fontnptr+2
    push    word ptr fontnptr
    call    font_set_fontdef2
    add     sp, 4
    lea     ax, [bp+var_A]
    push    ax
    sub     ax, ax
    push    ax
    push    cs
    call near ptr print_highscore_entry
    add     sp, 4
    sub     ax, ax
    push    ax
    push    ax
    call    font_set_unk
    add     sp, 4
    mov     ax, 1Eh
    push    ax
    mov     ax, 10h
    push    ax
    mov     al, [bp+var_A]
    cbw
    add     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     ax, 1Eh
    push    ax
    mov     ax, 78h ; 'x'
    push    ax
    mov     al, [bp+var_9]
    cbw
    add     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     ax, 1Eh
    push    ax
    mov     ax, 0E0h ; '‡'
    push    ax
    mov     al, [bp+var_8]
    cbw
    add     ax, 0AC74h
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     ax, 1Eh
    push    ax
    mov     ax, 110h
    push    ax
    mov     al, [bp+var_7]
    cbw
    add     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    call    font_set_fontdef
loc_112E5:
    mov     ax, offset aTedit; "tedit"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 18h
    push    ax
    mov     ax, 5Eh ; '^'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, 11h
    push    ax
    mov     ax, offset aBmt ; "bmt"
    push    ax
    push    dx
    push    [bp+var_4]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 18h
    push    ax
    mov     ax, 5Eh ; '^'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, 71h ; 'q'
    push    ax
    mov     ax, offset aBet ; "bet"
    push    ax
    push    [bp+var_2]
    push    [bp+var_4]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 18h
    push    ax
    mov     ax, 5Eh ; '^'
    push    ax
    mov     ax, 0ACh ; '¨'
    push    ax
    mov     ax, 0D1h ; '—'
    push    ax
    mov     ax, offset aBmm ; "bmm"
    push    ax
    push    [bp+var_2]
    push    [bp+var_4]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    push    [bp+var_2]
    push    [bp+var_4]
    call    unload_resource
    add     sp, 4
loc_113B4:
    mov     al, [bp+var_12]
    cmp     [bp+var_16], al
    jz      short loc_113E5
    mov     al, [bp+var_16]
    mov     [bp+var_12], al
    mov     al, [bp+var_6]
    cbw
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     [bp+var_6], 0FEh ; '˛'
    call    sprite_copy_2_to_1_2
    call    sub_29772
loc_113E5:
    push    word_407D0
    push    word_407CE
    mov     ax, offset trackmenu_buttons_y2
    push    ax
    mov     ax, offset trackmenu_buttons_y1
    push    ax
    mov     ax, offset trackmenu_buttons_x2
    push    ax
    mov     ax, offset trackmenu_buttons_x1
    push    ax
    mov     al, [bp+var_16]
    cbw
    push    ax
    call    mouse_timer_sprite_unk
    add     sp, 0Eh
    mov     [bp+var_C], ax
    add     idle_counter, ax
    cmp     idle_counter, 1770h
    jle     short loc_11423
    mov     idle_counter, 0
    inc     idle_expired
loc_11423:
    push    [bp+var_C]
    call    input_checking
    add     sp, 2
    mov     [bp+var_E], ax
    mov     ax, offset trackmenu_buttons_y2
    push    ax
    mov     ax, offset trackmenu_buttons_y1
    push    ax
    mov     ax, offset trackmenu_buttons_x2
    push    ax
    mov     ax, offset trackmenu_buttons_x1
    push    ax
    mov     ax, 3
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_14], al
    cmp     al, 0FFh
    jz      short loc_11457
    mov     [bp+var_16], al
loc_11457:
    cmp     idle_expired, 0
    jz      short loc_11467
    mov     [bp+var_16], 2
    mov     [bp+var_E], 0Dh
loc_11467:
    cmp     [bp+var_E], 0
    jnz     short loc_11470
    jmp     loc_113B4
loc_11470:
    mov     ax, [bp+var_E]
    cmp     ax, 0Dh
    jz      short loc_114BC
    cmp     ax, 1Bh
    jz      short loc_114B8
    cmp     ax, 20h ; ' '
    jz      short loc_114BC
    cmp     ax, 4B00h
    jz      short loc_11490
    cmp     ax, 4D00h
    jz      short loc_114A4
    jmp     loc_113B4
    ; align 2
    db 144
loc_11490:
    cmp     [bp+var_16], 0
    jz      short loc_1149C
    dec     [bp+var_16]
    jmp     loc_113B4
loc_1149C:
    mov     [bp+var_16], 2
    jmp     loc_113B4
    ; align 2
    db 144
loc_114A4:
    cmp     [bp+var_16], 2
    jge     short loc_114B0
    inc     [bp+var_16]
    jmp     loc_113B4
loc_114B0:
    mov     [bp+var_16], 0
    jmp     loc_113B4
    ; align 2
    db 144
loc_114B8:
    mov     [bp+var_16], 0FFh
loc_114BC:
    mov     al, [bp+var_16]
    cbw
    or      ax, ax
    jz      short loc_114E2
    cmp     ax, 1
    jnz     short loc_114CC
    jmp     loc_1155A
loc_114CC:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_114E2:
    mov     ax, offset aTrk ; "trk"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx              ; int
    push    ax              ; int
    mov     ax, offset a_trk_0; ".trk"
    push    ax              ; int
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, 9Ch ; 'ú'
    push    ax              ; char *
    call    do_fileselect_dialog
    add     sp, 0Ah
    cbw
    mov     si, ax
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, offset a_trk_1; ".trk"
    push    ax              ; int
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, 9Ch ; 'ú'
    push    ax              ; char *
    call    file_build_path
    add     sp, 8
    or      si, si
    jz      short loc_11552
    push    word ptr td14_elem_map_main+2
    push    word ptr td14_elem_map_main
    mov     ax, 95F8h
    push    ax
    call    file_read_fatal
    add     sp, 6
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    jmp     loc_110ED
loc_11552:
    mov     [bp+var_12], 0FFh
    jmp     loc_113B4
    ; align 2
    db 144
loc_1155A:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
loc_1156A:
    call    check_input
    call    show_waiting
    mov     waitflag, 82h ; 'Ç'
    call    track_setup
    call    load_tracks_menu_shapes
    jmp     loc_110ED
    ; align 2
    db 144
run_tracks_menu endp
highscore_write_a proc far
    var_3A = word ptr -58
    var_38 = byte ptr -56
    var_27 = byte ptr -39
    var_F = byte ptr -15
    var_E = byte ptr -14
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 3Ah
    push    di
    push    si
    mov     byte_449CE, 0FFh
    mov     [bp+var_3A], 0
loc_1159A:
    mov     bx, [bp+var_3A]
    shl     bx, 1
    mov     ax, [bp+var_3A]
    mov     word_46170[bx], ax
    inc     [bp+var_3A]
    cmp     [bp+var_3A], 7
    jl      short loc_1159A
loc_115AF:
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, offset a_hig_0; ".hig"
    push    ax              ; int
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, 9Ch ; 'ú'
    push    ax              ; char *
    call    file_build_path
    add     sp, 8
    cmp     [bp+arg_0], 0
    jnz     short loc_1160A
    mov     g_is_busy, 1
    push    word ptr td11_highscores+2
    push    word ptr td11_highscores
    mov     ax, offset g_path_buf
    push    ax
    mov     ax, 0Ah
    push    ax
    call    sub_29A86
    add     sp, 8
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    mov     g_is_busy, 0
    or      ax, dx
    jnz     short loc_11602
loc_115F9:
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_11602:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_1160A:
    mov     ax, offset a______________; "...................."
    push    ax
    lea     ax, [bp+var_38]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset a_______________________; "......................."
    push    ax
    lea     ax, [bp+var_27]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     [bp+var_F], 0
    mov     ax, offset a______; "../...."
    push    ax
    lea     ax, [bp+var_E]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     [bp+var_6], 0FFFFh
    mov     [bp+var_3A], 0
loc_11648:
    mov     ax, 34h ; '4'
    imul    [bp+var_3A]
    mov     bx, ax
    les     si, td11_highscores
    lea     di, [bx+si]
    lea     si, [bp+var_38]
    mov     cx, 1Ah
    repne movsw
    inc     [bp+var_3A]
    cmp     [bp+var_3A], 7
    jl      short loc_11648
    mov     ax, 16Ch
    cwd
    push    dx
    push    ax
    push    word ptr td11_highscores+2
    push    word ptr td11_highscores
    mov     ax, offset g_path_buf
    push    ax
    call    file_write_fatal
    add     sp, 0Ah
    mov     [bp+var_3A], ax
    or      ax, ax
    jnz     short loc_1168B
    jmp     loc_11602
loc_1168B:
    jmp     loc_115F9
highscore_write_a endp
highscore_text_unk proc far
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = byte ptr -6
    var_5 = byte ptr -5
    var_4 = byte ptr -4
    var_3 = byte ptr -3
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    call    sprite_copy_wnd_to_1
    mov     ax, offset aHs1 ; "hs1"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, offset asc_3BAA2; " '"
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    mov     ax, offset asc_3BAA5; "'"
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 5
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, 0AC74h
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    mov     ax, offset aHs2 ; "hs2"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 0Fh
    push    ax
    mov     ax, 10h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    mov     ax, offset aHs3 ; "hs3"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 0Fh
    push    ax
    mov     ax, 78h ; 'x'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    mov     ax, offset aHs5 ; "hs5"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 0Fh
    push    ax
    mov     ax, 0E0h ; '‡'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    mov     ax, offset aHs4 ; "hs4"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 0Fh
    push    ax
    mov     ax, 110h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    push    word ptr fontnptr+2
    push    word ptr fontnptr
    call    font_set_fontdef2
    add     sp, 4
    mov     [bp+var_A], 0
    jmp     loc_118A0
loc_1181A:
    mov     [bp+var_2], 0
loc_1181F:
    mov     al, [bp+var_A]
    cbw
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, 19h
    mov     [bp+var_8], ax
    sub     ax, ax
    push    ax
    push    [bp+var_2]
    call    font_set_unk
    add     sp, 4
    push    [bp+var_8]
    mov     ax, 10h
    push    ax
    mov     al, [bp+var_6]
    cbw
    add     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    push    [bp+var_8]
    mov     ax, 78h ; 'x'
    push    ax
    mov     al, [bp+var_5]
    cbw
    add     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    push    [bp+var_8]
    mov     ax, 0E0h ; '‡'
    push    ax
    mov     al, [bp+var_4]
    cbw
    add     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    push    [bp+var_8]
    mov     ax, 110h
    push    ax
    mov     al, [bp+var_3]
    cbw
    add     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    inc     [bp+var_A]
loc_118A0:
    cmp     [bp+var_A], 7
    jge     short loc_118CA
    lea     ax, [bp+var_6]
    push    ax
    mov     al, [bp+var_A]
    cbw
    push    ax
    push    cs
    call near ptr print_highscore_entry
    add     sp, 4
    mov     al, byte_449CE
    cmp     [bp+var_A], al
    jz      short loc_118C1
    jmp     loc_1181A
loc_118C1:
    mov     ax, dialogarg2
    mov     [bp+var_2], ax
    jmp     loc_1181F
loc_118CA:
    call    font_set_fontdef
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
highscore_text_unk endp
print_highscore_entry proc far
    var_4A = byte ptr -74
    var_39 = byte ptr -57
    var_21 = byte ptr -33
    var_20 = byte ptr -32
    var_18 = word ptr -24
    var_16 = byte ptr -22
    var_14 = word ptr -20
    var_12 = byte ptr -18
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4Ah
    push    di
    push    si
    mov     bx, [bp+arg_0]
    shl     bx, 1
    mov     ax, 34h ; '4'
    imul    word_46170[bx]
    add     ax, word ptr td11_highscores
    mov     dx, word ptr td11_highscores+2
    push    si
    lea     di, [bp+var_4A]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 1Ah
    repne movsw
    pop     ds
    pop     si
    mov     bx, [bp+arg_2]
    mov     byte ptr [bx], 0
    lea     ax, [bp+var_4A]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    inc     al
    mov     [bp+var_16], al
    mov     bx, [bp+arg_2]
    mov     [bx+1], al
    lea     ax, [bp+var_39]
    push    ax
    mov     al, [bp+var_16]
    cbw
    add     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     al, [bp+var_16]
    cbw
    add     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    inc     al
    add     [bp+var_16], al
    mov     bx, [bp+arg_2]
    mov     al, [bp+var_16]
    mov     [bx+2], al
    mov     al, [bp+var_16]
    cbw
    mov     si, ax
    add     si, offset resID_byte1
    mov     byte ptr [si], 0
    cmp     [bp+var_21], 1
    jnz     short loc_11981
    mov     ax, offset asc_3BAB7; "("
    push    ax
    push    si              ; char *
    call    _strcat
    add     sp, 4
loc_11981:
    lea     ax, [bp+var_20]
    push    ax
    mov     al, [bp+var_16]
    cbw
    add     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    cmp     [bp+var_21], 1
    jnz     short loc_119AF
    mov     ax, offset asc_3BAB9; ")"
    push    ax
    mov     al, [bp+var_16]
    cbw
    add     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
loc_119AF:
    mov     al, [bp+var_16]
    cbw
    add     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    inc     al
    add     [bp+var_16], al
    mov     ax, framespersec
    mov     [bp+var_14], ax
    mov     framespersec, 14h
    cmp     [bp+var_18], 0FFFFh
    jz      short loc_119E0
    mov     ax, 1
    push    ax
    push    [bp+var_18]
    jmp     short loc_119E7
    ; align 2
    db 144
loc_119E0:
    mov     ax, 1
    push    ax              ; int
    sub     ax, ax
    push    ax
loc_119E7:
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    mov     bx, [bp+arg_2]
    mov     al, [bp+var_16]
    mov     [bx+3], al
    lea     ax, [bp+var_12]
    push    ax
    mov     al, [bp+var_16]
    cbw
    add     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, [bp+var_14]
    mov     framespersec, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
print_highscore_entry endp
enter_hiscore proc far
    var_3C = word ptr -60
    var_3A = word ptr -58
    var_38 = byte ptr -56
    var_36 = byte ptr -54
    var_25 = byte ptr -37
    var_D = byte ptr -13
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_9 = byte ptr -9
    var_4 = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = byte ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 3Ch
    push    di
    push    si
    cmp     framespersec, 0Ah
    jnz     short loc_11A2E
    shl     [bp+arg_0], 1
loc_11A2E:
    les     bx, td11_highscores
    mov     ax, [bp+arg_0]
    cmp     es:[bx+16Ah], ax
    ja      short loc_11A3F
    jmp     loc_11BAA
loc_11A3F:
    mov     [bp+var_38], 0
    jmp     short loc_11A5D
    ; align 2
    db 144
loc_11A46:
    cmp     [bp+var_38], 7
    jge     short loc_11A71
    mov     al, [bp+var_38]
    cbw
    mov     si, ax
    mov     bx, si
    shl     bx, 1
    mov     word_46170[bx], si
    inc     [bp+var_38]
loc_11A5D:
    mov     al, 34h ; '4'
    imul    [bp+var_38]
    mov     di, ax
    les     bx, td11_highscores
    mov     ax, [bp+arg_0]
    cmp     es:[bx+di+32h], ax
    jbe     short loc_11A46
loc_11A71:
    mov     al, [bp+var_38]
    mov     [bp+var_2], al
    mov     byte_449CE, al
    jmp     short loc_11A8D
loc_11A7C:
    mov     al, [bp+var_38]
    cbw
    mov     si, ax
    mov     bx, si
    shl     bx, 1
    mov     word_46172[bx], si
    inc     [bp+var_38]
loc_11A8D:
    cmp     [bp+var_38], 6
    jl      short loc_11A7C
    mov     al, [bp+var_2]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     word_46170[bx], 6
    mov     ax, [bp+arg_0]
    mov     [bp+var_4], ax
    mov     [bp+var_36], 0
    mov     ax, offset gnam_string
    push    ax
    lea     ax, [bp+var_25]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     al, [bp+arg_6]
    mov     [bp+var_D], al
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_11AE6
    mov     ax, offset unk_46464
    push    ax
    lea     ax, [bp+var_C]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     [bp+var_A], 2Fh ; '/'
    mov     ax, offset gsna_string
    push    ax
    lea     ax, [bp+var_9]
    jmp     short loc_11AED
    ; align 2
    db 144
loc_11AE6:
    mov     ax, offset asc_3BABB; " "
    push    ax
    lea     ax, [bp+var_C]
loc_11AED:
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    les     bx, td11_highscores
    lea     di, [bx+138h]
    lea     si, [bp+var_36]
    mov     cx, 1Ah
    repne movsw
    call    sprite_copy_wnd_to_1
    push    cs
    call near ptr highscore_text_unk
    mov     ax, 0FFFFh
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_3C]
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    push    [bp+arg_4]
    push    [bp+arg_2]
    sub     ax, ax
    push    ax
    mov     ax, 3
    push    ax
    call    show_dialog
    add     sp, 12h
    call    check_input
    mov     ax, (offset terraincenterpos+22h)
    cwd
    push    dx              ; int
    push    ax              ; int
    push    [bp+var_3A]     ; int
    push    [bp+var_3C]     ; int
    mov     ax, 10h
    push    ax
    mov     ax, offset byte_459E0
    push    ax              ; char *
    call    call_read_line
    add     sp, 0Ch
    mov     ax, offset byte_459E0
    push    ax
    lea     ax, [bp+var_36]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    les     bx, td11_highscores
    lea     di, [bx+138h]
    lea     si, [bp+var_36]
    mov     cx, 1Ah
    repne movsw
    call    sprite_copy_wnd_to_1
    push    cs
    call near ptr highscore_text_unk
    mov     ax, 0FFFFh
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    push    cs
    call near ptr highscore_write_b
loc_11BAA:
    push    cs
    call near ptr highscore_text_unk
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
enter_hiscore endp
highscore_write_b proc far
    var_16E = word ptr -366
    var_16C = byte ptr -364
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 16Eh
    push    di
    push    si
    mov     [bp+var_16E], 0
loc_11BC3:
    mov     bx, [bp+var_16E]
    shl     bx, 1
    mov     ax, 34h ; '4'
    imul    word_46170[bx]
    add     ax, word ptr td11_highscores
    mov     dx, word ptr td11_highscores+2
    mov     cx, ax
    mov     ax, 34h ; '4'
    mov     bx, dx
    imul    [bp+var_16E]
    mov     si, ax
    lea     di, [bp+si+var_16C]
    mov     si, cx
    push    ss
    pop     es
    push    ds
    mov     ds, bx
    mov     cx, 1Ah
    repne movsw
    pop     ds
    inc     [bp+var_16E]
    cmp     [bp+var_16E], 7
    jl      short loc_11BC3
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, offset a_hig; ".hig"
    push    ax              ; int
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, 9Ch ; 'ú'
    push    ax              ; char *
    call    file_build_path
    add     sp, 8
    mov     g_is_busy, 1
    mov     ax, 16Ch
    cwd
    push    dx
    push    ax
    lea     ax, [bp+var_16C]
    push    ss
    push    ax
    mov     ax, 95F8h
    push    ax
    call    file_write_fatal
    add     sp, 0Ah
    mov     g_is_busy, 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
highscore_write_b endp
run_car_menu proc far
    var_10C = dword ptr -268
    var_108 = byte ptr -264
    var_106 = byte ptr -262
    var_104_rc = RECTANGLE ptr -260
    var_FC = dword ptr -252
    var_carpospolarangle = word ptr -248
    var_F6 = byte ptr -246
    var_findfile = word ptr -244
    var_F2 = byte ptr -242
    var_caridindex = byte ptr -240
    var_carids = byte ptr -238
    var_rotationdelta = word ptr -76
    var_4A = word ptr -74
    var_48 = word ptr -72
    var_46 = byte ptr -70
    var_44 = word ptr -68
    var_42wnd = dword ptr -66
    var_3E = byte ptr -62
    var_3C = word ptr -60
    var_3A = word ptr -58
    var_prevcaridindex = byte ptr -56
    var_36 = word ptr -54
    var_34 = word ptr -52
    var_transshape = TRANSFORMEDSHAPE ptr -50
    var_rotation = word ptr -30
    var_1C = byte ptr -28
    var_1A_rc = RECTANGLE ptr -26
    var_12 = word ptr -18
    var_10_rc = RECTANGLE ptr -16
    var_carspeed = word ptr -8
    var_6 = byte ptr -6
    var_carres = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_caridptr = word ptr 6
    arg_materialofs = word ptr 8
    arg_transmissionofs = word ptr 10
    arg_opponenttype = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 10Ch
    push    di
    push    si
    push    si
    lea     di, [bp+var_transshape]
    mov     si, offset carmenu_carpos
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     [bp+var_transshape.ts_shapeptr], (offset game3dshapes.shape3d_numverts+0AA8h)
    mov     [bp+var_transshape.ts_rotvec.vx], 0
    mov     [bp+var_transshape.ts_rotvec.vy], 0
    mov     [bp+var_transshape.ts_unk], 7530h
    mov     ax, timertestflag
    mov     timertestflag_copy, ax
    or      ax, ax
    jz      short loc_11C82
    lea     ax, [bp+var_10_rc]
    mov     [bp+var_transshape.ts_rectptr], ax
    mov     [bp+var_transshape.ts_flags], 8
    jmp     short loc_11C86
loc_11C82:
    mov     [bp+var_transshape.ts_flags], 0
loc_11C86:
    mov     ax, 2
    push    ax
    call    ensure_file_exists
    add     sp, 2
    mov     ax, offset a_res_0; ".res"
    push    ax              ; int
    mov     ax, offset aCar ; "car*"
    push    ax
    sub     ax, ax
    push    ax              ; char *
    call    file_combine_and_find
    add     sp, 6
    mov     [bp+var_findfile], ax
    or      ax, ax
    jnz     short loc_11CB8
    call    nullsub_1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_11CB8:
    mov     bx, [bp+var_findfile]
    mov     al, [bx+3]
    mov     [bp+var_carids], al
    mov     al, [bx+4]
    mov     [bp+var_carids+1], al
    mov     al, [bx+5]
    mov     [bp+var_carids+2], al
    mov     al, [bx+6]
    mov     [bp+var_carids+3], al
    mov     [bp+var_carids+4], 0
    mov     [bp+var_46], 1
loc_11CE1:
    call    file_find_next_alt
    mov     [bp+var_findfile], ax
    or      ax, ax
    jz      short loc_11D44
    mov     al, [bp+var_46]
    cbw
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    mov     di, ax
    add     di, bp
    mov     bx, [bp+var_findfile]
    mov     al, [bx+3]
    mov     [di+var_carids], al
    mov     bx, [bp+var_findfile]
    mov     al, [bx+4]
    mov     [di+var_carids+1], al
    mov     bx, [bp+var_findfile]
    mov     al, [bx+5]
    mov     [di+var_carids+2], al
    mov     bx, [bp+var_findfile]
    mov     al, [bx+6]
    mov     [di+var_carids+3], al
    mov     al, [bp+var_46]
    cbw
    mov     di, ax
    shl     di, 1
    shl     di, 1
    add     di, ax
    mov     [bp+di+var_carids+4], 0
    inc     [bp+var_46]
    cmp     [bp+var_46], 20h ; ' '
    jnz     short loc_11CE1
loc_11D44:
    call    nullsub_1
    cmp     [bp+var_46], 1
    jg      short loc_11D52
    jmp     loc_11E10
loc_11D52:
    mov     [bp+var_4A], 0
    jmp     loc_11DFB
loc_11D5A:
    inc     [bp+var_44]
loc_11D5D:
    mov     al, [bp+var_46]
    cbw
    cmp     ax, [bp+var_44]
    ja      short loc_11D69
    jmp     loc_11DF8
loc_11D69:
    mov     di, [bp+var_44]
    mov     ax, di
    shl     di, 1
    shl     di, 1
    add     di, ax
    lea     ax, [bp+di+var_carids]
    push    ax
    mov     di, [bp+var_4A]
    mov     ax, di
    shl     di, 1
    shl     di, 1
    add     di, ax
    lea     ax, [bp+di+var_carids]
    push    ax              ; char *
    call    _strcmp
    add     sp, 4
    or      ax, ax
    jle     short loc_11D5A
    mov     di, [bp+var_4A]
    mov     ax, di
    shl     di, 1
    shl     di, 1
    add     di, ax
    lea     ax, [bp+di+var_carids]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     di, [bp+var_44]
    mov     ax, di
    shl     di, 1
    shl     di, 1
    add     di, ax
    lea     ax, [bp+di+var_carids]
    push    ax
    mov     di, [bp+var_4A]
    mov     ax, di
    shl     di, 1
    shl     di, 1
    add     di, ax
    lea     ax, [bp+di+var_carids]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset resID_byte1
    push    ax
    mov     di, [bp+var_44]
    mov     ax, di
    shl     di, 1
    shl     di, 1
    add     di, ax
    lea     ax, [bp+di+var_carids]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    jmp     loc_11D5A
loc_11DF8:
    inc     [bp+var_4A]
loc_11DFB:
    mov     al, [bp+var_46]
    cbw
    dec     ax
    cmp     ax, [bp+var_4A]
    jle     short loc_11E10
    mov     ax, [bp+var_4A]
    inc     ax
    mov     [bp+var_44], ax
    jmp     loc_11D5D
    ; align 2
    db 144
loc_11E10:
    mov     [bp+var_caridindex], 0
    mov     [bp+var_F6], 0
    jmp     short loc_11E20
loc_11E1C:
    inc     [bp+var_F6]
loc_11E20:
    mov     al, [bp+var_46]
    cmp     [bp+var_F6], al
    jge     short loc_11E68
    mov     al, [bp+var_F6]
    cbw
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    mov     di, ax
    add     di, bp
    mov     bx, [bp+arg_caridptr]
    mov     al, [di+var_carids]
    cmp     [bx], al
    jnz     short loc_11E1C
    mov     al, [di+var_carids+1]
    cmp     [bx+1], al
    jnz     short loc_11E1C
    mov     al, [di+var_carids+2]
    cmp     [bx+2], al
    jnz     short loc_11E1C
    mov     al, [di+var_carids+3]
    cmp     [bx+3], al
    jnz     short loc_11E1C
    mov     al, [bp+var_F6]
    mov     [bp+var_caridindex], al
loc_11E68:
    mov     waitflag, 5Ah ; 'Z'
    mov     [bp+var_3E], 0FFh
    mov     backlights_paint_override, 2Dh ; '-'; default backlights paintjob 2Dh
    mov     ax, offset aSdcsel; "sdcsel"
    push    ax
    call    file_load_shape2d_fatal_thunk
    add     sp, 2
    mov     [bp+var_36], ax
    mov     [bp+var_34], dx
    cmp     [bp+arg_opponenttype], 0
    jnz     short loc_11EA2
    mov     ax, offset aMisc_0; "misc"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     word ptr miscptr, ax
    mov     word ptr miscptr+2, dx
loc_11EA2:
    cmp     [bp+arg_opponenttype], 0
    jnz     short loc_11EAB
    jmp     loc_11F4A
loc_11EAB:
    mov     rect_unk16.rc_right, 0F0h ; ''
    cmp     video_flag5_is0, 0
    jnz     short loc_11EBB
    jmp     loc_11F50
loc_11EBB:
    mov     bx, [bp+arg_opponenttype]
    shl     bx, 1
    shl     bx, 1
    mov     ax, word ptr oppresources[bx]
    mov     dx, word ptr (oppresources+2)[bx]
    mov     word ptr [bp+var_10C], ax
    mov     word ptr [bp+var_10C+2], dx
    mov     ax, 0Fh
    push    ax
    les     bx, [bp+var_10C]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr [bp+var_42wnd], ax
    mov     word ptr [bp+var_42wnd+2], dx
    call    setup_mcgawnd2
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    mov     al, byte ptr [bp+arg_opponenttype]
    add     al, 30h ; '0'
    cbw
    push    ax
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    nullsub_2
    add     sp, 6
    sub     ax, ax
    push    ax
    push    ax
    mov     bx, [bp+arg_opponenttype]
    shl     bx, 1
    shl     bx, 1
    push    word ptr (oppresources+2)[bx]
    push    word ptr oppresources[bx]
    call    sprite_putimage_transparent
    add     sp, 8
    sub     ax, ax
    push    ax
    push    ax
    les     bx, [bp+var_42wnd]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_clear_shape_alt
    add     sp, 8
    jmp     short loc_11F50
    ; align 2
    db 144
loc_11F4A:
    mov     rect_unk16.rc_right, 140h
loc_11F50:
    mov     [bp+var_prevcaridindex], 0FFh
    mov     [bp+var_rotation], 0
    mov     [bp+var_106], 0
    call    sub_29772
    mov     [bp+var_rotationdelta], 0
    mov     [bp+var_F2], 0FFh
    mov     ax, 64h ; 'd'
    push    ax
    mov     ax, 140h
    push    ax
    mov     ax, 11h
    push    ax
    mov     ax, 24h ; '$'
    push    ax
    call    set_projection
    add     sp, 8
    call    timer_get_delta_alt
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
loc_11FA5:
    mov     al, [bp+var_prevcaridindex]
    cmp     [bp+var_caridindex], al
    jnz     short loc_11FB1
    jmp     loc_12405
loc_11FB1:
    cmp     al, 0FFh
    jz      short loc_11FC8
    push    word ptr [bp+var_carres+2]
    push    word ptr [bp+var_carres]
    call    unload_resource
    add     sp, 4
    call    shape3d_free_car_shapes
loc_11FC8:
    mov     ax, offset gameconfig.game_opponentcarid
    push    ax
    mov     al, [bp+var_caridindex]
    cbw
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 0EEh ; 'Ó'  ; var_EE = var_carids
    push    ax
    call    shape3d_load_car_shapes
    add     sp, 4
    mov     al, [bp+var_caridindex]
    cbw
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    mov     di, ax
    add     di, bp
    mov     al, [di+var_carids]
    mov     byte ptr aCarcoun+3, al
    mov     al, [di+var_carids+1]
    mov     byte ptr aCarcoun+4, al
    mov     al, [di+var_carids+2]
    mov     byte ptr aCarcoun+5, al
    mov     al, [di+var_carids+3]
    mov     byte ptr aCarcoun+6, al
    mov     ax, offset aCarcoun; "carcoun"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     word ptr [bp+var_carres], ax
    mov     word ptr [bp+var_carres+2], dx
    sub     ax, ax
    push    ax
    push    dx
    push    word ptr [bp+var_carres]
    call    setup_aero_trackdata
    add     sp, 6
    call    sprite_copy_wnd_to_1_clear
    sub     ax, ax
    push    ax
    push    word_407F8      ; 7
    push    word_407F6      ; 8
    push    word_407F4      ; F
    mov     ax, 61h ; 'a'
    push    ax
    mov     ax, 140h
    push    ax
    mov     ax, 67h ; 'g'
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 55h ; 'U'
    push    ax
    mov     ax, 46h ; 'F'
    push    ax
    mov     ax, 6Dh ; 'm'
    push    ax
    mov     ax, 5
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 55h ; 'U'
    push    ax
    mov     ax, 8Ch ; 'å'
loc_120A3:
    push    ax
    mov     ax, 6Dh ; 'm'
    push    ax
    mov     ax, 52h ; 'R'
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    call    draw_button
    add     sp, 14h
    mov     ax, offset aGrap; "grap"
    push    ax
    push    [bp+var_34]
    push    [bp+var_36]
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sprite_shape_to_1_alt
    add     sp, 4
    push    word ptr fontnptr+2
    push    word ptr fontnptr
    call    font_set_fontdef2
    add     sp, 4
    push    dialog_fnt_colour; the graph
    sub     ax, ax
    push    ax
    call    font_set_unk
    add     sp, 4
    mov     ax, 73h ; 's'
    push    ax
    mov     ax, 9
    push    ax
    mov     ax, offset a150 ; "150"
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     ax, 87h ; 'á'
    push    ax
    mov     ax, 9
    push    ax
    mov     ax, offset a100 ; "100"
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     ax, 9Bh ; 'õ'
    push    ax
    mov     ax, 9
    push    ax
    mov     ax, offset a50  ; " 50"
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     ax, 0AFh ; 'Ø'
    push    ax
    mov     ax, 9
    push    ax
    mov     ax, offset a0   ; "  0"
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     ax, 0B9h ; 'π'
    push    ax
    mov     ax, 1Ah
    push    ax
    mov     ax, offset a02040; "0  20  40"
    push    ax
    call    font_draw_text
    add     sp, 6
    call    font_set_fontdef
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 10h
    push    ax
    mov     ax, 56h ; 'V'
    push    ax
    mov     ax, carmenu_buttons_x1
    inc     ax
    push    ax
    mov     ax, carmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, offset aBdo_0; "bdo"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 10h
    push    ax
    mov     ax, 56h ; 'V'
    push    ax
    mov     ax, carmenu_buttons_x1+2
    inc     ax
    push    ax
    mov     ax, carmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, offset aBnx_0; "bnx"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 10h
    push    ax
    mov     ax, 56h ; 'V'
    push    ax
    mov     ax, carmenu_buttons_x1+4
    inc     ax
    push    ax
    mov     ax, carmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, offset aBla_0; "bla"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    mov     bx, [bp+arg_transmissionofs]
    cmp     byte ptr [bx], 0
    jz      short loc_12226
    mov     ax, offset aBau ; "bau"
    jmp     short loc_12229
loc_12226:
    mov     ax, offset aBma ; "bma"
loc_12229:
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    mov     [bp+var_3C], ax
    mov     [bp+var_3A], dx
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 10h
    push    ax
    mov     ax, 56h ; 'V'
    push    ax
    mov     ax, carmenu_buttons_x1+6
    inc     ax
    push    ax
    mov     ax, carmenu_buttons_y1
    inc     ax
    push    ax
    push    dx
    push    [bp+var_3C]
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 10h
    push    ax
    mov     ax, 56h ; 'V'
    push    ax
    mov     ax, carmenu_buttons_x1+8
    inc     ax
    push    ax
    mov     ax, carmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, offset aBco ; "bco"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    mov     ax, framespersec
    mov     [bp+var_12], ax
    mov     framespersec, 14h
    mov     ax, 0FFFEh
    push    ax
    call    init_game_state
    add     sp, 2
    mov     state.playerstate.car_transmission, 1
    mov     [bp+var_4A], 0
loc_122CE:
    mov     ax, offset simd_player
    push    ax
    mov     ax, offset state.playerstate
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 1
    push    ax
    call    update_car_speed
    add     sp, 8
    mov     ax, state.playerstate.car_speed
    mov     cl, 8
    shr     ax, cl
    mov     [bp+var_carspeed], ax
    mov     ax, 96h ; 'ñ'
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_carspeed]
    cwd
    mov     cl, 6
loc_122FB:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_122FB
    push    dx
    push    ax
    call    __aFuldiv
    sub     ax, 0B5h ; 'µ'
    neg     ax
    mov     [bp+var_48], ax
    cmp     ax, 75h ; 'u'
    jb      short loc_12344
    mov     ax, 26h ; '&'
    imul    [bp+var_4A]
    sub     dx, dx
    mov     cx, 320h
    div     cx
    add     ax, 1Ch
    mov     [bp+var_44], ax
    push    performGraphColor
    push    [bp+var_48]
    push    ax
    call    putpixel_single_maybe
    add     sp, 6
    inc     [bp+var_4A]
    cmp     [bp+var_4A], 320h
    jl      short loc_122CE
loc_12344:
    mov     ax, [bp+var_12]
    mov     framespersec, ax
    push    word ptr fontnptr+2
    push    word ptr fontnptr
    call    font_set_fontdef2
    add     sp, 4
    mov     ax, offset aDes_1; "des"
    push    ax
    push    word ptr [bp+var_carres+2]
    push    word ptr [bp+var_carres]
    call    locate_text_res
    add     sp, 6
    mov     word ptr [bp+var_FC], ax
    mov     word ptr [bp+var_FC+2], dx
    mov     [bp+var_44], 0
    mov     [bp+var_48], 74h ; 't'
loc_1237E:
    les     bx, [bp+var_FC]
    inc     word ptr [bp+var_FC]
    mov     al, es:[bx]
    mov     [bp+var_1C], al
    cmp     al, 5Dh ; ']'
    jnz     short loc_123BE
    cmp     [bp+var_44], 0
    jz      short loc_123B1
    mov     bx, [bp+var_44]
    mov     resID_byte1[bx], 0
    push    [bp+var_48]
    mov     ax, 58h ; 'X'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
loc_123B1:
    mov     [bp+var_44], 0
    mov     ax, fontdef_unk_0E
    add     [bp+var_48], ax
    jmp     short loc_123CB
loc_123BE:
    mov     bx, [bp+var_44]
    inc     [bp+var_44]
    mov     al, [bp+var_1C]
    mov     resID_byte1[bx], al
loc_123CB:
    les     bx, [bp+var_FC]
    cmp     byte ptr es:[bx], 0
    jnz     short loc_1237E
    call    font_set_fontdef
    call    timer_get_delta_alt
    mov     [bp+var_F2], 0FFh
    mov     [bp+var_104_rc.rc_left], 0
    mov     [bp+var_104_rc.rc_right], 140h
    mov     [bp+var_104_rc.rc_top], 0
    mov     [bp+var_104_rc.rc_bottom], 0C8h ; '»'
    mov     [bp+var_108], 0
    mov     [bp+var_6], 3
loc_12405:
    mov     ax, [bp+var_rotationdelta]
    add     [bp+var_rotation], ax
    mov     al, [bp+var_6]
    cbw
    or      ax, ax
    jz      short loc_12423
    cmp     ax, 1
    jnz     short loc_1241B
    jmp     loc_125FE
loc_1241B:
    cmp     ax, 3
    jz      short loc_12423
    jmp     loc_124DE
loc_12423:
    push    carmenu_carpos.vz
    push    carmenu_carpos.vy
    call    polarAngle
    add     sp, 4
    mov     [bp+var_carpospolarangle], ax
    cmp     timertestflag_copy, 0
    jz      short loc_12448
    push    si
    lea     di, [bp+var_10_rc]
    mov     si, offset cliprect_unk
    jmp     short loc_1244F
    ; align 2
    db 144
loc_12448:
    push    si
    lea     di, [bp+var_10_rc]
    mov     si, offset carmenu_cliprect
loc_1244F:
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     si
    sub     ax, ax
    push    ax
    mov     ax, offset carmenu_cliprect
    push    ax
    sub     ax, ax
    push    ax
    push    [bp+var_carpospolarangle]
    push    ax
    call    select_cliprect_rotate
    add     sp, 0Ah
    mov     bx, [bp+arg_materialofs]
    mov     al, byte ptr game3dshapes.shape3d_numpaints+0AA8h
    cmp     [bx], al
    jl      short loc_1247A
    mov     byte ptr [bx], 0
loc_1247A:
    mov     ax, [bp+var_rotation]
    mov     [bp+var_transshape.ts_rotvec.vz], ax
    mov     bx, [bp+arg_materialofs]
    mov     al, [bx]
    mov     [bp+var_transshape.ts_material], al
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
    add     sp, 2
    mov     al, [bp+var_prevcaridindex]
    cmp     [bp+var_caridindex], al
    jnz     short loc_124A6
    mov     rect_unk16.rc_bottom, 5Fh ; '_'
    jmp     short loc_124AC
    ; align 2
    db 144
loc_124A6:
    mov     rect_unk16.rc_bottom, 0C8h ; '»'
loc_124AC:
    mov     ax, offset rect_unk16
    push    ax
    lea     ax, [bp+var_10_rc]
    push    ax
    call    rect_intersect
    add     sp, 4
    lea     ax, [bp+var_1A_rc]
    push    ax
    lea     ax, [bp+var_104_rc]
    push    ax
    lea     ax, [bp+var_10_rc]
    push    ax
    call    rect_union
    add     sp, 6
    cmp     [bp+var_6], 3
    jnz     short loc_124DA
    jmp     loc_125FE
loc_124DA:
    mov     [bp+var_6], 1
loc_124DE:
    mov     al, [bp+var_F2]
    cmp     [bp+var_106], al
    jz      short loc_12541
    cmp     al, 0FFh
    jz      short loc_12534
    call    sprite_copy_2_to_1_2
    mov     ax, carmenu_buttons_x2+8
    inc     ax
    push    ax
    push    carmenu_buttons_x1
    mov     ax, carmenu_buttons_y2
loc_124FD:
    add     ax, video_flag2_is1
    and     ax, video_flag3_isFFFF
    push    ax
    push    carmenu_buttons_y1
    call    sprite_set_1_size
    add     sp, 8
    call    mouse_draw_opaque_check
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
    call    mouse_draw_transparent_check
    call    sprite_copy_2_to_1_2
loc_12534:
    call    sub_29772
    mov     al, [bp+var_106]
    mov     [bp+var_F2], al
loc_12541:
    call    sprite_copy_2_to_1_2
    push    word_407D0
    push    word_407CE
    mov     ax, offset carmenu_buttons_x2
    push    ax
    mov     ax, offset carmenu_buttons_x1
    push    ax
    mov     ax, offset carmenu_buttons_y2
    push    ax
    mov     ax, offset carmenu_buttons_y1
    push    ax
    mov     al, [bp+var_106]
    cbw
    push    ax
    call    mouse_timer_sprite_unk
    add     sp, 0Eh
    mov     [bp+var_rotationdelta], ax
    add     idle_counter, ax
    cmp     idle_counter, 2EE0h
    jle     short loc_12585
    mov     idle_counter, 0
    inc     idle_expired
loc_12585:
    push    [bp+var_rotationdelta]
    call    input_checking
    add     sp, 2
    mov     si, ax
    mov     ax, offset carmenu_buttons_x2
    push    ax
    mov     ax, offset carmenu_buttons_x1
    push    ax
    mov     ax, offset carmenu_buttons_y2
    push    ax
    mov     ax, offset carmenu_buttons_y1
    push    ax
    mov     ax, 5
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_F6], al
    cmp     al, 0FFh
    jz      short loc_125BA
    mov     [bp+var_106], al
loc_125BA:
    cmp     idle_expired, 0
    jz      short loc_125C9
    mov     [bp+var_106], 0
    mov     si, 0Dh
loc_125C9:
    or      si, si
    jnz     short loc_125D0
    jmp     loc_11FA5
loc_125D0:
    mov     ax, si
    cmp     ax, 0Dh
    jnz     short loc_125DA
    jmp     loc_12732
loc_125DA:
    cmp     ax, 1Bh
    jnz     short loc_125E2
    jmp     loc_12732
loc_125E2:
    cmp     ax, 20h ; ' '
    jnz     short loc_125EA
    jmp     loc_12732
loc_125EA:
    cmp     ax, 4800h
    jnz     short loc_125F2
    jmp     loc_12910
loc_125F2:
    cmp     ax, 5000h
    jnz     short loc_125FA
    jmp     loc_12926
loc_125FA:
    jmp     loc_11FA5
    ; align 2
    db 144
loc_125FE:
    mov     [bp+var_6], 0
    mov     [bp+var_108], 1
    call    sprite_copy_wnd_to_1
    push    [bp+var_1A_rc.rc_bottom]
    push    [bp+var_1A_rc.rc_top]
    push    [bp+var_1A_rc.rc_right]
    push    [bp+var_1A_rc.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    mov     ax, offset aStop_1; "stop"
    push    ax
    push    [bp+var_34]
    push    [bp+var_36]
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sprite_putimage
    add     sp, 4
    call    get_a_poly_info
    call    sprite_copy_wnd_to_1
    push    [bp+var_1A_rc.rc_bottom]
    push    [bp+var_1A_rc.rc_top]
    push    [bp+var_1A_rc.rc_right]
    push    [bp+var_1A_rc.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    push    si
    lea     di, [bp+var_104_rc]
    lea     si, [bp+var_10_rc]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     si
    cmp     [bp+arg_opponenttype], 0
    jz      short loc_126D1
    mov     al, [bp+var_prevcaridindex]
    cmp     [bp+var_caridindex], al
    jz      short loc_126D1
    call    sprite_copy_wnd_to_1
    cmp     video_flag5_is0, 0
    jnz     short loc_126B8
    mov     al, byte ptr [bp+arg_opponenttype]
    add     al, 30h ; '0'
    cbw
    push    ax
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    nullsub_2
    add     sp, 6
    sub     ax, ax
    push    ax
    mov     ax, 0F0h ; ''
    push    ax
    mov     bx, [bp+arg_opponenttype]
    shl     bx, 1
    shl     bx, 1
    push    word ptr (oppresources+2)[bx]
    push    word ptr oppresources[bx]
    call    sprite_putimage_transparent
    jmp     short loc_126CE
loc_126B8:
    sub     ax, ax
    push    ax
    mov     ax, 0F0h ; ''
    push    ax
    les     bx, [bp+var_42wnd]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage_and_alt
loc_126CE:
    add     sp, 8
loc_126D1:
    call    sprite_copy_2_to_1_2
    push    [bp+var_1A_rc.rc_bottom]
    push    [bp+var_1A_rc.rc_top]
    push    [bp+var_1A_rc.rc_right]
    push    [bp+var_1A_rc.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    call    mouse_draw_opaque_check
    cmp     [bp+var_3E], 0FEh ; '˛'
    jz      short loc_12710
    mov     al, [bp+var_3E]
    cbw
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     [bp+var_3E], 0FEh ; '˛'
    jmp     short loc_12723
loc_12710:
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
loc_12723:
    call    mouse_draw_transparent_check
    mov     al, [bp+var_caridindex]
    mov     [bp+var_prevcaridindex], al
    jmp     loc_124DE
loc_12732:
    mov     al, [bp+var_106]
    cbw
    or      ax, ax
    jz      short _menu_done
    cmp     ax, 1
    jnz     short loc_12743
    jmp     _menu_nextcar
loc_12743:
    cmp     ax, 2
    jnz     short loc_1274B
    jmp     _menu_prevcar
loc_1274B:
    cmp     ax, 3
    jnz     short loc_12753
    jmp     _menu_transmission
loc_12753:
    cmp     ax, 4
    jnz     short loc_1275B
    jmp     _menu_color
loc_1275B:
    jmp     loc_11FA5
_menu_done:
    cmp     [bp+var_108], 0
    jnz     short loc_12768
    jmp     loc_11FA5
loc_12768:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    push    word ptr [bp+var_carres+2]
    push    word ptr [bp+var_carres]
    call    unload_resource
    add     sp, 4
    call    shape3d_free_car_shapes
    cmp     [bp+arg_opponenttype], 0
    jz      short loc_127A6
    cmp     video_flag5_is0, 0
    jz      short loc_127A6
    push    word ptr [bp+var_42wnd+2]
    push    word ptr [bp+var_42wnd]
    call    sprite_free_wnd
    add     sp, 4
loc_127A6:
    cmp     [bp+arg_opponenttype], 0
    jnz     short loc_127BC
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    unload_resource
    add     sp, 4
loc_127BC:
    push    [bp+var_34]
    push    [bp+var_36]
    call    mmgr_free
    add     sp, 4
    call    mouse_draw_opaque_check
    mov     al, [bp+var_caridindex]
    cbw
    mov     di, ax
    shl     di, 1
    shl     di, 1
    add     di, ax
    mov     al, [bp+di+var_carids]
    mov     bx, [bp+arg_caridptr]
    mov     [bx], al
    mov     al, [bp+var_caridindex]
    cbw
    mov     di, ax
    shl     di, 1
    shl     di, 1
    add     di, ax
    mov     al, [bp+di+var_carids+1]
    mov     bx, [bp+arg_caridptr]
    mov     [bx+1], al
    mov     al, [bp+var_caridindex]
    cbw
    mov     di, ax
    shl     di, 1
    shl     di, 1
    add     di, ax
    mov     al, [bp+di+var_carids+2]
    mov     bx, [bp+arg_caridptr]
    mov     [bx+2], al
    mov     al, [bp+var_caridindex]
    cbw
    mov     di, ax
    shl     di, 1
    shl     di, 1
    add     di, ax
    mov     al, [bp+di+var_carids+3]
    mov     bx, [bp+arg_caridptr]
    mov     [bx+3], al
    mov     idle_expired, 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
_menu_nextcar:
    inc     [bp+var_caridindex]
    mov     al, [bp+var_46]
    cmp     [bp+var_caridindex], al
    jz      short loc_12846
    jmp     loc_11FA5
loc_12846:
    mov     [bp+var_caridindex], 0
    jmp     loc_11FA5
_menu_prevcar:
    dec     [bp+var_caridindex]
    js      short loc_12857
    jmp     loc_11FA5
loc_12857:
    mov     al, [bp+var_46]
    dec     al
    mov     [bp+var_caridindex], al
    jmp     loc_11FA5
    ; align 2
    db 144
_menu_transmission:
    mov     bx, [bp+arg_transmissionofs]
    xor     byte ptr [bx], 1
    call    sprite_copy_wnd_to_1
    mov     bx, [bp+arg_transmissionofs]
    cmp     byte ptr [bx], 0
    jz      short loc_1287C
    mov     ax, offset aBau_0; "bau"
    jmp     short loc_1287F
loc_1287C:
    mov     ax, offset aBma_0; "bma"
loc_1287F:
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    mov     [bp+var_3C], ax
    mov     [bp+var_3A], dx
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 10h
    push    ax
    mov     ax, 56h ; 'V'
    push    ax
    mov     ax, carmenu_buttons_x1+6
    inc     ax
    push    ax
    mov     ax, carmenu_buttons_y1
    inc     ax
    push    ax
    push    dx
    push    [bp+var_3C]
    call    draw_button
    add     sp, 14h
    call    sprite_copy_2_to_1_2
    call    mouse_draw_opaque_check
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 10h
    push    ax
    mov     ax, 56h ; 'V'
    push    ax
    mov     ax, carmenu_buttons_x1+6
    inc     ax
    push    ax
    mov     ax, carmenu_buttons_y1
    inc     ax
    push    ax
    push    [bp+var_3A]
    push    [bp+var_3C]
    call    draw_button
    add     sp, 14h
    call    mouse_draw_transparent_check
    jmp     loc_11FA5
_menu_color:
    mov     bx, [bp+arg_materialofs]
    inc     byte ptr [bx]   ; change color/material
    mov     [bp+var_6], 3
    jmp     loc_11FA5
loc_12910:
    cmp     [bp+var_106], 0
    jz      short loc_1291E
    dec     [bp+var_106]
    jmp     loc_11FA5
loc_1291E:
    mov     [bp+var_106], 4
    jmp     loc_11FA5
loc_12926:
    cmp     [bp+var_106], 4
    jge     short loc_12934
    inc     [bp+var_106]
    jmp     loc_11FA5
loc_12934:
    mov     [bp+var_106], 0
    jmp     loc_11FA5
run_car_menu endp
run_opponent_menu proc far
    var_1E = byte ptr -30
    var_1C = byte ptr -28
    var_1A = dword ptr -26
    var_16 = byte ptr -22
    var_14 = byte ptr -20
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = byte ptr -6
    var_4 = byte ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 1Eh
    push    si
    mov     ax, 4
    push    ax
    call    ensure_file_exists
    add     sp, 2
    mov     ax, offset aMisc; "misc"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     word ptr miscptr, ax
    mov     word ptr miscptr+2, dx
    mov     ax, offset aSdosel; "sdosel"
    push    ax              ; char *
    mov     ax, 8
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr opp_res, ax
    mov     word ptr opp_res+2, dx
    mov     ax, offset oppresources
    push    ax
    mov     ax, offset aOpp0opp1opp2op; "opp0opp1opp2opp3opp4opp5opp6"
    push    ax
    push    dx
    push    word ptr opp_res
    call    locate_many_resources
    add     sp, 8
    mov     [bp+var_1C], 0
    mov     [bp+var_6], 0
    mov     [bp+var_1E], 0FFh
    mov     [bp+var_4], 0FFh
    call    sub_29772
loc_129A3:
    call    mouse_draw_transparent_check
loc_129A8:
    mov     al, gameconfig.game_opponenttype
    cmp     [bp+var_1E], al
    jnz     short loc_129B3
    jmp     loc_12CFB
loc_129B3:
    cmp     [bp+var_1E], 0FFh
    jz      short loc_129DD
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    cmp     [bp+var_6], 0
    jz      short loc_129DD
    push    [bp+var_A]
    push    [bp+var_C]
    call    unload_resource
    add     sp, 4
loc_129DD:
    mov     ax, 4
    push    ax
    call    ensure_file_exists
    add     sp, 2
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_12A10
    mov     al, gameconfig.game_opponenttype
    add     al, 30h ; '0'
    mov     byte ptr aOpp1+3, al
    mov     ax, offset aOpp1; "opp1"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_C], ax
    mov     [bp+var_A], dx
    mov     [bp+var_6], 1
    jmp     short loc_12A14
loc_12A10:
    mov     [bp+var_6], 0
loc_12A14:
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
    mov     al, gameconfig.game_opponenttype
    mov     [bp+var_1E], al
    mov     [bp+var_14], 0FFh
    cmp     video_flag5_is0, 0
    jnz     short loc_12A48
    call    sprite_copy_wnd_to_1
    jmp     short loc_12A4D
    ; align 2
    db 144
loc_12A48:
    call    setup_mcgawnd2
loc_12A4D:
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    mov     ax, 37h ; '7'
    push    ax
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    nullsub_2
    add     sp, 6
    mov     ax, offset aScrn_0; "scrn"
    push    ax
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sub_34526
    add     sp, 4
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 12h
    push    ax
    mov     ax, 36h ; '6'
    push    ax
    mov     ax, opponentmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, 15h
    push    ax
    mov     ax, offset aBla ; "bla"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 12h
    push    ax
    mov     ax, 36h ; '6'
    push    ax
    mov     ax, opponentmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, 4Dh ; 'M'
    push    ax
    mov     ax, offset aBnx ; "bnx"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 12h
    push    ax
    mov     ax, 36h ; '6'
    push    ax
    mov     ax, opponentmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, 85h ; 'Ö'
    push    ax
    mov     ax, offset aBcl ; "bcl"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 12h
    push    ax
    mov     ax, 36h ; '6'
    push    ax
    mov     ax, opponentmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, 0BDh ; 'Ω'
    push    ax
    mov     ax, offset aBca ; "bca"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 12h
    push    ax
    mov     ax, 36h ; '6'
    push    ax
    mov     ax, opponentmenu_buttons_y1
    inc     ax
    push    ax
    mov     ax, 0F5h ; 'ı'
    push    ax
    mov     ax, offset aBdo ; "bdo"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    mov     al, gameconfig.game_opponenttype
    add     al, 30h ; '0'
    cbw
    push    ax
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    nullsub_2
    add     sp, 6
    mov     al, gameconfig.game_opponenttype
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (oppresources+2)[bx]
    push    word ptr oppresources[bx]
    call    sub_34526
    add     sp, 4
    mov     ax, 37h ; '7'
    push    ax
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    nullsub_2
    add     sp, 6
    mov     ax, offset aClip; "clip"
    push    ax
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    sub_34526
    add     sp, 4
    cmp     video_flag5_is0, 0
    jz      short loc_12C46
    sub     ax, ax
    push    ax
    push    ax
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_clear_shape_alt
    add     sp, 8
    call    sprite_copy_wnd_to_1
loc_12C46:
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_12C5A
    mov     ax, offset aDes_0; "des"
    push    ax
    push    [bp+var_A]
    push    [bp+var_C]
    jmp     short loc_12C66
    ; align 2
    db 144
loc_12C5A:
    mov     ax, offset aRac ; "rac"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
loc_12C66:
    call    locate_text_res
    add     sp, 6
    mov     word ptr [bp+var_1A], ax
    mov     word ptr [bp+var_1A+2], dx
    push    word ptr fontnptr+2
    push    word ptr fontnptr
    call    font_set_fontdef2
    add     sp, 4
    push    dialog_fnt_colour
    sub     ax, ax
    push    ax
    call    font_set_unk
    add     sp, 4
    mov     [bp+var_8], 0
    mov     [bp+var_E], 0
loc_12C9D:
    les     bx, [bp+var_1A]
    inc     word ptr [bp+var_1A]
    mov     al, es:[bx]
    mov     [bp+var_2], al
    cmp     al, 5Dh ; ']'
    jnz     short loc_12CE0
    cmp     [bp+var_8], 0
    jz      short loc_12CD2
    mov     bx, [bp+var_8]
    mov     resID_byte1[bx], 0
    mov     ax, [bp+var_E]
    add     ax, 21h ; '!'
    push    ax
    mov     ax, 0Ch
    push    ax
    mov     ax, 0AC74h
    push    ax
    call    font_draw_text
    add     sp, 6
loc_12CD2:
    mov     [bp+var_8], 0
    mov     ax, fontdef_unk_0E
    add     [bp+var_E], ax
    jmp     short loc_12CED
    ; align 2
    db 144
loc_12CE0:
    mov     bx, [bp+var_8]
    inc     [bp+var_8]
    mov     al, [bp+var_2]
    mov     resID_byte1[bx], al
loc_12CED:
    les     bx, [bp+var_1A]
    cmp     byte ptr es:[bx], 0
    jnz     short loc_12C9D
    call    font_set_fontdef
loc_12CFB:
    mov     al, [bp+var_14]
    cmp     [bp+var_1C], al
    jz      short loc_12D2C
    mov     al, [bp+var_1C]
    mov     [bp+var_14], al
    mov     al, [bp+var_4]
    cbw
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     [bp+var_4], 0FEh ; '˛'
    call    timer_get_delta_alt
    call    sub_29772
loc_12D2C:
    push    word_407D0
    push    word_407CE
    mov     ax, 462h
    push    ax
    mov     ax, 458h
    push    ax
    mov     ax, 44Eh
    push    ax
    mov     ax, 444h
    push    ax
    mov     al, [bp+var_1C]
    cbw
    push    ax
    call    mouse_timer_sprite_unk
    add     sp, 0Eh
    mov     [bp+var_10], ax
    push    ax
    call    input_checking
    add     sp, 2
    mov     si, ax
    mov     ax, offset opponentmenu_buttons_y2
    push    ax
    mov     ax, offset opponentmenu_buttons_y1
    push    ax
    mov     ax, offset opponentmenu_buttons_x2
    push    ax
    mov     ax, offset opponentmenu_buttons_x1
    push    ax
    mov     ax, 5
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_16], al
    cmp     al, 0FFh
    jz      short loc_12D93
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_12D8D
    cmp     al, 3
    jz      short loc_12D93
loc_12D8D:
    mov     al, [bp+var_16]
    mov     [bp+var_1C], al
loc_12D93:
    or      si, si
    jnz     short loc_12D9A
    jmp     loc_129A8
loc_12D9A:
    mov     ax, si
    cmp     ax, 0Dh
    jz      short loc_12DBE
    cmp     ax, 1Bh
    jz      short loc_12DBE
    cmp     ax, 20h ; ' '
    jz      short loc_12DBE
    cmp     ax, 4B00h
    jnz     short loc_12DB3
    jmp     loc_12EF6
loc_12DB3:
    cmp     ax, 4D00h
    jnz     short loc_12DBB
    jmp     loc_12F20
loc_12DBB:
    jmp     loc_129A8
loc_12DBE:
    mov     al, [bp+var_1C]
    cbw
    or      ax, ax
    jz      short loc_12DE0
    cmp     ax, 1
    jz      short loc_12DF6
    cmp     ax, 2
    jz      short loc_12E0C
    cmp     ax, 3
    jz      short loc_12E14
    cmp     ax, 4
    jnz     short loc_12DDD
    jmp     loc_12E6A
loc_12DDD:
    jmp     loc_129A8
loc_12DE0:
    dec     gameconfig.game_opponenttype
    cmp     gameconfig.game_opponenttype, 1
    jl      short loc_12DEE
    jmp     loc_129A8
loc_12DEE:
    mov     gameconfig.game_opponenttype, 6
    jmp     loc_129A8
loc_12DF6:
    inc     gameconfig.game_opponenttype
    cmp     gameconfig.game_opponenttype, 7
    jz      short loc_12E04
    jmp     loc_129A8
loc_12E04:
    mov     gameconfig.game_opponenttype, 1
    jmp     loc_129A8
loc_12E0C:
    mov     gameconfig.game_opponenttype, 0
    jmp     loc_129A8
loc_12E14:
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_12E1E
    jmp     loc_129A8
loc_12E1E:
    call    check_input
    call    mouse_draw_opaque_check
loc_12E28:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    push    [bp+var_A]
    push    [bp+var_C]
    call    unload_resource
    add     sp, 4
    call    show_waiting
    mov     al, gameconfig.game_opponenttype
    cbw
    push    ax
    mov     ax, offset gameconfig.game_opponenttransmission
    push    ax
    mov     ax, offset gameconfig.game_opponentmaterial
    push    ax
    mov     ax, offset gameconfig.game_opponentcarid
    push    ax
    push    cs
    call near ptr run_car_menu
    add     sp, 8
    mov     [bp+var_1E], 0FFh
    jmp     loc_129A3
loc_12E6A:
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_12EA2
    cmp     gameconfig.game_opponentcarid, 0FFh
    jnz     short loc_12EA7
    mov     al, gameconfig.game_playercarid
    mov     gameconfig.game_opponentcarid, al
    mov     al, gameconfig.game_playercarid+1
    mov     gameconfig.game_opponentcarid+1, al
    mov     al, gameconfig.game_playercarid+2
    mov     gameconfig.game_opponentcarid+2, al
    mov     al, gameconfig.game_playercarid+3
    mov     gameconfig.game_opponentcarid+3, al
    mov     al, gameconfig.game_playermaterial
smart
    and     al, 1
nosmart
    xor     al, 1
    mov     gameconfig.game_opponentmaterial, al
    mov     gameconfig.game_opponenttransmission, 0
    jmp     short loc_12EA7
    ; align 2
    db 144
loc_12EA2:
    mov     gameconfig.game_opponentcarid, 0FFh
loc_12EA7:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    cmp     [bp+var_6], 0
    jz      short loc_12ECB
    push    [bp+var_A]
    push    [bp+var_C]
    call    unload_resource
    add     sp, 4
loc_12ECB:
    push    word ptr opp_res+2
    push    word ptr opp_res
    call    mmgr_free
    add     sp, 4
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    unload_resource
    add     sp, 4
    call    mouse_draw_opaque_check
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_12EF6:
    cmp     [bp+var_1C], 0
    jz      short loc_12F02
    dec     [bp+var_1C]
    jmp     short loc_12F06
    ; align 2
    db 144
loc_12F02:
    mov     [bp+var_1C], 4
loc_12F06:
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_12F10
    jmp     loc_129A8
loc_12F10:
    cmp     [bp+var_1C], 3
    jz      short loc_12F19
    jmp     loc_129A8
loc_12F19:
    dec     [bp+var_1C]
    jmp     loc_129A8
    ; align 2
    db 144
loc_12F20:
    cmp     [bp+var_1C], 4
    jge     short loc_12F2C
    inc     [bp+var_1C]
    jmp     short loc_12F30
    ; align 2
    db 144
loc_12F2C:
    mov     [bp+var_1C], 0
loc_12F30:
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_12F3A
    jmp     loc_129A8
loc_12F3A:
    cmp     [bp+var_1C], 3
    jz      short loc_12F43
    jmp     loc_129A8
loc_12F43:
    inc     [bp+var_1C]
    jmp     loc_129A8
    ; align 2
    db 144
run_opponent_menu endp
run_option_menu proc far
    var_6 = byte ptr -6
    var_4 = byte ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    mov     ax, offset aMisc_1; "misc"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     word ptr miscptr, ax
    mov     word ptr miscptr+2, dx
    call    sprite_copy_2_to_1_2
    push    word_407FA
    call    sprite_clear_1_color
    add     sp, 2
    mov     ax, offset aGstu; "gstu"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 6
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
loc_12FBA:
    mov     ax, offset aGver; "gver"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_shape_alt
    add     sp, 6
loc_12FCE:
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
loc_12FDF:
    push    dialog_fnt_colour
    mov     ax, 10h
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
loc_12FF4:
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    mov     [bp+var_4], 1
loc_13004:
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMop ; "mop"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 2
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     [bp+var_2], al
    cbw
    sub     ax, 0FFFFh
    cmp     ax, 7
    jbe     short loc_13046
    jmp     loc_1315A
loc_13046:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_1314A[bx]
loc_1304E:
    cmp     byte_3B8F2, 0
    jz      short loc_1305C
    mov     [bp+var_6], 2
    jmp     short loc_1306E
    ; align 2
    db 144
loc_1305C:
    cmp     byte_3FE00, 0
    jz      short loc_1306A
    mov     [bp+var_6], 1
    jmp     short loc_1306E
    ; align 2
    db 144
loc_1306A:
    mov     [bp+var_6], 0
loc_1306E:
    mov     al, [bp+var_6]
    cbw
    push    ax
    sub     ax, ax
    push    ax
    push    performGraphColor
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMid ; "mid"
    push    ax
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 2
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     [bp+var_2], al
    cbw
    or      ax, ax
    jz      short loc_130BA
    cmp     ax, 1
    jz      short loc_130C2
    cmp     ax, 2
    jz      short loc_130CA
    jmp     loc_1315A
loc_130BA:
    call    do_key_restext
    jmp     loc_1315A
loc_130C2:
    call    do_joy_restext
    jmp     loc_1315A
loc_130CA:
    call    do_mou_restext
    jmp     loc_1315A
loc_130D2:
    call    do_mof_restext
    jmp     loc_1315A
loc_130DA:
    call    do_sonsof_restext
    jmp     short loc_1315A
    ; align 2
    db 144
loc_130E2:
    mov     ax, offset aRep_0; "rep"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx              ; int
    push    ax              ; int
    mov     ax, offset a_rpl_0; ".rpl"
    push    ax              ; int
    mov     ax, offset aDefault_1; "DEFAULT"
    push    ax
    mov     ax, offset byte_3B85E
    push    ax              ; char *
    call    do_fileselect_dialog
    add     sp, 0Ah
    mov     [bp+var_6], al
    or      al, al
    jz      short loc_1315A
    mov     waitflag, 96h ; 'ñ'
    call    show_waiting
    mov     ax, offset aDefault_1; "DEFAULT"
    push    ax
    mov     ax, offset byte_3B85E
    push    ax              ; char *
    call    file_load_replay
    add     sp, 4
    mov     [bp+var_4], 1
    jmp     short loc_13163
loc_13134:
    call    do_mrl_textres
    jmp     short loc_1315A
    ; align 2
    db 144
loc_1313C:
    call    do_dos_restext
    jmp     short loc_1315A
    ; align 2
    db 144
loc_13144:
    mov     [bp+var_4], 0
    jmp     short loc_1315A
off_1314A     dw offset loc_13144
    dw offset loc_1304E
    dw offset loc_130D2
    dw offset loc_130DA
    dw offset loc_130E2
    dw offset loc_13134
    dw offset loc_1313C
    dw offset loc_13144
loc_1315A:
    cmp     [bp+var_4], 0
    jz      short loc_13163
    jmp     loc_13004
loc_13163:
    push    word ptr miscptr+2
    push    word ptr miscptr
    call    unload_resource
    mov     al, [bp+var_4]
    cbw
    mov     sp, bp
    pop     bp
    retf
run_option_menu endp
end_hiscore proc far
    var_9E = word ptr -158
    var_9C = word ptr -156
    var_9A = byte ptr -154
    var_98 = byte ptr -152
    var_selectedmenu = byte ptr -146
    var_90 = word ptr -144
    var_8E = byte ptr -142
    var_8C = word ptr -140
    var_8A = word ptr -138
    var_88 = word ptr -136
    var_86 = dword ptr -134
    var_menuhit = byte ptr -130
    var_80 = word ptr -128
    var_7E = word ptr -126
    var_7C = word ptr -124
    var_7A = word ptr -122
    var_78 = byte ptr -120
    var_72 = word ptr -114
    var_70 = word ptr -112
    var_6E = byte ptr -110
    var_6C = byte ptr -108
    var_6A = byte ptr -106
    var_68 = word ptr -104
    var_66 = word ptr -102
    var_64 = byte ptr -100
    var_62 = byte ptr -98
    var_5C = word ptr -92
    var_5A = word ptr -90
    var_58 = word ptr -88
    var_56 = dword ptr -86
    var_52 = byte ptr -82
    var_50 = word ptr -80
    var_4E = word ptr -78
    var_4C = word ptr -76
    var_4A = dword ptr -74
    var_46 = dword ptr -70
    var_42 = word ptr -66
    var_40 = word ptr -64
    var_3E = byte ptr -62
    var_3C = byte ptr -60
    var_1C = word ptr -28
    var_1A = word ptr -26
    var_18 = byte ptr -24
    var_16 = byte ptr -22
    var_14 = byte ptr -20
    var_12 = byte ptr -18
    var_11 = byte ptr -17
    var_10 = byte ptr -16
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 9Eh
    push    di
    push    si
    mov     ax, 4
    push    ax
    call    ensure_file_exists
    add     sp, 2
    mov     ax, offset aMisc_2; "misc"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_4E], ax
    mov     [bp+var_4C], dx
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_131C0
    mov     al, gameconfig.game_opponenttype
    add     al, 30h ; '0'
    mov     byte ptr aOpp1+3, al
    mov     ax, offset aOpp1; "opp1"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_68], ax
    mov     [bp+var_66], dx
loc_131C0:
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
    cmp     video_flag5_is0, 0
    jz      short loc_131FC
    mov     ax, 0Fh
    push    ax
    mov     ax, 64h ; 'd'
    push    ax
    mov     ax, 0C8h ; '»'
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr [bp+var_46], ax
    mov     word ptr [bp+var_46+2], dx
loc_131FC:
    mov     [bp+var_52], 0FFh
    call    sprite_copy_wnd_to_1_clear
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 64h ; 'd'
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    push    ax
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 63h ; 'c'
    push    ax
    mov     ax, 140h
    push    ax
    mov     ax, 65h ; 'e'
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    call    draw_button
    add     sp, 14h
    mov     [bp+var_70], 6Bh ; 'k'
    mov     ax, offset aElt ; "elt"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    cmp     gState_total_finish_time, 0
    jnz     short loc_13281
    jmp     loc_13354
loc_13281:
    mov     ax, 1
    push    ax              ; int
    mov     ax, gState_total_finish_time
    sub     ax, gState_penalty
    push    ax
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    test    byte_43966, 2
    jz      short loc_132DC
    mov     ax, offset aCon ; "con"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    add     ax, offset resID_byte1
    push    ax
loc_132D4:
    call    copy_string
    add     sp, 6
loc_132DC:
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    push    [bp+var_70]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    add     [bp+var_70], 0Ah
    cmp     gState_penalty, 0
    jnz     short loc_1330D
    jmp     loc_133A7
loc_1330D:
    mov     ax, offset aPpt ; "ppt"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, 1
    push    ax              ; int
    push    gState_penalty
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    jmp     short loc_13380
    ; align 2
    db 144
loc_13354:
    mov     ax, offset aDnf ; "dnf"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    add     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
loc_13380:
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    push    [bp+var_70]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    add     [bp+var_70], 0Ah
loc_133A7:
    mov     [bp+var_18], 2
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_133B5
    jmp     loc_134DC
loc_133B5:
    cmp     gState_144, 0
    jnz     short loc_1340C
    mov     ax, offset aOlt ; "olt"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, offset aDnf_0; "dnf"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    add     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    jmp     loc_134AA
    ; align 2
    db 144
loc_1340C:
    cmp     gState_total_finish_time, 0
    jz      short loc_1341C
    mov     ax, gState_total_finish_time
    cmp     gState_144, ax
    jnb     short loc_13466
loc_1341C:
    mov     ax, offset aOwt ; "owt"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, 1
    push    ax              ; int
    push    gState_144
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    mov     [bp+var_18], 1
    jmp     short loc_134B5
loc_13466:
    mov     ax, offset aOlt_0; "olt"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, 1
    push    ax              ; int
    push    gState_144
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
loc_134AA:
    cmp     gState_total_finish_time, 0
    jz      short loc_134B5
    mov     [bp+var_18], 0
loc_134B5:
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    push    [bp+var_70]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    add     [bp+var_70], 0Ah
loc_134DC:
    cmp     [bp+var_18], 0
    jnz     short loc_134F0
    mov     ax, offset aVict; "VICT"
    push    ax
    mov     ax, offset aSkidms_1; "skidms"
    push    ax
    mov     ax, offset aSkidvict; "skidvict"
    jmp     short loc_134FB
    ; align 2
    db 144
loc_134F0:
    mov     ax, offset aOver; "OVER"
    push    ax
    mov     ax, offset aSkidms_2; "skidms"
    push    ax
    mov     ax, offset aSkidover; "skidover"
loc_134FB:
    push    ax              ; char *
    call    file_load_audiores
    add     sp, 6
    mov     al, gameconfig.game_opponenttype
    mov     [bp+var_16], al
    cmp     [bp+var_18], 2
    jnz     short loc_1351D
    mov     ax, gState_pEndFrame
    cmp     gState_oEndFrame, ax
    jz      short loc_1351D
    mov     [bp+var_16], 0
loc_1351D:
    mov     ax, offset aAvs ; "avs"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, gState_pEndFrame
    add     ax, elapsed_time1
    jz      short loc_1356A
    mov     ax, gState_pEndFrame
    add     ax, elapsed_time1
    sub     cx, cx
    push    cx
    push    ax
    push    word ptr gState_travDist+2
    push    word ptr gState_travDist
    call    __aFuldiv
    mov     al, ah
    mov     ah, dl
    mov     dl, dh
    sub     dh, dh
    mov     di, ax
    jmp     short loc_1356C
loc_1356A:
    sub     di, di
loc_1356C:
    mov     ax, 3
    push    ax              ; int
    sub     ax, ax
    push    ax              ; int
    push    di
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    print_int_as_string_maybe
    add     sp, 8
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    mov     ax, offset aMph ; "mph"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    add     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    push    [bp+var_70]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    add     [bp+var_70], 0Ah
    cmp     gState_impactSpeed, 0
    jnz     short loc_135ED
    jmp     loc_1368B
loc_135ED:
    mov     ax, offset aImp ; "imp"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, 3
    push    ax              ; int
    sub     ax, ax
    push    ax              ; int
    mov     ax, gState_impactSpeed
    mov     cl, 8
    shr     ax, cl
    push    ax
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    print_int_as_string_maybe
    add     sp, 8
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    mov     ax, offset aMph_0; "mph"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    add     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    push    [bp+var_70]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    add     [bp+var_70], 0Ah
loc_1368B:
    mov     ax, offset aTop ; "top"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, 3
    push    ax              ; int
    sub     ax, ax
    push    ax              ; int
    mov     ax, gState_topSpeed
    mov     cl, 8
    shr     ax, cl
    push    ax
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    print_int_as_string_maybe
    add     sp, 8
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    mov     ax, offset aMph_1; "mph"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    add     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    push    [bp+var_70]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
    add     [bp+var_70], 0Ah
    cmp     gState_jumpCount, 0
    jz      short loc_1379A
    mov     ax, offset aJum ; "jum"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, 3
    push    ax              ; int
    sub     ax, ax
    push    ax              ; int
    push    gState_jumpCount
    lea     ax, [bp+var_12]
    push    ax              ; char *
    call    print_int_as_string_maybe
    add     sp, 8
    lea     ax, [bp+var_12]
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    push    [bp+var_70]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    hiscore_draw_text
    add     sp, 0Ah
loc_1379A:
    cmp     [bp+var_16], 0
    jnz     short loc_137A3
    jmp     loc_138FF
loc_137A3:
    test    byte_43966, 4
    jz      short loc_137AD
    jmp     loc_1384B
loc_137AD:
    mov     ax, word_40D40
    mov     word_40D3A, ax
    mov     ax, end_hiscore_random
    mov     word_40D3C, ax
    mov     ax, word_40D44
    mov     word_40D3E, ax
    call    get_super_random
    cwd
    mov     cx, 3
    idiv    cx
    mov     word_40D40, dx
    mov     ax, word_40D3A
    cmp     dx, ax
    jnz     short loc_137E0
    mov     bx, dx
    shl     bx, 1
    mov     ax, word_3BCDE[bx]
    mov     word_40D40, ax
loc_137E0:
    call    get_super_random
    cwd
    mov     cx, 3
    idiv    cx
    mov     word_40D44, dx
    mov     ax, word_40D3E
    cmp     dx, ax
    jnz     short loc_13801
    mov     bx, dx
    shl     bx, 1
    mov     ax, word_3BCDE[bx]
    mov     word_40D44, ax
loc_13801:
    cmp     [bp+var_18], 1
    jnz     short loc_1382A
    cmp     gState_total_finish_time, 0
    jz      short loc_1381E
    call    get_super_random
    cwd
    mov     cx, 2
    idiv    cx
    add     dx, cx
    jmp     short loc_13835
    ; align 2
    db 144
loc_1381E:
    call    get_super_random
    cwd
    mov     cx, 2
    jmp     short loc_13833
    ; align 2
    db 144
loc_1382A:
    call    get_super_random
    cwd
    mov     cx, 4
loc_13833:
    idiv    cx
loc_13835:
    mov     end_hiscore_random, dx
    mov     ax, word_40D3C
    cmp     dx, ax
    jnz     short loc_1384B
    mov     bx, dx
    shl     bx, 1
    mov     ax, word_3BCE4[bx]
    mov     end_hiscore_random, ax
loc_1384B:
    cmp     [bp+var_18], 1
    jnz     short loc_138B6
    mov     al, gameconfig.game_opponenttype
    add     al, 30h ; '0'
    mov     byte ptr aOpp2win+3, al
    mov     ax, offset aOpp2win; "opp2win"
    push    ax              ; char *
    mov     ax, 3
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     [bp+var_1C], ax
    mov     [bp+var_1A], dx
    mov     ax, offset aWinn; "winn"
    push    ax
    push    [bp+var_66]
    push    [bp+var_68]
    call    locate_shape_alt
    add     sp, 6
    mov     [bp+var_5A], ax
    mov     [bp+var_58], dx
    cmp     gState_total_finish_time, 0
    jz      short loc_138A0
    call    get_kevinrandom
    add     ax, gState_frame
smart
    and     ax, 1
nosmart
    add     ax, 2
    jmp     short loc_138AC
    ; align 2
    db 144
loc_138A0:
    call    get_kevinrandom
    add     ax, gState_frame
smart
    and     ax, 1
nosmart
loc_138AC:
    mov     end_hiscore_random, ax
    mov     [bp+var_6A], 76h ; 'v'
    jmp     short loc_138FF
    ; align 2
    db 144
loc_138B6:
    mov     al, gameconfig.game_opponenttype
    add     al, 30h ; '0'
    mov     byte ptr aOpp2lose+3, al
    mov     ax, offset aOpp2lose; "opp2lose"
    push    ax              ; char *
    mov     ax, 3
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     [bp+var_1C], ax
    mov     [bp+var_1A], dx
    mov     ax, offset aLose; "lose"
    push    ax
    push    [bp+var_66]
    push    [bp+var_68]
    call    locate_shape_alt
    add     sp, 6
    mov     [bp+var_5A], ax
    mov     [bp+var_58], dx
    call    get_kevinrandom
    add     ax, gState_frame
smart
    and     ax, 3
nosmart
    mov     end_hiscore_random, ax
    mov     [bp+var_6A], 64h ; 'd'
loc_138FF:
    mov     [bp+var_6E], 0
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, offset a_trk_5; ".trk"
    push    ax              ; int
    mov     ax, offset gameconfig.game_trackname
    push    ax
    mov     ax, offset byte_3B80C
    push    ax              ; char *
    call    file_build_path
    add     sp, 8
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, 1
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr [bp+var_4A], ax
    mov     word ptr [bp+var_4A+2], dx
    or      ax, dx
    jnz     short loc_1397F
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aIhd ; "ihd"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
loc_1394E:
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    push    ax
    call    show_dialog
    add     sp, 12h
    or      ax, ax
    jz      short loc_1397F
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, 1
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr [bp+var_4A], ax
    mov     word ptr [bp+var_4A+2], dx
loc_1397F:
    mov     ax, word ptr [bp+var_4A]
    or      ax, word ptr [bp+var_4A+2]
    jz      short loc_139B6
    sub     di, di
    jmp     short loc_1398D
    ; align 2
    db 144
loc_1398C:
    inc     di
loc_1398D:
    cmp     di, 385h
    jge     short loc_139A6
    les     bx, td14_elem_map_main
    mov     al, es:[bx+di]
    les     bx, [bp+var_4A]
    cmp     es:[bx+di], al
    jz      short loc_1398C
    mov     [bp+var_6E], 0FFh
loc_139A6:
    push    word ptr [bp+var_4A+2]
    push    word ptr [bp+var_4A]
    call    mmgr_release
    add     sp, 4
    jmp     short loc_139BA
loc_139B6:
    mov     [bp+var_6E], 0FFh
loc_139BA:
    cmp     [bp+var_6E], 0FFh
    jz      short loc_139E1
    sub     ax, ax
    push    ax
    push    cs
    call near ptr highscore_write_a
    add     sp, 2
    or      al, al
    jz      short loc_139E1
    mov     ax, 1
    push    ax
    push    cs
    call near ptr highscore_write_a
    add     sp, 2
    or      al, al
    jz      short loc_139E1
    mov     [bp+var_6E], 0FFh
loc_139E1:
    cmp     [bp+var_6E], 0
    jnz     short loc_13A0F
    cmp     gState_total_finish_time, 0
    jz      short loc_13A0F
    mov     ax, gState_total_finish_time
    mov     [bp+var_88], ax
    test    byte_43966, 6
    jnz     short loc_13A0F
    or      ax, ax
    jz      short loc_13A0F
    les     bx, td11_highscores
    cmp     es:[bx+16Ah], ax
    jbe     short loc_13A0F
    mov     [bp+var_6E], 1
loc_13A0F:
    mov     [bp+var_8E], 0
    mov     [bp+var_42], 1Eh
    mov     [bp+var_14], 1
loc_13A1D:
    cmp     [bp+var_16], 0
    jz      short loc_13A42
    cmp     [bp+var_6E], 2
    jnz     short loc_13A42
    mov     [bp+var_6E], 0
    call    sprite_copy_wnd_to_1
    push    cs
    call near ptr highscore_text_unk
    mov     [bp+var_selectedmenu], 1
    mov     [bp+var_14], 1
    jmp     loc_13FDA
loc_13A42:
    cmp     [bp+var_16], 0
    jnz     short loc_13A4B
    jmp     loc_13F48
loc_13A4B:
    mov     byte ptr aOp01+3, 31h ; '1'
    mov     ax, offset aOp01; "op01"
    push    ax
    push    [bp+var_1A]
    push    [bp+var_1C]
    call    locate_shape_fatal
    add     sp, 6
    mov     word ptr [bp+var_56], ax
    mov     word ptr [bp+var_56+2], dx
    les     bx, [bp+var_56]
    mov     ax, es:[bx]
    imul    video_flag1_is1
    mov     [bp+var_70], ax
    mov     ax, 138h
    sub     ax, [bp+var_70]
    mov     [bp+var_8C], ax
    mov     ax, 63h ; 'c'
    sub     ax, es:[bx+2]
    sar     ax, 1
    mov     [bp+var_90], ax
    push    word_407D2
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, es:[bx+2]
    add     ax, 5
    push    ax
    mov     ax, [bp+var_70]
    add     ax, 5
    push    ax
    mov     ax, [bp+var_90]
    sub     ax, 3
    push    ax
    mov     ax, [bp+var_8C]
    sub     ax, 3
    push    ax
    call    draw_lines_unk  ; border around opponent animation on eval screen
    add     sp, 0Eh
    mov     al, [bp+var_8E]
    cbw
    mov     bx, ax
    add     bx, [bp+var_5A]
    mov     es, [bp+var_58]
    mov     al, es:[bx]
    add     al, 30h ; '0'
    mov     byte ptr aOp01+3, al
    push    [bp+var_90]
    push    [bp+var_8C]
    mov     ax, offset aOp01; "op01"
    push    ax
    push    [bp+var_1A]
    push    [bp+var_1C]
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape2d_op_unk5
    add     sp, 8
    mov     al, [bp+var_8E]
    mov     [bp+var_6C], al
    sub     ax, ax
    push    ax
    push    ax
    call    font_set_unk
    add     sp, 4
    mov     [bp+var_70], 8
    mov     [bp+var_40], 0
    mov     [bp+var_50], 0
    mov     [bp+var_80], 0
    cmp     [bp+var_18], 2
    jnz     short loc_13B2C
    mov     [bp+var_7A], 1
    jmp     short loc_13B31
    ; align 2
    db 144
loc_13B2C:
    mov     [bp+var_7A], 3
loc_13B31:
    sub     di, di
    jmp     loc_13CAF
loc_13B36:
    cmp     [bp+var_18], 2
    jnz     short loc_13B42
    mov     ax, offset aD4a ; "d4a"
    jmp     short loc_13B57
    ; align 2
    db 144
loc_13B42:
    mov     al, [bp+var_6A]
    mov     [bp+var_12], al
    mov     [bp+var_11], 31h ; '1'
    mov     al, byte ptr word_40D40
loc_13B4F:
    add     al, 61h ; 'a'
    mov     [bp+var_10], al
    lea     ax, [bp+var_12]
loc_13B57:
    push    ax
    push    [bp+var_66]
    push    [bp+var_68]
    call    locate_text_res
    add     sp, 6
    mov     word ptr [bp+var_86], ax
    mov     word ptr [bp+var_86+2], dx
loc_13B6E:
    push    word ptr fontnptr+2
    push    word ptr fontnptr
    call    font_set_fontdef2
    add     sp, 4
loc_13B7E:
    les     bx, [bp+var_86]
    inc     word ptr [bp+var_86]
    mov     al, es:[bx]
    mov     [bp+var_3E], al
    cmp     al, 20h ; ' '
    jz      short loc_13B97
    or      al, al
    jz      short loc_13B97
    jmp     loc_13C92
loc_13B97:
    mov     bx, [bp+var_80]
    add     bx, bp
    mov     byte ptr [bx-3Ch], 0
    lea     ax, [bp+var_3C]
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_8A], ax
    add     ax, [bp+var_50]
    mov     cx, [bp+var_8C]
    sub     cx, 10h
    cmp     ax, cx
    jge     short loc_13C1A
    mov     ax, [bp+var_40]
    add     ax, [bp+var_80]
    cmp     ax, 50h ; 'P'
    jge     short loc_13C1A
    mov     [bp+var_5C], 0
    jmp     short loc_13BF3
loc_13BD0:
    mov     al, [bp+var_6A]
    mov     [bp+var_12], al
    mov     [bp+var_11], 32h ; '2'
    mov     al, byte ptr end_hiscore_random
    jmp     loc_13B4F
loc_13BE0:
    mov     al, [bp+var_6A]
    mov     [bp+var_12], al
    mov     [bp+var_11], 33h ; '3'
    mov     al, byte ptr word_40D44
    jmp     loc_13B4F
loc_13BF0:
    inc     [bp+var_5C]
loc_13BF3:
    mov     ax, [bp+var_80]
    cmp     [bp+var_5C], ax
    jge     short loc_13C10
    mov     bx, [bp+var_5C]
    add     bx, bp
    mov     al, [bx-3Ch]
    mov     bx, [bp+var_40]
    inc     [bp+var_40]
    mov     resID_byte1[bx], al
    jmp     short loc_13BF0
    ; align 2
    db 144
loc_13C10:
    mov     ax, [bp+var_8A]
    add     [bp+var_50], ax
    jmp     short loc_13C86
    ; align 2
    db 144
loc_13C1A:
    mov     bx, [bp+var_40]
    mov     resID_byte1[bx], 0
    push    [bp+var_70]
loc_13C25:
    mov     ax, 8
    push    ax
loc_13C29:
    mov     ax, 0AC74h
loc_13C2C:
    push    ax
    call    font_draw_text
    add     sp, 6
    add     [bp+var_70], 8
    cmp     [bp+var_3C], 20h ; ' '
    jnz     short loc_13C46
    mov     [bp+var_5C], 1
    jmp     short loc_13C4B
loc_13C46:
    mov     [bp+var_5C], 0
loc_13C4B:
    mov     [bp+var_40], 0
    jmp     short loc_13C67
loc_13C52:
    mov     bx, [bp+var_5C]
    add     bx, bp
    mov     al, [bx-3Ch]
    mov     bx, [bp+var_40]
    inc     [bp+var_40]
    mov     resID_byte1[bx], al
    inc     [bp+var_5C]
loc_13C67:
    mov     ax, [bp+var_80]
    cmp     [bp+var_5C], ax
    jl      short loc_13C52
    mov     bx, [bp+var_40]
    mov     resID_byte1[bx], 0
    mov     ax, 0AC74h
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_50], ax
loc_13C86:
    mov     [bp+var_80], 1
    mov     [bp+var_3C], 20h ; ' '
    jmp     short loc_13CA0
    ; align 2
    db 144
loc_13C92:
    mov     bx, [bp+var_80]
    inc     [bp+var_80]
    add     bx, bp
    mov     al, [bp+var_3E]
    mov     [bx-3Ch], al
loc_13CA0:
    cmp     [bp+var_3E], 0
    jz      short loc_13CA9
    jmp     loc_13B7E
loc_13CA9:
    call    font_set_fontdef
    inc     di
loc_13CAF:
    cmp     [bp+var_7A], di
    jle     short loc_13CD0
    mov     ax, di
    or      ax, ax
    jnz     short loc_13CBD
    jmp     loc_13B36
loc_13CBD:
    cmp     ax, 1
    jnz     short loc_13CC5
    jmp     loc_13BD0
loc_13CC5:
    cmp     ax, 2
    jnz     short loc_13CCD
    jmp     loc_13BE0
loc_13CCD:
    jmp     loc_13B6E
loc_13CD0:
    cmp     [bp+var_40], 0
    jz      short loc_13D06
    push    word ptr fontnptr+2
    push    word ptr fontnptr
    call    font_set_fontdef2
    add     sp, 4
    mov     bx, [bp+var_40]
    mov     resID_byte1[bx], 0
    push    [bp+var_70]
    mov     ax, 8
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    call    font_set_fontdef
loc_13D06:
    mov     [bp+var_14], 0
    cmp     [bp+var_6E], 0
    jg      short loc_13D13
    jmp     loc_13FDA
loc_13D13:
    mov     [bp+var_6E], 0
    mov     [bp+var_14], 1
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 15h
    push    ax
    mov     ax, 46h ; 'F'
    push    ax
    mov     ax, 0AFh ; 'Ø'
    push    ax
    mov     ax, 81h ; 'Å'
    push    ax
    mov     ax, offset aBct ; "bct"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    mov     al, [bp+var_52]
    cbw
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     [bp+var_52], 0FEh ; '˛'
    call    sub_29772
    call    check_input
    mov     [bp+var_70], 1
    call    sprite_copy_2_to_1_2
loc_13D83:
    push    word_407D0
    push    word_407CE
    mov     ax, 59Ah
    push    ax
    mov     ax, 590h
    push    ax
    mov     ax, 586h
    push    ax
    mov     ax, 57Ch
    push    ax
    mov     ax, 4
    push    ax
    call    mouse_timer_sprite_unk
    add     sp, 0Eh
    mov     [bp+var_72], ax
    add     [bp+var_42], ax
    cmp     [bp+var_42], 1Eh
    jl      short loc_13DD3
    sub     [bp+var_42], 1Eh
    inc     [bp+var_8E]
    mov     al, [bp+var_8E]
    cbw
    mov     bx, ax
    add     bx, [bp+var_5A]
    mov     es, [bp+var_58]
    cmp     byte ptr es:[bx], 0
    jnz     short loc_13DD3
    mov     [bp+var_8E], 0
loc_13DD3:
    mov     al, [bp+var_6C]
    cmp     [bp+var_8E], al
    jnz     short loc_13DDF
    jmp     loc_13EA5
loc_13DDF:
    mov     al, [bp+var_8E]
    mov     [bp+var_6C], al
    cbw
    mov     bx, ax
    add     bx, [bp+var_5A]
    mov     es, [bp+var_58]
    mov     al, es:[bx]
    add     al, 30h ; '0'
    mov     byte ptr aOp01+3, al
    call    mouse_draw_opaque_check
    mov     ax, offset aOp01; "op01"
    push    ax
    push    [bp+var_1A]
    push    [bp+var_1C]
    call    locate_shape_fatal
    add     sp, 6
    mov     word ptr [bp+var_56], ax
    mov     word ptr [bp+var_56+2], dx
    cmp     video_flag5_is0, 0
    jz      short loc_13E8A
    push    word ptr [bp+var_46+2]
    push    word ptr [bp+var_46]
    call    sprite_set_1_from_argptr
    add     sp, 4
    sub     ax, ax
    push    ax
    push    ax
    push    word ptr [bp+var_56+2]
    push    word ptr [bp+var_56]
    call    shape2d_op_unk5
    add     sp, 8
    call    sprite_copy_2_to_1_2
    les     bx, [bp+var_56]
    mov     ax, es:[bx+2]
    add     ax, [bp+var_90]
    push    ax
    push    [bp+var_90]
    mov     ax, es:[bx]
    imul    video_flag1_is1
    add     ax, [bp+var_8C]
    push    ax
    push    [bp+var_8C]
    call    sprite_set_1_size
    add     sp, 8
    push    [bp+var_90]
    push    [bp+var_8C]
    les     bx, [bp+var_46]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage_and_alt
    add     sp, 8
    call    sprite_copy_2_to_1_2
    jmp     short loc_13EA0
    ; align 2
    db 144
loc_13E8A:
    push    [bp+var_90]
    push    [bp+var_8C]
    push    word ptr [bp+var_56+2]
    push    word ptr [bp+var_56]
    call    shape2d_op_unk5
    add     sp, 8
loc_13EA0:
    call    mouse_draw_transparent_check
loc_13EA5:
    push    di
    call    input_checking
    add     sp, 2
    mov     si, ax
    cmp     si, 0Dh
    jz      short loc_13EBF
    cmp     si, 20h ; ' '
    jz      short loc_13EBF
    cmp     si, 1Bh
    jnz     short loc_13EC4
loc_13EBF:
    mov     [bp+var_70], 0
loc_13EC4:
    cmp     [bp+var_70], 0
    jz      short loc_13ECD
    jmp     loc_13D83
loc_13ECD:
    call    sprite_copy_wnd_to_1
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 64h ; 'd'
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    push    ax
    call    draw_button
    add     sp, 14h
    mov     ax, hiscore_buttons_y2
    inc     ax
    push    ax
    push    hiscore_buttons_y1
    mov     ax, 138h
    push    ax
    mov     ax, 8
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    word_407F8
    call    sprite_clear_1_color
    add     sp, 2
    call    mouse_draw_opaque_check
    mov     al, [bp+var_18]
    cbw
    push    ax
    mov     ax, offset aInh ; "inh"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    push    [bp+var_88]
    push    cs
    call near ptr enter_hiscore
    add     sp, 8
    jmp     loc_13FDA
loc_13F48:
    cmp     [bp+var_6E], 0
    jle     short loc_13F84
    call    check_input
    call    mouse_draw_opaque_check
    sub     ax, ax
    push    ax
    mov     ax, offset aInh_0; "inh"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    push    [bp+var_88]
    push    cs
    call near ptr enter_hiscore
    add     sp, 8
    mov     [bp+var_6E], 0
    mov     [bp+var_52], 0FEh ; '˛'
    jmp     short loc_13FDA
loc_13F84:
    call    mouse_draw_opaque_check
    cmp     [bp+var_6E], 0FFh
    jnz     short loc_13FD6
    mov     ax, offset aHna ; "hna"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 0AC74h
    push    ax
    call    copy_string
    add     sp, 6
    sub     ax, ax
    push    ax
loc_13FB2:
    push    dialog_fnt_colour
    mov     ax, 32h ; '2'
    push    ax
    mov     ax, 0AC74h
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, 0AC74h
loc_13FCA:
    push    ax
loc_13FCB:
    call    hiscore_draw_text
loc_13FD0:
    add     sp, 0Ah
    jmp     short loc_13FDA
    ; align 2
    db 144
loc_13FD6:
    push    cs
loc_13FD7:
    call near ptr highscore_text_unk
loc_13FDA:
    mov     [bp+var_selectedmenu], 1
    mov     [bp+var_78], 1
    call    sub_29772
    call    sprite_copy_wnd_to_1
    cmp     [bp+var_16], 0
    jz      short loc_13FF9
    cmp     [bp+var_6E], 0FFh
    jnz     short loc_14002
loc_13FF9:
    mov     [bp+var_9C], 0FFDCh
    jmp     short loc_14058
    ; align 2
    db 144
loc_14002:
    mov     [bp+var_9C], 0
    cmp     [bp+var_14], 0
    jz      short loc_14014
    mov     ax, offset aBev ; "bev"
    jmp     short loc_14017
    ; align 2
    db 144
loc_14014:
    mov     ax, offset aBhi ; "bhi"
loc_14017:
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    mov     [bp+var_7E], ax
    mov     [bp+var_7C], dx
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 15h
    push    ax
    mov     ax, 46h ; 'F'
    push    ax
    mov     ax, 0AFh ; 'Ø'
    push    ax
    mov     ax, word_3BCEC
    inc     ax
    push    ax
    push    dx
    push    [bp+var_7E]
    call    draw_button
    add     sp, 14h
loc_14058:
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 15h
    push    ax
    mov     ax, 46h ; 'F'
    push    ax
    mov     ax, 0AFh ; 'Ø'
    push    ax
    mov     ax, [bp+var_9C]
    add     ax, word_3BCEE
    inc     ax
    push    ax
    mov     ax, offset aBrp ; "brp"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    cmp     [bp+var_16], 0
    jz      short loc_140A4
    mov     ax, offset aBra ; "bra"
    jmp     short loc_140A7
loc_140A4:
    mov     ax, offset aBdr ; "bdr"
loc_140A7:
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    mov     [bp+var_7E], ax
    mov     [bp+var_7C], dx
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 15h
    push    ax
    mov     ax, 46h ; 'F'
    push    ax
    mov     ax, 0AFh ; 'Ø'
    push    ax
    mov     ax, [bp+var_9C]
    add     ax, word_3BCF0
    inc     ax
    push    ax
    push    dx
    push    [bp+var_7E]
    call    draw_button
    add     sp, 14h
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 15h
    push    ax
    mov     ax, 46h ; 'F'
    push    ax
    mov     ax, 0AFh ; 'Ø'
    push    ax
    mov     ax, [bp+var_9C]
    add     ax, word_3BCF2
    inc     ax
    push    ax
    mov     ax, offset aBmm_0; "bmm"
    push    ax
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    call    draw_button
    add     sp, 14h
    sub     di, di
loc_14130:
    mov     ax, di
    shl     ax, 1
    mov     [bp+var_9E], ax
    mov     bx, ax
    mov     ax, word_3BCEC[bx]
    add     ax, [bp+var_9C]
    add     bx, bp
    mov     [bx-64h], ax
    mov     ax, di
    shl     ax, 1
    mov     [bp+var_9E], ax
    mov     bx, ax
    mov     ax, word_3BCF6[bx]
    add     ax, [bp+var_9C]
    add     bx, bp
    mov     [bx-9Ah], ax
    inc     di
    cmp     di, 4
    jl      short loc_14130
    call    check_input
    mov     al, [bp+var_52]
    cbw
loc_1416E:
    push    ax
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_blit_to_video
    add     sp, 6
    mov     [bp+var_52], 0FEh ; '˛'
    call    sprite_copy_2_to_1_2
loc_14188:
    mov     al, [bp+var_78]
    cmp     [bp+var_selectedmenu], al
    jz      short loc_141DC
    mov     al, [bp+var_selectedmenu]
    mov     [bp+var_78], al
    call    sprite_copy_2_to_1_2
    mov     ax, hiscore_buttons_y2
    inc     ax
    push    ax
    push    hiscore_buttons_y1
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    call    mouse_draw_opaque_check
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
    call    mouse_draw_transparent_check
    call    timer_get_delta_alt
    call    sub_29772
loc_141DC:
    push    word_407D0
    push    word_407CE
    mov     ax, offset hiscore_buttons_y2
    push    ax
    mov     ax, offset hiscore_buttons_y1
    push    ax
    lea     ax, [bp+var_9A]
    push    ax
    lea     ax, [bp+var_64]
    push    ax
    mov     al, [bp+var_selectedmenu]
    cbw
    push    ax
    call    mouse_timer_sprite_unk
    add     sp, 0Eh
    mov     [bp+var_72], ax
    cmp     [bp+var_14], 0
    jz      short loc_1420F
    jmp     loc_14337
loc_1420F:
    cmp     [bp+var_18], 2
    jnz     short loc_14218
    jmp     loc_14337
loc_14218:
    add     [bp+var_42], ax
loc_1421B:
    cmp     [bp+var_42], 1Eh
    jl      short loc_14241
    sub     [bp+var_42], 1Eh
    inc     [bp+var_8E]
    mov     al, [bp+var_8E]
    cbw
    mov     bx, ax
    add     bx, [bp+var_5A]
    mov     es, [bp+var_58]
    cmp     byte ptr es:[bx], 0
    jnz     short loc_14241
loc_1423C:
    mov     [bp+var_8E], 0
loc_14241:
    mov     al, [bp+var_6C]
    cmp     [bp+var_8E], al
    jnz     short loc_1424D
    jmp     loc_14337
loc_1424D:
    mov     al, [bp+var_8E]
    mov     [bp+var_6C], al
    cbw
    mov     bx, ax
    add     bx, [bp+var_5A]
    mov     es, [bp+var_58]
    mov     al, es:[bx]
    add     al, 30h ; '0'
    mov     byte ptr aOp01+3, al
    call    mouse_draw_opaque_check
    mov     ax, offset aOp01; "op01"
    push    ax
    push    [bp+var_1A]
    push    [bp+var_1C]
    call    locate_shape_fatal
    add     sp, 6
    mov     word ptr [bp+var_56], ax
    mov     word ptr [bp+var_56+2], dx
    cmp     video_flag5_is0, 0
    jz      short loc_142F8
    push    word ptr [bp+var_46+2]
    push    word ptr [bp+var_46]
    call    sprite_set_1_from_argptr
    add     sp, 4
    sub     ax, ax
    push    ax
    push    ax
    push    word ptr [bp+var_56+2]
    push    word ptr [bp+var_56]
    call    shape2d_op_unk5
    add     sp, 8
    call    sprite_copy_2_to_1_2
    les     bx, [bp+var_56]
    mov     ax, es:[bx+2]
    add     ax, [bp+var_90]
    push    ax
    push    [bp+var_90]
    mov     ax, es:[bx]
    imul    video_flag1_is1
    add     ax, [bp+var_8C]
    push    ax
    push    [bp+var_8C]
    call    sprite_set_1_size
    add     sp, 8
    push    [bp+var_90]
    push    [bp+var_8C]
    les     bx, [bp+var_46]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage_and_alt
    add     sp, 8
    call    sprite_copy_2_to_1_2
    jmp     short loc_1430E
    ; align 2
    db 144
loc_142F8:
    push    [bp+var_90]
loc_142FC:
    push    [bp+var_8C]
    push    word ptr [bp+var_56+2]
    push    word ptr [bp+var_56]
    call    shape2d_op_unk5
    add     sp, 8
loc_1430E:
    push    [bp+var_90]
    push    [bp+var_8C]
    mov     ax, offset aOp01; "op01"
    push    ax
    push    [bp+var_1A]
    push    [bp+var_1C]
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape2d_op_unk5
    add     sp, 8
    call    mouse_draw_transparent_check
loc_14337:
    cmp     [bp+var_16], 0
    jz      short loc_14343
    cmp     [bp+var_6E], 0FFh
    jnz     short loc_1436C
loc_14343:
    mov     ax, (offset hiscore_buttons_y2+2); references the last three y pos in the array
    push    ax
    mov     ax, (offset hiscore_buttons_y1+2); ditto
    push    ax
    lea     ax, [bp+var_98]
    push    ax
    lea     ax, [bp+var_62]
    push    ax
    mov     ax, 3
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
loc_14360:
    mov     [bp+var_menuhit], al
    cmp     al, 0FFh
    jz      short loc_14395
    inc     al
    jmp     short loc_14391
loc_1436C:
    mov     ax, offset hiscore_buttons_y2
    push    ax
    mov     ax, offset hiscore_buttons_y1
    push    ax
loc_14374:
    lea     ax, [bp+var_9A]
    push    ax
    lea     ax, [bp+var_64]
    push    ax
    mov     ax, 4
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_menuhit], al
    cmp     al, 0FFh
    jz      short loc_14395
loc_14391:
    mov     [bp+var_selectedmenu], al
loc_14395:
    push    [bp+var_72]
    call    input_checking
    add     sp, 2
    mov     si, ax
    or      si, si
    jnz     short loc_143A9
    jmp     loc_14188
loc_143A9:
    cmp     ax, 0Dh         ; enter
    jz      short loc_143C6
    cmp     ax, 20h ; ' '   ; space
    jz      short loc_143C6
    cmp     ax, 4B00h
    jnz     short loc_143BB
    jmp     loc_1447A
loc_143BB:
    cmp     ax, 4D00h
    jnz     short loc_143C3
    jmp     loc_144A4
loc_143C3:
    jmp     loc_14188
loc_143C6:
    cmp     [bp+var_selectedmenu], 0
    jnz     short loc_1440C
    call    sprite_copy_wnd_to_1
    sub     ax, ax
    push    ax
    push    word_407F8
    push    word_407F6
    push    word_407F4
    mov     ax, 64h ; 'd'
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    push    ax
    call    draw_button
    add     sp, 14h
    cmp     [bp+var_14], 0
    jz      short loc_14404
    mov     [bp+var_6E], 0
    jmp     loc_13A1D
loc_14404:
    mov     [bp+var_6E], 2
    jmp     loc_13A1D
    ; align 2
    db 144
loc_1440C:
    call    audio_unload
    cmp     [bp+var_16], 0
    jz      short loc_14425
    push    [bp+var_1A]
    push    [bp+var_1C]
    call    mmgr_release
    add     sp, 4
loc_14425:
    cmp     video_flag5_is0, 0
    jz      short loc_1443A
    push    word ptr [bp+var_46+2]
    push    word ptr [bp+var_46]
    call    sprite_free_wnd
    add     sp, 4
loc_1443A:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_1445F
    push    [bp+var_66]
    push    [bp+var_68]
    call    unload_resource
    add     sp, 4
loc_1445F:
    push    [bp+var_4C]
    push    [bp+var_4E]
    call    unload_resource
    add     sp, 4
    mov     al, [bp+var_selectedmenu]
    cbw
    dec     ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_1447A:
    cmp     [bp+var_16], 0
    jz      short loc_14486
    cmp     [bp+var_6E], 0FFh
    jnz     short loc_14496
loc_14486:
    cmp     [bp+var_selectedmenu], 1
    jg      short loc_1449D
loc_1448D:
    mov     [bp+var_selectedmenu], 3
    jmp     loc_14188
    ; align 2
    db 144
loc_14496:
    cmp     [bp+var_selectedmenu], 0
    jz      short loc_1448D
loc_1449D:
    dec     [bp+var_selectedmenu]
    jmp     loc_14188
loc_144A4:
    cmp     [bp+var_selectedmenu], 3
    jge     short loc_144B2
    inc     [bp+var_selectedmenu]
    jmp     loc_14188
loc_144B2:
    cmp     [bp+var_16], 0
    jz      short loc_144BE
    cmp     [bp+var_6E], 0FFh
    jnz     short loc_144C6
loc_144BE:
    mov     [bp+var_selectedmenu], 1
    jmp     loc_14188
loc_144C6:
    mov     [bp+var_selectedmenu], 0
    jmp     loc_14188
    pop     si
end_hiscore endp
security_check proc far
    var_440 = byte ptr -1088
    var_43E = byte ptr -1086
    var_428 = word ptr -1064
    var_426 = word ptr -1062
    var_424 = word ptr -1060
    var_422 = word ptr -1058
    var_420 = word ptr -1056
    var_41E = word ptr -1054
    var_41C = word ptr -1052
    var_41A = word ptr -1050
    var_40E = word ptr -1038
    var_40C = word ptr -1036
    var_40A = word ptr -1034
    var_408 = word ptr -1032
    var_406 = byte ptr -1030
    var_405 = byte ptr -1029
    var_404 = byte ptr -1028
    var_403 = byte ptr -1027
    var_402 = byte ptr -1026
    var_401 = byte ptr -1025
    var_400 = byte ptr -1024
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 440h
    push    si
    mov     bx, [bp+arg_0]
    mov     al, byte_3BD34[bx]
    mov     byte ptr aQ00+2, al
    mov     al, byte_3BD34[bx]
    mov     byte ptr aA00+2, al
    mov     ax, offset aMisc_3; "misc"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_40C], ax
loc_144F8:
    mov     [bp+var_40A], dx
    mov     ax, offset aCop_0; "cop"
    push    ax
    push    dx
    push    [bp+var_40C]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    lea     ax, [bp+var_400]
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, offset aQ00 ; "q00"
    push    ax
    push    [bp+var_40A]
    push    [bp+var_40C]
loc_14528:
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, offset unk_463EA
    push    ax
    lea     ax, [bp+var_400]
    push    ax              ; char *
loc_14547:
    call    _strcat
loc_1454C:
    add     sp, 4
    sub     si, si
loc_14551:
    mov     al, resID_byte1[si]
    mov     [bp+si+var_406], al
    inc     si
    cmp     si, 6
    jl      short loc_14551
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_428]
    push    ax
    push    performGraphColor
    mov     ax, 78h ; 'x'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    lea     ax, [bp+var_400]
    push    ss
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 3
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     resID_byte3, 0
    mov     al, [bp+var_406]
    mov     resID_byte1, al
    mov     al, [bp+var_405]
    mov     resID_byte2, al
    push    [bp+var_426]
    push    [bp+var_428]
    mov     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
    mov     al, [bp+var_404]
    mov     resID_byte1, al
    mov     al, [bp+var_403]
    mov     resID_byte2, al
    push    [bp+var_422]
    push    [bp+var_424]
    mov     ax, offset resID_byte1
    push    ax
loc_145CA:
    call    font_draw_text
loc_145CF:
    add     sp, 6
    mov     al, [bp+var_402]
    mov     resID_byte1, al
    mov     al, [bp+var_401]
    mov     resID_byte2, al
loc_145E0:
    push    [bp+var_41E]
    push    [bp+var_420]
    mov     ax, offset resID_byte1
    push    ax
    call    font_draw_text
    add     sp, 6
loc_145F4:
    mov     ax, offset aA00 ; "a00"
    push    ax
    push    [bp+var_40A]
    push    [bp+var_40C]
loc_14600:
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
loc_14616:
    mov     ax, [bp+var_41C]
    mov     dx, [bp+var_41A]
loc_1461E:
    mov     [bp+var_428], ax
    mov     [bp+var_426], dx
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
loc_14632:
    mov     [bp+var_408], ax
    mov     [bp+var_43E], 0
    mov     [bp+var_40E], 0
loc_14641:
    mov     ax, (offset terraincenterpos+22h)
    cwd
    push    dx              ; int
    push    ax              ; int
    push    [bp+var_426]    ; int
    push    [bp+var_428]    ; int
    push    [bp+var_408]
    lea     ax, [bp+var_43E]
    push    ax              ; char *
    call    call_read_line
    add     sp, 0Ch
    sub     si, si
    jmp     short loc_1468D
loc_14664:
    mov     al, [bp+si+var_43E]
    cbw
    mov     bx, ax
    mov     al, g_ascii_props[bx]
smart
    and     al, 1
nosmart
    mov     [bp+var_440], al
    or      al, al
    jz      short loc_1468C
    jz      short loc_14684
    mov     al, [bp+si+var_43E]
    add     al, 20h ; ' '
    jmp     short loc_14688
    ; align 2
    db 144
loc_14684:
    mov     al, [bp+si+var_43E]
loc_14688:
    mov     [bp+si+var_43E], al
loc_1468C:
    inc     si
loc_1468D:
    cmp     [bp+si+var_43E], 0
    jnz     short loc_14664
    mov     ax, offset resID_byte1
    push    ax
loc_14698:
    lea     ax, [bp+var_43E]
    push    ax              ; char *
    call    _strcmp
    add     sp, 4
    or      ax, ax
    jnz     short loc_146B0
    mov     passed_security, 1
    jmp     short loc_146B4
loc_146B0:
    inc     [bp+var_40E]
loc_146B4:
    cmp     passed_security, 0
    jnz     short loc_146C5
    cmp     [bp+var_40E], 3
    jz      short loc_146C5
loc_146C2:
    jmp     loc_14641
loc_146C5:
    call    sub_275C6
    call    mouse_draw_transparent_check
loc_146CF:
    push    [bp+var_40A]
loc_146D3:
    push    [bp+var_40C]
loc_146D7:
    call    unload_resource
loc_146DC:
    add     sp, 4
    pop     si
    mov     sp, bp
loc_146E2:
    pop     bp
    retf
security_check endp
set_default_car proc far

    mov     gameconfig.game_playercarid, 43h ; 'C'
loc_146E9:
    mov     gameconfig.game_playercarid+1, 4Fh ; 'O'
loc_146EE:
    mov     gameconfig.game_playercarid+2, 55h ; 'U'
loc_146F3:
    mov     gameconfig.game_playercarid+3, 4Eh ; 'N'
loc_146F8:
    mov     gameconfig.game_playermaterial, 0
loc_146FD:
    mov     gameconfig.game_opponenttype, 0
loc_14702:
    mov     gameconfig.game_opponentmaterial, 0
loc_14707:
    mov     gameconfig.game_playertransmission, 1
loc_1470C:
    mov     gameconfig.game_opponentcarid, 0FFh
locret_14711:
    retf
set_default_car endp
seg000 ends
end
