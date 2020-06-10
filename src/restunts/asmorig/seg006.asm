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
seg006 segment byte public 'STUNTSC' use16
    assume cs:seg006
    assume es:nothing, ss:nothing, ds:dseg
    public init_polyinfo
    public copy_material_list_pointers
    public polyinfo_reset
    public select_cliprect_rotate
    public transformed_shape_op
    public transformed_shape_op_helper
    public rect_compare_point
    public transformed_shape_op_helper3
    public get_a_poly_info
    public mat_rot_zxy
    public rect_adjust_from_point
    public vector_op_unk2
    public calc_sincos80
    public nopsub_26552
    public rect_union
    public rect_intersect
    public rectlist_add_rect
    public rect_is_overlapping
    public rect_is_inside
    public rect_is_adjacent
    public rectlist_add_rects
    public rect_array_sort_by_top
init_polyinfo proc far

    mov     ax, 28A0h       ; bytes to reserve
    cwd
loc_24D68:
    push    dx
loc_24D69:
    push    ax
loc_24D6A:
    mov     ax, offset aPolyinfo; "polyinfo"
loc_24D6D:
    push    ax
loc_24D6E:
    call    mmgr_alloc_resbytes
    add     sp, 6
    mov     word ptr polyinfoptr, ax
    mov     word ptr polyinfoptr+2, dx
    sub     ax, ax
    push    ax
loc_24D80:
    mov     ax, offset mat_y0
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     ax, 100h
    push    ax
    mov     ax, offset mat_y100
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     ax, 200h
    push    ax
    mov     ax, offset mat_y200
    push    ax
    call    mat_rot_y
    add     sp, 4
loc_24DAC:
    mov     ax, 300h
    push    ax
    mov     ax, offset mat_y300
    push    ax
loc_24DB4:
    call    mat_rot_y
    add     sp, 4
loc_24DBC:
    push    cs
    call near ptr calc_sincos80
    retf
    ; align 2
    db 144
init_polyinfo endp
copy_material_list_pointers proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
loc_24DC3:
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     material_clrlist_ptr_cpy, ax
loc_24DCB:
    mov     ax, [bp+arg_2]
    mov     material_clrlist2_ptr_cpy, ax
    mov     ax, [bp+arg_4]
loc_24DD4:
    mov     material_patlist_ptr_cpy, ax
loc_24DD7:
    mov     ax, [bp+arg_6]
    mov     material_patlist2_ptr_cpy, ax
    mov     ax, [bp+arg_8]
    mov     someZeroVideoConst, ax
    pop     bp
    retf
    ; align 2
    db 144
copy_material_list_pointers endp
polyinfo_reset proc far

    mov     polyinfonumpolys, 0
loc_24DEC:
    mov     polyinfoptrnext, 0
    mov     word_40ECE, 0
    mov     word_411F6, 0FFFFh
    mov     word_443F2, 190h
    retf
    ; align 2
    db 144
polyinfo_reset endp
select_cliprect_rotate proc far
    var_vec = VECTOR ptr -14
    var_matptr = word ptr -8
    var_vec2 = VECTOR ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_angZ = word ptr 6
    arg_angX = word ptr 8
    arg_angY = word ptr 10
    arg_cliprectptr = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    di
    push    si
    mov     ax, 1
    push    ax
    push    [bp+arg_angY]
    push    [bp+arg_angX]
    push    [bp+arg_angZ]
    push    cs
    call near ptr mat_rot_zxy
    add     sp, 8
    mov     di, offset mat_temp
    mov     si, ax
    push    ds
    pop     es
    mov     cx, 9
    repne movsw
    push    cs
    call near ptr polyinfo_reset
    mov     ax, [bp+arg_cliprectptr]
    mov     di, offset select_rect_rc
    mov     si, ax
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     ax, [bp+arg_8]
    mov     select_rect_param, ax
    sub     ax, ax
    push    ax
    mov     ax, [bp+arg_angY]
    neg     ax
    push    ax
    mov     ax, [bp+arg_angX]
    neg     ax
    push    ax
    mov     ax, [bp+arg_angZ]
    neg     ax
    push    ax
    push    cs
    call near ptr mat_rot_zxy
    add     sp, 8
    mov     [bp+var_matptr], ax
    mov     [bp+var_vec.vz], 2710h
    mov     [bp+var_vec.vy], 0
    mov     [bp+var_vec.vx], 0
    lea     ax, [bp+var_vec2]
    push    ax
    push    [bp+var_matptr]
    lea     ax, [bp+var_vec]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    [bp+var_vec2.vz]
    push    [bp+var_vec2.vx]
    call    polarAngle
    add     sp, 4
smart
    and     ah, 3
nosmart
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
select_cliprect_rotate endp
transformed_shape_op proc far
    var_B7C = word ptr -2940
    var_polyvertunktabptr = word ptr -2938
    var_cull1 = dword ptr -2936
    var_vec4 = VECTOR ptr -2932
    var_vecarr = VECTOR ptr -2926
    var_574 = POINT2D ptr -1396
    var_polyvertY = word ptr -1392
    var_polyvertsptr = dword ptr -1390
    var_vec3 = VECTOR ptr -1386
    var_polyvertX = word ptr -1380
    var_vertflagtbl = byte ptr -1378
    var_462 = word ptr -1122
    var_460 = word ptr -1120
    var_45E = word ptr -1118
    var_45C = dword ptr -1116
    var_vec2 = VECTOR ptr -1112
    var_450 = POINT2D ptr -1104
    var_ptrectflag = byte ptr -1098
    var_448 = word ptr -1096
    var_mat = MATRIX ptr -1094
    var_cull2 = dword ptr -1076
    var_transshapepolyinfoptptr = dword ptr -1072
    var_rotmatptr = word ptr -1068
    var_mat2 = MATRIX ptr -1066
    var_fileprimtype = word ptr -1048
    var_vecarr2 = POINT2D ptr -1046
    var_1A = word ptr -26
    var_18 = dword ptr -24
    var_vec = VECTOR ptr -20
    var_polyvertcounter = word ptr -14
    var_C = word ptr -12
    var_A = dword ptr -10
    var_primtype = byte ptr -6
    var_4 = word ptr -4
    var_primitiveflags = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_transshapeptr = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0B7Ch
    push    di
    push    si
    cmp     word_40ECE, 0
    jz      short loc_24EB8
loc_24EAE:
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_24EB8:
    mov     bx, [bp+arg_transshapeptr]
    mov     bx, [bx+TRANSFORMEDSHAPE.ts_shapeptr]
    mov     ax, [bx+SHAPE3D.shape3d_numverts]
    mov     transshapenumverts, ax
    mov     bx, [bp+arg_transshapeptr]
    mov     bx, [bx+TRANSFORMEDSHAPE.ts_shapeptr]
    mov     ax, word ptr [bx+SHAPE3D.shape3d_primitives]
    mov     dx, word ptr [bx+(SHAPE3D.shape3d_primitives+2)]
    mov     word ptr transshapeprimitives, ax
    mov     word ptr transshapeprimitives+2, dx
loc_24ED6:
    mov     bx, [bp+arg_transshapeptr]
    mov     bx, [bx+TRANSFORMEDSHAPE.ts_shapeptr]
    mov     ax, word ptr [bx+SHAPE3D.shape3d_verts]
    mov     dx, word ptr [bx+(SHAPE3D.shape3d_verts+2)]
    mov     word ptr transshapeverts, ax
    mov     word ptr transshapeverts+2, dx
    mov     bx, [bp+arg_transshapeptr]
    mov     bx, [bx+TRANSFORMEDSHAPE.ts_shapeptr]
    mov     al, byte ptr [bx+SHAPE3D.shape3d_numpaints]
    cbw
    mov     transshapenumpaints, ax
    mov     bx, [bp+arg_transshapeptr]
    mov     bx, [bx+TRANSFORMEDSHAPE.ts_shapeptr]
    mov     ax, word ptr [bx+SHAPE3D.shape3d_cull1]
    mov     dx, word ptr [bx+(SHAPE3D.shape3d_cull1+2)]
    mov     word ptr [bp+var_cull1], ax
    mov     word ptr [bp+var_cull1+2], dx
    mov     bx, [bp+arg_transshapeptr]
    mov     bx, [bx+TRANSFORMEDSHAPE.ts_shapeptr]
    mov     ax, word ptr [bx+SHAPE3D.shape3d_cull2]
    mov     dx, word ptr [bx+(SHAPE3D.shape3d_cull2+2)]
    mov     word ptr [bp+var_cull2], ax
    mov     word ptr [bp+var_cull2+2], dx
    mov     bx, [bp+arg_transshapeptr]
    mov     al, [bx+TRANSFORMEDSHAPE.ts_material]
    mov     transshapematerial, al
    cmp     byte ptr transshapenumpaints, al
    ja      short loc_24F32
    mov     transshapematerial, 0
loc_24F32:
    mov     al, [bx+TRANSFORMEDSHAPE.ts_flags]
    mov     transshapeflags, al
    test    transshapeflags, 8
    jz      short loc_24F45
    mov     ax, [bx+TRANSFORMEDSHAPE.ts_rectptr]
    mov     transshaperectptr, ax
loc_24F45:
    sub     si, si
    jmp     short loc_24F50
    ; align 2
    db 144
loc_24F4A:
    mov     [bp+si+var_vertflagtbl], 0FFh
    inc     si
loc_24F50:
    mov     ax, si
    cmp     ax, transshapenumverts
    jb      short loc_24F4A
    test    transshapeflags, 2
    jz      short loc_24FB6
    sub     ax, ax
    push    ax
    mov     bx, [bp+arg_transshapeptr]
    push    [bx+TRANSFORMEDSHAPE.ts_rotvec.vz]
    push    [bx+TRANSFORMEDSHAPE.ts_rotvec.vy]
    push    [bx+TRANSFORMEDSHAPE.ts_rotvec.vx]
    push    cs
    call near ptr mat_rot_zxy
    add     sp, 8
    mov     [bp+var_rotmatptr], ax
    lea     ax, [bp+var_mat2]
    push    ax
    mov     ax, offset mat_temp
    push    ax
    push    [bp+var_rotmatptr]
    call    mat_multiply
    add     sp, 6
    mov     ax, [bp+arg_transshapeptr]
    push    si
    push    di
    lea     di, [bp+var_vec]
    mov     si, ax
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
loc_24F9F:
    mov     word ptr [bp+var_45C], 0FFFFh
    mov     word ptr [bp+var_45C+2], 0FFFFh
    sub     ax, ax
    mov     word ptr [bp+var_A+2], ax
    mov     word ptr [bp+var_A], ax
    jmp     loc_250A3       ; initialized to 190h in polyinfo_reset()
loc_24FB6:
    sub     ax, ax
    push    ax
    mov     bx, [bp+arg_transshapeptr]
    push    [bx+TRANSFORMEDSHAPE.ts_rotvec.vz]
    push    [bx+TRANSFORMEDSHAPE.ts_rotvec.vy]
    push    [bx+TRANSFORMEDSHAPE.ts_rotvec.vx]
    push    cs
    call near ptr mat_rot_zxy
    add     sp, 8
    mov     [bp+var_rotmatptr], ax
    lea     ax, [bp+var_vec]
    push    ax
    mov     ax, offset mat_temp
    push    ax
    push    [bp+arg_transshapeptr]
    call    mat_mul_vector
    add     sp, 6
    lea     ax, [bp+var_mat2]
    push    ax
    mov     ax, offset mat_temp
    push    ax
    push    [bp+var_rotmatptr]
    call    mat_multiply
    add     sp, 6
    lea     ax, [bp+var_mat]
    push    ax
    lea     ax, [bp+var_mat2]
    push    ax
    call    mat_invert
    add     sp, 4
    mov     [bp+var_vec2.vx], 0
    mov     [bp+var_vec2.vy], 0
    mov     [bp+var_vec2.vz], 1000h
    lea     ax, [bp+var_vec3]
    push    ax
    lea     ax, [bp+var_mat]
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+var_vec3.vy], 0
    jle     short loc_25046
    mov     bx, [bp+arg_transshapeptr]
    cmp     [bx+TRANSFORMEDSHAPE.ts_pos.vy], 0
    jge     short loc_25046
    jmp     loc_24F9F
