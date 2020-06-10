.model medium
nosmart
    include structs.inc
    include custom.inc
    include seg000.inc
    include seg001.inc
    include seg002.inc
    include seg003.inc
    include seg004.inc
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
seg005 segment byte public 'STUNTSC' use16
    assume cs:seg005
    assume es:nothing, ss:nothing, ds:dseg
    public run_game
    public handle_ingame_kb_shortcuts
    public init_unknown
    public set_frame_callback
    public remove_frame_callback
    public frame_callback
    public replay_unk2
    public sub_2298C
    public file_load_replay
    public file_write_replay
    public setup_car_shapes
    public setup_player_cars
    public free_player_cars
    public mouse_minmax_position
    public replay_unk
    public loop_game
    public off_2481A
    public off_24D20
    public off_24D22
    public off_24D24
    public off_24D26
    public off_24D28
algn_21B79:
    ; align 2
    db 144
run_game proc far
    var_16 = dword ptr -22
    var_12 = word ptr -18
    var_E = word ptr -14
    var_C = word ptr -12
    var_rect = RECTANGLE ptr -10
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    si
    mov     [bp+var_C], 0FFFFh
    mov     rect_windshield.rc_left, 0
    mov     rect_windshield.rc_right, 140h
    mov     [bp+var_2], 0FFFFh
    mov     word_449EA, 0FFFFh
    call    get_kevinrandom
    mov     cl, 3
    shl     ax, cl
    mov     run_game_random, ax
    mov     replaybar_toggle, 1
    mov     is_in_replay, 0
    cmp     idle_expired, 0
    jz      short loc_21BEC
    inc     cameramode
    cmp     cameramode, 4
    jnz     short loc_21BCA
    mov     cameramode, 0
loc_21BCA:
    mov     game_replay_mode, 2
    mov     ax, offset aDefault; "default"
    push    ax
    sub     ax, ax
    push    ax              ; char *
    push    cs
    call near ptr file_load_replay
    add     sp, 4
    or      al, al
    jz      short loc_21BE4
    jmp     loc_223F4
loc_21BE4:
    call    track_setup
    jmp     short loc_21C0F
    ; align 2
    db 144
loc_21BEC:
    cmp     gameconfig.game_recordedframes, 0
    jnz     short loc_21C00
    mov     cameramode, 0
    mov     game_replay_mode, 1
    jmp     short loc_21C0F
    ; align 2
    db 144
loc_21C00:
    mov     cameramode, 0
    mov     game_replay_mode, 2
    mov     is_in_replay, 1
loc_21C0F:
    push    cs
    call near ptr setup_player_cars
    or      ax, ax
    jz      short loc_21C24
    push    cs
    call near ptr free_player_cars
    call    do_mer_restext
    jmp     loc_223E4
    ; align 2
    db 144
loc_21C24:
    mov     kbormouse, 0
    mov     byte_449E6, 0
    mov     byte_449DA, 1
    push    cs
    call near ptr set_frame_callback
    mov     game_replay_mode_copy, 0FFh
    mov     byte_44346, 0
    mov     byte_4432A, 0
    mov     byte_46467, 0
    mov     dashb_toggle, 0
    cmp     idle_expired, 0
    jz      short loc_21C6E
    mov     al, byte ptr gameconfig.game_framespersec
    cbw
    mov     framespersec, ax
loc_21C5E:
    mov     ax, 0FFFFh
    push    ax
    call    init_game_state
    add     sp, 2
    jmp     loc_21DA2
    ; align 2
    db 144
loc_21C6E:
    cmp     is_in_replay, 0
    jz      short loc_21C78
    jmp     loc_21D2C
loc_21C78:
    mov     cameramode, 0
    mov     dashb_toggle, 1
    mov     show_penalty_counter, 0
    mov     ax, framespersec2
    mov     framespersec, ax
    mov     al, byte ptr framespersec2
    mov     byte ptr gameconfig.game_framespersec, al
    mov     ax, 0FFFFh
    push    ax
    call    init_game_state
    add     sp, 2
    mov     word_45D94, 0
    mov     byte ptr word_45D3E, 0
    mov     byte_4393C, 1
    mov     al, byte_3B8F2
    cbw
    push    ax
    push    cs
    call near ptr mouse_minmax_position
    add     sp, 2
    mov     game_replay_mode, 1
    mov     ax, 0FF10h
    push    ax
    push    track_angle
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    cwd
    mov     cl, 6
loc_21CDC:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_21CDC
    add     word ptr state.playerstate.car_posWorld1.lx, ax
    adc     word ptr state.playerstate.car_posWorld1.lx+2, dx
    mov     ax, 0FF10h      ; -240
    push    ax
    push    track_angle
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    cwd
    mov     cl, 6
loc_21D08:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_21D08
    add     word ptr state.playerstate.car_posWorld1.lz, ax
    adc     word ptr state.playerstate.car_posWorld1.lz+2, dx
    add     word ptr state.playerstate.car_posWorld1.ly, 580h
    adc     word ptr state.playerstate.car_posWorld1.ly+2, 0
    mov     byte_43966, 1
    jmp     short loc_21DA2
    ; align 4
    db 144
    db 144
loc_21D2C:
    mov     cameramode, 0
    mov     game_replay_mode, 2
    mov     word_44DCA, 1F4h
    mov     al, byte ptr gameconfig.game_framespersec
    cbw
    mov     framespersec, ax
    sub     ax, ax
    push    ax
    call    restore_gamestate
    add     sp, 2
    push    gameconfig.game_recordedframes
    call    restore_gamestate
    add     sp, 2
    jmp     short loc_21D72
loc_21D5C:
    mov     ax, 1
    push    ax
    call    input_do_checking
    add     sp, 2
    cmp     ax, 1Bh
    jz      short loc_21D7B
    call    update_gamestate
loc_21D72:
    mov     ax, state.game_frame
    cmp     gameconfig.game_recordedframes, ax
    jnz     short loc_21D5C
loc_21D7B:
    mov     ax, gameconfig.game_recordedframes
    mov     elapsed_time2, ax
    jmp     short loc_21DA2
    ; align 2
    db 144
loc_21D84:
    cmp     byte_3B8F2, 0
    jnz     short loc_21D92
    cmp     byte_3FE00, 0
    jz      short loc_21D9D
loc_21D92:
    cmp     game_replay_mode, 0
    jnz     short loc_21D9D
    push    cs
    call near ptr replay_unk
loc_21D9D:
    call    update_gamestate
loc_21DA2:
    mov     ax, elapsed_time2
    cmp     state.game_frame, ax
    jnz     short loc_21D84
    cmp     game_replay_mode, 0
    jnz     short loc_21DCB
    cmp     byte_449DA, 0
    jnz     short loc_21DCB
    cmp     state.game_inputmode, 0
    jz      short loc_21DCB
    mov     ax, state.game_frame
    cmp     [bp+var_C], ax
    jz      short loc_21DA2
    mov     [bp+var_C], ax
loc_21DCB:
    cmp     state.game_inputmode, 0
    jnz     short loc_21DEB
    cmp     game_replay_mode, 0
    jnz     short loc_21DEB
    mov     elapsed_time2, 0
    mov     gameconfig.game_recordedframes, 0
    mov     state.game_frame, 0
loc_21DEB:
    mov     ax, timertestflag
    cmp     timertestflag_copy, ax
    jz      short loc_21DFC
    mov     timertestflag_copy, ax
    call    init_rect_arrays
loc_21DFC:
    cmp     byte_46467, 0
    jz      short loc_21E76
    call    input_push_status
    call    audio_unk
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aRbf ; "rbf"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
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
    mov     si, ax
    cmp     si, 0FFFFh
    jnz     short loc_21E49
    sub     si, si
loc_21E49:
    call    sub_372F4
    mov     word_3F88E, 0
    call    input_pop_status
    or      si, si
    jz      short loc_21E71
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    call    update_crash_state
    add     sp, 4
    mov     byte_449DA, 1
loc_21E71:
    mov     byte_46467, 0
loc_21E76:
    cmp     video_flag5_is0, 0
    jz      short loc_21E8A
    call    setup_mcgawnd2
    mov     al, byte_44346
    mov     byte_4432A, al
    jmp     short loc_21E8F
loc_21E8A:
    call    sprite_copy_wnd_to_1
loc_21E8F:
    mov     al, game_replay_mode_copy
    cmp     game_replay_mode, al
    jnz     short loc_21EBF
    mov     al, dashb_toggle_copy
    cmp     dashb_toggle, al
    jnz     short loc_21EBF
    mov     al, replaybar_toggle_copy
    cmp     replaybar_toggle, al
    jnz     short loc_21EBF
    mov     al, is_in_replay_copy
    cmp     is_in_replay, al
    jnz     short loc_21EBF
    mov     al, followOpponentFlag_copy
    cmp     followOpponentFlag, al
    jnz     short loc_21EBF
    jmp     loc_21F7A
loc_21EBF:
    mov     al, game_replay_mode
    mov     game_replay_mode_copy, al
    mov     al, dashb_toggle
    mov     dashb_toggle_copy, al
    mov     al, replaybar_toggle
    mov     replaybar_toggle_copy, al
    mov     al, is_in_replay
    mov     is_in_replay_copy, al
    mov     al, followOpponentFlag
    mov     followOpponentFlag_copy, al
    mov     roofbmpheight_copy, 0
    mov     byte_449E2, 0
    cmp     game_replay_mode, 2
    jnz     short loc_21F0A
    cmp     idle_expired, 0
    jnz     short loc_21F0A
    cmp     replaybar_toggle, 0
    jz      short loc_21F00
    jmp     loc_21FEE
loc_21F00:
    cmp     is_in_replay, 0
    jz      short loc_21F0A
    jmp     loc_21FEE
loc_21F0A:
    mov     replaybar_enabled, 0
loc_21F0F:
    cmp     idle_expired, 0
    jnz     short loc_21F19
    jmp     loc_21FF6
loc_21F19:
    mov     dashbmp_y_copy, 0C8h ; 'È'
loc_21F1F:
    mov     ax, roofbmpheight_copy
    cmp     [bp+var_2], ax
    jnz     short loc_21F38
    mov     ax, word_449EA
    cmp     dashbmp_y_copy, ax
    jnz     short loc_21F38
    mov     ax, height_above_replaybar
    cmp     [bp+var_E], ax
    jz      short loc_21F7A
loc_21F38:
    mov     al, video_flag6_is1
    mov     byte_454A4, al
    push    dashbmp_y_copy
    mov     ax, 140h
    push    ax
    mov     ax, dashbmp_y_copy
    cwd
    mov     cx, 6
    idiv    cx
    push    ax
    mov     ax, 23h ; '#'
    push    ax
    call    set_projection
    add     sp, 8
    mov     ax, roofbmpheight_copy
    mov     rect_windshield.rc_top, ax
    mov     ax, dashbmp_y_copy
    mov     rect_windshield.rc_bottom, ax
    mov     ax, roofbmpheight_copy
    mov     [bp+var_2], ax
    mov     ax, dashbmp_y_copy
    mov     word_449EA, ax
    mov     ax, height_above_replaybar
    mov     [bp+var_E], ax
loc_21F7A:
    cmp     byte_454A4, 0
    jnz     short loc_21F84
    jmp     loc_22052
loc_21F84:
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     byte_449D8[bx], 0
    cmp     byte_449E2, 0
    jz      short loc_21FB8
    push    height_above_replaybar
    push    dashbmp_y_copy
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    mov     ax, 1
    push    ax
    push    cs
    call near ptr setup_car_shapes
    add     sp, 2
loc_21FB8:
    cmp     replaybar_enabled, 0
    jnz     short loc_21FC2
    jmp     loc_22064
loc_21FC2:
    mov     ax, 0C8h ; 'È'
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    jmp     short loc_22064
    ; align 2
    db 144
loc_21FEE:
    mov     replaybar_enabled, 1
    jmp     loc_21F0F
loc_21FF6:
    cmp     dashb_toggle, 0
    jz      short loc_22034
    cmp     followOpponentFlag, 0
    jnz     short loc_22034
    cmp     game_replay_mode, 2
    jnz     short loc_2201A
    cmp     replaybar_enabled, 0
    jz      short loc_2201A
    mov     height_above_replaybar, 97h ; '—'; 151 = height of render area above the replay menu bar
    jmp     short loc_22020
loc_2201A:
    mov     height_above_replaybar, 0C8h ; 'È'; 200 = height of render area without the replay menu bar
loc_22020:
    mov     byte_449E2, 1
    mov     ax, roofbmpheight
    mov     roofbmpheight_copy, ax
    mov     ax, dashbmp_y
    mov     dashbmp_y_copy, ax
    jmp     loc_21F1F
loc_22034:
    cmp     game_replay_mode, 2
    jz      short loc_2203E
    jmp     loc_21F19
loc_2203E:
    cmp     replaybar_enabled, 0
    jnz     short loc_22048
    jmp     loc_21F19
loc_22048:
    mov     dashbmp_y_copy, 97h ; '—'
    jmp     loc_21F1F
    ; align 2
    db 144
loc_22052:
    cmp     replaybar_enabled, 0
    jnz     short loc_22064
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     byte_449D8[bx], 0
loc_22064:
    mov     ax, offset rect_windshield
    push    ax
    mov     al, byte_44346
    cbw
    push    ax
    call    update_frame
    add     sp, 4
    cmp     dastbmp_y, 0
    jz      short loc_220DB
    cmp     byte_449E2, 0
    jz      short loc_220DB
    cmp     timertestflag_copy, 0
    jz      short loc_220BB
    mov     [bp+var_rect.rc_left], 0
    mov     [bp+var_rect.rc_right], 140h
    mov     ax, dastbmp_y
    mov     [bp+var_rect.rc_top], ax
    mov     ax, dashbmp_y_copy
    mov     [bp+var_rect.rc_bottom], ax
    cmp     rectptr_unk, 0
    jz      short loc_220BB
    push    rectptr_unk
    lea     ax, [bp+var_rect]
    push    ax
    push    rectptr_unk
    call    rect_union
    add     sp, 6
loc_220BB:
    push    word ptr dasmshapeptr+2
    push    word ptr dasmshapeptr
    call    shape2d_render_bmp_as_mask
    add     sp, 4
    push    dastseg
    push    dastbmp_y2
    call    shape2d_op_unk4
    add     sp, 4
loc_220DB:
    mov     ax, offset rect_windshield
    push    ax
    call    sub_19F14
    add     sp, 2
    cmp     byte_449E2, 0
    jz      short loc_22126
    push    height_above_replaybar
    push    dashbmp_y_copy
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    mov     ax, 2
    push    ax
    push    cs
    call near ptr setup_car_shapes
    add     sp, 2
    mov     ax, 0C8h ; 'È'
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
loc_22126:
    cmp     byte_454A4, 0
    jz      short loc_22131
    dec     byte_454A4
loc_22131:
    cmp     video_flag5_is0, 0
    jz      short loc_22152
    call    mouse_draw_opaque_check
    call    setup_mcgawnd1
    xor     byte_44346, 1
    mov     al, byte_44346
    mov     byte_4432A, al
    call    mouse_draw_transparent_check
