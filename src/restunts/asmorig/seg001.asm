.model medium
nosmart
    include structs.inc
    include custom.inc
    include seg000.inc
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
seg001 segment byte public 'STUNTSC' use16
    assume cs:seg001
    assume es:nothing, ss:nothing, ds:dseg
    public opponent_op
    public mat_mul_vector2
    public update_player_state
    public init_carstate_from_simd
    public init_game_state
    public restore_gamestate
    public update_gamestate
    public player_op
    public detect_penalty
    public update_car_speed
    public update_grip
    public car_car_speed_adjust_maybe
    public carState_rc_op
    public upd_statef20_from_steer_input
    public audio_carstate
    public audio_unk3
    public sub_18D06
    public sub_18D60
    public car_car_coll_detect_maybe
    public init_plantrak
    public do_opponent_op
    public update_crash_state
    public plane_rotate_op
    public plane_origin_op
    public vec_normalInnerProduct
    public state_op_unk
    public sub_19BA0
    public setup_aero_trackdata
opponent_op proc far
    var_40 = word ptr -64
    var_3E = word ptr -62
    var_3C = word ptr -60
    var_3A = word ptr -58
    var_38 = word ptr -56
    var_36 = word ptr -54
    var_34 = word ptr -52
    var_32 = word ptr -50
    var_30 = word ptr -48
    var_2E = word ptr -46
    var_2C = word ptr -44
    var_2A = word ptr -42
    var_28 = word ptr -40
    var_26 = word ptr -38
    var_24 = word ptr -36
    var_22 = word ptr -34
    var_20 = byte ptr -32
    var_1C = word ptr -28
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = byte ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 40h
    push    di
    push    si
    cmp     framespersec, 14h
    jnz     short loc_1472E
    mov     [bp+var_14], 8
    mov     [bp+var_10], 1
    jmp     short loc_14738
    ; align 2
    db 144
loc_1472E:
    mov     [bp+var_14], 10h
    mov     [bp+var_10], 2
loc_14738:
    cmp     state.opponentstate.car_36MwhlAngle, 0
    jnz     short loc_14746
    cmp     state.game_inputmode, 2
    jnz     short loc_1474C
loc_14746:
    mov     [bp+var_20], 1
    jmp     short loc_14750
loc_1474C:
    mov     [bp+var_20], 0
loc_14750:
    mov     ax, word ptr state.opponentstate.car_posWorld1.lx
    mov     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_14759:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_14759
    mov     [bp+var_28], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.ly
    mov     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1476D:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1476D
    mov     [bp+var_2A], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.lz
    mov     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_14781:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_14781
    mov     [bp+var_36], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.lx
    mov     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     cl, 6
loc_14795:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_14795
    mov     [bp+var_34], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.ly
    mov     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_147A9:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_147A9
    mov     [bp+var_3E], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.lz
    mov     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     cl, 6
loc_147BD:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_147BD
    mov     [bp+var_40], ax
    mov     state.opponentstate.field_CF, 0
    mov     state.field_45E, 0
    mov     ax, 1
    push    ax
    push    state.opponentstate.car_rotate.vx
    push    state.opponentstate.car_rotate.vy
    push    state.opponentstate.car_rotate.vz
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_16], ax
    mov     state.opponentstate.field_CF, 1
    cmp     state.opponentstate.car_crashBmpFlag, 0
    jz      short loc_1480C
    cmp     state.opponentstate.car_speed2, 0
    jz      short loc_14803
    jmp     loc_14B72
loc_14803:
    mov     state.opponentstate.field_CF, 0
    jmp     loc_14B72
    ; align 2
    db 144
loc_1480C:
    push    si
    lea     di, [bp+var_3C]
    mov     si, offset state.opponentstate.car_vec_unk3
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    cmp     [bp+var_3A], 0FFFFh
    jz      short loc_14848
    mov     ax, [bp+var_3C]
    sub     ax, [bp+var_28]
    mov     [bp+var_32], ax
    mov     ax, [bp+var_3A]
    sub     ax, [bp+var_2A]
    mov     [bp+var_30], ax
    mov     ax, [bp+var_38]
    sub     ax, [bp+var_36]
    mov     [bp+var_2E], ax
    lea     ax, [bp+var_32]
    push    ax
    call    polarRadius3D
    add     sp, 2
    jmp     short loc_1485E
loc_14848:
    mov     ax, [bp+var_38]
    sub     ax, [bp+var_36]
    push    ax
    mov     ax, [bp+var_3C]
    sub     ax, [bp+var_28]
    push    ax
    call    polarRadius2D
    add     sp, 4
loc_1485E:
    mov     si, ax
    cmp     si, 0C8h ; 'È'
    jge     short loc_148B3
loc_14866:
    mov     ax, offset state.field_3F9
    push    ax
    mov     al, state.opponentstate.field_CE
    inc     state.opponentstate.field_CE
    sub     ah, ah
    push    ax
    mov     ax, offset state.opponentstate.car_vec_unk3
    push    ax
    mov     bx, state.opponentstate.car_trackdata3_index
    shl     bx, 1
    les     di, trackdata3
    push    word ptr es:[bx+di]
    push    cs
loc_14886:
    call near ptr sub_18D60
    add     sp, 8
    or      al, al
    jz      short loc_148B3
    inc     state.opponentstate.car_trackdata3_index
    mov     bx, state.opponentstate.car_trackdata3_index
    shl     bx, 1
    les     di, trackdata3
    cmp     word ptr es:[bx+di], 0
    jnz     short loc_148AE
    inc     state.opponentstate.field_CD
    mov     state.opponentstate.car_trackdata3_index, 0
loc_148AE:
    mov     state.opponentstate.field_CE, 0
loc_148B3:
    cmp     state.game_inputmode, 2
    jnz     short loc_148EC
loc_148BA:
    push    si
    lea     di, [bp+var_C]
    mov     si, offset state.opponentstate.car_vec_unk3
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
loc_148C7:
    push    si
    lea     di, [bp+var_26]
    lea     si, [bp+var_C]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     ax, [bp+var_28]
    sub     [bp+var_26], ax
    cmp     [bp+var_A], 0FFFFh
    jz      short loc_148E3
    jmp     loc_14A6E
loc_148E3:
    mov     [bp+var_24], 0
    jmp     loc_14A74
    ; align 2
    db 144
loc_148EC:
    mov     ax, [bp+var_34]
    sub     ax, [bp+var_28]
    mov     [bp+var_26], ax
    mov     ax, [bp+var_3E]
    sub     ax, [bp+var_2A]
    mov     [bp+var_24], ax
    mov     ax, [bp+var_40]
    sub     ax, [bp+var_36]
    mov     [bp+var_22], ax
    lea     ax, [bp+var_1C]
    push    ax
    push    [bp+var_16]
    lea     ax, [bp+var_26]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_1A], 5Ah ; 'Z'
    jg      short loc_148BA
    cmp     [bp+var_1C], 0
    jge     short loc_1492E
    mov     ax, [bp+var_1C]
    neg     ax
    jmp     short loc_14931
    ; align 2
    db 144
loc_1492E:
    mov     ax, [bp+var_1C]
loc_14931:
    cmp     ax, 0B4h ; '´'
    jg      short loc_148BA
    cmp     [bp+var_18], 258h
    jle     short loc_14940
    jmp     loc_148BA
loc_14940:
    cmp     [bp+var_18], 0FF4Ch
    jge     short loc_1494A
    jmp     loc_148BA
loc_1494A:
    mov     ax, [bp+var_34]
    sub     ax, state.opponentstate.car_vec_unk3.vx
    mov     [bp+var_26], ax
    cmp     state.opponentstate.car_vec_unk3.vy, 0FFFFh
    jnz     short loc_14962
    mov     [bp+var_24], 0
    jmp     short loc_1496C
loc_14962:
    mov     ax, [bp+var_3E]
    sub     ax, state.opponentstate.car_vec_unk3.vy
    mov     [bp+var_24], ax
loc_1496C:
    mov     ax, [bp+var_40]
    sub     ax, state.opponentstate.car_vec_unk3.vz
    mov     [bp+var_22], ax
    lea     ax, [bp+var_6]
    push    ax
    push    [bp+var_16]
    lea     ax, [bp+var_26]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_6], 0
    jge     short loc_149FE
    mov     ax, state.opponentstate.car_vec_unk5.vx
    cwd
    mov     cx, ax
    mov     ax, state.opponentstate.car_vec_unk3.vx
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     [bp+var_C], ax
    cmp     state.opponentstate.car_vec_unk3.vy, 0FFFFh
    jnz     short loc_149B4
    mov     [bp+var_A], 0FFFFh
    jmp     short loc_149CB
loc_149B4:
    mov     ax, state.opponentstate.car_vec_unk5.vy
    cwd
    mov     cx, ax
    mov     ax, state.opponentstate.car_vec_unk3.vy
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     [bp+var_A], ax
loc_149CB:
    mov     ax, state.opponentstate.car_vec_unk5.vz
    cwd
    mov     cx, ax
    mov     ax, state.opponentstate.car_vec_unk3.vz
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     [bp+var_8], ax
    cmp     [bp+var_18], 0FFB2h
    jg      short loc_149EB
    jmp     loc_148C7
loc_149EB:
    cmp     state.playerstate.car_crashBmpFlag, 0
    jz      short loc_149F5
    jmp     loc_148C7
loc_149F5:
    mov     state.field_45E, 2
    jmp     loc_148C7
    ; align 2
    db 144
loc_149FE:
    mov     ax, state.opponentstate.car_vec_unk4.vx
    cwd
    mov     cx, ax
    mov     ax, state.opponentstate.car_vec_unk3.vx
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     [bp+var_C], ax
    cmp     state.opponentstate.car_vec_unk3.vy, 0FFFFh
    jnz     short loc_14A24
    mov     [bp+var_A], 0FFFFh
    jmp     short loc_14A3B
    ; align 2
    db 144
loc_14A24:
    mov     ax, state.opponentstate.car_vec_unk4.vy
    cwd
    mov     cx, ax
    mov     ax, state.opponentstate.car_vec_unk3.vy
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     [bp+var_A], ax
loc_14A3B:
    mov     ax, state.opponentstate.car_vec_unk4.vz
    cwd
    mov     cx, ax
    mov     ax, state.opponentstate.car_vec_unk3.vz
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     [bp+var_8], ax
    cmp     [bp+var_18], 0FFB2h
    jg      short loc_14A5B
    jmp     loc_148C7
loc_14A5B:
    cmp     state.playerstate.car_crashBmpFlag, 0
    jz      short loc_14A65
    jmp     loc_148C7
loc_14A65:
    mov     state.field_45E, 1
    jmp     loc_148C7
    ; align 2
    db 144
loc_14A6E:
    mov     ax, [bp+var_2A]
    sub     [bp+var_24], ax
loc_14A74:
    mov     ax, [bp+var_36]
    sub     [bp+var_22], ax
    lea     ax, [bp+var_3C]
    push    ax
    push    [bp+var_16]
    lea     ax, [bp+var_26]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    [bp+var_38]
    push    [bp+var_3C]
    call    polarAngle
    add     sp, 4
    mov     [bp+var_2C], ax
    cmp     state.opponentstate.car_slidingFlag, 0
    jnz     short loc_14B03
    or      ax, ax
    jge     short loc_14AAE
    neg     ax
    jmp     short loc_14AB1
    ; align 2
    db 144
loc_14AAE:
    mov     ax, [bp+var_2C]
loc_14AB1:
    cmp     ax, 100h
    jle     short loc_14B03
    mov     ax, offset state.field_3F9
    push    ax
    mov     al, state.opponentstate.field_CE
    inc     state.opponentstate.field_CE
    sub     ah, ah
    push    ax
    mov     ax, offset state.opponentstate.car_vec_unk3
    push    ax
    mov     bx, state.opponentstate.car_trackdata3_index
    shl     bx, 1
    les     di, trackdata3
    push    word ptr es:[bx+di]
    push    cs
    call near ptr sub_18D60
    add     sp, 8
    or      al, al
    jz      short loc_14B03
    inc     state.opponentstate.car_trackdata3_index
    mov     bx, state.opponentstate.car_trackdata3_index
    shl     bx, 1
    les     di, trackdata3
    cmp     word ptr es:[bx+di], 0
    jnz     short loc_14AFE
    inc     state.opponentstate.field_CD
    mov     state.opponentstate.car_trackdata3_index, 0
loc_14AFE:
    mov     state.opponentstate.field_CE, 0
loc_14B03:
    cmp     [bp+var_2C], 41h ; 'A'
    jle     short loc_14B1E
    cmp     [bp+var_20], 0
    jnz     short loc_14B16
loc_14B0F:
    mov     [bp+var_20], 1
    jmp     loc_14866
loc_14B16:
    mov     [bp+var_2C], 41h ; 'A'
    jmp     short loc_14B2F
    ; align 2
    db 144
loc_14B1E:
    cmp     [bp+var_2C], 0FFBFh
    jge     short loc_14B2F
    cmp     [bp+var_20], 0
    jz      short loc_14B0F
    mov     [bp+var_2C], 0FFBFh
loc_14B2F:
    cmp     state.opponentstate.car_sumSurfFrontWheels, 0
    jnz     short loc_14B3B
    mov     [bp+var_2C], 0
loc_14B3B:
    mov     si, [bp+var_2C]
    sub     si, state.opponentstate.car_steeringAngle
    jns     short loc_14B4A
    mov     ax, si
    neg     ax
    jmp     short loc_14B4C
loc_14B4A:
    mov     ax, si
loc_14B4C:
    cmp     ax, [bp+var_14]
    jle     short loc_14B6C
    mov     ax, state.opponentstate.car_steeringAngle
    cmp     [bp+var_2C], ax
    jge     short loc_14B62
    mov     ax, [bp+var_14]
    sub     state.opponentstate.car_steeringAngle, ax
    jmp     short loc_14B72
loc_14B62:
    mov     ax, [bp+var_14]
    add     state.opponentstate.car_steeringAngle, ax
    jmp     short loc_14B72
    ; align 2
    db 144
loc_14B6C:
    mov     ax, [bp+var_2C]
    mov     state.opponentstate.car_steeringAngle, ax
loc_14B72:
    mov     [bp+var_E], 0
    cmp     state.opponentstate.car_sumSurfRearWheels, 0
    jz      short loc_14BFA
    cmp     state.opponentstate.car_crashBmpFlag, 0
    jnz     short loc_14BF6
    cmp     state.opponentstate.car_36MwhlAngle, 0
    jz      short loc_14BB6
    mov     ax, [bp+var_10]
    mov     cl, 9
    shl     ax, cl
    cmp     ax, state.opponentstate.car_speed2
    jbe     short loc_14BA8
    mov     state.opponentstate.car_speed2, 0
    mov     state.opponentstate.car_36MwhlAngle, 0
    jmp     short loc_14BFA
    ; align 4
    db 144
    db 144
loc_14BA8:
    mov     ax, [bp+var_10]
    mov     cl, 9
    shl     ax, cl
    sub     state.opponentstate.car_speed2, ax
    jmp     short loc_14BFA
    ; align 2
    db 144
loc_14BB6:
    mov     ax, state.opponentstate.car_surfacegrip_sum
    cmp     state.opponentstate.car_demandedGrip, ax
    jg      short loc_14BF6
    cmp     state.game_inputmode, 2
    jnz     short loc_14BCE
    mov     [bp+var_12], 4000h
    jmp     short loc_14BD7
    ; align 2
    db 144
loc_14BCE:
    mov     ah, state.field_3F9
    sub     al, al
    mov     [bp+var_12], ax
loc_14BD7:
    mov     ax, [bp+var_12]
    sub     ax, 100h
    cmp     ax, state.opponentstate.car_speed
    jbe     short loc_14BEA
    mov     [bp+var_E], 1
    jmp     short loc_14BFA
    ; align 2
    db 144
loc_14BEA:
    mov     ax, [bp+var_12]
    add     ah, 3
    cmp     ax, state.opponentstate.car_speed
    jnb     short loc_14BFA
loc_14BF6:
    mov     [bp+var_E], 2
loc_14BFA:
    mov     ax, offset simd_opponent
    push    ax
    mov     ax, offset state.opponentstate
    push    ax
    mov     ax, 1
    push    ax
    mov     al, [bp+var_E]
    cbw
    push    ax
    push    cs
    call near ptr update_car_speed
    add     sp, 8
    sub     ax, ax
    push    ax
    mov     ax, offset simd_opponent
    push    ax
    mov     ax, offset state.opponentstate
    push    ax
    push    cs
    call near ptr update_grip
    add     sp, 6
    mov     ax, 1
    push    ax
    mov     ax, offset simd_player
    push    ax
    mov     ax, offset state.playerstate
    push    ax
    mov     ax, offset simd_opponent
    push    ax
    mov     ax, offset state.opponentstate
    push    ax
    push    cs
    call near ptr update_player_state
    add     sp, 0Ah
    cmp     state.opponentstate.car_crashBmpFlag, 0
    jz      short loc_14C49
    jmp     loc_14CD7
loc_14C49:
    push    si
    lea     di, [bp+var_26]
    mov     si, offset state.opponentstate.car_vec_unk3
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     ax, word ptr state.opponentstate.car_posWorld1.lx
    mov     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_14C5F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_14C5F
    sub     [bp+var_26], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.ly
    mov     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_14C73:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_14C73
    sub     [bp+var_24], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.lz
    mov     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_14C87:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_14C87
    sub     [bp+var_22], ax
    mov     ax, 1
    push    ax
    push    state.opponentstate.car_rotate.vx
    push    state.opponentstate.car_rotate.vy
    push    state.opponentstate.car_rotate.vz
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_16], ax
    lea     ax, [bp+var_3C]
    push    ax
    push    [bp+var_16]
    lea     ax, [bp+var_26]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    [bp+var_38]
    mov     ax, [bp+var_3C]
    neg     ax
    push    ax
    call    polarAngle
    add     sp, 4
smart
    and     ah, 3
nosmart
    mov     state.opponentstate.field_48, ax
loc_14CD7:
    cmp     state.opponentstate.field_CD, 0
    jnz     short loc_14CE1
    jmp     loc_14D66
loc_14CE1:
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    mov     cx, word ptr state.opponentstate.car_posWorld1.lz
    mov     bx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     dx, cx
    mov     cl, 6
loc_14CF9:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_14CF9
    sub     ax, dx
    push    ax
    push    track_angle
    call    cos_fast
    add     sp, 2
    push    ax
loc_14D11:
    call    multiply_and_scale
    add     sp, 4
    mov     si, ax
    mov     al, startcol2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    mov     cx, word ptr state.opponentstate.car_posWorld1.lx
    mov     bx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     dx, cx
    mov     cl, 6
loc_14D33:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_14D33
    sub     ax, dx
    push    ax
    push    track_angle
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     si, ax
    jns     short loc_14D66
    mov     ax, 1
    push    ax
    mov     ax, 3
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
loc_14D66:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
opponent_op endp
mat_mul_vector2 proc far
    var_mat = byte ptr -18
     s = byte ptr 0
     r = byte ptr 2
    arg_invec = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_outvec = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 12h
    push    di
    push    si
    mov     ax, [bp+arg_2]
    mov     dx, [bp+arg_4]
    lea     di, [bp+var_mat]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 9
    repne movsw
    pop     ds
    push    [bp+arg_outvec]
    lea     ax, [bp+var_mat]
    push    ax
    push    [bp+arg_invec]
    call    mat_mul_vector
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
mat_mul_vector2 endp
update_player_state proc far
    vec_1E4 = VECTOR ptr -484
    vec_1DE = VECTOR ptr -478
    vec_1C6 = VECTOR ptr -454
    vecl_1C0 = VECTORLONG ptr -448
    var_190 = word ptr -400
    vec_18EoStateWorldCrds = VECTOR ptr -398
    vec_182 = VECTOR ptr -386
    vec_17C = VECTOR ptr -380
    vecl_176 = VECTORLONG ptr -374
    var_146ptrTo176 = word ptr -326
    var_144 = word ptr -324
    pState_f40_sar2 = word ptr -322
    var_140someWhlData = word ptr -320
    var_138 = word ptr -312
    var_136 = byte ptr -310
    mat_134 = MATRIX ptr -308
    var_122 = VECTOR ptr -290
    var_11C = byte ptr -284
    var_11ApStateWorldCrds = VECTOR ptr -282
    var_MmatFromAngleZ = MATRIX ptr -270
    vec_FC = VECTOR ptr -252
    var_F4 = word ptr -244
    var_F2 = word ptr -242
    var_F0 = word ptr -240
    var_EE = word ptr -238
    var_EC = byte ptr -236
    var_EA = word ptr -234
    var_wheelIndex = byte ptr -232
    var_pSpeed2Scaled = word ptr -230
    vec_E4 = VECTOR ptr -228
    var_DEptrTo1C0 = word ptr -222
    var_DC = VECTOR ptr -220
    vec_1C = VECTOR ptr -28
    var_16 = word ptr -22
    var_E = word ptr -14
    vec_C = VECTOR ptr -12
    var_6 = dword ptr -6
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_pState = word ptr 6
    arg_pSimd = word ptr 8
    arg_oState = word ptr 10
    arg_oSimd = word ptr 12
    arg_MplayerFlag = byte ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 1E4h
    push    di
    push    si
    mov     bx, [bp+arg_pState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lx]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lx+2)]
    mov     word ptr pState_lvec1_x, ax
    mov     word ptr pState_lvec1_x+2, dx
    mov     word ptr [bx+CARSTATE.car_posWorld2.lx], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld2.lx+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.ly]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.ly+2)]
    mov     word ptr pState_lvec1_y, ax
    mov     word ptr pState_lvec1_y+2, dx
    mov     word ptr [bx+CARSTATE.car_posWorld2.ly], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld2.ly+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lz]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lz+2)]
    mov     word ptr pState_lvec1_z, ax
    mov     word ptr pState_lvec1_z+2, dx
    mov     word ptr [bx+CARSTATE.car_posWorld2.lz], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld2.lz+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rotate.vz]
    mov     pState_minusRotate_z_1, ax
    mov     pState_minusRotate_z_2, ax
    mov     ax, [bx+CARSTATE.car_rotate.vy]
    mov     pState_minusRotate_x_1, ax
    mov     pState_minusRotate_x_2, ax
    mov     ax, [bx+CARSTATE.car_rotate.vx]
    mov     pState_minusRotate_y_1, ax
    mov     pState_minusRotate_y_2, ax
    cmp     [bx+CARSTATE.car_sumSurfAllWheels], 0
    jz      short loc_14E1E
    mov     ax, [bx+CARSTATE.car_40MfrontWhlAngle]
    sar     ax, 1
    sar     ax, 1
    mov     [bp+pState_f40_sar2], ax
    jmp     short loc_14E24
loc_14E1E:
    mov     [bp+pState_f40_sar2], 0
loc_14E24:
    cmp     framespersec, 0Ah
    jnz     short loc_14E30
    mov     ax, 1E00h
    jmp     short loc_14E33
loc_14E30:
    mov     ax, 3C00h       ; full trk grid length/2
loc_14E33:
    sub     dx, dx
    push    dx
    push    ax
    mov     ax, 580h        ; 11*128
    cwd
    push    dx
    push    ax
    mov     bx, [bp+arg_pState]
    sub     ax, ax
    push    ax
    push    [bx+CARSTATE.car_speed2]
    call    __aFlmul
    push    dx
    push    ax
    call    __aFuldiv
    mov     [bp+var_pSpeed2Scaled], ax
    sub     ax, ax
    push    ax
    mov     ax, pState_minusRotate_y_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_x_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_z_1
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    push    si
    mov     di, offset mat_unk
    mov     si, ax
    push    ds
    pop     es
    mov     cx, 9
    repne movsw
    pop     si
    cmp     pState_minusRotate_x_1, 0
    jnz     short loc_14E8F
    cmp     pState_minusRotate_z_1, 0
    jz      short loc_14EC6
loc_14E8F:
    mov     [bp+vec_1C6.vx], 0
    mov     [bp+vec_1C6.vy], 0
    mov     [bp+vec_1C6.vz], 82h ; '‚'
    lea     ax, [bp+vec_FC]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+vec_FC.vy]
    neg     ax
    mov     [bx+CARSTATE.car_pseudoGravity], ax
    jmp     short loc_14ECE
    ; align 2
    db 144
loc_14EC6:
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_pseudoGravity], 0
loc_14ECE:
    mov     bx, [bp+arg_pState]
    test    [bx+CARSTATE.car_angle_z], 3FFh
    jz      short loc_14F04
    mov     [bp+var_EC], 1
    sub     ax, ax
    push    ax
    mov     ax, [bx+CARSTATE.car_angle_z]
    neg     ax
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    push    si
    lea     di, [bp+var_MmatFromAngleZ]
    mov     si, ax
    push    ss
    pop     es
    mov     cx, 9
    repne movsw
    pop     si
    jmp     short loc_14F09
    ; align 2
    db 144
loc_14F04:
    mov     [bp+var_EC], 0
loc_14F09:
    mov     [bp+vec_1C6.vx], 0
    mov     [bp+vec_1C6.vy], 7530h; 30000
    mov     [bp+vec_1C6.vz], 0
    lea     ax, [bp+vec_FC]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     bx, [bp+arg_pState]
    cmp     [bx+CARSTATE.car_sumSurfAllWheels], 0
    jz      short loc_14F76
    cmp     [bp+vec_FC.vy], 0
    jge     short loc_14F76
    cmp     [bx+CARSTATE.car_speed2], 1E00h
    jbe     short loc_14F6E
    mov     [bp+var_F0], 0C0h ; 'À'
    mov     [bp+vec_1C6.vy], 0FF40h
    lea     ax, [bp+vec_E4]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    jmp     short loc_14F7C
    ; align 2
    db 144
loc_14F6E:
    mov     [bp+var_F0], 0FF40h
    jmp     short loc_14F7C
loc_14F76:
    mov     [bp+var_F0], 0
loc_14F7C:
    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     planindex_copy, 0FFFFh
    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    lea     ax, [bp+vecl_176]
    mov     [bp+var_146ptrTo176], ax
    mov     [bp+var_wheelIndex], 0
    jmp     short loc_14FFA
    ; align 2
    db 144
loc_14FA6:
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_36MwhlAngle]
loc_14FAC:
    mov     pState_f36Mminf40sar2, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, pState_f36Mminf40sar2
    mov     [bp+di+var_140someWhlData], ax
    push    cs
    call near ptr plane_rotate_op
    mov     ax, vec_planerotopresult.vx
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, vec_planerotopresult.vy
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, vec_planerotopresult.vz
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx
loc_14FEC:
    add     [bp+var_DEptrTo1C0], 0Ch
    add     [bp+var_146ptrTo176], 0Ch
    inc     [bp+var_wheelIndex]
loc_14FFA:
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_15004
    jmp     loc_1513E
loc_15004:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1           ; *6
    mov     bx, [bp+arg_pSimd]
    push    si
    lea     si, [bx+di+SIMD.wheel_coords]
    lea     di, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+di+CARSTATE.car_rc2]
    add     ax, 180h        ; 384 = 24*16
    neg     ax
    mov     [bp+vec_1C6.vy], ax; adjusting wheel heights?
    cmp     [bp+var_F0], 0
    jge     short loc_1504A
    mov     ax, [bp+var_F0]
    sub     [bp+vec_1C6.vy], ax
loc_1504A:
    cmp     [bp+var_EC], 0
    jz      short loc_15077
    lea     ax, [bp+vec_FC]
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    si
    lea     di, [bp+vec_1C6]
    lea     si, [bp+vec_FC]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
loc_15077:
    lea     ax, [bp+vec_FC]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+vec_FC.vx]
    cwd
    add     ax, word ptr pState_lvec1_x
    adc     dx, word ptr pState_lvec1_x+2
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], ax
    mov     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_FC.vy]
    cwd
    add     ax, word ptr pState_lvec1_y
    adc     dx, word ptr pState_lvec1_y+2
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], ax
    mov     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_FC.vz]
    cwd
    add     ax, word ptr pState_lvec1_z
    adc     dx, word ptr pState_lvec1_z+2
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], ax
    mov     word ptr [bx+(VECTORLONG.lz+2)], dx
    mov     bx, [bp+var_146ptrTo176]
    mov     di, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [di+VECTORLONG.lx]
    mov     dx, word ptr [di+(VECTORLONG.lx+2)]
    mov     word ptr [bx+VECTORLONG.lx], ax
    mov     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     bx, [bp+var_146ptrTo176]
    mov     di, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [di+VECTORLONG.ly]
    mov     dx, word ptr [di+(VECTORLONG.ly+2)]
    mov     word ptr [bx+VECTORLONG.ly], ax
    mov     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     bx, [bp+var_146ptrTo176]
    mov     di, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [di+VECTORLONG.lz]
    mov     dx, word ptr [di+(VECTORLONG.lz+2)]
    mov     word ptr [bx+VECTORLONG.lz], ax
    mov     word ptr [bx+(VECTORLONG.lz+2)], dx
    cmp     [bp+var_pSpeed2Scaled], 0
    jnz     short loc_15115
    jmp     loc_14FEC