loc_25046:
    push    [bp+var_vec.vx] ; int
    call    _abs
    add     sp, 2
    mov     bx, [bp+arg_transshapeptr]
    mov     cx, [bx+TRANSFORMEDSHAPE.ts_unk]
    shl     cx, 1
    cmp     cx, ax
    jle     short loc_25077
    push    [bp+var_vec.vz] ; int
    call    _abs
    add     sp, 2
    mov     bx, [bp+arg_transshapeptr]
    mov     cx, [bx+TRANSFORMEDSHAPE.ts_unk]
    shl     cx, 1
    cmp     cx, ax
    jle     short loc_25077
    jmp     loc_24F9F
loc_25077:
    lea     ax, [bp+var_vec3]
    push    ax
    push    cs
    call near ptr vector_op_unk2
    add     sp, 2
    mov     byte_4393D, al
    cbw
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    mov     ax, word ptr invpow2tbl[bx]
    mov     dx, word ptr (invpow2tbl+2)[bx]
    mov     word ptr [bp+var_45C], ax
    mov     word ptr [bp+var_45C+2], dx
    mov     word ptr [bp+var_A], ax
    mov     word ptr [bp+var_A+2], dx
loc_250A3:
    mov     ax, word_443F2  ; initialized to 190h in polyinfo_reset()
    mov     word_4394E, ax
    mov     word_45D98, ax
    mov     word_4554A, 0
    mov     [bp+var_45E], 0
    cmp     transshapenumverts, 8
    jbe     short loc_250C6
    mov     transshapenumvertscopy, 8
    jmp     short loc_250CC
loc_250C6:
    mov     al, byte ptr transshapenumverts
    mov     transshapenumvertscopy, al
loc_250CC:
    cmp     transshapenumvertscopy, 4
    jbe     short loc_250E6
    les     bx, transshapeverts
    mov     ax, es:[bx+1Ah]
    cmp     es:[bx+2], ax
    jnz     short loc_250E6
    mov     transshapenumvertscopy, 4
loc_250E6:
    mov     [bp+var_ptrectflag], 0Fh
    mov     [bp+var_460], 1
    mov     [bp+var_1A], 0
    sub     si, si
    jmp     short loc_2513F
loc_250FA:
    mov     [bp+var_460], 0
    mov     [bp+si+var_vertflagtbl], 0
    mov     bx, si
    shl     bx, 1
    push    polyvertpointptrtab[bx]
    lea     ax, [bp+var_vec3]
    push    ax
    call    vector_to_point
    add     sp, 4
    cmp     [bp+var_ptrectflag], 0
    jz      short loc_25134
    mov     bx, si
    shl     bx, 1
    push    polyvertpointptrtab[bx]
    push    cs
    call near ptr rect_compare_point
    add     sp, 2
    and     [bp+var_ptrectflag], al
loc_25134:
    cmp     [bp+var_ptrectflag], 0
    jnz     short loc_2513E
    jmp     loc_25220
loc_2513E:
    inc     si
loc_2513F:
    mov     al, transshapenumvertscopy
    sub     ah, ah
    cmp     ax, si
    ja      short loc_2514B
    jmp     loc_251F6
loc_2514B:
    mov     bx, si
    shl     bx, 1
    mov     ax, si
    shl     ax, 1
    shl     ax, 1
    add     ax, bp
    sub     ax, 416h        ; array access in var_416, but dunno how to make IDA show this
    mov     polyvertpointptrtab[bx], ax
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr transshapeverts
    mov     dx, word ptr transshapeverts+2
    push    si
    push    di
    lea     di, [bp+var_vec2]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    movsw
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    cmp     select_rect_param, 0
    jz      short loc_25196
    sar     [bp+var_vec2.vx], 1
    sar     [bp+var_vec2.vy], 1
    sar     [bp+var_vec2.vz], 1
loc_25196:
    lea     ax, [bp+var_vec3]
    push    ax
    lea     ax, [bp+var_mat2]
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+var_vec.vx]
    add     [bp+var_vec3.vx], ax
    mov     ax, [bp+var_vec.vy]
    add     [bp+var_vec3.vy], ax
    mov     ax, [bp+var_vec.vz]
    add     [bp+var_vec3.vz], ax
    mov     bx, si
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1           ; bx = vertex index * 6
    add     bx, bp
    push    si
    push    di
    lea     di, [bx+var_vecarr]
    lea     si, [bp+var_vec3]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    cmp     [bp+var_vec3.vz], 0Ch
    jl      short loc_251E9
    jmp     loc_250FA
loc_251E9:
    mov     [bp+si+var_vertflagtbl], 1
    mov     [bp+var_1A], 1
    jmp     loc_2513E
loc_251F6:
    cmp     [bp+var_460], 0
    jnz     short _done_ret_neg1
    cmp     [bp+var_1A], 0
    jz      short _done_ret_neg1
    push    [bp+var_vec.vx] ; int
    call    _abs
    add     sp, 2
    mov     bx, [bp+arg_transshapeptr]
    cmp     [bx+TRANSFORMEDSHAPE.ts_unk], ax
    jge     short loc_25220
_done_ret_neg1:
    mov     ax, 0FFFFh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_25220:
    mov     bx, [bp+arg_transshapeptr]
    mov     bx, [bx+TRANSFORMEDSHAPE.ts_shapeptr]
    mov     ax, word ptr [bx+SHAPE3D.shape3d_primitives]
    mov     dx, word ptr [bx+(SHAPE3D.shape3d_primitives+2)]
    mov     word ptr transshapeprimitives, ax
    mov     word ptr transshapeprimitives+2, dx
loc_25233:
    les     bx, transshapeprimitives
    mov     bl, es:[bx]     ; primitives+0 = primitive type
    sub     bh, bh
    mov     al, primidxcounttab[bx]; look up maybe indexcount from a table?
    sub     ah, ah
    add     ax, transshapenumpaints
    add     ax, word ptr transshapeprimitives
    mov     dx, es
    add     ax, 2
    mov     word ptr transshapeprimptr, ax
    mov     word ptr transshapeprimptr+2, dx
    mov     bx, word ptr transshapeprimitives
    mov     al, es:[bx+1]   ; primitives+1 = primitive flags
    sub     ah, ah
    mov     [bp+var_primitiveflags], ax
    mov     [bp+var_4], 0
    les     bx, [bp+var_cull1]
    mov     ax, es:[bx]
    mov     dx, es:[bx+2]
    and     ax, word ptr [bp+var_45C]
    and     dx, word ptr [bp+var_45C+2]
    or      dx, ax
    jnz     short loc_25282
    jmp     loc_25801
loc_25282:
    les     bx, transshapeprimitives
    mov     al, es:[bx]     ; primitives+0 = type
    sub     ah, ah
    mov     [bp+var_fileprimtype], ax
    mov     bx, ax
    mov     al, primidxcounttab[bx]
    mov     transshapenumvertscopy, al
    mov     al, primtypetab[bx]
    mov     [bp+var_primtype], al; primunktab maps from file-based primitive type to internal type:
    mov     ax, polyinfoptrnext
    add     ax, word ptr polyinfoptr
    mov     dx, word ptr polyinfoptr+2
    mov     word ptr transshapepolyinfo, ax
    mov     word ptr transshapepolyinfo+2, dx
    mov     bx, polyinfonumpolys
    shl     bx, 1
    shl     bx, 1
    mov     word ptr polyinfoptrs[bx], ax
    mov     word ptr (polyinfoptrs+2)[bx], dx
    mov     bl, transshapematerial
    sub     bh, bh
    add     bx, word ptr transshapeprimitives
    mov     es, word ptr transshapeprimitives+2
    mov     al, es:[bx+2]   ; primitives+2+X = paint job color, X in [0..numpaints]
    mov     transprimitivepaintjob, al
    mov     ax, transshapenumpaints
    add     ax, 2
    add     word ptr transshapeprimitives, ax; <- skip header and materials, -> point at indices
    mov     [bp+var_ptrectflag], 0Fh
    mov     [bp+var_460], 1
    mov     [bp+var_1A], 0
    mov     ax, word ptr transshapeprimitives
    mov     dx, es
    mov     word ptr transshapeprimindexptr, ax
    mov     word ptr transshapeprimindexptr+2, dx
    mov     [bp+var_polyvertcounter], 0
    jmp     short loc_25328
    ; align 2
    db 144
loc_25304:
    mov     [bp+var_460], 0
loc_2530A:
    cmp     [bp+var_ptrectflag], 0
    jz      short loc_25325
    mov     bx, [bp+var_polyvertcounter]
    shl     bx, 1
    push    polyvertpointptrtab[bx]
    push    cs
    call near ptr rect_compare_point
    add     sp, 2
    and     [bp+var_ptrectflag], al
loc_25325:
    inc     [bp+var_polyvertcounter]
loc_25328:
    mov     al, transshapenumvertscopy
    sub     ah, ah
    cmp     [bp+var_polyvertcounter], ax
    jb      short loc_25335
    jmp     loc_2542A
loc_25335:
    mov     bx, word ptr transshapeprimindexptr
    inc     word ptr transshapeprimindexptr
    mov     es, word ptr transshapeprimindexptr+2
    mov     al, es:[bx]
    mov     si, ax
    mov     bx, [bp+var_polyvertcounter]
    shl     bx, 1
    shl     ax, 1
    shl     ax, 1
    add     ax, bp
    sub     ax, 416h
    mov     polyvertpointptrtab[bx], ax
    mov     al, [bp+si+var_vertflagtbl]
    cbw
    cmp     ax, 0FFFFh
    jz      short loc_25370
loc_25362:
    or      ax, ax
    jz      short loc_25304
    cmp     ax, 1
    jnz     short loc_2536E
    jmp     loc_253FD
loc_2536E:
    jmp     short loc_25325
loc_25370:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr transshapeverts
    mov     dx, word ptr transshapeverts+2
    push    si
    push    di
    lea     di, [bp+var_vec2]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    movsw
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    cmp     select_rect_param, 0
    jz      short loc_253A8
    sar     [bp+var_vec2.vx], 1
    sar     [bp+var_vec2.vy], 1
    sar     [bp+var_vec2.vz], 1
loc_253A8:
    lea     ax, [bp+var_vec3]
    push    ax
    lea     ax, [bp+var_mat2]
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+var_vec.vx]
    add     [bp+var_vec3.vx], ax
    mov     ax, [bp+var_vec.vy]
    add     [bp+var_vec3.vy], ax
    mov     ax, [bp+var_vec.vz]
    add     [bp+var_vec3.vz], ax
    mov     bx, si
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, bp
    push    si
    push    di
    lea     di, [bx+var_vecarr]
    lea     si, [bp+var_vec3]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
loc_253F1:
    cmp     [bp+var_vec3.vz], 0Ch
    jge     short loc_25406
    mov     [bp+si+var_vertflagtbl], 1
loc_253FD:
    mov     [bp+var_1A], 1
    jmp     loc_25325
    ; align 2
    db 144
loc_25406:
    mov     [bp+var_460], 0
    mov     [bp+si+var_vertflagtbl], 0
    mov     bx, [bp+var_polyvertcounter]
    shl     bx, 1
    push    polyvertpointptrtab[bx]
    lea     ax, [bp+var_vec3]
    push    ax
    call    vector_to_point
    add     sp, 4
    jmp     loc_2530A
loc_2542A:
    cmp     [bp+var_460], 0
    jz      short loc_25434
    jmp     loc_25801
loc_25434:
    cmp     [bp+var_ptrectflag], 0
    jz      short loc_25444
    cmp     [bp+var_1A], 0
    jnz     short loc_25444
    jmp     loc_25801
loc_25444:
    mov     al, [bp+var_primtype]
    sub     ah, ah
    or      ax, ax
    jz      short _primtype_poly; al = 0 for polygons,
    cmp     ax, 1           ; 1 = lines
    jnz     short loc_25455
    jmp     _primtype_line
loc_25455:
    cmp     ax, 2
    jnz     short loc_2545D
    jmp     _primtype_sphere; 2 = sphere
loc_2545D:
    cmp     ax, 3
    jnz     short loc_25465
    jmp     _primtype_wheel ; 3 = wheel