loc_22152:
    cmp     game_replay_mode, 1
    jnz     short loc_2217D
    cmp     byte_4393C, 0
    jnz     short loc_2217D
    mov     game_replay_mode, 0
    mov     ax, framespersec2
    mov     framespersec, ax
    mov     al, byte ptr framespersec2
    mov     byte ptr gameconfig.game_framespersec, al
loc_22171:
    mov     ax, 0FFFFh
    push    ax
    call    init_game_state
    add     sp, 2
loc_2217D:
    cmp     idle_expired, 0
    jz      short loc_221AA
    call    kb_get_char
    or      ax, ax
    jz      short loc_22190
    jmp     loc_22298
loc_22190:
    cmp     byte_449DA, 0
    jz      short loc_2219A
    jmp     loc_22298
loc_2219A:
    call    get_kb_or_joy_flags
    or      ax, ax
    jnz     short loc_221A6
    jmp     loc_21DA2
loc_221A6:
    jmp     loc_22298
    ; align 2
    db 144
loc_221AA:
    cmp     byte_449DA, 0
    jz      short loc_22208
    cmp     game_replay_mode, 0
    jnz     short loc_221C2
    cmp     state.game_3F6autoLoadEvalFlag, 4
    jz      short loc_221C2
    jmp     loc_22298
loc_221C2:
    cmp     byte_449DA, 2
    jnz     short loc_221CC
    jmp     loc_22298
loc_221CC:
    mov     byte_449DA, 0
    mov     game_replay_mode, 2
    sub     ax, ax
    push    ax
    push    cs
    call near ptr mouse_minmax_position
    add     sp, 2
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    mov     is_in_replay, 1
loc_22203:
    call    audio_carstate
loc_22208:
    cmp     game_replay_mode, 2
    jnz     short loc_22222
    sub     ax, ax
    push    ax
    push    ax
    mov     ax, 3
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    jmp     loc_21DA2
    ; align 2
    db 144
loc_22222:
    call    kb_get_char
    mov     [bp+var_12], ax
    or      ax, ax
    jz      short loc_22236
    push    ax
    push    cs
    call near ptr handle_ingame_kb_shortcuts
    add     sp, 2
loc_22236:
    mov     ax, [bp+var_12]
    cmp     ax, 4800h
    jz      short loc_22222
    cmp     ax, 4B00h
    jz      short loc_22222
    cmp     ax, 4D00h
    jz      short loc_22222
    cmp     ax, 5000h
    jz      short loc_22222
    cmp     game_replay_mode, 1
    jz      short loc_22257
    jmp     loc_21DA2
loc_22257:
    mov     ax, offset mouse_ypos
    push    ax
    mov     ax, offset mouse_xpos
    push    ax
    mov     ax, offset mouse_butstate
    push    ax
    call    mouse_get_state
    add     sp, 6
    test    byte ptr mouse_butstate, 3
    jnz     short loc_2227E
    call    get_kb_or_joy_flags
    test    al, 30h
    jnz     short loc_2227E
    jmp     loc_21DA2
loc_2227E:
    mov     game_replay_mode, 0
    mov     byte_4393C, 0
    mov     ax, framespersec2
    mov     framespersec, ax
    mov     al, byte ptr framespersec2
    mov     byte ptr gameconfig.game_framespersec, al
    jmp     loc_21C5E
    ; align 2
    db 144
loc_22298:
    cmp     video_flag5_is0, 0
    jz      short loc_222D3
    call    get_0
    or      ax, ax
    jz      short loc_222D3
    call    mouse_draw_opaque_check
    call    setup_mcgawnd2
    sub     ax, ax
    push    ax
    mov     ax, 0C8h ; 'È'  ; 200
    push    ax
    mov     ax, 140h        ; 320
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    call    sub_35C4E
    add     sp, 0Ah
    call    setup_mcgawnd1
    call    mouse_draw_transparent_check
loc_222D3:
    call    sprite_copy_2_to_1_2
    mov     is_in_replay, 1
    call    audio_carstate
    call    audio_remove_driver_timer
    cmp     game_replay_mode, 0
    jz      short loc_222F1
    jmp     loc_223CD
loc_222F1:
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_222FB
    jmp     loc_223CD
loc_222FB:
    cmp     state.opponentstate.car_crashBmpFlag, 0
    jz      short loc_22305
    jmp     loc_223CD
loc_22305:
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_16]
    push    ax
    push    performGraphColor
    mov     ax, 50h ; 'P'
    push    ax
    mov     ax, 0FFFFh
    push    ax
    mov     ax, offset aCop ; "cop"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 3
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     byte ptr word_45D3E, 1
    mov     si, framespersec
    dec     si
loc_22347:
    mov     ax, 1
    push    ax
    push    cs
    call near ptr replay_unk2
    add     sp, 2
    call    update_gamestate
    inc     si
    mov     ax, framespersec
    cmp     si, ax
    jnz     short loc_2239F
    sub     si, si
    mov     ax, 1
    push    ax              ; int
    mov     ax, state.game_frame
    add     ax, elapsed_time1
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    call    mouse_draw_opaque_check
    push    word ptr [bp+var_16+2]
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    sub_345BC
    add     sp, 6
    call    mouse_draw_transparent_check
loc_2239F:
    mov     ax, 1
    push    ax
    call    input_do_checking
    add     sp, 2
    cmp     ax, 1Bh
    jz      short loc_223CD
    cmp     state.opponentstate.car_crashBmpFlag, 0
    jnz     short loc_223CD
    mov     ax, 5DCh
    imul    framespersec
    mov     cx, state.game_frame
    add     cx, elapsed_time1
    cmp     ax, cx
    jz      short loc_223CD
    jmp     loc_22347
loc_223CD:
    mov     byte ptr word_45D3E, 0
    sub     ax, ax
    push    ax
    push    cs
    call near ptr mouse_minmax_position
    add     sp, 2
    push    cs
    call near ptr remove_frame_callback
    push    cs
    call near ptr free_player_cars
loc_223E4:
    mov     waitflag, 64h ; 'd'
    call    check_input
    call    show_waiting
loc_223F4:
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
run_game endp
handle_ingame_kb_shortcuts proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    cmp     ax, 64h ; 'd'
    jz      short loc_22470
    jbe     short loc_2240A
    jmp     loc_224EE
loc_2240A:
    cmp     ax, 44h ; 'D'
    jz      short loc_22470
    jbe     short loc_22414
    jmp     loc_224AC
loc_22414:
    cmp     ax, 1Bh         ; ESC
    jz      short loc_22420
    cmp     ax, 43h ; 'C'
    jmp     loc_224BE
    ; align 2
    db 144
loc_22420:
    cmp     game_replay_mode, 0
    jnz     short loc_22436
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    call    update_crash_state
    add     sp, 4
loc_22436:
    mov     byte_449DA, 1
    jmp     loc_224E9
loc_2243E:
    mov     cameramode, 1
    jmp     loc_224E9
loc_22446:
    mov     cameramode, 2
    jmp     loc_224E9
loc_2244E:
    mov     cameramode, 3
    jmp     loc_224E9
loc_22456:
    xor     HKeyFlag, 1
    jmp     loc_224E9
loc_2245E:
    call    do_mou_restext
    mov     al, byte_3B8F2
    cbw
    push    ax
    push    cs
    call near ptr mouse_minmax_position
    jmp     short loc_224E6
    ; align 4
    db 144
    db 144
loc_22470:
    xor     dashb_toggle, 1
    jmp     short loc_224E9
    ; align 2
    db 144
loc_22478:
    xor     replaybar_toggle, 1
    jmp     short loc_224E9
    ; align 2
    db 144
loc_22480:
    cmp     game_replay_mode, 1
    jz      short loc_224E9
    inc     cameramode
    cmp     cameramode, 4
    jnz     short loc_224E9
loc_22492:
    mov     cameramode, 0
    jmp     short loc_224E9
    ; align 2
    db 144
loc_2249A:
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_224E9
    xor     followOpponentFlag, 1
    jmp     short loc_224E9
loc_224A8:
    sub     ax, ax
    pop     bp
    retf
loc_224AC:
    cmp     ax, 48h ; 'H'
    jz      short loc_22456
    cmp     ax, 4Dh ; 'M'
    jz      short loc_2245E
    cmp     ax, 52h ; 'R'
    jz      short loc_22478
    cmp     ax, 63h ; 'c'
loc_224BE:
    jz      short loc_22480
loc_224C0:
    cmp     game_replay_mode, 1
    jnz     short loc_224A8
    mov     game_replay_mode, 0
    mov     byte_4393C, 0
    mov     ax, framespersec2
    mov     framespersec, ax
    mov     al, byte ptr framespersec2
    mov     byte ptr gameconfig.game_framespersec, al
    mov     ax, 0FFFFh
    push    ax
    call    init_game_state
loc_224E6:
    add     sp, 2
loc_224E9:
    mov     ax, 1
    pop     bp
    retf
loc_224EE:
    cmp     ax, 74h ; 't'
    jz      short loc_2249A
    ja      short loc_22510
    cmp     ax, 68h ; 'h'
    jnz     short loc_224FD
    jmp     loc_22456
loc_224FD:
    cmp     ax, 6Dh ; 'm'
    jnz     short loc_22505
    jmp     loc_2245E
loc_22505:
    cmp     ax, 72h ; 'r'
    jnz     short loc_2250D
    jmp     loc_22478
loc_2250D:
    jmp     short loc_224C0
    ; align 2
    db 144
loc_22510:
    cmp     ax, 3B00h
    jnz     short loc_22518
    jmp     loc_22492
loc_22518:
    cmp     ax, 3C00h
    jnz     short loc_22520
    jmp     loc_2243E
loc_22520:
    cmp     ax, 3D00h
    jnz     short loc_22528
    jmp     loc_22446
loc_22528:
    cmp     ax, 3E00h
    jnz     short loc_22530
    jmp     loc_2244E
loc_22530:
    jmp     short loc_224C0
handle_ingame_kb_shortcuts endp
init_unknown proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    mov     byte_44A8A, 1
    mov     byte_4552F, 2
    sub     si, si
    mov     elapsed_time2, si
    sub     al, al
    mov     byte_449DA, al
    mov     byte_4393C, al
    mov     word_44DCA, si
    pop     si
    mov     sp, bp
    pop     bp
    retf
init_unknown endp
set_frame_callback proc far

    mov     word_46468, 0
    mov     ax, offset frame_callback
    mov     dx, seg seg005
    push    dx
    push    ax
    call    timer_reg_callback
    add     sp, 4
    mov     byte_442E4, 0
    retf
set_frame_callback endp
remove_frame_callback proc far

    mov     ax, 0Ah
    cwd
    push    dx
    push    ax
    call    timer_get_counter_unk
    add     sp, 4
    mov     ax, offset frame_callback
    mov     dx, seg seg005
    push    dx
    push    ax
    call    timer_remove_callback
    add     sp, 4
    retf
    ; align 2
    db 144
remove_frame_callback endp
frame_callback proc far

    call    compare_ds_ss
    or      ax, ax
    jnz     short loc_225A2
    jmp     locret_22696
loc_225A2:
    cmp     byte_442E4, 0
    jz      short loc_225AC
    jmp     locret_22696
loc_225AC:
    inc     byte_442E4
    cmp     byte_442E4, 1
    jz      short loc_225BA
    jmp     loc_22692
loc_225BA:
    inc     word_443F4
    mov     ax, word_4499C
    cmp     word_443F4, ax
    jl      short loc_225FE
    mov     ax, word_449E4
    cmp     word_44D1E, ax
    jz      short loc_225FE
    push    word_443F4
    mov     ax, 22h ; '"'
    imul    word_44D1E
    add     ax, 97DCh
    push    ax
    call    sub_18D06
    add     sp, 4
    mov     word_443F4, 0
    inc     word_44D1E
    cmp     word_44D1E, 28h ; '('
    jnz     short loc_225FE
    mov     word_44D1E, 0
loc_225FE:
    cmp     byte_449DA, 0
    jz      short loc_22608
    jmp     loc_22692
loc_22608:
    cmp     byte_46467, 0
    jz      short loc_22612
    jmp     loc_22692
loc_22612:
    cmp     is_in_replay, 0
    jz      short loc_22620
    cmp     game_replay_mode, 2
    jz      short loc_22692
loc_22620:
    cmp     game_replay_mode, 0
    jnz     short loc_2263E
    mov     ax, state.game_frames_per_sec
    cmp     state.game_frame_in_sec, ax
    jl      short loc_2263E
    mov     is_in_replay, 1
    call    audio_carstate
    jmp     short loc_22692
    db 144
    db 144
loc_2263E:
    dec     byte_44A8A
    jnz     short loc_22692
    mov     al, byte ptr word_4499C
    mov     byte_44A8A, al
    inc     word_46468
    cmp     game_replay_mode, 2
    jnz     short loc_22688
    mov     al, byte_449E6
    cbw
    cmp     ax, 2
    jz      short loc_22666
    cmp     ax, 3
    jz      short loc_2267E
    jmp     short loc_22688
    ; align 2
    db 144
loc_22666:
    dec     byte_4552F
    jnz     short loc_22692
    sub     ax, ax
    push    ax
    push    cs
    call near ptr replay_unk2
    add     sp, 2
    mov     byte_4552F, 2
    jmp     short loc_22692
    ; align 2
    db 144
loc_2267E:
    sub     ax, ax
    push    ax
    push    cs
    call near ptr replay_unk2
    add     sp, 2
loc_22688:
    sub     ax, ax
    push    ax
    push    cs
    call near ptr replay_unk2
    add     sp, 2
loc_22692:
    dec     byte_442E4
locret_22696:
    retf
    ; align 2
    db 144
frame_callback endp
replay_unk2 proc far
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    di
    push    si
    cmp     [bp+arg_0], 0
    jz      short loc_226AC
loc_226A6:
    sub     si, si
    jmp     loc_22817
    ; align 2
    db 144
loc_226AC:
    cmp     game_replay_mode, 2
    jnz     short loc_226E6
    mov     ax, elapsed_time2
    cmp     gameconfig.game_recordedframes, ax
    jbe     short loc_226C6
    inc     elapsed_time2
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_226C6:
    cmp     byte_449DA, 0
    jz      short loc_226D0
    jmp     loc_22985
loc_226D0:
    mov     is_in_replay, 1
    call    audio_carstate
loc_226DA:
    mov     byte_449DA, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_226E6:
    cmp     byte_449DA, 0
    jnz     short loc_226A6
    cmp     state.game_3F6autoLoadEvalFlag, 0
    jnz     short loc_226A6
    cmp     game_replay_mode, 1
    jz      short loc_226A6
    cmp     passed_security, 0
    jnz     short loc_22725
    cmp     byte_4393C, 0
    jnz     short loc_22725
    mov     ax, framespersec
    shl     ax, 1
    shl     ax, 1
    cmp     ax, state.game_frame
    jnb     short loc_22725
    sub     ax, ax
    push    ax
    mov     ax, 1
    push    ax
    call    update_crash_state
    add     sp, 4
loc_22725:
    cmp     byte_3B8F2, 0
    jnz     short loc_22736
    cmp     byte_3FE00, 0
    jnz     short loc_22736
    jmp     loc_227E8