loc_15115:
    mov     ax, [bp+var_pSpeed2Scaled]
    mov     vec_unk2.vz, ax
    cmp     [bp+pState_f40_sar2], 0
    jnz     short loc_15126
    jmp     loc_14FA6
loc_15126:
    cmp     [bp+var_wheelIndex], 2
    jl      short loc_15130
    jmp     loc_14FA6
loc_15130:
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_36MwhlAngle]
    sub     ax, [bp+pState_f40_sar2]
    jmp     loc_14FAC
    ; align 2
    db 144
loc_1513E:
    mov     [bp+var_2], 0
loc_15142:
    inc     [bp+var_2]
    cmp     [bp+var_2], 5
    jnz     short loc_151A2
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_36MwhlAngle], 200h
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
loc_15163:
    mov     bx, [bp+arg_pState]; grip data...
    cmp     [bx+CARSTATE.car_surfaceWhl], 5
    jnz     short loc_15192
    cmp     [bx+(CARSTATE.car_surfaceWhl+1)], 5
    jnz     short loc_15192
    cmp     [bx+(CARSTATE.car_surfaceWhl+2)], 5
    jnz     short loc_15192
    cmp     [bx+(CARSTATE.car_surfaceWhl+3)], 5
    jnz     short loc_15192
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
loc_15192:
    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    mov     [bp+var_wheelIndex], 0
    jmp     loc_15DD1
loc_151A2:
    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    lea     ax, [bp+vecl_176]
    mov     [bp+var_146ptrTo176], ax
    mov     [bp+var_wheelIndex], 0
    jmp     loc_15D39
loc_151BA:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+arg_pState]
    add     ax, CARSTATE.car_whlWorldCrds1
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    build_track_object
    add     sp, 4
loc_151DB:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    mov     bx, [bp+arg_pState]
    mov     al, current_surf_type
    mov     [bx+di+CARSTATE.car_surfaceWhl], al; a CARSTATE field
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_151F7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_151F7
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_1520F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1520F
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15227:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15227
    mov     [bp+vec_1C6.vz], ax
    cmp     state.game_inputmode, 2
    jnz     short loc_15240
    mov     ax, [bp+vec_1C6.vy]
    jmp     short loc_15257
loc_15240:
    push    [bp+vec_1C6.vz]
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
loc_15257:
    mov     nextPosAndNormalIP, ax
    cmp     wallindex, 0FFFFh
    jnz     short loc_15264
    jmp     loc_15950
loc_15264:
    mov     ax, elRdWallRelated
    cmp     nextPosAndNormalIP, ax
    jg      short loc_15270
    jmp     loc_15950
loc_15270:
    mov     ax, wallHeight
    cmp     nextPosAndNormalIP, ax
    jl      short loc_1527C
    jmp     loc_15950
loc_1527C:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, [bp+arg_pState]
    mov     ax, [di+CARSTATE.car_whlWorldCrds1.vx]
    sub     ax, wallStartX
    mov     [bp+vec_182.vx], ax
    mov     [bp+vec_182.vy], 0
    mov     ax, [di+CARSTATE.car_whlWorldCrds1.vz]
    sub     ax, wallStartZ
    mov     [bp+vec_182.vz], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_152B5:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_152B5
    sub     ax, wallStartX
    mov     [bp+vec_1E4.vx], ax
    mov     [bp+vec_1E4.vy], 0
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_152D7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_152D7
    sub     ax, wallStartZ
    mov     [bp+vec_1E4.vz], ax
    mov     ax, wallOrientation
    neg     ax
    sub     ax, 100h
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    call    mat_rot_y
    add     sp, 4
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    lea     ax, [bp+vec_182]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    lea     ax, [bp+vec_1C]
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    lea     ax, [bp+vec_1E4]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+vec_1C.vz], 0
    jle     short loc_15338
    cmp     [bp+vec_C.vz], 0
    jle     short loc_15338
    jmp     loc_15950
loc_15338:
    cmp     [bp+vec_1C.vz], 0
    jge     short loc_15347
    cmp     [bp+vec_C.vz], 0
    jge     short loc_15347
    jmp     loc_15950
loc_15347:
    mov     ax, [bp+vec_C.vz]
    cmp     [bp+vec_1C.vz], ax
    jle     short loc_1537C
    mov     [bp+var_136], 1
    push    si
    lea     di, [bp+vec_FC]
    lea     si, [bp+vec_1C]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    push    si
    lea     di, [bp+vec_1C]
    lea     si, [bp+vec_C]
    movsw
    movsw
    movsw
    pop     si
    push    si
    lea     di, [bp+vec_C]
    lea     si, [bp+vec_FC]
    movsw
    movsw
    movsw
    pop     si
    jmp     short loc_15381
    ; align 2
    db 144
loc_1537C:
    mov     [bp+var_136], 0
loc_15381:
    cmp     [bp+vec_1C.vz], 0
    jnz     short loc_15398
    mov     ax, [bp+var_pSpeed2Scaled]
    mov     [bp+var_F4], ax
    mov     [bp+var_F2], 0
    jmp     short loc_1540C
    ; align 2
    db 144
loc_15398:
    cmp     [bp+vec_C.vz], 0
    jnz     short loc_153AE
    mov     [bp+var_F4], 0
    mov     ax, [bp+var_pSpeed2Scaled]
    mov     [bp+var_F2], ax
    jmp     short loc_1540C
loc_153AE:
    sub     ax, ax
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+vec_1C]
    push    ax
    call    vector_op_unk
    add     sp, 8
    mov     ax, [bp+vec_1C.vx]
    sub     ax, [bp+vec_FC.vx]
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_17C.vx], ax
    mov     ax, [bp+vec_1C.vy]
    sub     ax, [bp+vec_FC.vy]
    shl     ax, cl
    mov     [bp+vec_17C.vy], ax
    mov     ax, [bp+vec_1C.vz]
    sub     ax, [bp+vec_FC.vz]
    shl     ax, cl
    mov     [bp+vec_17C.vz], ax
    lea     ax, [bp+vec_17C]
    push    ax
    call    polarRadius3D
    add     sp, 2
    mov     [bp+var_F2], ax
    mov     ax, [bp+var_pSpeed2Scaled]
    sub     ax, [bp+var_F2]
    mov     [bp+var_F4], ax
loc_1540C:
    mov     ax, pState_minusRotate_y_1
    neg     ax
    sub     ax, wallOrientation
smart
    and     ah, 3
nosmart
    mov     [bp+var_EE], ax
    mov     ax, [bp+var_F2]
    mov     [bp+vec_FC.vz], ax
    mov     [bp+vec_FC.vy], 0
    cmp     [bp+var_EE], 100h
    jl      short loc_1543A
    cmp     [bp+var_EE], 300h
    jle     short loc_1544A
loc_1543A:
    mov     ax, wallOrientation
    mov     [bp+var_EE], ax
    mov     [bp+vec_FC.vx], 300h
    jmp     short loc_1545D
    ; align 2
    db 144
loc_1544A:
    mov     ax, wallOrientation
    add     ah, 2
smart
    and     ah, 3
nosmart
    mov     [bp+var_EE], ax
    mov     [bp+vec_FC.vx], 0FD00h
loc_1545D:
    cmp     [bp+var_136], 0
    jz      short loc_1546E
    mov     ax, [bp+vec_FC.vx]
    neg     ax
    mov     [bp+vec_FC.vx], ax
loc_1546E:
    sub     ax, ax
    push    ax
    push    [bp+var_EE]
    mov     ax, pState_minusRotate_x_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_z_1
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_EA], ax
    lea     ax, [bp+vec_1C]
    push    ax
    push    [bp+var_EA]
    lea     ax, [bp+vec_FC]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, pState_minusRotate_y_1
    neg     ax
    mov     si, ax
    sub     si, [bp+var_EE]
smart
    and     si, 3FFh
nosmart
    mov     [bp+var_138], 0
    cmp     si, 100h
    jle     short loc_154CA
    mov     ax, 400h
    sub     ax, si
    mov     si, ax
    mov     [bp+var_138], 1
loc_154CA:
    mov     ax, 46h ; 'F'
    imul    si
    mov     cl, 8
    sar     ax, cl
    sub     ax, 64h ; 'd'
    neg     ax
    mov     ch, al
    sub     cl, cl
    mov     [bp+var_190], cx
    mov     bx, [bp+arg_pState]
    mov     ax, cx
    cmp     [bx+CARSTATE.car_speed2], ax
    jbe     short loc_15513
    cmp     [bp+var_138], 0
    jz      short loc_154F8
    mov     ax, si
    neg     ax
    jmp     short loc_154FA
    ; align 2
    db 144
loc_154F8:
    mov     ax, si
loc_154FA:
    shl     ax, 1
    mov     [bp+var_138], ax
    mov     [bx+CARSTATE.car_36MwhlAngle], ax
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
loc_15513:
    mov     bx, [bp+arg_pState]
smart
    or      [bx+CARSTATE.field_CF], 10h
nosmart
    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    lea     ax, [bp+vecl_176]
    mov     [bp+var_146ptrTo176], ax
    sub     si, si
    jmp     short loc_15599
    ; align 2
    db 144
loc_15530:
    mov     [bp+vec_C.vx], 0
    mov     [bp+vec_C.vy], 0
    mov     [bp+vec_C.vz], 0
loc_1553F:
    mov     ax, [bp+vec_C.vx]
    add     ax, [bp+vec_1C.vx]
    cwd
    mov     bx, [bp+var_146ptrTo176]
    add     ax, word ptr [bx+VECTORLONG.lx]
    adc     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], ax
    mov     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_C.vy]
    add     ax, [bp+vec_1C.vy]
    cwd
    mov     bx, [bp+var_146ptrTo176]
    add     ax, word ptr [bx+VECTORLONG.ly]
    adc     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], ax
    mov     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_C.vz]
    add     ax, [bp+vec_1C.vz]
    cwd
    mov     bx, [bp+var_146ptrTo176]
    add     ax, word ptr [bx+VECTORLONG.lz]
    adc     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], ax
    mov     word ptr [bx+(VECTORLONG.lz+2)], dx
    add     [bp+var_DEptrTo1C0], 0Ch
    add     [bp+var_146ptrTo176], 0Ch
    inc     si
loc_15599:
    cmp     si, 4
    jl      short loc_155A1
    jmp     loc_15142
loc_155A1:
    cmp     [bp+var_F4], 0
    jz      short loc_15530
    mov     ax, [bp+var_pSpeed2Scaled]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lx]
    sbb     dx, word ptr [bx+(VECTORLONG.lx+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vx], ax
    mov     ax, [bp+var_pSpeed2Scaled]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.ly]
    sbb     dx, word ptr [bx+(VECTORLONG.ly+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vy], ax
    mov     ax, [bp+var_pSpeed2Scaled]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lz]
    sbb     dx, word ptr [bx+(VECTORLONG.lz+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vz], ax
    jmp     loc_1553F
loc_15642:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, word_3BD72[di]
    add     [bx+di+CARSTATE.car_rc1], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rc1]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.ly], ax
    sbb     word ptr [bx+(VECTORLONG.ly+2)], dx
    cmp     framespersec, 0Ah
    jnz     short loc_156A3
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, word_3BD72[di]
    add     [bx+di+CARSTATE.car_rc1], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rc1]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.ly], ax
    sbb     word ptr [bx+(VECTORLONG.ly+2)], dx
loc_156A3:
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_156AF:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_156AF
    mov     [bp+vec_1C6.vy], ax
    cmp     state.game_inputmode, 2
    jz      short loc_156D6
    push    [bp+vec_1C6.vz]
    push    ax
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
loc_156D6:
    mov     nextPosAndNormalIP, ax
    cmp     ax, 0Ch
    jle     short loc_156ED
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    mov     bx, [bp+arg_pState]
    mov     [bx+di+CARSTATE.car_surfaceWhl], 0
loc_156ED:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, nextPosAndNormalIP
    mov     [bp+di+var_16], ax
    or      ax, ax
    jnz     short loc_15703
    jmp     loc_15CE8
loc_15703:
    or      ax, ax
    jl      short loc_1570A
    jmp     loc_15D2B
loc_1570A:
    mov     ax, 22h ; '"'
    imul    planindex
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     word ptr [bp+var_6], ax
    mov     word ptr [bp+var_6+2], dx
    les     bx, [bp+var_6]
    mov     ax, es:[bx+PLANE.plane_origin.vx]
    add     ax, elem_xCenter
    mov     [bp+var_122.vx], ax
    mov     ax, es:[bx+PLANE.plane_origin.vy]
    add     ax, terrainHeight
    mov     [bp+var_122.vy], ax
    mov     ax, es:[bx+PLANE.plane_origin.vz]
    add     ax, elem_zCenter
    mov     [bp+var_122.vz], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15751:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15751
    sub     ax, [bp+var_122.vx]
    mov     [bp+vec_182.vx], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_1576D:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1576D
    sub     ax, [bp+var_122.vy]
    mov     [bp+vec_182.vy], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15789:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15789
    sub     ax, [bp+var_122.vz]
    mov     [bp+vec_182.vz], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_157A4:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_157A4
    sub     ax, [bp+var_122.vx]
    mov     [bp+vec_1E4.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_157C0:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_157C0
    sub     ax, [bp+var_122.vy]
    mov     [bp+vec_1E4.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_157DC:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_157DC
    sub     ax, [bp+var_122.vz]
    mov     [bp+vec_1E4.vz], ax
    mov     ax, word ptr [bp+var_6]
    mov     dx, word ptr [bp+var_6+2]
    add     ax, 10h         ; plane rotation matrix
    push    si
    lea     di, [bp+mat_134]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 9
    repne movsw
    pop     ds
    pop     si
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    call    mat_invert
    add     sp, 4
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_182]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    lea     ax, [bp+vec_1C]
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_1E4]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     [bp+var_136], 0
    cmp     byte_4392C, 0
    jnz     short loc_15879
    cmp     [bp+vec_C.vy], 0FFF4h
    jge     short loc_15879
    cmp     [bp+vec_1C.vy], 0FFF4h
    jge     short loc_15879
    cmp     [bp+vec_1C.vy], 0FFE8h
    jle     short loc_158DA
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 5
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
    mov     [bp+var_136], 1
loc_15879:
    cmp     [bp+vec_1C.vy], 0
    jz      short loc_15882
    jmp     loc_1599E
loc_15882:
    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     vec_unk2.vz, 40h ; '@'
    mov     ax, planindex
    mov     planindex_copy, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, [bp+di+var_140someWhlData]
    mov     pState_f36Mminf40sar2, ax
    push    cs
    call near ptr plane_rotate_op
    mov     ax, vec_planerotopresult.vx
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.lx], ax
    sbb     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, vec_planerotopresult.vy
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.ly], ax
    sbb     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, vec_planerotopresult.vz
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.lz], ax
    sbb     word ptr [bx+(VECTORLONG.lz+2)], dx
    jmp     loc_15CDF
loc_158DA:
    mov     planindex, 0
    mov     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     word ptr current_planptr, ax
    mov     word ptr current_planptr+2, dx
    mov     byte_4392C, 1
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_158FE:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_158FE
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15916:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15916
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_1592E:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1592E
    mov     [bp+vec_1C6.vz], ax
    push    ax
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    sub     ax, ax
    push    ax
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     nextPosAndNormalIP, ax
loc_15950:
    cmp     nextPosAndNormalIP, 0
    jg      short loc_1595A
    jmp     loc_156ED
loc_1595A:
    cmp     [bp+var_F0], 0
    jg      short loc_15964
    jmp     loc_15642
loc_15964:
    cmp     nextPosAndNormalIP, 18h
    jl      short loc_1596E
    jmp     loc_15642
loc_1596E:
    mov     ax, [bp+vec_E4.vx]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_E4.vy]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_E4.vz]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx
    jmp     loc_156ED
    ; align 2
    db 144
loc_1599E:
    cmp     [bp+vec_C.vy], 0
    jle     short loc_159AD
    cmp     [bp+vec_1C.vy], 0
    jge     short loc_159AD
    jmp     loc_15A30
loc_159AD:
    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     ax, [bp+var_pSpeed2Scaled]
    mov     vec_unk2.vz, ax
    mov     ax, planindex
    mov     planindex_copy, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, [bp+di+var_140someWhlData]
    mov     pState_f36Mminf40sar2, ax
    push    cs
    call near ptr plane_rotate_op
    mov     ax, vec_planerotopresult.vx
    cwd
    mov     bx, [bp+var_146ptrTo176]
    mov     cx, word ptr [bx+VECTORLONG.lx]
    mov     di, word ptr [bx+(VECTORLONG.lx+2)]
    add     cx, ax
    adc     di, dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], cx
    mov     word ptr [bx+(VECTORLONG.lx+2)], di
    mov     ax, vec_planerotopresult.vy
    cwd
    mov     bx, [bp+var_146ptrTo176]
    mov     cx, word ptr [bx+VECTORLONG.ly]
    mov     di, word ptr [bx+(VECTORLONG.ly+2)]
    add     cx, ax
    adc     di, dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], cx
    mov     word ptr [bx+(VECTORLONG.ly+2)], di
    mov     ax, vec_planerotopresult.vz
    cwd
    mov     bx, [bp+var_146ptrTo176]
    mov     cx, word ptr [bx+VECTORLONG.lz]
    mov     di, word ptr [bx+(VECTORLONG.lz+2)]
    add     cx, ax
    adc     di, dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], cx
    mov     word ptr [bx+(VECTORLONG.lz+2)], di
    jmp     loc_15C04
    ; align 2
    db 144
loc_15A30:
    mov     ax, [bp+vec_C.vz]
    mov     [bp+var_EE], ax
    mov     ax, [bp+vec_C.vy]
    neg     ax
    mov     [bp+vec_C.vz], ax
    mov     ax, [bp+var_EE]
    mov     [bp+vec_C.vy], ax
    mov     ax, [bp+vec_1C.vz]
    mov     [bp+var_EE], ax
    mov     ax, [bp+vec_1C.vy]
    neg     ax
    mov     [bp+vec_1C.vz], ax
    mov     ax, [bp+var_EE]
    mov     [bp+vec_1C.vy], ax
    sub     ax, ax
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+vec_1C]
    push    ax
    call    vector_op_unk
    add     sp, 8
    mov     ax, [bp+vec_1C.vx]
    sub     ax, [bp+vec_FC.vx]
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_17C.vx], ax
    mov     ax, [bp+vec_1C.vy]
    sub     ax, [bp+vec_FC.vy]
    shl     ax, cl
    mov     [bp+vec_17C.vy], ax
    mov     ax, [bp+vec_1C.vz]
    sub     ax, [bp+vec_FC.vz]
    shl     ax, cl
    mov     [bp+vec_17C.vz], ax
    lea     ax, [bp+vec_17C]
    push    ax
    call    polarRadius3D
    add     sp, 2
    mov     [bp+var_EE], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+di+CARSTATE.car_rc1]
    add     ax, [bp+var_pSpeed2Scaled]
    mov     [bp+var_F4], ax
    sub     ax, [bp+var_EE]
    mov     [bp+var_F2], ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F2]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lx]
    sbb     dx, word ptr [bx+(VECTORLONG.lx+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vx], ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F2]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.ly]
    sbb     dx, word ptr [bx+(VECTORLONG.ly+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vy], ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F2]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lz]
    sbb     dx, word ptr [bx+(VECTORLONG.lz+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vz], ax
    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     ax, [bp+var_EE]
    mov     vec_unk2.vz, ax
    mov     ax, planindex
    mov     planindex_copy, ax
    mov     ax, [bp+di+var_140someWhlData]
    mov     pState_f36Mminf40sar2, ax
    push    cs
    call near ptr plane_rotate_op
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cx, ax
    mov     ax, [bp+vec_C.vx]
    mov     bx, dx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, vec_planerotopresult.vx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, bx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], cx
    mov     word ptr [bx+(VECTORLONG.lx+2)], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cx, ax
    mov     ax, [bp+vec_C.vy]
    mov     bx, dx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, vec_planerotopresult.vy
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, bx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], cx
    mov     word ptr [bx+(VECTORLONG.ly+2)], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cx, ax
    mov     ax, [bp+vec_C.vz]
    mov     bx, dx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, vec_planerotopresult.vz
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, bx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], cx
    mov     word ptr [bx+(VECTORLONG.lz+2)], ax
loc_15C04:
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15C0F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15C0F
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15C27:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15C27
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15C3F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15C3F
    mov     [bp+vec_1C6.vz], ax
    push    ax
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     nextPosAndNormalIP, ax
    or      ax, ax
    jge     short loc_15CDF
    cmp     [bp+var_136], 0
    jz      short loc_15C75
    neg     ax
    add     ax, 6
    mov     nextPosAndNormalIP, ax
loc_15C75:
    mov     [bp+vec_1C6.vz], 0
    mov     [bp+vec_1C6.vx], 0
    mov     ax, nextPosAndNormalIP
    neg     ax
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_1C6.vy], ax
    lea     ax, [bp+vec_FC]
    push    ax
    mov     ax, 22h ; '"'
    imul    planindex
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    add     ax, 10h
    push    dx
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    push    cs
    call near ptr mat_mul_vector2
    add     sp, 8
    mov     ax, [bp+vec_FC.vx]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
loc_15CBE:
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_FC.vy]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_FC.vz]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx
loc_15CDF:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
loc_15CE8:
    mov     bx, [bp+arg_pState]
    cmp     [bx+di+CARSTATE.car_rc1], 0FAh ; 'ú'
    jle     short loc_15CF7
smart
    or      [bx+CARSTATE.field_CF], 20h
nosmart
loc_15CF7:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    cmp     [bx+di+CARSTATE.car_rc1], 5AEBh
    jle     short loc_15D1A
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
loc_15D1A:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     [bx+di+CARSTATE.car_rc1], 0
loc_15D2B:
    add     [bp+var_DEptrTo1C0], 0Ch
    add     [bp+var_146ptrTo176], 0Ch
    inc     [bp+var_wheelIndex]
loc_15D39:
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_15D43
    jmp     loc_15163
loc_15D43:
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15D4E:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15D4E
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15D66:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15D66
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15D7E:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15D7E
    mov     [bp+vec_1C6.vz], ax
    cmp     state.game_inputmode, 2
    jz      short loc_15D94
    jmp     loc_151BA
loc_15D94:
    mov     wallindex, 0FFFFh
    mov     current_surf_type, tarmac
    mov     planindex, 0
    mov     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     word ptr current_planptr, ax
    mov     word ptr current_planptr+2, dx
    jmp     loc_151DB
loc_15DB6:
    mov     ax, [bp+var_EE]
    add     ax, 180h
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
loc_15DC8:
    add     [bp+var_DEptrTo1C0], 0Ch
    inc     [bp+var_wheelIndex]
loc_15DD1:
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_15DDB
    jmp     code_update_globalPos
loc_15DDB:
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15DE6:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15DE6
    mov     cx, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_whlWorldCrds1.vx], cx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15E0F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15E0F
    mov     cx, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_whlWorldCrds1.vy], cx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15E38:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15E38
    mov     cx, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_whlWorldCrds1.vz], cx
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    push    di
    mov     bx, di
    shl     bx, 1
    add     bx, bp
    push    [bx+var_16]     ; var_(16-2*wheelIndex)
    push    [bp+arg_pState]
    push    cs
    call near ptr carState_rc_op
    add     sp, 6
    mov     [bp+var_EE], ax
    cmp     pState_minusRotate_z_1, 0
    jnz     short loc_15E85
    cmp     pState_minusRotate_x_1, 0
    jnz     short loc_15E85
    jmp     loc_15DB6
loc_15E85:
    mov     [bp+vec_1C6.vz], 0
    mov     [bp+vec_1C6.vx], 0
    mov     ax, [bp+var_EE]
    add     ax, 180h
    mov     [bp+vec_1C6.vy], ax
    lea     ax, [bp+vec_182]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+vec_182.vx]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_182.vy]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_182.vz]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx
    jmp     loc_15DC8
    ; align 2
    db 144
code_update_globalPos:
    mov     ax, word ptr [bp+vecl_1C0.lx]
    mov     dx, word ptr [bp+vecl_1C0.lx+2]
    add     ax, word ptr [bp+vecl_1C0.lx+0Ch]
    adc     dx, word ptr [bp+vecl_1C0.lx+0Eh]
    add     ax, word ptr [bp+vecl_1C0.lx+18h]
    adc     dx, word ptr [bp+vecl_1C0.lx+1Ah]
    add     ax, word ptr [bp+vecl_1C0.lx+24h]
    adc     dx, word ptr [bp+vecl_1C0.lx+26h]
    mov     cl, 2
loc_15F04:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15F04
    mov     word ptr pState_lvec1_x, ax
    mov     word ptr pState_lvec1_x+2, dx
    mov     ax, word ptr [bp+vecl_1C0.ly]
    mov     dx, word ptr [bp+vecl_1C0.ly+2]
    add     ax, word ptr [bp+vecl_1C0.ly+0Ch]
    adc     dx, word ptr [bp+vecl_1C0.ly+0Eh]
    add     ax, word ptr [bp+vecl_1C0.ly+18h]
    adc     dx, word ptr [bp+vecl_1C0.ly+1Ah]
    add     ax, word ptr [bp+vecl_1C0.ly+24h]
    adc     dx, word ptr [bp+vecl_1C0.ly+26h]
    mov     cl, 2
loc_15F35:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15F35
    mov     word ptr pState_lvec1_y, ax
    mov     word ptr pState_lvec1_y+2, dx
    mov     ax, word ptr [bp+vecl_1C0.lz]
    mov     dx, word ptr [bp+vecl_1C0.lz+2]
    add     ax, word ptr [bp+vecl_1C0.lz+0Ch]
    adc     dx, word ptr [bp+vecl_1C0.lz+0Eh]
    add     ax, word ptr [bp+vecl_1C0.lz+18h]
    adc     dx, word ptr [bp+vecl_1C0.lz+1Ah]
    add     ax, word ptr [bp+vecl_1C0.lz+24h]
    adc     dx, word ptr [bp+vecl_1C0.lz+26h]
    mov     cl, 2
loc_15F66:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15F66
    mov     word ptr pState_lvec1_z, ax
    mov     word ptr pState_lvec1_z+2, dx
    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    mov     [bp+var_wheelIndex], 0
