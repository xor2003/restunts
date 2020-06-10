.model medium
nosmart
    include structs.inc
    include custom.inc
    include seg000.inc
    include seg001.inc
    include seg002.inc
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
seg003 segment byte public 'STUNTSC' use16
    assume cs:seg003
    assume es:nothing, ss:nothing, ds:dseg
    public sub_19F14
    public init_rect_arrays
    public update_frame
    public skybox_op_helper2
    public skybox_op
    public transformed_shape_add_for_sort
    public draw_track_preview
    public draw_ingame_text
    public do_sinking
    public init_crak
    public load_skybox
    public unload_skybox
    public load_sdgame2_shapes
    public free_sdgame2
    public setup_intro
    public intro_op
loc_19F12:
    pop     ds
locret_19F13:
    retf
sub_19F14 proc far
    var_rectptr = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_rectptr = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    cmp     video_flag5_is0, 0
    jz      short loc_19F26
    jmp     loc_1A090
loc_19F26:
    call    sprite_copy_2_to_1_2
    cmp     byte_454A4, 0
    jz      short loc_19F35
    jmp     loc_1A046
loc_19F35:
    cmp     timertestflag_copy, 0
    jnz     short loc_19F3F
    jmp     loc_1A030
loc_19F3F:
    sub     si, si
loc_19F41:
    mov     rect_array_unk_indices[si], 3
    inc     si
    cmp     si, 0Fh
    jl      short loc_19F41
    cmp     timertestflag2, 4
    jnz     short loc_19F59
    mov     ax, word_463D6
    mov     word_449FE, ax
loc_19F59:
    mov     ax, word_463D6
    cmp     word_449FE, ax
    jnz     short loc_19F8B
    mov     ax, rect_array_unk2.rc_left+28h
    cmp     rect_array_unk.rc_left+28h, ax
    jnz     short loc_19F8B
    mov     ax, rect_array_unk2.rc_right+28h
    cmp     rect_array_unk.rc_right+28h, ax
    jnz     short loc_19F8B
    mov     ax, rect_array_unk2.rc_top+28h
    cmp     rect_array_unk.rc_top+28h, ax
    jnz     short loc_19F8B
    mov     ax, rect_array_unk2.rc_bottom+28h
    cmp     rect_array_unk.rc_bottom+28h, ax
    jnz     short loc_19F8B
    mov     rect_array_unk_indices+5, 0
loc_19F8B:
    mov     rect_array_unk3_length, 0
    mov     ax, offset rect_array_unk3
    push    ax
    mov     ax, offset rect_array_unk3_length
    push    ax
    push    [bp+arg_rectptr]
    mov     ax, offset rect_array_unk2
    push    ax
    mov     ax, offset rect_array_unk
    push    ax
    mov     ax, offset rect_array_unk_indices
    push    ax
    mov     ax, 0Fh         ; number of rects in the array
    push    ax
    call    rectlist_add_rects
    add     sp, 0Eh
    cmp     rect_array_unk3_length, 0
    jz      short loc_1A01E
    mov     ax, offset rect_array_unk3_indices
    push    ax
    mov     ax, offset rect_array_unk3
    push    ax
    mov     al, rect_array_unk3_length
    cbw
    push    ax
    call    rect_array_sort_by_top
    add     sp, 6
    call    mouse_draw_opaque_check
    sub     si, si
    jmp     short loc_1A013
loc_19FD8:
    mov     bx, si
    shl     bx, 1
    mov     ax, rect_array_unk3_indices[bx]
    mov     cl, 3
    shl     ax, cl
    add     ax, offset rect_array_unk3
    mov     [bp+var_rectptr], ax
    mov     bx, ax
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
    inc     si
loc_1A013:
    mov     al, rect_array_unk3_length
    cbw
    cmp     ax, si
    jg      short loc_19FD8
    jmp     short loc_1A05E
    ; align 2
    db 144
loc_1A01E:
    mov     bx, [bp+arg_rectptr]
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    jmp     short loc_1A03E
loc_1A030:
    mov     bx, [bp+arg_rectptr]
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
loc_1A03E:
    call    sprite_set_1_size
    add     sp, 8
loc_1A046:
    call    mouse_draw_opaque_check
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
loc_1A05E:
    call    mouse_draw_transparent_check
    cmp     timertestflag_copy, 0
    jz      short loc_1A090
    mov     ax, word_463D6
    mov     word_449FE, ax
    sub     si, si
loc_1A072:
    mov     di, si
    mov     cl, 3
    shl     di, cl
    push    si
    push    di
    lea     si, rect_array_unk.rc_left[di]
    lea     di, rect_array_unk2.rc_left[di]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
loc_1A088:
    pop     di
    pop     si
    inc     si
    cmp     si, 0Fh
    jl      short loc_1A072
loc_1A090:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_19F14 endp
init_rect_arrays proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    cmp     timertestflag_copy, 0
    jz      short loc_1A0EE
    push    si
    mov     di, offset rect_array_unk
    mov     si, offset rect_unk5
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     si
    push    si
    mov     di, offset rect_array_unk2
    mov     si, offset rect_unk5
    movsw
    movsw
    movsw
    movsw
    pop     si
    mov     si, 1
loc_1A0C2:
    mov     di, si
    mov     cl, 3
    shl     di, cl
    push    si
    push    di
    lea     di, rect_array_unk.rc_left[di]
    mov     si, offset cliprect_unk
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    push    si
    push    di
    lea     di, rect_array_unk2.rc_left[di]
    mov     si, offset cliprect_unk
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    inc     si
    cmp     si, 0Fh         ; there are 15 rects in the array
    jl      short loc_1A0C2
loc_1A0EE:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
init_rect_arrays endp
update_frame proc far
    var_lastpos2lookup = dword ptr -340
    var_lastposlookupw = word ptr -336
    var_transformresult = word ptr -334
    var_14C = byte ptr -332
    var_posadjust = byte ptr -308
    var_132 = word ptr -306
    var_130 = byte ptr -304
    var_trkobject_ptr = word ptr -302
    var_poslookupadjust = byte ptr -300
    var_12A = word ptr -298
    var_vec7 = VECTOR ptr -296
    var_122 = byte ptr -290
    var_mat = MATRIX ptr -288
    var_10E = word ptr -270
    terr_map_value = byte ptr -268
    var_pos2adjust = byte ptr -266
    var_108 = dword ptr -264
    var_stateptr = word ptr -260
    var_poslookup = byte ptr -258
    var_pos2lookupadjust = byte ptr -256
    var_angZ = word ptr -254
    var_FC = byte ptr -252
    var_angX = word ptr -250
    var_pos2lookup = byte ptr -246
    var_angY2 = word ptr -244
    var_vec6 = VECTOR ptr -242
    var_vec5 = VECTOR ptr -236
    var_E4 = byte ptr -228
    var_E2 = byte ptr -226
    var_E0 = word ptr -224
    var_multitileflag = word ptr -222
    var_DC = byte ptr -220
    var_DA = word ptr -218
    var_D8 = byte ptr -216
    var_matptr = word ptr -214
    var_postab = byte ptr -212
    var_BC = byte ptr -188
    var_A4 = word ptr -164
    var_counter2 = word ptr -162
    var_mat2 = MATRIX ptr -160
    var_rect2 = RECTANGLE ptr -142
    var_pos2tab = byte ptr -134
    var_6E = byte ptr -110
    var_6C = word ptr -108
    var_rect = RECTANGLE ptr -106
    elem_map_value = byte ptr -98
    var_60 = byte ptr -96
    var_5E = word ptr -94
    var_angY = word ptr -92
    var_angZ2 = word ptr -90
    var_vec4 = VECTOR ptr -88
    var_52 = word ptr -82
    var_50 = word ptr -80
    var_4E = byte ptr -78
    var_4C = byte ptr -76
    var_4A = byte ptr -74
    var_hillheight = word ptr -72
    var_angX2 = word ptr -70
    var_vec8 = VECTOR ptr -68
    var_rectptr = word ptr -62
    var_3C = byte ptr -60
    var_3A = word ptr -58
    var_38 = word ptr -56
    var_counter = word ptr -54
    var_trkobjectptr = word ptr -52
    var_32 = byte ptr -50
    var_1A = byte ptr -26
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6
    arg_cliprectptr = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 154h
    push    di
    push    si
    mov     [bp+var_DC], 0
    mov     [bp+var_DC+1], 0
    cmp     video_flag5_is0, 0
    jz      short loc_1A122
    cmp     [bp+arg_0], 0
    jz      short loc_1A122
    mov     rectptr_unk2, offset rect_array_unk
    mov     rectptr_unk, offset rect_array_unk2
    jmp     short loc_1A12E
loc_1A122:
    mov     rectptr_unk, offset rect_array_unk
    mov     rectptr_unk2, offset rect_array_unk2
loc_1A12E:
    cmp     timertestflag_copy, 0
    jz      short loc_1A162
    mov     [bp+var_122], 8
    mov     [bp+var_rectptr], offset rect_unk
    sub     si, si
    jmp     short loc_1A145
    ; align 2
    db 144
loc_1A144:
    inc     si
loc_1A145:
    cmp     si, 0Fh
    jge     short loc_1A167
    mov     ax, [bp+var_rectptr]
    add     [bp+var_rectptr], 8
    push    si
    push    di
    mov     di, ax
    mov     si, offset cliprect_unk
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    jmp     short loc_1A144
loc_1A162:
    mov     [bp+var_122], 0
loc_1A167:
    cmp     followOpponentFlag, 0
    jnz     short loc_1A1BE
    mov     ax, word ptr state.playerstate.car_posWorld1.lx
    mov     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1A177:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1A177
    mov     [bp+var_vec5.vx], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.ly
    mov     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1A18C:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1A18C
    mov     [bp+var_vec5.vy], ax
    mov     ax, word ptr state.playerstate.car_posWorld1.lz
    mov     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1A1A1:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1A1A1
    mov     [bp+var_vec5.vz], ax
    mov     ax, state.playerstate.car_rotate.vy
    mov     [bp+var_angX2], ax
    mov     ax, state.playerstate.car_rotate.vz
    mov     [bp+var_angZ2], ax
    mov     ax, state.playerstate.car_rotate.vx
    jmp     short loc_1A20C
loc_1A1BE:
    mov     ax, word ptr state.opponentstate.car_posWorld1.lx
    mov     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1A1C7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1A1C7
    mov     [bp+var_vec5.vx], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.ly
    mov     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1A1DC:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1A1DC
    mov     [bp+var_vec5.vy], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.lz
    mov     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1A1F1:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1A1F1
    mov     [bp+var_vec5.vz], ax
    mov     ax, state.opponentstate.car_rotate.vy
    mov     [bp+var_angX2], ax
    mov     ax, state.opponentstate.car_rotate.vz
    mov     [bp+var_angZ2], ax
    mov     ax, state.opponentstate.car_rotate.vx
loc_1A20C:
    mov     [bp+var_angY2], ax
    mov     [bp+var_angY], 0FFFFh
    mov     [bp+var_E0], 0
    mov     al, cameramode
    cbw
    or      ax, ax
    jnz     short loc_1A226
    jmp     loc_1A434
loc_1A226:
    cmp     ax, 1
    jnz     short loc_1A22E
    jmp     loc_1A40A
loc_1A22E:
    cmp     ax, 2
    jz      short loc_1A23E
    cmp     ax, 3
    jnz     short loc_1A23B
    jmp     loc_1A48E
loc_1A23B:
    jmp     loc_1A303
loc_1A23E:
    mov     [bp+var_vec6.vx], 0
    mov     [bp+var_vec6.vy], 0
    mov     [bp+var_vec6.vz], 4000h
    sub     ax, ax
    push    ax
    mov     ax, [bp+var_angY2]
    neg     ax
    push    ax
    mov     ax, [bp+var_angX2]
    neg     ax
    push    ax
    mov     ax, [bp+var_angZ2]
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
    lea     ax, [bp+var_vec7]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    [bp+var_vec7.vz]
    push    [bp+var_vec7.vx]
    call    polarAngle
    add     sp, 4
    mov     si, ax
    mov     [bp+var_vec6.vx], 0
    mov     [bp+var_vec6.vy], 0
    mov     ax, word_3B8EC
    mov     [bp+var_vec6.vz], ax
    sub     ax, ax
    push    ax
    mov     ax, si
    sub     ax, word_3B8EE
    push    ax
    mov     ax, word_3B8F0
    neg     ax
    push    ax
    sub     ax, ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
loc_1A2CC:
    lea     ax, [bp+var_vec7]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+var_vec5.vx]
    add     ax, [bp+var_vec7.vx]
    mov     [bp+var_vec4.vx], ax
    mov     ax, [bp+var_vec5.vy]
    add     ax, [bp+var_vec7.vy]
    mov     [bp+var_vec4.vy], ax
    mov     ax, [bp+var_vec5.vz]
    add     ax, [bp+var_vec7.vz]
loc_1A300:
    mov     [bp+var_vec4.vz], ax
loc_1A303:
    cmp     [bp+var_angY], 0FFFFh
    jz      short loc_1A30C
    jmp     loc_1A3E9
loc_1A30C:
    lea     ax, [bp+var_vec4]
    push    ax
    lea     ax, [bp+var_vec4]
    push    ax
    call    build_track_object
    add     sp, 4
    mov     ax, terrainHeight
    cmp     [bp+var_vec4.vy], ax
    jge     short loc_1A327
    mov     [bp+var_vec4.vy], ax
loc_1A327:
    cmp     byte_4392C, 0
    jz      short loc_1A393
    push    [bp+var_vec4.vz]
    push    [bp+var_vec4.vy]
    push    [bp+var_vec4.vx]
    push    planindex
    call    plane_origin_op
    add     sp, 8
    mov     si, ax
    cmp     si, 0Ch
    jge     short loc_1A393
    mov     vec_unk2.vx, 0
    mov     ax, 0Ch
    sub     ax, si
    mov     vec_unk2.vy, ax
    mov     vec_unk2.vz, 0
    mov     ax, planindex
    mov     planindex_copy, ax
    mov     pState_f36Mminf40sar2, 0
    mov     pState_minusRotate_x_2, 0
    mov     pState_minusRotate_z_2, 0
    mov     pState_minusRotate_y_2, 0
    call    plane_rotate_op
    mov     ax, vec_planerotopresult.vx
    add     [bp+var_vec4.vx], ax
    mov     ax, vec_planerotopresult.vy
    add     [bp+var_vec4.vy], ax
    mov     ax, vec_planerotopresult.vz
    add     [bp+var_vec4.vz], ax
loc_1A393:
    mov     ax, [bp+var_vec5.vz]
    sub     ax, [bp+var_vec4.vz]
    push    ax
    mov     ax, [bp+var_vec5.vx]
    sub     ax, [bp+var_vec4.vx]
    push    ax
    call    polarAngle
    add     sp, 4
    neg     ax
smart
    and     ah, 3
nosmart
    mov     [bp+var_angY], ax
    mov     ax, [bp+var_vec5.vz]
    sub     ax, [bp+var_vec4.vz]
    push    ax
    mov     ax, [bp+var_vec5.vx]
    sub     ax, [bp+var_vec4.vx]
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_38], ax
    push    ax
    mov     ax, [bp+var_vec5.vy]
    sub     ax, [bp+var_vec4.vy]
    add     ax, 32h ; '2'
    push    ax
    call    polarAngle
    add     sp, 4
smart
    and     ah, 3
nosmart
    mov     [bp+var_angX], ax
loc_1A3E9:
    cmp     [bp+var_E0], 1
    jg      short loc_1A3F3
    jmp     loc_1A4D0
loc_1A3F3:
    cmp     [bp+var_E0], 3FFh
    jl      short loc_1A3FE
    jmp     loc_1A4D0
loc_1A3FE:
    mov     ax, [bp+var_E0]
    mov     [bp+var_angZ], ax
    jmp     loc_1A4D6
    ; align 2
    db 144
loc_1A40A:
    mov     al, followOpponentFlag
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_lastposlookupw], ax
    mov     bx, ax
    mov     ax, state.game_vec1.vx[bx]
    mov     [bp+var_vec4.vx], ax
    mov     ax, state.game_vec1.vz[bx]
    mov     [bp+var_vec4.vz], ax
    mov     ax, state.game_vec1.vy[bx]
    mov     [bp+var_vec4.vy], ax
    jmp     loc_1A303
loc_1A434:
    mov     ax, [bp+var_angY2]
smart
    and     ah, 3
nosmart
    mov     [bp+var_angY], ax
    mov     ax, [bp+var_angX2]
smart
    and     ah, 3
nosmart
    mov     [bp+var_angX], ax
    mov     ax, [bp+var_angZ2]
smart
    and     ah, 3
nosmart
    mov     [bp+var_E0], ax
    sub     ax, ax
    push    ax
    mov     ax, [bp+var_angY2]
    neg     ax
    push    ax
    mov     ax, [bp+var_angX2]
    neg     ax
    push    ax
    mov     ax, [bp+var_angZ2]
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
    mov     [bp+var_vec6.vx], 0
    mov     [bp+var_vec6.vz], 0
    mov     ax, simd_player.car_height
    sub     ax, 6
    mov     [bp+var_vec6.vy], ax
    jmp     loc_1A2CC
    ; align 2
    db 144
loc_1A48E:
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
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     word ptr [bp+var_lastpos2lookup+2], dx
    les     bx, [bp+var_lastpos2lookup]
    mov     ax, es:[bx]
    mov     [bp+var_vec4.vx], ax
    mov     ax, es:[bx+2]
    add     ax, word_44D20
    add     ax, 5Ah ; 'Z'
    mov     [bp+var_vec4.vy], ax
    mov     ax, es:[bx+4]
    jmp     loc_1A300
loc_1A4D0:
    mov     [bp+var_angZ], 0
loc_1A4D6:
    cmp     state.game_frame, 0
    jnz     short loc_1A4E4
    mov     bx, word_46468
    jmp     short loc_1A4E8
    ; align 2
    db 144
loc_1A4E4:
    mov     bx, state.game_frame
loc_1A4E8:
smart
    and     bx, 0Fh
nosmart
    mov     al, byte_3C0C6[bx]
    mov     [bp+var_E4], al
    sub     ax, ax
    push    ax
    push    [bp+arg_cliprectptr]
    push    [bp+var_angY]
    push    [bp+var_angX]
    push    [bp+var_angZ]
    call    select_cliprect_rotate
    add     sp, 0Ah
    mov     [bp+var_52], ax
smart
    and     ah, 3
nosmart
loc_1A512:
    mov     cl, 7
    shr     ax, cl
    mov     si, ax
    mov     bx, si
    shl     bx, 1
    mov     ax, off_3C084[bx]
    mov     [bp+var_50], ax
    mov     ax, 1
    push    ax
    sub     ax, ax
    push    ax
    push    [bp+var_angX]
    push    [bp+var_angZ]
    call    mat_rot_zxy
    add     sp, 8
    push    si
    push    di
    lea     di, [bp+var_mat]
    mov     si, ax
    push    ss
    pop     es
    mov     cx, 9
    repne movsw
    pop     di
    pop     si
    mov     [bp+var_vec6.vx], 0
    mov     [bp+var_vec6.vy], 0
    mov     [bp+var_vec6.vz], 3E8h
    lea     ax, [bp+var_vec8]
    push    ax
    lea     ax, [bp+var_mat]
    push    ax
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_vec8.vz], 0
    jle     short loc_1A580
    mov     [bp+var_2], 1
    jmp     short loc_1A585
loc_1A580:
    mov     [bp+var_2], 0FFFFh
loc_1A585:
    cmp     timertestflag2, 0
    jz      short loc_1A58F
    jmp     loc_1A66D
loc_1A58F:
    mov     currenttransshape.ts_rectptr, offset rect_unk9
    mov     al, [bp+var_122]
    or      al, 7
    mov     currenttransshape.ts_flags, al
    mov     currenttransshape.ts_rotvec.vx, 0
loc_1A5A4:
    mov     currenttransshape.ts_rotvec.vy, 0
    mov     currenttransshape.ts_unk, 400h
    mov     currenttransshape.ts_material, 0
    mov     [bp+var_counter], 0
loc_1A5BA:
    mov     bx, [bp+var_counter]
    shl     bx, 1
    mov     si, word_3BE34[bx]
    add     si, [bp+var_angY]
    add     si, run_game_random
smart
    and     si, 3FFh
nosmart
    cmp     si, 87h ; '‡'
    jl      short loc_1A5DD
    cmp     si, 379h
    jg      short loc_1A5DD
    jmp     loc_1A661
loc_1A5DD:
    push    si
    lea     ax, [bp+var_mat2]
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     [bp+var_vec6.vx], 0
    mov     ax, 0AE6h
    sub     ax, [bp+var_vec4.vy]
    mov     [bp+var_vec6.vy], ax
    mov     [bp+var_vec6.vz], 3A98h; 15000
    lea     ax, [bp+var_vec7]
    push    ax
    lea     ax, [bp+var_mat2]
    push    ax
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     [bp+var_vec7.vz], 3A98h; 15000
    mov     ax, offset currenttransshape
    push    ax
    lea     ax, [bp+var_mat]
    push    ax
    lea     ax, [bp+var_vec7]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     currenttransshape.ts_pos.vz, 0C8h ; 'È'
    jle     short loc_1A661
    mov     bx, [bp+var_counter]
    shl     bx, 1
    mov     ax, off_3BE44[bx]
    mov     currenttransshape.ts_shapeptr, ax
    mov     ax, [bp+var_angY]
    neg     ax
    mov     currenttransshape.ts_rotvec.vz, ax
    mov     ax, offset currenttransshape
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
loc_1A661:
    inc     [bp+var_counter]
    cmp     [bp+var_counter], 8
    jge     short loc_1A66D
    jmp     loc_1A5BA