loc_22736:
    cmp     byte_3B8F2, 0
    jz      short loc_2279A
    mov     ax, 0AA5Eh
    push    ax
    mov     ax, 0A9FCh
    push    ax
    mov     ax, 8B78h
    push    ax
    call    mouse_get_state
    add     sp, 6
    mov     di, mouse_xpos
    sub     di, 0A0h ; ' '
    push    di              ; int
    call    _abs
    add     sp, 2
    cmp     ax, 12h
    jge     short loc_2276C
    sub     di, di
    jmp     short loc_22779
    ; align 2
    db 144
loc_2276C:
    or      di, di
    jle     short loc_22776
    sub     di, 12h
    jmp     short loc_22779
    ; align 2
    db 144
loc_22776:
    add     di, 12h
loc_22779:
    mov     ax, di
    mov     byte_40D6A, al
    test    byte ptr mouse_butstate, 1
    jz      short loc_2278A
    mov     si, 2
    jmp     short loc_227D2
loc_2278A:
    test    byte ptr mouse_butstate, 2
    jz      short loc_22796
    mov     si, 1
    jmp     short loc_227D2
loc_22796:
    sub     si, si
    jmp     short loc_227D2
loc_2279A:
    call    sub_307E3
    mov     byte_40D6A, al
    or      al, al
    jle     short loc_227B0
    cbw
    mov     bx, ax
    mov     al, byte_3E85C[bx]
    jmp     short loc_227C5
    ; align 2
    db 144
loc_227B0:
    cmp     byte_40D6A, 0
    jge     short loc_227C8
    mov     al, byte_40D6A
    cbw
    mov     bx, ax
    neg     bx
    mov     al, byte_3E85C[bx]
    neg     al
loc_227C5:
    mov     byte_40D6A, al
loc_227C8:
    call    get_kb_or_joy_flags
    mov     si, ax
smart
    and     si, 33h
nosmart
loc_227D2:
    mov     di, elapsed_time2
smart
    and     di, 3Fh
nosmart
    mov     al, byte_40D6A
    mov     byte_44292[di], al
    mov     byte_442EA[di], 1
    jmp     short loc_227EF
    ; align 2
    db 144
loc_227E8:
    call    get_kb_or_joy_flags
    mov     si, ax
loc_227EF:
    mov     ax, 1Eh
    push    ax
    call    kb_get_key_state
    add     sp, 2
    or      ax, ax
    jz      short loc_22803
smart
    nop
    or      si, 10h
nosmart
loc_22803:
    mov     ax, 2Ch ; ','
    push    ax
    call    kb_get_key_state
    add     sp, 2
    or      ax, ax
    jz      short loc_22817
smart
    nop
    or      si, 20h
nosmart
loc_22817:
    mov     ax, 5DCh
    imul    framespersec
    mov     cx, elapsed_time2
    add     cx, elapsed_time1
    cmp     ax, cx
    ja      short loc_2283C
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    call    update_crash_state
    add     sp, 4
    jmp     loc_226DA
loc_2283C:
    cmp     elapsed_time2, 2EE0h
    jz      short loc_22847
    jmp     loc_2296C
loc_22847:
    cmp     elapsed_time1, 0
    jnz     short loc_22866
    cmp     byte ptr word_45D3E, 0
    jnz     short loc_22866
    mov     byte ptr word_45D3E, 1
    mov     byte_46467, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_22866:
    sub     di, di
    jmp     loc_22909
    ; align 2
    db 144
loc_2286C:
    mov     ax, 460h
    cwd
    push    dx
    push    ax
    mov     ax, di
    cwd
    push    dx
    push    ax
    call    __aFlmul
    add     ax, 5A0h
    adc     dx, 0
    add     ax, word ptr cvxptr
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, word ptr cvxptr+2
    mov     es, dx
    mov     bx, ax
    mov     ax, [bp+var_6]
    sub     es:[bx], ax
    mov     ax, 460h
    cwd
    push    dx
    push    ax
    mov     ax, di
    cwd
    push    dx
    push    ax
    call    __aFlmul
    add     ax, 460h
    adc     dx, 0
    add     ax, word ptr cvxptr
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, word ptr cvxptr+2
    mov     cx, 460h
    sub     bx, bx
    push    bx
    push    cx
    mov     cx, ax
    mov     ax, di
    mov     bx, dx
    cwd
    push    dx
    push    ax
    mov     [bp+var_A], cx
    mov     [bp+var_8], bx
    call    __aFlmul
    add     ax, word ptr cvxptr
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, word ptr cvxptr+2
    mov     bx, ax
    mov     es, dx
    mov     ax, [bp+var_A]
    mov     dx, [bp+var_8]
    push    si
    push    di
    mov     di, bx
    mov     si, ax
    push    ds
    mov     ds, dx
    mov     cx, 230h
    repne movsw
    pop     ds
    pop     di
    pop     si
    inc     di
loc_22909:
    mov     ax, 1Eh
    imul    framespersec
    mov     [bp+var_6], ax
    mov     ax, 2EE0h
    cwd
    mov     cx, [bp+var_6]
    idiv    cx
    dec     ax
    cmp     ax, di
    jle     short loc_22924
    jmp     loc_2286C
loc_22924:
    sub     di, di
    jmp     short loc_2293E
loc_22928:
    mov     bx, [bp+var_A]
    add     bx, word ptr td16_rpl_buffer
    mov     es, word ptr td16_rpl_buffer+2
    mov     al, es:[bx+di]
    mov     bx, word ptr td16_rpl_buffer
    mov     es:[bx+di], al
    inc     di
loc_2293E:
    mov     ax, 1Eh
    imul    framespersec
    mov     [bp+var_A], ax
    mov     ax, 2EE0h
    sub     ax, [bp+var_A]
    cmp     ax, di
    jg      short loc_22928
    mov     ax, 1Eh
    imul    framespersec
    mov     [bp+var_A], ax
    sub     elapsed_time2, ax
    sub     gameconfig.game_recordedframes, ax
    add     elapsed_time1, ax
    sub     state.game_frame, ax
loc_2296C:
    mov     bx, elapsed_time2
    inc     elapsed_time2
    add     bx, word ptr td16_rpl_buffer
    mov     es, word ptr td16_rpl_buffer+2
    mov     ax, si
    mov     es:[bx], al
    inc     gameconfig.game_recordedframes
loc_22985:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
replay_unk2 endp
sub_2298C proc far
    var_34 = dword ptr -52
    var_30 = word ptr -48
    var_2E = word ptr -46
    var_2C = word ptr -44
    var_2A = word ptr -42
    var_28 = word ptr -40
    var_26 = word ptr -38
    var_opponentstateptr = word ptr -36
    var_22 = word ptr -34
    var_20 = word ptr -32
    var_1E = word ptr -30
    var_1C = word ptr -28
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_14 = word ptr -20
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 34h
    push    di
    push    si
    mov     [bp+var_2A], 1
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_229A5
    mov     [bp+var_2A], 2
loc_229A5:
    sub     si, si
    jmp     loc_22C53
loc_229AA:
    mov     [bp+var_opponentstateptr], offset state.opponentstate
loc_229AF:
    mov     bx, [bp+var_opponentstateptr]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.ly]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.ly+2)]
    mov     cl, 6
loc_229BA:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_229BA
    mov     [bp+var_1A], ax
    mov     bx, [bp+var_opponentstateptr]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lx]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lx+2)]
    mov     cl, 6
loc_229CF:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_229CF
    mov     [bp+var_1C], ax
    mov     bx, [bp+var_opponentstateptr]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lz]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lz+2)]
    mov     cl, 6
loc_229E5:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_229E5
    mov     [bp+var_18], ax
    mov     bx, [bp+var_opponentstateptr]
    push    si
    push    di
    lea     di, [bp+var_6]
    lea     si, [bx+CARSTATE.car_vec_unk3]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     bx, [bp+var_opponentstateptr]
    mov     ax, [bx+CARSTATE.field_48]
    mov     [bp+var_E], ax
    or      si, si
    jnz     short loc_22A1E
    cmp     state.field_45B, 0
    jnz     short loc_22A40
    cmp     state.field_45C, 0
    jnz     short loc_22A40
loc_22A1E:
    cmp     [bx+CARSTATE.field_B6], 0
    jnz     short loc_22A40
    cmp     [bx+CARSTATE.car_crashBmpFlag], 0
    jnz     short loc_22A40
    cmp     [bx+CARSTATE.car_trackdata3_index], 0FFFFh
    jz      short loc_22A40
    cmp     [bp+var_E], 80h ; '€'
    jle     short loc_22A4D
    cmp     [bp+var_E], 380h
    jge     short loc_22A4D
loc_22A40:
    push    si
    push    di
    lea     di, [bp+var_6]
    lea     si, [bp+var_1C]
    movsw
    movsw
    movsw
    pop     di
    pop     si
loc_22A4D:
    mov     [bp+var_22], 1C2h
    mov     ax, [bp+var_1A]
    add     ax, 10Eh
    mov     [bp+var_14], ax
    mov     bx, si
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     ax, state.game_vec1.vy[bx]
    sub     ax, [bp+var_14]
    mov     [bp+var_C], ax
    or      ax, ax
    jz      short loc_22A96
    mov     di, ax
    cmp     di, 1Eh
    jle     short loc_22A80
    mov     di, 1Eh
    jmp     short loc_22A88
    ; align 2
    db 144
loc_22A80:
    cmp     di, 0FFE2h
    jge     short loc_22A88
    mov     di, 0FFE2h
loc_22A88:
    mov     bx, si
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    sub     state.game_vec1.vy[bx], di
loc_22A96:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_2E], ax
    mov     ax, [bp+var_2]
    mov     bx, [bp+var_2E]
    sub     ax, state.game_vec1.vz[bx]
    push    ax
    mov     ax, [bp+var_6]
    sub     ax, state.game_vec1.vx[bx]
    push    ax
    call    polarAngle
    add     sp, 4
    mov     [bp+var_10], ax
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_30], ax
    mov     ax, [bp+var_18]
    mov     bx, [bp+var_30]
    sub     ax, state.game_vec1.vz[bx]
    push    ax
    mov     ax, [bp+var_1C]
    sub     ax, state.game_vec1.vx[bx]
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     di, ax
    cmp     [bp+var_22], di
    jge     short loc_22B53
    sub     di, [bp+var_22]
    cmp     framespersec, 14h
    jnz     short loc_22B04
    cmp     di, 78h ; 'x'
    jle     short loc_22B0D
    mov     di, 78h ; 'x'
    jmp     short loc_22B0D
loc_22B04:
    cmp     di, 0F0h ; 'ð'
    jle     short loc_22B0D
    mov     di, 0F0h ; 'ð'
loc_22B0D:
    push    [bp+var_10]
    call    sin_fast
    add     sp, 2
    push    ax
    push    di
    call    multiply_and_scale
    add     sp, 4
    mov     bx, si
    mov     cx, bx
    shl     bx, 1
    add     bx, cx
    shl     bx, 1
    add     state.game_vec1.vx[bx], ax
    push    [bp+var_10]
    call    cos_fast
    add     sp, 2
    push    ax
    push    di
    call    multiply_and_scale
    add     sp, 4
    mov     bx, si
    mov     cx, bx
    shl     bx, 1
    add     bx, cx
    shl     bx, 1
    add     state.game_vec1.vz[bx], ax
loc_22B53:
    mov     ax, state.game_frame
    sub     dx, dx
    mov     cx, framespersec
    sar     cx, 1
    div     cx
    or      dx, dx
    jz      short loc_22B67
    jmp     loc_22C52
loc_22B67:
    mov     [bp+var_2C], 2710h
    mov     [bp+var_A], 0
    jmp     short loc_22BE3
    ; align 4
    db 144
    db 144
loc_22B74:
    mov     ax, [bp+var_20]
    mov     dx, [bp+var_1E]
loc_22B7A:
    mov     cx, ax
    mov     ax, [bp+var_2C]
    mov     bx, dx
    cwd
    cmp     bx, dx
    jg      short loc_22BE0
    jl      short loc_22B8C
    cmp     cx, ax
    jnb     short loc_22BE0
loc_22B8C:
    cmp     [bp+var_26], 0
    jge     short loc_22BA2
    mov     ax, [bp+var_28]
    mov     dx, [bp+var_26]
    neg     ax
    adc     dx, 0
    neg     dx
    jmp     short loc_22BA8
    ; align 2
    db 144
loc_22BA2:
    mov     ax, [bp+var_28]
    mov     dx, [bp+var_26]
loc_22BA8:
    mov     cx, ax
    mov     ax, [bp+var_2C]
    mov     bx, dx
    cwd
    cmp     bx, dx
    jg      short loc_22BE0
    jl      short loc_22BBA
    cmp     cx, ax
    jnb     short loc_22BE0
loc_22BBA:
    push    [bp+var_28]
    push    [bp+var_20]
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_8], ax
    mov     ax, [bp+var_2C]
    cmp     [bp+var_8], ax
    jge     short loc_22BE0
    mov     al, [bp+var_A]
    mov     state.field_3F7[si], al
    mov     ax, [bp+var_8]
    mov     [bp+var_2C], ax
loc_22BE0:
    inc     [bp+var_A]
loc_22BE3:
    mov     al, byte_4616E
    cmp     [bp+var_A], al
    jge     short loc_22C52
    mov     al, [bp+var_A]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr trackdata9
    mov     dx, word ptr trackdata9+2
    mov     word ptr [bp+var_34], ax
    mov     word ptr [bp+var_34+2], dx
    mov     ax, [bp+var_1C]
    cwd
    les     bx, [bp+var_34]
    mov     cx, ax
    mov     ax, es:[bx]
    mov     bx, dx
    cwd
    sub     ax, cx
    sbb     dx, bx
    mov     [bp+var_20], ax
    mov     [bp+var_1E], dx
    mov     ax, [bp+var_18]
    cwd
    mov     bx, word ptr [bp+var_34]
    mov     cx, ax
    mov     ax, es:[bx+4]
    mov     bx, dx
    cwd
    sub     ax, cx
    sbb     dx, bx
    mov     [bp+var_28], ax
    mov     [bp+var_26], dx
    cmp     [bp+var_1E], 0
    jl      short loc_22C41
    jmp     loc_22B74
loc_22C41:
    mov     ax, [bp+var_20]
    mov     dx, [bp+var_1E]
    neg     ax
    adc     dx, 0
    neg     dx
    jmp     loc_22B7A
    ; align 2
    db 144
loc_22C52:
    inc     si
loc_22C53:
    cmp     [bp+var_2A], si
    jle     short loc_22C8C
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_2E], ax
    mov     bx, ax
    lea     ax, state.game_vec1.vx[bx]
    mov     bx, [bp+var_2E]
    push    si
    push    di
    lea     di, state.game_vec3.vx[bx]
    mov     si, ax
    push    ds
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    or      si, si
    jz      short loc_22C84
    jmp     loc_229AA
loc_22C84:
    mov     [bp+var_opponentstateptr], offset state.playerstate
    jmp     loc_229AF