code_update_rotCoords:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    sub     ax, word ptr pState_lvec1_x
    mov     [di+vec_1DE.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    sub     ax, word ptr pState_lvec1_y
    mov     [di+vec_1DE.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    sub     ax, word ptr pState_lvec1_z
    mov     [di+vec_1DE.vz], ax
    add     [bp+var_DEptrTo1C0], 0Ch
    inc     [bp+var_wheelIndex]
    cmp     [bp+var_wheelIndex], 4
    jl      short code_update_rotCoords
    cmp     word ptr pState_lvec1_y+2, 0
    jge     short loc_15FDE
    sub     ax, ax
    mov     word ptr pState_lvec1_y+2, ax
    mov     word ptr pState_lvec1_y, ax
loc_15FDE:
    cmp     word ptr pState_lvec1_x+2, 1Dh
    jl      short loc_15FFE
    jg      short loc_15FEF
    cmp     word ptr pState_lvec1_x, 0F100h
    jbe     short loc_15FFE
loc_15FEF:
    mov     word ptr pState_lvec1_x, 0F0FFh
    mov     word ptr pState_lvec1_x+2, 1Dh
    jmp     short loc_1601B
    ; align 2
    db 144
loc_15FFE:
    cmp     word ptr pState_lvec1_x+2, 0
    jg      short loc_1601B
    jl      short loc_1600F
    cmp     word ptr pState_lvec1_x, 0F00h
    jnb     short loc_1601B
loc_1600F:
    mov     word ptr pState_lvec1_x, 0F00h
    mov     word ptr pState_lvec1_x+2, 0
loc_1601B:
    cmp     word ptr pState_lvec1_z+2, 1Dh
    jl      short loc_1603A
    jg      short loc_1602C
    cmp     word ptr pState_lvec1_z, 0F100h
    jbe     short loc_1603A
loc_1602C:
    mov     word ptr pState_lvec1_z, 0F0FFh
    mov     word ptr pState_lvec1_z+2, 1Dh
    jmp     short loc_16057
loc_1603A:
    cmp     word ptr pState_lvec1_z+2, 0
    jg      short loc_16057
    jl      short loc_1604B
    cmp     word ptr pState_lvec1_z, 0F00h
    jnb     short loc_16057
loc_1604B:
    mov     word ptr pState_lvec1_z, 0F00h
    mov     word ptr pState_lvec1_z+2, 0
loc_16057:
    mov     ax, [bp+vec_1DE.vx+12h]
    add     ax, [bp+vec_1DE.vx+0Ch]
    sub     ax, [bp+vec_1DE.vx]
    sub     ax, [bp+vec_1DE.vx+6]
    mov     [bp+var_EE], ax
    mov     ax, [bp+vec_1DE.vz+12h]
    add     ax, [bp+vec_1DE.vz+0Ch]
    sub     ax, [bp+vec_1DE.vz]
    sub     ax, [bp+vec_1DE.vz+6]
    mov     [bp+var_F2], ax
    neg     ax
    push    ax
    push    [bp+var_EE]
    call    polarAngle
    add     sp, 4
smart
    and     ah, 3
nosmart
    mov     pState_minusRotate_y_1, ax
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     [bp+var_wheelIndex], 0
loc_160A7:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    sub     di, 1DEh
    push    si
    push    di
    mov     si, di
    lea     di, [bp+vec_FC]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    push    di
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    inc     [bp+var_wheelIndex]
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_160A7
    mov     ax, [bp+vec_1DE.vz+12h]
    add     ax, [bp+vec_1DE.vz+0Ch]
    sub     ax, [bp+vec_1DE.vz]
    sub     ax, [bp+vec_1DE.vz+6]
    mov     [bp+var_F2], ax
    mov     ax, [bp+vec_1DE.vy+12h]
    add     ax, [bp+vec_1DE.vy+0Ch]
    sub     ax, [bp+vec_1DE.vy]
    sub     ax, [bp+vec_1DE.vy+6]
    mov     [bp+var_F4], ax
    or      ax, ax
    jnz     short loc_1611C
    cmp     [bp+var_F2], 0
    jl      short loc_16146
loc_1611C:
    push    [bp+var_F4]
    mov     ax, [bp+var_F2]
    neg     ax
    push    ax
    call    polarAngle
    add     sp, 4
    sub     ax, 100h
    mov     pState_minusRotate_x_1, ax
    or      ax, ax
    jge     short loc_1613E
    neg     ax
    jmp     short loc_16141
    ; align 2
    db 144
loc_1613E:
    mov     ax, pState_minusRotate_x_1
loc_16141:
    cmp     ax, 2
    jge     short loc_1614C
loc_16146:
    mov     pState_minusRotate_x_1, 0
loc_1614C:
    cmp     pState_minusRotate_x_1, 0
    jz      short loc_161AB
    push    pState_minusRotate_x_1
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    call    mat_rot_x
    add     sp, 4
    mov     [bp+var_wheelIndex], 0
loc_16169:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    sub     di, 1DEh
    push    si
    push    di
    mov     si, di
    lea     di, [bp+vec_FC]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    push    di
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    inc     [bp+var_wheelIndex]
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_16169
loc_161AB:
    mov     ax, [bp+vec_1DE.vx+6]
    add     ax, [bp+vec_1DE.vx+0Ch]
    sub     ax, [bp+vec_1DE.vx]
    sub     ax, [bp+vec_1DE.vx+12h]
    mov     [bp+var_F2], ax
    mov     ax, [bp+vec_1DE.vy+6]
    add     ax, [bp+vec_1DE.vy+0Ch]
    sub     ax, [bp+vec_1DE.vy]
    sub     ax, [bp+vec_1DE.vy+12h]
    mov     [bp+var_F4], ax
    or      ax, ax
    jnz     short loc_161DE
    cmp     [bp+var_F2], 0
    jg      short loc_16204
loc_161DE:
    push    [bp+var_F4]
    push    [bp+var_F2]
    call    polarAngle
    add     sp, 4
    sub     ax, 100h
    mov     pState_minusRotate_z_1, ax
    or      ax, ax
    jge     short loc_161FC
    neg     ax
    jmp     short loc_161FF
loc_161FC:
    mov     ax, pState_minusRotate_z_1
loc_161FF:
    cmp     ax, 2
    jge     short loc_1620A
loc_16204:
    mov     pState_minusRotate_z_1, 0
loc_1620A:
    mov     bx, [bp+arg_pState]
    mov     di, bx
    mov     al, [di+CARSTATE.car_surfaceWhl]
    add     al, [di+(CARSTATE.car_surfaceWhl+1)]
    mov     [bx+CARSTATE.car_sumSurfFrontWheels], al
    mov     bx, [bp+arg_pState]
    mov     di, bx
    mov     al, [di+(CARSTATE.car_surfaceWhl+2)]
    add     al, [di+(CARSTATE.car_surfaceWhl+3)]
    mov     [bx+CARSTATE.car_sumSurfRearWheels], al
    cmp     state.game_inputmode, 2
    jnz     short loc_16236
    jmp     loc_16840
loc_16236:
    cmp     is_in_replay, 0
    jnz     short loc_1625F
    cmp     [bp+arg_MplayerFlag], 0
    jz      short loc_1624A
    push    word_4408C
    jmp     short loc_1624E
    ; align 2
    db 144
loc_1624A:
    push    word_43964
loc_1624E:
    mov     bx, [bp+arg_pState]
    mov     al, [bx+CARSTATE.field_CF]
    sub     ah, ah
    push    ax
    push    cs
    call near ptr audio_unk3
    add     sp, 4
loc_1625F:
    sub     ax, ax
    push    ax
    mov     ax, pState_minusRotate_y_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_x_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_z_1
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_EA], ax
    mov     [bp+var_wheelIndex], 0
    jmp     loc_1632C
loc_16288:
    mov     ax, planindex
    mov     [bp+var_E], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    push    si
    lea     si, [bx+di+CARSTATE.car_whlWorldCrds2]
    lea     di, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    lea     ax, [bp+vec_17C]
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    build_track_object
    add     sp, 4
    mov     ax, planindex
    cmp     [bp+var_E], ax
    jnz     short loc_16309
    push    [bp+vec_1C6.vz]
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    ax
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     [bp+var_138], ax
    cmp     game_replay_mode, 1
    jz      short loc_16309
    or      si, si
    jge     short loc_162EE
    or      ax, ax
    jg      short loc_162F9
loc_162EE:
    or      si, si
    jle     short loc_16309
    cmp     [bp+var_138], 0
    jge     short loc_16309
loc_162F9:
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 5
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
loc_16309:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    push    si
    lea     di, [bx+di+CARSTATE.car_whlWorldCrds2]
    lea     si, [bp+vec_17C]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    pop     si
    inc     [bp+var_wheelIndex]
loc_1632C:
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_16336
    jmp     loc_16428
loc_16336:
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pSimd]
    push    si
    lea     si, [bx+di+SIMD.wheel_coords]
    lea     di, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     bx, [bp+arg_pSimd]
    mov     ax, [bx+SIMD.collide_points.y2]
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_1C6.vy], ax
    lea     ax, [bp+vec_FC]
    push    ax
    push    [bp+var_EA]
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+vec_FC.vx]
    cwd
    add     ax, word ptr pState_lvec1_x
    adc     dx, word ptr pState_lvec1_x+2
    mov     cl, 6
loc_16389:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16389
    mov     [bp+vec_1C6.vx], ax
    mov     ax, [bp+vec_FC.vy]
    cwd
    add     ax, word ptr pState_lvec1_y
    adc     dx, word ptr pState_lvec1_y+2
    mov     cl, 6
loc_163A4:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_163A4
    mov     [bp+vec_1C6.vy], ax
    mov     ax, [bp+vec_FC.vz]
    cwd
    add     ax, word ptr pState_lvec1_z
    adc     dx, word ptr pState_lvec1_z+2
    mov     cl, 6
loc_163BF:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_163BF
    mov     [bp+vec_1C6.vz], ax
    push    si
    lea     di, [bp+vec_17C]
    lea     si, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+arg_pState]
    add     ax, CARSTATE.car_whlWorldCrds2
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    build_track_object
    add     sp, 4
    push    [bp+vec_1C6.vz]
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     si, ax
    cmp     planindex, 4
    jl      short loc_1641E
    jmp     loc_16288
loc_1641E:
    or      si, si
    jle     short loc_16425
    jmp     loc_16309
loc_16425:
    jmp     loc_162F9
loc_16428:
    mov     bx, [bp+arg_pState]
    mov     al, [bx+CARSTATE.car_sumSurfFrontWheels]
    add     al, [bx+CARSTATE.car_sumSurfRearWheels]
    mov     [bp+var_11C], al
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_1644C
    or      al, al
    jnz     short loc_1644C
    cmp     [bx+CARSTATE.car_sumSurfAllWheels], 0
    jz      short loc_1644C
    inc     state.game_jumpCount
loc_1644C:
    mov     al, [bp+var_11C]
    mov     [bx+CARSTATE.car_sumSurfAllWheels], al
    mov     ax, word ptr pState_lvec1_x
    mov     dx, word ptr pState_lvec1_x+2
    mov     cl, 6
loc_1645D:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1645D
    mov     [bp+var_11ApStateWorldCrds.vx], ax
    mov     ax, word ptr pState_lvec1_y
    mov     dx, word ptr pState_lvec1_y+2
    mov     cl, 6
loc_16472:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16472
    mov     [bp+var_11ApStateWorldCrds.vy], ax
    mov     ax, word ptr pState_lvec1_z
    mov     dx, word ptr pState_lvec1_z+2
    mov     cl, 6
loc_16487:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16487
    mov     [bp+var_11ApStateWorldCrds.vz], ax
    mov     ax, pState_minusRotate_z_1
    mov     [bp+var_11ApStateWorldCrds.vx+6], ax
    mov     ax, pState_minusRotate_x_1
    mov     [bp+var_11ApStateWorldCrds.vy+6], ax
    mov     ax, pState_minusRotate_y_1
    mov     [bp+var_11ApStateWorldCrds.vz+6], ax
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_164B2
    jmp     loc_16578
loc_164B2:
    mov     bx, [bp+arg_oState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lx]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lx+2)]
    mov     cl, 6
loc_164BC:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_164BC
    mov     [bp+vec_18EoStateWorldCrds.vx], ax
    mov     bx, [bp+arg_oState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.ly]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.ly+2)]
    mov     cl, 6
loc_164D3:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_164D3
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     bx, [bp+arg_oState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lz]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lz+2)]
    mov     cl, 6
loc_164EA:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_164EA
    mov     [bp+vec_18EoStateWorldCrds.vz], ax
    mov     bx, [bp+arg_oState]
    mov     ax, [bx+CARSTATE.car_rotate.vz]
    mov     [bp+vec_18EoStateWorldCrds.vx+6], ax
    mov     ax, [bx+CARSTATE.car_rotate.vy]
    mov     [bp+vec_18EoStateWorldCrds.vy+6], ax
    mov     ax, [bx+CARSTATE.car_rotate.vx]
    mov     [bp+vec_18EoStateWorldCrds.vz+6], ax
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_oSimd]
    add     ax, SIMD.collide_points
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    or      al, al
    jz      short loc_16578
    mov     bx, [bp+arg_pState]
    cmp     [bx+CARSTATE.field_C8], 0
    jz      short loc_1653E
    jmp     loc_16892
loc_1653E:
    push    [bp+arg_oState]
    push    bx
    push    cs
    call near ptr car_car_speed_adjust_maybe
    add     sp, 4
    or      al, al
    jnz     short loc_16550
    jmp     loc_16892
loc_16550:
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
    mov     al, [bp+arg_MplayerFlag]
    cbw
    xor     al, 1
loc_16566:
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_16578:
    mov     ax, [bp+var_11ApStateWorldCrds.vx]
    mov     cl, 0Ah
    sar     ax, cl
    mov     [bp+vec_FC.vx], ax
    mov     ax, [bp+var_11ApStateWorldCrds.vz]
    sar     ax, cl          ; /2^10 : scale to tile index.
    sub     ax, 1Dh
    neg     ax
    mov     [bp+vec_FC.vz], ax
    mov     [bp+vec_18EoStateWorldCrds.vx+6], 0
    mov     [bp+vec_18EoStateWorldCrds.vy+6], 0
    mov     [bp+vec_18EoStateWorldCrds.vz+6], 0
    cmp     [bp+vec_FC.vx], 0
    jge     short loc_165AF
    jmp     loc_16840
loc_165AF:
    cmp     [bp+vec_FC.vx], 1Eh
    jl      short loc_165B9
    jmp     loc_16840
loc_165B9:
    or      ax, ax
    jge     short loc_165C0
    jmp     loc_16840
loc_165C0:
    cmp     ax, 1Eh
    jl      short loc_165C8
    jmp     loc_16840
loc_165C8:
    lea     ax, [bp+var_DC]
    push    ax
    push    [bp+vec_FC.vz]
    push    [bp+vec_FC.vx]
    call    bto_auxiliary1
    add     sp, 6
    mov     [bp+var_EC], al
    or      al, al
    jz      short loc_16650
    sub     si, si
    jmp     short loc_165F0
    ; align 2
    db 144
loc_165EA:
    add     [bp+var_144], 6
    inc     si
loc_165F0:
    mov     al, [bp+var_EC]
    sub     ah, ah
    cmp     ax, si
    jbe     short loc_16650
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    mov     ax, [di-0DCh]
    mov     [bp+vec_18EoStateWorldCrds.vx], ax
    mov     ax, [di-0DAh]
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     ax, [di-0D8h]
    mov     [bp+vec_18EoStateWorldCrds.vz], ax
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD6A
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    or      al, al
    jz      short loc_165EA
    mov     bx, [bp+arg_pState]
    sub     [bx+CARSTATE.car_36MwhlAngle], 200h
loc_16648:
    mov     al, [bp+arg_MplayerFlag]
    cbw
    jmp     loc_16566
    ; align 2
    db 144
loc_16650:
    mov     bx, [bp+vec_FC.vz]
    shl     bx, 1
    mov     bx, trackrows[bx]
    add     bx, [bp+vec_FC.vx]
    les     di, trackdata19
    mov     al, es:[bx+di]
    cbw
    mov     si, ax
    cmp     si, 0FFFFh
    jnz     short loc_16670
    jmp     loc_16710
loc_16670:
    cmp     state.field_3FA[si], 0
    jz      short loc_1667A
    jmp     loc_16710
loc_1667A:
    mov     bx, si
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    les     di, td10_track_check_rel
    mov     ax, es:[bx+di]
    mov     [bp+vec_18EoStateWorldCrds.vx], ax
    mov     di, si
    mov     ax, di
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, word ptr td10_track_check_rel
    mov     ax, es:[bx+di+2]
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     di, si
    mov     ax, di
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     ax, es:[bx+di+4]
    mov     [bp+vec_18EoStateWorldCrds.vz], ax
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD5A
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    or      al, al
    jz      short loc_16710
    mov     state.field_3FA[si], 1
    mov     ax, 3C00h       ; 15360 = track grid length / 2
    cwd
    push    dx
    push    ax
    mov     ax, 580h        ; 1408
    cwd
    push    dx
    push    ax
    mov     bx, [bp+arg_pState]
    sub     ax, ax
    push    ax
    push    [bx+CARSTATE.car_speed2]
    call    __aFlmul
    push    dx
    push    ax
    call    __aFuldiv       ; *11/120
    push    ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rotate.vx]
    neg     ax
    push    ax
    lea     ax, [si+2]
    push    ax
    push    cs
    call near ptr state_op_unk
    add     sp, 6
loc_16710:
    mov     al, startcol2
    cbw
    mov     di, ax
    cmp     [bp+vec_FC.vx], di
    jz      short loc_1671F
    jmp     loc_16840
loc_1671F:
    mov     al, startrow2
    cbw
    cmp     [bp+vec_FC.vz], ax
    jz      short loc_1672C
    jmp     loc_16840
loc_1672C:
    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 1
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, di
    shl     bx, 1
    mov     cx, trackcenterpos2[bx]
    add     cx, ax
    mov     [bp+vec_18EoStateWorldCrds.vx], cx
    mov     al, hillFlag
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, hillHeightConsts[bx]
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 1
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, ax
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    add     cx, trackcenterpos[bx]
    mov     [bp+vec_18EoStateWorldCrds.vz], cx
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD62
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    cbw
loc_167B1:
    mov     [bp+var_138], ax
    or      ax, ax
    jnz     short loc_16836
    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 3
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, ax
    mov     al, startcol2
    cbw
    mov     bx, ax
    shl     bx, 1
    add     cx, trackcenterpos2[bx]
    mov     [bp+vec_18EoStateWorldCrds.vx], cx
    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 3
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, ax
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    add     cx, trackcenterpos[bx]
    mov     [bp+vec_18EoStateWorldCrds.vz], cx
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD62
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    cbw
    mov     [bp+var_138], ax
loc_16836:
    cmp     [bp+var_138], 0
    jz      short loc_16840
    jmp     loc_16648
loc_16840:
    mov     bx, [bp+arg_pState]
    mov     ax, word ptr pState_lvec1_x
    mov     dx, word ptr pState_lvec1_x+2
    mov     word ptr [bx+CARSTATE.car_posWorld1.lx], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld1.lx+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, word ptr pState_lvec1_y
    mov     dx, word ptr pState_lvec1_y+2
    mov     word ptr [bx+CARSTATE.car_posWorld1.ly], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld1.ly+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, word ptr pState_lvec1_z
    mov     dx, word ptr pState_lvec1_z+2
    mov     word ptr [bx+CARSTATE.car_posWorld1.lz], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld1.lz+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, pState_minusRotate_z_1
    mov     [bx+CARSTATE.car_rotate.vz], ax
    mov     bx, [bp+arg_pState]
    mov     ax, pState_minusRotate_x_1
    mov     [bx+CARSTATE.car_rotate.vy], ax
    mov     bx, [bp+arg_pState]
    mov     ax, pState_minusRotate_y_1
    mov     [bx+CARSTATE.car_rotate.vx], ax
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.field_C8], 0
loc_16892:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
update_player_state endp
init_carstate_from_simd proc far
    var_E = word ptr -14
    var_C = word ptr -12
    var_initX = word ptr -10
    var_initY = word ptr -8
    var_initZ = word ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_pState = word ptr 6
    arg_pSimd = word ptr 8
    arg_pTransm = byte ptr 10
    arg_posX_ax = word ptr 12
    arg_posX_dx = word ptr 14
    arg_posY_ax = word ptr 16
    arg_posY_dx = word ptr 18
    arg_posZ_ax = word ptr 20
    arg_posZ_dx = word ptr 22
    arg_MTrackAngle = word ptr 24

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    di
    push    si
    sub     si, si
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_posX_ax]
    mov     dx, [bp+arg_posX_dx]
    mov     word ptr [bx+CARSTATE.car_posWorld1.lx], ax
    mov     word ptr [bx+CARSTATE.car_posWorld1.lx+2], dx
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_posX_ax]
    mov     dx, [bp+arg_posX_dx]
    mov     word ptr [bx+CARSTATE.car_posWorld2.lx], ax
    mov     word ptr [bx+CARSTATE.car_posWorld2.lx+2], dx
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_posY_ax]
    mov     dx, [bp+arg_posY_dx]
    add     ax, 200h
    adc     dx, si
    mov     word ptr [bx+CARSTATE.car_posWorld1.ly], ax
    mov     word ptr [bx+CARSTATE.car_posWorld1.ly+2], dx
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_posY_ax]
    mov     dx, [bp+arg_posY_dx]
    mov     word ptr [bx+CARSTATE.car_posWorld2.ly], ax
    mov     word ptr [bx+CARSTATE.car_posWorld2.ly+2], dx
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_posZ_ax]
    mov     dx, [bp+arg_posZ_dx]
    mov     word ptr [bx+CARSTATE.car_posWorld1.lz], ax
    mov     word ptr [bx+CARSTATE.car_posWorld1.lz+2], dx
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_posZ_ax]
    mov     dx, [bp+arg_posZ_dx]
    mov     word ptr [bx+CARSTATE.car_posWorld2.lz], ax
    mov     word ptr [bx+CARSTATE.car_posWorld2.lz+2], dx
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_MTrackAngle]
    mov     [bx+CARSTATE.car_rotate.vx], ax
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_rotate.vy], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_rotate.vz], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_36MwhlAngle], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_pseudoGravity], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_steeringAngle], si
    mov     bx, [bp+arg_pState]
    sub     al, al
    mov     [bx+CARSTATE.car_is_braking], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_is_accelerating], al
    mov     bx, [bp+arg_pSimd]
    mov     ax, [bx+SIMD.idle_rpm]
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_currpm], ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_currpm]
    mov     [bx+CARSTATE.car_lastrpm], ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_currpm]
    mov     [bx+CARSTATE.car_idlerpm2], ax
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_current_gear], 1
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_speeddiff], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_speed], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_speed2], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_lastspeed], si
    mov     bx, [bp+arg_pSimd]
    mov     ax, [bx+(SIMD.gear_ratios+2)]
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_gearratio], ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_gearratio]
    mov     cl, 8
    shr     ax, cl
    mov     [bx+CARSTATE.car_gearratioshr8], ax
    mov     bx, [bp+arg_pSimd]
    mov     ax, [bx+(SIMD.knob_points.x2+4)]
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_knob_x], ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_knob_x]
    mov     [bx+CARSTATE.car_knob_x2], ax
    mov     bx, [bp+arg_pSimd]
    mov     ax, [bx+(SIMD.knob_points.y2+4)]
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_knob_y], ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_knob_y]
    mov     [bx+CARSTATE.car_knob_y2], ax
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_angle_z], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_40MfrontWhlAngle], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.field_42], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.field_48], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_trackdata3_index], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_sumSurfFrontWheels], 2
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_sumSurfRearWheels], 2
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_sumSurfAllWheels], 4
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_demandedGrip], si
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_surfacegrip_sum], 3E8h
    mov     ax, [bp+arg_posX_ax]
    mov     dx, [bp+arg_posX_dx]
    mov     cl, 6
loc_16A04:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16A04
    mov     [bp+var_initX], ax
    mov     ax, [bp+arg_posY_ax]
    mov     dx, [bp+arg_posY_dx]
    mov     cl, 6
loc_16A17:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16A17
    mov     [bp+var_initY], ax
    mov     ax, [bp+arg_posZ_ax]
    mov     dx, [bp+arg_posZ_dx]
    mov     cl, 6
loc_16A2A:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16A2A
    mov     [bp+var_initZ], ax
    sub     di, di
loc_16A37:
    mov     bx, [bp+arg_pState]
    mov     [bx+di+CARSTATE.car_surfaceWhl], 1; initial surface = tarmac
    mov     ax, di
    shl     ax, 1
    mov     [bp+var_C], ax
    mov     bx, [bp+arg_pState]
    add     bx, ax
    mov     [bx+CARSTATE.car_rc1], si; .rc1
    mov     bx, [bp+arg_pState]
    add     bx, [bp+var_C]
    mov     [bx+CARSTATE.car_rc2], si; rc2
    mov     bx, [bp+arg_pState]
    add     bx, [bp+var_C]
    mov     [bx+CARSTATE.car_rc3], si; rc3
    mov     bx, [bp+arg_pState]
    add     bx, [bp+var_C]
    mov     [bx+CARSTATE.car_rc4], si; rc4
    mov     bx, [bp+arg_pState]
    add     bx, [bp+var_C]
    mov     [bx+CARSTATE.car_rc5], si; rc5
    mov     ax, di
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1           ; *6
    mov     [bp+var_E], ax
    mov     bx, [bp+arg_pState]
    add     bx, ax
    push    si
    push    di
    lea     di, [bx+CARSTATE.car_whlWorldCrds1]; ax is added into the offset
    lea     si, [bp+var_initX]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     bx, [bp+arg_pState]
    add     bx, [bp+var_E]
    push    si
    push    di
    lea     di, [bx+CARSTATE.car_whlWorldCrds2]
    lea     si, [bp+var_initX]; moves x, y and z.
    movsw
    movsw
    movsw
    pop     di
    pop     si
    inc     di
    cmp     di, 4
    jl      short loc_16A37
    mov     bx, [bp+arg_pState]
    mov     ax, si
    mov     [bx+CARSTATE.car_engineLimiterTimer], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_slidingFlag], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.field_C8], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_crashBmpFlag], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_changing_gear], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_fpsmul2], al
    mov     bx, [bp+arg_pState]
    mov     al, [bp+arg_pTransm]
    mov     [bx+CARSTATE.car_transmission], al
    mov     bx, [bp+arg_pState]
    mov     ax, si
    mov     [bx+CARSTATE.field_CD], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.field_CE], al
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.field_CF], 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
init_carstate_from_simd endp
init_game_state proc far
    var_A = word ptr -10
    var_8 = word ptr -8
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    di
    push    si
    sub     si, si
    cmp     [bp+arg_0], 0FFFFh
    jnz     short loc_16B4D
    mov     elapsed_time1, si
    sub     di, di
loc_16B18:
    mov     ax, 1120        ; sizeof(struct GAMESTATE)
    cwd
    push    dx
    push    ax
    mov     ax, di
    cwd
    push    dx
    push    ax
    call    __aFlmul
    add     ax, GAMESTATE.field_3F4
    adc     dx, 0
    add     ax, word ptr cvxptr
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, word ptr cvxptr+2
    mov     es, dx
    mov     bx, ax
    mov     ax, si
    mov     es:[bx], al
    inc     di
    cmp     di, 20
    jl      short loc_16B18 ; sizeof(struct GAMESTATE)
loc_16B4D:
    cmp     framespersec, 10
    jnz     short loc_16B5C
    mov     steerWhlRespTable_ptr, offset steerWhlRespTable_10fps
    jmp     short loc_16B62
loc_16B5C:
    mov     steerWhlRespTable_ptr, offset steerWhlRespTable_20fps
loc_16B62:
    mov     ax, 30
    imul    framespersec
    mov     word_45A00, ax
    mov     ax, 100
    cwd
    mov     cx, framespersec
    idiv    cx
    mov     word_4499C, ax
    cmp     [bp+arg_0], 0FFFDh
    jnz     short loc_16B82
    jmp     loc_16F34
loc_16B82:
    call    init_unknown
    mov     state.field_3F4, 1
    mov     state.game_frames_per_sec, 1
    mov     ax, si
    mov     state.game_inputmode, al
    mov     state.game_3F6autoLoadEvalFlag, al
    mov     state.game_frame_in_sec, si
    mov     state.field_2F4, si
    mov     state.field_3F7, al
    mov     state.field_3F7+1, al
    mov     di, si
    jmp     short loc_16BB3
loc_16BAC:
    mov     ax, si
    mov     state.field_3FA[di], al
    inc     di
loc_16BB3:
    cmp     di, 48
    jl      short loc_16BAC
    mov     di, si
    jmp     short loc_16BC5
loc_16BBC:
    mov     bx, di
    shl     bx, 1
    mov     word ptr state.field_38E[bx], si
    inc     di
loc_16BC5:
    cmp     di, 24
    jl      short loc_16BBC
    mov     ax, 200h
    push    ax
    mov     ax, track_angle
    add     ah, 3
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 1000h
    push    cx
    mov     cx, track_angle
    add     ch, 2
    push    cx
    mov     [bp+var_A], ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, [bp+var_A]
    mov     cx, ax
    mov     al, startcol2
    cbw