loc_25465:
    cmp     ax, 5
    jnz     short loc_2546D
    jmp     loc_25CE0       ; 5 = particle
loc_2546D:
    jmp     loc_25801       ; everything else? (4?)
_primtype_poly:
    mov     ax, word ptr transshapepolyinfo
    mov     dx, word ptr transshapepolyinfo+2
    add     ax, 6
    mov     word ptr [bp+var_transshapepolyinfoptptr], ax
    mov     word ptr [bp+var_transshapepolyinfoptptr+2], dx
    mov     ax, word ptr transshapeprimitives
    mov     dx, word ptr transshapeprimitives+2
    mov     word ptr transshapeprimindexptr, ax
    mov     word ptr transshapeprimindexptr+2, dx
    sub     ax, ax
    mov     word ptr [bp+var_18+2], ax
    mov     word ptr [bp+var_18], ax
    mov     [bp+var_ptrectflag], 0Fh
    cmp     [bp+var_1A], ax
    jnz     short loc_25518
    sub     si, si
    jmp     short loc_254A7
loc_254A6:
    inc     si
loc_254A7:
    mov     al, transshapenumvertscopy
    sub     ah, ah
    cmp     ax, si
    ja      short loc_254B3
    jmp     loc_2571A
loc_254B3:
    mov     bx, word ptr transshapeprimindexptr
    inc     word ptr transshapeprimindexptr
    mov     es, word ptr transshapeprimindexptr+2
    mov     al, es:[bx]
    mov     [bp+var_C], ax
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, bp
    mov     ax, [bx+var_vecarr.vz]
    cwd
    add     word ptr [bp+var_18], ax
    adc     word ptr [bp+var_18+2], dx
    mov     ax, si
    shl     ax, 1
    add     ax, offset polyvertpointptrtab
    mov     [bp+var_polyvertunktabptr], ax
    mov     bx, ax
    mov     bx, [bx]
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, [bp+var_transshapepolyinfoptptr]
    mov     es:[bx], ax
    mov     es:[bx+2], dx
    cmp     [bp+var_ptrectflag], 0
    jz      short loc_25511
    mov     bx, [bp+var_polyvertunktabptr]
    push    word ptr [bx]
    push    cs
    call near ptr rect_compare_point
    add     sp, 2
    and     [bp+var_ptrectflag], al
loc_25511:
    add     word ptr [bp+var_transshapepolyinfoptptr], 4
    jmp     short loc_254A6
loc_25518:
    mov     [bp+var_polyvertcounter], 0
    mov     bl, transshapenumvertscopy
    sub     bh, bh
    add     bx, word ptr transshapeprimitives
    mov     es, word ptr transshapeprimitives+2
    mov     al, es:[bx-1]
    sub     ah, ah
    mov     [bp+var_448], ax
    sub     si, si
    jmp     loc_255EE
loc_2553A:
    mov     bx, [bp+var_448]
    add     bx, bp
    cmp     [bx+var_vertflagtbl], 0
    jz      short loc_2554A
    jmp     loc_255E6
loc_2554A:
    mov     ax, 0Ch
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    mov     ax, [bp+var_C]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    sub     ax, 0B6Eh
    push    ax
    mov     ax, [bp+var_448]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    sub     ax, 0B6Eh
    push    ax
    call    vector_op_unk
    add     sp, 8
    lea     ax, [bp+var_574]
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    vector_to_point
    add     sp, 4
    mov     ax, [bp+var_448]
    shl     ax, 1
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_B7C], ax
    mov     bx, ax
    mov     ax, [bp+var_574.x2]
    cmp     [bx+var_vecarr2.x2], ax
    jnz     short loc_255B4
    mov     ax, [bp+var_574.y2]
    cmp     [bx+var_vecarr2.y2], ax
    jz      short loc_255E6
loc_255B4:
    cmp     [bp+var_ptrectflag], 0
    jz      short loc_255CB
    lea     ax, [bp+var_574]
    push    ax
    push    cs
    call near ptr rect_compare_point
    add     sp, 2
    and     [bp+var_ptrectflag], al
loc_255CB:
    les     bx, [bp+var_transshapepolyinfoptptr]
    mov     ax, [bp+var_574.x2]
    mov     dx, [bp+var_574.y2]
    mov     es:[bx], ax
    mov     es:[bx+2], dx
loc_255DE:
    add     word ptr [bp+var_transshapepolyinfoptptr], 4
    inc     [bp+var_polyvertcounter]
loc_255E6:
    mov     ax, [bp+var_C]
    mov     [bp+var_448], ax
    inc     si
loc_255EE:
    mov     al, transshapenumvertscopy
    sub     ah, ah
    cmp     ax, si
    ja      short loc_255FA
    jmp     loc_25714
loc_255FA:
    mov     bx, word ptr transshapeprimindexptr
    inc     word ptr transshapeprimindexptr
    mov     es, word ptr transshapeprimindexptr+2
    mov     al, es:[bx]
    mov     [bp+var_C], ax
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_polyvertunktabptr], ax
    mov     bx, ax
    mov     ax, [bx+var_vecarr.vz]
    cwd
    add     word ptr [bp+var_18], ax
    adc     word ptr [bp+var_18+2], dx
    mov     bx, cx
    add     bx, bp
    cmp     [bx+var_vertflagtbl], 0
    jz      short loc_25635
    jmp     loc_2553A
loc_25635:
    mov     bx, [bp+var_448]
    add     bx, bp
    cmp     [bx+var_vertflagtbl], 0
    jnz     short loc_25645
    jmp     loc_256D7
loc_25645:
    mov     ax, 0Ch
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    mov     ax, [bp+var_448]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    sub     ax, 0B6Eh
    push    ax
    mov     ax, [bp+var_polyvertunktabptr]
    sub     ax, 0B6Eh
    push    ax
    call    vector_op_unk
    add     sp, 8
    lea     ax, [bp+var_574]
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    vector_to_point
    add     sp, 4
    mov     ax, [bp+var_C]
    shl     ax, 1
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_B7C], ax
    mov     bx, ax
    mov     ax, [bp+var_574.x2]
    cmp     [bx+var_vecarr2.x2], ax
    jnz     short loc_256A5
    mov     ax, [bp+var_574.y2]
    cmp     [bx+var_vecarr2.y2], ax
    jz      short loc_256D7
loc_256A5:
    cmp     [bp+var_ptrectflag], 0
    jz      short loc_256BC
    lea     ax, [bp+var_574]
    push    ax
    push    cs
    call near ptr rect_compare_point
    add     sp, 2
    and     [bp+var_ptrectflag], al
loc_256BC:
    les     bx, [bp+var_transshapepolyinfoptptr]
    mov     ax, [bp+var_574.x2]
    mov     dx, [bp+var_574.y2]
    mov     es:[bx], ax
    mov     es:[bx+2], dx
    add     word ptr [bp+var_transshapepolyinfoptptr], 4
    inc     [bp+var_polyvertcounter]
loc_256D7:
    mov     ax, si
    shl     ax, 1
    add     ax, offset polyvertpointptrtab
    mov     [bp+var_B7C], ax
    mov     bx, ax
    mov     bx, [bx]
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, [bp+var_transshapepolyinfoptptr]
    mov     es:[bx], ax
    mov     es:[bx+2], dx
    cmp     [bp+var_ptrectflag], 0
    jnz     short loc_25700
    jmp     loc_255DE
loc_25700:
    mov     bx, [bp+var_B7C]
    push    word ptr [bx]
    push    cs
    call near ptr rect_compare_point
    add     sp, 2
    and     [bp+var_ptrectflag], al
    jmp     loc_255DE
loc_25714:
    mov     al, byte ptr [bp+var_polyvertcounter]
    mov     transshapenumvertscopy, al
loc_2571A:
    cmp     transshapenumvertscopy, 0
    jnz     short loc_25724
    jmp     loc_25801
loc_25724:
    cmp     [bp+var_ptrectflag], 0
    jz      short loc_2572E
    jmp     loc_25801
loc_2572E:
    test    byte ptr [bp+var_primitiveflags], 1
    jnz     short loc_25760
    les     bx, [bp+var_cull2]
    mov     ax, es:[bx]
    mov     dx, es:[bx+2]
    and     ax, word ptr [bp+var_A]
    and     dx, word ptr [bp+var_A+2]
    or      dx, ax
    jnz     short loc_25760
    mov     ax, word ptr transshapepolyinfo
    mov     dx, word ptr transshapepolyinfo+2
    add     ax, 6
    push    dx
    push    ax
    push    cs
    call near ptr transformed_shape_op_helper3
    add     sp, 4
    or      al, al
    jz      short loc_25763
loc_25760:
    inc     [bp+var_4]
loc_25763:
    cmp     [bp+var_4], 0
    jnz     short loc_2576C
    jmp     loc_25801
loc_2576C:
    test    transshapeflags, 8
    jnz     short loc_25776
    jmp     loc_25801
loc_25776:
    mov     ax, word ptr transshapepolyinfo
    mov     dx, word ptr transshapepolyinfo+2
    add     ax, 6
    mov     word ptr [bp+var_polyvertsptr], ax
    mov     word ptr [bp+var_polyvertsptr+2], dx
    mov     [bp+var_polyvertcounter], 0
    jmp     short loc_257F7
    ; align 2
    db 144
loc_25790:
    les     bx, [bp+var_polyvertsptr]
    mov     ax, es:[bx+POINT2D.x2]
    mov     [bp+var_polyvertX], ax
    mov     ax, es:[bx+POINT2D.y2]
    mov     [bp+var_polyvertY], ax
    add     word ptr [bp+var_polyvertsptr], 4
    mov     bx, transshaperectptr
    mov     ax, [bx+RECTANGLE.rc_left]
    cmp     [bp+var_polyvertX], ax
    jge     short loc_257BA
    mov     ax, [bp+var_polyvertX]
    mov     [bx+RECTANGLE.rc_left], ax
loc_257BA:
    mov     ax, [bp+var_polyvertX]
    inc     ax
    mov     [bp+var_B7C], ax
    mov     bx, transshaperectptr
    cmp     [bx+RECTANGLE.rc_right], ax
    jge     short loc_257CF
    mov     [bx+RECTANGLE.rc_right], ax
loc_257CF:
    mov     bx, transshaperectptr
    mov     ax, [bp+var_polyvertY]
    cmp     [bx+RECTANGLE.rc_top], ax
    jle     short loc_257DF
    mov     [bx+RECTANGLE.rc_top], ax
loc_257DF:
    mov     ax, [bp+var_polyvertY]
    inc     ax
    mov     [bp+var_B7C], ax
    mov     bx, transshaperectptr
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jge     short loc_257F4
    mov     [bx+RECTANGLE.rc_bottom], ax
loc_257F4:
    inc     [bp+var_polyvertcounter]
loc_257F7:
    mov     al, transshapenumvertscopy
    sub     ah, ah
    cmp     [bp+var_polyvertcounter], ax
    jb      short loc_25790
loc_25801:
    mov     ax, word ptr transshapeprimptr
    mov     dx, word ptr transshapeprimptr+2
    mov     word ptr transshapeprimitives, ax
    mov     word ptr transshapeprimitives+2, dx
    add     word ptr [bp+var_cull2], 4
    add     word ptr [bp+var_cull1], 4
    cmp     [bp+var_4], 0
    jz      short loc_25822
    jmp     loc_25D3C
loc_25822:
    test    byte ptr [bp+var_primitiveflags], 2
    jz      short loc_2582B
    jmp     loc_25E04
loc_2582B:
    les     bx, transshapeprimitives
    test    byte ptr es:[bx+1], 2
    jnz     short loc_25839
    jmp     loc_25E04
loc_25839:
    mov     bl, es:[bx]
    sub     bh, bh
    mov     al, primidxcounttab[bx]
    sub     ah, ah
    add     ax, transshapenumpaints
    add     ax, 2
    add     word ptr transshapeprimitives, ax
    add     word ptr [bp+var_cull1], 4
    add     word ptr [bp+var_cull2], 4
    jmp     short loc_2582B
    ; align 2
    db 144