loc_22C8C:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_2298C endp
file_load_replay proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    push    di
    push    si
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, offset a_rpl; ".rpl"
    push    ax              ; int
    push    word ptr [bp+arg_0+2]
    push    word ptr [bp+arg_0]; char *
    call    file_build_path
    add     sp, 8
    mov     g_is_busy, 1
    push    word ptr td13_rpl_header+2
    push    word ptr td13_rpl_header
    mov     ax, offset g_path_buf
    push    ax
    call    file_read_fatal
    add     sp, 6
    mov     ax, word ptr td13_rpl_header
    mov     dx, word ptr td13_rpl_header+2
    mov     di, offset gameconfig
    mov     si, ax
    push    ds
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 0Dh         ; copies 13 words from the rpl to gameconfig
    repne movsw
    pop     ds
    mov     g_is_busy, 0
    sub     ax, ax
    pop     si
    pop     di
    pop     bp
    retf
file_load_replay endp
file_write_replay proc far
    var_6 = word ptr -6
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    les     bx, td13_rpl_header
    push    si
    mov     di, bx
    mov     si, offset gameconfig
    mov     cx, 0Dh
    repne movsw
    pop     si
    mov     ax, gameconfig.game_recordedframes
    add     ax, 724h        ; offset of .rpl kb. event block
    cwd
    mov     [bp+var_6], ax
    mov     [bp+var_4], dx
    mov     g_is_busy, 1
    push    dx
    push    ax
    push    es
    push    bx
    push    [bp+arg_filename]
    call    file_write_fatal
    add     sp, 0Ah
    mov     g_is_busy, 0
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
file_write_replay endp
setup_car_shapes proc far
    var_20 = word ptr -32
    var_1E = word ptr -30
    var_1C = byte ptr -28
    var_1A = byte ptr -26
    var_18 = byte ptr -24
    var_16 = byte ptr -22
    var_14 = byte ptr -20
    var_E = word ptr -14
    var_C = dword ptr -12
    var_8 = word ptr -8
    var_6 = byte ptr -6
    var_4 = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 20h
    push    di
    push    si
    mov     ax, [bp+arg_0]
    or      ax, ax
    jz      short loc_22D5C
    cmp     ax, 1
    jnz     short loc_22D45
    jmp     loc_22F76
loc_22D45:
    cmp     ax, 2
    jnz     short loc_22D4D
    jmp     loc_23030
loc_22D4D:
    cmp     ax, 3
    jnz     short loc_22D55
    jmp     loc_236AC
loc_22D55:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_22D5C:
    mov     al, gameconfig.game_playercarid
    mov     byte ptr aStdaxxxx+4, al
    mov     al, gameconfig.game_playercarid+1
    mov     byte ptr aStdaxxxx+5, al
    mov     al, gameconfig.game_playercarid+2
    mov     byte ptr aStdaxxxx+6, al
    mov     al, gameconfig.game_playercarid+3
    mov     byte ptr aStdaxxxx+7, al
    mov     al, gameconfig.game_playercarid
    mov     byte ptr aStdbxxxx+4, al
    mov     al, gameconfig.game_playercarid+1
    mov     byte ptr aStdbxxxx+5, al
    mov     al, gameconfig.game_playercarid+2
    mov     byte ptr aStdbxxxx+6, al
    mov     al, gameconfig.game_playercarid+3
    mov     byte ptr aStdbxxxx+7, al
    mov     ax, offset aStdaxxxx; "stdaxxxx"
    push    ax              ; char *
    mov     ax, 3
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr stdaresptr, ax
    mov     word ptr stdaresptr+2, dx
    mov     ax, offset aStdbxxxx; "stdbxxxx"
    push    ax              ; char *
    mov     ax, 2
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr stdbresptr, ax
    mov     word ptr stdbresptr+2, dx
    mov     ax, offset whlshapes
    push    ax
    mov     ax, offset aWhl1whl2whl3ins2gboxins1i; "whl1whl2whl3ins2gboxins1ins3inm1inm3"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_many_resources
    add     sp, 8
    mov     ax, offset gnobshapes
    push    ax
    mov     ax, offset aGnobgnabdotDotadot1dot2; "gnobgnabdot dotadot1dot2"
    push    ax
    push    word ptr stdbresptr+2
    push    word ptr stdbresptr
    call    locate_many_resources
    add     sp, 8
    cmp     simd_player.spdcenter.y2, 0
    jnz     short loc_22E09
    mov     ax, offset digshapes
    push    ax
    mov     ax, offset aDig0dig1dig2dig3dig4dig5d; "dig0dig1dig2dig3dig4dig5dig6dig7dig8dig"...
    push    ax
    push    word ptr stdbresptr+2
    push    word ptr stdbresptr
    call    locate_many_resources
    add     sp, 8
loc_22E09:
    mov     ax, 0Fh
    push    ax
    les     bx, whlshapes+0Ch
    push    word ptr es:[bx+2]
    mov     ax, es:[bx]
    imul    video_flag1_is1
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr whlsprite1, ax
    mov     word ptr whlsprite1+2, dx
    mov     ax, 0Fh
    push    ax
    les     bx, whlshapes+10h
    push    word ptr es:[bx+2]
    mov     ax, es:[bx]
    imul    video_flag1_is1
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr whlsprite2, ax
    mov     word ptr whlsprite2+2, dx
    mov     ax, 0Fh
    push    ax
    les     bx, whlshapes+10h
    push    word ptr es:[bx+2]
    mov     ax, es:[bx]
    imul    video_flag1_is1
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr whlsprite3, ax
    mov     word ptr whlsprite3+2, dx
    mov     ax, offset aDash; "dash"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_fatal
    add     sp, 6
    mov     word ptr [bp+var_C], ax
    mov     word ptr [bp+var_C+2], dx
    push    word ptr whlsprite3+2
    push    word ptr whlsprite3
    call    sprite_set_1_from_argptr
    add     sp, 4
    les     bx, [bp+var_C]
    mov     ax, es:[bx+SHAPE2D.s2d_pos_y]
    les     bx, whlshapes+10h
    sub     ax, es:[bx+SHAPE2D.s2d_pos_y]
    push    ax
    les     bx, [bp+var_C]
    mov     ax, es:[bx+SHAPE2D.s2d_pos_x]
    les     bx, whlshapes+10h
    sub     ax, es:[bx+SHAPE2D.s2d_pos_x]
    push    ax
    push    word ptr [bp+var_C+2]
    push    word ptr [bp+var_C]
    call    shape2d_op_unk2
    add     sp, 8
    call    sprite_copy_2_to_1
    les     bx, [bp+var_C]
    mov     ax, es:[bx+SHAPE2D.s2d_pos_y]
    mov     dashbmp_y, ax
    mov     ax, offset aRoof; "roof"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_nofatal
    add     sp, 6
    or      dx, ax
    jz      short loc_22F12
    mov     ax, offset aRoof_0; "roof"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_fatal
    add     sp, 6
    mov     bx, ax
    mov     es, dx
    mov     ax, es:[bx+SHAPE2D.s2d_height]
    mov     roofbmpheight, ax
    jmp     short loc_22F18
loc_22F12:
    mov     roofbmpheight, 0
loc_22F18:
    mov     ax, offset aDast; "dast"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_nofatal
    add     sp, 6
    mov     word ptr [bp+var_C], ax
    mov     word ptr [bp+var_C+2], dx
    or      ax, dx
    jz      short loc_22F6A
    les     bx, [bp+var_C]
    mov     ax, es:[bx+SHAPE2D.s2d_pos_y]
    mov     dastbmp_y, ax
    mov     ax, bx
    mov     dastbmp_y2, ax
    mov     dastseg, dx
    mov     ax, offset aDasm; "dasm"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_fatal
    add     sp, 6
    mov     word ptr dasmshapeptr, ax
    mov     word ptr dasmshapeptr+2, dx
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_22F6A:
    mov     dastbmp_y, 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_22F76:
    call    mouse_draw_opaque_check
    mov     ax, offset aRoof_1; "roof"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_nofatal
    add     sp, 6
    or      dx, ax
    jz      short loc_22FB1
    mov     ax, offset aRoof_2; "roof"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape2d_op_unk
    add     sp, 4
loc_22FB1:
    mov     ax, offset aDash_0; "dash"
    push    ax
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape2d_op_unk3
    add     sp, 4
    push    word ptr whlshapes+6
    push    word ptr whlshapes+4
    call    shape2d_op_unk3
    add     sp, 4
    call    mouse_draw_transparent_check
    sub     si, si
    mov     al, byte_4432A
    cbw
    mov     [bp+var_1E], ax
    mov     bx, ax
    sub     al, al
    mov     byte_449D8[bx], al
    mov     bx, [bp+var_1E]
    mov     byte_40DFA[bx], al
    mov     ax, [bp+var_1E]
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     bx, ax
    mov     word_40DF6[bx], si
    mov     bx, [bp+var_1E]
    sub     al, al
    mov     byte_40DF0[bx], al
    dec     si
    mov     bx, [bp+var_20]
    mov     word_40E00[bx], si
    mov     bx, [bp+var_20]
    mov     word_40D78[bx], si
    mov     bx, [bp+var_20]
    mov     word_40D6C[bx], si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_23030:
    mov     al, state.playerstate.car_fpsmul2
    cbw
    mov     cx, ax
    mov     al, state.playerstate.car_changing_gear
    cbw
    or      ax, cx
    jnz     short loc_2309A
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    cmp     byte_40DFA[bx], 0
    jz      short loc_2309A
    cmp     video_flag5_is0, 0
    jnz     short loc_23057
    call    mouse_draw_opaque_check
loc_23057:
    push    height_above_replaybar
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    les     bx, whlshapes+10h
    push    word ptr es:[bx+0Ah]
    push    word ptr es:[bx+8]
    les     bx, whlsprite3
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     byte_40DFA[bx], 0
    jmp     loc_2319D
loc_2309A:
    mov     al, byte_4432A
    cbw
    mov     [bp+var_20], ax
    mov     bx, ax
    mov     al, state.playerstate.car_changing_gear
    cmp     byte_40DFA[bx], al
    jnz     short loc_230DE
    mov     ax, bx
    shl     ax, 1
    mov     [bp+var_1E], ax
    mov     bx, ax
    mov     ax, state.playerstate.car_knob_x
    cmp     word_40D70[bx], ax
    jnz     short loc_230DE
    mov     ax, state.playerstate.car_knob_y
    cmp     word_40D74[bx], ax
    jnz     short loc_230DE
    cmp     state.playerstate.car_fpsmul2, 0
    jnz     short loc_230D1
    jmp     loc_2319D
loc_230D1:
    mov     bx, [bp+var_20]
    cmp     byte_40DFA[bx], 0
    jz      short loc_230DE
    jmp     loc_2319D
loc_230DE:
    push    word ptr whlsprite2+2
    push    word ptr whlsprite2
    call    sprite_set_1_from_argptr
    add     sp, 4
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     byte_40DFA[bx], 1
    sub     ax, ax
    push    ax
    push    ax
    push    word ptr whlshapes+12h
    push    word ptr whlshapes+10h
    call    shape2d_op_unk2
    add     sp, 8
    mov     si, state.playerstate.car_knob_x
    mov     di, state.playerstate.car_knob_y
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     bx, ax
loc_23120:
    mov     word_40D70[bx], si
    mov     bx, [bp+var_20]
    mov     word_40D74[bx], di
    push    di
    push    si
    push    word ptr gnobshapes+6
    push    word ptr gnobshapes+4
    call    sprite_putimage_and_alt2
    add     sp, 8
    push    di
    push    si
    push    word ptr gnobshapes+2
    push    word ptr gnobshapes
    call    sprite_putimage_or_alt
    add     sp, 8
    cmp     video_flag5_is0, 0
    jz      short loc_2315E
    call    setup_mcgawnd2
    jmp     short loc_23168
    ; align 2
    db 144
loc_2315E:
    call    sprite_copy_2_to_1_2
    call    mouse_draw_opaque_check
loc_23168:
    push    height_above_replaybar
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    les     bx, whlshapes+10h
    push    word ptr es:[bx+0Ah]
    push    word ptr es:[bx+8]
    les     bx, whlsprite2
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage_and_alt
    add     sp, 8
loc_2319D:
    mov     [bp+var_1A], 0
    mov     ax, state.playerstate.car_steeringAngle
    cwd
    xor     ax, dx
    sub     ax, dx
    mov     cx, 3
    sar     ax, cl
    xor     ax, dx
    sub     ax, dx
    mov     [bp+var_4], ax
    mov     [bp+var_2], 1
    cmp     ax, 0FFF6h
    jge     short loc_231C4
    mov     [bp+var_2], 0
    jmp     short loc_231CE
loc_231C4:
    cmp     [bp+var_4], 0Ah
    jle     short loc_231CE
    mov     [bp+var_2], 2
loc_231CE:
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     al, [bp+var_2]
    cmp     byte_40DF0[bx], al
    jnz     short loc_231E7
    cmp     byte_454A4, 0
    jnz     short loc_231E7
    jmp     loc_23286
loc_231E7:
    cmp     video_flag5_is0, 0
    jnz     short loc_231F3
    call    mouse_draw_opaque_check
loc_231F3:
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     bx, ax
    cmp     word_40DF6[bx], 0
    jz      short loc_23239
    push    word_40DF6[bx]
    push    word_40DF2[bx]
    mov     al, byte_44346
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (gnobshapes+12h)[bx]
    push    word ptr (gnobshapes+10h)[bx]
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     word_40DF6[bx], 0
    mov     [bp+var_1A], 1
loc_23239:
    mov     al, [bp+var_2]
    cbw
    or      ax, ax
    jz      short loc_2324E
    cmp     ax, 1
    jz      short loc_23272
    cmp     ax, 2
    jz      short loc_2327C
    jmp     short loc_2325E
    ; align 2
    db 144
loc_2324E:
    push    word ptr whlshapes+2
    push    word ptr whlshapes
loc_23256:
    call    shape2d_op_unk3
    add     sp, 4
loc_2325E:
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     al, [bp+var_2]
    mov     byte_40DF0[bx], al
    mov     [bp+var_18], 1
    jmp     short loc_2328A
    ; align 2
    db 144
loc_23272:
    push    word ptr whlshapes+6
    push    word ptr whlshapes+4
    jmp     short loc_23256
loc_2327C:
    push    word ptr whlshapes+0Ah
    push    word ptr whlshapes+8
    jmp     short loc_23256
loc_23286:
    mov     [bp+var_18], 0
loc_2328A:
    mov     ax, simd_player.spdcenter.y2
    cmp     ax, 0FFFFh
    jz      short loc_232B6
    or      ax, ax
    jnz     short loc_23299
    jmp     loc_233A2
loc_23299:
    mov     [bp+var_6], 0
    mov     ax, state.playerstate.car_speed
    sub     dx, dx
    mov     cx, 280h
    div     cx
    mov     si, ax
    cmp     simd_player.spdnumpoints, si
    jg      short loc_232BC
    mov     si, simd_player.spdnumpoints
    dec     si
    jmp     short loc_232BC
loc_232B6:
    sub     si, si
    mov     [bp+var_6], 2
loc_232BC:
    mov     ax, state.playerstate.car_currpm
    mov     cl, 7
    shr     ax, cl
    mov     di, ax
    cmp     simd_player.revnumpoints, di
    jg      short loc_232D0
    mov     di, simd_player.revnumpoints
    dec     di