loc_16C0F:
    mov     dx, cx
    mov     cl, 0Ah
    shl     ax, cl
    add     dx, ax
    mov     state.game_vec1.vx, dx
    mov     al, hillFlag
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, hillHeightConsts[bx]
    add     ax, 3C0h
    mov     state.game_vec1.vy, ax
    mov     ax, 200h
    push    ax
    mov     ax, track_angle
    add     ah, 3
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 1000h
    push    cx
    mov     cx, track_angle
    add     ch, 2
    push    cx
    mov     [bp+var_A], ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, ax
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    add     cx, trackpos[bx]
    add     cx, [bp+var_A]
    mov     state.game_vec1.vz, cx
    push    si
    push    di
    mov     di, offset state.game_vec2
    mov     si, offset state.game_vec1
    push    ds
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    push    si
    push    di
    mov     di, offset state.game_vec3
    mov     si, offset state.game_vec1
    movsw
    movsw
    movsw
    pop     di
    pop     si
    push    si
    push    di
    mov     di, offset state.game_vec4
    mov     si, offset state.game_vec1
    movsw
    movsw
    movsw
    pop     di
    pop     si
    sub     ax, ax
    mov     word ptr state.game_travDist+2, ax
    mov     word ptr state.game_travDist, ax
    mov     state.game_frame, si
    mov     state.game_total_finish, si
    mov     state.field_144, si
    mov     state.game_pEndFrame, si
    mov     state.game_oEndFrame, si
    mov     state.game_penalty, si
    mov     state.game_impactSpeed, si
    mov     state.game_topSpeed, si
    mov     state.game_jumpCount, si
    mov     ax, 0D2h ; 'Ò'
    push    ax
    mov     ax, track_angle
    add     ah, 2
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 24h ; '$'
    push    cx
    mov     cx, track_angle
    add     ch, 1
    push    cx
    mov     [bp+var_A], ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, [bp+var_A]
    mov     [bp+var_8], ax
    mov     ax, 0D2h ; 'Ò'
    push    ax
    mov     ax, track_angle
    add     ah, 2
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 24h ; '$'
    push    cx
    mov     cx, track_angle
    add     ch, 1
    push    cx
    mov     [bp+var_A], ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, [bp+var_A]
    mov     [bp+var_2], ax
    mov     ax, track_angle
    neg     ax
    push    ax
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    add     ax, [bp+var_2]
    cwd
    mov     cl, 6
loc_16D6F:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_16D6F
    push    dx
    push    ax
    mov     al, hillFlag
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, hillHeightConsts[bx]
    cwd
    mov     cl, 6
loc_16D88:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_16D88
    push    dx
    push    ax
    mov     al, startcol2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    add     ax, [bp+var_8]
    cwd
    mov     cl, 6
loc_16DA4:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_16DA4
    push    dx
    push    ax
    mov     al, gameconfig.game_playertransmission
    cbw
    push    ax
    mov     ax, offset simd_player; dseg: simd_copy
    push    ax
    mov     ax, offset state.playerstate; dseg: state.playerstate
    push    ax
    push    cs
    call near ptr init_carstate_from_simd
    add     sp, 14h
    mov     state.field_2F2, si
    mov     ax, si
    mov     state.field_45D, al
    mov     state.field_45E, al
    mov     state.field_45B, al
    mov     state.field_45C, al
    mov     al, startcol2
    cbw
    mov     state.game_startcol, ax
    mov     state.game_startcol2, ax
    mov     al, startrow2
    cbw
    mov     state.game_startrow, ax
    mov     state.game_startrow2, ax
    cmp     [bp+arg_0], 0FFFEh
    jz      short loc_16E0A
    sub     ax, ax
    push    ax
    mov     al, state.playerstate.field_CE
    inc     state.playerstate.field_CE
    sub     ah, ah
    push    ax
    mov     ax, offset state.playerstate.car_vec_unk3
    push    ax
    push    state.playerstate.car_trackdata3_index
    push    cs
    call near ptr sub_18D60
    add     sp, 8
loc_16E0A:
    mov     ax, 0D2h ; 'Ò'
    push    ax
    mov     ax, track_angle
    add     ah, 2
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 24h ; '$'
    push    cx
    mov     cx, track_angle
    add     ch, 3
    push    cx
    mov     [bp+var_A], ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, [bp+var_A]
    mov     [bp+var_8], ax
    mov     ax, 0D2h ; 'Ò'
    push    ax
    mov     ax, track_angle
    add     ah, 2
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 24h ; '$'
    push    cx
    mov     cx, track_angle
    add     ch, 3
    push    cx
    mov     [bp+var_A], ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, [bp+var_A]
    mov     [bp+var_2], ax
    mov     ax, track_angle
    neg     ax
    push    ax
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    add     ax, [bp+var_2]
    cwd
    mov     cl, 6
loc_16EA6:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_16EA6
    push    dx
    push    ax
    mov     al, hillFlag
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, hillHeightConsts[bx]
    cwd
    mov     cl, 6
loc_16EBF:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_16EBF
    push    dx
    push    ax
    mov     al, startcol2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    add     ax, [bp+var_8]
    cwd
    mov     cl, 6
loc_16EDB:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_16EDB
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, offset simd_opponent
    push    ax
    mov     ax, offset state.opponentstate
    push    ax
    push    cs
    call near ptr init_carstate_from_simd
    add     sp, 14h
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_16F2F
    cmp     [bp+arg_0], 0FFFEh
    jz      short loc_16F2F
    mov     ax, offset state.field_3F9
    push    ax
    mov     al, state.opponentstate.field_CE
    inc     state.opponentstate.field_CE
    sub     ah, ah
    push    ax
    mov     ax, offset state.opponentstate.car_vec_unk3
    push    ax
    mov     bx, state.opponentstate.car_trackdata3_index
    shl     bx, 1
    add     bx, word ptr trackdata3
    mov     es, word ptr trackdata3+2
    push    word ptr es:[bx]
    push    cs
    call near ptr sub_18D60
    add     sp, 8
loc_16F2F:
    mov     ax, si
    mov     state.field_42A, al
loc_16F34:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
init_game_state endp
restore_gamestate proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_frame = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    cmp     [bp+arg_frame], 0
    jnz     short loc_16F59
    cmp     elapsed_time1, 0
    jnz     short loc_16F59
    sub     ax, ax
    push    ax
    push    cs
    call near ptr init_game_state
    add     sp, 2
loc_16F59:
    mov     ax, [bp+arg_frame]
    cwd
    mov     cx, word_45A00
    idiv    cx
    mov     si, ax
    cmp     si, 14h
    jnz     short loc_16F6B
    dec     si
loc_16F6B:
    mov     ax, state.game_frame
    cmp     [bp+arg_frame], ax
    jb      short loc_16FB1
loc_16F73:
    mov     ax, word_45A00
    imul    si
    cmp     ax, state.game_frame
    ja      short loc_16F81
    jmp     loc_17002
loc_16F81:
    mov     ax, 460h
    cwd
    push    dx
    push    ax
    mov     ax, si
    cwd
    push    dx
    push    ax
    call    __aFlmul
    add     ax, GAMESTATE.field_3F4
    adc     dx, 0
    add     ax, word ptr cvxptr
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, word ptr cvxptr+2
    mov     es, dx
    mov     bx, ax
    cmp     byte ptr es:[bx], 0
    jz      short loc_16FFE
loc_16FB1:
    mov     ax, 460h
    cwd
    push    dx
    push    ax
    mov     ax, si
    cwd
    push    dx
    push    ax
    call    __aFlmul
    add     ax, word ptr cvxptr
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, word ptr cvxptr+2
    push    si
    mov     di, offset state
    mov     si, ax
    push    ds
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 230h
    repne movsw
    pop     ds
    pop     si
    mov     ax, offset state.kevinseed
    push    ax
    call    init_kevinrandom
    add     sp, 2
    mov     ax, state.game_frame
    mov     elapsed_time2, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    db 144
    db 144
    db 144
loc_16FFE:
    dec     si
    jmp     loc_16F73
loc_17002:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
restore_gamestate endp
update_gamestate proc far
    var_carInputByte = byte ptr -4
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     bx, state.game_frame
    les     di, td16_rpl_buffer
    mov     al, es:[bx+di]
    mov     [bp+var_carInputByte], al
    or      al, al
    jz      short loc_17027
    mov     state.game_inputmode, 1
loc_17027:
    mov     ax, bx
    sub     dx, dx
    div     word_45A00
    or      dx, dx
    jnz     short loc_17079
    mov     ax, bx
    sub     dx, dx
    div     word_45A00
    mov     si, ax
    mov     ax, offset state.kevinseed
    push    ax
    call    get_kevinrandom_seed
    add     sp, 2
    mov     ax, 460h
    cwd
    push    dx
    push    ax
    mov     ax, si
    cwd
    push    dx
    push    ax
    call    __aFlmul
    add     ax, word ptr cvxptr
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, word ptr cvxptr+2
    mov     bx, ax
    mov     es, dx
    push    si
    mov     di, bx
    mov     si, offset state
    mov     cx, 230h
    repne movsw
    pop     si
loc_17079:
    inc     state.game_frame
    cmp     state.game_3F6autoLoadEvalFlag, 0
    jz      short loc_170BE
    mov     ax, state.game_frames_per_sec
    cmp     state.game_frame_in_sec, ax
    jge     short loc_170BE
    inc     state.game_frame_in_sec
    cmp     state.game_frame_in_sec, ax
    jnz     short loc_170BE
    cmp     byte_449DA, 0
    jnz     short loc_170BE
    cmp     state.playerstate.car_crashBmpFlag, 1
    jnz     short loc_170B2
    cmp     state.playerstate.car_speed2, 0
    jz      short loc_170B2
    inc     state.game_frames_per_sec
    jmp     short loc_170BE
loc_170B2:
    cmp     game_replay_mode, 0
    jnz     short loc_170BE
    mov     byte_449DA, 1
loc_170BE:
    cmp     state.game_inputmode, 0
    jz      short loc_170F6
    mov     al, [bp+var_carInputByte]
    cbw
    push    ax
    push    cs
    call near ptr player_op
    add     sp, 2
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_170DC
    push    cs
    call near ptr opponent_op
loc_170DC:
    call    sub_2298C
    cmp     state.field_42A, 0
    jz      short loc_170EC
    push    cs
    call near ptr sub_19BA0
loc_170EC:
    push    cs
    call near ptr audio_carstate
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_170F6:
    cmp     game_replay_mode, 1
    jz      short loc_17100
    jmp     loc_171E1
loc_17100:
    push    cs
    call near ptr audio_carstate
    cmp     byte_4393C, 0
    jnz     short loc_1710E
    jmp     loc_171E1
loc_1710E:
    cmp     word_44DCA, 1C2h
    jge     short loc_1711B
    add     word_44DCA, 8
loc_1711B:
    cmp     byte_4393C, 1
    jnz     short loc_1712E
    cmp     word_44DCA, 180h
    jle     short loc_1712E
    inc     byte_4393C
loc_1712E:
    cmp     byte_4393C, 2
    jz      short loc_17138
    jmp     loc_171E1
loc_17138:
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    mov     cx, word ptr state.playerstate.car_posWorld1.lz
    mov     bx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     dx, cx
    mov     cl, 6
loc_17150:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_17150
    sub     ax, dx
    push    ax
    push    track_angle
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     si, ax
    mov     al, startcol2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    mov     cx, word ptr state.playerstate.car_posWorld1.lx
    mov     bx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     dx, cx
    mov     cl, 6
loc_1718A:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_1718A
    sub     ax, dx
    push    ax
    push    track_angle
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     si, ax
    cmp     si, 0E4h ; 'ä'
    jle     short loc_171D0
    cmp     state.playerstate.car_speed, 500h
    jnb     short loc_171CC
    mov     ax, 1
loc_171BD:
    push    ax
    push    cs
    call near ptr player_op
    add     sp, 2
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_171CC:
    sub     ax, ax
    jmp     short loc_171BD
loc_171D0:
    cmp     state.playerstate.car_speed, 0
    jz      short loc_171DC
    mov     ax, 2
    jmp     short loc_171BD
loc_171DC:
    mov     byte_4393C, 0
loc_171E1:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
update_gamestate endp
player_op proc far
    var_52 = VECTOR ptr -82
    var_3A = byte ptr -58
    var_38 = VECTOR ptr -56
    var_32 = VECTOR ptr -50
    var_2C = byte ptr -44
    var_2A = byte ptr -42
    var_28 = VECTOR ptr -40
    var_matptr = word ptr -32
    var_1EpenaltyCounter = word ptr -30
    var_1C = byte ptr -28
    var_1A = VECTOR ptr -26
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_carInputByte = byte ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 52h
    push    di
    push    si
    cmp     show_penalty_counter, 0
    jz      short loc_171FB
    dec     show_penalty_counter
loc_171FB:
    mov     state.playerstate.field_CF, 1
    cmp     state.playerstate.car_crashBmpFlag, 0
    jz      short loc_17242
    mov     state.field_45D, 0
    mov     [bp+arg_carInputByte], 2
    cmp     state.playerstate.car_speed2, 0
    jnz     short loc_17242
    mov     state.playerstate.field_CF, 0
    cmp     state.playerstate.car_speed, 0
    jnz     short loc_17242
    cmp     state.playerstate.car_rc1, 0
    jnz     short loc_17242
    cmp     state.playerstate.car_rc1+2, 0
    jnz     short loc_17242
    cmp     state.playerstate.car_rc1+4, 0
    jnz     short loc_17242
    cmp     state.playerstate.car_rc1+6, 0
    jnz     short loc_17242
    jmp     loc_17810
loc_17242:
    mov     ax, offset simd_player
    push    ax
    mov     ax, offset state.playerstate
    push    ax
    sub     ax, ax
    push    ax
    mov     al, [bp+arg_carInputByte]
    cbw
    push    ax
    push    cs
    call near ptr update_car_speed
    add     sp, 8
    mov     al, [bp+arg_carInputByte]
    cbw
    sar     ax, 1
    sar     ax, 1
smart
    and     ax, 3           ; masks all keys but the steering ones.
nosmart
    push    ax
    push    cs
    call near ptr upd_statef20_from_steer_input
    add     sp, 2
    mov     ax, 1
    push    ax
    mov     ax, offset simd_player
    push    ax
    mov     ax, offset state.playerstate
    push    ax
    push    cs
    call near ptr update_grip
    add     sp, 6
    sub     ax, ax
    push    ax
    mov     ax, offset simd_opponent; simd2
    push    ax
    mov     ax, offset state.opponentstate; opp CARSTATE
    push    ax
    mov     ax, offset simd_player
    push    ax
    mov     ax, offset state.playerstate; player CARSTATE
    push    ax
    push    cs
    call near ptr update_player_state
    add     sp, 0Ah
    mov     ax, state.playerstate.car_speed2
    sub     dx, dx
    add     word ptr state.game_travDist, ax
    adc     word ptr state.game_travDist+2, dx
    mov     al, state.field_45B
    mov     [bp+var_1C], al
    mov     ax, state.field_2F2
    mov     [bp+var_2], ax
    lea     ax, [bp+var_1EpenaltyCounter]
    push    ax
    lea     ax, [bp+var_2]
    push    ax
    push    cs
    call near ptr detect_penalty
    add     sp, 4
    cbw
    mov     si, ax
    or      si, si
    jnz     short loc_172CB
    jmp     loc_173B3
loc_172CB:
    cmp     [bp+var_1EpenaltyCounter], 0FFFEh
    jnz     short loc_172D8
    mov     state.field_45B, 1
    jmp     short loc_172E4
loc_172D8:
    cmp     state.field_45B, 1
    jnz     short loc_172E9
    mov     state.field_45B, 0
loc_172E4:
    mov     state.field_45C, 0
loc_172E9:
    cmp     state.field_45B, 0
    jz      short loc_172F3
    jmp     loc_173AD
loc_172F3:
    cmp     [bp+var_2], 0
    jnz     short loc_17308
    cmp     state.field_2F4, 0
    jz      short loc_17308
    inc     state.playerstate.field_CD
    jmp     short loc_1737B
    ; align 4
    db 144
    db 144
loc_17308:
    cmp     [bp+var_1EpenaltyCounter], 0
    jl      short loc_17322
    cmp     [bp+var_1EpenaltyCounter], 3
    jge     short loc_17322
    mov     state.field_45C, 0
    mov     ax, [bp+var_2]
    mov     state.field_2F2, ax
    jmp     loc_173AD
loc_17322:
    cmp     [bp+var_1EpenaltyCounter], 0FFFFh
    jz      short loc_1732E
    cmp     [bp+var_1EpenaltyCounter], 3
    jle     short loc_173AD
loc_1732E:
    mov     di, state.field_2F4
    shl     di, 1
    les     bx, td01_track_file_cpy
    mov     ax, [bp+var_2]
    cmp     es:[bx+di], ax
    jz      short loc_17349
    les     bx, td02_penalty_related
    cmp     es:[bx+di], ax
    jnz     short loc_17350
loc_17349:
    inc     state.field_45C
    jmp     short loc_17374
    ; align 2
    db 144
loc_17350:
    mov     di, [bp+var_2]
    shl     di, 1
    les     bx, td01_track_file_cpy
    mov     ax, state.field_2F4
    cmp     es:[bx+di], ax
    jz      short loc_1736A
    les     bx, td02_penalty_related
    cmp     es:[bx+di], ax
    jnz     short loc_1736F
loc_1736A:
    mov     state.field_45B, 2
loc_1736F:
    mov     state.field_45C, 1
loc_17374:
    cmp     state.field_45C, 3
    jl      short loc_173AD
loc_1737B:
    mov     ax, [bp+var_2]
    mov     state.field_2F2, ax
    mov     state.field_45C, 0
    cmp     [bp+var_1EpenaltyCounter], 0
    jle     short loc_173AD
    mov     ax, [bp+var_1EpenaltyCounter]
    imul    framespersec
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    mov     penalty_time, ax
    mov     al, byte ptr framespersec
    shl     al, 1
    shl     al, 1
    mov     show_penalty_counter, al
    mov     ax, penalty_time
    add     state.game_penalty, ax
loc_173AD:
    mov     ax, [bp+var_2]
    mov     state.field_2F4, ax
loc_173B3:
    mov     state.field_45D, 0
    cmp     state.field_45B, 1
    jnz     short loc_173C2
    jmp     loc_17810
loc_173C2:
    mov     ax, 1
    push    ax
    push    state.playerstate.car_rotate.vx
    push    state.playerstate.car_rotate.vy
    push    state.playerstate.car_rotate.vz
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
    cmp     state.field_45B, 2
    jnz     short loc_173F6
    cmp     state.playerstate.car_crashBmpFlag, 0
    jnz     short loc_173F0
    mov     state.field_45D, 3
loc_173F0:
    mov     ax, state.field_2F4
    jmp     loc_174C9
loc_173F6:
    cmp     state.playerstate.car_trackdata3_index, 0FFFFh
    jnz     short loc_17402
loc_173FD:
    sub     si, si
    jmp     loc_174B3
loc_17402:
    cmp     [bp+var_1C], 0
    jz      short loc_1740F
    cmp     state.field_45B, 0
    jz      short loc_17431
loc_1740F:
    mov     ax, state.field_2F2
    cmp     state.playerstate.car_trackdata3_index, ax
    jz      short loc_1743A
    mov     di, ax
    shl     di, 1
    les     bx, td01_track_file_cpy
    mov     ax, state.playerstate.car_trackdata3_index
    cmp     es:[bx+di], ax
    jz      short loc_1743A
    les     bx, td02_penalty_related
    cmp     es:[bx+di], ax
    jz      short loc_1743A
loc_17431:
    mov     state.playerstate.car_trackdata3_index, 0FFFFh
    jmp     short loc_173FD
    ; align 2
    db 144
loc_1743A:
    mov     ax, state.playerstate.car_vec_unk3.vx
    mov     cx, word ptr state.playerstate.car_posWorld1.lx
    mov     bx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     dx, cx
    mov     cl, 6
loc_17449:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_17449
    sub     ax, dx
    mov     [bp+var_32.vx], ax
    cmp     state.playerstate.car_vec_unk3.vy, 0FFFFh
    jz      short loc_1747C
    mov     ax, state.playerstate.car_vec_unk3.vy
    mov     cx, word ptr state.playerstate.car_posWorld1.ly
    mov     bx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     dx, cx
    mov     cl, 6
loc_1746C:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_1746C
    sub     ax, dx
    mov     [bp+var_32.vy], ax
    jmp     short loc_17481
    ; align 2
    db 144
loc_1747C:
    mov     [bp+var_32.vy], 0
loc_17481:
    mov     ax, state.playerstate.car_vec_unk3.vz
    mov     cx, word ptr state.playerstate.car_posWorld1.lz
    mov     bx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     dx, cx
    mov     cl, 6
loc_17490:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_17490
    sub     ax, dx
    mov     [bp+var_32.vz], ax
    lea     ax, [bp+var_38]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_32]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     si, [bp+var_38.vz]
loc_174B3:
    cmp     si, 113h
    jl      short loc_174BC
    jmp     loc_17699
loc_174BC:
    cmp     state.playerstate.car_trackdata3_index, 0FFFFh
    jz      short loc_174C6
    jmp     loc_1764C
loc_174C6:
    mov     ax, state.field_2F2
loc_174C9:
    mov     [bp+var_2], ax
    mov     bx, ax
    shl     bx, 1
    les     di, td02_penalty_related
    cmp     word ptr es:[bx+di], 0FFFFh
    jz      short loc_174DD
    jmp     loc_17771
loc_174DD:
    mov     [bp+var_2A], 0
    mov     [bp+var_2C], 0
loc_174E5:
    sub     ax, ax
    push    ax
    mov     al, [bp+var_2C]
    sub     ah, ah
    push    ax
    mov     ax, offset state.playerstate.car_vec_unk3
    push    ax
    push    [bp+var_2]
    push    cs
    call near ptr sub_18D60
    add     sp, 8
    mov     [bp+var_2A], al
    push    si
    lea     di, [bp+var_28]
    mov     si, offset state.playerstate.car_vec_unk3
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     ax, word ptr state.playerstate.car_posWorld1.lx
    mov     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     cl, 6
loc_17515:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_17515
    sub     [bp+var_28.vx], ax
    cmp     [bp+var_28.vy], 0FFFFh
    jnz     short loc_1753E
    mov     ax, word ptr state.playerstate.car_posWorld1.ly
    mov     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1752F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1752F
loc_17537:
    neg     ax
    mov     [bp+var_28.vy], ax
    jmp     short loc_17552
loc_1753E:
    mov     ax, word ptr state.playerstate.car_posWorld1.ly
    mov     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_17547:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_17547
    sub     [bp+var_28.vy], ax
loc_17552:
    mov     ax, word ptr state.playerstate.car_posWorld1.lz
    mov     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1755B:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1755B
    sub     [bp+var_28.vz], ax
    lea     ax, [bp+var_38]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_28]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_2C], 0
loc_1757D:
    jz      short loc_1758D
    mov     ax, [bp+var_32.vz]
    cmp     [bp+var_38.vz], ax
    jge     short loc_17599
    cmp     [bp+var_38.vz], 0
    jle     short loc_17599
loc_1758D:
    mov     al, [bp+var_2C]
    mov     [bp+var_3A], al
    mov     ax, [bp+var_38.vz]
    mov     [bp+var_32.vz], ax
loc_17599:
    inc     [bp+var_2C]
    cmp     [bp+var_2A], 0
    jnz     short loc_175A5
    jmp     loc_174E5
loc_175A5:
    cmp     state.field_45B, 2
    jz      short loc_175AF
    jmp     loc_17640
loc_175AF:
    cmp     [bp+var_3A], 0
    jnz     short loc_175D0
    sub     ax, ax
    push    ax
loc_175B8:
    push    ax
    lea     ax, [bp+var_52]
    push    ax
    push    [bp+var_2]
    push    cs
    call near ptr sub_18D60
    add     sp, 8
    sub     ax, ax
    push    ax
    mov     ax, 1
    jmp     short loc_175F0
    ; align 2
    db 144
loc_175D0:
    sub     ax, ax
    push    ax
    mov     al, [bp+var_3A]
    dec     al
    cbw
    push    ax
    lea     ax, [bp+var_52]
    push    ax
    push    [bp+var_2]
    push    cs
    call near ptr sub_18D60
    add     sp, 8
    sub     ax, ax
    push    ax
    mov     al, [bp+var_3A]
    sub     ah, ah
loc_175F0:
    push    ax
    lea     ax, [bp+var_1A]
    push    ax
    push    [bp+var_2]
    push    cs
    call near ptr sub_18D60
    add     sp, 8
    mov     ax, [bp+var_1A.vz]
    sub     ax, [bp+var_52.vz]
    push    ax
    mov     ax, [bp+var_52.vx]
    sub     ax, [bp+var_1A.vx]
    push    ax
    call    polarAngle
    add     sp, 4
    mov     si, ax
smart
    and     si, 3FFh
nosmart
    mov     ax, state.playerstate.car_rotate.vx
    sub     ax, si
smart
    and     ah, 3
nosmart
    mov     si, ax
    cmp     si, 380h
    jg      short loc_17631
    cmp     si, 80h ; '€'
    jge     short loc_1764C
loc_17631:
    mov     state.field_45B, 0
    mov     state.field_45C, 1
    mov     ax, [bp+var_2]
    jmp     short loc_17643
loc_17640:
    mov     ax, state.field_2F2
loc_17643:
    mov     state.playerstate.car_trackdata3_index, ax
    mov     al, [bp+var_3A]
    mov     state.playerstate.field_CE, al
loc_1764C:
    sub     ax, ax
    push    ax
    mov     al, state.playerstate.field_CE
    inc     state.playerstate.field_CE
    sub     ah, ah
    push    ax
    mov     ax, offset state.playerstate.car_vec_unk3
    push    ax
    push    state.playerstate.car_trackdata3_index
    push    cs
    call near ptr sub_18D60
    add     sp, 8
    or      al, al
    jz      short loc_17699
    mov     bx, state.field_2F2
    shl     bx, 1
    les     di, td02_penalty_related
    cmp     word ptr es:[bx+di], 0FFFFh
    jz      short loc_17684
    mov     state.playerstate.car_trackdata3_index, 0FFFFh
    jmp     short loc_17694
loc_17684:
    mov     bx, state.field_2F2
    shl     bx, 1
    les     di, td01_track_file_cpy
    mov     ax, es:[bx+di]
    mov     state.playerstate.car_trackdata3_index, ax
loc_17694:
    mov     state.playerstate.field_CE, 0
loc_17699:
    push    si
    lea     di, [bp+var_28]
    mov     si, offset state.playerstate.car_vec_unk3
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    cmp     state.playerstate.car_trackdata3_index, 0FFFFh
    jnz     short loc_176B0
    jmp     loc_17771
loc_176B0:
    cmp     state.field_45B, 0
    jz      short loc_176BA
    jmp     loc_17771
loc_176BA:
    mov     ax, word ptr state.playerstate.car_posWorld1.lx
    mov     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     cl, 6
loc_176C3:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
loc_176C9:
    jnz     short loc_176C3
    sub     [bp+var_28.vx], ax
    cmp     [bp+var_28.vy], 0FFFFh
    jnz     short loc_176DC
    mov     [bp+var_28.vy], 0
    jmp     short loc_176F0
    ; align 2
    db 144
loc_176DC:
    mov     ax, word ptr state.playerstate.car_posWorld1.ly
    mov     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_176E5:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_176E5
    sub     [bp+var_28.vy], ax
loc_176F0:
    mov     ax, word ptr state.playerstate.car_posWorld1.lz
    mov     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     cl, 6
loc_176F9:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_176F9
    sub     [bp+var_28.vz], ax
loc_17704:
    mov     ax, 1
    push    ax
    push    state.playerstate.car_rotate.vx
    push    state.playerstate.car_rotate.vy
    push    state.playerstate.car_rotate.vz
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
    lea     ax, [bp+var_38]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_28]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    [bp+var_38.vz]
    mov     ax, [bp+var_38.vx]
    neg     ax
    push    ax
    call    polarAngle
    add     sp, 4
smart
    and     ah, 3
nosmart
    mov     state.playerstate.field_48, ax
    cmp     state.playerstate.car_crashBmpFlag, 0
    jnz     short loc_17771
    add     ax, 80h ; '€'
smart
    and     ah, 3
nosmart
    mov     cl, 8
    shr     ax, cl
    cmp     ax, 1
    jz      short loc_1776C
    cmp     ax, 3
    jz      short loc_1779E
loc_17764:
    mov     state.field_45D, 0
    jmp     short loc_17771
    ; align 2
    db 144
loc_1776C:
    mov     state.field_45D, 1
loc_17771:
    cmp     state.playerstate.field_CD, 0
    jnz     short loc_1777B
    jmp     loc_17810
loc_1777B:
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    mov     cx, word ptr state.playerstate.car_posWorld1.lz
    mov     bx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     dx, cx
    mov     cl, 6