_primtype_line:
    les     bx, transshapeprimitives
    mov     al, es:[bx]
    sub     ah, ah
    mov     si, ax
    mov     al, es:[bx+1]
    mov     di, ax
    mov     al, [bp+di+var_vertflagtbl]
    cbw
    mov     cx, ax
    mov     al, [bp+si+var_vertflagtbl]
    cbw
    add     ax, cx
    cmp     ax, 2
    jz      short loc_25801
    cmp     [bp+si+var_vertflagtbl], 0
    jz      short loc_258BC
    mov     ax, 0Ch
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    sub     ax, 0B6Eh
    push    ax
    mov     ax, di
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    sub     ax, 0B6Eh
    push    ax
    call    vector_op_unk
    add     sp, 8
    mov     ax, si
    jmp     short loc_258F6
loc_258BC:
    cmp     [bp+di+var_vertflagtbl], 0
    jz      short loc_2590D
    mov     ax, 0Ch
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    mov     ax, di
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    sub     ax, 0B6Eh
    push    ax
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    sub     ax, 0B6Eh
    push    ax
    call    vector_op_unk
    add     sp, 8
    mov     ax, di
loc_258F6:
    shl     ax, 1
    shl     ax, 1
    add     ax, bp
    sub     ax, 416h
    push    ax
    lea     ax, [bp+var_vec2]
    push    ax
    call    vector_to_point
    add     sp, 4
loc_2590D:
    mov     bx, si
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, bp
    mov     ax, [bx+var_vecarr.vz]
    mov     bx, di
    mov     cx, bx
    shl     bx, 1
    add     bx, cx
    shl     bx, 1
    add     bx, bp
    add     ax, [bx+var_vecarr.vz]
    cwd
    mov     word ptr [bp+var_18], ax
    mov     word ptr [bp+var_18+2], dx
    mov     bx, polyvertpointptrtab
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+6], ax
    mov     es:[bx+8], dx
    mov     bx, polyvertpointptrtab+2
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+0Ah], ax
    mov     es:[bx+0Ch], dx
    test    transshapeflags, 8
    jz      short loc_25983
    push    transshaperectptr
    push    polyvertpointptrtab
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
    push    transshaperectptr
    push    polyvertpointptrtab+2
loc_2597C:
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
loc_25983:
    mov     transshapenumvertscopy, 2
loc_25988:
    inc     [bp+var_4]
    jmp     loc_25801
_primtype_wheel:
    cmp     [bp+var_1A], 0
    jz      short loc_25997
    jmp     loc_25801
loc_25997:
    mov     bx, polyvertpointptrtab
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+6], ax
    mov     es:[bx+8], dx
    mov     bx, polyvertpointptrtab+2
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+0Ah], ax
    mov     es:[bx+0Ch], dx
    mov     bx, polyvertpointptrtab+4
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+0Eh], ax
    mov     es:[bx+10h], dx
    mov     bx, polyvertpointptrtab+6
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+12h], ax
    mov     es:[bx+14h], dx
    mov     ax, word ptr transshapepolyinfo
    mov     dx, word ptr transshapepolyinfo+2
    add     ax, 6
    push    dx
    push    ax
    push    cs
    call near ptr transformed_shape_op_helper3
    add     sp, 4
    or      al, al
    jnz     short loc_25A7C
    mov     bx, polyvertpointptrtab+6
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+6], ax
    mov     es:[bx+8], dx
    mov     bx, polyvertpointptrtab+8
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+0Ah], ax
    mov     es:[bx+0Ch], dx
    mov     bx, polyvertpointptrtab+0Ah
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+0Eh], ax
    mov     es:[bx+10h], dx
    mov     bx, polyvertpointptrtab
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+12h], ax
    mov     es:[bx+14h], dx
    les     bx, transshapeprimitives
    mov     al, es:[bx+3]   ; primitives+3 = paintjob 1? [0..x]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, bp
    mov     ax, [bx+var_vecarr.vz]
    cwd
    mov     cl, 2
loc_25A71:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_25A71
    jmp     short loc_25A9E
    ; align 2
    db 144
loc_25A7C:
    les     bx, transshapeprimitives
    mov     al, es:[bx]     ; primitives+0 = primitivetype
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, bp
    mov     ax, [bx+var_vecarr.vz]
    cwd
    mov     cl, 2
loc_25A96:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jnz     short loc_25A96
loc_25A9E:
    mov     word ptr [bp+var_18], ax
    mov     word ptr [bp+var_18+2], dx
    les     bx, transshapepolyinfo
    mov     ax, es:[bx+8]
    sub     ax, es:[bx+0Ch]
    push    ax
    mov     ax, es:[bx+6]
    sub     ax, es:[bx+0Ah]
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     si, ax
    les     bx, transshapepolyinfo
    mov     ax, es:[bx+8]
    sub     ax, es:[bx+10h]
    push    ax
    mov     ax, es:[bx+6]
    sub     ax, es:[bx+0Eh]
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     di, ax
    cmp     di, si
    jle     short loc_25AEA
    mov     si, di
loc_25AEA:
    test    transshapeflags, 8
    jnz     short loc_25AF4
    jmp     loc_25B9C
loc_25AF4:
    les     bx, transshapepolyinfo
    mov     ax, es:[bx+6]
    sub     ax, si
    dec     ax
    mov     [bp+var_450.x2], ax
    mov     ax, es:[bx+8]
    sub     ax, si
    dec     ax
    mov     [bp+var_450.y2], ax
    push    transshaperectptr
    lea     ax, [bp+var_450]
    push    ax
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
    les     bx, transshapepolyinfo
    mov     ax, es:[bx+8]
    add     ax, si
    inc     ax
    mov     [bp+var_450.y2], ax
    mov     ax, es:[bx+6]
    add     ax, si
    inc     ax
    mov     [bp+var_450.x2], ax
    push    transshaperectptr
    lea     ax, [bp+var_450]
    push    ax
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
    les     bx, transshapepolyinfo
    mov     ax, es:[bx+12h]
    sub     ax, si
    dec     ax
    mov     [bp+var_450.x2], ax
    mov     ax, es:[bx+14h]
    sub     ax, si
    dec     ax
    mov     [bp+var_450.y2], ax
    push    transshaperectptr
    lea     ax, [bp+var_450]
    push    ax
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
    les     bx, transshapepolyinfo
    mov     ax, es:[bx+14h]
    add     ax, si
    inc     ax
    mov     [bp+var_450.y2], ax
    mov     ax, es:[bx+12h]
    add     ax, si
    inc     ax
    mov     [bp+var_450.x2], ax
    push    transshaperectptr
    lea     ax, [bp+var_450]
    push    ax
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
loc_25B9C:
    mov     transshapenumvertscopy, 4
    mov     [bp+var_4], 1
    jmp     loc_25801
    ; align 2
    db 144
_primtype_sphere:
    les     bx, transshapeprimitives
    mov     al, es:[bx]
    sub     ah, ah
    mov     si, ax
    mov     al, es:[bx+1]
    mov     di, ax
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_B7C], ax
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_polyvertunktabptr], ax
    mov     bx, ax
    mov     ax, [bx+var_vecarr.vz]
    mov     bx, [bp+var_B7C]
    add     ax, [bx+var_vecarr.vz]
    cwd
    mov     word ptr [bp+var_18], ax
    mov     word ptr [bp+var_18+2], dx
    mov     al, [bp+di+var_vertflagtbl]
    cbw
    mov     cx, ax
    mov     al, [bp+si+var_vertflagtbl]
    cbw
    add     ax, cx
    jz      short loc_25C01
    jmp     loc_25801
loc_25C01:
    mov     bx, polyvertpointptrtab
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+6], ax
    mov     es:[bx+8], dx
    mov     bx, [bp+var_polyvertunktabptr]
    push    si
    push    di
    lea     di, [bp+var_vec3]
    lea     si, [bx+var_vecarr]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     bx, [bp+var_B7C]
    push    si
    push    di
    lea     di, [bp+var_vec4]
    lea     si, [bx-0B6Eh]
    movsw
    movsw
    movsw
    pop     di
    pop     si
    mov     ax, [bp+var_vec3.vx]
    sub     ax, [bp+var_vec4.vx]
    mov     [bp+var_vec2.vx], ax
    mov     ax, [bp+var_vec3.vy]
    sub     ax, [bp+var_vec4.vy]
    mov     [bp+var_vec2.vy], ax
    mov     ax, [bp+var_vec3.vz]
    sub     ax, [bp+var_vec4.vz]
    mov     [bp+var_vec2.vz], ax
    push    [bp+var_vec3.vz]
    lea     ax, [bp+var_vec2]
    push    ax
    call    polarRadius3D
    add     sp, 2
    push    ax
    call    transformed_shape_op_helper2
    add     sp, 4
    mov     [bp+var_462], ax
    les     bx, transshapepolyinfo
    mov     es:[bx+0Ah], ax
    test    transshapeflags, 8
    jnz     short loc_25C92
    jmp     loc_25983
loc_25C92:
    mov     bx, polyvertpointptrtab
    mov     ax, [bx+2]
    sub     ax, [bp+var_462]
    mov     [bp+var_450.y2], ax
    mov     ax, [bx]
    sub     ax, [bp+var_462]
    mov     [bp+var_450.x2], ax
    push    transshaperectptr
    lea     ax, [bp+var_450]
    push    ax
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
    mov     ax, [bp+var_462]
    mov     bx, polyvertpointptrtab
    add     ax, [bx]
    mov     [bp+var_450.x2], ax
    mov     ax, [bx+2]
    add     ax, [bp+var_462]
    mov     [bp+var_450.x2], ax
    push    transshaperectptr
    lea     ax, [bp+var_450]
    push    ax
    jmp     loc_2597C
loc_25CE0:
    les     bx, transshapeprimitives
    mov     al, es:[bx]     ; primitives+ 0 = type
    sub     ah, ah
    mov     si, ax
    cmp     [bp+si+var_vertflagtbl], ah
    jz      short loc_25CF4
    jmp     loc_25801
loc_25CF4:
    mov     bx, si
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, bp
    mov     ax, [bx+var_vecarr.vz]
    cwd
    mov     word ptr [bp+var_18], ax
    mov     word ptr [bp+var_18+2], dx
    mov     bx, polyvertpointptrtab
    mov     ax, [bx]
    mov     dx, [bx+2]
    les     bx, transshapepolyinfo
    mov     es:[bx+6], ax
    mov     es:[bx+8], dx
    test    transshapeflags, 8
    jz      short loc_25D34
    push    transshaperectptr
    push    polyvertpointptrtab
    push    cs
    call near ptr rect_adjust_from_point
    add     sp, 4
loc_25D34:
    mov     transshapenumvertscopy, 1
    jmp     loc_25988
loc_25D3C:
    inc     [bp+var_45E]
    les     bx, transshapepolyinfo
    mov     al, transshapenumvertscopy
    mov     es:[bx+3], al   ; polyinfo+3 = numverts
    les     bx, transshapepolyinfo
    mov     al, [bp+var_primtype]
    mov     es:[bx+4], al   ; polyinfo+4 = primtype
    cmp     transprimitivepaintjob, 2Dh ; '-'; if shape paintjob = 0x2d (back lights), use override
    jnz     short loc_25D66
    les     bx, transshapepolyinfo
    mov     al, backlights_paint_override
    jmp     short loc_25D6D
loc_25D66:
    les     bx, transshapepolyinfo
    mov     al, transprimitivepaintjob
loc_25D6D:
    mov     es:[bx+2], al   ; polyinfo+2 = paintjob
    mov     al, transshapenumvertscopy
    sub     ah, ah
    cmp     ax, 1
    jz      short loc_25D9C
    cmp     ax, 2
    jz      short loc_25DB8
    cmp     ax, 4
    jz      short loc_25DC6
    cmp     ax, 8
    jz      short loc_25DDA
    sub     cx, cx
    push    cx
    push    ax
    push    word ptr [bp+var_18+2]
    push    word ptr [bp+var_18]
    call    __aFuldiv
    jmp     short loc_25DC2
    ; align 2
    db 144
loc_25D9C:
    mov     si, word ptr [bp+var_18]
loc_25D9F:
    les     bx, transshapepolyinfo
    mov     es:[bx], si     ; polyinfo+0 = ???
    test    transshapeflags, 1
    jnz     short loc_25DB3
    test    byte ptr [bp+var_primitiveflags], 2
    jz      short loc_25DEE