loc_232D0:
    cmp     [bp+var_18], 0
    jnz     short loc_232F7
    cmp     byte_454A4, 0
    jnz     short loc_232F7
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     bx, ax
    cmp     word_40D78[bx], si
    jnz     short loc_232F7
    cmp     word_40D6C[bx], di
    jnz     short loc_232F7
    jmp     loc_23540
loc_232F7:
    cmp     video_flag5_is0, 0
    jnz     short loc_23303
    call    mouse_draw_opaque_check
loc_23303:
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     bx, ax
    cmp     word_40DF6[bx], 0
    jz      short loc_23349
    push    word_40DF6[bx]
    push    word_40DF2[bx]
    mov     al, byte_44346
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (gnobshapes+12h)[bx]
    push    word ptr (gnobshapes+10h)[bx]
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     word_40DF6[bx], 0
    mov     [bp+var_1A], 1
loc_23349:
    push    word ptr whlsprite1+2
    push    word ptr whlsprite1
    call    sprite_set_1_from_argptr
    add     sp, 4
    sub     ax, ax
    push    ax
    push    ax
    push    word ptr whlshapes+0Eh
    push    word ptr whlshapes+0Ch
    call    shape2d_op_unk5
    add     sp, 8
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     bx, ax
    mov     word_40D78[bx], si
    mov     bx, [bp+var_20]
    mov     word_40D6C[bx], di
    cmp     [bp+var_6], 1
    jz      short loc_2338C
    jmp     loc_23456
loc_2338C:
    mov     [bp+var_8], 0
    cmp     si, 0C8h ; 'È'
    jl      short loc_233B2
    mov     [bp+var_8], 2
    sub     si, 0C8h ; 'È'
    jmp     short loc_233BF
loc_233A2:
    mov     [bp+var_6], 1
    mov     ax, state.playerstate.car_speed
    mov     cl, 8
    shr     ax, cl
    mov     si, ax
    jmp     loc_232BC
loc_233B2:
    cmp     si, 64h ; 'd'
    jl      short loc_233BF
    mov     [bp+var_8], 1
    sub     si, 64h ; 'd'
loc_233BF:
    cmp     [bp+var_8], 0
    jz      short loc_233EA
    mov     al, simd_player.spdpoints+1
    sub     ah, ah
    push    ax
    mov     al, simd_player.spdpoints
    push    ax
    mov     bx, [bp+var_8]
    shl     bx, 1
    shl     bx, 1
    push    word ptr (digshapes+2)[bx]
    push    word ptr digshapes[bx]
    call    sprite_putimage_or
    add     sp, 8
    mov     [bp+var_1C], 1
loc_233EA:
    mov     ax, si
    cwd
    mov     cx, 0Ah
    idiv    cx
    mov     [bp+var_8], ax
    or      ax, ax
    jnz     short loc_233FF
    cmp     [bp+var_1C], 0
    jz      short loc_23433
loc_233FF:
    mov     al, simd_player.spdpoints+3
    sub     ah, ah
    push    ax
    mov     al, simd_player.spdpoints+2
    push    ax
    mov     bx, [bp+var_8]
    shl     bx, 1
    shl     bx, 1
    push    word ptr (digshapes+2)[bx]
    push    word ptr digshapes[bx]
    call    sprite_putimage_or
    add     sp, 8
    mov     ax, [bp+var_8]
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    sub     si, ax
    mov     [bp+var_1C], 1
loc_23433:
    mov     al, simd_player.spdpoints+5
    sub     ah, ah
    push    ax
    mov     al, simd_player.spdpoints+4
    push    ax
    mov     bx, si
    shl     bx, 1
    shl     bx, 1
    push    word ptr (digshapes+2)[bx]
    push    word ptr digshapes[bx]
    call    sprite_putimage_or
    add     sp, 8
    jmp     short loc_23485
    ; align 2
    db 144
loc_23456:
    cmp     [bp+var_6], 0
    jnz     short loc_23485
    mov     ax, si
    shl     ax, 1
    mov     [bp+var_20], ax
    push    meter_needle_color
    mov     bx, ax
    mov     al, (simd_player.spdpoints+1)[bx]
    sub     ah, ah
    push    ax
    mov     al, simd_player.spdpoints[bx]
    push    ax
    push    simd_player.spdcenter.y2
    push    simd_player.spdcenter.x2
    call    preRender_line
    add     sp, 0Ah
loc_23485:
    mov     ax, di
    shl     ax, 1
    mov     [bp+var_20], ax
    push    meter_needle_color
    mov     bx, ax
    mov     al, (simd_player.revpoints+1)[bx]
    sub     ah, ah
    push    ax
    mov     al, simd_player.revpoints[bx]
    push    ax
    push    simd_player.revcenter.y2
    push    simd_player.revcenter.x2
    call    preRender_line
    add     sp, 0Ah
    mov     al, [bp+var_2]
    cbw
    or      ax, ax
    jz      short loc_234BE
    cmp     ax, 2           ; st. whl. position flag
    jz      short loc_234EC
    jmp     short loc_234DE
    ; align 2
    db 144
loc_234BE:
    push    word ptr whlshapes+1Eh
    push    word ptr whlshapes+1Ch
    call    shape2d_render_bmp_as_mask
    add     sp, 4
    push    word ptr whlshapes+16h
    push    word ptr whlshapes+14h
loc_234D6:
    call    shape2d_op_unk4
    add     sp, 4
loc_234DE:
    cmp     video_flag5_is0, 0
    jz      short loc_23506
    call    setup_mcgawnd2
    jmp     short loc_2350B
loc_234EC:
    push    word ptr whlshapes+22h
    push    word ptr whlshapes+20h
    call    shape2d_render_bmp_as_mask
    add     sp, 4
    push    word ptr whlshapes+1Ah
    push    word ptr whlshapes+18h
    jmp     short loc_234D6
loc_23506:
    call    sprite_copy_2_to_1_2
loc_2350B:
    push    height_above_replaybar
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    les     bx, whlshapes+0Ch
    push    es:[bx+SHAPE2D.s2d_pos_y]
    push    es:[bx+SHAPE2D.s2d_pos_x]
    les     bx, whlsprite1
    push    word ptr es:[bx+(SPRITE.sprite_bitmapptr+2)]
    push    word ptr es:[bx+SPRITE.sprite_bitmapptr]
    call    sprite_putimage_and_alt
    add     sp, 8
loc_23540:
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, [bp+var_4]
    cmp     word_40E00[bx], ax
    jnz     short loc_23561
    cmp     byte_454A4, 0
    jnz     short loc_23561
    cmp     [bp+var_1A], 0
    jnz     short loc_23561
    jmp     loc_236A0
loc_23561:
    cmp     video_flag5_is0, 0
    jnz     short loc_2356D
    call    mouse_draw_opaque_check
loc_2356D:
    push    height_above_replaybar
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     bx, ax
    cmp     word_40DF6[bx], 0
    jz      short loc_235C5
    push    word_40DF6[bx]
    push    word_40DF2[bx]
    mov     al, byte_44346
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (gnobshapes+12h)[bx]
    push    word ptr (gnobshapes+10h)[bx]
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     word_40DF6[bx], 0
loc_235C5:
    cmp     [bp+var_4], 0
    jge     short loc_235D2
    mov     ax, [bp+var_4]
    neg     ax
    jmp     short loc_235D5
loc_235D2:
    mov     ax, [bp+var_4]
loc_235D5:
    shl     ax, 1
    add     ax, offset simd_player.steeringdots
    mov     [bp+var_E], ax
    mov     bx, ax
    mov     al, [bx+1]
    mov     [bp+var_16], al
    mov     al, [bx]
    mov     [bp+var_14], al
    cmp     [bp+var_4], 0
    jge     short loc_235F9
    sub     al, simd_player.steeringdots
    shl     al, 1
    sub     [bp+var_14], al
loc_235F9:
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_20], ax
    mov     al, [bp+var_14]
    sub     ah, ah
    les     bx, gnobshapes+8
    sub     ax, es:[bx+4]
    and     ax, video_flag3_isFFFF
    mov     bx, [bp+var_20]
    mov     word_40DF2[bx], ax
    mov     al, [bp+var_16]
    sub     ah, ah
    les     bx, gnobshapes+8
    sub     ax, es:[bx+6]
    mov     bx, [bp+var_20]
    mov     word_40DF6[bx], ax
    mov     al, [bp+var_16]
    sub     ah, ah
    les     bx, gnobshapes+8
    sub     ax, es:[bx+6]
    push    ax
    mov     bx, [bp+var_20]
    push    word_40DF2[bx]
    mov     al, byte_44346
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (gnobshapes+12h)[bx]
    push    word ptr (gnobshapes+10h)[bx]
    call    sprite_clear_shape_alt
    add     sp, 8
    mov     al, [bp+var_16]
    sub     ah, ah
    push    ax
    mov     al, [bp+var_14]
    push    ax
    push    word ptr gnobshapes+0Eh
    push    word ptr gnobshapes+0Ch
    call    sprite_putimage_and_alt2
    add     sp, 8
    mov     al, [bp+var_16]
    sub     ah, ah
    push    ax
    mov     al, [bp+var_14]
    push    ax
    push    word ptr gnobshapes+0Ah
    push    word ptr gnobshapes+8
    call    sprite_putimage_or_alt
    add     sp, 8
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, [bp+var_4]
    mov     word_40E00[bx], ax
loc_236A0:
    call    mouse_draw_transparent_check
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_236AC:
    push    word ptr whlsprite3+2
    push    word ptr whlsprite3
    call    sprite_free_wnd
    add     sp, 4
    push    word ptr whlsprite2+2
    push    word ptr whlsprite2
    call    sprite_free_wnd
    add     sp, 4
    push    word ptr whlsprite1+2
    push    word ptr whlsprite1
    call    sprite_free_wnd
    add     sp, 4
    push    word ptr stdbresptr+2
    push    word ptr stdbresptr
    call    mmgr_free
    add     sp, 4
    push    word ptr stdaresptr+2
    push    word ptr stdaresptr
    call    mmgr_free
    add     sp, 4
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
setup_car_shapes endp
setup_player_cars proc far
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 8
    sub     ax, ax
    mov     word ptr wndsprite+2, ax
    mov     word ptr wndsprite, ax
    mov     ax, 2
    push    ax
    call    ensure_file_exists
    add     sp, 2
    mov     ax, offset gameconfig.game_opponentcarid
    push    ax
    mov     ax, offset gameconfig
    push    ax
    call    shape3d_load_car_shapes
    add     sp, 4
    mov     al, gameconfig.game_playercarid
    mov     byte ptr aCarcoun+3, al
    mov     al, gameconfig.game_playercarid+1
    mov     byte ptr aCarcoun+4, al
    mov     al, gameconfig.game_playercarid+2
    mov     byte ptr aCarcoun+5, al
    mov     al, gameconfig.game_playercarid+3
    mov     byte ptr aCarcoun+6, al
    mov     ax, offset aCarcoun; "carcoun"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    sub     ax, ax
    push    ax
    push    dx
    push    [bp+var_4]
    call    setup_aero_trackdata
    add     sp, 6
    push    [bp+var_2]
    push    [bp+var_4]
    call    unload_resource
    add     sp, 4
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_237D3
    mov     al, gameconfig.game_opponentcarid
    mov     byte ptr aCarcoun+3, al
    mov     al, gameconfig.game_opponentcarid+1
    mov     byte ptr aCarcoun+4, al
    mov     al, gameconfig.game_opponentcarid+2
    mov     byte ptr aCarcoun+5, al
    mov     al, gameconfig.game_opponentcarid+3
    mov     byte ptr aCarcoun+6, al
    mov     ax, offset aCarcoun; "carcoun"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    mov     ax, 1
    push    ax
    push    dx
    push    [bp+var_4]
    call    setup_aero_trackdata
    add     sp, 6
    push    [bp+var_2]
    push    [bp+var_4]
    call    unload_resource
    add     sp, 4
    mov     ax, 4
    push    ax
    call    ensure_file_exists
    add     sp, 2
    call    load_opponent_data
loc_237D3:
    mov     ax, 3
    push    ax
    call    ensure_file_exists
    add     sp, 2
    mov     ax, offset aEng1; "eng1"
    push    ax              ; char *
    mov     ax, 5
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr eng1ptr, ax
    mov     word ptr eng1ptr+2, dx
    mov     ax, offset aEng ; "eng"
    push    ax              ; char *
    mov     ax, 6
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr engptr, ax
    mov     word ptr engptr+2, dx
    call    audio_add_driver_timer
    push    word ptr engptr+2
    push    word ptr engptr
    push    word ptr eng1ptr+2
    push    word ptr eng1ptr
    mov     ax, offset unk_3E7FC
    push    ds
    push    ax
    mov     ax, 21h ; '!'
    push    ax
    call    audio_init_engine
    add     sp, 0Eh
    mov     word_43964, ax
    mov     byte_459D8, 0
    mov     byte_42D26, 0
    mov     byte_42D2A, 0
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_23870
    push    word ptr engptr+2
    push    word ptr engptr
    push    word ptr eng1ptr+2
    push    word ptr eng1ptr
    mov     ax, offset unk_3E82C
    push    ds
    push    ax
    mov     ax, 20h ; ' '
    push    ax
    call    audio_init_engine
    add     sp, 0Eh
    mov     word_4408C, ax
loc_23870:
    mov     word_44D1E, 0
    mov     word_449E4, 0
    mov     word_443F4, 0
    mov     ax, offset aFontled_fnt; "fontled.fnt"
    push    ax              ; char *
    sub     ax, ax
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr fontledresptr, ax
    mov     word ptr fontledresptr+2, dx
    mov     ax, timertestflag
    mov     timertestflag_copy, ax
    call    init_rect_arrays
    cmp     idle_expired, 0
    jnz     short loc_238B4
    sub     ax, ax
    push    ax
    push    cs
    call near ptr setup_car_shapes
    add     sp, 2
loc_238B4:
    cmp     idle_expired, 0
    jnz     short loc_238DE
    mov     ax, offset aSdgame; "sdgame"
    push    ax              ; char *
    mov     ax, 3
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr sdgameresptr, ax
    mov     word ptr sdgameresptr+2, dx
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
loc_238DE:
    mov     ax, offset aGame; "game"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     word ptr gameresptr, ax
    mov     word ptr gameresptr+2, dx
    mov     ax, offset aPlan; "plan"
    push    ax
    push    dx
    push    word ptr gameresptr
    call    locate_shape_alt
    add     sp, 6
    mov     word ptr planptr, ax
    mov     word ptr planptr+2, dx
    mov     ax, offset aWall; "wall"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_shape_alt
    add     sp, 6
    mov     word ptr wallptr, ax
    mov     word ptr wallptr+2, dx
    call    load_sdgame2_shapes
    les     bx, td14_elem_map_main
    mov     al, es:[bx+384h]; 384h = sky box position in track data
    sub     ah, ah
    push    ax
    call    load_skybox
    add     sp, 2
    call    shape3d_load_all
    or      ax, ax
    jz      short loc_2394E