loc_17793:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jz      short loc_177AC
    jmp     short loc_17793
    ; align 2
    db 144
loc_1779E:
    cmp     state.playerstate.field_B6, 0
    jnz     short loc_17764
    mov     state.field_45D, 2
    jmp     short loc_17771
loc_177AC:
    sub     ax, dx
    push    ax
    push    track_angle
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     si, ax
    mov     al, startcol2
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    mov     cx, word ptr state.playerstate.car_posWorld1.lx
    mov     bx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     dx, cx
    mov     cl, 6
loc_177DE:
    sar     bx, 1
    rcr     dx, 1
    dec     cl
    jnz     short loc_177DE
    sub     ax, dx
    push    ax
    push    track_angle
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     si, ax
    jns     short loc_17810
    sub     ax, ax
    push    ax
    mov     ax, 3
    push    ax
    push    cs
    call near ptr update_crash_state
    add     sp, 4
loc_17810:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
player_op endp
detect_penalty proc far
    var_5A4 = word ptr -1444
    var_5A2 = byte ptr -1442
    var_21A = word ptr -538
    var_218 = byte ptr -536
    var_116 = byte ptr -278
    var_114 = byte ptr -276
    var_110 = word ptr -272
    var_E = byte ptr -14
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = byte ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_extVar2ptr = word ptr 6
    arg_extVar1Eptr = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 5A4h
    push    di
    push    si
    mov     al, byte ptr state.playerstate.car_posWorld1.lx+2
    mov     [bp+var_4], al
    mov     al, 1Dh
    sub     al, byte ptr state.playerstate.car_posWorld1.lz+2
    mov     [bp+var_A], al
    mov     al, [bp+var_4]
    cbw
    mov     [bp+var_5A4], ax
    mov     ax, state.game_startcol
    cmp     [bp+var_5A4], ax
    jz      short loc_17848
    mov     ax, state.game_startcol2
    cmp     [bp+var_5A4], ax
    jnz     short loc_17872
loc_17848:
    mov     al, [bp+var_A]
    cbw
    mov     [bp+var_5A4], ax
    mov     ax, state.game_startrow
    cmp     [bp+var_5A4], ax
    jz      short loc_17862
    mov     ax, state.game_startrow2
    cmp     [bp+var_5A4], ax
    jnz     short loc_17872
loc_17862:
    mov     bx, [bp+arg_extVar1Eptr]
    mov     word ptr [bx], 0
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_17872:
    cmp     [bp+var_4], 0
    jge     short loc_1787B
    jmp     loc_1792E
loc_1787B:
    cmp     [bp+var_4], 1Dh
    jle     short loc_17884
    jmp     loc_1792E
loc_17884:
    cmp     [bp+var_A], 0
    jge     short loc_1788D
    jmp     loc_1792E
loc_1788D:
    cmp     [bp+var_A], 1Dh
    jle     short loc_17896
    jmp     loc_1792E
loc_17896:
    mov     [bp+var_6], 0
    mov     [bp+var_21A], 0
    sub     di, di
    sub     si, si
    jmp     short loc_178AE
    ; align 2
    db 144
loc_178A8:
    mov     [bp+si+var_5A2], 0
    inc     si
loc_178AE:
    cmp     track_pieces_counter, si
    jg      short loc_178A8
    mov     bx, [bp+arg_extVar2ptr]
    mov     si, [bx]
loc_178B9:
    mov     bx, si
    shl     bx, 1
    add     bx, word ptr td01_track_file_cpy
    mov     es, word ptr td01_track_file_cpy+2
    mov     ax, es:[bx]
    mov     [bp+var_2], ax
    mov     bx, ax
    add     bx, bp
    cmp     byte ptr [bx-5A2h], 0
    jz      short loc_17938
    cmp     [bp+var_21A], 0
    jz      short loc_178FA
    dec     [bp+var_21A]
    mov     ax, [bp+var_21A]
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_5A4], ax
    mov     bx, ax
    mov     si, [bx-216h]
    mov     di, [bx-10Eh]
    jmp     short loc_178B9
    ; align 2
    db 144
loc_178FA:
    cmp     [bp+var_6], 0
    jz      short loc_1791A
    mov     bx, [bp+arg_extVar2ptr]
    mov     ax, [bp+var_110]
    mov     [bx], ax
    mov     bx, [bp+arg_extVar1Eptr]
    mov     ax, [bp+var_6]
    mov     [bx], ax
loc_17911:
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_1791A:
    mov     al, [bp+var_4]
    cbw
    mov     state.game_startcol, ax
    mov     state.game_startcol2, ax
    mov     al, [bp+var_A]
    cbw
    mov     state.game_startrow, ax
    mov     state.game_startrow2, ax
loc_1792E:
    mov     bx, [bp+arg_extVar1Eptr]
    mov     word ptr [bx], 0FFFEh
    jmp     short loc_17911
    ; align 2
    db 144
loc_17938:
    mov     bx, [bp+var_2]
    add     bx, bp
    mov     byte ptr [bx-5A2h], 1
    mov     bx, [bp+var_2]
    add     bx, word ptr td22_row_from_path
    mov     es, word ptr td22_row_from_path+2
    mov     al, es:[bx]
    mov     [bp+var_E], al
    mov     bx, [bp+var_2]
    add     bx, word ptr td17_trk_elem_ordered
    mov     es, word ptr td17_trk_elem_ordered+2
    mov     al, es:[bx]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     al, trkObjectList.ss_multiTileFlag[bx]
    mov     [bp+var_116], al
    test    [bp+var_116], 1
    jz      short loc_17986
    mov     al, [bp+var_E]
    inc     al
    jmp     short loc_17989
    ; align 2
    db 144
loc_17986:
    mov     al, [bp+var_E]
loc_17989:
    mov     [bp+var_218], al
    mov     bx, [bp+var_2]
    add     bx, word ptr td21_col_from_path
    mov     es, word ptr td21_col_from_path+2
    mov     al, es:[bx]
    mov     [bp+var_C], al
    test    [bp+var_116], 2
    jz      short loc_179AA
    inc     al
    jmp     short loc_179AD
    ; align 2
    db 144
loc_179AA:
    mov     al, [bp+var_C]
loc_179AD:
    mov     [bp+var_114], al
    mov     al, [bp+var_4]
    cmp     [bp+var_C], al
    jz      short loc_179BF
    cmp     [bp+var_114], al
    jnz     short loc_17A19
loc_179BF:
    mov     al, [bp+var_A]
    cmp     [bp+var_E], al
    jz      short loc_179CD
    cmp     [bp+var_218], al
    jnz     short loc_17A19
loc_179CD:
    mov     bx, si
    shl     bx, 1
    add     bx, word ptr td02_penalty_related
    mov     es, word ptr td02_penalty_related+2
    cmp     word ptr es:[bx], 0FFFFh
    jz      short loc_179E2
    mov     [bp+var_2], si
loc_179E2:
    mov     al, [bp+var_C]
    cbw
loc_179E6:
    mov     state.game_startcol, ax
    mov     al, [bp+var_114]
    cbw
    mov     state.game_startcol2, ax
    mov     al, [bp+var_E]
    cbw
    mov     state.game_startrow, ax
    mov     al, [bp+var_218]
    cbw
    mov     state.game_startrow2, ax
    or      di, di
    jle     short loc_17A5E
    cmp     [bp+var_6], 0
    jz      short loc_17A0F
    cmp     [bp+var_6], di
    jle     short loc_17A19
loc_17A0F:
    mov     ax, [bp+var_2]
    mov     [bp+var_110], ax
    mov     [bp+var_6], di
loc_17A19:
    mov     bx, si
    shl     bx, 1
    add     bx, word ptr td02_penalty_related
    mov     es, word ptr td02_penalty_related+2
    mov     ax, es:[bx]
    mov     [bp+var_8], ax
    cmp     ax, 0FFFFh
    jz      short loc_17A4F
    mov     bx, [bp+var_21A]
    shl     bx, 1
    add     bx, bp
    mov     [bx-10Eh], di
    mov     bx, [bp+var_21A]
    inc     [bp+var_21A]
    shl     bx, 1
    add     bx, bp
    mov     ax, [bp+var_8]
    mov     [bx-216h], ax
loc_17A4F:
    cmp     [bp+var_2], 0
    jz      short loc_17A6E
    cmp     di, 0FFFFh
    jz      short loc_17A71
    inc     di
    jmp     short loc_17A71
    ; align 2
    db 144
loc_17A5E:
    mov     bx, [bp+arg_extVar2ptr]
    mov     ax, [bp+var_2]
    mov     [bx], ax
    mov     bx, [bp+arg_extVar1Eptr]
    mov     [bx], di
    jmp     loc_17911
loc_17A6E:
    mov     di, 0FFFFh
loc_17A71:
    mov     si, [bp+var_2]
    jmp     loc_178B9
    ; align 2
    db 144
detect_penalty endp
update_car_speed proc far
    var_currTorque = byte ptr -10
    var_deltaSpeed = word ptr -8
    var_updatedSpeed = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_carInputByte = byte ptr 6
    arg_MplayerFlag = byte ptr 8
    arg_carState = word ptr 10
    arg_simd = word ptr 12

    push    bp              ; former update_car_state
    mov     bp, sp
    sub     sp, 0Ah
    push    di
    push    si
    cmp     framespersec, 14h
    jnz     short loc_17A8E
    mov     [bp+var_2], 6
    jmp     short loc_17A93
loc_17A8E:
    mov     [bp+var_2], 0Ch
loc_17A93:
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_engineLimiterTimer], 0
    jz      short loc_17AA1
    dec     [bx+CARSTATE.car_engineLimiterTimer]
loc_17AA1:
    mov     bx, [bp+arg_carState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_speed2]
    sub     ax, [si+CARSTATE.car_lastspeed]
    mov     [bx+CARSTATE.car_speeddiff], ax
    mov     bx, [bp+arg_carState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_speed2]
    mov     [bx+CARSTATE.car_lastspeed], ax
    mov     bx, [bp+arg_carState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_currpm]
    mov     [bx+CARSTATE.car_lastrpm], ax
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_transmission], 0
    jnz     short loc_17AE6
    cmp     [bx+CARSTATE.car_changing_gear], 0
    jnz     short loc_17AE6
    test    [bp+arg_carInputByte], 10h
    jnz     short loc_17B0F
    test    [bp+arg_carInputByte], 20h
    jnz     short loc_17B2E
    jmp     loc_17B86
    ; align 2
    db 144
loc_17AE6:
    cmp     [bx+CARSTATE.car_current_gear], 0
    jnz     short loc_17AF0
    jmp     loc_17B86
loc_17AF0:
    cmp     [bx+CARSTATE.car_changing_gear], 0
    jz      short loc_17AFA
    jmp     loc_17B86
loc_17AFA:
    cmp     [bx+CARSTATE.car_sumSurfRearWheels], 0
    jnz     short loc_17B04
    jmp     loc_17B86
loc_17B04:
    mov     si, [bp+arg_simd]
    mov     ax, [si+SIMD.upshift_rpm]
    cmp     [bx+CARSTATE.car_currpm], ax
    jbe     short loc_17B20
loc_17B0F:
    mov     si, [bp+arg_simd]
    mov     al, [si+SIMD.num_gears]
    cmp     [bx+CARSTATE.car_current_gear], al
    jz      short loc_17B86
    inc     [bx+CARSTATE.car_current_gear]
    jmp     short loc_17B39
loc_17B20:
    mov     bx, [bp+arg_carState]
    mov     si, [bp+arg_simd]
    mov     ax, [si+SIMD.downshift_rpm]
    cmp     [bx+CARSTATE.car_currpm], ax
    jnb     short loc_17B86
loc_17B2E:
    cmp     [bx+CARSTATE.car_current_gear], 1
    jle     short loc_17B86
    dec     [bx+CARSTATE.car_current_gear]
loc_17B39:
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_changing_gear], 1
    mov     al, byte ptr framespersec
    cbw
    sar     ax, 1
    add     al, byte ptr framespersec
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_fpsmul2], al
    mov     bx, [bp+arg_carState]
    mov     al, [bx+CARSTATE.car_current_gear]
    cbw
    mov     si, ax
    shl     si, 1
    shl     si, 1
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+si+SIMD.knob_points.x2]
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_knob_x2], ax
    mov     bx, [bp+arg_carState]
    mov     al, [bx+CARSTATE.car_current_gear]
    cbw
    mov     si, ax
    shl     si, 1
    shl     si, 1
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+si+SIMD.knob_points.y2]
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_knob_y2], ax
loc_17B86:
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_changing_gear], 0
    jnz     short loc_17B93
    jmp     loc_17C9E
loc_17B93:
    mov     si, bx
    mov     ax, [si+CARSTATE.car_knob_x2]
    cmp     [bx+CARSTATE.car_knob_x], ax
    jnz     short loc_17C0C
    mov     ax, [bx+CARSTATE.car_knob_y2]
    sub     ax, [bx+CARSTATE.car_knob_y]
    mov     [bp+var_4], ax
    or      ax, ax
    jnz     short loc_17BDA
    mov     [bx+CARSTATE.car_changing_gear], 0
    mov     bx, [bp+arg_carState]
    mov     al, [bx+CARSTATE.car_current_gear]
    cbw
    mov     si, ax
    shl     si, 1
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+si+SIMD.gear_ratios]
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_gearratio], ax
    mov     bx, [bp+arg_carState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_gearratio]
    mov     cl, 8
    shr     ax, cl
    mov     [bx+CARSTATE.car_gearratioshr8], ax
    jmp     loc_17CAC
    ; align 2
    db 144
loc_17BDA:
    push    [bp+var_4]      ; int
    call    _abs
    add     sp, 2
    cmp     ax, [bp+var_2]
    jg      short loc_17BF6
    mov     bx, [bp+arg_carState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_knob_y2]
    jmp     loc_17C84
    ; align 2
    db 144
loc_17BF6:
    cmp     [bp+var_4], 0
    jle     short loc_17BFF
    jmp     loc_17C93
loc_17BFF:
    mov     bx, [bp+arg_carState]
    mov     ax, [bp+var_2]
    sub     [bx+CARSTATE.car_knob_y], ax
    jmp     loc_17CAC
    ; align 2
    db 144
loc_17C0C:
    mov     bx, [bp+arg_simd]
    mov     si, [bp+arg_carState]
    mov     ax, [si+CARSTATE.car_knob_y]
    cmp     [bx+SIMD.knob_points.y2], ax
    jnz     short loc_17C5E
    mov     bx, si
    mov     ax, [bx+CARSTATE.car_knob_x2]
    sub     ax, [bx+CARSTATE.car_knob_x]
    mov     [bp+var_4], ax
    push    ax              ; int
    call    _abs
    add     sp, 2
    cmp     ax, [bp+var_2]
    jg      short loc_17C40
    mov     bx, [bp+arg_carState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_knob_x2]
    mov     [bx+CARSTATE.car_knob_x], ax
    jmp     short loc_17CAC
loc_17C40:
    cmp     [bp+var_4], 0
    jle     short loc_17C52
    mov     bx, [bp+arg_carState]
    mov     ax, [bp+var_2]
    add     [bx+CARSTATE.car_knob_x], ax
    jmp     short loc_17CAC
    ; align 2
    db 144
loc_17C52:
    mov     bx, [bp+arg_carState]
    mov     ax, [bp+var_2]
    sub     [bx+CARSTATE.car_knob_x], ax
    jmp     short loc_17CAC
    ; align 2
    db 144
loc_17C5E:
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+SIMD.knob_points.y2]
    mov     bx, [bp+arg_carState]
    sub     ax, [bx+CARSTATE.car_knob_y]
    mov     [bp+var_4], ax
    push    ax              ; int
    call    _abs
    add     sp, 2
    cmp     ax, [bp+var_2]
    jg      short loc_17C8A
    mov     bx, [bp+arg_carState]
    mov     si, [bp+arg_simd]
    mov     ax, [si+SIMD.knob_points.y2]
loc_17C84:
    mov     [bx+CARSTATE.car_knob_y], ax
    jmp     short loc_17CAC
    ; align 2
    db 144
loc_17C8A:
    cmp     [bp+var_4], 0
    jg      short loc_17C93
    jmp     loc_17BFF
loc_17C93:
    mov     bx, [bp+arg_carState]
    mov     ax, [bp+var_2]
    add     [bx+CARSTATE.car_knob_y], ax
    jmp     short loc_17CAC
loc_17C9E:
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_fpsmul2], 0
    jz      short loc_17CAC
    dec     [bx+CARSTATE.car_fpsmul2]
loc_17CAC:
    mov     bx, [bp+arg_carState]
    mov     ax, [bx+CARSTATE.car_speed]
    mov     [bp+var_updatedSpeed], ax
    mov     si, ax
    mov     cl, 0Ah
    shr     si, cl
    shl     si, 1           ; this is NOT part of the calculations *LOL*
    mov     bx, [bp+arg_simd]
    les     bx, [bx+SIMD.aerorestable]
    mov     di, [bp+arg_carState]
    mov     ax, [di+CARSTATE.car_pseudoGravity]
    sub     ax, es:[bx+si]
    mov     [bp+var_deltaSpeed], ax
    mov     bx, di
    mov     si, [bp+arg_simd]
    mov     ax, [si+SIMD.max_rpm]
    cmp     [bx+CARSTATE.car_currpm], ax
    jbe     short loc_17CEA
    dec     ax
    mov     [bx+CARSTATE.car_currpm], ax
loc_17CE1:
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+SIMD.braking_eff]
    jmp     short loc_17D36
    ; align 2
    db 144
loc_17CEA:
    mov     al, [bp+arg_carInputByte]
smart
    and     ax, 3
nosmart
    cmp     ax, 1
    jnz     short loc_17CF8
    jmp     loc_17D82
loc_17CF8:
    cmp     ax, 2
    jz      short loc_17D10
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_is_accelerating], 0
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_is_braking], 0
    jmp     short loc_17D39
    ; align 2
    db 144
loc_17D10:
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_is_accelerating], 0
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_engineLimiterTimer], 0
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_is_braking], 1
    cmp     [bp+arg_MplayerFlag], 0
    jz      short loc_17CE1
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+SIMD.braking_eff]
    shl     ax, 1
loc_17D36:
    sub     [bp+var_deltaSpeed], ax
loc_17D39:
    cmp     framespersec, 0Ah
    jnz     short loc_17D46
    mov     ax, [bp+var_deltaSpeed]
    add     [bp+var_deltaSpeed], ax
loc_17D46:
    cmp     [bp+var_deltaSpeed], 0
    jge     short loc_17D4F
    jmp     loc_17EE2
loc_17D4F:
    cmp     [bp+var_updatedSpeed], 8000h
    jb      short loc_17D59
    jmp     loc_17EC2
loc_17D59:
    mov     ax, [bp+var_deltaSpeed]
    add     [bp+var_updatedSpeed], ax
loc_17D5F:
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_sumSurfRearWheels], 0
    jnz     short loc_17D6C
    jmp     loc_17F3C
loc_17D6C:
    mov     ax, [bx+CARSTATE.car_speed2]
    sub     ax, [bp+var_updatedSpeed]
    mov     [bp+var_4], ax
    or      ax, ax
    jl      short loc_17D7C
    jmp     loc_17EF8
loc_17D7C:
    neg     ax
    jmp     loc_17EFB
    ; align 2
    db 144
loc_17D82:
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_is_braking], 0
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_is_accelerating], 1
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_changing_gear], 0
    jz      short loc_17DBC
    mov     [bx+CARSTATE.car_engineLimiterTimer], 0
    cmp     framespersec, 0Ah
    jnz     short loc_17DB2
    mov     bx, [bp+arg_carState]
    sub     [bx+CARSTATE.car_currpm], 50h ; 'P'
    jmp     short loc_17D39
    ; align 2
    db 144
loc_17DB2:
    mov     bx, [bp+arg_carState]
    sub     [bx+CARSTATE.car_currpm], 28h ; '('
    jmp     loc_17D39
loc_17DBC:
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_sumSurfRearWheels], 0
    jnz     short loc_17DE6
    mov     si, [bp+arg_simd]
    mov     ax, [si+SIMD.max_rpm]
    cmp     [bx+CARSTATE.car_currpm], ax
    jb      short loc_17DD4
    jmp     loc_17D39
loc_17DD4:
    cmp     [bp+var_updatedSpeed], 0FA00h
    jb      short loc_17DDE
    jmp     loc_17D39
loc_17DDE:
    add     byte ptr [bp+var_deltaSpeed+1], 3
    jmp     loc_17D39
    ; align 2
    db 144
loc_17DE6:
    cmp     [bx+CARSTATE.car_current_gear], 1
    jg      short loc_17DFC
    cmp     [bx+CARSTATE.car_currpm], 0A28h
    jge     short loc_17DFC
    mov     bx, [bp+arg_simd]
    mov     al, [bx+SIMD.idle_torque]
    jmp     short loc_17E0C
loc_17DFC:
    mov     bx, [bp+arg_carState]
    mov     si, [bx+CARSTATE.car_currpm]
    mov     cl, 7
    shr     si, cl          ; divide rpm by 2^7 to find offset.
    mov     bx, [bp+arg_simd]
    mov     al, [bx+si+SIMD.torque_curve]
loc_17E0C:
    mov     [bp+var_currTorque], al
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_engineLimiterTimer], 0
    jz      short loc_17E34
    cmp     [bx+CARSTATE.car_currpm], 1388h
    jge     short loc_17E34
    mov     bx, [bp+arg_simd]
    mov     al, [bx+SIMD.idle_torque]
    sub     ah, ah
    mov     cl, [bp+var_currTorque]
    sub     ch, ch
    add     ax, cx
    shr     ax, 1
    mov     [bp+var_currTorque], al
loc_17E34:
    mov     al, [bp+var_currTorque]
    sub     ah, ah
    mov     cx, ax
    mov     bx, [bp+arg_carState]
    mov     ax, [bx+CARSTATE.car_gearratioshr8]
    mul     cx
    mov     cl, 4
    shr     ax, cl          ; torque * ratio / 4096
    add     [bp+var_deltaSpeed], ax
    mov     bx, [bp+arg_simd]
    sub     ax, ax
    push    ax
    push    [bx+SIMD.car_mass]; push cwd(MASS)
    mov     ax, 19h
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_deltaSpeed]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFuldiv
    sar     ax, 1
    mov     [bp+var_deltaSpeed], ax
    cmp     [bp+arg_MplayerFlag], 0
    jz      short loc_17EAD
    mov     al, oppnentSped
    sub     ah, ah
    sub     ax, 0C8h ; 'È'
    neg     ax
    shr     ax, 1
    mov     [bp+var_currTorque], al
    or      al, al
    jz      short loc_17EAD
    mov     ax, 0C8h ; 'È'
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_deltaSpeed]
    cwd
    push    dx
    push    ax
    mov     al, [bp+var_currTorque]
    sub     ah, ah
    sub     cx, cx
    push    cx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    sub     [bp+var_deltaSpeed], ax
loc_17EAD:
    cmp     [bp+var_deltaSpeed], 128h; (37/32)mph, a quite large value
    jg      short loc_17EB7
    jmp     loc_17D39
loc_17EB7:
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_engineLimiterTimer], 5
    jmp     loc_17D39
loc_17EC2:
    mov     ax, [bp+var_deltaSpeed]
    add     [bp+var_updatedSpeed], ax
    cmp     [bp+var_updatedSpeed], 8000h
    jb      short loc_17ED9
    cmp     [bp+var_updatedSpeed], 0F500h
    ja      short loc_17ED9
    jmp     loc_17D5F
loc_17ED9:
    mov     [bp+var_updatedSpeed], 0F500h
    jmp     loc_17D5F
    ; align 2
    db 144
loc_17EE2:
    mov     ax, [bp+var_deltaSpeed]
    neg     ax
    cmp     ax, [bp+var_updatedSpeed]
    ja      short loc_17EEF
    jmp     loc_17D59
loc_17EEF:
    mov     [bp+var_updatedSpeed], 0
    jmp     loc_17D5F
    ; align 2
    db 144
loc_17EF8:
    mov     ax, [bp+var_4]
loc_17EFB:
    cmp     ax, 1400h       ; abs.delta = 20mph: a lot
    jle     short loc_17F28
    mov     si, bx
    mov     ax, [si+CARSTATE.car_speed]
    sub     dx, dx
    add     ax, [si+CARSTATE.car_speed2]
    adc     dx, dx
    shr     dx, 1
    rcr     ax, 1           ; an average
    mov     [bx+CARSTATE.car_speed], ax
    mov     bx, [bp+arg_carState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_speed]
    mov     [bx+CARSTATE.car_speed2], ax
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_engineLimiterTimer], 5
    jmp     short loc_17F45
loc_17F28:
    mov     bx, [bp+arg_carState]
    mov     ax, [bp+var_updatedSpeed]
    mov     [bx+CARSTATE.car_speed], ax
    mov     bx, [bp+arg_carState]
    mov     ax, [bp+var_updatedSpeed]
    mov     [bx+CARSTATE.car_speed2], ax
    jmp     short loc_17F45
loc_17F3C:
    mov     bx, [bp+arg_carState]
    mov     ax, [bp+var_updatedSpeed]
    mov     [bx+CARSTATE.car_speed], ax
loc_17F45:
    mov     bx, [bp+arg_simd]
    push    [bx+SIMD.idle_rpm]
    mov     bx, [bp+arg_carState]
    mov     al, [bx+CARSTATE.car_changing_gear]
    cbw
    push    ax
    push    [bx+CARSTATE.car_gearratio]
    push    [bx+CARSTATE.car_speed]
    push    [bx+CARSTATE.car_currpm]
    call    update_rpm_from_speed
    add     sp, 0Ah
    mov     bx, [bp+arg_carState]
    mov     [bx+CARSTATE.car_currpm], ax
    mov     bx, [bp+arg_carState]
    cmp     [bx+CARSTATE.car_sumSurfAllWheels], 0
    jz      short loc_17FBF
    mov     si, bx
    mov     ax, [si+CARSTATE.car_currpm]
    cmp     [bx+CARSTATE.car_lastrpm], ax
    jle     short loc_17FBF
    mov     ax, [bx+CARSTATE.car_lastrpm]
    sub     ax, [bx+CARSTATE.car_currpm]
    cmp     ax, 7D0h        ; 2000rpm
    jle     short loc_17FA4
    mov     bx, [bp+arg_simd]
    mov     al, [bx+SIMD.idle_torque]
    sub     ah, ah
    mov     bx, si
    mul     [bx+CARSTATE.car_gearratioshr8]
    cmp     ax, 2EE0h
    jle     short loc_17FBF
    mov     [bx+CARSTATE.car_engineLimiterTimer], 1Eh
    jmp     short loc_17FBF
    ; align 2
    db 144
loc_17FA4:
    mov     bx, [bp+arg_carState]
    mov     ax, [bx+CARSTATE.car_currpm]
    sub     ax, [bx+CARSTATE.car_lastrpm]
    cmp     ax, 7D0h        ; 2000rpm
    jle     short loc_17FBF
    mov     [bx+CARSTATE.car_engineLimiterTimer], 0Ah
    mov     bx, [bp+arg_carState]
    sub     [bx+CARSTATE.car_speed2], 500h; 5mph
loc_17FBF:
    mov     bx, [bp+arg_carState]
    mov     ax, state.game_topSpeed
    cmp     [bx+CARSTATE.car_speed2], ax
    jbe     short loc_17FD0
    mov     ax, [bx+CARSTATE.car_speed2]
    mov     state.game_topSpeed, ax
loc_17FD0:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
update_car_speed endp
update_grip proc far
    var_addf20f36Initial = word ptr -16
    var_E = byte ptr -14
    var_C = word ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_combinedGrip = word ptr -6
    var_4 = word ptr -4
    var_speedshr8 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_cState = word ptr 6
    arg_simd = word ptr 8
    arg_isOpponent = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    di
    push    si
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_sumSurfAllWheels], 0
    jnz     short loc_17FFC
    mov     [bx+CARSTATE.car_40MfrontWhlAngle], 0
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_slidingFlag], 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_17FFC:
    mov     [bp+var_8], 0
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_surfaceWhl], 4
    jnz     short loc_1800E
    inc     [bp+var_8]
loc_1800E:
    cmp     [bx+(CARSTATE.car_surfaceWhl+1)], 4
    jnz     short loc_18018
    inc     [bp+var_8]