loc_1A66D:
    mov     ax, [bp+var_vec4.vx]
    mov     cl, 0Ah
    sar     ax, cl
    mov     [bp+var_pos2adjust], al
    mov     ax, [bp+var_vec4.vz]
    sar     ax, cl
    sub     al, 1Dh
    neg     al
    mov     [bp+var_posadjust], al
    cmp     timertestflag2, 0
    jz      short loc_1A69D
    mov     al, byte ptr state.playerstate.car_posWorld1.lx+2
    mov     [bp+var_D8], al
    mov     al, 1Dh
    sub     al, byte ptr state.playerstate.car_posWorld1.lz+2
    mov     [bp+var_E2], al
loc_1A69D:
    sub     si, si
loc_1A69F:
    mov     [bp+si+var_32], 0
    inc     si
    cmp     si, 17h
    jl      short loc_1A69F
    mov     bl, timertestflag2
    sub     bh, bh
    mov     al, byte_3C09C[bx]
    mov     [bp+var_130], al
    mov     si, 16h
    jmp     short loc_1A6FF
loc_1A6BC:
    mov     ax, [bp+var_50]
    mov     cx, si
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    add     ax, cx
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    mov     al, [bx]
    add     al, [bp+var_pos2adjust]
    mov     [bp+var_pos2lookup], al
    mov     al, [bx+1]
    add     al, [bp+var_posadjust]
    mov     [bp+var_poslookup], al
    cmp     [bp+var_pos2lookup], 0
    jl      short loc_1A6FA
    cmp     [bp+var_pos2lookup], 1Dh
    jg      short loc_1A6FA
    or      al, al
    jl      short loc_1A6FA
    cmp     al, 1Dh
    jle     short loc_1A724
loc_1A6FA:
    mov     [bp+si+var_32], 2
loc_1A6FE:
    dec     si
loc_1A6FF:
    or      si, si
    jge     short loc_1A706
    jmp     loc_1A9C8
loc_1A706:
    cmp     [bp+si+var_32], 0
    jnz     short loc_1A6FE
    mov     bx, [bp+var_50]
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    add     bx, ax
    mov     al, [bp+var_130]
    cmp     [bx+2], al
    jle     short loc_1A6BC
    jmp     short loc_1A6FA
loc_1A724:
    mov     al, [bp+var_pos2lookup]
    cbw
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     al, [bp+var_poslookup]
    cbw
    shl     ax, 1
    mov     [bp+var_lastposlookupw], ax
    mov     bx, ax
    mov     bx, trackrows[bx]
    add     bx, word ptr [bp+var_lastpos2lookup]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+elem_map_value], al
    mov     bx, [bp+var_lastposlookupw]
    mov     bx, terrainrows[bx]
    add     bx, word ptr [bp+var_lastpos2lookup]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+terr_map_value], al
    cmp     [bp+elem_map_value], 0
    jnz     short loc_1A774
    jmp     loc_1A7FF
loc_1A774:
    cmp     al, 7
    jb      short loc_1A797
    cmp     al, 0Bh
    jnb     short loc_1A797
    mov     al, [bp+elem_map_value]
    sub     ah, ah
    push    ax
    mov     al, [bp+terr_map_value]
    push    ax
    call    subst_hillroad_track
    add     sp, 4
    mov     [bp+elem_map_value], al
    mov     [bp+terr_map_value], 0
loc_1A797:
    mov     al, [bp+elem_map_value]
    sub     ah, ah
    cmp     ax, 0FDh ; 'ý'
    jz      short loc_1A7B0
    cmp     ax, 0FEh ; 'þ'
    jz      short loc_1A7B4
    cmp     ax, 0FFh
    jnz     short loc_1A7AE
    jmp     loc_1A8CA
loc_1A7AE:
    jmp     short loc_1A7FF
loc_1A7B0:
    dec     [bp+var_pos2lookup]
loc_1A7B4:
    dec     [bp+var_poslookup]
loc_1A7B8:
    mov     al, [bp+var_pos2lookup]
    cbw
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     al, [bp+var_poslookup]
    cbw
    shl     ax, 1
    mov     [bp+var_lastposlookupw], ax
    mov     bx, ax
    mov     bx, trackrows[bx]
    add     bx, word ptr [bp+var_lastpos2lookup]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+elem_map_value], al
    mov     bx, [bp+var_lastposlookupw]
    mov     bx, terrainrows[bx]
    add     bx, word ptr [bp+var_lastpos2lookup]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+terr_map_value], al
loc_1A7FF:
    mov     al, [bp+terr_map_value]
    mov     [bp+si+var_1A], al
    mov     bx, [bp+var_50]
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    add     bx, ax
    mov     al, [bx+2]
    mov     [bp+si+var_BC], al
    cmp     [bp+elem_map_value], 0
    jz      short loc_1A857
    cmp     timertestflag2, 0
    jz      short loc_1A857
    mov     al, [bp+elem_map_value]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    cmp     trkObjectList.ss_physicalModel[bx], 40h ; '@'
    jl      short loc_1A857
    mov     al, [bp+var_D8]
    cmp     [bp+var_pos2lookup], al
    jnz     short loc_1A853
    mov     al, [bp+var_E2]
    cmp     [bp+var_poslookup], al
    jz      short loc_1A857
loc_1A853:
    mov     [bp+elem_map_value], 0
loc_1A857:
    mov     al, [bp+var_pos2lookup]
    mov     [bp+si+var_pos2tab], al
    mov     al, [bp+var_poslookup]
    mov     [bp+si+var_postab], al
    mov     al, [bp+elem_map_value]
    mov     [bp+si+var_14C], al
    cmp     [bp+elem_map_value], 0
    jnz     short loc_1A877
    jmp     loc_1A6FE
loc_1A877:
    mov     al, [bp+elem_map_value]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     al, trkObjectList.ss_multiTileFlag[bx]
    cbw
    mov     [bp+var_multitileflag], ax
    or      ax, ax
    jnz     short loc_1A898
    jmp     loc_1A6FE
loc_1A898:
    mov     al, [bp+var_pos2lookup]
    sub     al, [bp+var_pos2adjust]
    mov     [bp+var_pos2lookupadjust], al
    mov     al, [bp+var_poslookup]
    sub     al, [bp+var_posadjust]
    mov     [bp+var_poslookupadjust], al
    mov     ax, [bp+var_multitileflag]
    cmp     ax, 1
    jz      short loc_1A8D2
    cmp     ax, 2
    jz      short loc_1A914
    cmp     ax, 3
    jnz     short loc_1A8C6
    jmp     loc_1A960
loc_1A8C6:
    jmp     loc_1A6FE
    ; align 2
    db 144
loc_1A8CA:
    dec     [bp+var_pos2lookup]
    jmp     loc_1A7B8
    ; align 2
    db 144
loc_1A8D2:
    sub     di, di
    jmp     short loc_1A8D7
loc_1A8D6:
    inc     di
loc_1A8D7:
    cmp     di, si
    jl      short loc_1A8DE
    jmp     loc_1A6FE
loc_1A8DE:
    mov     ax, [bp+var_50]
    mov     cx, di
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    add     ax, cx
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    mov     al, [bp+var_pos2lookupadjust]
    cmp     [bx], al
    jnz     short loc_1A8D6
    mov     al, [bp+var_poslookupadjust]
    cmp     [bx+1], al
    jz      short loc_1A90E
    cbw
    inc     ax
    mov     cx, ax
    mov     al, [bx+1]
    cbw
    cmp     ax, cx
    jnz     short loc_1A8D6
loc_1A90E:
    mov     [bp+di+var_32], 1
    jmp     short loc_1A8D6
loc_1A914:
    sub     di, di
    jmp     short loc_1A919
loc_1A918:
    inc     di
loc_1A919:
    cmp     di, si
    jl      short loc_1A920
    jmp     loc_1A6FE
loc_1A920:
    mov     ax, [bp+var_50]
    mov     cx, di
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    add     ax, cx
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    mov     al, [bp+var_poslookupadjust]
    cmp     [bx+1], al
    jnz     short loc_1A918
    mov     al, [bx]
    mov     byte ptr [bp+var_lastposlookupw], al
    mov     al, [bp+var_pos2lookupadjust]
    cmp     byte ptr [bp+var_lastposlookupw], al
    jz      short loc_1A959
    cbw
    inc     ax
    mov     cx, ax
    mov     al, byte ptr [bp+var_lastposlookupw]
    cbw
    cmp     cx, ax
    jnz     short loc_1A918
loc_1A959:
    mov     [bp+di+var_32], 1
    jmp     short loc_1A918
    ; align 2
    db 144
loc_1A960:
    sub     di, di
    jmp     short loc_1A965
loc_1A964:
    inc     di
loc_1A965:
    cmp     di, si
    jl      short loc_1A96C
    jmp     loc_1A6FE
loc_1A96C:
    mov     bx, [bp+var_50]
    mov     ax, di
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    add     bx, ax
    mov     al, [bx]
    mov     byte ptr [bp+var_lastpos2lookup], al
    mov     al, [bp+var_pos2lookupadjust]
    cmp     byte ptr [bp+var_lastpos2lookup], al
    jz      short loc_1A996
    cbw
    inc     ax
    mov     cx, ax
    mov     al, byte ptr [bp+var_lastpos2lookup]
    cbw
    cmp     cx, ax
    jnz     short loc_1A964
loc_1A996:
    mov     bx, [bp+var_50]
    mov     ax, di
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    add     bx, ax
    mov     al, [bx+1]
    mov     byte ptr [bp+var_lastpos2lookup], al
    mov     al, [bp+var_poslookupadjust]
    cmp     byte ptr [bp+var_lastpos2lookup], al
    jz      short loc_1A9C1
    cbw
    inc     ax
    mov     cx, ax
    mov     al, byte ptr [bp+var_lastpos2lookup]
    cbw
    cmp     cx, ax
    jnz     short loc_1A964
loc_1A9C1:
    mov     [bp+di+var_32], 1
    jmp     short loc_1A964
    ; align 2
    db 144
loc_1A9C8:
    mov     [bp+var_3C], 0FFh
    mov     [bp+var_6C], 0
    cmp     cameramode, 0
    jnz     short loc_1A9E2
    cmp     followOpponentFlag, 0
    jnz     short loc_1A9E2
    jmp     loc_1AB65
loc_1A9E2:
    cmp     state.playerstate.car_crashBmpFlag, 2
    jnz     short loc_1A9EC
    jmp     loc_1AB65
loc_1A9EC:
    sub     ax, ax
    push    ax
    mov     ax, state.playerstate.car_rotate.vx
    neg     ax
    push    ax
    mov     ax, state.playerstate.car_rotate.vy
    neg     ax
    push    ax
    mov     ax, state.playerstate.car_rotate.vz
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
    mov     [bp+var_multitileflag], 0FFFFh
    mov     di, 0FFFFh
    mov     [bp+var_counter2], 0
    jmp     short loc_1AA8C
loc_1AA1E:
    dec     si
loc_1AA1F:
    cmp     [bp+var_multitileflag], si
    jge     short loc_1AA88
    cmp     [bp+si+var_32], 2
    jz      short loc_1AA1E
    mov     ax, [bp+var_50]
    mov     cx, si
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    add     ax, cx
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     al, [bp+var_pos2adjust]
    cbw
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     cx, ax
    mov     al, [bx]
    cbw
    add     ax, cx
    mov     cx, ax
    mov     al, [bp+var_pos2lookup]
    cbw
    cmp     cx, ax
    jnz     short loc_1AA1E
    mov     al, [bp+var_posadjust]
    cbw
    mov     cx, ax
    mov     al, [bx+1]
    cbw
    add     ax, cx
    mov     cx, ax
    mov     al, [bp+var_poslookup]
    cbw
    cmp     cx, ax
    jnz     short loc_1AA1E
    mov     al, [bp+var_pos2lookup]
    mov     [bp+var_3C], al
    mov     al, [bp+var_poslookup]
    mov     [bp+var_60], al
    mov     [bp+var_multitileflag], si
    mov     di, [bp+var_counter2]
    jmp     short loc_1AA1E
    ; align 2
    db 144
loc_1AA88:
    inc     [bp+var_counter2]
loc_1AA8C:
    cmp     [bp+var_counter2], 4
    jge     short loc_1AAF4
    mov     bx, [bp+var_counter2]
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    push    si
    push    di
    lea     di, [bp+var_vec6]
    lea     si, simd_player.wheel_coords.vx[bx]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    lea     ax, [bp+var_vec8]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector  ; rotating car wheels, maybe?
    add     sp, 6
    mov     ax, [bp+var_vec8.vx]
    cwd
    add     ax, word ptr state.playerstate.car_posWorld1.lx
    adc     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     ax, dx
    mov     [bp+var_pos2lookup], al
    mov     ax, [bp+var_vec8.vz]
    cwd
    add     ax, word ptr state.playerstate.car_posWorld1.lz
    adc     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     ax, dx
    sub     al, 1Dh
    neg     al
    mov     [bp+var_poslookup], al
    mov     si, 16h
    jmp     loc_1AA1F
    ; align 2
    db 144
loc_1AAF4:
    cmp     di, 0FFFFh
    jz      short loc_1AB65
    cmp     state.playerstate.car_surfaceWhl, 4
    jnz     short loc_1AB15
    cmp     state.playerstate.car_surfaceWhl+1, 4
    jnz     short loc_1AB15
    cmp     state.playerstate.car_surfaceWhl+2, 4
    jnz     short loc_1AB15
    cmp     state.playerstate.car_surfaceWhl+3, 4
    jz      short loc_1AB65
loc_1AB15:
    mov     [bp+var_vec6.vx], 0
    mov     [bp+var_vec6.vz], 0
    mov     [bp+var_vec6.vy], 7530h
    lea     ax, [bp+var_vec8]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    lea     ax, [bp+var_vec6]
    push    ax
    mov     ax, offset mat_temp
    push    ax
    lea     ax, [bp+var_vec8]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_vec6.vz], 0
    jg      short loc_1AB60
    mov     [bp+var_6C], 0F800h
    jmp     short loc_1AB65
    ; align 2
    db 144
loc_1AB60:
    mov     [bp+var_6C], 800h
loc_1AB65:
    mov     [bp+var_4A], 0FFh
    mov     [bp+var_A4], 0
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_1AB79
    jmp     loc_1AD0E
loc_1AB79:
    cmp     cameramode, 0
    jnz     short loc_1AB8A
    cmp     followOpponentFlag, 0
    jz      short loc_1AB8A
    jmp     loc_1AD0E
loc_1AB8A:
    cmp     state.opponentstate.car_crashBmpFlag, 2
    jnz     short loc_1AB94
    jmp     loc_1AD0E
loc_1AB94:
    sub     ax, ax
    push    ax
    mov     ax, state.opponentstate.car_rotate.vx
    neg     ax
    push    ax
    mov     ax, state.opponentstate.car_rotate.vy
    neg     ax
    push    ax
    mov     ax, state.opponentstate.car_rotate.vz
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
    mov     [bp+var_multitileflag], 0FFFFh
    mov     di, 0FFFFh
    mov     [bp+var_counter2], 0
    jmp     short loc_1AC34
loc_1ABC6:
    dec     si
loc_1ABC7:
    cmp     [bp+var_multitileflag], si
    jge     short loc_1AC30
    cmp     [bp+si+var_32], 2
    jz      short loc_1ABC6
    mov     ax, [bp+var_50]
    mov     cx, si
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    add     ax, cx
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     al, [bp+var_pos2adjust]
    cbw
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     cx, ax
    mov     al, [bx]
    cbw
    add     ax, cx
    mov     cx, ax
    mov     al, [bp+var_pos2lookup]
    cbw
    cmp     cx, ax
    jnz     short loc_1ABC6
    mov     al, [bp+var_posadjust]
    cbw
    mov     cx, ax
    mov     al, [bx+1]
    cbw
    add     ax, cx
    mov     cx, ax
    mov     al, [bp+var_poslookup]
    cbw
    cmp     cx, ax
    jnz     short loc_1ABC6
    mov     al, [bp+var_pos2lookup]
    mov     [bp+var_4A], al
    mov     al, [bp+var_poslookup]
    mov     [bp+var_6E], al
    mov     [bp+var_multitileflag], si
    mov     di, [bp+var_counter2]
    jmp     short loc_1ABC6
    ; align 2
    db 144
loc_1AC30:
    inc     [bp+var_counter2]
loc_1AC34:
    cmp     [bp+var_counter2], 4
    jge     short loc_1AC9C
    mov     bx, [bp+var_counter2]
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    push    si
    push    di
    lea     di, [bp+var_vec6]
    lea     si, simd_opponent.wheel_coords.vx[bx]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    lea     ax, [bp+var_vec8]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+var_vec8.vx]
    cwd
    add     ax, word ptr state.opponentstate.car_posWorld1.lx
    adc     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     ax, dx
    mov     [bp+var_pos2lookup], al
    mov     ax, [bp+var_vec8.vz]
    cwd
    add     ax, word ptr state.opponentstate.car_posWorld1.lz
    adc     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     ax, dx
    sub     al, 1Dh
    neg     al
    mov     [bp+var_poslookup], al
    mov     si, 16h
    jmp     loc_1ABC7
    ; align 2
    db 144
loc_1AC9C:
    cmp     di, 0FFFFh
    jz      short loc_1AD0E
    cmp     state.opponentstate.car_surfaceWhl, 4
    jnz     short loc_1ACBD
    cmp     state.opponentstate.car_surfaceWhl+1, 4
    jnz     short loc_1ACBD
    cmp     state.opponentstate.car_surfaceWhl+2, 4
    jnz     short loc_1ACBD
    cmp     state.opponentstate.car_surfaceWhl+3, 4
    jz      short loc_1AD0E
loc_1ACBD:
    mov     [bp+var_vec6.vx], 0
    mov     [bp+var_vec6.vz], 0
    mov     [bp+var_vec6.vy], 7530h
    lea     ax, [bp+var_vec8]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_vec6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    lea     ax, [bp+var_vec6]
    push    ax
    mov     ax, offset mat_temp
    push    ax
    lea     ax, [bp+var_vec8]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_vec6.vz], 0
    jg      short loc_1AD08
    mov     [bp+var_A4], 0F800h
    jmp     short loc_1AD0E
loc_1AD08:
    mov     [bp+var_A4], 800h
loc_1AD0E:
    mov     [bp+var_4E], 0
    sub     si, si
    jmp     loc_1BF6D
    ; align 2
    db 144
loc_1AD18:
    mov     [bp+var_counter], 1
    mov     [bp+var_10E], offset unk_3C0EE
    jmp     short loc_1AD55
    ; align 2
    db 144
loc_1AD26:
    mov     [bp+var_counter], 2
    mov     [bp+var_10E], offset unk_3C0F0
    jmp     short loc_1AD55
    ; align 2
    db 144
loc_1AD34:
    mov     [bp+var_counter], 3
    jmp     short loc_1AD4F
    ; align 2
    db 144
loc_1AD3C:
    mov     [bp+var_counter], 4
    mov     [bp+var_10E], offset unk_3C0F8
    jmp     short loc_1AD55
    ; align 2
    db 144
loc_1AD4A:
    mov     [bp+var_counter], 1
loc_1AD4F:
    mov     [bp+var_10E], offset unk_3C0F4
loc_1AD55:
    mov     [bp+var_multitileflag], 0
    jmp     loc_1AE7A
loc_1AD5E:
    mov     al, [bp+var_pos2lookupadjust]
    cbw
    or      ax, ax
    jz      short loc_1AD80
    cmp     ax, 1Dh
    jz      short loc_1ADCC
    mov     al, [bp+var_poslookupadjust]
    cbw
    or      ax, ax
    jz      short loc_1ADEC
    cmp     ax, 1Dh
    jz      short loc_1ADF0
    mov     di, 0FFFFh
    jmp     short loc_1AD97
    ; align 2
    db 144
loc_1AD80:
    mov     al, [bp+var_poslookupadjust]
    cbw
    or      ax, ax
    jz      short loc_1AD94
    cmp     ax, 1Dh
    jz      short loc_1ADC6
    mov     di, 6
    jmp     short loc_1AD97
    ; align 2
    db 144
loc_1AD94:
    mov     di, 7
loc_1AD97:
    cmp     di, 0FFFFh
    jnz     short loc_1AD9F
    jmp     loc_1AE76
loc_1AD9F:
    mov     al, fence_TrkObjCodes[di]; indices to corner shapes?
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_trkobjectptr], ax
    cmp     [bp+var_FC], 0
    jnz     short loc_1ADF6
    mov     bx, ax
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    jmp     short loc_1ADFC
    ; align 2
    db 144
loc_1ADC6:
    mov     di, 5
    jmp     short loc_1AD97
    ; align 2
    db 144
loc_1ADCC:
    mov     al, [bp+var_poslookupadjust]
    cbw
    or      ax, ax
    jz      short loc_1ADE0
    cmp     ax, 1Dh
    jz      short loc_1ADE6
    mov     di, 2
    jmp     short loc_1AD97
    ; align 2
    db 144
loc_1ADE0:
    mov     di, 1
    jmp     short loc_1AD97
    ; align 2
    db 144
loc_1ADE6:
    mov     di, 3
    jmp     short loc_1AD97
    ; align 2
    db 144
loc_1ADEC:
    sub     di, di
    jmp     short loc_1AD97
loc_1ADF0:
    mov     di, 4
    jmp     short loc_1AD97
    ; align 2
    db 144
loc_1ADF6:
    mov     bx, [bp+var_trkobjectptr]
    mov     ax, [bx+TRACKOBJECT.ss_loShapePtr]
loc_1ADFC:
    mov     currenttransshape.ts_shapeptr, ax
    mov     al, [bp+var_pos2lookupadjust]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    sub     ax, [bp+var_vec4.vx]
    mov     currenttransshape.ts_pos.vx, ax
    mov     ax, [bp+var_vec4.vy]
    neg     ax
    mov     currenttransshape.ts_pos.vy, ax
    mov     al, [bp+var_poslookupadjust]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    sub     ax, [bp+var_vec4.vz]
    mov     currenttransshape.ts_pos.vz, ax
    mov     currenttransshape.ts_rectptr, offset rect_unk2
    mov     al, [bp+var_122]
    or      al, 5
    mov     currenttransshape.ts_flags, al
    mov     currenttransshape.ts_rotvec.vx, 0
    mov     currenttransshape.ts_rotvec.vy, 0
    mov     bx, di
    shl     bx, 1
    mov     ax, word_3C0D6[bx]
    mov     currenttransshape.ts_rotvec.vz, ax
    mov     currenttransshape.ts_unk, 400h
    mov     currenttransshape.ts_material, 0
    mov     ax, offset currenttransshape
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
    or      ax, ax
    jle     short loc_1AE76
    jmp     loc_1B03C