loc_23946:
    mov     ax, 1
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_2394E:
    cmp     video_flag5_is0, 0
    jnz     short loc_239A3
    mov     ax, video_flag1_is1
    imul    video_flag4_is1
    cwd
    push    dx
    push    ax
    mov     ax, 0FA00h
    sub     dx, dx
    push    dx
    push    ax
    call    __aFldiv
    add     ax, 12h
    adc     dx, 0
    mov     [bp+var_8], ax
    mov     [bp+var_6], dx
    call    mmgr_get_res_ofs_diff_scaled
    cmp     dx, [bp+var_6]
    jg      short loc_23988
    jl      short loc_23946
    cmp     ax, [bp+var_8]
    jbe     short loc_23946
loc_23988:
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h ; 'È'
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
loc_239A3:
    mov     followOpponentFlag, 0
    mov     is_in_replay_copy, 0FFh
    sub     ax, ax
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
setup_player_cars endp
free_player_cars proc far

    cmp     video_flag5_is0, 0
    jnz     short loc_239D4
    mov     ax, word ptr wndsprite
    or      ax, word ptr wndsprite+2
    jz      short loc_239D4
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
loc_239D4:
    call    shape3d_free_all
    call    unload_skybox
    call    free_sdgame2
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    unload_resource
    add     sp, 4
    cmp     idle_expired, 0
    jnz     short loc_23A15
    push    word ptr sdgameresptr+2
    push    word ptr sdgameresptr
    call    mmgr_free
    add     sp, 4
    mov     ax, 3
    push    ax
    push    cs
    call near ptr setup_car_shapes
    add     sp, 2
loc_23A15:
    push    word ptr fontledresptr+2
    push    word ptr fontledresptr
    call    mmgr_free
    add     sp, 4
    call    audio_remove_driver_timer
    push    word ptr engptr+2
    push    word ptr engptr
    call    mmgr_free
    add     sp, 4
    push    word ptr eng1ptr+2
    push    word ptr eng1ptr
    call    mmgr_free
    add     sp, 4
    call    shape3d_free_car_shapes
    retf
free_player_cars endp
mouse_minmax_position proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    cmp     [bp+arg_0], 0
    jz      short loc_23A82
    mov     ax, 0C8h ; 'È'
    push    ax
    mov     ax, 131h
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 0Fh
    push    ax
    call    mouse_set_minmax
    add     sp, 8
    mov     ax, 64h ; 'd'
    push    ax
    mov     ax, 0A0h ; ' '
    push    ax
    call    mouse_set_position
    add     sp, 4
    pop     bp
    retf
loc_23A82:
    mov     ax, 0C8h ; 'È'
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    call    mouse_set_minmax
    add     sp, 8
    pop     bp
    retf
mouse_minmax_position endp
replay_unk proc far
    var_A = byte ptr -10
    var_8 = byte ptr -8
    var_6 = byte ptr -6
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    di
    push    si
    mov     si, state.game_frame
smart
    and     si, 3Fh
nosmart
    cmp     byte_442EA[si], 0
    jnz     short loc_23AB1
    jmp     loc_23B45
loc_23AB1:
    mov     al, byte_44292[si]
    cbw
    mov     di, ax
    mov     ax, state.playerstate.car_speed2
    mov     cl, 0Ah
    shr     ax, cl
smart
    and     al, 0FCh
nosmart
    mov     [bp+var_8], al
    cbw
    mov     bx, ax
    add     bx, steerWhlRespTable_ptr
    mov     al, [bx+1]
    mov     [bp+var_A], al
    cmp     state.playerstate.car_steeringAngle, di
    jge     short loc_23AE0
    cmp     state.playerstate.car_steeringAngle, 0FFFFh
    jge     short loc_23AF2
    jmp     short loc_23AED
loc_23AE0:
    cmp     state.playerstate.car_steeringAngle, di
    jle     short loc_23AF2
    cmp     state.playerstate.car_steeringAngle, 1
    jle     short loc_23AF2
loc_23AED:
    mov     cl, 2
    shl     [bp+var_A], cl
loc_23AF2:
    cmp     state.playerstate.car_steeringAngle, di
    jle     short loc_23B0C
    mov     al, [bp+var_A]
    cbw
    mov     cx, state.playerstate.car_steeringAngle
    sub     cx, ax
    cmp     cx, di
    jl      short loc_23B0C
    mov     [bp+var_6], 8
    jmp     short loc_23B28
loc_23B0C:
    cmp     state.playerstate.car_steeringAngle, di
    jge     short loc_23B24
    mov     al, [bp+var_A]
    cbw
    add     ax, state.playerstate.car_steeringAngle
    cmp     ax, di
    jg      short loc_23B24
    mov     [bp+var_6], 4
    jmp     short loc_23B28
loc_23B24:
    mov     [bp+var_6], 0
loc_23B28:
    cmp     [bp+var_6], 0
    jz      short loc_23B40
    mov     bx, state.game_frame
    add     bx, word ptr td16_rpl_buffer
    mov     es, word ptr td16_rpl_buffer+2
    mov     al, [bp+var_6]
    or      es:[bx], al     ; writing action into rpl buff?!
loc_23B40:
    mov     byte_442EA[si], 0
loc_23B45:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
replay_unk endp
loop_game proc far
    var_44 = word ptr -68
    var_42 = word ptr -66
    var_40 = byte ptr -64
    var_3E = byte ptr -62
    var_3D = byte ptr -61
    var_3C = byte ptr -60
    var_3B = byte ptr -59
    var_38 = byte ptr -56
    var_37 = byte ptr -55
    var_36 = byte ptr -54
    var_35 = byte ptr -53
    var_34 = byte ptr -52
    var_24 = word ptr -36
    var_22 = word ptr -34
    var_counter = byte ptr -32
    var_1E = byte ptr -30
    var_18 = word ptr -24
    var_inputcode = word ptr -22
    var_14 = byte ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_4 = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 44h
    push    di
    push    si
    mov     ax, [bp+arg_0]
    or      ax, ax
    jz      short loc_23B70
    cmp     ax, 1
    jz      short loc_23BA6
    cmp     ax, 2
    jz      short loc_23B8D
    cmp     ax, 3
    jnz     short loc_23B6D
    jmp     loc_23FB8
loc_23B6D:
    jmp     loc_24D5E
loc_23B70:
    mov     ax, offset rplyshapes
    push    ax
    mov     ax, offset aRplyrpicrpacrpmcrptcbof6bof5b; "rplyrpicrpacrpmcrptcbof6bof5bof4bof3bof"...
    push    ax
    push    word ptr sdgameresptr+2
    push    word ptr sdgameresptr
    call    locate_many_resources
    add     sp, 8
    mov     [bp+arg_2], 4
loc_23B8D:
    sub     si, si
loc_23B8F:
    mov     byte_40E6A[si], 0
    inc     si
    cmp     si, 9
    jl      short loc_23B8F
    mov     bx, [bp+arg_2]
    mov     byte_40E6A[bx], 1
    jmp     loc_24D5E
    ; align 2
    db 144
loc_23BA6:
    mov     al, byte_4432A
    cbw
    mov     [bp+var_42], ax
    mov     bx, ax
    cmp     byte_449D8[bx], 0
    jz      short loc_23BB9
    jmp     loc_23C66
loc_23BB9:
    mov     byte_449D8[bx], 1
    mov     bx, [bp+var_42]
    mov     byte_40E74[bx], 0FFh
    mov     bx, [bp+var_42]
    mov     byte_40E08[bx], 0FFh
    sub     si, si
loc_23BD0:
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     ax, si
    shl     ax, 1
    add     bx, ax
    mov     byte_40E7A[bx], 0
    inc     si
    cmp     si, 9
    jl      short loc_23BD0
    call    mouse_draw_opaque_check
    push    word ptr rplyshapes+2
    push    word ptr rplyshapes
    call    shape2d_op_unk
    add     sp, 4
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_42], ax
    mov     bx, ax
    mov     word_40E0A[bx], 0FFFFh
    mov     bx, [bp+var_42]
loc_23C10:
    mov     word_40E76[bx], 0FFFFh
    mov     ax, 1
    push    ax              ; int
    mov     ax, gameconfig.game_recordedframes
    add     ax, elapsed_time1
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    push    word ptr fontledresptr+2
    push    word ptr fontledresptr
    call    font_set_fontdef2
    add     sp, 4
    mov     ax, 0BBh ; '»'
    push    ax
    mov     ax, 0D8h ; 'Ø'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    sub_345BC
    add     sp, 6
    call    font_set_fontdef
loc_23C66:
    mov     ax, [bp+arg_4]
    add     ax, elapsed_time1
    mov     [bp+var_42], ax
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    add     ax, offset word_40E0A
    mov     [bp+var_44], ax
    mov     bx, ax
    mov     ax, [bp+var_42]
    cmp     [bx], ax
    jz      short loc_23CD7
    mov     [bx], ax
    mov     ax, 1
    push    ax              ; int
    push    [bp+var_42]
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    call    mouse_draw_opaque_check
    push    word ptr fontledresptr+2
    push    word ptr fontledresptr
    call    font_set_fontdef2
    add     sp, 4
    mov     ax, 0BBh ; '»'
    push    ax
    mov     ax, 98h ; '˜'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    sub_345BC
    add     sp, 6
    call    font_set_fontdef
loc_23CD7:
    mov     al, byte_4432A
    cbw
    mov     [bp+var_44], ax
    mov     bx, ax
    mov     al, cameramode
    cmp     byte_40E74[bx], al
    jz      short loc_23D46
    mov     byte_40E74[bx], al
    mov     bx, [bp+var_44]
    shl     bx, 1
    mov     word_40E76[bx], 0FFFFh
    call    mouse_draw_opaque_check
    mov     al, cameramode
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (rplyshapes+6)[bx]
    push    word ptr (rplyshapes+4)[bx]
    call    shape2d_op_unk
    add     sp, 4
    mov     al, cameramode
    cbw
    mov     bx, ax
    mov     al, game_camera_buttons_count[bx]
    mov     byte ptr [bp+var_42], al
    mov     al, byte_3E9DB
    cmp     byte ptr [bp+var_42], al
    jge     short loc_23D32
    mov     al, byte ptr [bp+var_42]
    mov     byte_3E9DB, al
loc_23D32:
    mov     al, byte_4432A
    cbw
    add     ax, offset byte_40E08
    mov     [bp+var_44], ax
    mov     bx, ax
    cmp     byte ptr [bx], 6
    jle     short loc_23D46
    mov     byte ptr [bx], 0FFh
loc_23D46:
    cmp     gameconfig.game_recordedframes, 0
    jnz     short loc_23D54
    sub     si, si
    sub     di, di
    jmp     short loc_23D94
    ; align 2
    db 144
loc_23D54:
    mov     ax, gameconfig.game_recordedframes
    cwd
    push    dx
    push    ax
    mov     ax, 6Eh ; 'n'
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_2]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     si, ax
    mov     ax, gameconfig.game_recordedframes
    cwd
    push    dx
    push    ax
    mov     ax, 6Eh ; 'n'
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_4]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     di, ax
loc_23D94:
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_44], ax
    mov     bx, ax
    cmp     word_40E76[bx], si
    jnz     short loc_23DAB
    cmp     word_40E04[bx], di
    jz      short loc_23E1A
loc_23DAB:
    call    mouse_draw_opaque_check
    mov     al, byte_4432A
    cbw
    shl     ax, 1
    mov     [bp+var_44], ax
    mov     bx, ax
    mov     word_40E76[bx], si
    mov     bx, [bp+var_44]
    mov     word_40E04[bx], di
    push    word_407FC
    mov     ax, 6
    push    ax
    mov     ax, 74h ; 't'
    push    ax
    mov     ax, 0B1h ; '±'
    push    ax
    mov     ax, 9Ah ; 'š'
    push    ax
    call    sprite_1_unk
    add     sp, 0Ah
    push    dialog_fnt_colour
    mov     ax, 6
    push    ax
    push    ax
    mov     ax, 0B1h ; '±'
    push    ax
    lea     ax, [si+9Ah]
    push    ax
    call    sprite_1_unk
    add     sp, 0Ah
    push    word_407FE
    mov     ax, 0B6h ; '¶'
    push    ax
    lea     ax, [di+9Fh]
    push    ax
    mov     ax, 0B1h ; '±'
    push    ax
    lea     ax, [di+9Ah]
    push    ax
    call    sprite_1_unk4
    add     sp, 0Ah
loc_23E1A:
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     al, byte_3E9DB
    cmp     byte_40E08[bx], al
    jz      short loc_23E68
loc_23E29:
    call    mouse_draw_opaque_check
    mov     al, byte_4432A
    cbw
    mov     [bp+var_44], ax
    mov     bx, ax
    cmp     byte_40E08[bx], 0FFh
    jnz     short loc_23E41
    jmp     loc_23EC6
loc_23E41:
    mov     al, byte_40E08[bx]
    cbw
    mov     [bp+var_42], ax
    mov     bx, ax
    shl     bx, 1
    add     bx, [bp+var_44]
    cmp     byte_40E7A[bx], 0
    jz      short loc_23E9A
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (rplyshapes+3Ah)[bx]
    push    word ptr (rplyshapes+38h)[bx]
    jmp     short loc_23EB3
    ; align 2
    db 144
loc_23E68:
    mov     [bp+var_counter], 0
    jmp     short loc_23E71
loc_23E6E:
    inc     [bp+var_counter]
loc_23E71:
    cmp     [bp+var_counter], 7
    jl      short loc_23E7A
    jmp     loc_23FB0
loc_23E7A:
    mov     al, [bp+var_counter]
    cbw
    mov     [bp+var_44], ax
    mov     bx, ax
    mov     al, byte_40E6A[bx]
    mov     cx, ax
    mov     al, byte_4432A
    cbw
    shl     bx, 1
    add     bx, ax
    cmp     byte_40E7A[bx], cl
    jz      short loc_23E6E
    jmp     short loc_23E29
    ; align 2
    db 144
loc_23E9A:
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     al, byte_40E08[bx]
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    push    word ptr (rplyshapes+16h)[bx]
    push    word ptr (rplyshapes+14h)[bx]
loc_23EB3:
    call    shape2d_op_unk
    add     sp, 4
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     byte_40E08[bx], 0FFh
loc_23EC6:
    mov     [bp+var_counter], 0
loc_23ECA:
    mov     al, [bp+var_counter]
    cbw
    mov     [bp+var_44], ax
    mov     bx, ax
    cmp     byte_40E6A[bx], 0
    jnz     short loc_23F18
    mov     al, byte_40E6A[bx]
    mov     cx, ax
    mov     al, byte_4432A
    cbw
    shl     bx, 1
    add     bx, ax
    cmp     byte_40E7A[bx], cl
    jz      short loc_23F18
    mov     bx, [bp+var_44]
    shl     bx, 1
    shl     bx, 1
    push    word ptr (rplyshapes+16h)[bx]
    push    word ptr (rplyshapes+14h)[bx]
    call    shape2d_op_unk
    add     sp, 4
    mov     al, [bp+var_counter]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     al, byte_4432A
    cbw
    add     bx, ax
    mov     byte_40E7A[bx], 0
loc_23F18:
    inc     [bp+var_counter]
    cmp     [bp+var_counter], 7
    jl      short loc_23ECA
    mov     [bp+var_counter], 0