loc_18018:
    cmp     [bx+(CARSTATE.car_surfaceWhl+2)], 4
    jnz     short loc_18022
    inc     [bp+var_8]
loc_18022:
    cmp     [bx+(CARSTATE.car_surfaceWhl+3)], 4
    jnz     short loc_1802C
    inc     [bp+var_8]
loc_1802C:
    cmp     [bp+var_8], 0
    jz      short loc_18051
    mov     ax, [bx+CARSTATE.car_speed2]
    sub     dx, dx
    mov     bx, [bp+var_8]
    shl     bx, 1
    div     grassDecelDivTab[bx]
    mov     bx, [bp+arg_cState]
    sub     [bx+CARSTATE.car_speed2], ax
    mov     bx, [bp+arg_cState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_speed2]
    mov     [bx+CARSTATE.car_speed], ax
loc_18051:
    mov     bx, [bp+arg_cState]
    mov     ax, [bx+CARSTATE.car_steeringAngle]
    add     ax, [bx+CARSTATE.car_36MwhlAngle]
    mov     [bp+var_addf20f36Initial], ax
    mov     [bp+var_C], ax
loc_18060:
    mov     ax, [bx+CARSTATE.car_speed]
    mov     cl, 8
    shr     ax, cl
    mov     [bp+var_speedshr8], ax
    cmp     [bp+var_C], 0
    jge     short loc_18078
    mov     ax, [bp+var_C]
    neg     ax
    jmp     short loc_1807B
    ; align 2
    db 144
loc_18078:
    mov     ax, [bp+var_C]
loc_1807B:
    mov     cl, 3
    sar     ax, cl
    mov     [bp+var_8], ax
    mov     ax, [bp+var_speedshr8]
    mul     ax
    mov     cl, 6
    shr     ax, cl
    mul     [bp+var_8]
    mov     [bp+var_4], ax
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+SIMD.grip]
    shl     ax, 1
    mov     [bp+var_combinedGrip], ax
    cwd
    push    dx
    push    ax
    mov     bx, [bp+arg_cState]
    mov     al, [bx+(CARSTATE.car_surfaceWhl+3)]
    cbw
    mov     si, ax
    shl     si, 1
    mov     bx, [bp+arg_simd]
    mov     di, [bp+arg_cState]
    mov     al, [di+(CARSTATE.car_surfaceWhl+2)]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, [bx+si+SIMD.sliding]
    mov     bx, [bp+arg_cState]
    mov     cx, ax
    mov     al, [bx+(CARSTATE.car_surfaceWhl+1)]
    cbw
    mov     si, ax
    shl     si, 1
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+si+SIMD.sliding]
    mov     bx, [bp+arg_cState]
    mov     dx, ax
    mov     al, [bx+CARSTATE.car_surfaceWhl]
    cbw
    mov     si, ax
    shl     si, 1
    mov     bx, [bp+arg_simd]
    mov     ax, [bx+si+SIMD.sliding]
    add     ax, dx
    add     ax, [bx+di+SIMD.sliding]
    add     ax, cx
    cwd
    push    dx
    push    ax
    call    __aFlmul
    mov     cl, 0Ah
loc_180FB:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_180FB
    mov     [bp+var_combinedGrip], ax
    mov     bx, [bp+arg_cState]
    mov     ax, [bp+var_4]
    mov     [bx+CARSTATE.car_demandedGrip], ax
    mov     bx, [bp+arg_cState]
    mov     ax, [bp+var_combinedGrip]
    mov     [bx+CARSTATE.car_surfacegrip_sum], ax
    cmp     [bp+arg_isOpponent], 0
    jnz     short loc_18121
    jmp     loc_1835E
loc_18121:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_steeringAngle], 0
    jnz     short loc_18168
    mov     al, byte ptr [bx+CARSTATE.car_rotate.vx]
    sub     ah, ah
    mov     [bp+var_8], ax
    cmp     ax, 7Fh ; ''
    jle     short loc_1813C
    sub     [bp+var_8], 100h
loc_1813C:
    cmp     [bp+var_8], 0
    jz      short loc_18168
    jge     short loc_1814C
    mov     ax, [bp+var_8]
    neg     ax
    jmp     short loc_1814F
    ; align 2
    db 144
loc_1814C:
    mov     ax, [bp+var_8]
loc_1814F:
    cmp     ax, 8
    jge     short loc_18168
    cmp     [bp+var_8], 0
    jle     short loc_18162
    mov     bx, [bp+arg_cState]
    dec     [bx+CARSTATE.car_rotate.vx]
    jmp     short loc_18168
loc_18162:
    mov     bx, [bp+arg_cState]
    inc     [bx+CARSTATE.car_rotate.vx]
loc_18168:
    mov     ax, [bp+var_combinedGrip]
    cmp     [bp+var_4], ax
    jle     short loc_181CE
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_slidingFlag], 1
    mov     ax, [bp+var_speedshr8]
    cwd
    push    dx
    push    ax
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    mov     ax, [bp+var_combinedGrip]
    cwd
    mov     dh, dl
    mov     dl, ah
    mov     ah, al
    sub     al, al          ; *2^8
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+var_C], ax
    cmp     [bp+var_addf20f36Initial], 0
    jge     short loc_181AD
    mov     ax, 0FFFFh
    imul    [bp+var_C]
    mov     [bp+var_C], ax
loc_181AD:
    mov     ax, [bp+var_C]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    add     ax, [bp+var_addf20f36Initial]
    sar     ax, 1
    sar     ax, 1
    mov     [bp+var_C], ax
    mov     bx, [bp+arg_cState]
    mov     ax, [bp+var_addf20f36Initial]
    sub     ax, [bp+var_C]
    mov     [bx+CARSTATE.field_42], ax
    jmp     short loc_18207
loc_181CE:
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_slidingFlag], 0
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.field_42], 0
    jz      short loc_18207
    mov     si, bx
    mov     ax, [si+CARSTATE.field_42]
    mov     cl, 4
    sar     ax, cl
    sub     [bx+CARSTATE.field_42], ax
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.field_42], 0
    jge     short loc_181FC
    mov     ax, [bx+CARSTATE.field_42]
    neg     ax
    jmp     short loc_181FF
    ; align 2
    db 144
loc_181FC:
    mov     ax, [bx+CARSTATE.field_42]
loc_181FF:
    cmp     ax, 10h
    jge     short loc_18207
    sar     [bx+CARSTATE.field_42], 1
loc_18207:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_angle_z], 0
    jnz     short loc_18220
    cmp     [bx+CARSTATE.car_crashBmpFlag], 1
    jz      short loc_18220
    mov     ax, [bp+var_C]
    mov     [bx+CARSTATE.car_40MfrontWhlAngle], ax
    jmp     short loc_18228
    ; align 2
    db 144
loc_18220:
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_40MfrontWhlAngle], 0
loc_18228:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_rotate.vz], 0
    jnz     short loc_18234
    jmp     loc_182BD
loc_18234:
    jge     short loc_1823E
    mov     ax, [bx+CARSTATE.car_rotate.vz]
    neg     ax
    jmp     short loc_18241
    ; align 2
    db 144
loc_1823E:
    mov     ax, [bx+CARSTATE.car_rotate.vz]
loc_18241:
    cmp     ax, 4
    jle     short loc_182BD
    mov     al, byte ptr [bx+(CARSTATE.car_posWorld1.lx+2)]
    mov     [bp+var_A], al
    mov     al, byte ptr [bx+(CARSTATE.car_posWorld1.lz+2)]
    mov     [bp+var_E], al
    mov     bl, al          ; hi-word > word : div by 2^8
    sub     bh, bh
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_A]
    sub     ah, ah
    add     bx, ax
    les     si, td14_elem_map_main
    mov     al, es:[bx+si]
    cmp     ax, 0FDh ; 'ý'
    jz      short loc_1827C
    cmp     ax, 0FEh ; 'þ'
    jz      short loc_1827F
    cmp     ax, 0FFh
    jz      short loc_182A8
    jmp     short loc_18282
    ; align 2
    db 144
loc_1827C:
    dec     [bp+var_A]
loc_1827F:
    inc     [bp+var_E]
loc_18282:
    mov     bl, [bp+var_E]
    sub     bh, bh
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_A]
    sub     ah, ah
    add     bx, ax
    les     si, td14_elem_map_main
    mov     al, es:[bx+si]
    cmp     ax, 34h ; '4'
    jb      short loc_182BD
    cmp     ax, 37h ; '7'
    jbe     short loc_182AE
    jmp     short loc_182BD
    ; align 2
    db 144
loc_182A8:
    dec     [bp+var_A]
    jmp     short loc_18282
    ; align 2
    db 144
loc_182AE:
    mov     bx, [bp+arg_cState]
    mov     ax, [bx+CARSTATE.car_rotate.vz]
    cwd
    mov     cx, 5
    idiv    cx
    add     [bx+CARSTATE.car_40MfrontWhlAngle], ax
loc_182BD:
    mov     ax, [bp+var_combinedGrip]
    add     ax, 3E8h
    cmp     ax, [bp+var_4]
    jge     short loc_182EA
    mov     ax, [bp+var_C]
    sub     ax, [bp+var_addf20f36Initial]
    cwd
    mov     cx, 0Eh
    idiv    cx
    mov     bx, [bp+arg_cState]
    add     [bx+CARSTATE.car_angle_z], ax
    mov     bx, [bp+arg_cState]
    mov     cx, 2
    mov     ax, [bx+CARSTATE.car_angle_z]
    cwd
    idiv    cx
    jmp     loc_1838B
    ; align 2
    db 144
loc_182EA:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_angle_z], 0
    jnz     short loc_182F6
    jmp     loc_1838E
loc_182F6:
    mov     ax, [bp+var_C]
    sub     ax, [bp+var_addf20f36Initial]
    cwd
    mov     cx, 0Eh
    idiv    cx
    add     [bx+CARSTATE.car_angle_z], ax
    mov     bx, [bp+arg_cState]
    mov     cx, 2
    mov     ax, [bx+CARSTATE.car_angle_z]
    cwd
    idiv    cx
    mov     [bx+CARSTATE.car_angle_z], ax
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_angle_z], 0
    jnz     short loc_1838E
    push    [bx+CARSTATE.car_speed2]
    push    [bx+CARSTATE.car_36MwhlAngle]
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_speed2], ax
    mov     bx, [bp+arg_cState]
    push    [bx+CARSTATE.car_36MwhlAngle]
    call    cos_fast
    add     sp, 2
    or      ax, ax
    jge     short loc_18354
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_speed2], 0
loc_18354:
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_36MwhlAngle], 0
    jmp     short loc_1838E
loc_1835E:
    mov     bx, [bp+arg_cState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_steeringAngle]
    shl     ax, 1
    shl     ax, 1
    mov     [bx+CARSTATE.car_40MfrontWhlAngle], ax
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_angle_z], 0
    jz      short loc_1838E
    mov     si, bx
    mov     ax, [si+CARSTATE.car_angle_z]
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    sub     ax, cx
    mov     cl, 4
    sar     ax, cl
loc_1838B:
    mov     [bx+CARSTATE.car_angle_z], ax
loc_1838E:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_36MwhlAngle], 0
    jz      short loc_183B5
    cmp     [bx+CARSTATE.car_angle_z], 0
    jnz     short loc_183B5
    mov     si, bx
    mov     ax, [si+CARSTATE.car_36MwhlAngle]
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    sub     ax, cx
    mov     cl, 4
    sar     ax, cl
    mov     [bx+CARSTATE.car_36MwhlAngle], ax
loc_183B5:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_angle_z], 0
    jz      short loc_183C6
    mov     si, bx
    mov     ax, [si+CARSTATE.car_angle_z]
    sub     [bx+CARSTATE.car_36MwhlAngle], ax
loc_183C6:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_slidingFlag], 0
    jnz     short loc_183D3
    jmp     loc_18458
loc_183D3:
    cmp     [bx+CARSTATE.field_42], 0
    jge     short loc_183E0
    mov     ax, [bx+CARSTATE.field_42]
    neg     ax
    jmp     short loc_183E3
loc_183E0:
    mov     ax, [bx+CARSTATE.field_42]
loc_183E3:
    shl     ax, 1
    mov     [bp+var_8], ax
    cmp     [bx+CARSTATE.car_speed], ax
    jbe     short loc_18448
    cmp     [bx+CARSTATE.car_speed2], ax
    jbe     short loc_18400
    sub     [bx+CARSTATE.car_speed], ax
    mov     bx, [bp+arg_cState]
    mov     ax, [bp+var_8]
    sub     [bx+CARSTATE.car_speed2], ax
    jmp     short loc_18410
loc_18400:
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_speed], 0
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_speed2], 0
loc_18410:
    mov     bx, [bp+arg_cState]
    cmp     [bx+CARSTATE.car_crashBmpFlag], 0
    jnz     short loc_18458
    cmp     [bx+CARSTATE.car_surfaceWhl], 1
    jz      short loc_18436
    cmp     [bx+(CARSTATE.car_surfaceWhl+1)], 1
    jz      short loc_18436
    cmp     [bx+(CARSTATE.car_surfaceWhl+2)], 1
    jz      short loc_18436
    cmp     [bx+(CARSTATE.car_surfaceWhl+3)], 1
    jnz     short loc_1843E
loc_18436:
smart
    or      [bx+CARSTATE.field_CF], 2
nosmart
    jmp     short loc_18458
    ; align 2
    db 144
loc_1843E:
    mov     bx, [bp+arg_cState]
smart
    or      [bx+CARSTATE.field_CF], 4
nosmart
    jmp     short loc_18458
loc_18448:
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_speed], 0
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.car_speed2], 0
loc_18458:
    mov     bx, [bp+arg_cState]
    mov     [bx+CARSTATE.field_42], 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
update_grip endp
car_car_speed_adjust_maybe proc far
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_oState = word ptr 6
    arg_pState = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 18h
    push    si
    mov     bx, [bp+arg_oState]
    mov     [bx+CARSTATE.field_C8], 1
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.field_C8], 1
    mov     bx, [bp+arg_oState]
    mov     ax, [bx+CARSTATE.car_speed2]
    mov     [bp+var_6], ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_speed2]
    mov     [bp+var_C], ax
    mov     bx, [bp+arg_oState]
    mov     ax, [bx+CARSTATE.car_rotate.vx]
    mov     [bp+var_2], ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rotate.vx]
    mov     [bp+var_4], ax
    push    [bp+var_2]
    call    sin_fast
    add     sp, 2
    push    ax
    mov     ax, [bp+var_6]
    mov     cl, 8
    shr     ax, cl
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     [bp+var_10], ax
    push    [bp+var_4]
    call    sin_fast
    add     sp, 2
    push    ax
    mov     ax, [bp+var_C]
    mov     cl, 8
    shr     ax, cl
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     [bp+var_14], ax
    push    [bp+var_2]
    call    cos_fast
    add     sp, 2
    push    ax
    mov     ax, [bp+var_6]
    mov     cl, 8
    shr     ax, cl
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     [bp+var_12], ax
    push    [bp+var_4]
    call    cos_fast
    add     sp, 2
    push    ax
    mov     ax, [bp+var_C]
    mov     cl, 8
    shr     ax, cl
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     [bp+var_16], ax
    sub     ax, [bp+var_12]
    push    ax
    mov     ax, [bp+var_14]
    sub     ax, [bp+var_10]
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_A], ax
    cmp     ax, 0Ah
    jge     short loc_1853D
    mov     [bp+var_A], 0Ah
loc_1853D:
    mov     ax, [bp+var_2]
    sub     ax, [bp+var_4]
smart
    and     ah, 3
nosmart
    mov     [bp+var_8], ax
    mov     ah, byte ptr [bp+var_A]
    sub     al, al
    mov     [bp+var_E], ax
    mov     ax, 300h
    imul    [bp+var_A]
    sar     ax, 1
    sar     ax, 1
    mov     [bp+var_18], ax
    mov     bx, [bp+arg_oState]
    cmp     [bx+CARSTATE.car_speed2], ax
    jnb     short loc_1856E
    mov     [bx+CARSTATE.car_speed2], 0
    jmp     short loc_18577
    ; align 2
    db 144
loc_1856E:
    mov     bx, [bp+arg_oState]
    mov     ax, [bp+var_18]
    sub     [bx+CARSTATE.car_speed2], ax
loc_18577:
    mov     bx, [bp+arg_oState]
    mov     ax, [bp+var_4]
    sub     ax, [bp+var_2]
    mov     [bx+CARSTATE.car_36MwhlAngle], ax
    mov     bx, [bp+arg_oState]
    cmp     [bx+CARSTATE.car_36MwhlAngle], 200h
    jl      short loc_18592
    sub     [bx+CARSTATE.car_36MwhlAngle], 400h
loc_18592:
    mov     bx, [bp+arg_oState]
    cmp     [bx+CARSTATE.car_36MwhlAngle], 0FE00h
    jg      short loc_185A0
    add     byte ptr [bx+CARSTATE.car_36MwhlAngle+1], 4
loc_185A0:
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+var_2]
    sub     ax, [bp+var_4]
    mov     [bx+CARSTATE.car_36MwhlAngle], ax
    mov     bx, [bp+arg_pState]
    cmp     [bx+CARSTATE.car_36MwhlAngle], 200h
    jl      short loc_185BB
    sub     [bx+CARSTATE.car_36MwhlAngle], 400h
loc_185BB:
    mov     bx, [bp+arg_pState]
    cmp     word ptr [bx+36h], 0FE00h
    jg      short loc_185C9
    add     byte ptr [bx+CARSTATE.car_36MwhlAngle+1], 4
loc_185C9:
    mov     bx, [bp+arg_oState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_speed2]
    mov     [bx+CARSTATE.car_speed], ax
    mov     bx, [bp+arg_pState]
    mov     si, bx
    mov     ax, [si+CARSTATE.car_speed2]
    mov     [bx+CARSTATE.car_speed], ax
    cmp     [bp+var_A], 1Eh
    jle     short loc_185EE
    mov     ax, 1
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_185EE:
    sub     ax, ax
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
car_car_speed_adjust_maybe endp
carState_rc_op proc far
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_pState = word ptr 6
    arg_2 = word ptr 8
    arg_wheelIndex = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    mov     ax, [si+CARSTATE.car_rc2]; rc accesses are offset by the wheel index.
    mov     [bp+var_2], ax
    mov     [bp+var_4], 0
    mov     [bp+var_6], 0
    cmp     [si+CARSTATE.car_rc5], 0
    jz      short loc_18659
    jge     short loc_18636
    add     [si+CARSTATE.car_rc5], 4
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    add     si, CARSTATE.car_rc5
    mov     ax, [si]
    cmp     [bp+var_6], ax
    jge     short loc_18659
    jmp     short loc_18654
loc_18636:
    mov     di, [bp+arg_wheelIndex]
    shl     di, 1
    mov     bx, [bp+arg_pState]
    sub     [bx+di+CARSTATE.car_rc5], 4
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    add     si, CARSTATE.car_rc5
    mov     ax, [si]
    cmp     [bp+var_6], ax
    jle     short loc_18659
loc_18654:
    mov     ax, [bp+var_6]
    mov     [si], ax
loc_18659:
    mov     di, [bp+arg_wheelIndex]
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     si, [bx+di+CARSTATE.car_rc5]
    mov     di, [bp+arg_wheelIndex]
    shl     di, 1
    mov     [bx+di+CARSTATE.car_rc5], si
    cmp     [bp+arg_2], 0
    jge     short loc_18689
    mov     di, [bp+arg_wheelIndex]
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_2]
    neg     ax
    cmp     [bx+di+CARSTATE.car_rc2], ax
    jle     short loc_18689
    mov     [bp+arg_2], 0
loc_18689:
    cmp     [bp+arg_2], 0
    jnz     short loc_186FA
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    mov     ax, [si+CARSTATE.car_rc5]
    cmp     [si+CARSTATE.car_rc2], ax
    jle     short loc_186C8
    sub     [si+CARSTATE.car_rc2], 80h ; '€'
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    mov     ax, [si+CARSTATE.car_rc5]
    cmp     [si+CARSTATE.car_rc2], ax
    jge     short loc_186B7
    mov     [si+CARSTATE.car_rc2], ax
loc_186B7:
    mov     ax, [bp+var_2]
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    mov     bx, [bp+arg_pState]
loc_186C2:
    sub     ax, [bx+si+CARSTATE.car_rc2]
    jmp     loc_187A2
loc_186C8:
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    mov     ax, [si+CARSTATE.car_rc5]
    cmp     [si+CARSTATE.car_rc2], ax
    jl      short loc_186DB
    jmp     loc_187A5
loc_186DB:
    add     [si+CARSTATE.car_rc2], 80h ; '€'
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    mov     ax, [si+CARSTATE.car_rc5]
    cmp     [si+CARSTATE.car_rc2], ax
    jg      short loc_186F3
    jmp     loc_187A5
loc_186F3:
    mov     [si+CARSTATE.car_rc2], ax
    jmp     loc_187A5
    ; align 2
    db 144
loc_186FA:
    cmp     [bp+arg_2], 0
    jle     short loc_18748
    cmp     [bp+arg_2], 0C0h ; 'À'
    jle     short loc_18716
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    mov     bx, [bp+arg_pState]
    add     [bx+si+CARSTATE.car_rc2], 0C0h ; 'À'
    jmp     short loc_18724
loc_18716:
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_2]
    add     [bx+si+CARSTATE.car_rc2], ax
loc_18724:
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    add     si, 54h ; 'T'   ; 54 = car_rc2
    cmp     word ptr [si], 180h
    jle     short loc_18739
    mov     word ptr [si], 180h
loc_18739:
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    mov     bx, [bp+arg_pState]
    mov     word ptr [bx+si+64h], 0; 64 = car_rc4
    jmp     short loc_187A5
loc_18748:
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    add     si, CARSTATE.car_rc2
    mov     ax, [bp+arg_2]
    add     ax, [si]
    cmp     ax, 0FEE0h
    jle     short loc_18764
    mov     ax, [bp+arg_2]
    add     [si], ax
    jmp     short loc_18791
loc_18764:
    mov     di, [bp+arg_wheelIndex]
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, [bp+arg_2]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    sar     ax, 1
    sar     ax, 1
    add     [bx+di+CARSTATE.car_rc2], ax
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    add     si, [bp+arg_pState]
    add     si, CARSTATE.car_rc2
    cmp     word ptr [si], 0FE80h
    jge     short loc_18791
    mov     word ptr [si], 0FE80h
loc_18791:
    mov     ax, [bp+var_2]
    mov     si, [bp+arg_wheelIndex]
    shl     si, 1
    mov     bx, [bp+arg_pState]
    sub     ax, [bx+si+54h]
    add     ax, [bp+arg_2]
loc_187A2:
    mov     [bp+var_4], ax
loc_187A5:
    mov     ax, [bp+var_2]
    add     ax, [bp+var_4]
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
carState_rc_op endp
upd_statef20_from_steer_input proc far
    var_speed2shr0AandFC = byte ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_steeringInput = byte ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    mov     di, state.playerstate.car_steeringAngle
    mov     ax, state.playerstate.car_speed2
    mov     cl, 0Ah
    shr     ax, cl
smart
    and     al, 0FCh
nosmart
    mov     [bp+var_speed2shr0AandFC], al
    cbw
    mov     bx, ax
    mov     al, [bp+arg_steeringInput]
    cbw
    add     bx, ax
    add     bx, steerWhlRespTable_ptr
    mov     al, [bx]
    cbw
    mov     si, ax
    or      si, si
    jle     short loc_187E8
    cmp     di, 0FFFFh
    jge     short loc_187F5
    jmp     short loc_187F1
    ; align 2
    db 144
loc_187E8:
    or      si, si
    jz      short loc_187F5
    cmp     di, 1
    jle     short loc_187F5
loc_187F1:
    mov     cl, 2
    shl     si, cl
loc_187F5:
    or      si, si
    jnz     short loc_18835
    cmp     state.playerstate.car_speed2, 0
    jz      short loc_18835
    or      di, di
    jz      short loc_18835
    mov     al, [bp+var_speed2shr0AandFC]
    cbw
    mov     bx, ax
    add     bx, steerWhlRespTable_ptr
    mov     al, [bx+1]      ; tables?! With 40h values!!
    cbw
    mov     si, ax
    shl     si, 1
    or      di, di
    jge     short loc_18820
    mov     ax, di
    neg     ax
    jmp     short loc_18822
loc_18820:
    mov     ax, di
loc_18822:
    cmp     ax, si
    jle     short loc_1882E
    or      di, di
    jle     short loc_18835
    mov     ax, si
    jmp     short loc_18831
loc_1882E:
    mov     ax, state.playerstate.car_steeringAngle
loc_18831:
    neg     ax
    mov     si, ax
loc_18835:
    cmp     framespersec, 0Ah
    jnz     short loc_18850
    cmp     si, 0A0h ; ' '
    jle     short loc_18845
    mov     si, 0A0h ; ' '
loc_18845:
    cmp     si, 0FF60h
    jge     short loc_18860
    mov     si, 0FF60h
    jmp     short loc_18860
loc_18850:
    cmp     si, 50h ; 'P'
    jle     short loc_18858
    mov     si, 50h ; 'P'
loc_18858:
    cmp     si, 0FFB0h
    jge     short loc_18860
    mov     si, 0FFB0h
loc_18860:
    add     di, si
    cmp     di, 0F0h ; 'ð'
    jle     short loc_1886B
    mov     di, 0F0h ; 'ð'
loc_1886B:
    cmp     di, 0FF10h
    jge     short loc_18874
    mov     di, 0FF10h
loc_18874:
    mov     al, [bp+var_speed2shr0AandFC]
    cbw
    mov     bx, ax
    mov     al, [bp+arg_steeringInput]
    cbw
    add     bx, ax
    add     bx, steerWhlRespTable_ptr
    cmp     byte ptr [bx], 0
    jnz     short loc_18899
    push    di              ; int
    call    _abs
    add     sp, 2
    cmp     ax, 8
    jge     short loc_18899
    sub     di, di
loc_18899:
    mov     state.playerstate.car_steeringAngle, di
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
upd_statef20_from_steer_input endp
audio_carstate proc far
    var_34 = dword ptr -52
    var_30 = word ptr -48
    var_2E = word ptr -46
    var_2C = word ptr -44
    var_2A = word ptr -42
    var_28 = word ptr -40
    var_26 = word ptr -38
    var_24 = word ptr -36
    var_22 = word ptr -34
    var_20 = word ptr -32
    var_1E = word ptr -30
    var_1C = word ptr -28
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_16 = byte ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 34h
    push    di
    push    si
    cmp     is_in_replay, 0
    jnz     short loc_188B6
    jmp     loc_1893A
loc_188B6:
    cmp     byte_459D8, 0
    jz      short loc_18925
    mov     ax, word_449E4
    mov     word_44D1E, ax
    test    byte_42D26, 6
    jz      short loc_188D6
    push    word_43964
    call    audio_op_unk7
    add     sp, 2
loc_188D6:
    test    byte_42D26, 1
    jz      short loc_188E9
    push    word_43964
    call    audio_function2
    add     sp, 2
loc_188E9:
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_18916
    test    byte_42D2A, 6
    jz      short loc_18903
    push    word_4408C
    call    audio_op_unk7
    add     sp, 2
loc_18903:
    test    byte_42D2A, 1
    jz      short loc_18916
    push    word_4408C
    call    audio_function2
    add     sp, 2
loc_18916:
    mov     byte_459D8, 0
    mov     byte_42D26, 0
    mov     byte_42D2A, 0
loc_18925:
    mov     al, byte_3BE02
    cmp     is_in_replay, al
loc_1892C:
    jnz     short loc_18931
    jmp     loc_18CCC
loc_18931:
    call    sub_38178
    jmp     loc_18CCC
    ; align 2
    db 144
loc_1893A:
    mov     ax, word ptr state.playerstate.car_posWorld2.lx
    mov     dx, word ptr state.playerstate.car_posWorld2.lx+2
    mov     cl, 6
loc_18943:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_18943
loc_1894B:
    mov     [bp+var_1C], ax
    mov     ax, word ptr state.playerstate.car_posWorld2.ly
    mov     dx, word ptr state.playerstate.car_posWorld2.ly+2
    mov     cl, 6
loc_18957:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_18957
    mov     [bp+var_1A], ax
    mov     ax, word ptr state.playerstate.car_posWorld2.lz
    mov     dx, word ptr state.playerstate.car_posWorld2.lz+2
    mov     cl, 6