loc_1AE76:
    inc     [bp+var_multitileflag]
loc_1AE7A:
    mov     ax, [bp+var_counter]
    cmp     [bp+var_multitileflag], ax
    jge     short loc_1AECC
    mov     ax, [bp+var_multitileflag]
    shl     ax, 1
    add     ax, [bp+var_10E]
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    mov     al, [bx]
    add     al, [bp+var_pos2lookup]
    mov     [bp+var_pos2lookupadjust], al
    mov     al, [bx+1]
    add     al, [bp+var_poslookup]
    mov     [bp+var_poslookupadjust], al
    cmp     timertestflag2, 0
    jnz     short loc_1AEB2
    jmp     loc_1AD5E
loc_1AEB2:
    mov     al, [bp+var_D8]
    cmp     [bp+var_pos2lookupadjust], al
    jnz     short loc_1AE76
    mov     al, [bp+var_E2]
    cmp     [bp+var_poslookupadjust], al
    jnz     short loc_1AEC9
    jmp     loc_1AD5E
loc_1AEC9:
    jmp     short loc_1AE76
    ; align 2
    db 144
loc_1AECC:
    cmp     [bp+terr_map_value], 6
    jnz     short loc_1AF50
    mov     ax, hillHeightConsts+2
    mov     [bp+var_hillheight], ax
    cmp     [bp+elem_map_value], 0
    jz      short loc_1AEE4
loc_1AEDF:
    mov     [bp+terr_map_value], 0
loc_1AEE4:
    cmp     [bp+terr_map_value], 0
    jnz     short loc_1AEEE
    jmp     loc_1B11C
loc_1AEEE:
    mov     al, [bp+terr_map_value]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset sceneshapes2
    mov     [bp+var_trkobject_ptr], ax
    mov     bx, ax
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    mov     currenttransshape.ts_shapeptr, ax
    mov     al, [bp+var_pos2lookup]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    sub     ax, [bp+var_vec4.vx]
    mov     currenttransshape.ts_pos.vx, ax
    mov     ax, [bp+var_hillheight]
    sub     ax, [bp+var_vec4.vy]
    mov     currenttransshape.ts_pos.vy, ax
    mov     al, [bp+var_poslookup]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    sub     ax, [bp+var_vec4.vz]
    mov     currenttransshape.ts_pos.vz, ax
    cmp     [bp+var_hillheight], 0
    jz      short loc_1AF47
    jmp     loc_1B0D4
loc_1AF47:
    mov     currenttransshape.ts_rectptr, offset rect_unk2
    jmp     loc_1B0DA
loc_1AF50:
    mov     [bp+var_hillheight], 0
    mov     al, [bp+elem_map_value]
    sub     ah, ah
    cmp     ax, 69h ; 'i'
    jb      short loc_1AEE4
    cmp     ax, 6Ch ; 'l'
    jbe     short loc_1AF67
    jmp     loc_1AEE4
loc_1AF67:
    mov     [bp+var_multitileflag], 0
    jmp     loc_1B0AC
loc_1AF70:
    mov     al, [bp+var_pos2lookup]
loc_1AF74:
    mov     [bp+var_pos2lookupadjust], al
    mov     al, [bp+var_poslookup]
loc_1AF7C:
    mov     [bp+var_poslookupadjust], al
loc_1AF80:
    mov     al, [bp+var_pos2lookupadjust]
    cbw
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     al, [bp+var_poslookupadjust]
    cbw
    shl     ax, 1
    mov     [bp+var_lastposlookupw], ax
    mov     bx, ax
    mov     bx, terrainrows[bx]
    add     bx, word ptr [bp+var_lastpos2lookup]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+terr_map_value], al
    or      al, al
    jnz     short loc_1AFB4
    jmp     loc_1B0A8
loc_1AFB4:
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset sceneshapes2
    mov     [bp+var_trkobject_ptr], ax
    mov     bx, ax
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    mov     currenttransshape.ts_shapeptr, ax
    mov     bx, word ptr [bp+var_lastpos2lookup]
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    sub     ax, [bp+var_vec4.vx]
    mov     currenttransshape.ts_pos.vx, ax
    mov     ax, [bp+var_vec4.vy]
    neg     ax
    mov     currenttransshape.ts_pos.vy, ax
    mov     bx, [bp+var_lastposlookupw]
    mov     ax, trackcenterpos[bx]
    sub     ax, [bp+var_vec4.vz]
    mov     currenttransshape.ts_pos.vz, ax
    mov     currenttransshape.ts_rectptr, offset rect_unk2
    mov     al, [bp+var_122]
    or      al, 5
    mov     currenttransshape.ts_flags, al
    mov     currenttransshape.ts_rotvec.vx, 0
    mov     currenttransshape.ts_rotvec.vy, 0
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_rotY]
    mov     currenttransshape.ts_rotvec.vz, ax
    mov     currenttransshape.ts_unk, 400h
    mov     currenttransshape.ts_material, 0
    mov     ax, offset currenttransshape
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
    or      ax, ax
    jle     short loc_1B0A8
loc_1B03C:
    push    [bp+var_vec4.vy]
    push    [bp+var_angY]
    push    [bp+var_angZ]
    lea     ax, [bp+var_mat]
    push    ax
    push    [bp+var_2]
    push    [bp+arg_cliprectptr]
    mov     al, [bp+arg_0]
    cbw
    push    ax
    push    cs
    call near ptr skybox_op
    add     sp, 0Eh
    mov     [bp+var_132], ax
    mov     bx, [bp+arg_cliprectptr]
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    call    get_a_poly_info
    sub     si, si
    jmp     loc_1C0C2
    ; align 2
    db 144
loc_1B084:
    mov     al, [bp+var_pos2lookup]
    inc     al
    jmp     loc_1AF74
    ; align 2
    db 144
loc_1B08E:
    mov     al, [bp+var_pos2lookup]
loc_1B092:
    mov     [bp+var_pos2lookupadjust], al
    mov     al, [bp+var_poslookup]
    inc     al
    jmp     loc_1AF7C
    ; align 2
    db 144
loc_1B0A0:
    mov     al, [bp+var_pos2lookup]
    inc     al
    jmp     short loc_1B092
loc_1B0A8:
    inc     [bp+var_multitileflag]
loc_1B0AC:
    cmp     [bp+var_multitileflag], 4
    jl      short loc_1B0B6
    jmp     loc_1AEDF
loc_1B0B6:
    mov     ax, [bp+var_multitileflag]
    or      ax, ax
    jnz     short loc_1B0C1
    jmp     loc_1AF70
loc_1B0C1:
    cmp     ax, 1
    jz      short loc_1B084
    cmp     ax, 2
    jz      short loc_1B08E
    cmp     ax, 3
    jz      short loc_1B0A0
    jmp     loc_1AF80
    ; align 2
    db 144
loc_1B0D4:
    mov     currenttransshape.ts_rectptr, offset rect_unk6
loc_1B0DA:
    mov     al, [bp+var_122]
    or      al, 5
    mov     currenttransshape.ts_flags, al
    mov     currenttransshape.ts_rotvec.vx, 0
    mov     currenttransshape.ts_rotvec.vy, 0
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_rotY]
    mov     currenttransshape.ts_rotvec.vz, ax
    mov     currenttransshape.ts_unk, 400h
    mov     currenttransshape.ts_material, 0
    mov     ax, offset currenttransshape
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
    or      ax, ax
    jle     short loc_1B11C
    jmp     loc_1B03C
loc_1B11C:
    mov     transformedshape_counter, 0
    mov     curtransshape_ptr, offset currenttransshape
    cmp     [bp+elem_map_value], 0
    jnz     short loc_1B130
    jmp     loc_1B71E
loc_1B130:
    mov     al, [bp+elem_map_value]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_trkobject_ptr], ax
    mov     bx, ax
    test    byte ptr [bx+0Bh], 1
    jz      short loc_1B168
    mov     al, [bp+var_poslookup]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackpos[bx]
    mov     [bp+var_5E], ax
    mov     al, [bp+var_poslookup]
    inc     al
    jmp     short loc_1B17C
loc_1B168:
    mov     al, [bp+var_poslookup]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    mov     [bp+var_5E], ax
    mov     al, [bp+var_poslookup]
loc_1B17C:
    mov     [bp+var_poslookupadjust], al
    mov     bx, [bp+var_trkobject_ptr]
    test    [bx+TRACKOBJECT.ss_multiTileFlag], 2
    jz      short loc_1B1A2
    mov     al, [bp+var_pos2lookup]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, (trackpos2+2)[bx]
    mov     [bp+var_3A], ax
    mov     al, [bp+var_pos2lookup]
    inc     al
    jmp     short loc_1B1B6
loc_1B1A2:
    mov     al, [bp+var_pos2lookup]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    mov     [bp+var_3A], ax
    mov     al, [bp+var_pos2lookup]
loc_1B1B6:
    mov     [bp+var_pos2lookupadjust], al
    mov     ax, [bp+var_3A]
    sub     ax, [bp+var_vec4.vx]
    mov     [bp+var_vec8.vx], ax
    mov     ax, [bp+var_hillheight]
    sub     ax, [bp+var_vec4.vy]
    mov     [bp+var_vec8.vy], ax
    mov     ax, [bp+var_5E]
    sub     ax, [bp+var_vec4.vz]
    mov     [bp+var_vec8.vz], ax
    cmp     [bp+var_hillheight], 0
    jnz     short loc_1B1DE
    jmp     loc_1B2AE
loc_1B1DE:
    mov     bx, [bp+var_trkobject_ptr]
    mov     al, [bx+TRACKOBJECT.ss_multiTileFlag]
    cbw
    or      ax, ax
    jz      short loc_1B1FC
    cmp     ax, 1
    jz      short loc_1B20E
    cmp     ax, 2
    jz      short loc_1B21A
    cmp     ax, 3
    jz      short loc_1B226
    jmp     short loc_1B205
    ; align 2
    db 144
loc_1B1FC:
    mov     di, 1
    mov     [bp+var_DA], offset unk_3C0A2
loc_1B205:
    mov     [bp+var_multitileflag], 0
    jmp     short loc_1B236
    ; align 2
    db 144
loc_1B20E:
    mov     di, 2
    mov     [bp+var_DA], offset unk_3C0A6
    jmp     short loc_1B205
    ; align 2
    db 144
loc_1B21A:
    mov     di, 2
    mov     [bp+var_DA], offset unk_3C0AE
    jmp     short loc_1B205
    ; align 2
    db 144
loc_1B226:
    mov     di, 4
    mov     [bp+var_DA], offset unk_3C0B6
    jmp     short loc_1B205
    ; align 2
    db 144
loc_1B232:
    inc     [bp+var_multitileflag]
loc_1B236:
    cmp     [bp+var_multitileflag], di
    jge     short loc_1B2AE
    mov     bx, [bp+var_DA]
    add     [bp+var_DA], 2
    mov     ax, [bx]
    add     ax, [bp+var_vec8.vx]
    mov     currenttransshape.ts_pos.vx, ax
    mov     ax, [bp+var_vec8.vy]
    mov     currenttransshape.ts_pos.vy, ax
    mov     bx, [bp+var_DA]
    add     [bp+var_DA], 2
    mov     ax, [bx]
    add     ax, [bp+var_vec8.vz]
    mov     currenttransshape.ts_pos.vz, ax
    mov     currenttransshape.ts_shapeptr, (offset game3dshapes.shape3d_numverts+3B2h)
    mov     currenttransshape.ts_rectptr, offset rect_unk6
    mov     al, [bp+var_122]
    or      al, 5
    mov     currenttransshape.ts_flags, al
    mov     currenttransshape.ts_rotvec.vx, 0
    mov     currenttransshape.ts_rotvec.vy, 0
    mov     currenttransshape.ts_rotvec.vz, 0
    mov     currenttransshape.ts_unk, 800h
    mov     currenttransshape.ts_material, 0
    mov     ax, offset currenttransshape
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
    or      ax, ax
    jle     short loc_1B232
    jmp     loc_1B03C
loc_1B2AE:
    mov     bx, [bp+var_trkobject_ptr]
    cmp     [bx+TRACKOBJECT.ss_ssOvelay], 0
    jnz     short loc_1B2BB
    jmp     loc_1B374
loc_1B2BB:
    mov     al, [bx+TRACKOBJECT.ss_ssOvelay]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_trkobjectptr], ax
    cmp     [bp+var_FC], 0
    jz      short loc_1B2E0
    mov     bx, ax
    mov     ax, [bx+TRACKOBJECT.ss_loShapePtr]
    jmp     short loc_1B2E6
loc_1B2E0:
    mov     bx, [bp+var_trkobjectptr]
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
loc_1B2E6:
    mov     currenttransshape.ts_shapeptr+14h, ax
    or      ax, ax
    jnz     short loc_1B2F0
    jmp     loc_1B374
loc_1B2F0:
    push    si
    push    di
    mov     di, (offset currenttransshape.ts_pos.vy+12h)
    lea     si, [bp+var_vec8]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     currenttransshape.ts_rotvec.vy+12h, 0
    mov     currenttransshape.ts_rotvec.vz+12h, 0
    mov     ax, [bx+TRACKOBJECT.ss_rotY]
    mov     currenttransshape.ts_rotvec.vx+18h, ax
    cmp     [bx+TRACKOBJECT.ss_multiTileFlag], 0
    jz      short loc_1B320
    mov     currenttransshape.ts_unk+14h, 400h
    jmp     short loc_1B326
    ; align 2
    db 144
loc_1B320:
    mov     currenttransshape.ts_unk+14h, 800h
loc_1B326:
    cmp     [bx+TRACKOBJECT.ss_surfaceType], 0
    jl      short loc_1B332
    mov     al, [bx+TRACKOBJECT.ss_surfaceType]
    jmp     short loc_1B336
    ; align 2
    db 144
loc_1B332:
    mov     al, [bp+var_E4]
loc_1B336:
    mov     currenttransshape.ts_material+14h, al
    mov     al, [bx+TRACKOBJECT.ss_ignoreZBias]
    or      al, [bp+var_122]
    or      al, 4
    mov     currenttransshape.ts_flags+14h, al
    test    currenttransshape.ts_flags+14h, 1
    jz      short loc_1B36A
    mov     currenttransshape.ts_rectptr+14h, offset rect_unk2
    mov     ax, (offset currenttransshape.ts_pos.vy+12h)
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
    or      ax, ax
    jle     short loc_1B374
    jmp     loc_1B03C
loc_1B36A:
    mov     currenttransshape.ts_rectptr+14h, offset rect_unk6
    mov     [bp+var_4E], 1
loc_1B374:
    cmp     [bp+var_FC], 0
    jz      short loc_1B384
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_loShapePtr]
    jmp     short loc_1B38B
loc_1B384:
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
loc_1B38B:
    mov     currenttransshape.ts_shapeptr, ax
    push    si
    push    di
    mov     di, offset currenttransshape
    lea     si, [bp+var_vec8]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     currenttransshape.ts_rotvec.vx, 0
    mov     currenttransshape.ts_rotvec.vy, 0
    mov     ax, [bx+TRACKOBJECT.ss_rotY]
    mov     currenttransshape.ts_rotvec.vz, ax
    cmp     [bx+TRACKOBJECT.ss_multiTileFlag], 0
    jz      short loc_1B3BE
    mov     currenttransshape.ts_unk, 400h
    jmp     short loc_1B3C4
    ; align 2
    db 144
loc_1B3BE:
    mov     currenttransshape.ts_unk, 800h
loc_1B3C4:
    mov     al, [bx+TRACKOBJECT.ss_ignoreZBias]
    or      al, [bp+var_122]
    or      al, 4
    mov     currenttransshape.ts_flags, al
    cmp     [bx+TRACKOBJECT.ss_surfaceType], 0
    jl      short loc_1B3DC
    mov     al, [bx+TRACKOBJECT.ss_surfaceType]
    jmp     short loc_1B3E0
    ; align 2
    db 144
loc_1B3DC:
    mov     al, [bp+var_E4]
loc_1B3E0:
    mov     currenttransshape.ts_material, al
    test    [bx+TRACKOBJECT.ss_ignoreZBias], 1
    jz      short loc_1B408
    mov     currenttransshape.ts_rectptr, offset rect_unk2
    mov     ax, offset currenttransshape
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
    or      ax, ax
    jle     short loc_1B46A
    jmp     loc_1B03C
    ; align 2
    db 144
loc_1B408:
    mov     currenttransshape.ts_rectptr, offset rect_unk6
    sub     ax, ax
    push    ax
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
    cmp     [bp+var_4E], 0
    jz      short loc_1B449
    mov     [bp+var_4E], 0
    sub     ax, ax
    push    ax
    mov     ax, 0F800h
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
    cmp     [bp+var_6C], 0
    jz      short loc_1B43C
    mov     [bp+var_6C], 0FC00h
loc_1B43C:
    cmp     [bp+var_A4], 0
    jz      short loc_1B449
    sub     [bp+var_A4], 400h
loc_1B449:
    mov     al, startcol2
    cmp     [bp+var_pos2lookup], al
    jnz     short loc_1B464
    mov     al, startrow2
    cmp     [bp+var_poslookup], al
    jnz     short loc_1B464
    mov     [bp+var_12A], 0
    jmp     short loc_1B46A
    ; align 2
    db 144
loc_1B464:
    mov     [bp+var_12A], 0FFFFh
loc_1B46A:
    mov     al, [bp+var_poslookup]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, trackrows[bx]
    mov     al, [bp+var_pos2lookup]
    cbw
    add     bx, ax
    add     bx, word ptr trackdata19
    mov     es, word ptr trackdata19+2
    mov     al, es:[bx]
    mov     [bp+var_4C], al
    cmp     al, 0FFh
    jnz     short loc_1B493
    jmp     loc_1B72E
loc_1B493:
    cbw
    mov     bx, ax
    cmp     state.field_3FA[bx], 0
    jnz     short loc_1B4A0
    jmp     loc_1B626
loc_1B4A0:
    cmp     state.field_42A, 0
    jnz     short loc_1B4AA
    jmp     loc_1B72E
loc_1B4AA:
    sub     di, di
loc_1B4AC:
    mov     ax, di
    shl     ax, 1
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    cmp     word ptr state.field_38E[bx], 0
    jnz     short loc_1B4C0
    jmp     loc_1B61A
loc_1B4C0:
    mov     al, [bp+var_4C]
    cbw
    add     ax, 2
    mov     cl, state.field_443[di]
    sub     ch, ch
    cmp     ax, cx
    jz      short loc_1B4D4
    jmp     loc_1B61A
loc_1B4D4:
    mov     al, state.field_42B[di]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset sceneshapes3
    mov     [bp+var_trkobject_ptr], ax
    mov     ax, di
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_lastposlookupw], ax
    mov     bx, ax
    mov     ax, word ptr state.game_longs1[bx]
    mov     dx, word ptr (state.game_longs1+2)[bx]
    mov     cl, 6
loc_1B503:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B503
    mov     cx, ax
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    add     cx, es:[bx]
    sub     cx, [bp+var_vec4.vx]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vx], cx
    mov     bx, [bp+var_lastposlookupw]
    mov     ax, word ptr state.game_longs2[bx]
    mov     dx, word ptr (state.game_longs2+2)[bx]
    mov     cl, 6
loc_1B53B:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B53B
    mov     cx, ax
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    add     cx, es:[bx+2]
    sub     cx, [bp+var_vec4.vy]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vy], cx
    mov     bx, [bp+var_lastposlookupw]
    mov     ax, word ptr state.game_longs3[bx]
    mov     dx, word ptr (state.game_longs3+2)[bx]
    mov     cl, 6
loc_1B575:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B575
    mov     cx, ax
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    add     cx, es:[bx+4]
    sub     cx, [bp+var_vec4.vz]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vz], cx
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], offset rect_unk6
    mov     bx, curtransshape_ptr
    mov     al, [bp+var_122]
    or      al, 5
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], al
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_2FE[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vx], ax
    mov     ax, di
    shl     ax, 1
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    mov     ax, state.field_32E[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vy], ax
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_35E[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vz], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_unk], 400h
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_material], 0
    sub     ax, ax
    push    ax
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
loc_1B61A:
    inc     di
    cmp     di, 18h
    jge     short loc_1B623
    jmp     loc_1B4AC
loc_1B623:
    jmp     loc_1B72E
loc_1B626:
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    add     bx, word ptr trackdata23
    mov     es, word ptr trackdata23+2
    mov     al, es:[bx]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, (offset trkObjectList.ss_trkObjInfoPtr+0B98h)
    mov     [bp+var_trkobject_ptr], ax
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    mov     ax, es:[bx]
    sub     ax, [bp+var_vec4.vx]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vx], ax
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    mov     ax, es:[bx+2]
    sub     ax, [bp+var_vec4.vy]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vy], ax
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    mov     ax, es:[bx+4]
    sub     ax, [bp+var_vec4.vz]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vz], ax
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], offset rect_unk6
    mov     bx, curtransshape_ptr
    mov     al, [bp+var_122]
    or      al, 4
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], al
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vx], 0
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vy], 0
    mov     al, [bp+var_4C]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, word ptr td08_direction_related
    mov     es, word ptr td08_direction_related+2
    mov     ax, es:[bx]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vz], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_unk], 64h ; 'd'
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_material], 0
    sub     ax, ax
    push    ax
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
    jmp     short loc_1B72E
loc_1B71E:
    mov     al, [bp+var_pos2lookup]
    mov     [bp+var_pos2lookupadjust], al
    mov     al, [bp+var_poslookup]
    mov     [bp+var_poslookupadjust], al