loc_23F25:
    mov     al, [bp+var_counter]
    cbw
    mov     [bp+var_44], ax
    mov     bx, ax
    cmp     byte_40E6A[bx], 0
    jz      short loc_23F6C
    mov     al, byte_4432A
    cbw
    shl     bx, 1
    add     bx, ax
    mov     byte_40E7A[bx], 1
    mov     bx, [bp+var_44]
    shl     bx, 1
    shl     bx, 1
    push    word ptr (rplyshapes+3Ah)[bx]
    push    word ptr (rplyshapes+38h)[bx]
    call    shape2d_op_unk
    add     sp, 4
    mov     al, [bp+var_counter]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     al, byte_4432A
    cbw
    add     bx, ax
    mov     byte_40E7A[bx], 1
loc_23F6C:
    inc     [bp+var_counter]
    cmp     [bp+var_counter], 7
    jl      short loc_23F25
    mov     al, byte_4432A
    cbw
    mov     bx, ax
    mov     al, byte_3E9DB
    mov     byte_40E08[bx], al
    cmp     byte_3E9DB, 0FFh
    jz      short loc_23FB0
    mov     al, byte_3E9DB
    cbw
    shl     ax, 1
    mov     [bp+var_44], ax
    push    word_407FE
    mov     bx, ax
    push    game_camera_buttons_y2[bx]
    push    game_camera_buttons_x2[bx]
    push    game_camera_buttons_y1[bx]
    push    game_camera_buttons_x1[bx]
    call    sprite_1_unk4
    add     sp, 0Ah
loc_23FB0:
    call    mouse_draw_transparent_check
    jmp     loc_24D5E
loc_23FB8:
    mov     al, cameramode
    cbw
    mov     bx, ax
    mov     al, game_camera_buttons_count[bx]
    mov     byte ptr [bp+var_44], al
    mov     al, byte_3E9DB
    cmp     byte ptr [bp+var_44], al
    jge     short loc_23FDA
    cmp     cameramode, 2
    jz      short loc_23FDA
    mov     al, byte ptr [bp+var_44]
    mov     byte_3E9DB, al
loc_23FDA:
    call    sprite_copy_2_to_1
    cmp     video_flag5_is0, 0
    jz      short loc_23FEE
    mov     al, byte_44346
    xor     al, 1
    mov     byte_4432A, al
loc_23FEE:
    call    timer_get_delta_alt
    push    ax
    call    input_checking
    add     sp, 2
    mov     [bp+var_inputcode], ax
    mov     ax, offset game_camera_buttons_y2
    push    ax
    mov     ax, offset game_camera_buttons_y1
    push    ax
    mov     ax, offset game_camera_buttons_x2
    push    ax
    mov     ax, offset game_camera_buttons_x1
    push    ax
    mov     al, cameramode
    cbw
    mov     bx, ax
    mov     al, game_camera_buttons_count[bx]; get number of buttons by cameramode
    cbw
    inc     ax
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_counter], al
    cmp     al, 0FFh
    jnz     short loc_2402E
    jmp     loc_240D8
loc_2402E:
    mov     al, byte_3E9DB
    cmp     [bp+var_counter], al
    jz      short loc_24041
    cmp     [bp+var_inputcode], 0
    jnz     short loc_24041
    mov     [bp+var_inputcode], 1
loc_24041:
    mov     al, [bp+var_counter]
    mov     byte_3E9DB, al
    cmp     [bp+var_inputcode], 20h ; ' '
    jz      short loc_24056
    cmp     [bp+var_inputcode], 0Dh
    jz      short loc_24056
    jmp     loc_2410C
loc_24056:
    cmp     byte_3E9DB, 7
    jge     short loc_24060
    jmp     loc_2410C
loc_24060:
    jnz     short loc_24082
    mov     ax, word_3EA3A
    add     ax, word_3EA4C
    sar     ax, 1
    cmp     ax, mouse_ypos
    jge     short loc_2407A
loc_24071:
    mov     [bp+var_inputcode], 5000h
    jmp     loc_2410C
    ; align 2
    db 144
loc_2407A:
    mov     [bp+var_inputcode], 4800h
    jmp     loc_2410C
loc_24082:
    mov     ax, word_3EA3C
    add     ax, word_3EA4E
    sar     ax, 1
    sub     ax, mouse_ypos
    push    ax
    mov     ax, mouse_xpos
    mov     cx, word_3EA18
    add     cx, word_3EA2A
    sar     cx, 1
    sub     ax, cx
    push    ax
    call    polarAngle
    add     sp, 4
    add     ax, 80h ; '€'
smart
    and     ah, 3
nosmart
    mov     cl, 8
    shr     ax, cl
    or      ax, ax
    jz      short loc_2407A
    cmp     ax, 1
    jz      short loc_240C8
    cmp     ax, 2
    jz      short loc_24071
    cmp     ax, 3
    jz      short loc_240D0
    jmp     short loc_2410C
    ; align 2
    db 144
loc_240C8:
    mov     [bp+var_inputcode], 4D00h
    jmp     short loc_2410C
    ; align 2
    db 144
loc_240D0:
    mov     [bp+var_inputcode], 4B00h
    jmp     short loc_2410C
    ; align 2
    db 144
loc_240D8:
    mov     ax, offset gameunk_button_y2
    push    ax
    mov     ax, offset gameunk_button_y1
    push    ax
    mov     ax, offset gameunk_button_x2
    push    ax
    mov     ax, offset gameunk_button_x1
    push    ax
    mov     ax, 1
    push    ax
    call    mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_counter], al
    or      al, al
    jnz     short loc_2410C
    cmp     [bp+var_inputcode], 20h ; ' '
    jz      short loc_24107
    cmp     [bp+var_inputcode], 0Dh
    jnz     short loc_2410C
loc_24107:
    mov     [bp+var_inputcode], 63h ; 'c'
loc_2410C:
    cmp     [bp+var_inputcode], 0
    jz      short loc_24129
    cmp     [bp+var_inputcode], 1Bh
    jz      short loc_24129
    push    [bp+var_inputcode]
    push    cs
    call near ptr handle_ingame_kb_shortcuts
    add     sp, 2
    or      al, al
    jz      short loc_24129
    jmp     loc_24D5E
loc_24129:
    cmp     is_in_replay, 0
    jnz     short loc_2415A
    cmp     [bp+var_inputcode], 0
    jnz     short loc_2415A
    cmp     replaybar_enabled, 0
    jnz     short loc_24140
    jmp     loc_24D5E
loc_24140:
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_2415A:
    cmp     replaybar_enabled, 0
    jnz     short loc_2416C
    mov     is_in_replay_copy, 0FFh
    mov     word_449EA, 0FFFFh
loc_2416C:
    cmp     is_in_replay, 0
    jz      short loc_24193
    cmp     byte_40E6D, 0
    jnz     short loc_24181
    cmp     byte_40E6C, 0
    jz      short loc_24193
loc_24181:
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
loc_24193:
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    mov     [bp+var_40], 0
    mov     ax, 1Dh
    push    ax
    call    kb_get_key_state
    add     sp, 2
    or      ax, ax
    jnz     short loc_241C8
    cmp     byte_3E9DB, 8
    jnz     short loc_241CC
    test    byte ptr kbjoyflags, 30h
    jz      short loc_241CC
loc_241C8:
    mov     [bp+var_40], 1
loc_241CC:
    cmp     [bp+var_40], 0
    jz      short loc_241FE
    mov     ax, [bp+var_inputcode]
    cmp     ax, 2Bh ; '+'
    jnz     short loc_241DD
    jmp     loc_2429C
loc_241DD:
    cmp     ax, 2Dh ; '-'
    jnz     short loc_241E5
    jmp     loc_2426E
loc_241E5:
    cmp     ax, 4800h
    jz      short loc_24242
    cmp     ax, 4B00h
    jz      short loc_24236
    cmp     ax, 4D00h
    jz      short loc_2422A
    cmp     ax, 5000h
    jz      short loc_24258
loc_241F9:
    mov     [bp+var_inputcode], 0
loc_241FE:
    mov     ax, [bp+var_inputcode]
    cmp     ax, 2Bh ; '+'
    jnz     short loc_24209
    jmp     loc_2429C
loc_24209:
    jbe     short loc_2420E
    jmp     loc_24D32
loc_2420E:
    cmp     ax, 0Dh
    jnz     short loc_24216
    jmp     loc_24334
loc_24216:
    cmp     ax, 1Bh
    jnz     short loc_2421E
    jmp     loc_24346
loc_2421E:
    cmp     ax, 20h ; ' '
    jnz     short loc_24226
    jmp     loc_24334
loc_24226:
    jmp     loc_242E7
    ; align 2
    db 144
loc_2422A:
    add     word_3B8EE, 10h
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_24236:
    sub     word_3B8EE, 10h
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_24242:
    mov     ax, word_3B8F0
    add     ax, 10h
    cmp     ax, 100h
    jge     short loc_241F9
    add     word_3B8F0, 10h
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_24258:
    mov     ax, word_3B8F0
    sub     ax, 10h
    cmp     ax, 0FF00h
    jle     short loc_241F9
    sub     word_3B8F0, 10h
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_2426E:
    cmp     cameramode, 3
    jnz     short loc_24288
    cmp     word_44D20, 0
    jg      short loc_2427F
    jmp     loc_241F9
loc_2427F:
    sub     word_44D20, 1Eh
    jmp     loc_24D5E
    ; align 2
    db 144
loc_24288:
    cmp     word_3B8EC, 5DCh
    jl      short loc_24293
    jmp     loc_241F9
loc_24293:
    add     word_3B8EC, 1Eh
    jmp     loc_24D5E
    ; align 2
    db 144
loc_2429C:
    cmp     cameramode, 3
    jnz     short loc_242B6
    cmp     word_44D20, 384h
    jl      short loc_242AE
    jmp     loc_241F9
loc_242AE:
    add     word_44D20, 1Eh
    jmp     loc_24D5E
loc_242B6:
    cmp     word_3B8EC, 78h ; 'x'
    jg      short loc_242C0
    jmp     loc_241F9
loc_242C0:
    sub     word_3B8EC, 1Eh
    jmp     loc_24D5E
loc_242C8:
    mov     al, byte_3E9DB
    cbw
    mov     bx, ax
    mov     al, byte_3E9DC[bx]
    mov     byte ptr [bp+var_44], al
    mov     al, cameramode
    cbw
    mov     bx, ax
    mov     al, byte ptr [bp+var_44]
    cmp     game_camera_buttons_count[bx], al
    jl      short loc_242E7
loc_242E4:
    mov     byte_3E9DB, al
loc_242E7:
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    jmp     loc_23FEE
    ; align 2
    db 144
loc_242FE:
    mov     al, byte_3E9DB
    cbw
    mov     bx, ax
    mov     al, byte_3E9E6[bx]
    jmp     short loc_242E4
loc_2430A:
    cmp     byte_3E9DB, 7
    jz      short loc_2429C
    mov     al, byte_3E9DB
    cbw
    mov     bx, ax
    mov     al, byte_3E9F0[bx]
    jmp     short loc_242E4
    ; align 2
    db 144
loc_2431E:
    cmp     byte_3E9DB, 7
    jnz     short loc_24328
    jmp     loc_2426E
loc_24328:
    mov     al, byte_3E9DB
    cbw
    mov     bx, ax
    mov     al, byte_3E9FA[bx]
    jmp     short loc_242E4
loc_24334:
    mov     al, byte_3E9DB
    cbw
    cmp     ax, 6
    ja      short loc_242E7
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_24D20[bx]
    ; align 2
    db 144
loc_24346:
    mov     is_in_replay, 1
    call    audio_carstate
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    sub     si, si
loc_24377:
    mov     bx, si
    shl     bx, 1
    add     bx, bp
    mov     word ptr [bx-14h], 0
    inc     si
    cmp     si, 8
    jl      short loc_24377
    cmp     state.playerstate.car_crashBmpFlag, 0
    jz      short loc_24394
    mov     [bp+var_E], 1
loc_24394:
    cmp     gameconfig.game_recordedframes, 0
    jz      short loc_243A2
    cmp     elapsed_time1, 0
    jz      short loc_243A7
loc_243A2:
    mov     [bp+var_A], 1
loc_243A7:
    cmp     passed_security, 0
    jnz     short loc_243B8
    mov     [bp+var_10], 1
    mov     [bp+var_E], 1
loc_243B8:
    test    byte_43966, 4
    jnz     short loc_243C4
    mov     [bp+var_12], 1
loc_243C4:
    mov     al, video_flag6_is1; pause menu
    mov     byte_454A4, al
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_14]
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMen_0; "men"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 2
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     [bp+var_2], al
    cbw
    sub     ax, 1
    cmp     ax, 6
    jbe     short loc_2440E
    jmp     loc_24828
loc_2440E:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_2481A[bx]
loc_24416:
    call    check_input
    mov     ax, framespersec2
    mov     framespersec, ax
    mov     al, byte ptr framespersec2
    mov     byte ptr gameconfig.game_framespersec, al
    mov     ax, 0FFFFh
    push    ax
    call    init_game_state
    add     sp, 2
    mov     elapsed_time2, 0
    mov     gameconfig.game_recordedframes, 0
    mov     byte ptr word_45D3E, 0
    mov     byte_43966, 1
    jmp     short loc_244B0
    ; align 2
    db 144
loc_2444C:
    test    byte_43966, 2
    jz      short loc_2445A
loc_24453:
    mov     byte_43966, 3
    jmp     short loc_244A7
loc_2445A:
    mov     ax, elapsed_time2
    cmp     gameconfig.game_recordedframes, ax
    jz      short loc_244A2
    sub     ax, ax
    push    ax
    push    ax
    push    performGraphColor
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aCon_0; RH warning
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 2
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     si, ax
    cmp     si, 1
    jge     short loc_2449F
    jmp     loc_24828
loc_2449F:
    jmp     short loc_24453
    ; align 2
    db 144
loc_244A2:
    mov     byte_43966, 1
loc_244A7:
    mov     ax, state.game_frame
    mov     elapsed_time2, ax
    mov     gameconfig.game_recordedframes, ax
loc_244B0:
    mov     dashb_toggle, 1
    mov     show_penalty_counter, 0
    mov     followOpponentFlag, 0
    mov     game_replay_mode, 0
    mov     cameramode, 0
    mov     state.game_3F6autoLoadEvalFlag, 0
    mov     state.game_frame_in_sec, 0
    mov     byte_449E6, 0
    sub     ax, ax
    push    ax
    mov     ax, 3
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    mov     is_in_replay, 0
    mov     al, byte_3B8F2
    cbw
    push    ax
    push    cs
    call near ptr mouse_minmax_position
    add     sp, 2
    call    check_input
    mov     kbormouse, 0
    jmp     loc_24828
    ; align 2
    db 144
loc_2450A:
    mov     byte_43966, 0
    call    audio_carstate
    mov     ax, offset aRep ; "rep"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx              ; int
    push    ax              ; int
    mov     ax, offset a_rpl_1; ".rpl"
    push    ax              ; int
    mov     ax, 140h
    push    ax
    mov     ax, offset byte_3B85E
    push    ax              ; char *
    call    do_fileselect_dialog
    add     sp, 0Ah
    cbw
    mov     si, ax
    or      si, si
    jnz     short loc_24548
    jmp     loc_24828