loc_1896B:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1896B
    mov     [bp+var_18], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.lx
    mov     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1897F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1897F
    mov     [bp+var_8], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.ly
    mov     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_18993:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_18993
    mov     [bp+var_6], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.lz
    mov     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     cl, 6
loc_189A7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_189A7
    mov     [bp+var_4], ax
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_18A31
    mov     ax, word ptr state.opponentstate.car_posWorld2.lx
    mov     dx, word ptr state.opponentstate.car_posWorld2.lx+2
    mov     cl, 6
loc_189C2:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_189C2
    mov     [bp+var_24], ax
    mov     ax, word ptr state.opponentstate.car_posWorld2.ly
    mov     dx, word ptr state.opponentstate.car_posWorld2.ly+2
    mov     cl, 6
loc_189D6:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_189D6
    mov     [bp+var_22], ax
    mov     ax, word ptr state.opponentstate.car_posWorld2.lz
    mov     dx, word ptr state.opponentstate.car_posWorld2.lz+2
    mov     cl, 6
loc_189EA:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_189EA
    mov     [bp+var_20], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.lx
    mov     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_189FE:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_189FE
    mov     [bp+var_E], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.ly
    mov     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_18A12:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_18A12
    mov     [bp+var_C], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.lz
    mov     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_18A26:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_18A26
    mov     [bp+var_A], ax
loc_18A31:
    mov     al, cameramode
    cbw
    or      ax, ax
    jz      short loc_18A52
    cmp     ax, 1
    jnz     short loc_18A41
    jmp     loc_18B42
loc_18A41:
    cmp     ax, 2
    jz      short loc_18A52
    cmp     ax, 3
    jnz     short loc_18A4E
    jmp     loc_18B6E
loc_18A4E:
    jmp     short loc_18A82
    db 144
    db 144
loc_18A52:
    cmp     followOpponentFlag, 0
    jz      short loc_18A6E
    lea     di, [bp+var_14]
    lea     si, [bp+var_E]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    lea     di, [bp+var_2A]
    lea     si, [bp+var_24]
loc_18A6A:
    push    ss
    pop     es
    jmp     short loc_18A7F
loc_18A6E:
    lea     di, [bp+var_14]
    lea     si, [bp+var_8]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    lea     di, [bp+var_2A]
    lea     si, [bp+var_1C]
loc_18A7F:
    movsw
    movsw
    movsw
loc_18A82:
    mov     ax, 22h ; '"'
    imul    word_449E4
    add     ax, offset unk_44F4C
    mov     [bp+var_2], ax
    mov     bx, ax
    mov     ax, [bp+var_2A]
    sub     ax, [bp+var_1C]
    mov     [bx+6], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_28]
    sub     ax, [bp+var_1A]
    mov     [bx+8], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_26]
    sub     ax, [bp+var_18]
    mov     [bx+0Ah], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_14]
    sub     ax, [bp+var_8]
    mov     [bx+0Ch], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_12]
    sub     ax, [bp+var_6]
    mov     [bx+0Eh], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_10]
    sub     ax, [bp+var_4]
    mov     [bx+10h], ax
    mov     bx, [bp+var_2]
    mov     ax, state.playerstate.car_currpm
    mov     [bx+1Eh], ax
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_18AE9
    jmp     loc_18BB6
loc_18AE9:
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_2A]
    sub     ax, [bp+var_24]
    mov     [bx+12h], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_28]
    sub     ax, [bp+var_22]
    mov     [bx+14h], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_26]
    sub     ax, [bp+var_20]
    mov     [bx+16h], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_14]
    sub     ax, [bp+var_E]
    mov     [bx+18h], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_12]
    sub     ax, [bp+var_C]
    mov     [bx+1Ah], ax
    mov     bx, [bp+var_2]
    mov     ax, [bp+var_10]
    sub     ax, [bp+var_A]
    mov     [bx+1Ch], ax
    mov     bx, [bp+var_2]
    mov     ax, state.opponentstate.car_currpm
    mov     [bx+20h], ax
    mov     [bp+var_30], 2
    jmp     short loc_18BBB
    ; align 2
    db 144
loc_18B42:
    mov     al, followOpponentFlag
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     si, ax
    push    si
    lea     di, [bp+var_14]
    lea     si, state.game_vec1.vx[si]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    push    si
    lea     di, [bp+var_2A]
    lea     si, state.game_vec3.vx[si]
    movsw
    movsw
    movsw
    pop     si
    jmp     loc_18A82
    ; align 2
    db 144
loc_18B6E:
    mov     al, followOpponentFlag
    cbw
    mov     bx, ax
    mov     al, state.field_3F7[bx]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr trackdata9
    mov     dx, word ptr trackdata9+2
    mov     word ptr [bp+var_34], ax
    mov     word ptr [bp+var_34+2], dx
    les     bx, [bp+var_34]
    mov     ax, es:[bx]
    mov     [bp+var_14], ax
    mov     ax, es:[bx+2]
    add     ax, word_44D20
    add     ax, 5Ah ; 'Z'
    mov     [bp+var_12], ax
    mov     ax, es:[bx+4]
    mov     [bp+var_10], ax
    lea     di, [bp+var_2A]
    lea     si, [bp+var_14]
    jmp     loc_18A6A
loc_18BB6:
    mov     [bp+var_30], 1
loc_18BBB:
    mov     [bp+var_1E], 0
    jmp     loc_18C93
    ; align 2
    db 144
loc_18BC4:
    mov     [bp+var_2C], offset state.playerstate
    mov     ax, word_43964
    mov     [bp+var_2E], ax
    mov     al, byte_42D26
loc_18BD2:
    mov     [bp+var_16], al
    mov     bx, [bp+var_2C]
    test    [bx+CARSTATE.field_CF], 1
    jz      short loc_18BF4
    test    [bp+var_16], 1
    jnz     short loc_18C08
smart
    or      [bp+var_16], 1
nosmart
    push    [bp+var_2E]
    call    audio_op_unk
    jmp     short loc_18C05
    ; align 2
    db 144
loc_18BF4:
    test    [bp+var_16], 1
    jz      short loc_18C08
    dec     [bp+var_16]
    push    [bp+var_2E]
    call    audio_function2
loc_18C05:
    add     sp, 2
loc_18C08:
    mov     bx, [bp+var_2C]
    test    [bx+CARSTATE.field_CF], 6
    jz      short loc_18C56
    mov     al, [bp+var_16]
smart
    and     al, 6
nosmart
    mov     byte ptr [bp+var_34], al
    mov     al, [bx+CARSTATE.field_CF]
smart
    and     al, 6
nosmart
    cmp     al, byte ptr [bp+var_34]
    jz      short loc_18C7B
    test    [bp+var_16], 6
    jnz     short loc_18C5C
    test    [bx+CARSTATE.field_CF], 2
    jz      short loc_18C44
    push    [bp+var_2E]
    call    audio_op_unk5
    add     sp, 2
    add     [bp+var_16], 2
    jmp     short loc_18C7B
    ; align 2
    db 144
loc_18C44:
    push    [bp+var_2E]
    call    audio_op_unk6
    add     sp, 2
    add     [bp+var_16], 4
    jmp     short loc_18C7B
    ; align 2
    db 144
loc_18C56:
    test    [bp+var_16], 6
    jz      short loc_18C7B
loc_18C5C:
    test    [bp+var_16], 2
    jz      short loc_18C66
    sub     [bp+var_16], 2
loc_18C66:
    test    [bp+var_16], 4
    jz      short loc_18C70
    sub     [bp+var_16], 4
loc_18C70:
    push    [bp+var_2E]
    call    audio_op_unk7
    add     sp, 2
loc_18C7B:
    cmp     [bp+var_1E], 0
    jz      short loc_18C8A
    mov     al, [bp+var_16]
    mov     byte_42D2A, al
    jmp     short loc_18C90
    ; align 2
    db 144
loc_18C8A:
    mov     al, [bp+var_16]
    mov     byte_42D26, al
loc_18C90:
    inc     [bp+var_1E]
loc_18C93:
    mov     ax, [bp+var_30]
    cmp     [bp+var_1E], ax
    jge     short loc_18CB6
    cmp     [bp+var_1E], 0
    jnz     short loc_18CA4
    jmp     loc_18BC4
loc_18CA4:
    mov     [bp+var_2C], offset state.opponentstate
    mov     ax, word_4408C
    mov     [bp+var_2E], ax
    mov     al, byte_42D2A
    jmp     loc_18BD2
    ; align 2
    db 144
loc_18CB6:
    mov     byte_459D8, 1
    inc     word_449E4
    cmp     word_449E4, 28h ; '('
    jnz     short loc_18CCC
    mov     word_449E4, 0
loc_18CCC:
    mov     al, is_in_replay
    mov     byte_3BE02, al
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audio_carstate endp
audio_unk3 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    cmp     byte_459D8, 0
    jz      short loc_18D04
    test    [bp+arg_0], 10h
    jz      short loc_18CF3
    push    [bp+arg_2]
    call    audio_op_unk4
    add     sp, 2
loc_18CF3:
    test    [bp+arg_0], 20h
    jz      short loc_18D04
    push    [bp+arg_2]
    call    audio_op_unk3
    add     sp, 2
loc_18D04:
    pop     bp
    retf
audio_unk3 endp
sub_18D06 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    [bp+arg_2]
    mov     bx, [bp+arg_0]
    push    word ptr [bx+10h]
    push    word ptr [bx+0Eh]
    push    word ptr [bx+0Ch]
    push    word ptr [bx+0Ah]
    push    word ptr [bx+8]
    push    word ptr [bx+6]
    push    word ptr [bx+1Eh]
    push    word_43964
    call    audio_op_unk2
    add     sp, 12h
    cmp     gameconfig.game_opponenttype, 0
    jz      short loc_18D5E
    push    [bp+arg_2]
    mov     bx, [bp+arg_0]
    push    word ptr [bx+1Ch]
    push    word ptr [bx+1Ah]
    push    word ptr [bx+18h]
    push    word ptr [bx+16h]
    push    word ptr [bx+14h]
    push    word ptr [bx+12h]
    push    word ptr [bx+20h]
    push    word_4408C
    call    audio_op_unk2
    add     sp, 12h
loc_18D5E:
    pop     bp
    retf
sub_18D06 endp
sub_18D60 proc far
    var_30 = word ptr -48
    var_2E = word ptr -46
    var_2C = word ptr -44
    var_2A = word ptr -42
    var_td18connStatus = byte ptr -40
    var_offsetTrkObject = word ptr -38
    var_24 = word ptr -36
    var_22 = word ptr -34
    var_20 = word ptr -32
    var_1E = word ptr -30
    var_td18subTOI = byte ptr -28
    var_1A = word ptr -26
    var_18 = byte ptr -24
    var_16 = byte ptr -22
    var_TOInfoPtr = word ptr -20
    var_12 = word ptr -18
    var_10 = byte ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = dword ptr -6
    var_tileElem = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = byte ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 30h
    push    di
    push    si
    mov     bx, [bp+arg_0]
    les     si, td17_trk_elem_ordered
    mov     al, es:[bx+si]
    mov     [bp+var_tileElem], al
    les     si, trackdata18
    mov     al, es:[bx+si]
smart
    and     al, 0Fh
nosmart
    mov     [bp+var_td18subTOI], al
    mov     al, es:[bx+si]
smart
    and     al, 10h
nosmart
    mov     [bp+var_td18connStatus], al
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     cx, ax          ; * sizeof(struct TRACKOBJECT)
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_offsetTrkObject], ax
    mov     bx, ax
    mov     ax, [bx]
    mov     [bp+var_TOInfoPtr], ax
    mov     [bp+var_12], ds
    mov     al, [bp+var_td18subTOI]
    sub     ah, ah
    mov     cx, ax          ; * sizeof(struct TRKOBJINFO)
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_TOInfoPtr]
    mov     dx, ds
    mov     word ptr [bp+var_6], ax
    mov     word ptr [bp+var_6+2], dx
    mov     [bp+var_24], 0
    les     bx, [bp+var_6]
    mov     al, es:[bx+TRKOBJINFO.si_arrowType]
    mov     [bp+var_18], al
    cmp     [bp+var_td18connStatus], 0
    jnz     short loc_18DE2
    mov     al, [bp+arg_4]
    shl     al, 1
    jmp     short loc_18DEC
loc_18DE2:
    mov     al, [bp+var_18]
    sub     al, [bp+arg_4]
    shl     al, 1
    sub     al, 2
loc_18DEC:
    mov     [bp+var_10], al
    cmp     [bp+arg_6], 0
    jz      short loc_18E1A
    mov     al, es:[bx+TRKOBJINFO.si_oppSpedCode]
    mov     [bp+var_16], al
    mov     bx, [bp+var_offsetTrkObject]
    mov     al, [bx+TRACKOBJECT.ss_surfaceType]
    mov     byte ptr [bp+var_1A], al
    mov     si, [bp+var_1A]
smart
    and     si, 0FFh
nosmart
    mov     bl, [bp+var_16]
    sub     bh, bh
    mov     al, oppnentSped[bx+si]
    mov     bx, [bp+arg_6]
    mov     [bx], al
loc_18E1A:
    les     bx, [bp+var_6]
    cmp     word ptr es:[bx+TRKOBJINFO.si_opp1], 0
    jz      short loc_18E29
    mov     [bp+var_24], 1
loc_18E29:
    cmp     [bp+var_td18connStatus], 0
    jz      short loc_18E76
    cmp     [bp+var_24], 0
    jz      short loc_18E3C
    mov     ax, word ptr es:[bx+TRKOBJINFO.si_opp1]
    jmp     short loc_18E7D
    ; align 2
    db 144
loc_18E3C:
    les     bx, [bp+var_6]
    mov     ax, es:[bx+8]
    mov     [bp+var_2C], ax
    mov     [bp+var_2A], ds
    mov     al, [bp+var_10]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_2C]
    mov     dx, ds
    mov     [bp+var_30], ax
    mov     [bp+var_2E], dx
    add     ax, 6
    lea     di, [bp+var_C]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    movsw
    movsw
    movsw
    pop     ds
    mov     ax, [bp+var_30]
    jmp     short loc_18EAA
    ; align 2
    db 144
loc_18E76:
    les     bx, [bp+var_6]
    mov     ax, es:[bx+TRKOBJINFO.si_cameraDataOffset]
loc_18E7D:
    mov     [bp+var_2C], ax
    mov     [bp+var_2A], ds
    mov     al, [bp+var_10]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_2C]
    mov     dx, ds
    mov     [bp+var_30], ax
    mov     [bp+var_2E], dx
    lea     di, [bp+var_C]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    movsw
    movsw
    movsw
    pop     ds
    add     ax, 6
loc_18EAA:
    lea     di, [bp+var_22]
    mov     si, ax
    push    ds
    mov     ds, dx
    movsw
    movsw
    movsw
    pop     ds
    les     bx, [bp+var_6]
    mov     ax, es:[bx+6]
    cmp     ax, 100h
    jnz     short loc_18EC5
    jmp     loc_18F74
loc_18EC5:
    cmp     ax, 200h
    jnz     short loc_18ECD
    jmp     loc_18F52
loc_18ECD:
    cmp     ax, 300h
    jnz     short loc_18EFA
    mov     ax, [bp+var_C]
    mov     [bp+var_E], ax
    mov     ax, [bp+var_8]
    neg     ax
    mov     [bp+var_C], ax
    mov     ax, [bp+var_E]
    mov     [bp+var_8], ax
    mov     ax, [bp+var_22]
    mov     [bp+var_E], ax
    mov     ax, [bp+var_1E]
    neg     ax
    mov     [bp+var_22], ax
    mov     ax, [bp+var_E]
loc_18EF7:
    mov     [bp+var_1E], ax
loc_18EFA:
    mov     bx, [bp+arg_0]
    les     si, td21_col_from_path
    mov     al, es:[bx+si]
    mov     [bp+var_16], al
    les     si, td22_row_from_path
    mov     al, es:[bx+si]
    mov     byte ptr [bp+var_1A], al
    cmp     [bp+var_A], 0FFFFh
    jz      short loc_18F3B
    mov     bl, al
    sub     bh, bh
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_16]
    sub     ah, ah
    add     bx, ax
    les     si, td15_terr_map_main
    cmp     byte ptr es:[bx+si], 6
    jnz     short loc_18F3B
    mov     ax, hillHeightConsts+2
    add     [bp+var_A], ax
    add     [bp+var_20], ax
loc_18F3B:
    mov     bx, [bp+var_offsetTrkObject]
    test    byte ptr [bx+0Bh], 1
    jz      short loc_18F9C
    mov     bl, byte ptr [bp+var_1A]
    sub     bh, bh
    shl     bx, 1
    mov     si, trackpos[bx]
    jmp     short loc_18FA7
    ; align 2
    db 144
loc_18F52:
    mov     ax, [bp+var_8]
    neg     ax
    mov     [bp+var_8], ax
    mov     ax, [bp+var_C]
    neg     ax
    mov     [bp+var_C], ax
    mov     ax, [bp+var_1E]
    neg     ax
    mov     [bp+var_1E], ax
    mov     ax, [bp+var_22]
    neg     ax
    mov     [bp+var_22], ax
    jmp     short loc_18EFA
loc_18F74:
    mov     ax, [bp+var_C]
    mov     [bp+var_E], ax
    mov     ax, [bp+var_8]
    mov     [bp+var_C], ax
    mov     ax, [bp+var_E]
    neg     ax
    mov     [bp+var_8], ax
    mov     ax, [bp+var_22]
    mov     [bp+var_E], ax
    mov     ax, [bp+var_1E]
    mov     [bp+var_22], ax
    mov     ax, [bp+var_E]
    neg     ax
    jmp     loc_18EF7
loc_18F9C:
    mov     bl, byte ptr [bp+var_1A]
    sub     bh, bh
    shl     bx, 1
    mov     si, trackcenterpos[bx]
loc_18FA7:
    add     [bp+var_8], si
    add     [bp+var_1E], si
    mov     bx, [bp+var_offsetTrkObject]
    test    byte ptr [bx+0Bh], 2
    jz      short loc_18FC4
    mov     bl, [bp+var_16]
    sub     bh, bh
    shl     bx, 1
    mov     si, (trackpos2+2)[bx]
    jmp     short loc_18FCF
    ; align 2
    db 144
loc_18FC4:
    mov     bl, [bp+var_16]
    sub     bh, bh
    shl     bx, 1
    mov     si, trackcenterpos2[bx]
loc_18FCF:
    add     [bp+var_C], si
    add     [bp+var_22], si
    mov     ax, [bp+var_22]
    cwd
    mov     cx, ax
    mov     ax, [bp+var_C]
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     bx, [bp+arg_2]
    mov     [bx+VECTOR.vx], ax
    cmp     [bp+var_A], 0FFFFh
    jnz     short loc_18FFE
    mov     bx, [bp+arg_2]
    mov     [bx+VECTOR.vy], 0FFFFh
    jmp     short loc_19018
loc_18FFE:
    mov     ax, [bp+var_20]
    cwd
    mov     cx, ax
    mov     ax, [bp+var_A]
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     bx, [bp+arg_2]
    mov     [bx+VECTOR.vy], ax
loc_19018:
    mov     ax, [bp+var_1E]
    cwd
    mov     cx, ax
    mov     ax, [bp+var_8]
    mov     bx, dx
    cwd
    add     ax, cx
    adc     dx, bx
    sar     dx, 1
    rcr     ax, 1
    mov     bx, [bp+arg_2]
    mov     [bx+VECTOR.vz], ax
    mov     bx, [bp+arg_2]
    lea     di, [bx+6]
    lea     si, [bp+var_C]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    mov     bx, [bp+arg_2]
    lea     di, [bx+0Ch]
    lea     si, [bp+var_22]
    movsw
    movsw
    movsw
    mov     bx, [bp+arg_2]
    mov     ax, [bp+var_24]
    mov     [bx+12h], ax
    mov     al, [bp+arg_4]
    cbw
    mov     cl, [bp+var_18]
    sub     ch, ch
    dec     cx
    cmp     cx, ax
    jnz     short loc_1906C
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_1906C:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_18D60 endp
car_car_coll_detect_maybe proc far
    var_2A = word ptr -42
    var_28 = word ptr -40
    var_26 = word ptr -38
    var_24 = byte ptr -36
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = byte ptr -6
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_pCollPoints = word ptr 6
    arg_pWorldCrds = word ptr 8
    arg_oCollPoints = word ptr 10
    arg_oWorldCrds = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 2Ah
    push    di
    push    si
    mov     bx, [bp+arg_pCollPoints]
    mov     si, [bx+6]      ; the 4th field of collPoints
    mov     bx, [bp+arg_oCollPoints]
    add     si, [bx+6]
    mov     bx, [bp+arg_pWorldCrds]
    mov     di, [bp+arg_oWorldCrds]
    mov     ax, [di]
    cmp     [bx], ax
    jl      short loc_19098
    mov     ax, [bx]
    mov     bx, di
loc_19098:
    sub     ax, [bx]
    cmp     ax, si
    jg      short loc_190D2
    mov     bx, [bp+arg_pWorldCrds]
    mov     di, [bp+arg_oWorldCrds]
    mov     ax, [di+4]
    cmp     [bx+4], ax
    jl      short loc_190B1
    mov     ax, [bx+4]
    mov     bx, di
loc_190B1:
    sub     ax, [bx+4]
    cmp     ax, si
    jg      short loc_190D2
    mov     bx, [bp+arg_pWorldCrds]
    mov     di, [bp+arg_oWorldCrds]
    mov     ax, [di+2]
    cmp     [bx+2], ax
    jl      short loc_190CB
    mov     ax, [bx+2]
    mov     bx, di
loc_190CB:
    sub     ax, [bx+2]
    cmp     ax, si
    jle     short loc_190DA
loc_190D2:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_190DA:
    mov     bx, [bp+arg_pWorldCrds]
    mov     ax, [bx]
    mov     bx, [bp+arg_oWorldCrds]
    sub     ax, [bx]
    mov     [bp+var_2A], ax
    mov     bx, [bp+arg_pWorldCrds]
    mov     ax, [bx+2]
    mov     bx, [bp+arg_oWorldCrds]
    sub     ax, [bx+2]
    mov     [bp+var_28], ax
    mov     bx, [bp+arg_pWorldCrds]
    mov     ax, [bx+4]
    mov     bx, [bp+arg_oWorldCrds]
    sub     ax, [bx+4]
    mov     [bp+var_26], ax
    lea     ax, [bp+var_2A]
    push    ax
    call    polarRadius3D
    add     sp, 2
    cmp     ax, si
    ja      short loc_190D2
    sub     ax, ax
    push    ax
    mov     bx, [bp+arg_pWorldCrds]
    mov     ax, [bx+0Ah]
    neg     ax
    push    ax
    mov     ax, [bx+8]
    neg     ax
    push    ax
    mov     ax, [bx+6]
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_4], ax
    mov     [bp+var_6], 0
    jmp     short loc_191B2
loc_1913E:
    mov     bx, [bp+arg_pCollPoints]
    mov     ax, [bx]
    neg     ax
loc_19145:
    mov     [bp+var_C], ax
    mov     [bp+var_A], 0
    mov     al, [bp+var_6]
    cbw
    mov     bx, ax
    shl     bx, 1
    cmp     word_3BE0C[bx], 0
    jnz     short loc_19164
    mov     bx, [bp+arg_pCollPoints]
    mov     ax, [bx+4]
    jmp     short loc_1916C
loc_19164:
    mov     bx, [bp+arg_pCollPoints]
    mov     ax, [bx+4]
    neg     ax
loc_1916C:
    mov     [bp+var_8], ax
    lea     ax, [bp+var_2A]
    push    ax
    push    [bp+var_4]
    lea     ax, [bp+var_C]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     bx, [bp+arg_pWorldCrds]
    mov     ax, [bx]
    add     [bp+var_2A], ax
    mov     ax, [bx+2]
    add     [bp+var_28], ax
    mov     ax, [bx+4]
    add     [bp+var_26], ax
    mov     al, [bp+var_6]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    push    si
    lea     di, [bp+di+var_24]
    lea     si, [bp+var_2A]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    inc     [bp+var_6]
loc_191B2:
    cmp     [bp+var_6], 4
    jge     short loc_191D2
    mov     al, [bp+var_6]
    cbw
    mov     bx, ax
    shl     bx, 1
    cmp     word_3BE04[bx], 0
    jz      short loc_191CA
    jmp     loc_1913E
loc_191CA:
    mov     bx, [bp+arg_pCollPoints]
    mov     ax, [bx]
    jmp     loc_19145
loc_191D2:
    mov     ax, 1
    push    ax
    mov     bx, [bp+arg_oWorldCrds]
    push    word ptr [bx+0Ah]
    push    word ptr [bx+8]
    push    word ptr [bx+6]
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_4], ax
    mov     [bp+var_6], 0
    jmp     short loc_191F7
    ; align 2
    db 144
loc_191F4:
    inc     [bp+var_6]
loc_191F7:
    cmp     [bp+var_6], 4
    jge     short loc_1927A
    mov     al, [bp+var_6]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    mov     bx, [bp+arg_oWorldCrds]
    mov     ax, [bx]
    sub     ax, [di-24h]
    mov     [bp+var_C], ax
    mov     ax, [bx+2]
    sub     ax, [di-22h]
    mov     [bp+var_A], ax
    mov     ax, [bx+4]
    sub     ax, [di-20h]
    mov     [bp+var_8], ax
    lea     ax, [bp+var_2A]
    push    ax
    push    [bp+var_4]
    lea     ax, [bp+var_C]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_28], 0
    jl      short loc_191F4
    mov     bx, [bp+arg_oCollPoints]
    mov     ax, [bp+var_28]
    cmp     [bx+2], ax
    jl      short loc_191F4
    mov     di, [bx]
    mov     ax, di
    neg     ax
    cmp     [bp+var_2A], ax
    jl      short loc_191F4
    cmp     [bp+var_2A], di
    jg      short loc_191F4
    mov     ax, [bx+4]
    neg     ax
    cmp     ax, [bp+var_26]
    jg      short loc_191F4
    mov     ax, [bp+var_26]
    cmp     [bx+4], ax
    jl      short loc_191F4
loc_19270:
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_1927A:
    sub     ax, ax
    push    ax
    mov     bx, [bp+arg_oWorldCrds]
    mov     ax, [bx+0Ah]
    neg     ax
    push    ax
    mov     ax, [bx+8]
    neg     ax
    push    ax
    mov     ax, [bx+6]
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_4], ax
    mov     [bp+var_6], 0
    jmp     short loc_19318
    ; align 2
    db 144
loc_192A4:
    mov     bx, [bp+arg_oCollPoints]
    mov     ax, [bx]
    neg     ax
loc_192AB:
    mov     [bp+var_C], ax
    mov     [bp+var_A], 0
    mov     al, [bp+var_6]
    cbw
    mov     bx, ax
    shl     bx, 1
    cmp     word_3BE0C[bx], 0
    jnz     short loc_192CA
    mov     bx, [bp+arg_oCollPoints]
    mov     ax, [bx+4]
    jmp     short loc_192D2
loc_192CA:
    mov     bx, [bp+arg_oCollPoints]
    mov     ax, [bx+4]
    neg     ax
loc_192D2:
    mov     [bp+var_8], ax
loc_192D5:
    lea     ax, [bp+var_2A]
    push    ax
loc_192D9:
    push    [bp+var_4]
loc_192DC:
    lea     ax, [bp+var_C]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     bx, [bp+arg_oWorldCrds]
    mov     ax, [bx]
    add     [bp+var_2A], ax
    mov     ax, [bx+2]
    add     [bp+var_28], ax
    mov     ax, [bx+4]
    add     [bp+var_26], ax
    mov     al, [bp+var_6]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    push    si
    lea     di, [bp+di+var_24]
    lea     si, [bp+var_2A]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    inc     [bp+var_6]
loc_19318:
    cmp     [bp+var_6], 4
    jge     short loc_19338
    mov     al, [bp+var_6]
    cbw
    mov     bx, ax
    shl     bx, 1
    cmp     word_3BE04[bx], 0
    jz      short loc_19330
    jmp     loc_192A4
loc_19330:
    mov     bx, [bp+arg_oCollPoints]
    mov     ax, [bx]
    jmp     loc_192AB