loc_1B72E:
    mov     al, [bp+var_pos2lookup]
    cmp     [bp+var_3C], al
    jz      short loc_1B743
    mov     al, [bp+var_pos2lookupadjust]
    cmp     [bp+var_3C], al
    jz      short loc_1B743
    jmp     loc_1B9DA
loc_1B743:
    mov     al, [bp+var_poslookup]
    cmp     [bp+var_60], al
    jz      short loc_1B758
    mov     al, [bp+var_poslookupadjust]
    cmp     [bp+var_60], al
    jz      short loc_1B758
    jmp     loc_1B9DA
loc_1B758:
    cmp     state.field_42A, 0
    jnz     short loc_1B762
    jmp     loc_1B89F
loc_1B762:
    sub     di, di
loc_1B764:
    mov     ax, di
    shl     ax, 1
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    cmp     word ptr state.field_38E[bx], 0
    jnz     short loc_1B778
    jmp     loc_1B896
loc_1B778:
    cmp     state.field_443[di], 0
    jz      short loc_1B782
    jmp     loc_1B896
loc_1B782:
    mov     al, state.field_42B[di]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset sceneshapes3
    mov     [bp+var_trkobject_ptr], ax
    mov     ax, di
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_lastposlookupw], ax
    mov     bx, ax
    mov     ax, word ptr state.game_longs1[bx]
    mov     dx, word ptr (state.game_longs1+2)[bx]
    add     ax, word ptr state.playerstate.car_posWorld1.lx
    adc     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1B7B9:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B7B9
    sub     ax, [bp+var_vec4.vx]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vx], ax
    mov     bx, [bp+var_lastposlookupw]
    mov     ax, word ptr state.game_longs2[bx]
    mov     dx, word ptr (state.game_longs2+2)[bx]
    add     ax, word ptr state.playerstate.car_posWorld1.ly
    adc     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1B7E0:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B7E0
    sub     ax, [bp+var_vec4.vy]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vy], ax
    mov     bx, [bp+var_lastposlookupw]
    mov     ax, word ptr state.game_longs3[bx]
    mov     dx, word ptr (state.game_longs3+2)[bx]
    add     ax, word ptr state.playerstate.car_posWorld1.lz
    adc     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1B808:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B808
    sub     ax, [bp+var_vec4.vz]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vz], ax
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], offset rect_unk6
    mov     bx, curtransshape_ptr
    mov     al, [bp+var_122]
    or      al, 5
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], al
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_2FE[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vx], ax
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_32E[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vy], ax
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_35E[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vz], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_unk], 400h
    mov     bx, curtransshape_ptr
    mov     al, gameconfig.game_playermaterial
    mov     [bx+TRANSFORMEDSHAPE.ts_material], al
    sub     ax, ax
    push    ax
    mov     ax, [bp+var_6C]
    and     ax, [bp+var_12A]
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
loc_1B896:
    inc     di
    cmp     di, 18h
    jge     short loc_1B89F
    jmp     loc_1B764
loc_1B89F:
    mov     [bp+var_trkobject_ptr], (offset trkObjectList.ss_trkObjInfoPtr+1Ch)
    mov     bx, curtransshape_ptr
    mov     ax, word ptr state.playerstate.car_posWorld1.lx
    mov     dx, word ptr state.playerstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1B8B2:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B8B2
    sub     ax, [bp+var_vec4.vx]
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vx], ax
    mov     bx, curtransshape_ptr
    mov     ax, word ptr state.playerstate.car_posWorld1.ly
    mov     dx, word ptr state.playerstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1B8CC:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B8CC
    sub     ax, [bp+var_vec4.vy]
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vy], ax
    mov     bx, curtransshape_ptr
    mov     ax, word ptr state.playerstate.car_posWorld1.lz
    mov     dx, word ptr state.playerstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1B8E7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1B8E7
    sub     ax, [bp+var_vec4.vz]
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vz], ax
    cmp     [bp+var_FC], 0
    jnz     short loc_1B903
    cmp     timertestflag2, 2
    jbe     short loc_1B914
loc_1B903:
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_loShapePtr]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    jmp     short loc_1B94A
    ; align 2
    db 144
loc_1B914:
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    mov     ax, offset carshapevec
    push    ax
    mov     ax, offset carshapevecs
    push    ax
    mov     ax, offset word_443E8
    push    ax
    mov     ax, offset state.playerstate.car_rc2
    push    ax
    push    state.playerstate.car_steeringAngle
    mov     ax, word ptr game3dshapes.shape3d_verts+0AD4h
    mov     dx, word ptr game3dshapes.shape3d_verts+0AD6h
    add     ax, 30h ; '0'
    push    dx
    push    ax
    call    sub_204AE
    add     sp, 0Eh
loc_1B94A:
    cmp     timertestflag_copy, 0
    jz      short loc_1B964
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], offset rect_unk12
loc_1B95A:
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], 0Ch
    jmp     short loc_1B990
loc_1B964:
    cmp     state.playerstate.car_crashBmpFlag, 1
    jnz     short loc_1B988
    push    si
    push    di
    lea     di, [bp+var_rect]
    mov     si, offset cliprect_unk
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     bx, curtransshape_ptr
    lea     ax, [bp+var_rect]
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], ax
    jmp     short loc_1B95A
    ; align 2
    db 144
loc_1B988:
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], 4
loc_1B990:
    mov     bx, curtransshape_ptr
    mov     ax, state.playerstate.car_rotate.vz
    neg     ax
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vx], ax
    mov     bx, curtransshape_ptr
    mov     ax, state.playerstate.car_rotate.vy
    neg     ax
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vy], ax
    mov     bx, curtransshape_ptr
    mov     ax, state.playerstate.car_rotate.vx
    neg     ax
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vz], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_unk], 12Ch
    mov     bx, curtransshape_ptr
    mov     al, gameconfig.game_playermaterial
    mov     [bx+TRANSFORMEDSHAPE.ts_material], al
    mov     ax, 2
    push    ax
    mov     ax, [bp+var_6C]
    and     ax, [bp+var_12A]
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
loc_1B9DA:
    mov     al, [bp+var_pos2lookup]
    cmp     [bp+var_4A], al
    jz      short loc_1B9EF
    mov     al, [bp+var_pos2lookupadjust]
    cmp     [bp+var_4A], al
    jz      short loc_1B9EF
    jmp     loc_1BC89
loc_1B9EF:
    mov     al, [bp+var_poslookup]
    cmp     [bp+var_6E], al
    jz      short loc_1BA04
    mov     al, [bp+var_poslookupadjust]
    cmp     [bp+var_6E], al
    jz      short loc_1BA04
    jmp     loc_1BC89
loc_1BA04:
    cmp     state.field_42A, 0
    jnz     short loc_1BA0E
    jmp     loc_1BB4C
loc_1BA0E:
    sub     di, di
loc_1BA10:
    mov     ax, di
    shl     ax, 1
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    cmp     word ptr state.field_38E[bx], 0
    jnz     short loc_1BA24
    jmp     loc_1BB43
loc_1BA24:
    cmp     state.field_443[di], 1
    jz      short loc_1BA2E
    jmp     loc_1BB43
loc_1BA2E:
    mov     al, state.field_42B[di]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset sceneshapes3
    mov     [bp+var_trkobject_ptr], ax
    mov     ax, di
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_lastposlookupw], ax
    mov     bx, ax
    mov     ax, word ptr state.game_longs1[bx]
    mov     dx, word ptr (state.game_longs1+2)[bx]
    add     ax, word ptr state.opponentstate.car_posWorld1.lx
    adc     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1BA65:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1BA65
    sub     ax, [bp+var_vec4.vx]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vx], ax
    mov     bx, [bp+var_lastposlookupw]
    mov     ax, word ptr state.game_longs2[bx]
    mov     dx, word ptr (state.game_longs2+2)[bx]
    add     ax, word ptr state.opponentstate.car_posWorld1.ly
    adc     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1BA8C:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1BA8C
    sub     ax, [bp+var_vec4.vy]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vy], ax
    mov     bx, [bp+var_lastposlookupw]
    mov     ax, word ptr state.game_longs3[bx]
    mov     dx, word ptr (state.game_longs3+2)[bx]
    add     ax, word ptr state.opponentstate.car_posWorld1.lz
    adc     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1BAB4:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1BAB4
    sub     ax, [bp+var_vec4.vz]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vz], ax
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+4]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], offset rect_unk6
    mov     bx, curtransshape_ptr
    mov     al, [bp+var_122]
    or      al, 5
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], al
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_2FE[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vx], ax
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_32E[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vy], ax
    mov     bx, word ptr [bp+var_lastpos2lookup]
    mov     ax, state.field_35E[bx]
    neg     ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vz], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_unk], 400h
    mov     bx, curtransshape_ptr
    mov     al, gameconfig.game_opponentmaterial
    mov     [bx+TRANSFORMEDSHAPE.ts_material], al
    sub     ax, ax
    push    ax
    mov     ax, [bp+var_A4]
    and     ax, [bp+var_12A]
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
loc_1BB43:
    inc     di
    cmp     di, 18h
    jge     short loc_1BB4C
    jmp     loc_1BA10
loc_1BB4C:
    mov     [bp+var_trkobject_ptr], (offset trkObjectList.ss_trkObjInfoPtr+2Ah)
    mov     bx, curtransshape_ptr
    mov     ax, word ptr state.opponentstate.car_posWorld1.lx
    mov     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1BB5F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1BB5F
    sub     ax, [bp+var_vec4.vx]
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vx], ax
    mov     bx, curtransshape_ptr
    mov     ax, word ptr state.opponentstate.car_posWorld1.ly
    mov     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1BB79:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1BB79
    sub     ax, [bp+var_vec4.vy]
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vy], ax
    mov     bx, curtransshape_ptr
    mov     ax, word ptr state.opponentstate.car_posWorld1.lz
    mov     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1BB94:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1BB94
    sub     ax, [bp+var_vec4.vz]
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vz], ax
    cmp     [bp+var_FC], 0
    jnz     short loc_1BBB0
    cmp     timertestflag2, 2
    jbe     short loc_1BBC0
loc_1BBB0:
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_loShapePtr]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    jmp     short loc_1BBF6
loc_1BBC0:
    mov     bx, [bp+var_trkobject_ptr]
    mov     ax, [bx+TRACKOBJECT.ss_shapePtr]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], ax
    mov     ax, offset oppcarshapevec
    push    ax
    mov     ax, offset oppcarshapevecs
    push    ax
    mov     ax, offset word_4448A
    push    ax
    mov     ax, offset state.opponentstate.car_rc2
    push    ax
    push    state.opponentstate.car_steeringAngle
    mov     ax, word ptr game3dshapes.shape3d_verts+0AEAh
    mov     dx, word ptr game3dshapes.shape3d_verts+0AECh
    add     ax, 30h ; '0'
    push    dx
    push    ax
    call    sub_204AE
    add     sp, 0Eh
loc_1BBF6:
    cmp     timertestflag_copy, 0
    jz      short loc_1BC10
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], offset rect_unk15
loc_1BC06:
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], 0Ch
    jmp     short loc_1BC3E
loc_1BC10:
    cmp     state.opponentstate.car_crashBmpFlag, 1
    jnz     short loc_1BC36
    push    si
    push    di
    lea     di, [bp+var_rect2]
    mov     si, offset cliprect_unk
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     bx, curtransshape_ptr
    lea     ax, [bp+var_rect2]
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], ax
    jmp     short loc_1BC06
    ; align 2
    db 144
loc_1BC36:
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], 4
loc_1BC3E:
    mov     bx, curtransshape_ptr
    mov     ax, state.opponentstate.car_rotate.vz
    neg     ax
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vx], ax
    mov     bx, curtransshape_ptr
    mov     ax, state.opponentstate.car_rotate.vy
    neg     ax
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vy], ax
    mov     bx, curtransshape_ptr
    mov     ax, state.opponentstate.car_rotate.vx
    neg     ax
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vz], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_unk], 12Ch
    mov     bx, curtransshape_ptr
    mov     al, gameconfig.game_opponentmaterial
    mov     [bx+TRANSFORMEDSHAPE.ts_material], al
    mov     ax, 3
    push    ax
    mov     ax, [bp+var_A4]
    and     ax, [bp+var_12A]
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
loc_1BC89:
    cmp     state.game_inputmode, 0
    jz      short loc_1BC93
    jmp     loc_1BEAA
loc_1BC93:
    mov     al, startcol2
    cmp     [bp+var_pos2lookup], al
    jz      short loc_1BCA5
    cmp     [bp+var_pos2lookupadjust], al
    jz      short loc_1BCA5
    jmp     loc_1BEAA
loc_1BCA5:
    mov     al, startrow2
    cmp     [bp+var_poslookup], al
    jz      short loc_1BCB7
    cmp     [bp+var_poslookupadjust], al
    jz      short loc_1BCB7
    jmp     loc_1BEAA
loc_1BCB7:
    mov     ax, 24h ; '$'
    push    ax
    push    word_44DCA
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     [bp+var_multitileflag], ax
    mov     ax, 24h ; '$'
    push    ax
    push    word_44DCA
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, 38h ; '8'
    mov     [bp+var_counter], ax
    mov     ax, word ptr game3dshapes.shape3d_verts+98Ah
    mov     dx, word ptr game3dshapes.shape3d_verts+98Ch
    add     ax, 30h ; '0'
    mov     word ptr [bp+var_108], ax
    mov     word ptr [bp+var_108+2], dx
    les     bx, [bp+var_108]
    mov     ax, [bp+var_multitileflag]
    sub     ax, 24h ; '$'
    mov     es:[bx], ax
    les     bx, [bp+var_108]
    mov     ax, [bp+var_multitileflag]
    sub     ax, 24h ; '$'
    mov     es:[bx+6], ax
    les     bx, [bp+var_108]
    mov     ax, 24h ; '$'
    sub     ax, [bp+var_multitileflag]
    mov     es:[bx+0Ch], ax
    les     bx, [bp+var_108]
    mov     ax, 24h ; '$'
    sub     ax, [bp+var_multitileflag]
    mov     es:[bx+12h], ax
    les     bx, [bp+var_108]
    mov     ax, [bp+var_counter]
    mov     es:[bx+4], ax
    les     bx, [bp+var_108]
    mov     ax, [bp+var_counter]
    mov     es:[bx+0Ah], ax
    les     bx, [bp+var_108]
    mov     ax, [bp+var_counter]
    mov     es:[bx+10h], ax
    les     bx, [bp+var_108]
    mov     ax, [bp+var_counter]
    mov     es:[bx+16h], ax
    mov     ax, 24h ; '$'
    push    ax
    mov     ax, track_angle
    add     ah, 1
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 1B6h
    push    cx
    mov     cx, track_angle
    add     ch, 2
    push    cx
    mov     word ptr [bp+var_lastpos2lookup], ax
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
    add     cx, word ptr [bp+var_lastpos2lookup]
    sub     cx, [bp+var_vec4.vx]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vx], cx
    mov     al, hillFlag
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, hillHeightConsts[bx]
    sub     ax, [bp+var_vec4.vy]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vy], ax
    mov     ax, 24h ; '$'
    push    ax
    mov     ax, track_angle
    add     ah, 1
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, 1B6h
    push    cx
    mov     cx, track_angle
    add     ch, 2
    push    cx
    mov     word ptr [bp+var_lastpos2lookup], ax
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
    add     cx, word ptr [bp+var_lastpos2lookup]
    sub     cx, [bp+var_vec4.vz]
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_pos.vz], cx
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_shapeptr], (offset game3dshapes.shape3d_numverts+98Ah)
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rectptr], offset rect_unk6
    mov     bx, curtransshape_ptr
    mov     al, [bp+var_122]
    or      al, 4
    mov     [bx+TRANSFORMEDSHAPE.ts_flags], al
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vx], 0
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vy], 0
    mov     bx, curtransshape_ptr
    mov     ax, track_angle
    mov     [bx+TRANSFORMEDSHAPE.ts_rotvec.vz], ax
    mov     bx, curtransshape_ptr
    mov     [bx+TRANSFORMEDSHAPE.ts_unk], 400h
    mov     ax, word_44DCA
    mov     cl, 6
    sar     ax, cl
    mov     [bp+var_multitileflag], ax
    cmp     ax, 3
    jle     short loc_1BE8D
    mov     [bp+var_multitileflag], 3
loc_1BE8D:
    mov     bx, curtransshape_ptr
    mov     al, byte ptr [bp+var_multitileflag]
    mov     [bx+TRANSFORMEDSHAPE.ts_material], al
    sub     ax, ax
    push    ax
    mov     ax, [bp+var_12A]
smart
    and     ax, 0F800h
nosmart
    push    ax
    push    cs
    call near ptr transformed_shape_add_for_sort
    add     sp, 4
loc_1BEAA:
    cmp     transformedshape_counter, 0
    jnz     short loc_1BEB4
    jmp     loc_1BF6C
loc_1BEB4:
    cmp     transformedshape_counter, 1
    jle     short loc_1BED0
    mov     ax, offset transformedshape_indices
    push    ax
    mov     ax, offset transformedshape_zarray
    push    ax
    mov     al, transformedshape_counter
    cbw
    push    ax
    call    heapsort_by_order
    add     sp, 6
loc_1BED0:
    mov     [bp+var_multitileflag], 0
    jmp     short loc_1BF38
loc_1BED8:
    cmp     state.playerstate.car_is_braking, 0
    jnz     short loc_1BF09
loc_1BEDF:
    mov     backlights_paint_override, 2Eh ; '.'
loc_1BEE4:
    mov     ax, 14h
    imul    di
    add     ax, offset currenttransshape
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cbw
    mov     [bp+var_transformresult], ax
    or      ax, ax
    jle     short loc_1BF10
    jmp     loc_1B03C
    ; align 2
    db 144
loc_1BF02:
    cmp     state.opponentstate.car_is_braking, 0
    jz      short loc_1BEDF
loc_1BF09:
    mov     backlights_paint_override, 2Fh ; '/'
    jmp     short loc_1BEE4
loc_1BF10:
    cmp     [bp+var_transformresult], 0
    jnz     short loc_1BF34
    mov     al, transformedshape_arg2array[di]
    cbw
    cmp     ax, 2
    jz      short loc_1BF28
    cmp     ax, 3
    jz      short loc_1BF5E
    jmp     short loc_1BF34
loc_1BF28:
    cmp     state.playerstate.car_crashBmpFlag, 1
    jnz     short loc_1BF34
    mov     [bp+var_DC], 1
loc_1BF34:
    inc     [bp+var_multitileflag]
loc_1BF38:
    mov     al, transformedshape_counter
    cbw
    cmp     [bp+var_multitileflag], ax
    jge     short loc_1BF6C
    mov     bx, [bp+var_multitileflag]
    shl     bx, 1
    mov     di, transformedshape_indices[bx]
    mov     al, transformedshape_arg2array[di]
    cbw
    cmp     ax, 2
    jz      short loc_1BED8
    cmp     ax, 3
    jz      short loc_1BF02
    jmp     short loc_1BEE4
    ; align 2
    db 144
loc_1BF5E:
    cmp     state.opponentstate.car_crashBmpFlag, 1
    jnz     short loc_1BF34
    mov     [bp+var_DC+1], 1
    jmp     short loc_1BF34
loc_1BF6C:
    inc     si
loc_1BF6D:
    cmp     si, 17h
    jl      short loc_1BF75
    jmp     loc_1B03C
loc_1BF75:
    cmp     [bp+si+var_32], 0
    jnz     short loc_1BF6C
    mov     al, [bp+si+var_pos2tab]
    mov     [bp+var_pos2lookup], al
    mov     al, [bp+si+var_postab]
    mov     [bp+var_poslookup], al
    mov     al, [bp+si+var_14C]
    mov     [bp+elem_map_value], al
    mov     al, [bp+si+var_1A]
    mov     [bp+terr_map_value], al
    mov     al, [bp+si+var_BC]
    mov     [bp+var_FC], al
    mov     [bp+var_12A], 0
    cmp     [bp+elem_map_value], 0
    jnz     short loc_1BFB0
    jmp     loc_1AD4A
loc_1BFB0:
    mov     al, [bp+elem_map_value]
loc_1BFB3:
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_trkobject_ptr], ax
    mov     bx, ax
    mov     al, [bx+TRACKOBJECT.ss_multiTileFlag]
    cbw
    or      ax, ax
    jnz     short loc_1BFD5
    jmp     loc_1AD18
loc_1BFD5:
    cmp     ax, 1
    jnz     short loc_1BFDD
    jmp     loc_1AD26
loc_1BFDD:
    cmp     ax, 2
    jnz     short loc_1BFE5
    jmp     loc_1AD34
loc_1BFE5:
    cmp     ax, 3
    jnz     short loc_1BFED
    jmp     loc_1AD3C
loc_1BFED:
    jmp     loc_1AD55
loc_1BFF0:
    mov     [bp+var_rectptr], offset rect_unk15
    jmp     short loc_1C009
    ; align 2
    db 144
loc_1BFF8:
    or      si, si
    jnz     short loc_1C002
    lea     ax, [bp+var_rect]
    jmp     short loc_1C006
    ; align 2
    db 144
loc_1C002:
    lea     ax, [bp+var_rect2]
loc_1C006:
    mov     [bp+var_rectptr], ax
loc_1C009:
    push    [bp+arg_cliprectptr]
    push    [bp+var_rectptr]
    call    rect_intersect
    add     sp, 4
    or      al, al
    jz      short loc_1C01E
    jmp     loc_1C0C1
loc_1C01E:
    mov     bx, [bp+var_rectptr]
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    mov     bx, [bp+var_rectptr]
    mov     ax, [bx+RECTANGLE.rc_right]
    add     ax, [bx+RECTANGLE.rc_left]
    sar     ax, 1
    mov     [bp+var_vec6.vx], ax
    mov     ax, [bx+RECTANGLE.rc_top]
    add     ax, [bx+RECTANGLE.rc_bottom]
    sar     ax, 1
    mov     [bp+var_vec6.vy], ax
    mov     ax, [bx+RECTANGLE.rc_right]
    sub     ax, [bx+RECTANGLE.rc_left]
    mov     [bp+var_multitileflag], ax
    mov     ax, [bx+RECTANGLE.rc_bottom]
    sub     ax, [bx+RECTANGLE.rc_top]
    mov     [bp+var_counter], ax
    mov     ax, [bp+var_multitileflag]
    cmp     [bp+var_counter], ax
    jle     short loc_1C070
    mov     ax, [bp+var_counter]
    mov     [bp+var_multitileflag], ax