loc_24548:
    mov     waitflag, 96h ; '–'
    call    show_waiting
    push    si
    push    di
    lea     di, [bp+var_3E]
    mov     si, 9234h
    push    ss
    pop     es
    mov     cx, 0Dh
    repne movsw
    pop     di
    pop     si
    les     bx, td14_elem_map_main
    mov     al, es:[bx+384h]
    sub     ah, ah
    mov     [bp+var_4], ax
    mov     ax, 140h
    push    ax
    mov     ax, 0EEh ; 'î'
    push    ax              ; char *
    push    cs
    call near ptr file_load_replay
    add     sp, 4
    or      al, al
    jz      short loc_2458B
    mov     gameconfig.game_recordedframes, 0
loc_2458B:
    mov     dashb_toggle, 0
    call    track_setup
    sub     si, si
    les     bx, td14_elem_map_main
    mov     al, es:[bx+384h]
    sub     ah, ah
    cmp     ax, [bp+var_4]
    jz      short loc_245AA
    mov     si, 1
loc_245AA:
    mov     al, gameconfig.game_playercarid
    cmp     [bp+var_3E], al
    jnz     short loc_245CA
    mov     al, gameconfig.game_playercarid+1
    cmp     [bp+var_3D], al
    jnz     short loc_245CA
    mov     al, gameconfig.game_playercarid+2
    cmp     [bp+var_3C], al
    jnz     short loc_245CA
    mov     al, gameconfig.game_playercarid+3
    cmp     [bp+var_3B], al
    jz      short loc_245D0
loc_245CA:
    mov     si, 1
    jmp     short loc_2460D
    ; align 2
    db 144
loc_245D0:
    mov     al, gameconfig.game_opponenttype
    cmp     [bp+var_38], al
    jnz     short loc_245CA
    or      al, al
    jz      short loc_2460D
    mov     al, gameconfig.game_opponentcarid
    cmp     [bp+var_37], al
    jnz     short loc_245CA
    mov     al, gameconfig.game_opponentcarid+1
    cmp     [bp+var_36], al
    jnz     short loc_245CA
    mov     al, gameconfig.game_opponentcarid+2
    cmp     [bp+var_35], al
    jnz     short loc_245CA
    mov     al, gameconfig.game_opponentcarid+3
    cmp     [bp+var_34], al
    jnz     short loc_245CA
    mov     ax, 2
    push    ax
    call    ensure_file_exists
    add     sp, 2
    call    load_opponent_data
loc_2460D:
    or      si, si
    jz      short loc_24619
    push    cs
    call near ptr free_player_cars
    push    cs
    call near ptr setup_player_cars
loc_24619:
    mov     al, byte ptr gameconfig.game_framespersec
    cbw
    mov     framespersec, ax
    mov     ax, 0FFFFh
    push    ax
    call    init_game_state
    add     sp, 2
    jmp     loc_24828
    ; align 2
    db 144
loc_24630:
    call    audio_carstate
loc_24635:
    mov     [bp+var_1E], 0
loc_24639:
    cmp     [bp+var_1E], 0
    jz      short loc_24642
    jmp     loc_24828
loc_24642:
    mov     ax, offset aRep_1; "rep"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx              ; int
    push    ax              ; int
    mov     ax, 140h
    push    ax
    mov     ax, 0EEh ; 'î'
    push    ax              ; char *
    call    do_savefile_dialog
    add     sp, 8
    or      al, al
    jnz     short loc_2466F
    jmp     loc_246F0
loc_2466F:
    mov     ax, offset g_path_buf
    push    ax              ; char *
    mov     ax, offset a_rpl_2; ".rpl"
    push    ax              ; int
    mov     ax, 140h
    push    ax
    mov     ax, 0EEh ; 'î'
    push    ax              ; char *
    call    file_build_path
    add     sp, 8
    mov     [bp+var_1E], 1
    mov     g_is_busy, 1
    mov     ax, offset g_path_buf
    push    ax
    call    file_find
    add     sp, 2
    or      ax, ax
    jz      short loc_246E8
    sub     ax, ax
    push    ax
    push    ax
    push    performGraphColor
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aFex_0; "fex"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 2
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     si, ax
    cmp     si, 0FFFFh
    jnz     short loc_246E0
    mov     [bp+var_1E], 0FFh
    jmp     short loc_246E8
    ; align 2
    db 144
loc_246E0:
    or      si, si
    jnz     short loc_246E8
    mov     [bp+var_1E], 0
loc_246E8:
    mov     g_is_busy, 0
    jmp     short loc_246F4
    ; align 2
    db 144
loc_246F0:
    mov     [bp+var_1E], 0FFh
loc_246F4:
    cmp     [bp+var_1E], 1
    jz      short loc_246FD
    jmp     loc_24639
loc_246FD:
    mov     ax, offset g_path_buf
    push    ax
    push    cs
    call near ptr file_write_replay
    add     sp, 2
    mov     [bp+var_counter], al
    or      al, al
    jnz     short loc_24712
    jmp     loc_24639
loc_24712:
    sub     ax, ax
    push    ax
    push    ax
    push    performGraphColor
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aSer_0; "ser"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 1
    push    ax
    call    show_dialog
    add     sp, 12h
    jmp     loc_24635
    ; align 2
    db 144
loc_24748:
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    call    update_crash_state
    add     sp, 4
loc_24757:
    mov     byte_449DA, 2
    jmp     loc_24828
    ; align 2
    db 144
loc_24760:
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    call    update_crash_state
    add     sp, 4
    mov     byte_43966, 0
    jmp     short loc_24757
loc_24776:
    sub     si, si
loc_24778:
    mov     bx, si
    shl     bx, 1
    add     bx, bp
    mov     word ptr [bx-14h], 0
    inc     si
    cmp     si, 5
    jl      short loc_24778
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_24795
    mov     [bp+var_C], 1
loc_24795:
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_14]
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMdo ; "mdo"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 2
    push    ax
    call    show_dialog
    add     sp, 12h
    mov     [bp+var_2], al
    cbw
    or      ax, ax
    jz      short loc_247E8
    cmp     ax, 1
    jz      short loc_247F0
    cmp     ax, 2
    jz      short loc_247F8
    cmp     ax, 3
    jz      short loc_2480A
    cmp     ax, 4
    jz      short loc_24812
    jmp     short loc_24828
loc_247E8:
    xor     dashb_toggle, 1
    jmp     short loc_24828
    ; align 2
    db 144
loc_247F0:
    xor     replaybar_toggle, 1; "replay bar on/off (while driving)"
    jmp     short loc_24828
    ; align 2
    db 144
loc_247F8:
    inc     cameramode
    cmp     cameramode, 4
    jnz     short loc_24828
    mov     cameramode, 0
    jmp     short loc_24828
loc_2480A:
    call    do_mrl_textres
    jmp     short loc_24828
    ; align 2
    db 144
loc_24812:
    xor     followOpponentFlag, 1
    jmp     short loc_24828
    ; align 2
    db 144
off_2481A     dw offset loc_24748
    dw offset loc_24416
    dw offset loc_2444C     ; modifying this to 0x2CB8 disables Continue Driving
    dw offset loc_2450A
    dw offset loc_24630
    dw offset loc_24776
    dw offset loc_24760
loc_24828:
    call    check_input
    jmp     loc_24D5E
loc_24830:
    mov     is_in_replay, 1
    call    audio_carstate
    sub     ax, ax
    push    ax
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    call    timer_get_delta_alt
    mov     [bp+var_24], 14h
    mov     [bp+var_22], 0
    jmp     loc_248F4
    ; align 2
    db 144
loc_2485C:
    mov     ax, 32h ; '2'
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    mov     di, ax
    add     di, 3
    cmp     di, 64h ; 'd'
    jle     short loc_2487A
    mov     di, 64h ; 'd'
loc_2487A:
    call    timer_get_delta_alt
    mov     [bp+var_18], ax
    imul    di
    mov     si, ax
    cwd
    add     [bp+var_24], ax
    adc     [bp+var_22], dx
    mov     ax, gameconfig.game_recordedframes
    sub     ax, elapsed_time2
    mov     [bp+var_44], ax
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    cmp     ax, [bp+var_44]
    jbe     short loc_248C4
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    push    [bp+var_44]
    call    __aFlmul
    mov     [bp+var_24], ax
    mov     [bp+var_22], dx
loc_248C4:
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    add     ax, elapsed_time2
    push    ax
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    push    [bp+var_18]
    call    input_do_checking
    add     sp, 2
loc_248F4:
    test    byte ptr kbjoyflags, 30h
    jz      short loc_248FE
    jmp     loc_2485C
loc_248FE:
    mov     ax, gameconfig.game_recordedframes
    sub     ax, elapsed_time2
    mov     [bp+var_44], ax
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    cmp     ax, [bp+var_44]
    jbe     short loc_24935
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    push    [bp+var_44]
    call    __aFlmul
    mov     [bp+var_24], ax
    mov     [bp+var_22], dx
loc_24935:
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    mov     si, ax
    add     si, elapsed_time2
    cmp     gameconfig.game_recordedframes, si
    jge     short loc_24956
    mov     si, gameconfig.game_recordedframes
loc_24956:
    push    si
    call    restore_gamestate
    add     sp, 2
    mov     elapsed_time2, si
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    mov     ax, offset aWai_0; "wai"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    cmp     timertestflag_copy, 0
    jz      short loc_249D2
    push    rectptr_unk2
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 64h ; 'd'
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
    push    ax
    push    rectptr_unk2
    call    rect_union
    jmp     short loc_24A0D
loc_249D2:
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 64h ; 'd'
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
    jmp     short loc_24A10
loc_249F8:
    call    update_gamestate
    push    elapsed_time2
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
loc_24A0D:
    add     sp, 6
loc_24A10:
    mov     ax, elapsed_time2
    cmp     state.game_frame, ax
loc_24A17:
    jnz     short loc_249F8
loc_24A19:
    mov     ax, 3E8h
    push    ax
    call    input_do_checking
    add     sp, 2
    jmp     loc_24D5E
loc_24A28:
    mov     is_in_replay, 1
    call    audio_carstate
    sub     ax, ax
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    call    timer_get_delta_alt
    mov     [bp+var_24], 14h
    mov     [bp+var_22], 0
    jmp     loc_24AEA
    ; align 4
    db 144
    db 144
loc_24A58:
    mov     ax, 32h ; '2'
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    mov     di, ax
    add     di, 3
    cmp     di, 64h ; 'd'
    jle     short loc_24A76
    mov     di, 64h ; 'd'
loc_24A76:
    call    timer_get_delta_alt
    mov     [bp+var_18], ax
    imul    di
    mov     si, ax
    cwd
    add     [bp+var_24], ax
    adc     [bp+var_22], dx
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    cmp     ax, elapsed_time2
    jbe     short loc_24AB8
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    push    elapsed_time2
    call    __aFlmul
    mov     [bp+var_24], ax
    mov     [bp+var_22], dx
loc_24AB8:
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    mov     cx, elapsed_time2
    sub     cx, ax
    push    cx
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    push    [bp+var_18]
    call    input_do_checking
    add     sp, 2
loc_24AEA:
    test    byte ptr kbjoyflags, 30h
    jz      short loc_24AF4
    jmp     loc_24A58
loc_24AF4:
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    cmp     ax, elapsed_time2
    jbe     short loc_24B23
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    push    elapsed_time2
    call    __aFlmul
    mov     [bp+var_24], ax
    mov     [bp+var_22], dx
loc_24B23:
    mov     ax, 14h
    cwd
    push    dx
    push    ax
    push    [bp+var_22]
    push    [bp+var_24]
    call    __aFldiv
    mov     di, ax
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    or      di, di
    jnz     short loc_24B4F
    jmp     loc_24C43
loc_24B4F:
    mov     ax, offset aWai_1; "wai"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    copy_string
    add     sp, 6
    cmp     timertestflag_copy, 0
    jz      short loc_24BB0
    push    rectptr_unk2
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 64h ; 'd'
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
    push    ax
    push    rectptr_unk2
    call    rect_union
    add     sp, 6
    jmp     short loc_24BD4
    ; align 2
    db 144
loc_24BB0:
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 64h ; 'd'
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
loc_24BD4:
    mov     si, elapsed_time2
    sub     si, di
    push    si
    call    restore_gamestate
    add     sp, 2
    mov     elapsed_time2, si
    mov     ax, si
    sub     ax, state.game_frame
    mov     [bp+var_4], ax
    or      ax, ax
    jz      short loc_24C43
    mov     si, ax
    jmp     short loc_24C3A
loc_24BF8:
    call    update_gamestate
    dec     si
    push    elapsed_time2
    mov     ax, [bp+var_4]
    cwd
    push    dx
    push    ax
    mov     ax, di
    cwd
    push    dx
    push    ax
    mov     ax, si
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    add     ax, elapsed_time2
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    mov     ax, 1
    push    ax
    call    input_do_checking
    add     sp, 2
loc_24C3A:
    mov     ax, elapsed_time2
    cmp     state.game_frame, ax
    jnz     short loc_24BF8
loc_24C43:
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    jmp     loc_24A19
    ; align 2
    db 144
loc_24C5A:
    mov     byte_449E6, 0
    sub     ax, ax
    push    ax
    mov     ax, 3
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    jmp     loc_24D18
loc_24C74:
    mov     is_in_replay, 1
    call    audio_carstate
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    jmp     loc_242E7
loc_24CA6:
    mov     is_in_replay, 1
    call    audio_carstate
    sub     ax, ax
    push    ax
    mov     ax, 5
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    push    state.game_frame
    push    state.game_frame
    mov     ax, 1
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    sub     ax, ax
    push    ax
    call    restore_gamestate
    add     sp, 2
    mov     ax, 32h ; '2'
    cwd
    push    dx
    push    ax
    call    timer_get_counter_unk
    add     sp, 4
    sub     ax, ax
    push    ax
    mov     ax, 4
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    jmp     loc_24140
    ; align 2
    db 144
loc_24D04:
    sub     ax, ax
    push    ax
    mov     ax, 2
    push    ax
    push    ax
    push    cs
    call near ptr loop_game
    add     sp, 6
    mov     byte_449E6, 3
loc_24D18:
    mov     is_in_replay, 0
    jmp     loc_242E7
off_24D20     dw offset loc_24830
off_24D22     dw offset loc_24A28
off_24D24     dw offset loc_24D04
off_24D26     dw offset loc_24C5A
off_24D28     dw offset loc_24C74
    dw offset loc_24CA6
    dw offset loc_24346
    jmp     loc_242E7
    ; align 2
    db 144
loc_24D32:
    cmp     ax, 2Dh ; '-'
    jnz     short loc_24D3A
    jmp     loc_2426E
loc_24D3A:
    cmp     ax, 4800h
    jnz     short loc_24D42
    jmp     loc_2430A
loc_24D42:
    cmp     ax, 4B00h
    jnz     short loc_24D4A
    jmp     loc_242C8
loc_24D4A:
    cmp     ax, 4D00h
    jnz     short loc_24D52
    jmp     loc_242FE
loc_24D52:
    cmp     ax, 5000h
    jnz     short loc_24D5A
    jmp     loc_2431E
loc_24D5A:
    jmp     loc_242E7
    ; align 2
    db 144
loc_24D5E:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loop_game endp
seg005 ends
end