loc_25DB3:
    sub     ax, ax
    jmp     short loc_25DF1
    ; align 2
    db 144
loc_25DB8:
    mov     ax, word ptr [bp+var_18]
    mov     dx, word ptr [bp+var_18+2]
    sar     dx, 1
    rcr     ax, 1
loc_25DC2:
    mov     si, ax
    jmp     short loc_25D9F
loc_25DC6:
    mov     ax, word ptr [bp+var_18]
    mov     dx, word ptr [bp+var_18+2]
    mov     cl, 2
loc_25DCE:
    or      cl, cl
    jz      short loc_25DC2
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jmp     short loc_25DCE
loc_25DDA:
    mov     ax, word ptr [bp+var_18]
    mov     dx, word ptr [bp+var_18+2]
    mov     cl, 3
loc_25DE2:
    or      cl, cl
    jz      short loc_25DC2
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jmp     short loc_25DE2
loc_25DEE:
    mov     ax, 1
loc_25DF1:
    push    ax
    push    si
    push    cs
    call near ptr transformed_shape_op_helper
    add     sp, 4
    mov     word_40ECE, ax
    or      ax, ax
    jz      short loc_25E04
    jmp     loc_24EAE
loc_25E04:
    les     bx, transshapeprimitives
    cmp     byte ptr es:[bx], 0
    jz      short _transform_done
    jmp     loc_25233
_transform_done:
    cmp     [bp+var_45E], 0
    jnz     short _done_ret_0
    jmp     _done_ret_neg1
_done_ret_0:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
transformed_shape_op endp
transformed_shape_op_helper proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    cmp     [bp+arg_2], 0
    jnz     short loc_25E3E
    mov     bx, word_45D98
    shl     bx, 1
    mov     di, word_40ED6[bx]
    jmp     short loc_25E7B
loc_25E3E:
    mov     ax, word_4394E
    mov     word_45D98, ax
    mov     bx, ax
    shl     bx, 1
    mov     di, word_40ED6[bx]
    mov     si, word_4554A
    jmp     short loc_25E77
loc_25E52:
    mov     ax, si
    dec     si
    or      ax, ax
    jz      short loc_25E7B
    mov     bx, di
    shl     bx, 1
    shl     bx, 1
    les     bx, polyinfoptrs[bx]
    mov     ax, [bp+arg_0]
    cmp     es:[bx], ax
    jl      short loc_25E7B
    mov     word_45D98, di
    mov     bx, di
    shl     bx, 1
    mov     di, word_40ED6[bx]
loc_25E77:
    or      di, di
    jge     short loc_25E52
loc_25E7B:
    mov     bx, polyinfonumpolys
    shl     bx, 1
    mov     word_40ED6[bx], di
    mov     bx, word_45D98
    shl     bx, 1
    mov     ax, polyinfonumpolys
    mov     word_40ED6[bx], ax
    inc     word_4554A
    or      di, di
    jge     short loc_25EA0
    mov     ax, polyinfonumpolys
    mov     word_443F2, ax
loc_25EA0:
    mov     bx, word_45D98
    shl     bx, 1
    mov     ax, word_40ED6[bx]
    mov     word_45D98, ax
    inc     polyinfonumpolys
    mov     al, transshapenumvertscopy
    sub     ah, ah
    shl     ax, 1
    shl     ax, 1
    add     ax, 6
    add     polyinfoptrnext, ax
    cmp     polyinfonumpolys, 190h
    jz      short loc_25ED1
    cmp     polyinfoptrnext, 2872h
    jle     short loc_25EDA
loc_25ED1:
    mov     ax, 1           ; return 1 if error
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_25EDA:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
transformed_shape_op_helper endp
rect_compare_point proc far
    var_flags = byte ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_pointptr = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    mov     si, [bp+arg_pointptr]
    mov     ax, select_rect_rc.rc_top
    cmp     [si+POINT2D.y2], ax
    jge     short loc_25EFA
    mov     [bp+var_flags], 1
    jmp     short loc_25F0C
loc_25EFA:
    mov     ax, select_rect_rc.rc_bottom
    cmp     [si+POINT2D.y2], ax
    jle     short loc_25F08
    mov     [bp+var_flags], 2
    jmp     short loc_25F0C
loc_25F08:
    mov     [bp+var_flags], 0
loc_25F0C:
    mov     ax, select_rect_rc.rc_left
    cmp     [si+POINT2D.x2], ax
    jge     short loc_25F1A
smart
    or      [bp+var_flags], 4
nosmart
    jmp     short loc_25F25
    ; align 2
    db 144
loc_25F1A:
    mov     ax, select_rect_rc.rc_right
    cmp     [si+POINT2D.x2], ax
    jle     short loc_25F25
smart
    or      [bp+var_flags], 8
nosmart
loc_25F25:
    mov     al, [bp+var_flags]
    cbw
    pop     si
    mov     sp, bp
    pop     bp
    retf
rect_compare_point endp
transformed_shape_op_helper3 proc far
    var_10 = dword ptr -16
    var_C = dword ptr -12
    var_8 = dword ptr -8
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    di
    push    si
    les     bx, [bp+arg_0]
    mov     ax, es:[bx+4]
    cwd
    mov     cx, ax
    mov     ax, es:[bx]
    mov     bx, dx
    cwd
    sub     ax, cx
    sbb     dx, bx
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    mov     bx, word ptr [bp+arg_0]
    mov     ax, es:[bx+4]
    cwd
    mov     cx, ax
    mov     ax, es:[bx+8]
    mov     bx, dx
    cwd
    sub     ax, cx
    sbb     dx, bx
    mov     word ptr [bp+var_C], ax
    mov     word ptr [bp+var_C+2], dx
    mov     ax, word ptr [bp+var_4]
    or      ax, word ptr [bp+var_4+2]
    jnz     short loc_25F7A
    mov     ax, word ptr [bp+var_C]
    or      ax, dx
    jz      short loc_25FEE
loc_25F7A:
    mov     bx, word ptr [bp+arg_0]
    mov     ax, es:[bx+2]
    sub     ax, es:[bx+6]
    cwd
    mov     word ptr [bp+var_8], ax
    mov     word ptr [bp+var_8+2], dx
    mov     ax, es:[bx+0Ah]
    sub     ax, es:[bx+6]
    cwd
    mov     word ptr [bp+var_10], ax
    mov     word ptr [bp+var_10+2], dx
    mov     ax, word ptr [bp+var_8]
    or      ax, word ptr [bp+var_8+2]
    jnz     short loc_25FAA
    mov     ax, word ptr [bp+var_10]
    or      ax, dx
    jz      short loc_25FEE
loc_25FAA:
    push    word ptr [bp+var_10+2]
    push    word ptr [bp+var_10]
    push    word ptr [bp+var_4+2]
    push    word ptr [bp+var_4]
    call    __aFlmul
    push    word ptr [bp+var_8+2]
    push    word ptr [bp+var_8]
    push    word ptr [bp+var_C+2]
    push    word ptr [bp+var_C]
    mov     si, ax
    mov     di, dx
    call    __aFlmul
    sub     ax, si
    sbb     dx, di
    or      dx, dx
    jl      short loc_25FE4
    jg      short loc_25FDE
    or      ax, ax
    jz      short loc_25FE4
loc_25FDE:
    mov     al, 1
    jmp     short loc_25FE6
    ; align 4
    db 144
    db 144
loc_25FE4:
    sub     al, al
loc_25FE6:
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_25FEE:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
transformed_shape_op_helper3 endp
get_a_poly_info proc far
    var_pattype2 = word ptr -64
    var_polyinfoptrdata = dword ptr -62
    var_polyinfoptr = dword ptr -56
    var_32 = byte ptr -50
    var_32ptr = word ptr -10
    var_matcolor = word ptr -8
    var_mattype = word ptr -6
    var_counter = word ptr -4
    var_maxcount = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 40h
    push    di
    push    si
    mov     di, 190h
    sub     si, si
    jmp     loc_260AC
_fill_type0:
    les     bx, [bp+var_polyinfoptr]
    mov     al, es:[bx+3]
    cbw
    mov     [bp+var_maxcount], ax
    mov     ax, bx
    mov     dx, es
    add     ax, 6
    mov     word ptr [bp+var_polyinfoptrdata], ax; polyinfoptrdata = polyinfoptr+6
    mov     word ptr [bp+var_polyinfoptrdata+2], dx
    lea     ax, [bp+var_32]
    mov     [bp+var_32ptr], ax
    mov     [bp+var_counter], 0
    jmp     short loc_26049
    ; align 2
    db 144
loc_2602C:
    les     bx, [bp+var_polyinfoptrdata]
    mov     ax, es:[bx]
    mov     dx, es:[bx+2]
    mov     bx, [bp+var_32ptr]
    mov     [bx], ax
    mov     [bx+2], dx
    add     [bp+var_32ptr], 4
    add     word ptr [bp+var_polyinfoptrdata], 4
    inc     [bp+var_counter]
loc_26049:
    mov     ax, [bp+var_maxcount]
    cmp     [bp+var_counter], ax
    jb      short loc_2602C
    mov     bx, [bp+var_mattype]
    shl     bx, 1
    add     bx, material_patlist_ptr_cpy
    mov     ax, [bx]
    or      ax, ax
    jz      short _fill_default; 0 normal 1 grille 2? 3 invisible
    cmp     ax, 1
    jz      short _fill_patterned
    cmp     ax, 2
    jnz     short _do_fill_next
    jmp     _fill_unk
_do_fill_next:
    jmp     short _fill_next
    ; align 2
    db 144
_fill_default:
    lea     ax, [bp+var_32]
    push    ax
    push    [bp+var_maxcount]
    push    [bp+var_matcolor]
    call    preRender_default
_fill_next_eop6:
    add     sp, 6
    jmp     short _fill_next
_fill_patterned:
    mov     bx, [bp+var_mattype]
    shl     bx, 1
    add     bx, material_patlist2_ptr_cpy
    mov     ax, [bx]
    mov     [bp+var_pattype2], ax
    or      ax, ax
    jz      short _fill_next
    lea     ax, [bp+var_32]
    push    ax
    push    [bp+var_maxcount]
    push    [bp+var_matcolor]
    push    [bp+var_pattype2]
    call    preRender_patterned
_fill_next_eop8:
    add     sp, 8
_fill_next:
    inc     si
loc_260AC:
    mov     ax, si
    cmp     ax, polyinfonumpolys
    jb      short loc_260B7
loc_260B4:
    jmp     _get_a_poly_info_done
loc_260B7:
    mov     bx, di          ; di = 400
    shl     bx, 1
    mov     di, word_40ED6[bx]
    mov     bx, di
    shl     bx, 1
    shl     bx, 1
    mov     ax, word ptr polyinfoptrs[bx]
    mov     dx, word ptr (polyinfoptrs+2)[bx]
    mov     word ptr [bp+var_polyinfoptr], ax
    mov     word ptr [bp+var_polyinfoptr+2], dx
    les     bx, [bp+var_polyinfoptr]
    mov     al, es:[bx+2]   ; material type
    sub     ah, ah
    mov     [bp+var_mattype], ax
    mov     bx, ax          ; material index...
    shl     bx, 1
    add     bx, material_clrlist_ptr_cpy
    mov     ax, [bx]
    mov     [bp+var_matcolor], ax
    mov     bx, word ptr [bp+var_polyinfoptr]
    mov     al, es:[bx+4]   ; object type (solid, sphere, wheel, pixel)
    cbw
    or      ax, ax
    jnz     short _fill_nonzero
    jmp     _fill_type0
_fill_nonzero:
    cmp     ax, 1
    jz      short _fill_solid
    cmp     ax, 2
    jnz     short loc_26108
    jmp     _fill_sphere
loc_26108:
    cmp     ax, 3
    jz      short _fill_wheel0
    cmp     ax, 5
    jnz     short _fill_next_jmp
    jmp     _fill_pixel
_fill_next_jmp:
    jmp     short _fill_next
    ; align 2
    db 144