loc_1C070:
    mov     ax, state.game_frame
    shr     ax, 1
    shr     ax, 1
    sub     dx, dx
    mov     cx, 3
    div     cx
    mov     di, dx
    mov     bx, di
    shl     bx, 1
    mov     ax, sdgame2_widths[bx]; lookup width of explotion shape
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_multitileflag]
    cwd
    mov     dh, dl
    mov     dl, ah
    mov     ah, al
    sub     al, al
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+var_counter], ax
    push    [bp+var_vec6.vy]
    push    [bp+var_vec6.vx]
    mov     bx, di
    shl     bx, 1
    shl     bx, 1
    push    word ptr (sdgame2shapes+2)[bx]
    push    word ptr sdgame2shapes[bx]; loops up one of the three explotion anim shapes
    push    ax
    call    shape_op_explosion
    add     sp, 0Ah
loc_1C0C1:
    inc     si
loc_1C0C2:
    cmp     si, 2
    jge     short loc_1C0E8
    cmp     [bp+si+var_DC], 0
    jz      short loc_1C0C1
    cmp     timertestflag_copy, 0
    jnz     short loc_1C0D8
    jmp     loc_1BFF8
loc_1C0D8:
    or      si, si
    jz      short loc_1C0DF
    jmp     loc_1BFF0
loc_1C0DF:
    mov     [bp+var_rectptr], offset rect_unk12
    jmp     loc_1C009
    ; align 2
    db 144
loc_1C0E8:
    mov     bx, [bp+arg_cliprectptr]
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    cmp     cameramode, 0
    jz      short loc_1C10A
    jmp     loc_1C1C6
loc_1C10A:
    cmp     followOpponentFlag, 0
    jz      short loc_1C11E
    mov     [bp+var_stateptr], offset state.opponentstate
    mov     si, state.game_oEndFrame
    jmp     short loc_1C128
    ; align 2
    db 144
loc_1C11E:
    mov     [bp+var_stateptr], offset state.playerstate
    mov     si, state.game_pEndFrame
loc_1C128:
    mov     bx, [bp+var_stateptr]
    cmp     [bx+CARSTATE.car_crashBmpFlag], 1
    jnz     short loc_1C17C
    cmp     timertestflag_copy, 0
    jz      short loc_1C162
    mov     ax, offset rect_unk
    push    ax
    push    ax
    mov     bx, [bp+arg_cliprectptr]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    sub     ax, [bx+RECTANGLE.rc_top]
    push    ax
    push    [bx+RECTANGLE.rc_top]
    mov     ax, state.game_frame
    sub     ax, si
    push    ax
    push    cs
    call near ptr init_crak
loc_1C156:
    add     sp, 6
    push    ax
    call    rect_union
    jmp     short loc_1C1C3
    ; align 2
    db 144
loc_1C162:
    mov     bx, [bp+arg_cliprectptr]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    sub     ax, [bx+RECTANGLE.rc_top]
    push    ax
    push    [bx+RECTANGLE.rc_top]
    mov     ax, state.game_frame
    sub     ax, si
    push    ax
    push    cs
    call near ptr init_crak
    jmp     short loc_1C1C3
    ; align 2
    db 144
loc_1C17C:
    mov     bx, [bp+var_stateptr]
    cmp     [bx+CARSTATE.car_crashBmpFlag], 2
    jnz     short loc_1C1C6
    cmp     timertestflag_copy, 0
    jz      short loc_1C1AC
    mov     ax, offset rect_unk
    push    ax
    push    ax
    mov     bx, [bp+arg_cliprectptr]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    sub     ax, [bx+RECTANGLE.rc_top]
    push    ax
    push    [bx+RECTANGLE.rc_top]
    mov     ax, state.game_frame
    sub     ax, si
    push    ax
    push    cs
    call near ptr do_sinking
    jmp     short loc_1C156
loc_1C1AC:
    mov     bx, [bp+arg_cliprectptr]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    sub     ax, [bx+RECTANGLE.rc_top]
    push    ax
    push    [bx+RECTANGLE.rc_top]
    mov     ax, state.game_frame
    sub     ax, si
    push    ax
    push    cs
    call near ptr do_sinking
loc_1C1C3:
    add     sp, 6
loc_1C1C6:
    cmp     game_replay_mode, 0
    jz      short loc_1C1D0
    jmp     loc_1C25B
loc_1C1D0:
    cmp     state.game_inputmode, 0
    jnz     short loc_1C1DA
    jmp     loc_1C25B
loc_1C1DA:
    sub     ax, ax
    push    ax              ; int
    mov     ax, elapsed_time1
    add     ax, elapsed_time2
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    format_frame_as_string; prints elapsed time (unless in pause/replay, or some unknown state)
    add     sp, 6
    push    word ptr fontledresptr+2
    push    word ptr fontledresptr
    call    font_set_fontdef2
    add     sp, 4
    cmp     timertestflag_copy, 0
    jz      short loc_1C238
    mov     ax, offset rect_unk11
    push    ax
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, roofbmpheight
    add     ax, 2
    push    ax
    mov     ax, 8Ch ; 'Œ'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    push    ax
    call    rect_union
    add     sp, 6
    jmp     short loc_1C256
    ; align 4
    db 144
    db 144
loc_1C238:
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, roofbmpheight
    add     ax, 2
    push    ax
    mov     ax, 8Ch ; 'Œ'
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
loc_1C256:
    call    font_set_fontdef
loc_1C25B:
    cmp     timertestflag_copy, 0
    jnz     short loc_1C265
    jmp     loc_1C2F8
loc_1C265:
    mov     ax, offset rect_unk
    push    ax
    push    ax
    push    cs
    call near ptr draw_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
    cmp     [bp+var_132], 0
    jz      short loc_1C2AE
    mov     ax, [bp+arg_cliprectptr]
    push    si
    push    di
    mov     di, offset rect_unk
    mov     si, ax
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     si, 1
loc_1C293:
    mov     bx, si
    mov     cl, 3
    shl     bx, cl
    push    si
    push    di
    lea     di, rect_unk.rc_left[bx]
    mov     si, offset cliprect_unk
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    inc     si
    cmp     si, 0Fh
    jl      short loc_1C293
loc_1C2AE:
    sub     si, si
loc_1C2B0:
    mov     ax, si
    mov     cl, 3
    shl     ax, cl
    mov     word ptr [bp+var_lastpos2lookup], ax
    mov     bx, ax
    lea     ax, rect_unk.rc_left[bx]
    mov     bx, word ptr [bp+var_lastpos2lookup]
    add     bx, rectptr_unk
    push    si
    push    di
    mov     di, bx
    mov     si, ax
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    inc     si
    cmp     si, 0Fh
    jl      short loc_1C2B0
    mov     al, [bp+arg_0]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, [bp+var_angY]
    mov     word_449FC[bx], ax
    mov     ax, [bp+var_angY]
    mov     word_463D6, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_1C2F8:
    push    cs
    call near ptr draw_ingame_text
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
update_frame endp
skybox_op_helper2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_rectptr = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    cmp     timertestflag2, 4
    jz      short loc_1C320
    mov     si, [bp+arg_4]
    mov     bx, [bp+arg_rectptr]
    sub     si, [bx+RECTANGLE.rc_top]
    sub     si, skybox_current
    jmp     short loc_1C329
loc_1C320:
    mov     si, [bp+arg_4]
    mov     bx, [bp+arg_rectptr]
    sub     si, [bx+RECTANGLE.rc_top]
loc_1C329:
    mov     ax, [bx+RECTANGLE.rc_bottom]
    sub     ax, [bx+RECTANGLE.rc_top]
    cmp     ax, si
    jge     short loc_1C339
    mov     si, [bx+RECTANGLE.rc_bottom]
    sub     si, [bx+RECTANGLE.rc_top]
loc_1C339:
    or      si, si
    jle     short loc_1C35F
    mov     ax, [bx+RECTANGLE.rc_top]
    add     ax, si
    push    ax
    push    [bx+RECTANGLE.rc_top]
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_sky_color
    call    sprite_clear_1_color
    add     sp, 2
loc_1C35F:
    cmp     timertestflag2, 4
    jnz     short loc_1C369
    jmp     loc_1C432
loc_1C369:
    mov     si, [bp+arg_2]
    add     si, 200h
smart
    and     si, 3FFh
nosmart
    sub     si, 400h
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bp+arg_4]
    cmp     [bx+RECTANGLE.rc_top], ax
    jl      short loc_1C386
    jmp     loc_1C432
loc_1C386:
    sub     ax, word_454CE
    cmp     ax, [bx+RECTANGLE.rc_bottom]
    jle     short loc_1C392
    jmp     loc_1C432
loc_1C392:
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    mov     ax, [bp+arg_4]
    sub     ax, skybox_ptr1
    push    ax
    push    si
    push    word ptr skyboxes+2
    push    word ptr skyboxes
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     ax, [bp+arg_4]
    sub     ax, skybox_ptr2
    push    ax
    lea     ax, [si+140h]
    push    ax
    push    word ptr skyboxes+6
    push    word ptr skyboxes+4
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     ax, [bp+arg_4]
    sub     ax, skybox_ptr3
    push    ax
    lea     ax, [si+200h]
    push    ax
    push    word ptr skyboxes+0Ah
    push    word ptr skyboxes+8
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     ax, [bp+arg_4]
    sub     ax, skybox_ptr4
    push    ax
    lea     ax, [si+340h]
    push    ax
    push    word ptr skyboxes+0Eh
    push    word ptr skyboxes+0Ch
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     ax, [bp+arg_4]
    sub     ax, skybox_ptr1
    push    ax
    lea     ax, [si+400h]
    push    ax
    push    word ptr skyboxes+2
    push    word ptr skyboxes
    call    sprite_putimage_and_alt
    add     sp, 8
loc_1C432:
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bp+arg_4]
    cmp     [bx+RECTANGLE.rc_top], ax
    jle     short loc_1C442
    mov     di, [bx+RECTANGLE.rc_top]
    jmp     short loc_1C445
loc_1C442:
    mov     di, [bp+arg_4]
loc_1C445:
    mov     si, [bx+RECTANGLE.rc_bottom]
    sub     si, di
    or      si, si
    jle     short loc_1C46D
    mov     ax, di
    add     ax, si
    push    ax
    push    di
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_grd_color
    call    sprite_clear_1_color
    add     sp, 2
loc_1C46D:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
skybox_op_helper2 endp
skybox_op proc far
    var_78 = byte ptr -120
    var_76 = word ptr -118
    var_72 = word ptr -114
    var_6E = word ptr -110
    var_5C = word ptr -92
    var_5A = word ptr -90
    var_58 = word ptr -88
    var_56 = word ptr -86
    var_54 = word ptr -84
    var_skyheight = word ptr -80
    var_point = POINT2D ptr -78
    var_point2 = POINT2D ptr -74
    var_point3 = POINT2D ptr -70
    var_point4 = POINT2D ptr -66
    var_point5 = POINT2D ptr -62
    var_point6 = POINT2D ptr -58
    var_34 = word ptr -52
    var_32 = word ptr -50
    var_rect = RECTANGLE ptr -48
    var_rectptr = word ptr -40
    var_26 = word ptr -38
    var_vec = VECTOR ptr -36
    var_vec2 = VECTOR ptr -30
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_rectptr = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18

    push    bp
    mov     bp, sp
    sub     sp, 78h
    push    di
    push    si
    mov     rect_array_unk3_length, 0
    mov     [bp+var_5C], 0
    mov     bx, [bp+arg_rectptr]
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    cmp     [bp+arg_8], 0
    jnz     short loc_1C4A7
    jmp     loc_1C958
loc_1C4A7:
    mov     ax, 4650h
    imul    [bp+arg_4]
    mov     [bp+var_58], ax
    mov     ax, [bp+arg_C]
    neg     ax
    mov     [bp+var_56], ax
    mov     ax, 3A98h
    imul    [bp+arg_4]
    mov     [bp+var_54], ax
    lea     ax, [bp+var_vec]
    push    ax
    push    [bp+arg_6]
    lea     ax, [bp+var_58]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, 0B9B0h
    imul    [bp+arg_4]
    mov     [bp+var_58], ax
    lea     ax, [bp+var_vec2]
    push    ax
    push    [bp+arg_6]
    lea     ax, [bp+var_58]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_vec.vz], 0
    jl      short loc_1C4FC
    cmp     [bp+var_vec2.vz], 0
    jge     short loc_1C51C
loc_1C4FC:
    mov     di, skybox_sky_color
loc_1C500:
    mov     bx, [bp+arg_rectptr]
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    di
    jmp     loc_1CB6A
loc_1C51C:
    lea     ax, [bp+var_point]
    push    ax
    lea     ax, [bp+var_vec]
    push    ax
    call    vector_to_point
    add     sp, 4
    lea     ax, [bp+var_point2]
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    vector_to_point
    add     sp, 4
    cmp     [bp+var_point.x2], 140h
    jle     short loc_1C558
    cmp     [bp+var_point2.x2], 140h
    jle     short loc_1C558
    mov     ax, [bp+var_point2.y2]
    cmp     [bp+var_point.y2], ax
    jl      short loc_1C4FC
loc_1C552:
    mov     di, skybox_grd_color
    jmp     short loc_1C500
loc_1C558:
    cmp     [bp+var_point.x2], 0
    jge     short loc_1C56E
    cmp     [bp+var_point2.x2], 0
    jge     short loc_1C56E
    mov     ax, [bp+var_point2.y2]
    cmp     [bp+var_point.y2], ax
loc_1C56A:
    jle     short loc_1C552
    jmp     short loc_1C4FC
loc_1C56E:
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bp+var_point.y2]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jge     short loc_1C58A
    mov     ax, [bp+var_point2.y2]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jge     short loc_1C58A
    mov     ax, [bp+var_point2.x2]
    cmp     [bp+var_point.x2], ax
    jmp     short loc_1C56A
    ; align 2
    db 144
loc_1C58A:
    mov     ax, [bp+var_point.y2]
    cmp     [bx+RECTANGLE.rc_top], ax
    jle     short loc_1C5A6
    mov     ax, [bp+var_point2.y2]
    cmp     [bx+RECTANGLE.rc_top], ax
    jle     short loc_1C5A6
    mov     ax, [bp+var_point2.x2]
    cmp     [bp+var_point.x2], ax
    jge     short loc_1C552
    jmp     loc_1C4FC
    ; align 2
    db 144
loc_1C5A6:
    mov     [bp+var_5A], 0
    cmp     timertestflag2, 4
    jz      short loc_1C61D
    cmp     [bp+var_point2.x2], 0
    jge     short loc_1C61D
    cmp     [bp+var_point.x2], 140h
    jle     short loc_1C61D
    lea     ax, [bp+var_78]
    push    ax
    push    [bp+var_point.y2]
    push    [bp+var_point.x2]
    push    [bp+var_point2.y2]
    push    [bp+var_point2.x2]
    call    draw_line_related
    add     sp, 0Ah
    or      ax, ax
    jnz     short loc_1C61D
    mov     di, [bp+var_72]
    sub     di, [bp+var_6E]
    jns     short loc_1C5EA
    mov     ax, di
    neg     ax
    jmp     short loc_1C5EC
    ; align 2
    db 144
loc_1C5EA:
    mov     ax, di
loc_1C5EC:
    cmp     ax, 60h ; '`'
    jge     short loc_1C61D
    cmp     [bp+var_76], 0
    jnz     short loc_1C602
    mov     ax, [bp+var_72]
    mov     [bp+var_32], ax
    mov     ax, [bp+var_6E]
    jmp     short loc_1C612
loc_1C602:
    cmp     [bp+var_76], 13Fh
    jnz     short loc_1C61D
    mov     ax, [bp+var_6E]
    mov     [bp+var_32], ax
    mov     ax, [bp+var_72]
loc_1C612:
    sub     ax, [bp+var_32]
    mov     [bp+var_26], ax
    mov     [bp+var_5A], 1
loc_1C61D:
    cmp     [bp+var_5A], 0
    jnz     short loc_1C626
    jmp     loc_1C852
loc_1C626:
    cmp     timertestflag_copy, 0
    jnz     short loc_1C630
    jmp     loc_1C7B6
loc_1C630:
    mov     [bp+var_rect.rc_left], 0
    mov     rect_skybox.rc_left, 0
    mov     [bp+var_rect.rc_right], 140h
    mov     rect_skybox.rc_right, 140h
    cmp     byte_454A4, 0
    jz      short loc_1C660
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     rect_skybox.rc_top, ax
    mov     ax, [bx+RECTANGLE.rc_bottom]
    mov     rect_skybox.rc_bottom, ax
    jmp     loc_1C7AA
    ; align 2
    db 144
loc_1C660:
    mov     ax, [bp+var_32]
    add     ax, [bp+var_26]
    cmp     ax, [bp+var_32]
    jle     short loc_1C66E
    mov     ax, [bp+var_32]
loc_1C66E:
    sub     ax, word_454CE
    mov     rect_skybox.rc_top, ax
    mov     bx, [bp+arg_rectptr]
    cmp     [bx+RECTANGLE.rc_top], ax
    jle     short loc_1C683
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     rect_skybox.rc_top, ax
loc_1C683:
    mov     ax, [bp+var_32]
    add     ax, [bp+var_26]
    cmp     ax, [bp+var_32]
    jge     short loc_1C691
    mov     ax, [bp+var_32]
loc_1C691:
    mov     rect_skybox.rc_bottom, ax
    sub     si, si
loc_1C696:
    mov     rect_array_unk_indices[si], 1
    inc     si
    cmp     si, 0Fh
    jl      short loc_1C696
    mov     rect_array_unk_indices+5, 3
    mov     [bp+var_rect.rc_top], 0
    mov     ax, rect_skybox.rc_top
    mov     [bp+var_rect.rc_bottom], ax
    push    [bp+arg_rectptr]
    lea     ax, [bp+var_rect]
    push    ax
    call    rect_intersect
    add     sp, 4
    or      al, al
    jnz     short loc_1C728
    mov     rect_array_unk3_length, 0
    mov     ax, offset rect_array_unk3
    push    ax
    mov     ax, offset rect_array_unk3_length
    push    ax
    lea     ax, [bp+var_rect]
    push    ax
    mov     ax, offset rect_unk
    push    ax
    push    rectptr_unk
    mov     ax, offset rect_array_unk_indices
    push    ax
    mov     ax, 0Fh         ; number of rects
    push    ax
    call    rectlist_add_rects
    add     sp, 0Eh
    sub     di, di
    jmp     short loc_1C720
    ; align 2
    db 144
loc_1C6F2:
    mov     ax, di
    mov     cl, 3
    shl     ax, cl
    add     ax, offset rect_array_unk3
    mov     [bp+var_rectptr], ax
    mov     bx, ax
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_sky_color
    call    sprite_clear_1_color
    add     sp, 2
    inc     di
loc_1C720:
    mov     al, rect_array_unk3_length
    cbw
    cmp     ax, di
    jg      short loc_1C6F2
loc_1C728:
    mov     ax, rect_skybox.rc_bottom
    mov     [bp+var_rect.rc_top], ax
    mov     [bp+var_rect.rc_bottom], 0C8h ; 'È'
    push    [bp+arg_rectptr]
    lea     ax, [bp+var_rect]
    push    ax
    call    rect_intersect
    add     sp, 4
    or      al, al
    jnz     short loc_1C7AA
    mov     rect_array_unk3_length, 0
    mov     ax, offset rect_array_unk3
    push    ax
    mov     ax, offset rect_array_unk3_length
    push    ax
    lea     ax, [bp+var_rect]
    push    ax
    mov     ax, offset rect_unk
    push    ax
    push    rectptr_unk
    mov     ax, offset rect_array_unk_indices
    push    ax
    mov     ax, 0Fh         ; number of rects
    push    ax
    call    rectlist_add_rects
    add     sp, 0Eh
    sub     di, di
    jmp     short loc_1C7A2
    ; align 2
    db 144
loc_1C774:
    mov     ax, di
    mov     cl, 3
    shl     ax, cl
    add     ax, offset rect_array_unk3
    mov     [bp+var_rectptr], ax
    mov     bx, ax
    push    [bx+RECTANGLE.rc_bottom]
    push    [bx+RECTANGLE.rc_top]
    push    [bx+RECTANGLE.rc_right]
    push    [bx+RECTANGLE.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_grd_color
    call    sprite_clear_1_color
    add     sp, 2
    inc     di
loc_1C7A2:
    mov     al, rect_array_unk3_length
    cbw
    cmp     ax, di
    jg      short loc_1C774
loc_1C7AA:
    mov     ax, rect_skybox.rc_top
    mov     [bp+var_rect.rc_top], ax
    mov     ax, rect_skybox.rc_bottom
    jmp     short loc_1C7C2
    ; align 2
    db 144
loc_1C7B6:
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+4]
    mov     [bp+var_rect.rc_top], ax
    mov     ax, [bx+6]
loc_1C7C2:
    mov     [bp+var_rect.rc_bottom], ax
    mov     [bp+var_rect.rc_left], 0
    mov     [bp+var_rect.rc_right], 140h
    push    [bp+arg_rectptr]
    lea     ax, [bp+var_rect]
    push    ax
    call    rect_intersect
    add     sp, 4
    or      al, al
    jz      short loc_1C7E5
    jmp     loc_1CB77
loc_1C7E5:
    mov     [bp+var_34], 0
    cmp     [bp+var_26], 0
    jge     short loc_1C7F8
    mov     ax, [bp+var_26]
    neg     ax
    jmp     short loc_1C7FB
    ; align 2
    db 144
loc_1C7F8:
    mov     ax, [bp+var_26]
loc_1C7FB:
    mov     di, ax
    inc     di
    cmp     di, 20h ; ' '
    jle     short loc_1C806
    mov     di, 20h ; ' '