loc_19338:
    mov     ax, 1
    push    ax
    mov     bx, [bp+arg_pWorldCrds]
    push    word ptr [bx+0Ah]
    push    word ptr [bx+8]
    push    word ptr [bx+6]
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_4], ax
    mov     [bp+var_6], 0
    jmp     short loc_1935D
    ; align 2
    db 144
loc_1935A:
    inc     [bp+var_6]
loc_1935D:
    cmp     [bp+var_6], 4
    jl      short loc_19366
    jmp     loc_190D2
loc_19366:
    mov     al, [bp+var_6]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    mov     bx, [bp+arg_pWorldCrds]
    mov     ax, [bx]
    sub     ax, [di-24h]
    mov     [bp+var_C], ax
    mov     ax, [bx+2]
    sub     ax, [di-22h]
    mov     [bp+var_A], ax
    mov     ax, [bx+4]
    sub     ax, [di-20h]
    mov     [bp+var_8], ax
    lea     ax, [bp+var_2A]
    push    ax
    push    [bp+var_4]
    lea     ax, [bp+var_C]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_28], 0
    jl      short loc_1935A
    mov     bx, [bp+arg_pCollPoints]
    mov     ax, [bp+var_28]
    cmp     [bx+2], ax
    jl      short loc_1935A
    mov     di, [bx]
    mov     ax, di
    neg     ax
    cmp     [bp+var_2A], ax
    jl      short loc_1935A
    cmp     [bp+var_2A], di
    jg      short loc_1935A
    mov     ax, [bx+4]
    neg     ax
    cmp     ax, [bp+var_26]
    jg      short loc_1935A
    mov     ax, [bp+var_26]
    cmp     [bx+4], ax
    jl      short loc_193DC
    jmp     loc_19270
loc_193DC:
    jmp     loc_1935A
    ; align 2
    db 144
car_car_coll_detect_maybe endp
init_plantrak proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    mov     ax, 0FFFDh
    push    ax
    push    cs
    call near ptr init_game_state
    add     sp, 2
    sub     si, si
    mov     state.game_inputmode, 2
    mov     word ptr planptr, offset plan_memres
    mov     word ptr planptr+2, seg seg038
    mov     startcol2, 1
    mov     startrow2, 1Ch
    les     bx, td17_trk_elem_ordered
    mov     byte ptr es:[bx], 7
    les     bx, td21_col_from_path
    mov     byte ptr es:[bx], 1
    les     bx, td22_row_from_path
    mov     al, startrow2
    mov     es:[bx], al
    les     bx, trackdata18
    mov     byte ptr es:[bx], 0
    les     bx, td17_trk_elem_ordered
    mov     byte ptr es:[bx+1], 6
    les     bx, td21_col_from_path
    mov     byte ptr es:[bx+1], 0
    les     bx, td22_row_from_path
    mov     al, startrow2
    mov     es:[bx+1], al
    les     bx, trackdata18
    mov     byte ptr es:[bx+1], 0
    les     bx, td17_trk_elem_ordered
    mov     byte ptr es:[bx+2], 8
    les     bx, td21_col_from_path
    mov     byte ptr es:[bx+2], 0
    les     bx, td22_row_from_path
    mov     al, startrow2
    inc     al
    mov     es:[bx+2], al
    les     bx, trackdata18
    mov     byte ptr es:[bx+2], 0
    les     bx, td17_trk_elem_ordered
    mov     byte ptr es:[bx+3], 9
    les     bx, td21_col_from_path
    mov     byte ptr es:[bx+3], 1
    les     bx, td22_row_from_path
    mov     al, startrow2
    inc     al
    mov     es:[bx+3], al
    les     bx, trackdata18
    mov     byte ptr es:[bx+3], 0
    les     bx, td17_trk_elem_ordered
    mov     byte ptr es:[bx+4], 7
    les     bx, td21_col_from_path
    mov     byte ptr es:[bx+4], 1
    les     bx, td22_row_from_path
    mov     al, startrow2
    mov     es:[bx+4], al
    les     bx, trackdata18
    mov     byte ptr es:[bx+4], 0
    les     bx, trackdata3
    mov     es:[bx], si
    les     bx, trackdata3
    mov     word ptr es:[bx+2], 1
    les     bx, trackdata3
    mov     word ptr es:[bx+4], 2
    les     bx, trackdata3
    mov     word ptr es:[bx+6], 3
    les     bx, trackdata3
    mov     word ptr es:[bx+8], 4
    les     bx, trackdata3
    mov     word ptr es:[bx+0Ah], 1
    les     bx, trackdata3
    mov     word ptr es:[bx+0Ch], 2
    les     bx, trackdata3
    mov     word ptr es:[bx+0Eh], 3
    les     bx, trackdata3
    mov     word ptr es:[bx+10h], 4
    les     bx, trackdata3
    mov     word ptr es:[bx+12h], 1
    les     bx, trackdata3
    mov     word ptr es:[bx+14h], 2
    les     bx, trackdata3
    mov     word ptr es:[bx+16h], 3
    les     bx, trackdata3
    mov     word ptr es:[bx+18h], 4
    les     bx, trackdata3
    mov     es:[bx+1Ah], si
    les     bx, trackdata3
    mov     word ptr es:[bx+1Ch], 1
    les     bx, trackdata3
    mov     word ptr es:[bx+1Eh], 2
    les     bx, trackdata3
    mov     word ptr es:[bx+20h], 3
    les     bx, trackdata3
    mov     es:[bx+22h], si
    mov     oppnentSped, 0C8h ; 'È'
    sub     ax, ax
    push    ax
    mov     ax, trackpos+38h
    add     ax, 12Eh
    cwd
    mov     cl, 6
loc_1958C:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_1958C
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    mov     ax, 7700h
    mov     dx, 1
    push    dx
    push    ax
    mov     ax, dx
    push    ax
    mov     ax, offset simd_opponent
    push    ax
    mov     ax, offset state.opponentstate
    push    ax
    push    cs
    call near ptr init_carstate_from_simd
    add     sp, 14h
    mov     ax, offset state.field_3F9
    push    ax
    mov     al, state.opponentstate.field_CE
    inc     state.opponentstate.field_CE
    sub     ah, ah
    push    ax
    mov     ax, offset state.opponentstate.car_vec_unk3
    push    ax
    mov     bx, state.opponentstate.car_trackdata3_index
    shl     bx, 1
    les     di, trackdata3
    push    word ptr es:[bx+di]
    push    cs
    call near ptr sub_18D60
    add     sp, 8
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
init_plantrak endp
do_opponent_op proc far

    push    cs
    call near ptr opponent_op
    retf
    ; align 2
    db 144
do_opponent_op endp
update_crash_state proc far
    var_cState = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_someFlag = word ptr 6
    arg_MplayerFlag = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     ax, [bp+arg_MplayerFlag]
    or      ax, ax
    jz      short loc_195FC
    cmp     ax, 1
    jz      short loc_19612
    jmp     short loc_19601
loc_195FC:
    mov     [bp+var_cState], offset state.playerstate
loc_19601:
    mov     bx, [bp+var_cState]
    cmp     [bx+CARSTATE.car_crashBmpFlag], 0
    jz      short loc_1961A
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_19612:
    mov     [bp+var_cState], offset state.opponentstate
    jmp     short loc_19601
    ; align 2
    db 144
loc_1961A:
    mov     [bp+var_2], 0
    mov     ax, [bp+arg_someFlag]
    cmp     ax, 1
    jz      short loc_1967F
    cmp     ax, 2
    jnz     short loc_1962E
    jmp     loc_196DE
loc_1962E:
    cmp     ax, 3
    jnz     short loc_19636
    jmp     loc_19730
loc_19636:
    cmp     ax, 4
    jz      short loc_19642
    cmp     ax, 5
    jz      short loc_19676
    jmp     short loc_1964E
loc_19642:
    mov     state.game_frame_in_sec, 1
    mov     state.game_frames_per_sec, 1
loc_1964E:
    cmp     [bp+var_2], 0
    jz      short loc_19664
    mov     bx, [bp+var_cState]
    mov     [bx+CARSTATE.car_speed2], 0
    mov     bx, [bp+var_cState]
    mov     [bx+CARSTATE.car_speed], 0
loc_19664:
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_1966D
    jmp     loc_19760
loc_1966D:
    mov     ax, state.game_frame
    mov     state.game_oEndFrame, ax
    jmp     loc_19766
loc_19676:
    mov     [bp+arg_someFlag], 1
    mov     [bp+var_2], 1
loc_1967F:
    mov     bx, [bp+var_cState]
    mov     [bx+CARSTATE.car_crashBmpFlag], 1
    sub     ax, ax
    push    ax
    mov     bx, [bp+var_cState]
    push    [bx+CARSTATE.car_rotate.vx]
    push    [bp+arg_MplayerFlag]
    push    cs
    call near ptr state_op_unk
    add     sp, 6
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_196B3
    mov     bx, [bp+var_cState]
    mov     ax, [bx+CARSTATE.car_speed2]
    mov     state.game_impactSpeed, ax
    mov     ax, framespersec
    shl     ax, 1
    shl     ax, 1
    mov     state.game_frames_per_sec, ax
loc_196B3:
    cmp     is_in_replay, 0
    jnz     short loc_1964E
    cmp     byte_459D8, 0
    jz      short loc_1964E
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_196CE
    push    word_43964
    jmp     short loc_196D2
    ; align 2
    db 144
loc_196CE:
    push    word_4408C
loc_196D2:
    call    audio_function2_wrap
    add     sp, 2
    jmp     loc_1964E
    ; align 2
    db 144
loc_196DE:
    cmp     is_in_replay, 0
    jnz     short loc_19704
    cmp     byte_459D8, 0
    jz      short loc_19704
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_196F8
    push    word_43964
    jmp     short loc_196FC
loc_196F8:
    push    word_4408C
loc_196FC:
    call    audio_function2_wrap
    add     sp, 2
loc_19704:
    mov     bx, [bp+var_cState]
    mov     [bx+CARSTATE.car_crashBmpFlag], 2
    mov     [bp+var_2], 1
    cmp     [bp+arg_MplayerFlag], 0
    jz      short loc_19719
    jmp     loc_1964E
loc_19719:
    mov     bx, [bp+var_cState]
    mov     ax, [bx+CARSTATE.car_speed2]
    mov     state.game_impactSpeed, ax
    mov     ax, framespersec
    shl     ax, 1
    shl     ax, 1
loc_19729:
    mov     state.game_frames_per_sec, ax
    jmp     loc_1964E
    ; align 2
    db 144
loc_19730:
    mov     bx, [bp+var_cState]
    mov     [bx+CARSTATE.car_crashBmpFlag], 3
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_19752
    mov     ax, state.game_frame
    add     ax, state.game_penalty
    add     ax, elapsed_time1
    mov     state.game_total_finish, ax
    mov     ax, framespersec
    jmp     short loc_19729
    ; align 2
    db 144
loc_19752:
    mov     ax, state.game_frame
    add     ax, elapsed_time1
    mov     state.field_144, ax
    jmp     loc_1964E
    ; align 2
    db 144
loc_19760:
    mov     ax, state.game_frame
    mov     state.game_pEndFrame, ax
loc_19766:
    cmp     state.game_3F6autoLoadEvalFlag, 0
    jnz     short loc_19779
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_19779
    mov     al, byte ptr [bp+arg_someFlag]
    mov     state.game_3F6autoLoadEvalFlag, al
loc_19779:
    test    byte_43966, 4
    jnz     short loc_1978D
    mov     di, offset gState_travDist
    mov     si, offset state.game_travDist
    push    ds
    pop     es
    mov     cx, 0Bh
    repne movsw
loc_1978D:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
update_crash_state endp
plane_rotate_op proc far
    var_planptr = dword ptr -54
    var_32 = VECTOR ptr -50
    var_2C = MATRIX ptr -44
    var_1A = MATRIX ptr -26
    var_8 = VECTOR ptr -8
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 36h
    push    di
    push    si
    cmp     planindex_copy, 0FFFFh
    jnz     short loc_197A6
    jmp     loc_198C2
loc_197A6:
    mov     ax, 22h ; '"'
    imul    planindex_copy
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     word ptr [bp+var_planptr], ax
    mov     word ptr [bp+var_planptr+2], dx
    les     bx, [bp+var_planptr]
    mov     ax, pState_minusRotate_x_2
    cmp     es:[bx+PLANE.plane_xy], ax
    jnz     short loc_197D6
    mov     ax, pState_minusRotate_z_2
    cmp     es:[bx+PLANE.plane_yz], ax
    jnz     short loc_197D6
    mov     si, pState_minusRotate_y_2
    jmp     short loc_19845
    ; align 2
    db 144
loc_197D6:
    lea     ax, [bp+var_8]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    mov     ax, offset vec_unk2
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, 22h ; '"'
    imul    planindex_copy
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    add     ax, 10h         ; plane rotation matrix
    push    si
    lea     di, [bp+var_1A]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 9
    repne movsw
    pop     ds
    pop     si
    lea     ax, [bp+var_2C]
    push    ax
    lea     ax, [bp+var_1A]
    push    ax
    call    mat_invert
    add     sp, 4
loc_1981E:
    lea     ax, [bp+var_32]
    push    ax
    lea     ax, [bp+var_2C]
    push    ax
    lea     ax, [bp+var_8]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    [bp+var_32.vz]
    mov     ax, [bp+var_32.vx]
    neg     ax
    push    ax
    call    polarAngle
    add     sp, 4
    mov     si, ax
loc_19845:
    add     si, pState_f36Mminf40sar2
    jz      short loc_198A4
    cmp     word_3BE16, si
    jz      short loc_19866
    mov     ax, si
    neg     ax
    push    ax
    mov     ax, offset mat_planetmp
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     word_3BE16, si
loc_19866:
    lea     ax, [bp+var_32]
    push    ax
    mov     ax, offset mat_planetmp
    push    ax
    mov     ax, offset vec_unk2
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, offset vec_planerotopresult
    push    ax
    mov     ax, 22h ; '"'
    imul    planindex_copy
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    add     ax, 10h         ; plane rotation matrix.
    push    dx
    push    ax
    lea     ax, [bp+var_32]
loc_19895:
    push    ax
    push    cs
    call near ptr mat_mul_vector2
    add     sp, 8
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_198A4:
    mov     ax, offset vec_planerotopresult
    push    ax
    mov     ax, 22h         ; sizeof plane
    imul    planindex_copy
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    add     ax, 10h
    push    dx
    push    ax
    mov     ax, offset vec_unk2
    jmp     short loc_19895
    ; align 2
    db 144
loc_198C2:
    cmp     pState_f36Mminf40sar2, 0
    jz      short loc_1990C
    mov     ax, f36f40_whlData
    cmp     pState_f36Mminf40sar2, ax
    jz      short loc_198EA
    mov     ax, pState_f36Mminf40sar2
    neg     ax
    push    ax
    mov     ax, offset mat_unk2
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     ax, pState_f36Mminf40sar2
    mov     f36f40_whlData, ax
loc_198EA:
    lea     ax, [bp+var_32]
    push    ax
    mov     ax, offset mat_unk2
    push    ax
    mov     ax, offset vec_unk2
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, offset vec_planerotopresult
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+var_32]
    jmp     short loc_19917
    ; align 2
    db 144
loc_1990C:
    mov     ax, offset vec_planerotopresult
    push    ax
    mov     ax, offset mat_unk
    push    ax
    mov     ax, offset vec_unk2
loc_19917:
    push    ax
    call    mat_mul_vector
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
plane_rotate_op endp
plane_origin_op proc far
    var_10 = VECTOR ptr -16
    var_A = VECTOR ptr -10
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_planIndex = word ptr 6
    arg_2x = word ptr 8
    arg_4y = word ptr 10
    arg_6z = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 10h
    mov     ax, planindex
    cmp     [bp+arg_planIndex], ax
    jnz     short loc_1993E ; sizeof PLANE
    mov     ax, word ptr current_planptr
    mov     dx, word ptr current_planptr+2
    jmp     short loc_1994C
    ; align 2
    db 144
loc_1993E:
    mov     ax, 22h         ; sizeof PLANE
    imul    [bp+arg_planIndex]
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
loc_1994C:
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    les     bx, [bp+var_4]
    mov     ax, es:[bx+PLANE.plane_origin.vy]
    add     ax, terrainHeight
    mov     [bp+var_10.vy], ax
    mov     ax, [bp+arg_4y]
    sub     ax, [bp+var_10.vy]
    mov     [bp+var_A.vy], ax; y
    cmp     [bp+arg_planIndex], 4
    jl      short loc_199AE
    mov     ax, es:[bx+PLANE.plane_origin.vx]
    add     ax, elem_xCenter
    mov     [bp+var_10.vx], ax
    mov     ax, es:[bx+PLANE.plane_origin.vz]
    add     ax, elem_zCenter
    mov     [bp+var_10.vz], ax
    mov     ax, [bp+arg_2x]
    sub     ax, [bp+var_10.vx]
    mov     [bp+var_A.vx], ax; x
    mov     ax, [bp+arg_6z]
    sub     ax, [bp+var_10.vz]
    mov     [bp+var_A.vz], ax; z
    mov     ax, bx
    add     ax, PLANE.plane_normal
    push    dx
    push    ax
    push    [bp+var_A.vz]
    push    [bp+var_A.vy]
    push    [bp+var_A.vx]
    push    cs
    call near ptr vec_normalInnerProduct
    add     sp, 0Ah
loc_199AE:
    mov     sp, bp
    pop     bp
    retf
plane_origin_op endp
vec_normalInnerProduct proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0x = word ptr 6
    arg_2y = word ptr 8
    arg_4z = word ptr 10
    arg_normal = dword ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     ax, 2000h       ; length of normal vector => normalization
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_0x]
    cwd
    push    dx
    push    ax
    les     bx, [bp+arg_normal]
    mov     ax, es:[bx]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    mov     cx, ax
    mov     ax, [bp+arg_4z]
    mov     bx, dx
    cwd
    push    dx
    push    ax
    les     si, [bp+arg_normal]
    mov     ax, es:[si+4]
    cwd
    push    dx
    push    ax
    mov     si, cx
    mov     di, bx
    call    __aFlmul
    mov     cx, ax
    mov     ax, [bp+arg_2y]
    mov     bx, dx
    cwd
    push    dx
    push    ax
    mov     ax, bx
    les     bx, [bp+arg_normal]
    mov     dx, ax
    mov     ax, es:[bx+2]
    mov     [bp+var_4], cx  ; 1st multiplication lo-byte
    mov     [bp+var_2], dx  ; 1st multiplication hi-byte
    cwd
    push    dx
    push    ax
    call    __aFlmul
    add     ax, [bp+var_4]
    adc     dx, [bp+var_2]
    add     ax, si
    adc     dx, di
    push    dx
    push    ax
    call    __aFldiv        ; /2000h
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
vec_normalInnerProduct endp
state_op_unk proc far
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 18h
    push    di
    push    si
    cmp     [bp+arg_0], 2
    jge     short loc_19A5E
    mov     ax, [bp+arg_2]
    mov     [bp+var_6], ax
    mov     [bp+var_2], 400h
    mov     [bp+var_E], 12h
    mov     ax, [bp+arg_0]
    shl     ax, 1
    shl     ax, 1
    add     ax, 4
    mov     [bp+var_10], ax
    mov     [bp+var_8], 6
    jmp     short loc_19A7B
loc_19A5E:
    mov     ax, [bp+arg_2]
    sub     ax, 60h ; '`'
    mov     [bp+var_6], ax
    mov     [bp+var_2], 0C0h ; 'À'
    mov     [bp+var_E], 8
    mov     [bp+var_10], 0
    mov     [bp+var_8], 1
loc_19A7B:
    mov     state.field_42A, 1
    mov     [bp+var_12], 0
    sub     si, si
loc_19A87:
    mov     bx, si
    shl     bx, 1
    cmp     word ptr state.field_38E[bx], 0
    jnz     short loc_19A95
    inc     [bp+var_12]
loc_19A95:
    inc     si
    cmp     si, 18h
    jl      short loc_19A87
    mov     ax, [bp+var_E]
    cmp     [bp+var_12], ax
    jle     short loc_19AA6
    mov     [bp+var_12], ax
loc_19AA6:
    mov     [bp+var_C], 0
    sub     si, si
    jmp     short loc_19AB1
    ; align 2
    db 144
loc_19AB0:
    inc     si
loc_19AB1:
    cmp     si, 18h
    jl      short loc_19AB9
    jmp     loc_19B99
loc_19AB9:
    mov     ax, si
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, ax
    cmp     word ptr state.field_38E[bx], 0
    jnz     short loc_19AB0
    mov     al, byte ptr [bp+arg_0]
    mov     state.field_443[si], al
    mov     al, byte ptr [bp+var_C]
smart
    and     al, 3
nosmart
    add     al, byte ptr [bp+var_10]
    mov     state.field_42B[si], al
    mov     ax, si
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_16], ax
    mov     bx, ax
    sub     ax, ax
    mov     word ptr (state.game_longs1+2)[bx], ax
    mov     word ptr state.game_longs1[bx], ax
    mov     bx, [bp+var_16]
    mov     word ptr (state.game_longs2+2)[bx], ax
    mov     word ptr state.game_longs2[bx], ax
    mov     bx, [bp+var_16]
    mov     word ptr (state.game_longs3+2)[bx], ax
    mov     word ptr state.game_longs3[bx], ax
    call    get_kevinrandom
    shl     ax, 1
    shl     ax, 1
    mov     bx, [bp+var_14]
    mov     state.field_2FE[bx], ax
    call    get_kevinrandom
    shl     ax, 1
    shl     ax, 1
    mov     bx, si
    shl     bx, 1
    mov     state.field_32E[bx], ax
    mov     ax, [bp+var_12]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_C]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_2]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    add     ax, [bp+var_6]
smart
    and     ah, 3
nosmart
    mov     bx, si
    shl     bx, 1
    mov     state.field_35E[bx], ax
    call    get_kevinrandom
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    mov     cl, 2
    sar     di, cl
    add     di, [bp+arg_4]
    add     di, 180h
    mov     ax, si
    shl     ax, 1
    mov     [bp+var_18], ax
    mov     bx, ax
    mov     word ptr state.field_38E[bx], di
    mov     ax, [bp+var_8]
    imul    di
    sar     ax, 1
    sar     ax, 1
    mov     bx, [bp+var_18]
    mov     word ptr state.field_3BE[bx], ax
    inc     [bp+var_C]
    mov     ax, [bp+var_12]
    cmp     [bp+var_C], ax
    jz      short loc_19B99
    jmp     loc_19AB0
loc_19B99:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
state_op_unk endp
sub_19BA0 proc far
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_4 = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 14h
    push    di
    push    si
    mov     [bp+var_2], 0
    sub     si, si
    jmp     short loc_19BC3
loc_19BB0:
    mov     [bp+var_2], 1
    mov     di, si
    shl     di, 1
    add     state.field_2FE[di], 10h
    add     state.field_32E[di], 10h
loc_19BC2:
    inc     si
loc_19BC3:
    cmp     si, 18h
    jl      short loc_19BCB
    jmp     loc_19C96
loc_19BCB:
    mov     di, si
    shl     di, 1
    cmp     word ptr state.field_38E[di], 0
    jz      short loc_19BC2
    mov     ax, 1
    push    ax
loc_19BDA:
    push    state.field_35E[di]
    sub     ax, ax
    push    ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_4], ax
    mov     [bp+var_C], 0
    mov     [bp+var_A], 0
    mov     bx, si
loc_19BF9:
    shl     bx, 1
loc_19BFB:
    mov     ax, word ptr state.field_38E[bx]
    mov     [bp+var_8], ax
    lea     ax, [bp+var_12]
    push    ax
    push    [bp+var_4]
    lea     ax, [bp+var_C]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     di, si
    mov     cl, 2
    shl     di, cl
    mov     ax, [bp+var_12]
    cwd
    add     word ptr state.game_longs1[di], ax
    adc     word ptr (state.game_longs1+2)[di], dx
    mov     ax, [bp+var_E]
    cwd
    add     word ptr state.game_longs3[di], ax
    adc     word ptr (state.game_longs3+2)[di], dx
    mov     ax, si
    shl     ax, 1
    add     ax, offset state.field_3BE
    mov     [bp+var_14], ax
    mov     bx, ax
    sub     word ptr [bx], 13h
    mov     bx, [bp+var_14]
    mov     ax, [bx]
    cwd
    add     word ptr state.game_longs2[di], ax
    adc     word ptr (state.game_longs2+2)[di], dx
    cmp     framespersec, 0Ah
    jnz     short loc_19C6B
    mov     bx, [bp+var_14]
    sub     word ptr [bx], 13h
    mov     bx, [bp+var_14]
    mov     ax, [bx]
    cwd
    add     word ptr state.game_longs2[di], ax
    adc     word ptr (state.game_longs2+2)[di], dx
loc_19C6B:
    mov     bx, si
    shl     bx, 1
    shl     bx, 1
    mov     ax, word ptr state.game_longs2[bx]
    mov     dx, word ptr (state.game_longs2+2)[bx]
    add     ax, word ptr state.playerstate.car_posWorld1.ly
loc_19C7D:
    adc     dx, word ptr state.playerstate.car_posWorld1.ly+2
    or      dx, dx
    jl      short loc_19C88
    jmp     loc_19BB0
loc_19C88:
    mov     bx, si
    shl     bx, 1
    mov     word ptr state.field_38E[bx], 0
loc_19C92:
    jmp     loc_19BC2
    ; align 2
    db 144
loc_19C96:
    mov     al, [bp+var_2]
    mov     state.field_42A, al
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_19BA0 endp
setup_aero_trackdata proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_carresptr = dword ptr 6
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    cmp     [bp+arg_4], 0
    jz      short loc_19CB3
    jmp     loc_19D36
loc_19CB3:
    mov     ax, offset aSimd; "simd"
    push    ax
    push    word ptr [bp+arg_carresptr+2]
    push    word ptr [bp+arg_carresptr]
    call    locate_shape_alt
    add     sp, 6
    push    si
    mov     di, offset simd_player
    mov     si, ax
    push    ds
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 184h
    repne movsw
    pop     ds
    pop     si
    mov     ax, word ptr td04_aerotable_pl
    mov     dx, word ptr td04_aerotable_pl+2
    mov     word ptr simd_player.aerorestable, ax
    mov     word ptr simd_player.aerorestable+2, dx
    sub     si, si
loc_19CE7:
    mov     ax, si
    cwd
    push    dx
    push    ax
    cwd
    push    dx
    push    ax
    mov     ax, simd_player.aero_resistance
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFlmul
    mov     cl, 9
loc_19D03:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_19D03
    mov     bx, si
    shl     bx, 1
    les     di, td04_aerotable_pl
    mov     es:[bx+di], ax
    inc     si
    cmp     si, 40h ; '@'
    jl      short loc_19CE7
    mov     ax, offset aGnam; "gnam"
    push    ax
    push    word ptr [bp+arg_carresptr+2]
    push    word ptr [bp+arg_carresptr]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset gnam_string
    jmp     loc_19DB6
loc_19D36:
    mov     ax, offset aSimd_0; "simd"
    push    ax
    push    word ptr [bp+arg_carresptr+2]
    push    word ptr [bp+arg_carresptr]
    call    locate_shape_alt
    add     sp, 6
    push    si
    mov     di, offset simd_opponent
    mov     si, ax
    push    ds
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 184h
    repne movsw
    pop     ds
    pop     si
    mov     ax, word ptr td05_aerotable_op
    mov     dx, word ptr td05_aerotable_op+2
    mov     word ptr simd_opponent.aerorestable, ax
    mov     word ptr simd_opponent.aerorestable+2, dx
    sub     si, si
loc_19D6A:
    mov     ax, si
    cwd
    push    dx
    push    ax
    cwd
    push    dx
    push    ax
    mov     ax, simd_opponent.aero_resistance
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFlmul
    mov     cl, 9
loc_19D86:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_19D86
    mov     bx, si
    shl     bx, 1
    les     di, td05_aerotable_op
    mov     es:[bx+di], ax
    inc     si
    cmp     si, 40h ; '@'
    jl      short loc_19D6A
    mov     ax, offset aGsna; "gsna"
    push    ax
    push    word ptr [bp+arg_carresptr+2]
    push    word ptr [bp+arg_carresptr]
    call    locate_shape_alt
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset gsna_string
loc_19DB6:
    push    ax
    call    copy_string
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
setup_aero_trackdata endp
seg001 ends
end