_fill_unk:
    mov     ax, [bp+var_mattype]
    shl     ax, 1
    mov     [bp+var_pattype2], ax
    lea     ax, [bp+var_32]
    push    ax
    push    [bp+var_maxcount]
    push    [bp+var_matcolor]
    mov     bx, [bp+var_pattype2]
    add     bx, material_clrlist2_ptr_cpy
    push    word ptr [bx]
    mov     bx, [bp+var_pattype2]
    add     bx, material_patlist2_ptr_cpy
    push    word ptr [bx]
    call    preRender_unk
    jmp     short _fill_next_eop10
    ; align 2
    db 144
_fill_solid:
    push    [bp+var_matcolor]
    les     bx, [bp+var_polyinfoptr]
    push    word ptr es:[bx+0Ch]
    push    word ptr es:[bx+0Ah]
    push    word ptr es:[bx+8]
    push    word ptr es:[bx+6]
    call    preRender_line
_fill_next_eop10:
    add     sp, 0Ah
    jmp     _fill_next
    ; align 2
    db 144
_fill_wheel0:
    mov     [bp+var_counter], 0
_fill_wheel:
    mov     ax, [bp+var_counter]
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_pattype2], ax
    mov     bx, ax
    add     bx, word ptr [bp+var_polyinfoptr]
    mov     es, word ptr [bp+var_polyinfoptr+2]
    mov     ax, es:[bx+6]
    mov     dx, es:[bx+8]
    mov     bx, [bp+var_pattype2]
    add     bx, bp
    mov     [bx-32h], ax
    mov     [bx-30h], dx
    inc     [bp+var_counter]
    cmp     [bp+var_counter], 4
    jb      short _fill_wheel; b4 every car0 render
    mov     ax, [bp+var_mattype]; material index
    shl     ax, 1
    add     ax, material_clrlist_ptr_cpy
    mov     [bp+var_pattype2], ax
    mov     bx, ax
    push    word ptr [bx+4]
    push    word ptr [bx+2]
    push    [bp+var_matcolor]
    mov     ax, (offset trkObjectList.ss_ssOvelay+460h)
    push    ax
    lea     ax, [bp+var_32]
    push    ax
    call    preRender_wheel
    jmp     short _fill_next_eop10
    ; align 2
    db 144
_fill_sphere:
    push    [bp+var_matcolor]
    les     bx, [bp+var_polyinfoptr]
    push    word ptr es:[bx+0Ah]
    push    word ptr es:[bx+8]
    push    word ptr es:[bx+6]
    call    preRender_sphere
    jmp     _fill_next_eop8
_fill_pixel:
    push    [bp+var_matcolor]
    les     bx, [bp+var_polyinfoptr]
    push    word ptr es:[bx+8]
    push    word ptr es:[bx+6]
    call    putpixel_single_maybe
    jmp     _fill_next_eop6
_get_a_poly_info_done:
    push    cs
    call near ptr polyinfo_reset
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
get_a_poly_info endp
mat_rot_zxy proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_angleZ = word ptr 6
    arg_angleX = word ptr 8
    arg_angleY = word ptr 10
    arg_6 = byte ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    sub     si, si
    test    [bp+arg_angleZ], 3FFh
    jz      short loc_2621C
    mov     si, 4
    push    [bp+arg_angleZ]
    mov     ax, offset mat_z_rot
    push    ax
    call    mat_rot_z
    add     sp, si
loc_2621C:
    test    [bp+arg_angleX], 3FFh
    jz      short loc_26236
smart
    nop
    or      si, 2
nosmart
    push    [bp+arg_angleX]
    mov     ax, offset mat_x_rot
    push    ax
    call    mat_rot_x
    add     sp, 4
loc_26236:
    test    [bp+arg_angleY], 3FFh
    jz      short loc_26285
smart
    nop
    or      si, 1
nosmart
    mov     ax, [bp+arg_angleY]
smart
    and     ah, 3
nosmart
    cmp     ax, mat_y_rot_angle
    jnz     short loc_26252
loc_2624D:
    mov     di, offset mat_y_rot
    jmp     short loc_26285
loc_26252:
    mov     ax, [bp+arg_angleY]
smart
    and     ah, 3
nosmart
    cmp     ax, 100h
    jz      short loc_26282
    cmp     ax, 200h
    jz      short loc_26298
    cmp     ax, 300h
    jz      short loc_2629E
    push    [bp+arg_angleY]
    mov     ax, offset mat_y_rot
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     ax, [bp+arg_angleY]
smart
    and     ah, 3
nosmart
    mov     mat_y_rot_angle, ax
    jmp     short loc_2624D
    ; align 2
    db 144
loc_26282:
    mov     di, offset mat_y100
loc_26285:
    mov     ax, si
    cmp     ax, 7
    jbe     short loc_2628F
    jmp     loc_26372
loc_2628F:
    add     ax, ax
    xchg    ax, bx
    jmp     word ptr cs:rotZXY_offset[bx]
    ; align 2
    db 144
loc_26298:
    mov     di, offset mat_y200
    jmp     short loc_26285
    ; align 2
    db 144
loc_2629E:
    mov     di, offset mat_y300
    jmp     short loc_26285
    ; align 2
    db 144
loc_262A4:
    mov     di, offset mat_y0
    jmp     loc_26372
loc_262AA:
    test    [bp+arg_6], 1
    jz      short loc_262BC
    mov     ax, offset mat_rot_temp
    push    ax
    mov     ax, offset mat_x_rot
loc_262B7:
    push    ax
    push    di
    jmp     short loc_262C5
    ; align 2
    db 144
loc_262BC:
    mov     ax, offset mat_rot_temp
    push    ax
    push    di
loc_262C1:
    mov     ax, offset mat_x_rot
loc_262C4:
    push    ax
loc_262C5:
    call    mat_multiply
    add     sp, 6
    mov     di, offset mat_rot_temp
    jmp     loc_26372
    ; align 2
    db 144
loc_262D4:
    test    [bp+arg_6], 1
    jz      short loc_262E4
    mov     ax, offset mat_rot_temp
    push    ax
    mov     ax, offset mat_z_rot
    jmp     short loc_262B7
    ; align 2
    db 144
loc_262E4:
    mov     ax, offset mat_rot_temp
    push    ax
    push    di
loc_262E9:
    mov     ax, offset mat_z_rot
    jmp     short loc_262C4
loc_262EE:
    test    [bp+arg_6], 1
    jz      short loc_262FE
    mov     ax, offset mat_rot_temp
    push    ax
    mov     ax, offset mat_z_rot
    push    ax
    jmp     short loc_262C1
loc_262FE:
    mov     ax, offset mat_rot_temp
    push    ax
    mov     ax, offset mat_x_rot
    push    ax
    jmp     short loc_262E9
loc_26308:
    test    [bp+arg_6], 1
    jz      short loc_26338
loc_2630E:
    mov     ax, offset mat_rot_temp
    push    ax
    mov     ax, offset mat_x_rot
    push    ax
    push    di
    call    mat_multiply
    add     sp, 6
    mov     ax, offset mat_x_rot
    push    ax
    mov     ax, offset mat_z_rot
    push    ax
    mov     ax, offset mat_rot_temp
    push    ax
    call    mat_multiply
    add     sp, 6
loc_26333:
    mov     di, offset mat_x_rot
    jmp     short loc_26372
loc_26338:
    mov     ax, offset mat_rot_temp
    push    ax
    mov     ax, offset mat_x_rot
    push    ax
    mov     ax, offset mat_z_rot
    push    ax
    call    mat_multiply
    add     sp, 6
    mov     ax, offset mat_z_rot
    push    ax
    push    di
    mov     ax, offset mat_rot_temp
    push    ax
    call    mat_multiply
    add     sp, 6
loc_2635D:
    mov     di, offset mat_z_rot
    jmp     short loc_26372
rotZXY_offset     dw offset loc_262A4
    dw offset loc_26372
    dw offset loc_26333
    dw offset loc_262AA
    dw offset loc_2635D
    dw offset loc_262D4
    dw offset loc_262EE
    dw offset loc_26308
loc_26372:
    mov     ax, di
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
mat_rot_zxy endp
rect_adjust_from_point proc far
    var_6 = word ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_rectptr = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    mov     bx, [bp+arg_0]
    mov     si, [bx]
    mov     di, [bx+2]
    mov     bx, [bp+arg_rectptr]
    cmp     [bx+RECTANGLE.rc_left], si
    jle     short loc_26393
    mov     [bx+RECTANGLE.rc_left], si
loc_26393:
    lea     ax, [si+1]
    mov     [bp+var_6], ax
    mov     bx, [bp+arg_rectptr]
    cmp     [bx+RECTANGLE.rc_right], ax
    jge     short loc_263A4
    mov     [bx+RECTANGLE.rc_right], ax
loc_263A4:
    mov     bx, [bp+arg_rectptr]
    cmp     [bx+RECTANGLE.rc_top], di
    jle     short loc_263AF
    mov     [bx+RECTANGLE.rc_top], di
loc_263AF:
    lea     ax, [di+1]
    mov     [bp+var_6], ax
    mov     bx, [bp+arg_rectptr]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jge     short loc_263C0
    mov     [bx+RECTANGLE.rc_bottom], ax
loc_263C0:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
rect_adjust_from_point endp
vector_op_unk2 proc far
    var_y = dword ptr -14
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_vec = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    di
    push    si
    mov     bx, [bp+arg_vec]
    push    [bx+VECTOR.vy]  ; int
    call    _abs
    add     sp, 2
    cwd
    mov     word ptr [bp+var_y], ax
    mov     word ptr [bp+var_y+2], dx
    mov     bx, [bp+arg_vec]
    push    [bx+VECTOR.vz]  ; int
    call    _abs
    add     sp, 2
    push    ax
    mov     bx, [bp+arg_vec]
    push    [bx+VECTOR.vx]  ; int
    call    _abs
    add     sp, 2
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_4], ax
    mov     [bp+var_2], 0
    mov     ax, word ptr sin80
    mov     dx, word ptr sin80+2
    cmp     word ptr cos80, ax
    jnz     short loc_2643A
    cmp     word ptr cos80+2, dx
    jnz     short loc_2643A
    mov     ax, word ptr [bp+var_y]
    mov     dx, word ptr [bp+var_y+2]
    cmp     [bp+var_2], dx
    jg      short loc_2646E
    jl      short loc_26435
    cmp     [bp+var_4], ax
    jnb     short loc_2646E
loc_26435:
    mov     ax, 1
    jmp     short loc_26470
loc_2643A:
    push    word ptr sin80+2
    push    word ptr sin80
    push    word ptr [bp+var_y+2]
    push    word ptr [bp+var_y]
    call    __aFlmul
    push    word ptr cos80+2
    push    word ptr cos80
    push    [bp+var_2]
    push    [bp+var_4]
    mov     si, ax
    mov     di, dx
    call    __aFlmul
    cmp     dx, di
    jg      short loc_2646E
    jl      short loc_26435
    cmp     ax, si
    jb      short loc_26435
loc_2646E:
    sub     ax, ax
loc_26470:
    mov     [bp+var_8], ax
    mov     bx, [bp+arg_vec]
    cmp     [bx+VECTOR.vy], 0
    jge     short loc_2648A
    or      ax, ax
    jz      short loc_264A0
    mov     ax, 1Eh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_2648A:
    cmp     [bx+VECTOR.vy], 0
    jle     short loc_264A0
    cmp     [bp+var_8], 0
    jz      short loc_264A0
    mov     ax, 1Fh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_264A0:
    cmp     [bx+VECTOR.vy], 0
    jle     short loc_264AC
    mov     [bp+var_A], 0Fh
    jmp     short loc_264B0
loc_264AC:
    mov     [bp+var_A], 0
loc_264B0:
    mov     ax, [bx+VECTOR.vx]
    neg     ax
    push    ax
    push    [bx+VECTOR.vz]
    call    polarAngle
    add     sp, 4
    neg     ax
    mov     [bp+var_6], ax
    or      ax, ax
    jge     short loc_264CD
    add     byte ptr [bp+var_6+1], 4
loc_264CD:
    mov     ax, [bp+var_6]
    cwd
    mov     cx, ax
    mov     bx, dx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    sub     ax, cx
    sbb     dx, bx
    mov     cl, 0Ah