loc_1C806:
    sub     si, si
    jmp     short loc_1C84B
loc_1C80A:
    mov     ax, [bp+var_34]
    mov     [bp+var_rect.rc_left], ax
    mov     ax, 140h
    imul    si
    add     ax, 140h
    cwd
    idiv    di
    and     ax, video_flag3_isFFFF
    mov     [bp+var_rect.rc_right], ax
    cmp     [bp+var_rect.rc_left], ax
    jz      short loc_1C84A
    mov     ax, [bp+var_26]
    imul    si
    cwd
    idiv    di
    add     ax, [bp+var_32]
    mov     [bp+var_skyheight], ax
    push    ax
    push    [bp+arg_A]
    lea     ax, [bp+var_rect]
    push    ax
    push    cs
    call near ptr skybox_op_helper2
    add     sp, 6
    mov     ax, [bp+var_rect.rc_right]
    mov     [bp+var_34], ax
loc_1C84A:
    inc     si
loc_1C84B:
    cmp     si, di
    jl      short loc_1C80A
    jmp     loc_1CB77
loc_1C852:
    mov     ax, [bp+var_point.y2]
    sub     ax, [bp+var_point2.y2]
    push    ax
    mov     ax, [bp+var_point.x2]
    sub     ax, [bp+var_point2.x2]
    push    ax
    call    polarAngle
    add     sp, 4
    mov     si, ax
smart
    and     si, 3FFh
nosmart
    mov     [bp+var_26], 2
    jmp     short loc_1C8F0
    ; align 2
    db 144
loc_1C876:
    mov     di, 1
loc_1C879:
    mov     bx, [bp+var_26]
    shl     bx, 1
    mov     ax, [bx+98Ch]
    add     ax, si
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    mov     ax, 3E80h
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, di
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    mov     cx, [bx-4Eh]
    add     cx, ax
    mov     bx, [bp+var_26]
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    mov     [bx-4Eh], cx
    mov     bx, [bp+var_26]
    shl     bx, 1
    mov     ax, [bx+98Ch]
    add     ax, si
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    mov     ax, 3E80h
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, di
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    mov     cx, [bx-4Ch]
    add     cx, ax
    mov     bx, [bp+var_26]
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    mov     [bx-4Ch], cx
    inc     [bp+var_26]
loc_1C8F0:
    cmp     [bp+var_26], 6
    jge     short loc_1C904
    cmp     [bp+var_26], 4
    jl      short loc_1C8FF
    jmp     loc_1C876
loc_1C8FF:
    sub     di, di
    jmp     loc_1C879
loc_1C904:
    push    [bp+var_point3.y2]
    push    [bp+var_point3.x2]
    push    [bp+var_point4.y2]
    push    [bp+var_point4.x2]
    push    [bp+var_point2.y2]
    push    [bp+var_point2.x2]
    push    [bp+var_point.y2]
    push    [bp+var_point.x2]
    mov     ax, 4
    push    ax
    push    skybox_sky_color
    call    skybox_op_helper
    add     sp, 14h
    push    [bp+var_point6.y2]
    push    [bp+var_point6.x2]
    push    [bp+var_point5.y2]
    push    [bp+var_point5.x2]
    push    [bp+var_point2.y2]
    push    [bp+var_point2.x2]
    push    [bp+var_point.y2]
    push    [bp+var_point.x2]
    mov     ax, 4
    push    ax
    push    skybox_grd_color
    call    skybox_op_helper
    add     sp, 14h
    jmp     loc_1CB72
    ; align 2
    db 144
loc_1C958:
    mov     [bp+var_58], 0
    mov     ax, [bp+arg_C]
    neg     ax
    mov     [bp+var_56], ax
    mov     ax, 3A98h
    imul    [bp+arg_4]
    mov     [bp+var_54], ax
    lea     ax, [bp+var_vec]
    push    ax
    push    [bp+arg_6]
    lea     ax, [bp+var_58]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_vec.vz], 0
    jge     short loc_1C9C0
    push    skybox_sky_color
    call    sprite_clear_1_color
    add     sp, 2
    cmp     timertestflag_copy, 0
    jnz     short loc_1C99D
    jmp     loc_1CB77
loc_1C99D:
    mov     [bp+var_5C], 1
    mov     rect_skybox.rc_left, 0
    mov     rect_skybox.rc_right, 140h
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     rect_skybox.rc_top, ax
    mov     ax, [bx+RECTANGLE.rc_bottom]
    mov     rect_skybox.rc_bottom, ax
    jmp     loc_1CB77
loc_1C9C0:
    lea     ax, [bp+var_point]
    push    ax
    lea     ax, [bp+var_vec]
    push    ax
    call    vector_to_point
    add     sp, 4
    mov     ax, [bp+var_point.y2]
    mov     [bp+var_skyheight], ax
    mov     bx, [bp+arg_rectptr]
    cmp     [bx+RECTANGLE.rc_top], ax
    jle     short loc_1C9E4
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     [bp+var_skyheight], ax
loc_1C9E4:
    cmp     [bp+arg_4], 1
    jz      short loc_1C9ED
    jmp     loc_1CB00
loc_1C9ED:
    cmp     timertestflag_copy, 0
    jz      short loc_1CA25
    cmp     timertestflag2, 4
    jnz     short loc_1CA02
    mov     ax, [bp+var_skyheight]
    dec     ax
    jmp     short loc_1CA09
    ; align 2
    db 144
loc_1CA02:
    mov     ax, [bp+var_skyheight]
    sub     ax, word_454CE
loc_1CA09:
    mov     rect_skybox.rc_top, ax
    mov     rect_skybox.rc_left, 0
    mov     rect_skybox.rc_right, 140h
    mov     ax, [bp+var_skyheight]
    mov     rect_skybox.rc_bottom, ax
    cmp     byte_454A4, 0
    jz      short loc_1CA52
loc_1CA25:
    mov     [bp+var_rect.rc_left], 0
    mov     [bp+var_rect.rc_right], 140h
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     [bp+var_rect.rc_top], ax
    mov     ax, [bx+RECTANGLE.rc_bottom]
    mov     [bp+var_rect.rc_bottom], ax
    push    [bp+var_skyheight]
    push    [bp+arg_A]
    lea     ax, [bp+var_rect]
    push    ax
    push    cs
    call near ptr skybox_op_helper2
    add     sp, 6
    jmp     loc_1CB77
loc_1CA52:
    sub     si, si
loc_1CA54:
    mov     rect_array_unk_indices[si], 1
    inc     si
    cmp     si, 0Fh
    jl      short loc_1CA54
    cmp     timertestflag2, 4
    jnz     short loc_1CA72
    mov     bx, [bp+arg_0]
    shl     bx, 1
    mov     ax, word_463D6
    mov     word_449FC[bx], ax
loc_1CA72:
    mov     bx, [bp+arg_0]
    shl     bx, 1
    mov     ax, [bp+arg_A]
    cmp     word_449FC[bx], ax
    jnz     short loc_1CAAC
    mov     bx, rectptr_unk
    mov     ax, rect_skybox.rc_left
    cmp     [bx+28h], ax
    jnz     short loc_1CAAC
    mov     ax, rect_skybox.rc_right
    cmp     [bx+2Ah], ax
    jnz     short loc_1CAAC
    mov     ax, rect_skybox.rc_top
    cmp     [bx+2Ch], ax
    jnz     short loc_1CAAC
    mov     ax, rect_skybox.rc_bottom
    cmp     [bx+2Eh], ax
    jnz     short loc_1CAAC
    mov     rect_array_unk_indices+5, 0
    jmp     short loc_1CAB1
    ; align 2
    db 144
loc_1CAAC:
    mov     rect_array_unk_indices+5, 3
loc_1CAB1:
    mov     rect_array_unk3_length, 0
    mov     ax, offset rect_array_unk3
    push    ax
    mov     ax, offset rect_array_unk3_length
    push    ax
    push    [bp+arg_rectptr]
    mov     ax, offset rect_unk
    push    ax
    push    rectptr_unk
    mov     ax, offset rect_array_unk_indices
    push    ax
    mov     ax, 0Fh         ; number of rects
    push    ax
    call    rectlist_add_rects
    add     sp, 0Eh
    sub     di, di
    jmp     short loc_1CAF6
    ; align 2
    db 144
loc_1CADE:
    push    [bp+var_skyheight]
    push    [bp+arg_A]
    mov     ax, di
    mov     cl, 3
    shl     ax, cl
    add     ax, offset rect_array_unk3
    push    ax
    push    cs
    call near ptr skybox_op_helper2
    add     sp, 6
    inc     di
loc_1CAF6:
    mov     al, rect_array_unk3_length
    cbw
    cmp     ax, di
    jg      short loc_1CADE
    jmp     short loc_1CB77
loc_1CB00:
    mov     si, [bp+var_skyheight]
    mov     bx, [bp+arg_rectptr]
    sub     si, [bx+RECTANGLE.rc_top]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    sub     ax, [bx+RECTANGLE.rc_top]
    cmp     ax, si
    jge     short loc_1CB19
    mov     si, [bx+RECTANGLE.rc_bottom]
    sub     si, [bx+RECTANGLE.rc_top]
loc_1CB19:
    or      si, si
    jle     short loc_1CB41
    mov     ax, [bx+RECTANGLE.rc_top]
    add     ax, si
    push    ax
    push    [bx+RECTANGLE.rc_top]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_grd_color
    call    sprite_clear_1_color
    add     sp, 2
loc_1CB41:
    mov     bx, [bp+arg_rectptr]
    mov     si, [bx+RECTANGLE.rc_bottom]
    sub     si, [bp+var_skyheight]
    or      si, si
    jle     short loc_1CB72
    mov     ax, [bp+var_skyheight]
    add     ax, si
    push    ax
    push    [bp+var_skyheight]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_sky_color
loc_1CB6A:
    call    sprite_clear_1_color
    add     sp, 2
loc_1CB72:
    mov     [bp+var_5C], 1
loc_1CB77:
    mov     ax, [bp+var_5C]
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
skybox_op endp
transformed_shape_add_for_sort proc far
    transformedpos = VECTOR ptr -12
    shapepos = VECTOR ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_zadjust = word ptr 6
    arg_2 = byte ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    di
    push    si
    mov     ax, curtransshape_ptr
    push    si
    push    di
    lea     di, [bp+shapepos]
    mov     si, ax          ; ax = offset to the first member of curtransshape_ptr, the pos vector
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    lea     ax, [bp+transformedpos]
    push    ax
    mov     ax, offset mat_temp
    push    ax
    lea     ax, [bp+shapepos]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     al, transformedshape_counter
    cbw
    mov     si, ax
    mov     di, si
    shl     di, 1
    mov     ax, [bp+transformedpos.vz]
    add     ax, [bp+arg_zadjust]
    mov     transformedshape_zarray[di], ax
    mov     al, [bp+arg_2]
    mov     transformedshape_arg2array[si], al
    mov     transformedshape_indices[di], si
    inc     transformedshape_counter
    add     curtransshape_ptr, 14h
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
transformed_shape_add_for_sort endp
draw_track_preview proc far
    var_42 = word ptr -66
    var_40 = word ptr -64
    var_3E = word ptr -62
    var_3C = byte ptr -60
    var_3A = byte ptr -58
    var_38 = byte ptr -56
    var_36 = byte ptr -54
    var_34 = word ptr -52
    var_32 = byte ptr -50
    var_30 = word ptr -48
    var_2E = byte ptr -46
    var_2C = word ptr -44
    var_2A = word ptr -42
    var_28 = word ptr -40
    var_transshape = TRANSFORMEDSHAPE ptr -38
    var_12 = word ptr -18
    var_10 = byte ptr -16
    var_vec = VECTOR ptr -12
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 42h
    push    di
    push    si
    mov     ax, word_3C112
    sub     ax, word_3C10C
    push    ax
    mov     ax, word_3C10E
    sub     ax, word_3C108
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_4], ax
    push    ax
    mov     ax, word_3C110
    sub     ax, word_3C10A
    push    ax
    call    polarAngle
    add     sp, 4
    mov     [bp+var_34], ax
    mov     ax, 1
    push    ax
    sub     ax, ax
    push    ax
    push    [bp+var_34]
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_28], ax
    lea     ax, [bp+var_vec]
    push    ax
    push    [bp+var_28]
    mov     ax, offset unk_3C114
    push    ax
    call    mat_mul_vector
    add     sp, 6
    lea     ax, [bp+var_2E]
    push    ax
    lea     ax, [bp+var_vec]
    push    ax
    call    vector_to_point
    add     sp, 4
    mov     ax, [bp+var_2C]
    mov     [bp+var_30], ax
    or      ax, ax
    jge     short loc_1CC5B
    mov     [bp+var_30], 0
loc_1CC5B:
    mov     ax, [bp+var_30]
    sub     ax, skybox_current
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_sky_color
    call    sprite_clear_1_color
    add     sp, 2
    mov     ax, 64h ; 'd'
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    mov     ax, [bp+var_30]
    sub     ax, skybox_ptr3
    push    ax
    sub     ax, ax
    push    ax
    push    word ptr skyboxes+0Ah
    push    word ptr skyboxes+8
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     ax, [bp+var_30]
    sub     ax, skybox_ptr4
    push    ax
    mov     ax, 140h
    push    ax
    push    word ptr skyboxes+0Eh
    push    word ptr skyboxes+0Ch
    call    sprite_putimage_and_alt
    add     sp, 8
    mov     ax, 0C8h ; 'È'
    push    ax
    push    [bp+var_30]
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_grd_color
    call    sprite_clear_1_color
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
    mov     ax, 1
    push    ax
    mov     ax, offset trackpreview_cliprect
    push    ax
    sub     ax, ax
    push    ax
    push    [bp+var_34]
    push    ax
    call    select_cliprect_rotate
    add     sp, 0Ah
    mov     [bp+var_transshape.ts_rotvec.vx], 0
    mov     [bp+var_transshape.ts_rotvec.vy], 0
    mov     [bp+var_transshape.ts_unk], 400h
    mov     [bp+var_38], 0
    jmp     loc_1D11B
    ; align 2
    db 144
loc_1CD34:
    mov     [bp+var_3A], 0
loc_1CD38:
    mov     [bp+var_10], 0
loc_1CD3C:
    cmp     [bp+var_3A], 6
    jz      short loc_1CD45
    jmp     loc_1CE04
loc_1CD45:
    mov     di, hillHeightConsts+2
    cmp     [bp+var_10], 0
    jz      short loc_1CD53
loc_1CD4F:
    mov     [bp+var_3A], 0
loc_1CD53:
    cmp     [bp+var_3A], 0
    jz      short loc_1CDCA
    mov     al, [bp+var_3A]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset sceneshapes2
    mov     [bp+var_3E], ax
    mov     bx, ax
    mov     ax, [bx+6]
    mov     [bp+var_transshape.ts_shapeptr], ax
    mov     al, [bp+var_32]
    cbw
    mov     bx, ax
loc_1CD7E:
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    sub     ax, word_3C108
    sar     ax, 1
    mov     [bp+var_transshape.ts_pos.vx], ax
    mov     ax, di
    sub     ax, word_3C10A
    sar     ax, 1
    mov     [bp+var_transshape.ts_pos.vy], ax
    mov     al, [bp+var_38]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    sub     ax, word_3C10C
    sar     ax, 1
    mov     [bp+var_transshape.ts_pos.vz], ax
    mov     bx, [bp+var_3E]
    mov     ax, [bx+2]
    mov     [bp+var_transshape.ts_rotvec.vz], ax
loc_1CDB6:
    mov     [bp+var_transshape.ts_flags], 5
    mov     [bp+var_transshape.ts_material], 0
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
    add     sp, 2
loc_1CDCA:
    cmp     [bp+var_10], 0
    jnz     short loc_1CDD3
    jmp     loc_1D086
loc_1CDD3:
    mov     al, [bp+var_10]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_3E], ax
    mov     bx, ax
    test    byte ptr [bx+0Bh], 1
    jnz     short loc_1CDF5
    jmp     loc_1CF14
loc_1CDF5:
    mov     al, [bp+var_38]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackpos[bx]
    jmp     loc_1CF20
loc_1CE04:
    sub     di, di
    mov     al, [bp+var_10]
    sub     ah, ah
    cmp     ax, 69h ; 'i'
    jnb     short loc_1CE13
    jmp     loc_1CD53
loc_1CE13:
    cmp     ax, 6Ch ; 'l'
    jbe     short loc_1CE1B
    jmp     loc_1CD53
loc_1CE1B:
    mov     [bp+var_2A], di
    jmp     loc_1CED0
    ; align 2
    db 144
loc_1CE22:
    mov     al, [bp+var_32]
loc_1CE25:
    mov     [bp+var_36], al
    mov     al, [bp+var_38]
loc_1CE2B:
    mov     [bp+var_3C], al
loc_1CE2E:
    mov     al, [bp+var_36]
    cbw
    mov     [bp+var_42], ax
    mov     al, [bp+var_3C]
    cbw
    shl     ax, 1
    mov     [bp+var_40], ax
    mov     bx, ax
    mov     bx, terrainrows[bx]
    add     bx, [bp+var_42]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_3A], al
    or      al, al
    jz      short loc_1CECD
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset sceneshapes2
    mov     [bp+var_3E], ax
    mov     bx, ax
    mov     ax, [bx+4]
    mov     [bp+var_transshape.ts_shapeptr], ax
    mov     bx, [bp+var_42]
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    sub     ax, word_3C108
    sar     ax, 1
    mov     [bp+var_transshape.ts_pos.vx], ax
    mov     ax, word_3C10A
    neg     ax
    sar     ax, 1
    mov     [bp+var_transshape.ts_pos.vy], ax
    mov     bx, [bp+var_40]
    mov     ax, trackcenterpos[bx]
    sub     ax, word_3C10C
    sar     ax, 1
    mov     [bp+var_transshape.ts_pos.vz], ax
    mov     [bp+var_transshape.ts_flags], 5
    mov     [bp+var_transshape.ts_rotvec.vx], 0
    mov     [bp+var_transshape.ts_rotvec.vy], 0
    mov     bx, [bp+var_3E]
    mov     ax, [bx+2]
    mov     [bp+var_transshape.ts_rotvec.vz], ax
    mov     [bp+var_transshape.ts_unk], 400h
    mov     [bp+var_transshape.ts_material], 0
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
loc_1CECA:
    add     sp, 2
loc_1CECD:
    inc     [bp+var_2A]
loc_1CED0:
    cmp     [bp+var_2A], 4
    jl      short loc_1CED9
    jmp     loc_1CD4F
loc_1CED9:
    mov     ax, [bp+var_2A]
    or      ax, ax
loc_1CEDE:
    jnz     short loc_1CEE3
    jmp     loc_1CE22
loc_1CEE3:
    cmp     ax, 1
    jz      short loc_1CEF6
    cmp     ax, 2
    jz      short loc_1CEFE
    cmp     ax, 3
    jz      short loc_1CF0C
loc_1CEF2:
    jmp     loc_1CE2E
    ; align 2
    db 144
loc_1CEF6:
    mov     al, [bp+var_32]
    inc     al
    jmp     loc_1CE25
loc_1CEFE:
    mov     al, [bp+var_32]
loc_1CF01:
    mov     [bp+var_36], al
loc_1CF04:
    mov     al, [bp+var_38]
    inc     al
    jmp     loc_1CE2B
loc_1CF0C:
    mov     al, [bp+var_32]
    inc     al
    jmp     short loc_1CF01
    ; align 2
    db 144
loc_1CF14:
    mov     al, [bp+var_38]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
loc_1CF20:
    mov     [bp+var_12], ax
    mov     bx, [bp+var_3E]
    test    byte ptr [bx+0Bh], 2
    jz      short loc_1CF3A
    mov     al, [bp+var_32]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     si, (trackpos2+2)[bx]
    jmp     short loc_1CF46
loc_1CF3A:
    mov     al, [bp+var_32]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     si, trackcenterpos2[bx]
loc_1CF46:
    mov     ax, si
    sub     ax, word_3C108
    sar     ax, 1
    mov     [bp+var_vec.vx], ax
    mov     ax, di
    sub     ax, word_3C10A
    sar     ax, 1
    mov     [bp+var_vec.vy], ax
    mov     ax, [bp+var_12]
    sub     ax, word_3C10C
    sar     ax, 1
    mov     [bp+var_vec.vz], ax
    or      di, di
    jz      short loc_1CFBF
    mov     bx, [bp+var_3E]
    mov     al, [bx+0Bh]
    cbw
    or      ax, ax
    jz      short loc_1CF92
    cmp     ax, 1
    jnz     short loc_1CF7F
    jmp     loc_1D01A
loc_1CF7F:
    cmp     ax, 2
    jnz     short loc_1CF87
    jmp     loc_1D022
loc_1CF87:
    cmp     ax, 3
    jnz     short loc_1CF8F
    jmp     loc_1D02A
loc_1CF8F:
    jmp     short loc_1CF97
    ; align 2
    db 144
loc_1CF92:
    mov     [bp+var_transshape.ts_shapeptr], (offset game3dshapes.shape3d_numverts+3B2h)
loc_1CF97:
    push    si
    push    di
    lea     di, [bp+var_transshape]
    lea     si, [bp+var_vec]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     [bp+var_transshape.ts_rotvec.vz], 0
    mov     [bp+var_transshape.ts_flags], 5
    mov     [bp+var_transshape.ts_material], 0
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
    add     sp, 2
loc_1CFBF:
    mov     bx, [bp+var_3E]
    cmp     byte ptr [bx+8], 0
    jz      short loc_1D042
    mov     al, [bx+8]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_2], ax
    mov     bx, ax
    cmp     word ptr [bx+6], 0
    jz      short loc_1D042
    mov     ax, [bx+6]
    mov     [bp+var_transshape.ts_shapeptr], ax
    push    si
    push    di
    lea     di, [bp+var_transshape]
    lea     si, [bp+var_vec]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     bx, [bp+var_3E]
    mov     ax, [bx+2]
    mov     [bp+var_transshape.ts_rotvec.vz], ax
    mov     [bp+var_transshape.ts_flags], 5
    mov     bx, [bp+var_2]
    cmp     byte ptr [bx+9], 0
    jl      short loc_1D032
    mov     al, [bx+9]
    mov     [bp+var_transshape.ts_material], al
    jmp     short loc_1D036