loc_264EB:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_264EB
    add     [bp+var_A], al
    mov     al, [bp+var_A]
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
vector_op_unk2 endp
calc_sincos80 proc far

    mov     ax, 80h
    push    ax
    call    sin_fast
    add     sp, 2
    cwd
    mov     word ptr sin80, ax
    mov     word ptr sin80+2, dx
    mov     ax, 80h
    push    ax
    call    cos_fast
    add     sp, 2
    cwd
    mov     word ptr cos80, ax
    mov     word ptr cos80+2, dx
    mov     ax, 80h
    push    ax
    call    sin_fast
    add     sp, 2
    cwd
    mov     word ptr sin80_2, ax
    mov     word ptr sin80_2+2, dx
    mov     ax, 80h
    push    ax
    call    cos_fast
    add     sp, 2
    cwd
    mov     word ptr cos80_2, ax
    mov     word ptr cos80_2+2, dx
    retf
    ; align 2
    db 144
calc_sincos80 endp
nopsub_26552 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    cmp     [bp+arg_2], 0
    jge     short loc_2656A
    mov     ax, [bp+arg_0]
    mov     dx, [bp+arg_2]
    neg     ax
    adc     dx, 0
    neg     dx
    pop     bp
    retf
loc_2656A:
    mov     ax, [bp+arg_0]
    mov     dx, [bp+arg_2]
    pop     bp
    retf
nopsub_26552 endp
rect_union proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_rectptr1 = word ptr 6
    arg_rectptr2 = word ptr 8
    arg_outrectptr = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    mov     bx, [bp+arg_outrectptr]
    mov     si, [bp+arg_rectptr1]
    mov     ax, [si+RECTANGLE.rc_left]
    mov     si, [bp+arg_rectptr2]
    cmp     ax, [si+RECTANGLE.rc_left]
    jle     short loc_26587
    mov     ax, [si+RECTANGLE.rc_left]
loc_26587:
    mov     [bx+RECTANGLE.rc_left], ax
    mov     bx, [bp+arg_outrectptr]
    mov     si, [bp+arg_rectptr1]
    mov     ax, [si+RECTANGLE.rc_right]
    mov     si, [bp+arg_rectptr2]
    cmp     ax, [si+RECTANGLE.rc_right]
    jge     short loc_2659D
    mov     ax, [si+RECTANGLE.rc_right]
loc_2659D:
    mov     [bx+RECTANGLE.rc_right], ax
    mov     bx, [bp+arg_outrectptr]
    mov     si, [bp+arg_rectptr1]
    mov     ax, [si+RECTANGLE.rc_top]
    mov     si, [bp+arg_rectptr2]
    cmp     ax, [si+RECTANGLE.rc_top]
    jle     short loc_265B4
    mov     ax, [si+RECTANGLE.rc_top]
loc_265B4:
    mov     [bx+RECTANGLE.rc_top], ax
    mov     bx, [bp+arg_outrectptr]
    mov     si, [bp+arg_rectptr1]
    mov     ax, [si+RECTANGLE.rc_bottom]
    mov     si, [bp+arg_rectptr2]
    cmp     ax, [si+RECTANGLE.rc_bottom]
    jge     short loc_265CB
    mov     ax, [si+RECTANGLE.rc_bottom]
loc_265CB:
    mov     [bx+RECTANGLE.rc_bottom], ax
    cmp     video_flag2_is1, 1
    jz      short loc_265E9
    mov     bx, [bp+arg_outrectptr]
    mov     si, bx
    mov     ax, [si+RECTANGLE.rc_right]
    add     ax, video_flag2_is1
    dec     ax
    and     ax, video_flag3_isFFFF
    mov     [bx+RECTANGLE.rc_right], ax
loc_265E9:
    pop     si
    pop     bp
    retf
rect_union endp
rect_intersect proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_rectptr1 = word ptr 6
    arg_rectptr2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    mov     bx, [bp+arg_rectptr1]
    mov     si, bx
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jge     short loc_26602
loc_265FC:
    mov     ax, 1
    pop     si
    pop     bp
    retf
loc_26602:
    mov     bx, [bp+arg_rectptr2]
    mov     si, [bp+arg_rectptr1]
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jle     short loc_265FC
    mov     bx, si
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jle     short loc_265FC
    mov     ax, [si+RECTANGLE.rc_bottom]
    cmp     [bx+RECTANGLE.rc_top], ax
    jge     short loc_265FC
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jle     short loc_265FC
    mov     bx, si
    mov     si, [bx+RECTANGLE.rc_left]
    mov     bx, [bp+arg_rectptr1]
    cmp     [bx+RECTANGLE.rc_left], si
    jge     short loc_26638
    mov     [bx+RECTANGLE.rc_left], si
loc_26638:
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_right]
    cmp     [bx+RECTANGLE.rc_right], ax
    jle     short loc_26649
    mov     [bx+RECTANGLE.rc_right], ax
loc_26649:
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_top], ax
    jge     short loc_2665A
    mov     [bx+RECTANGLE.rc_top], ax
loc_2665A:
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_bottom]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jle     short loc_2666B
    mov     [bx+RECTANGLE.rc_bottom], ax
loc_2666B:
    sub     ax, ax
    pop     si
    pop     bp
    retf
rect_intersect endp
rectlist_add_rect proc far
    var_22 = byte ptr -34
    var_rect2 = RECTANGLE ptr -32
    var_18 = byte ptr -24
    var_rectptr = word ptr -22
    var_counter = byte ptr -20
    var_12 = byte ptr -18
    var_rect = RECTANGLE ptr -16
    var_rect3 = RECTANGLE ptr -8
     s = byte ptr 0
     r = byte ptr 2
    arg_rect_array_length_ptr = word ptr 6
    arg_rect_array_ptr = word ptr 8
    arg_rectptr = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 22h
    push    di
    push    si
    cmp     video_flag2_is1, 1
    jz      short loc_26693
    mov     bx, [bp+arg_rectptr]
    mov     si, bx
    mov     ax, [si+RECTANGLE.rc_right]
    add     ax, video_flag2_is1
    dec     ax
    and     ax, video_flag3_isFFFF
    mov     [bx+RECTANGLE.rc_right], ax
loc_26693:
    mov     [bp+var_counter], 0
    jmp     short loc_266C9
    ; align 2
    db 144
loc_2669A:
    mov     di, si
    mov     cl, 3
    shl     di, cl
    add     di, [bp+arg_rect_array_ptr]
    push    si
    push    di
    lea     si, [di+(size RECTANGLE)]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    inc     [bp+var_12]
loc_266B3:
    mov     al, [bp+var_12]
    cbw
    mov     si, ax
    mov     bx, [bp+arg_rect_array_length_ptr]
    mov     al, [bx]
    cbw
    dec     ax
    cmp     ax, si
    jg      short loc_2669A
    dec     byte ptr [bx]
loc_266C6:
    inc     [bp+var_counter]
loc_266C9:
    mov     bx, [bp+arg_rect_array_length_ptr]
    mov     al, [bp+var_counter]
    cmp     [bx], al
    jg      short loc_266D6
    jmp     loc_26880
loc_266D6:
    cbw
    mov     cl, 3
    shl     ax, cl
    add     ax, [bp+arg_rect_array_ptr]
    mov     [bp+var_rectptr], ax
    push    ax
    push    [bp+arg_rectptr]
    push    cs
    call near ptr rect_is_overlapping
    add     sp, 4
    or      al, al
    jz      short loc_266C6
    push    [bp+var_rectptr]
    push    [bp+arg_rectptr]
    push    cs
    call near ptr rect_is_inside
    add     sp, 4
    or      al, al
    jz      short loc_26704
    jmp     loc_26957
loc_26704:
    push    [bp+arg_rectptr]
    push    [bp+var_rectptr]
    push    cs
    call near ptr rect_is_inside
    add     sp, 4
    or      al, al
    jz      short loc_2671E
    mov     al, [bp+var_counter]
    mov     [bp+var_12], al
    jmp     short loc_266B3
    ; align 2
    db 144
loc_2671E:
    mov     ax, [bp+var_rectptr]
    lea     di, [bp+var_rect]
    mov     si, ax
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     bx, ax
    mov     si, [bp+arg_rectptr]
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_top], ax
    jge     short loc_2675A
    mov     ax, bx
    lea     di, [bp+var_rect2]
    mov     si, ax
    movsw
    movsw
    movsw
    movsw
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     [bp+var_rect2.rc_bottom], ax
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     [bp+var_rect.rc_top], ax
loc_26753:
    mov     [bp+var_18], 1
    jmp     short loc_26784
    ; align 2
    db 144
loc_2675A:
    mov     bx, [bp+arg_rectptr]
    mov     si, [bp+var_rectptr]
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_top], ax
    jge     short loc_26780
    mov     ax, bx
    lea     di, [bp+var_rect2]
    mov     si, ax
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     bx, [bp+var_rectptr]
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     [bp+var_rect2.rc_bottom], ax
    jmp     short loc_26753
loc_26780:
    mov     [bp+var_18], 0
loc_26784:
    mov     bx, [bp+var_rectptr]
    mov     si, [bp+arg_rectptr]
    mov     ax, [si+RECTANGLE.rc_bottom]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jle     short loc_267B4
    mov     ax, bx
    lea     di, [bp+var_rect3]
    mov     si, ax
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    mov     [bp+var_rect3.rc_top], ax
    mov     ax, [bx+RECTANGLE.rc_bottom]
    mov     [bp+var_rect.rc_bottom], ax
loc_267AE:
    mov     [bp+var_22], 1
    jmp     short loc_267DE
loc_267B4:
    mov     bx, [bp+arg_rectptr]
    mov     si, [bp+var_rectptr]
    mov     ax, [si+RECTANGLE.rc_bottom]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jle     short loc_267DA
    mov     ax, bx
    lea     di, [bp+var_rect3]
    mov     si, ax
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     bx, [bp+var_rectptr]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    mov     [bp+var_rect3.rc_top], ax
    jmp     short loc_267AE
loc_267DA:
    mov     [bp+var_22], 0
loc_267DE:
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+RECTANGLE.rc_left]
    mov     bx, [bp+var_rectptr]
    cmp     ax, [bx+RECTANGLE.rc_left]
    jle     short loc_267EC
    mov     ax, [bx+RECTANGLE.rc_left]
loc_267EC:
    mov     [bp+var_rect.rc_left], ax
    mov     bx, [bp+arg_rectptr]
    mov     ax, [bx+RECTANGLE.rc_right]
    mov     bx, [bp+var_rectptr]
    cmp     ax, [bx+RECTANGLE.rc_right]
    jge     short loc_26800
    mov     ax, [bx+RECTANGLE.rc_right]
loc_26800:
    mov     [bp+var_rect.rc_right], ax
    mov     al, [bp+var_counter]
    mov     [bp+var_12], al
    jmp     short loc_26825
    ; align 2
    db 144
loc_2680C:
    mov     di, si
    mov     cl, 3
    shl     di, cl
    add     di, [bp+arg_rect_array_ptr]
    push    si
    push    di
    lea     si, [di+(size RECTANGLE)]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    inc     [bp+var_12]
loc_26825:
    mov     al, [bp+var_12]
    cbw
    mov     si, ax
    mov     bx, [bp+arg_rect_array_length_ptr]
    mov     al, [bx]
    cbw
    dec     ax
    cmp     ax, si
    jg      short loc_2680C
    dec     byte ptr [bx]
    cmp     [bp+var_18], 0
    jz      short loc_2684F
    lea     ax, [bp+var_rect2]
    push    ax
    push    [bp+arg_rect_array_ptr]
    push    [bp+arg_rect_array_length_ptr]
    push    cs
    call near ptr rectlist_add_rect
    add     sp, 6
loc_2684F:
    lea     ax, [bp+var_rect]
    push    ax
    push    [bp+arg_rect_array_ptr]
    push    [bp+arg_rect_array_length_ptr]
    push    cs
    call near ptr rectlist_add_rect
    add     sp, 6
    cmp     [bp+var_22], 0
    jnz     short loc_26869
    jmp     loc_26957
loc_26869:
    lea     ax, [bp+var_rect3]
loc_2686C:
    push    ax
    push    [bp+arg_rect_array_ptr]
    push    [bp+arg_rect_array_length_ptr]
    push    cs
    call near ptr rectlist_add_rect
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_26880:
    mov     [bp+var_counter], 0
    jmp     short loc_268BB
loc_26886:
    mov     di, si
    mov     cl, 3
    shl     di, cl
    add     di, [bp+arg_rect_array_ptr]
    push    si
    push    di
    lea     si, [di+(size RECTANGLE)]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    pop     di
    pop     si
    inc     [bp+var_12]
loc_2689F:
    mov     al, [bp+var_12]
    cbw
    mov     si, ax
    mov     bx, [bp+arg_rect_array_length_ptr]
    mov     al, [bx]
    cbw
    dec     ax
    cmp     ax, si
    jg      short loc_26886
    dec     byte ptr [bx]
    lea     ax, [bp+var_rect]
    jmp     short loc_2686C
    ; align 2
    db 144
loc_268B8:
    inc     [bp+var_counter]
loc_268BB:
    mov     bx, [bp+arg_rect_array_length_ptr]
    mov     al, [bp+var_counter]
    cmp     [bx], al
    jle     short loc_26936
    cbw
    mov     cl, 3
    shl     ax, cl
    add     ax, [bp+arg_rect_array_ptr]
    mov     [bp+var_rectptr], ax
    push    [bp+arg_rectptr]
    push    ax
    push    cs
    call near ptr rect_is_adjacent
    add     sp, 4
    or      al, al
    jz      short loc_268B8
    mov     bx, [bp+var_rectptr]
    mov     ax, [bx+RECTANGLE.rc_left]
    mov     bx, [bp+arg_rectptr]
    cmp     ax, [bx+RECTANGLE.rc_left]
    jle     short loc_268ED
    mov     ax, [bx+RECTANGLE.rc_left]
loc_268ED:
    mov     [bp+var_rect.rc_left], ax
    mov     bx, [bp+var_rectptr]
    mov     ax, [bx+RECTANGLE.rc_right]
    mov     bx, [bp+arg_rectptr]
    cmp     ax, [bx+RECTANGLE.rc_right]
    jge     short loc_26901
    mov     ax, [bx+RECTANGLE.rc_right]
loc_26901:
    mov     [bp+var_rect.rc_right], ax
    mov     bx, [bp+var_rectptr]
    mov     ax, [bx+RECTANGLE.rc_top]
    mov     bx, [bp+arg_rectptr]
    cmp     ax, [bx+RECTANGLE.rc_top]
    jle     short loc_26915
    mov     ax, [bx+RECTANGLE.rc_top]
loc_26915:
    mov     [bp+var_rect.rc_top], ax
    mov     bx, [bp+var_rectptr]
    mov     ax, [bx+RECTANGLE.rc_bottom]
    mov     bx, [bp+arg_rectptr]
    cmp     ax, [bx+RECTANGLE.rc_bottom]
    jge     short loc_26929
    mov     ax, [bx+RECTANGLE.rc_bottom]
loc_26929:
    mov     [bp+var_rect.rc_bottom], ax
    mov     al, [bp+var_counter]
    mov     [bp+var_12], al
    jmp     loc_2689F
    ; align 2
    db 144
loc_26936:
    mov     bx, [bp+arg_rect_array_length_ptr]
    mov     al, [bx]
    cbw
    mov     bx, ax
    mov     cl, 3
    shl     bx, cl
    mov     si, [bp+arg_rect_array_ptr]
    mov     ax, [bp+arg_rectptr]
    lea     di, [bx+si]
    mov     si, ax
    push    ds
    pop     es
    movsw
    movsw
    movsw
    movsw
    mov     bx, [bp+arg_rect_array_length_ptr]
    inc     byte ptr [bx]
loc_26957:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
rectlist_add_rect endp
rect_is_overlapping proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_rectptr1 = word ptr 6
    arg_rectptr2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jg      short loc_26974
loc_2696F:
    sub     ax, ax
    pop     si
    pop     bp
    retf
loc_26974:
    mov     bx, [bp+arg_rectptr2]
    mov     si, [bp+arg_rectptr1]
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jle     short loc_2696F
    mov     bx, si
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_bottom]
loc_26989:
    cmp     [bx+RECTANGLE.rc_top], ax
    jge     short loc_2696F
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jle     short loc_2696F
    mov     ax, 1
    pop     si
    pop     bp
    retf
rect_is_overlapping endp
rect_is_inside proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_rectptr1 = word ptr 6
    arg_rectptr2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_right]
    cmp     [bx+RECTANGLE.rc_right], ax
    jg      short loc_269CA
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_left], ax
    jl      short loc_269CA
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_top], ax
    jl      short loc_269CA
    mov     ax, [si+RECTANGLE.rc_bottom]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jg      short loc_269CA
    mov     ax, 1
    pop     si
    pop     bp
    retf
loc_269CA:
    sub     ax, ax
    pop     si
    pop     bp
    retf
    ; align 2
    db 144
rect_is_inside endp
rect_is_adjacent proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_rectptr1 = word ptr 6
    arg_rectptr2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jnz     short loc_26A02
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_left], ax
    jz      short loc_269EE
loc_269E8:
    sub     ax, ax
    pop     si
    pop     bp
    retf
    ; align 2
    db 144
loc_269EE:
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_right]
    cmp     [bx+RECTANGLE.rc_right], ax
    jnz     short loc_269E8
loc_269FC:
    mov     ax, 1
    pop     si
    pop     bp
    retf
loc_26A02:
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_bottom]
    cmp     [bx+RECTANGLE.rc_top], ax
    jnz     short loc_26A20
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_left], ax
    jnz     short loc_269E8
    mov     ax, [si+RECTANGLE.rc_right]
    cmp     [bx+RECTANGLE.rc_right], ax
loc_26A1C:
    jz      short loc_269FC
    jmp     short loc_269E8
loc_26A20:
    mov     bx, [bp+arg_rectptr1]
    mov     si, [bp+arg_rectptr2]
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jnz     short loc_26A3E
loc_26A2D:
    mov     ax, [si+RECTANGLE.rc_top]
    cmp     [bx+RECTANGLE.rc_top], ax
    jnz     short loc_269E8
    mov     ax, [si+RECTANGLE.rc_bottom]
    cmp     [bx+RECTANGLE.rc_bottom], ax
    jmp     short loc_26A1C
    ; align 2
    db 144
loc_26A3E:
    mov     bx, [bp+arg_rectptr2]
    mov     si, [bp+arg_rectptr1]
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jnz     short loc_269E8
    mov     bx, si
    mov     si, [bp+arg_rectptr2]
    jmp     short loc_26A2D
rect_is_adjacent endp
rectlist_add_rects proc far
    var_rectptr3 = word ptr -28
    var_rectptr = word ptr -26
    var_rectcounter = byte ptr -24
    var_rectarray_index = byte ptr -22
    var_rect = RECTANGLE ptr -20
    var_rect2 = RECTANGLE ptr -12
    var_rectptr2 = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_rectcount = byte ptr 6
    arg_rectarray_indices = word ptr 8
    arg_rectarray1 = word ptr 10
    arg_rectarray2 = word ptr 12
    arg_rectptr = word ptr 14
    arg_rect_array_length_ptr = word ptr 16
    arg_rect_array_ptr = word ptr 18

    push    bp
    mov     bp, sp
    sub     sp, 1Ch
    push    di
    push    si
    mov     [bp+var_rectcounter], 0
    jmp     short loc_26AC0
loc_26A60:
    mov     ax, [bp+var_rectptr]
loc_26A63:
    mov     [bp+var_rectptr2], ax
    mov     [bp+var_2], 1
    jmp     short loc_26A86
loc_26A6C:
    test    [bp+var_rectarray_index], 2
    jz      short loc_26A82
loc_26A72:
    mov     bx, [bp+var_rectptr3]
    mov     si, bx
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jle     short loc_26A82
    mov     ax, bx
    jmp     short loc_26A63
loc_26A82:
    mov     [bp+var_2], 0
loc_26A86:
    cmp     [bp+var_2], 0
    jz      short loc_26ABD
    mov     ax, [bp+var_rectptr2]
    lea     di, [bp+var_rect]
loc_26A92:
    mov     si, ax
    push    ss
    pop     es
    movsw
    movsw
    movsw
    movsw
    push    [bp+arg_rectptr]
    lea     ax, [bp+var_rect]
    push    ax
    push    cs
    call near ptr rect_intersect
loc_26AA5:
    add     sp, 4
    or      al, al
    jnz     short loc_26ABD
loc_26AAC:
    lea     ax, [bp+var_rect]
    push    ax
    push    [bp+arg_rect_array_ptr]
    push    [bp+arg_rect_array_length_ptr]
    push    cs
    call near ptr rectlist_add_rect
    add     sp, 6
loc_26ABD:
    inc     [bp+var_rectcounter]
loc_26AC0:
    mov     al, [bp+arg_rectcount]
    cmp     [bp+var_rectcounter], al
    jnb     short loc_26B44
    mov     al, [bp+var_rectcounter]
    cbw
    mov     si, ax
    mov     bx, [bp+arg_rectarray_indices]
    mov     al, [bx+si]
    mov     [bp+var_rectarray_index], al
    test    [bp+var_rectarray_index], 1
    jz      short loc_26AEA
    mov     ax, [bp+arg_rectarray1]
    mov     dx, si
    mov     cl, 3
    shl     dx, cl
    add     ax, dx
    mov     [bp+var_rectptr], ax
loc_26AEA:
    test    [bp+var_rectarray_index], 2
    jz      short loc_26AFE
    mov     al, [bp+var_rectcounter]
    cbw
    mov     cl, 3
    shl     ax, cl
    add     ax, [bp+arg_rectarray2]
    mov     [bp+var_rectptr3], ax
loc_26AFE:
    test    [bp+var_rectarray_index], 1
    jnz     short loc_26B07
    jmp     loc_26A6C
loc_26B07:
    mov     bx, [bp+var_rectptr]
    mov     si, bx
    mov     ax, [si+RECTANGLE.rc_left]
    cmp     [bx+RECTANGLE.rc_right], ax
    jg      short loc_26B16
    jmp     loc_26A6C
loc_26B16:
    test    [bp+var_rectarray_index], 2
    jnz     short loc_26B1F
    jmp     loc_26A60
loc_26B1F:
    mov     bx, [bp+var_rectptr3]
    mov     si, bx
    mov     ax, [si+RECTANGLE.rc_left]
loc_26B26:
    cmp     [bx+RECTANGLE.rc_right], ax
    jg      short loc_26B2E
    jmp     loc_26A60
loc_26B2E:
    lea     ax, [bp+var_rect2]
    push    ax
    push    bx
    push    [bp+var_rectptr]
    push    cs
    call near ptr rect_union
    add     sp, 6
    lea     ax, [bp+var_rect2]
    jmp     loc_26A63
    ; align 2
    db 144
loc_26B44:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
rectlist_add_rects endp
rect_array_sort_by_top proc far
    var_intbuffer = word ptr -514
     s = byte ptr 0
     r = byte ptr 2
    arg_array_length = byte ptr 6
    arg_rect_array = word ptr 8
    arg_array_indices = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 202h
    push    di
    push    si
loc_26B53:
    cmp     [bp+arg_array_length], 1
    jle     short loc_26BA0
    sub     si, si
    jmp     short loc_26B7C
    ; align 2
    db 144
loc_26B5E:
    mov     di, si
    shl     di, 1
    mov     bx, [bp+arg_rect_array]
    mov     ax, si
    mov     cl, 3
    shl     ax, cl
    add     bx, ax
    mov     ax, [bx+RECTANGLE.rc_top]
    neg     ax
    mov     [bp+di+var_intbuffer], ax
    mov     bx, [bp+arg_array_indices]
    mov     [bx+di], si
    inc     si
loc_26B7C:
    mov     al, [bp+arg_array_length]
    cbw
    cmp     ax, si
    jg      short loc_26B5E
    push    [bp+arg_array_indices]
    lea     ax, [bp+var_intbuffer]
    push    ax
    mov     al, [bp+arg_array_length]
    cbw
    push    ax
    call    heapsort_by_order
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_26BA0:
    mov     bx, [bp+arg_array_indices]
    mov     word ptr [bx], 0
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
rect_array_sort_by_top endp
seg006 ends
end