loc_1D01A:
    mov     [bp+var_transshape.ts_shapeptr], (offset game3dshapes.shape3d_numverts+7D2h)
    jmp     loc_1CF97
loc_1D022:
    mov     [bp+var_transshape.ts_shapeptr], (offset game3dshapes.shape3d_numverts+7E8h)
    jmp     loc_1CF97
loc_1D02A:
    mov     [bp+var_transshape.ts_shapeptr], (offset game3dshapes.shape3d_numverts+7FEh)
    jmp     loc_1CF97
loc_1D032:
    mov     [bp+var_transshape.ts_material], 0
loc_1D036:
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
    add     sp, 2
loc_1D042:
    mov     bx, [bp+var_3E]
    mov     ax, [bx+6]
    mov     [bp+var_transshape.ts_shapeptr], ax
    push    si
    push    di
    lea     di, [bp+var_transshape]
    lea     si, [bp+var_vec]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     ax, [bx+2]
    mov     [bp+var_transshape.ts_rotvec.vz], ax
    mov     al, [bx+0Ah]
    or      al, 4
    mov     [bp+var_transshape.ts_flags], al
    cmp     byte ptr [bx+9], 0
    jl      short loc_1D076
    mov     al, [bx+9]
    mov     [bp+var_transshape.ts_material], al
    jmp     short loc_1D07A
loc_1D076:
    mov     [bp+var_transshape.ts_material], 0
loc_1D07A:
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
    add     sp, 2
loc_1D086:
    call    get_a_poly_info
    inc     [bp+var_32]
loc_1D08E:
    cmp     [bp+var_32], 1Eh
    jl      short loc_1D097
    jmp     loc_1D118
loc_1D097:
    mov     al, [bp+var_32]
    cbw
    mov     [bp+var_40], ax
    mov     al, [bp+var_38]
    cbw
    shl     ax, 1
    mov     [bp+var_42], ax
    mov     bx, ax
    mov     bx, trackrows[bx]
    add     bx, [bp+var_40]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_10], al
    mov     bx, [bp+var_42]
    mov     bx, terrainrows[bx]
    add     bx, [bp+var_40]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_3A], al
    cmp     [bp+var_10], 0
    jnz     short loc_1D0DF
    jmp     loc_1CD3C
loc_1D0DF:
    cmp     al, 7
    jb      short loc_1D100
    cmp     al, 0Bh
    jnb     short loc_1D100
    mov     al, [bp+var_10]
    sub     ah, ah
    push    ax
    mov     al, [bp+var_3A]
    push    ax
    call    subst_hillroad_track
    add     sp, 4
    mov     [bp+var_10], al
    mov     [bp+var_3A], 0
loc_1D100:
    mov     al, [bp+var_10]
    sub     ah, ah
    cmp     ax, 0FDh ; 'ý'
    jnb     short loc_1D10D
    jmp     loc_1CD3C
loc_1D10D:
    cmp     ax, 0FFh
    ja      short loc_1D115
    jmp     loc_1CD34
loc_1D115:
    jmp     loc_1CD3C
loc_1D118:
    inc     [bp+var_38]
loc_1D11B:
    cmp     [bp+var_38], 1Eh
    jge     short loc_1D128
    mov     [bp+var_32], 0
    jmp     loc_1D08E
loc_1D128:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
draw_track_preview endp
draw_ingame_text proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    push    si
    mov     di, offset rect_ingame_text
    mov     si, offset cliprect_unk
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     si
    cmp     idle_expired, 0
    jnz     short loc_1D14E
    jmp     loc_1D1E6
loc_1D14E:
    mov     ax, offset aDm1 ; "Professional Driver"
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
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 0AAh ; 'ª'
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
    mov     ax, offset rect_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
    mov     ax, offset aDm2 ; on Closed Circuit
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
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 0B6h ; '¶'
loc_1D1D5:
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2_alt
    add     sp, 2
    jmp     loc_1D511
    ; align 2
    db 144
loc_1D1E6:
    cmp     game_replay_mode, 0
    jz      short loc_1D1F0
    jmp     loc_1D4B0
loc_1D1F0:
    cmp     state.game_inputmode, 0
    jnz     short loc_1D22A
    mov     ax, offset aPre ; Fasten Your Seatbelt
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
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 5Ah ; 'Z'
    jmp     short loc_1D1D5
    ; align 2
    db 144
loc_1D22A:
    cmp     passed_security, 0
    jz      short loc_1D234
    jmp     loc_1D2BE
loc_1D234:
    mov     ax, offset aSe1 ; You forgot to disable the
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
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 5Dh ; ']'
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
    mov     ax, offset rect_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
    mov     ax, offset aSe2 ; "Car's security system first"
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
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 69h ; 'i'
    jmp     loc_1D1D5
loc_1D2BE:
    cmp     followOpponentFlag, 0
    jz      short loc_1D2C8
    jmp     loc_1D52B
loc_1D2C8:
    cmp     cameramode, 0
    jz      short loc_1D2D2
    jmp     loc_1D52B
loc_1D2D2:
    cmp     state.playerstate.car_crashBmpFlag, 0
    jz      short loc_1D2DC
    jmp     loc_1D52B
loc_1D2DC:
    mov     al, state.field_45D
    cbw
    cmp     ax, 1
    jz      short loc_1D2F2
    cmp     ax, 2
    jz      short loc_1D338
    cmp     ax, 3
    jz      short loc_1D34A
    jmp     short loc_1D31E
    ; align 2
    db 144
loc_1D2F2:
    mov     ax, 5Dh ; ']'
    push    ax
    mov     ax, 94h ; '”'
    push    ax
    push    word ptr sdgame2shapes+0Eh; left arrow shape
    push    word ptr sdgame2shapes+0Ch; left arrow shape
loc_1D302:
    call    sprite_putimage_transparent
    add     sp, 8
    mov     ax, offset rect_ingame_text
    push    ax
    mov     ax, offset rect_ingame_text2
loc_1D311:
    push    ax
    mov     ax, offset rect_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
loc_1D31E:
    mov     resID_byte1, 0
    mov     al, state.field_45E
    cbw
    cmp     ax, 1
    jz      short loc_1D398
    cmp     ax, 2
    jnz     short loc_1D334
    jmp     loc_1D47E
loc_1D334:
    jmp     loc_1D3E6
    ; align 2
    db 144
loc_1D338:
    mov     ax, 5Dh ; ']'
    push    ax
    mov     ax, 94h ; '”'
    push    ax
    push    word ptr sdgame2shapes+12h; right arrow shape
    push    word ptr sdgame2shapes+10h; right arrow shape
    jmp     short loc_1D302
loc_1D34A:
    mov     ax, offset aWww ; "Wrong Way"
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
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 5Dh ; ']'
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
    jmp     loc_1D311
    ; align 2
    db 144
loc_1D398:
    mov     ax, 71h ; 'q'
    push    ax
    mov     ax, 44h ; 'D'
    push    ax
    push    word ptr sdgame2shapes+0Eh; left arrow shape
    push    word ptr sdgame2shapes+0Ch; left arrow shape
    call    sprite_putimage_transparent
    add     sp, 8
    mov     ax, offset rect_ingame_text
    push    ax
    mov     ax, offset rect_ingame_text3
    push    ax
    mov     ax, offset rect_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
    mov     ax, offset aOpp ; "Opponent Near"
loc_1D3C7:
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
loc_1D3E6:
    cmp     resID_byte1, 0
    jz      short loc_1D422
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 74h ; 't'
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
    mov     ax, offset rect_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
loc_1D422:
    cmp     show_penalty_counter, 0
    jnz     short loc_1D42C
    jmp     loc_1D52B
loc_1D42C:
    mov     ax, offset aPen ; "pen"
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
    sub     ax, ax
    push    ax              ; int
    push    penalty_time
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    add     ax, offset resID_byte1
    push    ax              ; char *
    call    format_frame_as_string
    add     sp, 6
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 66h ; 'f'
    jmp     loc_1D1D5
loc_1D47E:
    mov     ax, 71h ; 'q'
    push    ax
    mov     ax, 0E4h ; 'ä'
    push    ax
    push    word ptr sdgame2shapes+12h; right arrow shape
    push    word ptr sdgame2shapes+10h; right arrow shape
    call    sprite_putimage_transparent
    add     sp, 8
    mov     ax, offset rect_ingame_text
    push    ax
    mov     ax, offset rect_ingame_text4
    push    ax
    mov     ax, offset rect_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
    mov     ax, offset aOpp_0; "opp"
    jmp     loc_1D3C7
loc_1D4B0:
    cmp     game_replay_mode, 2
    jnz     short loc_1D52B
    mov     ax, state.game_frame
    sub     dx, dx
    div     framespersec
    mov     si, dx
    mov     ax, framespersec
    sar     ax, 1
    cmp     ax, si
    jle     short loc_1D52B
    mov     ax, offset aRpl_0; "rpl"
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
    mov     ax, offset rect_ingame_text
    push    ax
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    mov     ax, 0Fh
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    mov     cl, 3
    shl     ax, cl
    sub     ax, 138h
    neg     ax
loc_1D511:
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    intro_draw_text
    add     sp, 0Ah
    push    ax
    mov     ax, offset rect_ingame_text
    push    ax
    call    rect_union
    add     sp, 6
loc_1D52B:
    mov     ax, offset rect_ingame_text
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
draw_ingame_text endp
do_sinking proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    mov     di, framespersec
    mov     cl, 2
    shl     di, cl
    cmp     [bp+arg_0], di
    jle     short loc_1D54C
    mov     [bp+arg_0], di
loc_1D54C:
    mov     ax, framespersec
    shl     ax, 1
    shl     ax, 1
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_0]
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
    mov     si, ax
    mov     rect_ingame_text.rc_left, 0
    mov     rect_ingame_text.rc_right, 140h
    mov     di, [bp+arg_2]
    add     di, [bp+arg_4]
    mov     ax, di
    sub     ax, si
    mov     rect_ingame_text.rc_top, ax
    mov     rect_ingame_text.rc_bottom, di
    push    di
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    call    sprite_set_1_size
    add     sp, 8
    push    skybox_wat_color
    call    sprite_clear_1_color
    add     sp, 2
    mov     ax, 0AA0Eh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
do_sinking endp
init_crak proc far
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_cracshape = dword ptr -8
    var_cinfshape = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_framecount = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 1Ah
    push    di
    push    si
    mov     ax, offset aCrak; "crak"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_shape_alt
    add     sp, 6
    mov     word ptr [bp+var_cracshape], ax
    mov     word ptr [bp+var_cracshape+2], dx
    mov     ax, offset aCinf; "cinf"
    push    ax
    push    word ptr gameresptr+2
    push    word ptr gameresptr
    call    locate_shape_alt
    add     sp, 6
    mov     word ptr [bp+var_cinfshape], ax
    mov     word ptr [bp+var_cinfshape+2], dx
    mov     ax, framespersec
    cwd
    mov     cx, 7
    idiv    cx
    mov     cx, ax
    mov     ax, [bp+arg_framecount]
    cwd
    idiv    cx
    mov     [bp+var_1A], ax ; var_1A = ax = (framespersec / 7) / framecount
    les     bx, [bp+var_cinfshape]
    mov     di, es:[bx]
    cmp     ax, di
    jl      short loc_1D614
    lea     ax, [di-1]
    mov     [bp+var_1A], ax
loc_1D614:
    mov     di, [bp+var_1A]
    shl     di, 1
    les     bx, [bp+var_cinfshape]
    mov     ax, es:[bx+di+2]
    mov     [bp+var_18], ax
    push    si
    mov     di, offset rect_ingame_text
    mov     si, offset cliprect_unk
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     si
    sub     si, si
    jmp     loc_1D790
loc_1D636:
    mov     di, si
    mov     cl, 3
    shl     di, cl
    les     bx, [bp+var_cracshape]
    mov     ax, es:[bx+di]
    mov     dx, es:[bx+di+2]
    mov     [bp+var_10], ax
    mov     [bp+var_E], dx
    mov     bx, si
    shl     bx, cl
    mov     di, word ptr [bp+var_cracshape]
    mov     ax, es:[bx+di+4]
    mov     dx, es:[bx+di+6]
    mov     [bp+var_14], ax
    mov     [bp+var_12], dx
    mov     ax, 0C8h ; 'È'
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_E]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+var_E], ax
    mov     ax, 0C8h ; 'È'
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_12]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+var_12], ax
    sub     ax, ax
    push    ax
    mov     ax, [bp+var_12]
    add     ax, [bp+arg_2]
    dec     ax
    push    ax
    push    [bp+var_14]
    mov     ax, [bp+var_E]
    add     ax, [bp+arg_2]
    dec     ax
    push    ax
    push    [bp+var_10]
    call    preRender_line
    add     sp, 0Ah
    sub     ax, ax
    push    ax
    mov     ax, [bp+var_12]
    add     ax, [bp+arg_2]
    inc     ax
    push    ax
    push    [bp+var_14]
    mov     ax, [bp+var_E]
    add     ax, [bp+arg_2]
    inc     ax
    push    ax
    push    [bp+var_10]
    call    preRender_line
    add     sp, 0Ah
    push    dialog_fnt_colour
    mov     ax, [bp+var_12]
    add     ax, [bp+arg_2]
    push    ax
    push    [bp+var_14]
    mov     ax, [bp+var_E]
    add     ax, [bp+arg_2]
    push    ax
    push    [bp+var_10]
    call    preRender_line
    add     sp, 0Ah
    cmp     timertestflag_copy, 0
    jnz     short loc_1D70F
    jmp     loc_1D78F
loc_1D70F:
    mov     ax, [bp+var_10]
    mov     [bp+var_C], ax
    mov     ax, [bp+var_E]
    add     ax, [bp+arg_2]
    dec     ax
    mov     [bp+var_A], ax
    mov     ax, offset rect_ingame_text
    push    ax
    lea     ax, [bp+var_C]
    push    ax
    call    rect_adjust_from_point
    add     sp, 4
    mov     ax, [bp+var_14]
    mov     [bp+var_C], ax
    mov     ax, [bp+var_12]
    add     ax, [bp+arg_2]
    inc     ax
    mov     [bp+var_A], ax
    mov     ax, offset rect_ingame_text
    push    ax
    lea     ax, [bp+var_C]
    push    ax
    call    rect_adjust_from_point
    add     sp, 4
    mov     ax, [bp+var_10]
    mov     [bp+var_C], ax
    mov     ax, [bp+var_E]
    add     ax, [bp+arg_2]
    inc     ax
    mov     [bp+var_A], ax
    mov     ax, offset rect_ingame_text
    push    ax
    lea     ax, [bp+var_C]
    push    ax
    call    rect_adjust_from_point
    add     sp, 4
    mov     ax, [bp+var_14]
    mov     [bp+var_C], ax
    mov     ax, [bp+var_12]
    add     ax, [bp+arg_2]
    dec     ax
    mov     [bp+var_A], ax
    mov     ax, offset rect_ingame_text
    push    ax
    lea     ax, [bp+var_C]
    push    ax
    call    rect_adjust_from_point
    add     sp, 4
loc_1D78F:
    inc     si
loc_1D790:
    cmp     [bp+var_18], si
    jle     short loc_1D798
    jmp     loc_1D636
loc_1D798:
    mov     ax, offset rect_ingame_text
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
init_crak endp
load_skybox proc far
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    test    [bp+arg_0], 8
    jz      short loc_1D7B6
smart
smart
    and     [bp+arg_0], 7
nosmart
    jmp     loc_1D88E
loc_1D7B6:
    cmp     byte_3B8F6, 0
    jz      short loc_1D7C8
    mov     al, byte_46167
    cmp     [bp+arg_0], al
    jnz     short loc_1D7C8
    jmp     loc_1D8AF
loc_1D7C8:
    push    cs
    call near ptr unload_skybox
    mov     al, [bp+arg_0]
    mov     byte_46167, al
    mov     byte_3B8F6, 1
    cbw
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, offset aDesert; "desert"
    push    ax
    call    file_load_shape2d_fatal_thunk
    add     sp, 2
    mov     skybox_res_ofs, ax
    mov     skybox_res_seg, dx
    mov     ax, offset skyboxes
    push    ax
    mov     ax, offset aScensce2sce3sce4; "scensce2sce3sce4"
    push    ax
    push    dx
    push    skybox_res_ofs
    call    locate_many_resources
    add     sp, 8
    les     bx, skyboxes
    mov     ax, es:[bx+2]
    mov     skybox_ptr1, ax
    les     bx, skyboxes+4
    mov     ax, es:[bx+2]
    mov     skybox_ptr2, ax
    les     bx, skyboxes+8
    mov     ax, es:[bx+2]
    mov     skybox_ptr3, ax
    les     bx, skyboxes+0Ch
    mov     ax, es:[bx+2]
    mov     skybox_ptr4, ax
    mov     si, skybox_ptr1
    mov     ax, si
    cmp     ax, skybox_ptr2
    jbe     short loc_1D846
    mov     si, skybox_ptr2
loc_1D846:
    mov     ax, si
    cmp     ax, skybox_ptr3
    jbe     short loc_1D852
    mov     si, skybox_ptr3
loc_1D852:
    mov     ax, si
    cmp     ax, skybox_ptr4
    jbe     short loc_1D85E
    mov     si, skybox_ptr4
loc_1D85E:
    mov     skybox_current, si
    mov     si, skybox_ptr1
    mov     ax, si
    cmp     ax, skybox_ptr2
    jnb     short loc_1D872
    mov     si, skybox_ptr2
loc_1D872:
    mov     ax, si
    cmp     ax, skybox_ptr3
    jnb     short loc_1D87E
    mov     si, skybox_ptr3
loc_1D87E:
    mov     ax, si
    cmp     ax, skybox_ptr4
    jnb     short loc_1D88A
    mov     si, skybox_ptr4
loc_1D88A:
    mov     word_454CE, si
loc_1D88E:
    mov     ax, material_clrlist_ptr
    mov     [bp+var_4], ax
    mov     bx, ax
    mov     ax, [bx+22h]
    mov     skybox_sky_color, ax
    mov     ax, [bx+20h]
    mov     skybox_grd_color, ax
    mov     ax, [bx+0C8h]
    mov     skybox_wat_color, ax
    mov     ax, dialog_fnt_colour
    mov     meter_needle_color, ax
loc_1D8AF:
    pop     si
    mov     sp, bp
    pop     bp
    retf
load_skybox endp
unload_skybox proc far

    cmp     byte_3B8F6, 0
    jz      short loc_1D8CB
    push    skybox_res_seg
    push    skybox_res_ofs
    call    mmgr_free
    add     sp, 4
loc_1D8CB:
    mov     byte_3B8F6, 0
    retf
    ; align 2
    db 144
unload_skybox endp
load_sdgame2_shapes proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    mov     ax, offset aSdgame2; "sdgame2"
    push    ax              ; char *
    mov     ax, 8
    push    ax              ; int
    call    file_load_resource
    add     sp, 4
    mov     word ptr sdgame2ptr, ax
    mov     word ptr sdgame2ptr+2, dx
    mov     ax, offset sdgame2shapes
    push    ax
    mov     ax, offset aEx01ex02ex03leftrigh; "ex01ex02ex03leftrigh"
    push    ax
    push    dx
    push    word ptr sdgame2ptr
    call    locate_many_resources
    add     sp, 8
    sub     si, si
loc_1D908:
    mov     bx, si
    shl     bx, 1
    mov     di, si
    shl     di, 1
    shl     di, 1
    les     di, sdgame2shapes[di]
    mov     ax, es:[di+SHAPE2D.s2d_width]
    mov     sdgame2_widths[bx], ax
    inc     si
    cmp     si, 3
    jl      short loc_1D908
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
load_sdgame2_shapes endp
free_sdgame2 proc far

    push    word ptr sdgame2ptr+2
    push    word ptr sdgame2ptr
    call    mmgr_free
    add     sp, 4
    retf
    ; align 2
    db 144
free_sdgame2 endp
setup_intro proc far
    var_5D4 = word ptr -1492
    var_5D2 = word ptr -1490
    var_5D0 = byte ptr -1488
    var_440 = word ptr -1088
    var_43E = byte ptr -1086
    var_title3dres_seg = word ptr -686
    var_title3dres_ofs = word ptr -684
    var_2AA = word ptr -682
    var_2A8 = word ptr -680
    var_2A6 = word ptr -678
    var_2A4 = word ptr -676
    var_2A2 = byte ptr -674
    var_2A0 = word ptr -672
    var_29E = word ptr -670
    var_29C = word ptr -668
    var_29A = word ptr -666
    var_298 = word ptr -664
    var_296 = word ptr -662
    var_42 = word ptr -66
    var_40 = word ptr -64
    var_3E = word ptr -62
    var_3C = word ptr -60
    var_3A = word ptr -58
    var_38 = byte ptr -56
    var_rectindex = word ptr -54
    var_rect = RECTANGLE ptr -52
    var_2C = word ptr -44
    var_rect2 = RECTANGLE ptr -42
    var_22 = word ptr -34
    var_20 = word ptr -32
    var_1E = word ptr -30
    var_1C = word ptr -28
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_rect3 = RECTANGLE ptr -22
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
    sub     sp, 5D4h
    push    di
    push    si
    mov     [bp+var_38], 0
    mov     ax, offset aTitle; "title"
    push    ax
    call    file_load_3dres
    add     sp, 2
    mov     [bp+var_title3dres_seg], ax
    mov     [bp+var_title3dres_ofs], dx
    lea     ax, [bp+var_22]
    push    ax
    mov     ax, offset aLogolog2brav; "logolog2brav"
    push    ax
    push    dx
    push    [bp+var_title3dres_seg]
    call    locate_many_resources
    add     sp, 8
    mov     ax, offset logoshape
    push    ax
    push    [bp+var_20]
    push    [bp+var_22]
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, offset logo2shape
    push    ax
    push    [bp+var_1C]
    push    [bp+var_1E]
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, offset bravshape
    push    ax
    push    [bp+var_18]
    push    [bp+var_1A]
    call    shape3d_init_shape
    add     sp, 6
    cmp     video_flag5_is0, 0
    jnz     short loc_1D9CA
    mov     ax, 0Fh
    push    ax
    mov     ax, 0C8h
    push    ax
    mov     ax, 140h
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     word ptr wndsprite, ax
    mov     word ptr wndsprite+2, dx
loc_1D9CA:
    mov     [bp+var_42], 0
loc_1D9CF:
    call    get_kevinrandom
    mov     cl, 7
    shl     ax, cl
    sub     ax, 4000h
    mov     si, [bp+var_42]
    mov     cx, si
    shl     si, 1
    add     si, cx
    shl     si, 1
    mov     [bp+si+var_29A], ax
    call    get_kevinrandom
    mov     cl, 7
    shl     ax, cl
    sub     ax, 1388h
    neg     ax
    mov     si, [bp+var_42]
    mov     cx, si
    shl     si, 1
    add     si, cx
    shl     si, 1
    mov     [bp+si+var_298], ax
    call    get_kevinrandom
    mov     cl, 7
    shl     ax, cl
    sub     ax, 4000h
    mov     si, [bp+var_42]
    mov     cx, si
    shl     si, 1
    add     si, cx
    shl     si, 1
    mov     [bp+si+var_296], ax
    inc     [bp+var_42]
    cmp     [bp+var_42], 64h ; 'd'
    jl      short loc_1D9CF
    mov     ax, 0C8h ; 'È'
    push    ax
    mov     ax, 140h
    push    ax
    mov     ax, 28h ; '('
    push    ax
    push    ax
    call    set_projection
    add     sp, 8
    mov     [bp+var_3E], 400h
    mov     [bp+var_3A], 400h
    mov     [bp+var_3C], 12Ch
    mov     [bp+var_E], 0
    mov     [bp+var_5D4], 0
    mov     ax, offset aCarcoun_0; "carcoun"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_A], ax
    mov     [bp+var_8], dx
    mov     ax, 1
    push    ax
    push    dx
    push    [bp+var_A]
    call    setup_aero_trackdata
    add     sp, 6
    push    [bp+var_8]
    push    [bp+var_A]
    call    unload_resource
    add     sp, 4
    call    init_plantrak
    call    timer_get_delta
    mov     [bp+var_2AA], 0
    mov     [bp+var_440], 0
    mov     ax, timertestflag
    mov     timertestflag_copy, ax
    mov     rect_unk.rc_left, 0
    mov     rect_unk.rc_right, 140h
    mov     rect_unk.rc_top, 0
    mov     rect_unk.rc_bottom, 0C8h ; 'È'
    mov     di, offset rect_unk2
    mov     si, offset rect_unk
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     di, offset rect_unk3
    mov     si, offset rect_unk
    movsw
    movsw
    movsw
    movsw
    mov     [bp+var_rectindex], 0
    mov     [bp+var_2A2], 1
loc_1DADE:
    call    timer_get_delta
    mov     [bp+var_40], ax
    add     word_44DCC, ax
    jmp     loc_1DB8A
    ; align 2
    db 144
loc_1DAEE:
    mov     ax, word_4499C
    sub     word_44DCC, ax
    call    do_opponent_op
    mov     [bp+var_2A2], 1
    mov     ax, framespersec
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    inc     [bp+var_5D4]
    cmp     ax, [bp+var_5D4]
    jge     short loc_1DB8A
    mov     [bp+var_E], 1
    add     [bp+var_3C], 14h
    sub     [bp+var_3A], 5
    mov     ax, [bp+var_3E]
    sub     ax, 400h
    mov     [bp+var_42], ax
    or      ax, ax
    jge     short loc_1DB38
    neg     ax
    jmp     short loc_1DB3B
    ; align 4
    db 144
    db 144
loc_1DB38:
    mov     ax, [bp+var_42]
loc_1DB3B:
    cmp     ax, 0Ah
    jge     short loc_1DB48
    mov     [bp+var_3E], 400h
    jmp     short loc_1DB5E
    ; align 2
    db 144
loc_1DB48:
    cmp     [bp+var_42], 0
    jle     short loc_1DB54
    sub     [bp+var_3E], 0Ah
    jmp     short loc_1DB5E
loc_1DB54:
    cmp     [bp+var_42], 0
    jge     short loc_1DB5E
    add     [bp+var_3E], 0Ah
loc_1DB5E:
    cmp     [bp+var_6], 400h
    jle     short loc_1DB6A
    dec     [bp+var_6]
    jmp     short loc_1DB74
loc_1DB6A:
    cmp     [bp+var_6], 400h
    jge     short loc_1DB74
    inc     [bp+var_6]
loc_1DB74:
    cmp     [bp+var_2], 400h
    jle     short loc_1DB80
    dec     [bp+var_2]
    jmp     short loc_1DB8A
loc_1DB80:
    cmp     [bp+var_2], 400h
    jge     short loc_1DB8A
    inc     [bp+var_2]
loc_1DB8A:
    mov     ax, word_4499C
    cmp     word_44DCC, ax
    jle     short loc_1DB96
    jmp     loc_1DAEE
loc_1DB96:
    cmp     [bp+var_2A2], 0
    jnz     short loc_1DBA0
    jmp     loc_1DE19
loc_1DBA0:
    mov     [bp+var_2A2], 0
    cmp     video_flag5_is0, 0
    jz      short loc_1DBB4
    call    setup_mcgawnd2
    jmp     short loc_1DBB9
    ; align 2
    db 144
loc_1DBB4:
    call    sprite_copy_wnd_to_1
loc_1DBB9:
    mov     [bp+var_2C], 0FFFFh
    mov     [bp+var_2A6], 1
    mov     ax, word ptr state.opponentstate.car_posWorld1.lx
    mov     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1DBCD:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1DBCD
    mov     [bp+var_2A0], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.ly
    mov     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1DBE2:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1DBE2
    mov     [bp+var_29E], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.lz
    mov     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1DBF7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1DBF7
    mov     [bp+var_29C], ax
    mov     ax, framespersec
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    cmp     ax, [bp+var_5D4]
    jle     short loc_1DC44
    mov     [bp+var_2A6], 0
    mov     ax, state.opponentstate.car_rotate.vx
smart
    and     ah, 3
nosmart
    mov     [bp+var_2C], ax
    mov     [bp+var_2A4], 0
    mov     ax, [bp+var_2A0]
    mov     [bp+var_3E], ax
    mov     ax, [bp+var_29E]
    add     ax, 14h
    mov     [bp+var_3C], ax
    mov     ax, [bp+var_29C]
    mov     [bp+var_3A], ax
    jmp     short loc_1DC7D
    ; align 2
    db 144
loc_1DC44:
    mov     ax, framespersec
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    cmp     ax, [bp+var_5D4]
    jle     short loc_1DC7D
    mov     [bp+var_3E], 400h
    mov     [bp+var_3A], 400h
    mov     [bp+var_3C], 5Ah ; 'Z'
    mov     ax, [bp+var_2A0]
    mov     [bp+var_6], ax
    mov     ax, [bp+var_29E]
    mov     [bp+var_4], ax
    mov     ax, [bp+var_29C]
    mov     [bp+var_2], ax
loc_1DC7D:
    cmp     [bp+var_2C], 0FFFFh
    jnz     short loc_1DCD1
    mov     ax, [bp+var_2]
    sub     ax, [bp+var_3A]
    push    ax
    mov     ax, [bp+var_6]
    sub     ax, [bp+var_3E]
    push    ax
    call    polarAngle
    add     sp, 4
    neg     ax
smart
    and     ah, 3
nosmart
    mov     [bp+var_2C], ax
    mov     ax, [bp+var_2]
    sub     ax, [bp+var_3A]
    push    ax
    mov     ax, [bp+var_6]
    sub     ax, [bp+var_3E]
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_C], ax
    push    ax
    mov     ax, [bp+var_4]
    sub     ax, [bp+var_3C]
    push    ax
    call    polarAngle
    add     sp, 4
smart
    and     ah, 3
nosmart
    mov     [bp+var_2A4], ax
loc_1DCD1:
    cmp     timertestflag_copy, 0
    jz      short loc_1DCFC
    cmp     [bp+var_rectindex], 0
    jnz     short loc_1DCEC
    lea     ax, [bp+var_43E]
    mov     [bp+var_2A8], ax
    lea     ax, [bp+var_2AA]
    jmp     short loc_1DCF8
loc_1DCEC:
    lea     ax, [bp+var_5D0]
    mov     [bp+var_2A8], ax
    lea     ax, [bp+var_440]
loc_1DCF8:
    mov     [bp+var_5D2], ax
loc_1DCFC:
    lea     ax, [bp+var_rect]
    push    ax
    lea     ax, [bp+var_rect3]
    push    ax
    mov     bx, [bp+var_rectindex]
    mov     cl, 3
    shl     bx, cl
    push    rect_unk.rc_bottom[bx]
    push    rect_unk.rc_top[bx]
    push    rect_unk.rc_right[bx]
    push    word ptr rect_unk.rc_left[bx]
    push    [bp+var_5D2]
    push    [bp+var_2A8]
    lea     ax, [bp+var_29A]
    push    ax
    push    [bp+var_E]
    push    [bp+var_2A6]
    push    [bp+var_2A4]
    push    [bp+var_2C]
    push    [bp+var_3A]
    push    [bp+var_3C]
    push    [bp+var_3E]
    push    cs
    call near ptr intro_op
    add     sp, 20h
    cmp     video_flag5_is0, 0
    jz      short loc_1DD7E
    call    mouse_draw_opaque_check
    call    setup_mcgawnd1
    call    mouse_draw_transparent_check
    cmp     timertestflag_copy, 0
    jz      short loc_1DD77
    mov     bx, [bp+var_rectindex]
    mov     cl, 3
    shl     bx, cl
    lea     di, rect_unk.rc_left[bx]
    lea     si, [bp+var_rect3]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
loc_1DD77:
    xor     byte ptr [bp+var_rectindex], 1
    jmp     loc_1DE19
loc_1DD7E:
    call    sprite_copy_2_to_1_2
    cmp     timertestflag_copy, 0
    jz      short loc_1DDFC
    lea     ax, [bp+var_rect2]
    push    ax
    mov     ax, offset rect_unk6
    push    ax
    lea     ax, [bp+var_rect]
    push    ax
    call    rect_union
    add     sp, 6
    mov     ax, offset rect_unk3
    push    ax
    lea     ax, [bp+var_rect2]
    push    ax
    call    rect_intersect
    add     sp, 4
    or      al, al
    jnz     short loc_1DE19
    push    [bp+var_rect2.rc_bottom]
    push    [bp+var_rect2.rc_top]
    push    [bp+var_rect2.rc_right]
    push    [bp+var_rect2.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    call    mouse_draw_opaque_check
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
    call    mouse_draw_transparent_check
    mov     di, offset rect_unk
    lea     si, [bp+var_rect3]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     di, offset rect_unk6
    lea     si, [bp+var_rect]
    movsw
    movsw
    movsw
    movsw
    jmp     short loc_1DE19
    ; align 2
    db 144
loc_1DDFC:
    call    mouse_draw_opaque_check
    les     bx, wndsprite
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
    call    mouse_draw_transparent_check
loc_1DE19:
    push    [bp+var_40]
    call    input_do_checking
    add     sp, 2
    or      ax, ax
    jz      short loc_1DE2E
    mov     [bp+var_38], 1
    jmp     short loc_1DE3E
loc_1DE2E:
    mov     ax, 17h
    imul    framespersec
    cmp     ax, [bp+var_5D4]
    jle     short loc_1DE3E
    jmp     loc_1DADE
loc_1DE3E:
    cmp     video_flag5_is0, 0
    jz      short loc_1DE7C
    call    get_0
    or      ax, ax
    jz      short loc_1DE8C
    call    setup_mcgawnd2
    sub     ax, ax
    push    ax
    mov     ax, 0C8h ; 'È'
    push    ax
    mov     ax, 140h
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    call    sub_35C4E
    add     sp, 0Ah
    call    mouse_draw_opaque_check
    call    setup_mcgawnd1
    call    mouse_draw_transparent_check
    jmp     short loc_1DE8C
    ; align 2
    db 144
loc_1DE7C:
    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_free_wnd
    add     sp, 4
loc_1DE8C:
    push    [bp+var_title3dres_ofs]
    push    [bp+var_title3dres_seg]
    call    mmgr_free
    add     sp, 4
    mov     al, [bp+var_38]
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
setup_intro endp
intro_op proc far
    var_42 = word ptr -66
    var_vec = VECTOR ptr -64
    var_point = POINT2D ptr -58
    var_vec2 = word ptr -54
    var_34 = word ptr -52
    var_32 = word ptr -50
    var_rect1 = RECTANGLE ptr -44
    var_rect2 = byte ptr -36
    var_transshape = TRANSFORMEDSHAPE ptr -28
    var_rect3 = RECTANGLE ptr -8
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
    arg_12 = word ptr 24
    arg_rect = RECTANGLE ptr 26
    arg_rectptr = word ptr 34
    arg_rectptr2 = word ptr 36

    push    bp
    mov     bp, sp
    sub     sp, 42h
    push    di
    push    si
    push    si
    push    di
    lea     di, [bp+var_rect3]
    mov     si, offset cliprect_unk
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    sub     ax, ax
    push    ax
    mov     ax, offset intro_cliprect
loc_1DEC4:
    push    ax
    push    [bp+arg_6]
    push    [bp+arg_8]
    sub     ax, ax
    push    ax
    call    select_cliprect_rotate
    add     sp, 0Ah
    cmp     [bp+arg_C], 0
    jz      short loc_1DEE4
    mov     [bp+var_transshape.ts_shapeptr], offset logoshape
    jmp     short loc_1DEE9
    ; align 2
    db 144
loc_1DEE4:
    mov     [bp+var_transshape.ts_shapeptr], offset logo2shape
loc_1DEE9:
    mov     ax, 400h
    sub     ax, [bp+arg_0]
    mov     [bp+var_transshape.ts_pos.vx], ax
    mov     ax, [bp+arg_2]
    neg     ax
    mov     [bp+var_transshape.ts_pos.vy], ax
    mov     ax, 400h
    sub     ax, [bp+arg_4]
    mov     [bp+var_transshape.ts_pos.vz], ax
    cmp     timertestflag_copy, 0
    jz      short loc_1DF16
    lea     ax, [bp+var_rect3]
    mov     [bp+var_transshape.ts_rectptr], ax
    mov     [bp+var_transshape.ts_flags], 0Ch
    jmp     short loc_1DF1A
loc_1DF16:
    mov     [bp+var_transshape.ts_flags], 4
loc_1DF1A:
    mov     [bp+var_transshape.ts_rotvec.vx], 0
    mov     [bp+var_transshape.ts_rotvec.vy], 0
    mov     [bp+var_transshape.ts_rotvec.vz], 0
    mov     [bp+var_transshape.ts_unk], 400h
    mov     [bp+var_transshape.ts_material], 0
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
    add     sp, 2
    cmp     [bp+arg_A], 0
    jnz     short loc_1DF47
    jmp     loc_1DFCF
loc_1DF47:
    mov     ax, word ptr state.opponentstate.car_posWorld1.lx
    mov     dx, word ptr state.opponentstate.car_posWorld1.lx+2
    mov     cl, 6
loc_1DF50:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1DF50
    sub     ax, [bp+arg_0]
    mov     [bp+var_transshape.ts_pos.vx], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.ly
    mov     dx, word ptr state.opponentstate.car_posWorld1.ly+2
    mov     cl, 6
loc_1DF67:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1DF67
    sub     ax, [bp+arg_2]
    mov     [bp+var_transshape.ts_pos.vy], ax
    mov     ax, word ptr state.opponentstate.car_posWorld1.lz
    mov     dx, word ptr state.opponentstate.car_posWorld1.lz+2
    mov     cl, 6
loc_1DF7E:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1DF7E
    sub     ax, [bp+arg_4]
    mov     [bp+var_transshape.ts_pos.vz], ax
    mov     [bp+var_transshape.ts_shapeptr], offset bravshape
    cmp     timertestflag_copy, 0
    jz      short loc_1DFA4
    lea     ax, [bp+var_rect3]
    mov     [bp+var_transshape.ts_rectptr], ax
    mov     [bp+var_transshape.ts_flags], 0Ch
    jmp     short loc_1DFA8
loc_1DFA4:
    mov     [bp+var_transshape.ts_flags], 4
loc_1DFA8:
    mov     [bp+var_transshape.ts_rotvec.vx], 0
    mov     [bp+var_transshape.ts_rotvec.vy], 0
    mov     ax, state.opponentstate.car_rotate.vx
    neg     ax
    mov     [bp+var_transshape.ts_rotvec.vz], ax
    mov     [bp+var_transshape.ts_unk], 400h
    mov     [bp+var_transshape.ts_material], 0
    lea     ax, [bp+var_transshape]
    push    ax
    call    transformed_shape_op
    add     sp, 2
loc_1DFCF:
    cmp     timertestflag_copy, 0
    jnz     short loc_1DFD9
    jmp     loc_1E06C
loc_1DFD9:
    mov     bx, [bp+arg_12]
    cmp     word ptr [bx], 0
    jz      short loc_1E013
    sub     si, si
    jmp     short loc_1E00C
    ; align 2
    db 144
loc_1DFE6:
    mov     bx, [bp+arg_10]
    mov     ax, si
    shl     ax, 1
    shl     ax, 1
    add     bx, ax
    mov     ax, [bx]
    mov     dx, [bx+2]
    mov     [bp+var_point.x2], ax
    mov     [bp+var_point.y2], dx
    sub     ax, ax
    push    ax
    push    dx
    push    [bp+var_point.x2]
    call    putpixel_single_maybe
    add     sp, 6
    inc     si
loc_1E00C:
    mov     bx, [bp+arg_12]
    cmp     [bx], si
    jg      short loc_1DFE6
loc_1E013:
    lea     ax, [bp+var_rect1]
    push    ax
    lea     ax, [bp+arg_rect]
    push    ax
    push    [bp+arg_rectptr]
    call    rect_union
    add     sp, 6
    mov     ax, offset rect_unk3
    push    ax
    lea     ax, [bp+var_rect1]
    push    ax
    call    rect_intersect
    add     sp, 4
    or      al, al
    jnz     short loc_1E059
    push    [bp+var_rect1.rc_bottom]
    push    [bp+var_rect1.rc_top]
    push    [bp+var_rect1.rc_right]
    push    [bp+var_rect1.rc_left]
    call    sprite_set_1_size
    add     sp, 8
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
loc_1E059:
    push    si
    push    di
    lea     di, [bp+var_rect2]
    lea     si, [bp+var_rect3]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    jmp     short loc_1E08F
    ; align 2
    db 144
loc_1E06C:
    push    intro_cliprect.rc_bottom
    push    intro_cliprect.rc_top
    push    intro_cliprect.rc_right
    push    intro_cliprect.rc_left
    call    sprite_set_1_size
    add     sp, 8
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
loc_1E08F:
    push    intro_cliprect.rc_bottom
    push    intro_cliprect.rc_top
    push    intro_cliprect.rc_right
    push    intro_cliprect.rc_left
    call    sprite_set_1_size
    add     sp, 8
    sub     di, di
    sub     si, si
loc_1E0AB:
    mov     ax, [bp+arg_E]
    mov     cx, si
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    shl     cx, 1
    add     ax, cx
    mov     [bp+var_42], ax
    mov     bx, ax
    mov     ax, [bx]
    sub     ax, [bp+arg_0]
    mov     [bp+var_vec2], ax
    mov     ax, [bx+2]
    sub     ax, [bp+arg_2]
    mov     [bp+var_34], ax
    mov     ax, [bx+4]
    sub     ax, [bp+arg_4]
    mov     [bp+var_32], ax
    lea     ax, [bp+var_vec]
    push    ax
    mov     ax, offset mat_temp
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_vec.vz], 0C8h ; 'È'
    jle     short loc_1E157
    lea     ax, [bp+var_point]
    push    ax
    lea     ax, [bp+var_vec]
    push    ax
    call    vector_to_point
    add     sp, 4
    push    intro_colorvalue
    push    [bp+var_point.y2]
    push    [bp+var_point.x2]
    call    putpixel_single_maybe
    add     sp, 6
    cmp     timertestflag_copy, 0
    jz      short loc_1E144
    mov     bx, [bp+arg_10]
    mov     ax, di
    inc     di
    shl     ax, 1
    shl     ax, 1
    add     bx, ax
    mov     ax, [bp+var_point.x2]
loc_1E12C:
    mov     dx, [bp+var_point.y2]
    mov     [bx], ax
    mov     [bx+2], dx
    lea     ax, [bp+var_rect2]
    push    ax
    lea     ax, [bp+var_point]
    push    ax
    call    rect_adjust_from_point
    add     sp, 4
loc_1E144:
    inc     intro_colorvalue
    mov     ax, word_407CC
loc_1E14B:
    cmp     intro_colorvalue, ax
    jnz     short loc_1E157
    mov     intro_colorvalue, 1
loc_1E157:
    inc     si
    cmp     si, 64h ; 'd'
    jge     short loc_1E160
    jmp     loc_1E0AB
loc_1E160:
    cmp     timertestflag_copy, 0
    jz      short loc_1E16C
    mov     bx, [bp+arg_12]
    mov     [bx], di
loc_1E16C:
    call    get_a_poly_info
    cmp     timertestflag_copy, 0
    jz      short loc_1E19A
    mov     bx, [bp+arg_rectptr]
    push    si
    push    di
    mov     di, bx
    lea     si, [bp+var_rect3]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     bx, [bp+arg_rectptr2]
    push    si
    push    di
    mov     di, bx
    lea     si, [bp+var_rect2]
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
loc_1E19A:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
intro_op endp
seg003 ends
end
