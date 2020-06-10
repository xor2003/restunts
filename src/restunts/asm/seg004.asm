.model medium
nosmart
    include structs.inc
    include custom.inc
    include seg000.inc
    include seg001.inc
    include seg002.inc
    include seg003.inc
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
seg004 segment byte public 'STUNTSC' use16
    assume cs:seg004
    assume es:nothing, ss:nothing, ds:dseg
    public build_track_object
    public off_1F87E
    public bto_auxiliary1
    public ported_shape3d_load_all_
    public ported_shape3d_free_all_
    public ported_shape3d_load_car_shapes_
    public ported_shape3d_free_car_shapes_
    public ported_sub_204AE_
    public track_setup
    public off_2147C
    public load_opponent_data
    public subst_hillroad_track
build_track_object proc far
    var_curr_wallptr = dword ptr -64
    var_misc3C = word ptr -60
    var_trkObjList = word ptr -58
    var_wallOrientMod = word ptr -56
    var_36 = word ptr -54
    var_tileTerr = byte ptr -52
    var_absXElemCrds = word ptr -50
    var_absZElemCrds = word ptr -46
    var_posElemCrds = VECTOR ptr -44
    var_physModel = word ptr -36
    var_misc22 = word ptr -34
    var_trkRow = byte ptr -32
    var_misc1E = word ptr -30
    var_misc1C = word ptr -28
    var_trkCol = byte ptr -26
    var_nextPosElemCrds = VECTOR ptr -24
    var_surfaceType = byte ptr -18
    var_elemOrient = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_turnRadius = word ptr -10
    var_tileElem = byte ptr -8
    var_06effX = word ptr -6
    var_02effZ = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_posWorldCrds = word ptr 6
    arg_nextPosWorldCrds = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 40h
    push    di
    push    si
    mov     planindex, 0
    mov     wallindex, 0FFFFh
    mov     wallHeight, 0FFF4h
    mov     elRdWallRelated, 0FC18h; -1000
    mov     corkFlag, 0
    mov     current_surf_type, grass; grass is the default surface
    mov     byte_4392C, 1
    sub     si, si
    mov     [bp+var_wallOrientMod], si
    mov     [bp+var_elemOrient], si
    mov     terrainHeight, si
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx]
    mov     cl, 0Ah
    sar     ax, cl          ; divide by 1024
    mov     [bp+var_trkCol], al
    mov     ax, [bx+4]      ; 2D word vector... world xz coords?
    sar     ax, cl
    mov     [bp+var_trkRow], al
    mov     [bp+var_physModel], 0FFFFh
    cmp     [bp+var_trkCol], 0
    jge     short loc_1E1FD
    jmp     loc_1F8CD
loc_1E1FD:
    cmp     [bp+var_trkCol], 1Dh
    jle     short loc_1E206
    jmp     loc_1F8CD
loc_1E206:
    or      al, al
    jge     short loc_1E20D
    jmp     loc_1F8CD
loc_1E20D:
    cmp     al, 1Dh
    jle     short loc_1E214
    jmp     loc_1F8CD
loc_1E214:
    mov     al, [bp+var_trkCol]
    cbw
    mov     di, ax
    mov     bx, di
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    mov     elem_xCenter, ax
    mov     al, [bp+var_trkRow]
    cbw
    shl     ax, 1
    mov     [bp+var_misc3C], ax
    mov     bx, ax
    mov     ax, terraincenterpos[bx]
    mov     elem_zCenter, ax
    mov     bx, trackrows[bx]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx+di]
    mov     [bp+var_tileTerr], al; terrain tile
    or      al, al
    jz      short loc_1E276
    sub     ah, ah
    cmp     ax, 1
    jnz     short loc_1E257
    jmp     loc_1E2FB
loc_1E257:
    cmp     ax, 2           ; coast
    jz      short loc_1E29A
    cmp     ax, 3
    jz      short loc_1E2A0
    cmp     ax, 4
    jz      short loc_1E2A6
    cmp     ax, 5
    jz      short loc_1E2AC
    cmp     ax, 6
    jnz     short loc_1E276
code_addHillHeight:
    mov     ax, hillHeightConsts+2
    mov     terrainHeight, ax
loc_1E276:
    mov     al, [bp+var_trkRow]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_trkCol]
    cbw
    add     bx, ax
    les     di, td14_elem_map_main
    mov     al, es:[bx+di]
    mov     [bp+var_tileElem], al
    or      al, al
    jnz     short loc_1E304
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1E29A:
    mov     si, 80h ; 'Ä'
    jmp     short loc_1E2AF
    ; align 2
    db 144
loc_1E2A0:
    mov     si, 0FD80h
    jmp     short loc_1E2AF
    ; align 2
    db 144
loc_1E2A6:
    mov     si, 0FE80h
    jmp     short loc_1E2AF
    ; align 2
    db 144
loc_1E2AC:
    mov     si, 0FF80h
loc_1E2AF:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx]
    sub     ax, elem_xCenter
    mov     [bp+var_posElemCrds.vx], ax
    mov     ax, [bx+4]
    sub     ax, elem_zCenter
    mov     [bp+var_posElemCrds.vz], ax
    push    ax
    push    si
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_posElemCrds.vx]
    push    si
    mov     di, ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, di
    mov     [bp+var_misc22], ax
    or      ax, ax
    jl      short loc_1E2FB
    jmp     loc_1E276
loc_1E2FB:
    mov     current_surf_type, water
    jmp     loc_1E276
    ; align 2
    db 144
loc_1E304:
    cmp     [bp+var_tileElem], 0FDh ; '˝'; filler tests
    jnb     short loc_1E30D
    jmp     loc_1E40C
loc_1E30D:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    cmp     ax, 0FDh ; '˝'
    jz      short loc_1E328
loc_1E317:
    cmp     ax, 0FEh ; '˛'
    jz      short loc_1E390
    cmp     ax, 0FFh
    jnz     short loc_1E324
    jmp     loc_1E3CC
loc_1E324:
    jmp     loc_1E464
    ; align 2
    db 144
loc_1E328:
    mov     al, [bp+var_trkRow]
    cbw
    mov     di, ax
    shl     di, 1
    mov     al, [bp+var_trkCol]
    cbw
    mov     bx, ax
    add     bx, (terrainrows+2)[di]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx-1]
    mov     [bp+var_tileElem], al
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jz      short loc_1E365
    mov     ax, (terrainpos+2)[di]
loc_1E362:
    mov     elem_zCenter, ax
loc_1E365:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 2
    jnz     short loc_1E380
    jmp     loc_1E464
loc_1E380:
    mov     al, [bp+var_trkCol]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackpos2[bx]
    jmp     loc_1E461
    ; align 2
    db 144
loc_1E390:
    mov     al, [bp+var_trkRow]
    cbw
    mov     di, ax
    shl     di, 1
    mov     al, [bp+var_trkCol]
    cbw
    mov     bx, ax
    add     bx, (terrainrows+2)[di]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileElem], al
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jz      short loc_1E43D
    mov     ax, (terrainpos+2)[di]
    jmp     short loc_1E43A
    ; align 2
    db 144
loc_1E3CC:
    mov     al, [bp+var_trkRow]
    cbw
    mov     di, ax
    shl     di, 1
    mov     al, [bp+var_trkCol]
    cbw
    mov     bx, ax
    add     bx, terrainrows[di]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx-1]
    mov     [bp+var_tileElem], al
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jnz     short loc_1E405
    jmp     loc_1E365
loc_1E405:
    mov     ax, terrainpos[di]
    jmp     loc_1E362
loc_1E40C:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     al, trkObjectList.ss_multiTileFlag[bx]
    mov     byte ptr [bp+var_misc3C], al
    cmp     al, ah
    jz      short loc_1E464
    test    byte ptr [bp+var_misc3C], 1
    jz      short loc_1E43D
    mov     al, [bp+var_trkRow]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, terrainpos[bx]
loc_1E43A:
    mov     elem_zCenter, ax
loc_1E43D:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 2
    jz      short loc_1E464
    mov     al, [bp+var_trkCol]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, (trackpos2+2)[bx]
loc_1E461:
    mov     elem_xCenter, ax
loc_1E464:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx]
    sub     ax, elem_xCenter
    mov     [bp+var_posElemCrds.vx], ax
    mov     ax, [bx+4]
    sub     ax, elem_zCenter
    mov     [bp+var_posElemCrds.vz], ax
    mov     bx, [bp+arg_nextPosWorldCrds]
    mov     ax, [bx]
    sub     ax, elem_xCenter
    mov     [bp+var_nextPosElemCrds.vx], ax
    mov     ax, [bx+4]
    sub     ax, elem_zCenter
    mov     [bp+var_nextPosElemCrds.vz], ax
    cmp     [bp+var_tileElem], 0
    jz      short loc_1E4B6
    cmp     [bp+var_tileTerr], 7
    jb      short loc_1E4B6
    cmp     [bp+var_tileTerr], 0Bh
    jnb     short loc_1E4B6
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    push    ax
    mov     al, [bp+var_tileTerr]
    push    ax
    push    cs
    call near ptr subst_hillroad_track
    add     sp, 4
    mov     [bp+var_tileElem], al
loc_1E4B6:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, offset trkObjectList
    mov     [bp+var_trkObjList], ax
    mov     bx, ax          ; loading physical model indices!
    mov     al, [bx+TRACKOBJECT.ss_physicalModel]
    cbw
    mov     [bp+var_physModel], ax
    mov     ax, [bx+TRACKOBJECT.ss_rotY]
    mov     [bp+var_elemOrient], ax
    or      ax, ax
    jz      short loc_1E4EF
    cmp     ax, 100h
    jz      short loc_1E562
    cmp     ax, 200h
    jz      short loc_1E540
    cmp     ax, 300h
    jz      short loc_1E516
loc_1E4EF:
    mov     [bp+var_36], 0
    mov     bx, [bp+var_trkObjList]
    mov     al, [bx+TRACKOBJECT.ss_surfaceType]
    inc     al
    mov     [bp+var_surfaceType], al
    cmp     al, 1
    jge     short loc_1E507
    mov     [bp+var_surfaceType], 1
loc_1E507:
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1E58A
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    jmp     short loc_1E58D
    db 144
    db 144
loc_1E516:
    mov     ax, [bp+var_posElemCrds.vx]
    mov     [bp+var_misc1E], ax
    mov     ax, [bp+var_posElemCrds.vz]
    mov     [bp+var_posElemCrds.vx], ax
    mov     ax, [bp+var_misc1E]
    neg     ax
    mov     [bp+var_posElemCrds.vz], ax
    mov     ax, [bp+var_nextPosElemCrds.vx]
    mov     [bp+var_misc1E], ax
    mov     ax, [bp+var_nextPosElemCrds.vz]
    mov     [bp+var_nextPosElemCrds.vx], ax
    mov     ax, [bp+var_misc1E]
    neg     ax
loc_1E53B:
    mov     [bp+var_nextPosElemCrds.vz], ax
    jmp     short loc_1E4EF
loc_1E540:
    mov     ax, [bp+var_posElemCrds.vz]
    neg     ax
    mov     [bp+var_posElemCrds.vz], ax
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    mov     [bp+var_posElemCrds.vx], ax
    mov     ax, [bp+var_nextPosElemCrds.vz]
    neg     ax
    mov     [bp+var_nextPosElemCrds.vz], ax
    mov     ax, [bp+var_nextPosElemCrds.vx]
    neg     ax
    mov     [bp+var_nextPosElemCrds.vx], ax
    jmp     short loc_1E4EF
loc_1E562:
    mov     ax, [bp+var_posElemCrds.vx]
    mov     [bp+var_misc1E], ax
    mov     ax, [bp+var_posElemCrds.vz]
    neg     ax
    mov     [bp+var_posElemCrds.vx], ax
    mov     ax, [bp+var_misc1E]
    mov     [bp+var_posElemCrds.vz], ax
    mov     ax, [bp+var_nextPosElemCrds.vx]
    mov     [bp+var_misc1E], ax
    mov     ax, [bp+var_nextPosElemCrds.vz]
    neg     ax
    mov     [bp+var_nextPosElemCrds.vx], ax
    mov     ax, [bp+var_misc1E]
    jmp     short loc_1E53B
    ; align 2
    db 144
loc_1E58A:
    mov     ax, [bp+var_posElemCrds.vx]
loc_1E58D:
    mov     [bp+var_absXElemCrds], ax
    cmp     [bp+var_posElemCrds.vz], 0
    jge     short loc_1E59E
    mov     ax, [bp+var_posElemCrds.vz]
    neg     ax
    jmp     short loc_1E5A1
    ; align 2
    db 144
loc_1E59E:
    mov     ax, [bp+var_posElemCrds.vz]
loc_1E5A1:
    mov     [bp+var_absZElemCrds], ax
    mov     ax, [bp+var_physModel]
    cmp     ax, 4Ah ; 'J'
    jbe     short code_bto_root
    jmp     code_bto_blank
code_bto_root:
    add     ax, ax
    xchg    ax, bx
    jmp     word ptr cs:bto_branches[bx]
    ; align 2
    db 144
code_bto_sfLine:
    cmp     state.game_inputmode, 0
    jnz     short code_bto_road
    cmp     [bp+var_posElemCrds.vx], 0
    jle     short code_bto_road
    cmp     [bp+var_posElemCrds.vz], 0FE84h
    jge     short loc_1E5D4
    mov     planindex, 83h ; 'É'
    jmp     short code_bto_road
loc_1E5D4:
    cmp     [bp+var_posElemCrds.vz], 0FED4h
    jge     short code_bto_road
    mov     planindex, 84h ; 'Ñ'
code_bto_road:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
loc_1E5E5:
    jl      short code_set_pavement
    jmp     code_bto_blank
code_set_pavement:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_crossroad:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jl      short code_set_pavement
    cmp     [bp+var_absZElemCrds], 78h ; 'x'
    jmp     short loc_1E5E5
code_bto_chicaneLR:
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    mov     [bp+var_posElemCrds.vx], ax
code_bto_chicaneRL:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    cmp     [bp+var_posElemCrds.vx], 0
    jle     short code_bto_lCorner
    mov     ax, [bp+var_posElemCrds.vz]
    neg     ax
    mov     [bp+var_posElemCrds.vz], ax
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    mov     [bp+var_posElemCrds.vx], ax
code_bto_lCorner:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 4
    push    ax
    mov     ax, [bp+var_posElemCrds.vx]
    add     ah, 4
code_lCorner_radius:
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_turnRadius], ax
    cmp     ax, 588h
    jg      short loc_1E645
    jmp     code_bto_blank
loc_1E645:
    cmp     ax, 678h
    jmp     short loc_1E5E5
code_bto_sSplitA:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jl      short code_set_pavement
code_bto_sCorner:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 2
    push    ax
    mov     ax, [bp+var_posElemCrds.vx]
    add     ah, 2
code_sCorner_radius:
    push    ax
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_turnRadius], ax
    cmp     ax, 188h
    jg      short loc_1E671
    jmp     code_bto_blank
loc_1E671:
    cmp     ax, 278h
    jmp     loc_1E5E5
    ; align 2
    db 144
code_bto_sSplitB:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jge     short loc_1E681
    jmp     code_set_pavement
loc_1E681:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 2
    push    ax
    mov     ax, 200h
    sub     ax, [bp+var_posElemCrds.vx]
    jmp     short code_sCorner_radius
code_bto_lSplitA:
    cmp     [bp+var_posElemCrds.vx], 188h
    jl      short code_bto_lCorner
    cmp     [bp+var_posElemCrds.vx], 278h
    jg      short loc_1E6A1
    jmp     code_set_pavement
loc_1E6A1:
    jmp     short code_bto_lCorner
    ; align 2
    db 144
code_bto_lSplitB:
    cmp     [bp+var_posElemCrds.vx], 0FD88h
    jl      short loc_1E6B5
    cmp     [bp+var_posElemCrds.vx], 0FE78h
    jg      short loc_1E6B5
    jmp     code_set_pavement
loc_1E6B5:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 4
    push    ax
    mov     ax, 400h
    sub     ax, [bp+var_posElemCrds.vx]
    jmp     code_lCorner_radius
    ; align 2
    db 144
code_bto_highEntrance:
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1E6D4
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    jmp     short loc_1E6D7
    ; align 2
    db 144
loc_1E6D4:
    mov     ax, [bp+var_posElemCrds.vx]
loc_1E6D7:
    mov     [bp+var_misc1C], ax
    sub     si, si
    jmp     short loc_1E6DF
loc_1E6DE:
    inc     si
loc_1E6DF:
    mov     bx, si
    shl     bx, 1
    mov     ax, [bp+var_posElemCrds.vz]
    cmp     highEntrZBounds1[bx], ax
    jl      short loc_1E6DE
    mov     di, si
    shl     di, 1
    mov     ax, highEntrXInnBounds0[di]
    cmp     highEntrXInnBounds1[di], ax
    jz      short loc_1E72E
    mov     di, si
    shl     di, 1
    mov     ax, highEntrZBounds1[di]
    sub     ax, highEntrZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_posElemCrds.vz]
    sub     ax, highEntrZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, highEntrXInnBounds1[di]
    sub     ax, highEntrXInnBounds0[di]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    add     ax, highEntrXInnBounds0[di]
loc_1E72E:
    mov     [bp+var_misc1E], ax
    mov     di, si
    shl     di, 1
    mov     ax, highEntrXOutBounds0[di]
    cmp     highEntrXOutBounds1[di], ax
    jz      short loc_1E773
    mov     di, si
    shl     di, 1
    mov     ax, highEntrZBounds1[di]
    sub     ax, highEntrZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_posElemCrds.vz]
    sub     ax, highEntrZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, highEntrXOutBounds1[di]
    sub     ax, highEntrXOutBounds0[di]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    add     ax, highEntrXOutBounds0[di]
loc_1E773:
    mov     [bp+var_misc22], ax
    mov     ax, [bp+var_misc1E]
    cmp     [bp+var_misc1C], ax
    jle     short loc_1E789
    mov     ax, [bp+var_misc22]
    cmp     [bp+var_misc1C], ax
    jge     short loc_1E789
    jmp     code_set_pavement
loc_1E789:
    cmp     [bp+var_posElemCrds.vz], 0
    jge     short loc_1E792
    jmp     code_bto_blank
loc_1E792:
    cmp     [bp+var_misc1C], 78h ; 'x'
    jle     short loc_1E79B
    jmp     code_bto_blank
loc_1E79B:
    mov     planindex, 1
loc_1E7A1:
    cmp     [bp+var_posElemCrds.vz], 14Eh
    jl      short loc_1E7C0
    cmp     [bp+var_nextPosElemCrds.vx], 0FF88h
    jle     short loc_1E7F9
loc_1E7AE:
    cmp     [bp+var_nextPosElemCrds.vx], 78h ; 'x'
    jge     short loc_1E7B7
    jmp     code_bto_blank
loc_1E7B7:
    mov     wallindex, 0BAh ; '∫'
    jmp     code_bto_blank
loc_1E7C0:
    cmp     [bp+var_nextPosElemCrds.vx], 0
    jl      short loc_1E7D0
    mov     wallindex, 0BBh ; 'ª'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1E7D0:
    mov     wallindex, 0BDh ; 'Ω'
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_highway:
    cmp     [bp+var_absXElemCrds], 168h
    jle     short loc_1E7E4
    jmp     code_bto_blank
loc_1E7E4:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jle     short loc_1E7ED
    jmp     code_set_pavement
loc_1E7ED:
    mov     planindex, 1
    cmp     [bp+var_nextPosElemCrds.vx], 0FF88h
    jg      short loc_1E7AE
loc_1E7F9:
    mov     wallindex, 0BCh ; 'º'
    jmp     code_bto_blank
code_bto_ramp:
    cmp     [bp+var_posElemCrds.vz], 0
    jle     short loc_1E810
    mov     byte_4392C, 0
    jmp     short loc_1E82B
    ; align 2
    db 144
loc_1E810:
    cmp     [bp+var_nextPosElemCrds.vz], 0
    jl      short loc_1E82B
    mov     wallindex, 66h ; 'f'
    jmp     short loc_1E82B
code_bto_solidRamp:
    cmp     [bp+var_nextPosElemCrds.vz], 1DCh
    jl      short loc_1E82B
    mov     wallindex, 67h ; 'g'
loc_1E82B:
    cmp     [bp+var_nextPosElemCrds.vx], 0
    jge     short loc_1E838
    mov     ax, [bp+var_nextPosElemCrds.vx]
loc_1E834:
    neg     ax
    jmp     short loc_1E83B
loc_1E838:
    mov     ax, [bp+var_nextPosElemCrds.vx]
loc_1E83B:
    cmp     ax, 78h ; 'x'
    jge     short loc_1E886
    mov     planindex, 3
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    cmp     wallindex, 0FFFFh
    jz      short loc_1E856
    jmp     code_bto_blank
loc_1E856:
    cmp     [bp+var_posElemCrds.vz], 0
    jge     short loc_1E85F
    jmp     code_bto_blank
loc_1E85F:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jge     short loc_1E868
    jmp     code_bto_blank
loc_1E868:
    mov     wallHeight, 2Ah ; '*'
    mov     elRdWallRelated, 0FFF4h
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1E87D
    jmp     loc_1E96F
loc_1E87D:
    mov     wallindex, 65h ; 'e'
    jmp     code_bto_blank
loc_1E886:
    cmp     byte_4392C, 0
    jnz     short loc_1E890
    jmp     code_bto_blank
loc_1E890:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jle     short loc_1E899
    jmp     code_bto_blank
loc_1E899:
    mov     planindex, 3
    cmp     wallindex, 0FFFFh
    jz      short loc_1E8A9
    jmp     code_bto_blank
loc_1E8A9:
    mov     [bp+var_wallOrientMod], 200h
loc_1E8AE:
    cmp     [bp+var_posElemCrds.vx], 0
    jmp     loc_1E96A
    ; align 2
    db 144
code_bto_overpass:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 186h
    jle     short loc_1E8D8
loc_1E8C5:
    mov     byte_4392C, 0
code_bto_solidRoad:
    cmp     [bp+var_nextPosElemCrds.vx], 0
    jge     short loc_1E8F8
    mov     ax, [bp+var_nextPosElemCrds.vx]
    neg     ax
    jmp     short loc_1E8FB
    ; align 2
    db 144
loc_1E8D8:
    cmp     [bp+var_absZElemCrds], 78h ; 'x'
loc_1E8DC:
    jle     short loc_1E8E1
    jmp     code_bto_blank
loc_1E8E1:
    jmp     code_set_pavement
code_bto_elevRoad:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 186h
    jg      short loc_1E8F6
    jmp     code_bto_blank
loc_1E8F6:
    jmp     short loc_1E8C5
loc_1E8F8:
    mov     ax, [bp+var_nextPosElemCrds.vx]
loc_1E8FB:
    cmp     ax, 78h ; 'x'
    jg      short loc_1E942
    mov     planindex, 2
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    cmp     byte_4392C, 0
    jz      short loc_1E92F
    cmp     [bp+var_nextPosElemCrds.vz], 1DCh
    jl      short loc_1E922
    mov     wallindex, 67h ; 'g'
    jmp     short loc_1E92F
loc_1E922:
    cmp     [bp+var_nextPosElemCrds.vz], 0FE24h
    jg      short loc_1E92F
    mov     wallindex, 68h ; 'h'
loc_1E92F:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jge     short loc_1E938
    jmp     code_bto_blank
loc_1E938:
    mov     wallHeight, 2Ah ; '*'
    jmp     loc_1E8AE
    ; align 2
    db 144
loc_1E942:
    cmp     byte_4392C, 0
    jnz     short loc_1E94C
    jmp     code_bto_blank
loc_1E94C:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jle     short loc_1E955
    jmp     code_bto_blank
loc_1E955:
    mov     planindex, 2
    mov     wallHeight, 2Ah ; '*'
    mov     [bp+var_wallOrientMod], 200h
    cmp     [bp+var_nextPosElemCrds.vx], 0
loc_1E96A:
    jl      short loc_1E96F
    jmp     loc_1E87D
loc_1E96F:
    mov     wallindex, 64h ; 'd'
    jmp     code_bto_blank
code_bto_elevCorner:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 186h
    jg      short loc_1E98A
    jmp     code_bto_blank
loc_1E98A:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 4
    push    ax
    mov     ax, [bp+var_posElemCrds.vx]
    add     ah, 4
    push    ax
    call    polarRadius2D
    add     sp, 4
    sub     ax, 600h
    mov     [bp+var_turnRadius], ax
    cmp     ax, 0FF6Ah
    jg      short loc_1E9AE
    jmp     code_bto_blank
loc_1E9AE:
    cmp     ax, 96h ; 'ñ'
    jl      short loc_1E9B6
    jmp     code_bto_blank
loc_1E9B6:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    mov     planindex, 2
    mov     byte_4392C, 0
    cmp     [bp+var_turnRadius], 0FF94h
    jl      short loc_1E9D6
    cmp     [bp+var_turnRadius], 6Ch ; 'l'
    jg      short loc_1E9D6
    jmp     code_bto_blank
loc_1E9D6:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 4
    push    ax
    mov     ax, [bp+var_posElemCrds.vx]
    add     ah, 4
    push    ax
    call    polarAngle
    add     sp, 4
    sub     ah, ah
    mov     cx, 12h
    imul    cx
    mov     [bp+var_misc22], ax
    mov     cl, 8
    sar     ax, cl
    sub     ax, 11h
    neg     ax
    mov     [bp+var_misc1E], ax
    mov     wallHeight, 2Ah ; '*'
    mov     elRdWallRelated, 0FFF4h
    cmp     [bp+var_turnRadius], 0
    jge     short loc_1EA1A
    add     ax, 69h ; 'i'
    jmp     short loc_1EA20
    ; align 2
    db 144
loc_1EA1A:
    mov     ax, [bp+var_misc1E]
    add     ax, 7Bh ; '{'
loc_1EA20:
    mov     wallindex, ax
    jmp     code_bto_blank
code_bto_bankEntranceA:
    mov     [bp+var_misc1C], 23h ; '#'
    mov     [bp+var_misc1E], 0
    mov     si, 0FD60h
    jmp     short loc_1EA43
    ; align 2
    db 144
code_bto_bankEntranceB:
    mov     [bp+var_misc1C], 19h
    mov     [bp+var_misc1E], 1
    mov     si, 0A0h ; '†'
loc_1EA43:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jle     short loc_1EA4C
    jmp     code_bto_blank
loc_1EA4C:
    cmp     [bp+var_misc1E], 0
    jnz     short loc_1EA66
    cmp     [bp+var_nextPosElemCrds.vx], 0FF88h
    jg      short loc_1EA66
    mov     [bp+var_wallOrientMod], 200h
    mov     wallindex, 64h ; 'd'
    jmp     short loc_1EA7D
    ; align 2
    db 144
loc_1EA66:
    cmp     [bp+var_misc1E], 0
    jz      short loc_1EA7D
    cmp     [bp+var_nextPosElemCrds.vx], 78h ; 'x'
    jl      short loc_1EA7D
    mov     [bp+var_wallOrientMod], 200h
    mov     wallindex, 65h ; 'e'
loc_1EA7D:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    cmp     [bp+var_posElemCrds.vz], 0FEB2h
    jge     short loc_1EA90
    mov     ax, [bp+var_misc1C]
    jmp     short loc_1EA9D
    ; align 2
    db 144
loc_1EA90:
    cmp     [bp+var_posElemCrds.vz], 14Eh
    jl      short loc_1EAA4
    mov     ax, [bp+var_misc1C]
    add     ax, 9
loc_1EA9D:
    mov     planindex, ax
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1EAA4:
    cmp     [bp+var_posElemCrds.vz], 0FF58h
    jge     short loc_1EABA
    mov     ax, [bp+var_misc1C]
    inc     ax
    mov     planindex, ax
    mov     [bp+var_misc1E], 0
    jmp     short loc_1EAFD
    ; align 2
    db 144
loc_1EABA:
    cmp     [bp+var_posElemCrds.vz], 0
    jge     short loc_1EAD0
    mov     ax, [bp+var_misc1C]
    add     ax, 3
    mov     planindex, ax
    mov     [bp+var_misc1E], 1
    jmp     short loc_1EAFD
loc_1EAD0:
    cmp     [bp+var_posElemCrds.vz], 0A8h ; '®'
    jge     short loc_1EAE8
    mov     ax, [bp+var_misc1C]
    add     ax, 5
    mov     planindex, ax
    mov     [bp+var_misc1E], 2
    jmp     short loc_1EAFD
    ; align 2
    db 144
loc_1EAE8:
    cmp     [bp+var_posElemCrds.vz], 14Eh
    jge     short loc_1EAFD
    mov     ax, [bp+var_misc1C]
    add     ax, 7
    mov     planindex, ax
    mov     [bp+var_misc1E], 3
loc_1EAFD:
    mov     ax, [bp+var_posElemCrds.vz]
    mov     bx, [bp+var_misc1E]
    shl     bx, 1
    sub     ax, bkRdEntr_triang_zAdjust[bx]
    push    ax
    push    si
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_posElemCrds.vx]
    push    si
    mov     di, ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, di
    mov     [bp+var_misc22], ax
    or      ax, ax
    jg      short loc_1EB3F
    jmp     code_bto_blank
loc_1EB3F:
    inc     planindex
    jmp     code_bto_blank
code_bto_bankRoad:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jle     short loc_1EB4F
    jmp     code_bto_blank
loc_1EB4F:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    mov     planindex, 6
    cmp     [bp+var_nextPosElemCrds.vx], 78h ; 'x'
    jge     short loc_1EB64
    jmp     code_bto_blank
loc_1EB64:
    mov     [bp+var_wallOrientMod], 200h
    jmp     loc_1E87D
code_bto_bankCorner:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 4
    push    ax
    mov     ax, [bp+var_posElemCrds.vx]
    add     ah, 4
    push    ax
    call    polarRadius2D
    add     sp, 4
    sub     ax, 600h
    mov     [bp+var_turnRadius], ax
    cmp     ax, 0FF88h
    jg      short loc_1EB90
    jmp     code_bto_blank
loc_1EB90:
    cmp     ax, 7Eh ; '~'
    jl      short loc_1EB98
    jmp     code_bto_blank
loc_1EB98:
    mov     ax, [bp+var_posElemCrds.vz]
    add     ah, 4
    push    ax
    mov     ax, [bp+var_posElemCrds.vx]
    add     ah, 4
    push    ax
    call    polarAngle
    add     sp, 4
    sub     ah, ah
    mov     cx, 12h
    imul    cx
    mov     [bp+var_misc22], ax
    mov     cl, 8
    sar     ax, cl
    sub     ax, 11h
    neg     ax
    mov     [bp+var_misc1E], ax
    add     ax, 7
    mov     planindex, ax
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    cmp     [bp+var_turnRadius], 66h ; 'f'
    jg      short loc_1EBD9
    jmp     code_bto_blank
loc_1EBD9:
    mov     [bp+var_wallOrientMod], 200h
    mov     ax, [bp+var_misc1E]
    add     ax, 7Bh ; '{'
    mov     wallindex, ax
loc_1EBE7:
    mov     byte_4392C, 0
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_loop:
    cmp     [bp+var_posElemCrds.vz], 0
    jge     short loc_1EC0A
    mov     [bp+var_misc1C], 33h ; '3'
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    mov     [bp+var_06effX], ax
    mov     ax, [bp+var_posElemCrds.vz]
    neg     ax
    jmp     short loc_1EC18
loc_1EC0A:
    mov     [bp+var_misc1C], 2Dh ; '-'
    mov     ax, [bp+var_posElemCrds.vx]
    mov     [bp+var_06effX], ax
    mov     ax, [bp+var_posElemCrds.vz]
loc_1EC18:
    mov     [bp+var_02effZ], ax
    mov     ax, loopSurface_maxZ
    dec     ax
    cmp     [bp+var_02effZ], ax
    jle     short loc_1EC38
    mov     ax, loopSurface_maxZ
    add     ax, 64h ; 'd'
    cmp     [bp+var_02effZ], ax
    jle     short loc_1EC32
    jmp     code_bto_loopBase
loc_1EC32:
    mov     ax, loopSurface_maxZ
    dec     ax
    jmp     short loc_1EC3B
loc_1EC38:
    mov     ax, [bp+var_02effZ]
loc_1EC3B:
    mov     [bp+var_misc1E], ax
    sub     si, si
    jmp     short loc_1EC43
loc_1EC42:
    inc     si
loc_1EC43:
    mov     bx, si
    shl     bx, 1
    mov     ax, [bp+var_misc1E]
    cmp     loopSurface_ZBounds1[bx], ax
    jl      short loc_1EC42
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 20Ch        ; upside-down limit
    jg      short loc_1EC62
    jmp     loc_1ED04
loc_1EC62:
    mov     ax, 5
    sub     ax, si
    mov     si, ax
    mov     di, si
    shl     di, 1
    mov     ax, [bp+var_06effX]
    cmp     loopSurface_XBounds0[di], ax
    jle     short loc_1EC79
    jmp     code_bto_blank
loc_1EC79:
    mov     ax, loopSurface_XBounds1[di]
    add     ax, 190h
    cmp     ax, [bp+var_06effX]
    jge     short loc_1EC88
    jmp     code_bto_blank
loc_1EC88:
    mov     ax, [bp+var_06effX]
    cmp     loopSurface_XBounds1[di], ax
    jge     short loc_1EC9D
    mov     ax, loopSurface_XBounds0[di]
    add     ax, 190h
    cmp     ax, [bp+var_06effX]
    jg      short loc_1ECF3
loc_1EC9D:
    mov     di, si
    shl     di, 1
    mov     ax, loopSurface_ZBounds1[di]
    sub     ax, loopSurface_ZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, loopSurface_ZBounds0[di]
    sub     ax, [bp+var_misc1E]
    cwd
    push    dx
    push    ax
    mov     ax, loopSurface_XBounds0[di]
    sub     ax, loopSurface_XBounds1[di]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+var_misc22], ax
    mov     ax, loopSurface_XBounds0[di]
    add     ax, [bp+var_misc22]
    mov     [bp+var_misc3C], ax
    mov     ax, [bp+var_06effX]
    cmp     [bp+var_misc3C], ax
    jl      short loc_1ECE5
    jmp     code_bto_blank
loc_1ECE5:
    mov     ax, [bp+var_misc3C]
    add     ax, 190h
    cmp     ax, [bp+var_06effX]
    jg      short loc_1ECF3
    jmp     code_bto_blank
loc_1ECF3:
    mov     ax, [bp+var_misc1C]
    add     ax, si
    mov     planindex, ax
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    jmp     loc_1EBE7
loc_1ED04:
    cmp     si, 1
    jle     short loc_1ED1B
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 64h ; 'd'
    jge     short loc_1ED1B
    jmp     code_bto_loopBase
loc_1ED1B:
    mov     di, si
    shl     di, 1
    mov     ax, [bp+var_06effX]
    cmp     loopSurface_XBounds0[di], ax
    jle     short loc_1ED2B
    jmp     code_bto_loopBase
loc_1ED2B:
    mov     ax, loopSurface_XBounds1[di]
    add     ax, 190h
    cmp     ax, [bp+var_06effX]
    jl      short code_bto_loopBase
    mov     ax, [bp+var_06effX]
    cmp     loopSurface_XBounds1[di], ax
    jge     short loc_1ED4C
    mov     ax, loopSurface_XBounds0[di]
    add     ax, 190h
    cmp     ax, [bp+var_06effX]
    jg      short loc_1ECF3
loc_1ED4C:
    mov     di, si
    shl     di, 1
    mov     ax, loopSurface_XBounds0[di]
    cmp     loopSurface_XBounds1[di], ax
    jz      short code_bto_loopBase
    mov     di, si
    shl     di, 1
    mov     ax, loopSurface_ZBounds1[di]
    sub     ax, loopSurface_ZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, loopSurface_ZBounds0[di]
    sub     ax, [bp+var_misc1E]
    cwd
    push    dx
    push    ax
    mov     ax, loopSurface_XBounds0[di]
    sub     ax, loopSurface_XBounds1[di]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+var_misc22], ax
    mov     ax, loopSurface_XBounds0[di]
    add     ax, [bp+var_misc22]
    mov     [bp+var_misc3C], ax
    mov     ax, [bp+var_06effX]
    cmp     [bp+var_misc3C], ax
    jge     short code_bto_loopBase
    mov     ax, [bp+var_misc3C]
    add     ax, 190h
    cmp     ax, [bp+var_06effX]
    jle     short code_bto_loopBase
    jmp     loc_1ECF3
code_bto_loopBase:
    sub     si, si
    jmp     short loc_1EDB3
    ; align 2
    db 144
loc_1EDB2:
    inc     si
loc_1EDB3:
    mov     bx, si
    shl     bx, 1
    mov     ax, [bp+var_02effZ]
    cmp     loopBase_ZBounds1[bx], ax
    jl      short loc_1EDB2
    mov     di, si
    shl     di, 1
    mov     ax, loopBase_ZBounds1[di]
    sub     ax, loopBase_ZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_02effZ]
    sub     ax, loopBase_ZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, loopBase_InnXBounds1[di]
    sub     ax, loopBae_InnXBounds0[di]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    add     ax, loopBae_InnXBounds0[di]
    mov     [bp+var_misc1E], ax
    mov     ax, loopBase_ZBounds1[di]
    sub     ax, loopBase_ZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_02effZ]
    sub     ax, loopBase_ZBounds0[di]
    cwd
    push    dx
    push    ax
    mov     ax, loopBase_OutXBounds1[di]
    sub     ax, loopBase_OutXBounds0[di]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    add     ax, loopBase_OutXBounds0[di]
    mov     [bp+var_misc22], ax
    mov     ax, [bp+var_misc1E]
    cmp     [bp+var_06effX], ax
    jge     short loc_1EE35
    jmp     code_bto_blank
loc_1EE35:
    mov     ax, [bp+var_misc22]
    cmp     [bp+var_06effX], ax
    jmp     loc_1E8DC
code_bto_tunnel:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 90h ; 'ê'
    jge     short loc_1EE5C
    mov     bx, [bp+arg_nextPosWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 90h ; 'ê'
    jl      short loc_1EE76
loc_1EE5C:
    cmp     [bp+var_absXElemCrds], 10Eh
    jl      short loc_1EE66
    jmp     code_bto_blank
loc_1EE66:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    mov     planindex, 85h ; 'Ö'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1EE76:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jge     short loc_1EE82
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
loc_1EE82:
    cmp     [bp+var_posElemCrds.vx], 78h ; 'x'
    jl      short loc_1EEC6
    cmp     [bp+var_posElemCrds.vx], 10Eh
    jg      short loc_1EEC6
    mov     wallHeight, 90h ; 'ê'
    cmp     [bp+var_nextPosElemCrds.vz], 0FE00h
    jle     short loc_1EEE6
    cmp     [bp+var_nextPosElemCrds.vz], 200h
    jge     short loc_1EEF7
    cmp     [bp+var_nextPosElemCrds.vx], 78h ; 'x'
    jg      short loc_1EEB2
    mov     wallindex, 98h ; 'ò'
    jmp     code_bto_blank
loc_1EEB2:
    cmp     [bp+var_nextPosElemCrds.vx], 10Eh
    jge     short loc_1EEBC
    jmp     code_bto_blank
loc_1EEBC:
    mov     wallindex, 96h ; 'ñ'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1EEC6:
    cmp     [bp+var_posElemCrds.vx], 0FF88h
    jle     short loc_1EECF
    jmp     code_bto_blank
loc_1EECF:
    cmp     [bp+var_posElemCrds.vx], 0FEF2h
    jge     short loc_1EED9
    jmp     code_bto_blank
loc_1EED9:
    mov     wallHeight, 90h ; 'ê'
    cmp     [bp+var_nextPosElemCrds.vz], 0FE00h
    jg      short loc_1EEF0
loc_1EEE6:
    mov     wallindex, 9Ah ; 'ö'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1EEF0:
    cmp     [bp+var_nextPosElemCrds.vz], 200h
    jl      short loc_1EF00
loc_1EEF7:
    mov     wallindex, 99h ; 'ô'
    jmp     code_bto_blank
loc_1EF00:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF88h
    jl      short loc_1EF10
    mov     wallindex, 97h ; 'ó'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1EF10:
    cmp     [bp+var_nextPosElemCrds.vx], 0FEF2h
    jle     short loc_1EF1A
    jmp     code_bto_blank
loc_1EF1A:
    mov     wallindex, 95h ; 'ï'
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_pipeEntrance:
    cmp     [bp+var_nextPosElemCrds.vx], 0
    jge     short loc_1EF32
    mov     ax, [bp+var_nextPosElemCrds.vx]
    neg     ax
    jmp     short loc_1EF35
    ; align 2
    db 144
loc_1EF32:
    mov     ax, [bp+var_nextPosElemCrds.vx]
loc_1EF35:
    cmp     ax, 73h ; 's'
    jl      short loc_1EF60
    cmp     [bp+var_absXElemCrds], 0A4h ; '§'
    jg      short loc_1EF60
    mov     wallHeight, 97h ; 'ó'
    cmp     [bp+var_nextPosElemCrds.vx], 0
    jle     short loc_1EF56
    mov     wallindex, 9Fh ; 'ü'
    jmp     code_bto_blank
loc_1EF56:
    mov     wallindex, 0A0h ; '†'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1EF60:
    cmp     [bp+var_absXElemCrds], 73h ; 's'
    jl      short loc_1EF69
    jmp     code_bto_blank
loc_1EF69:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 0ABh ; '´'
    jl      short loc_1EF7B
    jmp     code_bto_blank
loc_1EF7B:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    cmp     [bp+var_absXElemCrds], 1Fh
    jge     short loc_1EF90
    mov     planindex, 46h ; 'F'
    jmp     code_bto_blank
loc_1EF90:
    cmp     [bp+var_posElemCrds.vx], 0FFACh
    jge     short loc_1EFA6
    mov     planindex, 49h ; 'I'
    mov     [bp+var_misc1E], 0FF9Ch
    mov     si, 0FFFBh
    jmp     short loc_1EFE0
loc_1EFA6:
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1EFBC
    mov     planindex, 47h ; 'G'
    mov     [bp+var_misc1E], 0FFC7h
    mov     si, 0FFF8h
    jmp     short loc_1EFE0
loc_1EFBC:
    cmp     [bp+var_posElemCrds.vx], 54h ; 'T'
    jle     short loc_1EFD2
    mov     planindex, 4Dh ; 'M'
    mov     [bp+var_misc1E], 64h ; 'd'
    mov     si, 5
    jmp     short loc_1EFE0
loc_1EFD2:
    mov     planindex, 4Bh ; 'K'
    mov     [bp+var_misc1E], 39h ; '9'
    mov     si, 8
loc_1EFE0:
    push    [bp+var_posElemCrds.vz]
    push    si
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, [bp+var_posElemCrds.vx]
    sub     cx, [bp+var_misc1E]
    push    cx
    push    si
    mov     di, ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, di
    mov     [bp+var_misc22], ax
    or      ax, ax
    jl      short loc_1F01C
    jmp     code_bto_blank
loc_1F01C:
    jmp     loc_1EB3F
    ; align 2
    db 144
code_bto_halfPipe:
    mov     [bp+var_misc22], 1
    jmp     short loc_1F02D
    ; align 2
    db 144
code_bto_pipe:
    mov     [bp+var_misc22], 0
loc_1F02D:
    cmp     [bp+var_nextPosElemCrds.vx], 0
    jge     short loc_1F03A
    mov     ax, [bp+var_nextPosElemCrds.vx]
    neg     ax
    jmp     short loc_1F03D
loc_1F03A:
    mov     ax, [bp+var_nextPosElemCrds.vx]
loc_1F03D:
    cmp     ax, 0A4h ; '§'
    jl      short loc_1F068
    cmp     [bp+var_absXElemCrds], 0A4h ; '§'
    jg      short loc_1F068
    mov     wallHeight, 97h ; 'ó'
    cmp     [bp+var_nextPosElemCrds.vx], 0
    jle     short loc_1F05E
    mov     wallindex, 9Bh ; 'õ'
    jmp     code_bto_blank
loc_1F05E:
    mov     wallindex, 9Ch ; 'ú'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F068:
    cmp     [bp+var_absXElemCrds], 0A4h ; '§'
    jl      short loc_1F072
    jmp     code_bto_blank
loc_1F072:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 109h
    jl      short loc_1F084
    jmp     code_bto_blank
loc_1F084:
    cmp     [bp+var_absXElemCrds], 82h ; 'Ç'
    jge     short loc_1F091
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
loc_1F091:
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 97h ; 'ó'
    jle     short loc_1F0A4
    mov     [bp+var_misc1E], 1
    jmp     short loc_1F0A9
loc_1F0A4:
    mov     [bp+var_misc1E], 0
loc_1F0A9:
    cmp     [bp+var_misc22], 0
    jz      short loc_1F0E8
    cmp     [bp+var_misc1E], 0
    jnz     short loc_1F0E8
    cmp     [bp+var_absXElemCrds], 54h ; 'T'
    jg      short loc_1F0E8
    cmp     [bp+var_absZElemCrds], 4Bh ; 'K'
    jg      short loc_1F0E8
    mov     planindex, 45h ; 'E'
    cmp     [bp+var_nextPosElemCrds.vz], 0FFB5h
    jg      short loc_1F0D6
    mov     wallindex, 9Dh ; 'ù'
    jmp     code_bto_blank
loc_1F0D6:
    cmp     [bp+var_nextPosElemCrds.vz], 4Bh ; 'K'
    jge     short loc_1F0DF
    jmp     code_bto_blank
loc_1F0DF:
    mov     wallindex, 9Eh ; 'û'
    jmp     code_bto_blank
loc_1F0E8:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 58h ; 'X'
    jle     short loc_1F116
    cmp     [bp+var_misc1E], 0
    jnz     short loc_1F116
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1F10C
    mov     planindex, 3Ch ; '<'
    jmp     code_bto_blank
loc_1F10C:
    mov     planindex, 42h ; 'B'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F116:
    cmp     [bp+var_absXElemCrds], 1Fh
    jge     short loc_1F136
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F12C
loc_1F122:
    mov     planindex, 3Fh ; '?'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F12C:
    mov     planindex, 39h ; '9'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F136:
    cmp     [bp+var_posElemCrds.vx], 0FFACh
    jge     short loc_1F156
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F14C
    mov     planindex, 3Dh ; '='
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F14C:
    mov     planindex, 3Bh ; ';'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F156:
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1F176
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F16C
    mov     planindex, 3Eh ; '>'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F16C:
    mov     planindex, 3Ah ; ':'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F176:
    cmp     [bp+var_posElemCrds.vx], 54h ; 'T'
    jle     short loc_1F196
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F18C
    mov     planindex, 41h ; 'A'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F18C:
    mov     planindex, 43h ; 'C'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F196:
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F1A6
    mov     planindex, 40h ; '@'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F1A6:
    mov     planindex, 44h ; 'D'
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_corkLr:
    cmp     [bp+var_absXElemCrds], 96h ; 'ñ'
    jl      short loc_1F1BA
    jmp     code_bto_blank
loc_1F1BA:
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 109h
    jl      short loc_1F1CC
    jmp     code_bto_blank
loc_1F1CC:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 97h ; 'ó'
    jle     short loc_1F1E6
    mov     [bp+var_misc1E], 1
    jmp     short loc_1F1EB
    ; align 2
    db 144
loc_1F1E6:
    mov     [bp+var_misc1E], 0
loc_1F1EB:
    mov     [bp+var_misc22], 0
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 58h ; 'X'
    jle     short loc_1F21A
    cmp     [bp+var_misc1E], 0
    jnz     short loc_1F21A
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1F212
    mov     [bp+var_misc22], 3
    jmp     loc_1F295
    db 144
    db 144
loc_1F212:
    mov     [bp+var_misc22], 9
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F21A:
    cmp     [bp+var_absXElemCrds], 1Fh
    jge     short loc_1F22E
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F295
    mov     [bp+var_misc22], 6
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F22E:
    cmp     [bp+var_posElemCrds.vx], 0FFACh
    jge     short loc_1F24A
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F242
    mov     [bp+var_misc22], 4
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F242:
    mov     [bp+var_misc22], 2
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F24A:
    cmp     [bp+var_posElemCrds.vx], 0
    jge     short loc_1F266
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F25E
    mov     [bp+var_misc22], 5
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F25E:
    mov     [bp+var_misc22], 1
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F266:
    cmp     [bp+var_posElemCrds.vx], 54h ; 'T'
    jle     short loc_1F282
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F27A
    mov     [bp+var_misc22], 8
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F27A:
    mov     [bp+var_misc22], 0Ah
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F282:
    cmp     [bp+var_misc1E], 0
    jz      short loc_1F290
    mov     [bp+var_misc22], 7
    jmp     short loc_1F295
    ; align 2
    db 144
loc_1F290:
    mov     [bp+var_misc22], 0Bh
loc_1F295:
    cmp     [bp+var_misc22], 0
    jz      short loc_1F2B8
    mov     di, [bp+var_misc22]
    shl     di, 1
    mov     ax, [bp+var_posElemCrds.vz]
    cmp     corkLR_negZBound[di], ax
    jge     short loc_1F2B8
    cmp     corkLR_posZBound[di], ax
    jle     short loc_1F2B8
    mov     ax, [bp+var_misc22]
    add     ax, 39h ; '9'
    mov     planindex, ax
loc_1F2B8:
    cmp     planindex, 0
    jz      short loc_1F2C2
    jmp     code_bto_blank
loc_1F2C2:
    cmp     [bp+var_absZElemCrds], 200h
    jl      short loc_1F2CC
    jmp     code_bto_blank
loc_1F2CC:
    mov     wallindex, 0B9h ; 'π'
    mov     corkFlag, 1
    mov     wallHeight, 75h ; 'u'
    jmp     code_bto_blank
code_bto_corkUdLH:
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    mov     [bp+var_misc1E], ax
    mov     [bp+var_misc22], 4Fh ; 'O'
    mov     [bp+var_C], 32h ; '2'
    mov     [bp+var_E], 4Bh ; 'K'
    jmp     short loc_1F30F
    ; align 2
    db 144
code_bto_corkUdRH:
    mov     ax, [bp+var_posElemCrds.vx]
    mov     [bp+var_misc1E], ax
    mov     [bp+var_misc22], 69h ; 'i'
    mov     [bp+var_C], 0
    mov     [bp+var_E], 19h
loc_1F30F:
    mov     corkFlag, 1
    cmp     [bp+var_posElemCrds.vz], 0
    jge     short loc_1F350
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 64h ; 'd'
    jge     short loc_1F350
    cmp     [bp+var_misc1E], 0
    jle     short loc_1F350
    cmp     [bp+var_misc1E], 278h
    jl      short loc_1F339
    jmp     code_bto_blank
loc_1F339:
    cmp     [bp+var_misc1E], 188h
    jg      short loc_1F343
    jmp     code_bto_blank
loc_1F343:
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    mov     ax, [bp+var_misc22]
    jmp     loc_1EA9D
    ; align 2
    db 144
loc_1F350:
    cmp     [bp+var_posElemCrds.vz], 0
    jle     short loc_1F3A8
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+2]
    sub     ax, terrainHeight
    cmp     ax, 15Eh
    jle     short loc_1F3A8
    cmp     [bp+var_misc1E], 2B4h
    jge     short loc_1F3A8
    cmp     [bp+var_misc1E], 14Ch
    jle     short loc_1F3A8
    mov     wallHeight, 2Ah ; '*'
    mov     elRdWallRelated, 0FFF4h
    cmp     [bp+var_misc1E], 200h
    jle     short loc_1F38C
    mov     ax, [bp+var_C]
    jmp     short loc_1F38F
    ; align 2
    db 144
loc_1F38C:
    mov     ax, [bp+var_E]
loc_1F38F:
    add     ax, 18h
    mov     wallindex, ax
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    mov     ax, [bp+var_misc22]
    add     ax, 19h
    mov     planindex, ax
    jmp     loc_1EBE7
    ; align 2
    db 144
loc_1F3A8:
    push    [bp+var_posElemCrds.vz]
    push    [bp+var_misc1E]
    call    polarRadius2D
    add     sp, 4
    mov     [bp+var_turnRadius], ax
    cmp     ax, 14Ch
    jg      short loc_1F3C1
    jmp     code_bto_blank
loc_1F3C1:
    cmp     ax, 2B4h
    jl      short loc_1F3C9
    jmp     code_bto_blank
loc_1F3C9:
    push    [bp+var_posElemCrds.vz]
    push    [bp+var_misc1E]
    call    polarAngle
    add     sp, 4
    sub     ax, 100h
    neg     ax
smart
    and     ah, 3
nosmart
    mov     cx, 18h
    imul    cx
    mov     si, ax
    mov     cl, 0Ah
    sar     si, cl
    mov     ax, [bp+var_misc22]
    add     ax, si
    inc     ax
    mov     planindex, ax
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
    mov     byte_4392C, 0
    mov     wallHeight, 2Ah ; '*'
    mov     elRdWallRelated, 0FFF4h
    mov     ax, [bp+var_turnRadius]
    sub     ax, 200h
    cmp     ax, 5Ah ; 'Z'
    jle     short loc_1F41E
    mov     ax, [bp+var_C]
loc_1F418:
    add     ax, si
    jmp     loc_1EA20
    ; align 2
    db 144
loc_1F41E:
    mov     ax, [bp+var_turnRadius]
    sub     ax, 200h
    cmp     ax, 0FFA6h
    jl      short loc_1F42C
    jmp     code_bto_blank
loc_1F42C:
    mov     ax, [bp+var_E]
    jmp     short loc_1F418
    ; align 2
    db 144
code_bto_slalom:
    cmp     [bp+var_absXElemCrds], 78h ; 'x'
    jge     short loc_1F43E
    mov     al, [bp+var_surfaceType]
    mov     current_surf_type, al
loc_1F43E:
    cmp     [bp+var_posElemCrds.vx], 17h
    jl      short loc_1F4A0
    cmp     [bp+var_posElemCrds.vx], 61h ; 'a'
    jg      short loc_1F4A0
    cmp     [bp+var_posElemCrds.vz], 0FEF1h
    jle     short loc_1F4A0
    cmp     [bp+var_posElemCrds.vz], 0FF0Fh
    jge     short loc_1F4A0
    mov     wallHeight, 2Ah ; '*'
    cmp     [bp+var_nextPosElemCrds.vz], 0FEF1h
    jge     short loc_1F46E
    mov     wallindex, 91h ; 'ë'
    jmp     code_bto_blank
loc_1F46E:
    cmp     [bp+var_nextPosElemCrds.vz], 0FF0Fh
    jle     short loc_1F47E
    mov     wallindex, 92h ; 'í'
    jmp     code_bto_blank
loc_1F47E:
    cmp     [bp+var_nextPosElemCrds.vx], 17h
    jge     short loc_1F48E
    mov     wallindex, 94h ; 'î'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F48E:
    cmp     [bp+var_nextPosElemCrds.vx], 61h ; 'a'
    jg      short loc_1F497
    jmp     code_bto_blank
loc_1F497:
    mov     wallindex, 93h ; 'ì'
    jmp     code_bto_blank
loc_1F4A0:
    cmp     [bp+var_posElemCrds.vx], 0FFE9h
    jle     short loc_1F4A9
    jmp     code_bto_blank
loc_1F4A9:
    cmp     [bp+var_posElemCrds.vx], 0FF9Fh
    jge     short loc_1F4B2
    jmp     code_bto_blank
loc_1F4B2:
    cmp     [bp+var_posElemCrds.vz], 10Fh
    jl      short loc_1F4BC
    jmp     code_bto_blank
loc_1F4BC:
    cmp     [bp+var_posElemCrds.vz], 0F1h ; 'Ò'
    jg      short loc_1F4C6
    jmp     code_bto_blank
loc_1F4C6:
    mov     wallHeight, 2Ah ; '*'
    cmp     [bp+var_nextPosElemCrds.vz], 10Fh
    jle     short loc_1F4DC
    mov     wallindex, 8Dh ; 'ç'
    jmp     code_bto_blank
loc_1F4DC:
    cmp     [bp+var_nextPosElemCrds.vz], 0F1h ; 'Ò'
    jge     short loc_1F4EC
    mov     wallindex, 8Eh ; 'é'
    jmp     code_bto_blank
loc_1F4EC:
    cmp     [bp+var_nextPosElemCrds.vx], 0FFE9h
    jle     short loc_1F4FC
    mov     wallindex, 8Fh ; 'è'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F4FC:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF9Fh
    jl      short loc_1F505
    jmp     code_bto_blank
loc_1F505:
    mov     wallindex, 90h ; 'ê'
    jmp     code_bto_blank
code_bto_barn:
    cmp     [bp+var_absXElemCrds], 96h ; 'ñ'
    jle     short loc_1F518
    jmp     code_bto_blank
loc_1F518:
    cmp     [bp+var_absZElemCrds], 96h ; 'ñ'
    jle     short loc_1F522
    jmp     code_bto_blank
loc_1F522:
    mov     wallHeight, 1A9h
    cmp     [bp+var_nextPosElemCrds.vz], 0FF6Ah
    jg      short loc_1F538
    mov     wallindex, 0A1h ; '°'
    jmp     code_bto_blank
loc_1F538:
    cmp     [bp+var_nextPosElemCrds.vz], 96h ; 'ñ'
    jl      short loc_1F548
    mov     wallindex, 0A2h ; '¢'
    jmp     code_bto_blank
loc_1F548:
    cmp     [bp+var_nextPosElemCrds.vx], 96h ; 'ñ'
    jl      short loc_1F558
    mov     wallindex, 0A3h ; '£'
    jmp     code_bto_blank
loc_1F558:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF6Ah
    jle     short loc_1F562
    jmp     code_bto_blank
loc_1F562:
    mov     wallindex, 0A4h ; '§'
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_gasStation:
    cmp     [bp+var_posElemCrds.vx], 0FF38h
    jge     short loc_1F576
    jmp     code_bto_blank
loc_1F576:
    cmp     [bp+var_posElemCrds.vx], 104h
    jle     short loc_1F580
    jmp     code_bto_blank
loc_1F580:
    cmp     [bp+var_absZElemCrds], 50h ; 'P'
    jle     short loc_1F589
    jmp     code_bto_blank
loc_1F589:
    mov     wallHeight, 0E6h ; 'Ê'
    cmp     [bp+var_nextPosElemCrds.vz], 0FFB0h
    jg      short loc_1F59E
    mov     wallindex, 0A5h ; '•'
    jmp     code_bto_blank
loc_1F59E:
    cmp     [bp+var_nextPosElemCrds.vz], 50h ; 'P'
    jl      short loc_1F5AE
    mov     wallindex, 0A8h ; '®'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F5AE:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF38h
    jg      short loc_1F5BE
    mov     wallindex, 0A6h ; '¶'
    jmp     code_bto_blank
loc_1F5BE:
    cmp     [bp+var_nextPosElemCrds.vx], 104h
    jge     short loc_1F5C8
    jmp     code_bto_blank
loc_1F5C8:
    mov     wallindex, 0A7h ; 'ß'
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_joes:
    cmp     [bp+var_absXElemCrds], 0B4h ; '¥'
    jle     short loc_1F5DC
    jmp     code_bto_blank
loc_1F5DC:
    cmp     [bp+var_absZElemCrds], 64h ; 'd'
    jle     short loc_1F5E5
    jmp     code_bto_blank
loc_1F5E5:
    mov     wallHeight, 0F8h ; '¯'
    cmp     [bp+var_nextPosElemCrds.vz], 0FF9Ch
    jg      short loc_1F5FA
    mov     wallindex, 0A9h ; '©'
    jmp     code_bto_blank
loc_1F5FA:
    cmp     [bp+var_nextPosElemCrds.vz], 64h ; 'd'
    jl      short loc_1F60A
    mov     wallindex, 0ACh ; '¨'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F60A:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF4Ch
    jg      short loc_1F61A
    mov     wallindex, 0ABh ; '´'
    jmp     code_bto_blank
loc_1F61A:
    cmp     [bp+var_nextPosElemCrds.vx], 0B4h ; '¥'
    jge     short loc_1F624
    jmp     code_bto_blank
loc_1F624:
    mov     wallindex, 0AAh ; '™'
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_office:
    cmp     [bp+var_absXElemCrds], 0C8h ; '»'
    jle     short loc_1F638
    jmp     code_bto_blank
loc_1F638:
    cmp     [bp+var_absZElemCrds], 0C8h ; '»'
    jle     short loc_1F642
    jmp     code_bto_blank
loc_1F642:
    mov     wallHeight, 226h
    cmp     [bp+var_nextPosElemCrds.vz], 0FF38h
    jg      short loc_1F658
    mov     wallindex, 0ADh ; '≠'
    jmp     code_bto_blank
loc_1F658:
    cmp     [bp+var_nextPosElemCrds.vz], 0C8h ; '»'
    jl      short loc_1F668
    mov     wallindex, 0AEh ; 'Æ'
    jmp     code_bto_blank
loc_1F668:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF38h
    jg      short loc_1F678
    mov     wallindex, 0AFh ; 'Ø'
    jmp     code_bto_blank
loc_1F678:
    cmp     [bp+var_nextPosElemCrds.vx], 0C8h ; '»'
    jge     short loc_1F682
    jmp     code_bto_blank
loc_1F682:
    mov     wallindex, 0B0h ; '∞'
    jmp     code_bto_blank
    ; align 2
    db 144
code_bto_windmill:
    cmp     [bp+var_absXElemCrds], 72h ; 'r'
    jle     short loc_1F695
    jmp     code_bto_blank
loc_1F695:
    cmp     [bp+var_absZElemCrds], 72h ; 'r'
    jle     short loc_1F69E
    jmp     code_bto_blank
loc_1F69E:
    mov     wallHeight, 1EFh
    cmp     [bp+var_nextPosElemCrds.vz], 0FF8Eh
    jg      short loc_1F6B4
    mov     wallindex, 0B4h ; '¥'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F6B4:
    cmp     [bp+var_nextPosElemCrds.vz], 72h ; 'r'
    jl      short loc_1F6C4
    mov     wallindex, 0B2h ; '≤'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F6C4:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF8Eh
    jg      short loc_1F6D4
    mov     wallindex, 0B1h ; '±'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F6D4:
    cmp     [bp+var_nextPosElemCrds.vx], 72h ; 'r'
    jge     short loc_1F6DD
    jmp     code_bto_blank
loc_1F6DD:
    mov     wallindex, 0B3h ; '≥'
    jmp     code_bto_blank
code_bto_ship:
    cmp     [bp+var_posElemCrds.vx], 0FF56h
    jge     short loc_1F6F0
    jmp     code_bto_blank
loc_1F6F0:
    cmp     [bp+var_posElemCrds.vx], 104h
    jle     short loc_1F6FA
    jmp     code_bto_blank
loc_1F6FA:
    cmp     [bp+var_absZElemCrds], 6Eh ; 'n'
    jle     short loc_1F703
    jmp     code_bto_blank
loc_1F703:
    mov     wallHeight, 0E6h ; 'Ê'
    cmp     [bp+var_nextPosElemCrds.vz], 0FF92h
    jg      short loc_1F71A
    mov     wallindex, 0B5h ; 'µ'
    jmp     code_bto_blank
    db 144
    db 144
loc_1F71A:
    cmp     [bp+var_nextPosElemCrds.vz], 6Eh ; 'n'
    jl      short loc_1F72A
    mov     wallindex, 0B8h ; '∏'
    jmp     code_bto_blank
    ; align 2
    db 144
loc_1F72A:
    cmp     [bp+var_nextPosElemCrds.vx], 0FF56h
    jg      short loc_1F73C
    mov     wallindex, 0B7h ; '∑'
    jmp     code_bto_blank
    ; align 4
    db 144
    db 144
loc_1F73C:
    cmp     [bp+var_nextPosElemCrds.vx], 104h
    jge     short loc_1F746
    jmp     code_bto_blank
loc_1F746:
    mov     wallindex, 0B6h ; '∂'
    jmp     code_bto_blank
    ; align 2
    db 144
bto_branches     dw offset code_bto_sfLine
    dw offset code_bto_road ; road
    dw offset code_bto_sCorner; sharp corner
    dw offset code_bto_lCorner; corner
    dw offset code_bto_chicaneRL; chicane B
    dw offset code_bto_chicaneLR; chicane A
    dw offset code_bto_sSplitA; sharp split A
    dw offset code_bto_sSplitB; sharp split B
    dw offset code_bto_lSplitA; split A
    dw offset code_bto_lSplitB; split B
    dw offset code_bto_highEntrance; highway entrance
    dw offset code_bto_highway; highway
    dw offset code_bto_crossroad; crossroad
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_ramp ; ramp
    dw offset code_bto_solidRamp; solid ramp
    dw offset code_bto_elevRoad; elevated road
    dw offset code_bto_elevRoad; elevated span
    dw offset code_bto_solidRoad; solid road
    dw offset code_bto_elevCorner; elevated corner
    dw offset code_bto_overpass; overpass
    dw offset code_bto_bankEntranceB; bank rd. entrance B
    dw offset code_bto_bankEntranceA; bank rd. entrance A
    dw offset code_bto_bankRoad; banked road
    dw offset code_bto_bankCorner; banked corner
    dw offset code_bto_loop ; loop
    dw offset code_bto_tunnel; tunnel
    dw offset code_bto_pipeEntrance; pipe entrance
    dw offset code_bto_pipe ; pipe
    dw offset code_bto_halfPipe; half-pipe
    dw offset code_bto_corkUdLH; cork u/d A
    dw offset code_bto_corkUdRH; cork u/d B
    dw offset code_bto_slalom; slalom
    dw offset code_bto_corkLr; cork l/r
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank
    dw offset code_bto_blank; empty
    dw offset code_bto_barn ; barn
    dw offset code_bto_gasStation; gas station
    dw offset code_bto_joes ; Joe's
    dw offset code_bto_office; office
    dw offset code_bto_windmill; windmill
    dw offset code_bto_ship ; ship
    dw offset code_bto_blank; pine
    dw offset code_bto_blank; cactus
    dw offset code_bto_blank; tennis
    dw offset code_bto_blank; palm
code_bto_blank:
    cmp     [bp+var_tileTerr], 7
    jnb     short code_hillslope_parsing
    jmp     loc_1F8CD
code_hillslope_parsing:
    mov     al, [bp+var_trkCol]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     di, [bp+arg_posWorldCrds]
    mov     ax, [di]
    sub     ax, trackcenterpos2[bx]
    mov     [bp+var_posElemCrds.vx], ax
    mov     al, [bp+var_trkRow]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, [di+4]
    sub     ax, terraincenterpos[bx]
    mov     [bp+var_posElemCrds.vz], ax
    mov     al, [bp+var_tileTerr]
    sub     ah, ah
    sub     ax, 7
    cmp     ax, 0Bh
    ja      short loc_1F896
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_1F87E[bx]
loc_1F82A:
    mov     [bp+var_elemOrient], 0
    jmp     short loc_1F896
    ; align 2
    db 144
loc_1F832:
    mov     [bp+var_elemOrient], 300h
    mov     ax, [bp+var_posElemCrds.vx]
    mov     [bp+var_misc1E], ax
    mov     ax, [bp+var_posElemCrds.vz]
    mov     [bp+var_posElemCrds.vx], ax
    mov     ax, [bp+var_misc1E]
    neg     ax
loc_1F848:
    mov     [bp+var_posElemCrds.vz], ax
    jmp     short loc_1F896
    ; align 2
    db 144
loc_1F84E:
    mov     [bp+var_elemOrient], 200h
    mov     ax, [bp+var_posElemCrds.vz]
    neg     ax
    mov     [bp+var_posElemCrds.vz], ax
    mov     ax, [bp+var_posElemCrds.vx]
    neg     ax
    mov     [bp+var_posElemCrds.vx], ax
    jmp     short loc_1F896
    ; align 2
    db 144
loc_1F866:
    mov     [bp+var_elemOrient], 100h
    mov     ax, [bp+var_posElemCrds.vx]
    mov     [bp+var_misc1E], ax
    mov     ax, [bp+var_posElemCrds.vz]
    neg     ax
    mov     [bp+var_posElemCrds.vx], ax
    mov     ax, [bp+var_misc1E]
    jmp     short loc_1F848
off_1F87E     dw offset loc_1F82A
    dw offset loc_1F832
    dw offset loc_1F84E
    dw offset loc_1F866
    dw offset loc_1F82A
    dw offset loc_1F832
    dw offset loc_1F84E
    dw offset loc_1F866
    dw offset loc_1F82A
    dw offset loc_1F832
    dw offset loc_1F84E
    dw offset loc_1F866
loc_1F896:
    mov     al, [bp+var_tileTerr]
    sub     ah, ah
    cmp     ax, 7
    jb      short loc_1F8CD
    cmp     ax, 0Ah
    jbe     short loc_1F8C0
    cmp     ax, 0Bh
    jb      short loc_1F8CD
    cmp     ax, 0Eh
    jbe     short loc_1F8FC
    cmp     ax, 0Fh
    jb      short loc_1F8CD
    cmp     ax, 12h
    ja      short loc_1F8BC
    jmp     loc_1F940
loc_1F8BC:
    jmp     short loc_1F8CD
    ; align 4
    db 144
    db 144
loc_1F8C0:
    cmp     planindex, 0
    jnz     short loc_1F8CD
loc_1F8C7:
    mov     planindex, 3
loc_1F8CD:
    cmp     planindex, 0
    jg      short loc_1F8D7
    jmp     loc_1F992
loc_1F8D7:
    mov     cl, 2
    shl     planindex, cl
    mov     ax, [bp+var_elemOrient]
    cmp     ax, 100h
    jnz     short loc_1F8E8
    jmp     loc_1F9CC
loc_1F8E8:
    cmp     ax, 200h
    jnz     short loc_1F8F0
    jmp     loc_1F9C4
loc_1F8F0:
    cmp     ax, 300h
    jnz     short loc_1F8F8
    jmp     loc_1F98E
loc_1F8F8:
    jmp     loc_1F992
    ; align 2
    db 144
loc_1F8FC:
    push    [bp+var_posElemCrds.vz]
    mov     ax, 0FF80h
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_posElemCrds.vx]
    mov     cx, 0FF80h
    push    cx
    mov     di, ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, di
    mov     [bp+var_misc22], ax
    or      ax, ax
    jge     short loc_1F8CD
    mov     planindex, 4
    jmp     short loc_1F8CD
    ; align 2
    db 144
loc_1F940:
    push    [bp+var_posElemCrds.vz]
    mov     ax, 0FF80h
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_posElemCrds.vx]
    mov     cx, 0FF80h
    push    cx
    mov     di, ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    add     ax, di
    mov     [bp+var_misc22], ax
    or      ax, ax
    jle     short loc_1F984
    mov     planindex, 5
    jmp     loc_1F8CD
loc_1F984:
    mov     terrainHeight, 1C2h
    jmp     loc_1F8CD
    ; align 2
    db 144
loc_1F98E:
    inc     planindex
loc_1F992:
    mov     ax, 22h ; '"'
    imul    planindex
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     word ptr current_planptr, ax
    mov     word ptr current_planptr+2, dx
    cmp     current_surf_type, 4
    jnz     short loc_1F9D4
    mov     bx, [bp+arg_posWorldCrds]
    mov     ax, [bx+4]
    xor     ax, [bx]
    mov     cl, 8
    sar     ax, cl
smart
    and     ax, 1
nosmart
    add     terrainHeight, ax
    jmp     short loc_1F9D9
loc_1F9C4:
    add     planindex, 2
    jmp     short loc_1F992
    ; align 2
    db 144
loc_1F9CC:
    add     planindex, 3
    jmp     short loc_1F992
    ; align 2
    db 144
loc_1F9D4:
    add     terrainHeight, 2
loc_1F9D9:
    cmp     wallindex, 0
    jge     short loc_1F9E3
    jmp     loc_1FADE
loc_1F9E3:
    mov     bx, wallindex
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1           ; *6
    les     di, wallptr
    mov     ax, es:[bx+di]
    neg     ax
    add     ax, [bp+var_elemOrient]
    add     ax, [bp+var_wallOrientMod]
smart
    and     ah, 3
nosmart
    mov     wallOrientation, ax
    mov     ax, [bp+var_elemOrient]
    or      ax, ax
    jz      short loc_1FA20
    cmp     ax, 100h
    jnz     short loc_1FA13
    jmp     loc_1FAA6
loc_1FA13:
    cmp     ax, 200h
    jz      short loc_1FA78
    cmp     ax, 300h
    jz      short loc_1FA4C
    jmp     loc_1FAD0
loc_1FA20:
    mov     ax, wallindex
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr wallptr
    mov     dx, es
    mov     word ptr [bp+var_curr_wallptr], ax
    mov     word ptr [bp+var_curr_wallptr+2], dx
    les     bx, [bp+var_curr_wallptr]
    mov     ax, es:[bx+2]
    mov     wallStartX, ax
    mov     ax, es:[bx+4]
loc_1FA45:
    mov     wallStartZ, ax
    jmp     loc_1FAD0
    ; align 2
    db 144
loc_1FA4C:
    mov     ax, wallindex
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr wallptr
loc_1FA5B:
    mov     dx, word ptr wallptr+2
    mov     word ptr [bp+var_curr_wallptr], ax
    mov     word ptr [bp+var_curr_wallptr+2], dx
    les     bx, [bp+var_curr_wallptr]
    mov     ax, es:[bx+4]
    neg     ax
    mov     wallStartX, ax
    mov     ax, es:[bx+2]
    jmp     short loc_1FA45
    ; align 2
    db 144
loc_1FA78:
    mov     ax, wallindex
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr wallptr
    mov     dx, word ptr wallptr+2
    mov     word ptr [bp+var_curr_wallptr], ax
    mov     word ptr [bp+var_curr_wallptr+2], dx
    les     bx, [bp+var_curr_wallptr]
    mov     ax, es:[bx+2]
    neg     ax
    mov     wallStartX, ax
    mov     ax, es:[bx+4]
loc_1FAA1:
    neg     ax
    jmp     short loc_1FA45
    ; align 2
    db 144
loc_1FAA6:
    mov     ax, wallindex
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr wallptr
    mov     dx, word ptr wallptr+2
    mov     word ptr [bp+var_curr_wallptr], ax
    mov     word ptr [bp+var_curr_wallptr+2], dx
    les     bx, [bp+var_curr_wallptr]
    mov     ax, es:[bx+4]
    mov     wallStartX, ax
    mov     ax, es:[bx+2]
    jmp     short loc_1FAA1
    ; align 2
    db 144
loc_1FAD0:
    mov     ax, elem_xCenter
    add     wallStartX, ax
    mov     ax, elem_zCenter
    add     wallStartZ, ax
loc_1FADE:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
build_track_object endp
bto_auxiliary1 proc far
    var_14 = word ptr -20
    var_10 = byte ptr -16
    var_C = word ptr -12
    var_A = word ptr -10
    var_elemOrient = word ptr -8
    var_6 = word ptr -6
    var_elemDepOffset = word ptr -4
    var_tileElem = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 14h
    push    di
    push    si
    mov     bx, [bp+arg_2]
    shl     bx, 1
    mov     bx, trackrows[bx]
    add     bx, [bp+arg_0]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileElem], al
    or      al, al
    jnz     short loc_1FB12
loc_1FB0A:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_1FB12:
    mov     bx, [bp+arg_0]
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
    mov     [bp+var_6], ax
    mov     bx, [bp+arg_2]
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    mov     [bp+var_C], ax
    cmp     [bp+var_tileElem], 0FDh ; '˝'
    jnb     short loc_1FB33
    jmp     loc_1FC34
loc_1FB33:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    cmp     ax, 0FDh ; '˝'
    jz      short loc_1FB4E
    cmp     ax, 0FEh ; '˛'
    jz      short loc_1FBB4
    cmp     ax, 0FFh
    jnz     short loc_1FB4A
    jmp     loc_1FBF2
loc_1FB4A:
    jmp     loc_1FC86
    ; align 2
    db 144
loc_1FB4E:
    mov     ax, [bp+arg_2]
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, ax
    mov     bx, word_45D3E[bx]; is really trackrows[bx -1]
    add     bx, [bp+arg_0]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx-1]
    mov     [bp+var_tileElem], al
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jz      short loc_1FB8D
    mov     bx, [bp+var_14]
    mov     ax, (trackpos+2)[bx]
loc_1FB8A:
    mov     [bp+var_C], ax
loc_1FB8D:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 2
    jnz     short loc_1FBA8
    jmp     loc_1FC86
loc_1FBA8:
    mov     bx, [bp+arg_0]
    shl     bx, 1
    mov     ax, trackpos2[bx]
    jmp     loc_1FC83
loc_1FBB4:
    mov     ax, [bp+arg_2]
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, ax
    mov     bx, word_45D3E[bx]; is really trackrows[bx -1]
    add     bx, [bp+arg_0]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileElem], al
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jz      short loc_1FC62
    mov     bx, [bp+var_14]
    mov     ax, (trackpos+2)[bx]
    jmp     short loc_1FC5F
    ; align 2
    db 144
loc_1FBF2:
    mov     ax, [bp+arg_2]
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, ax
    mov     bx, trackrows[bx]
    add     bx, [bp+arg_0]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx-1]
    mov     [bp+var_tileElem], al
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jnz     short loc_1FC2A
    jmp     loc_1FB8D
loc_1FC2A:
    mov     bx, [bp+var_14]
    mov     ax, trackpos[bx]
    jmp     loc_1FB8A
loc_1FC34:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     al, trkObjectList.ss_multiTileFlag[bx]
    mov     byte ptr [bp+var_14], al
    cmp     al, ah
    jz      short loc_1FC86
    test    byte ptr [bp+var_14], 1
    jz      short loc_1FC62
    mov     bx, [bp+arg_2]
    shl     bx, 1
    mov     ax, trackpos[bx]
loc_1FC5F:
    mov     [bp+var_C], ax
loc_1FC62:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 2
    jz      short loc_1FC86
    mov     bx, [bp+arg_0]
    shl     bx, 1
    mov     ax, (trackpos2+2)[bx]
loc_1FC83:
    mov     [bp+var_6], ax
loc_1FC86:
    sub     di, di
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     al, trkObjectList.ss_physicalModel[bx]
    cbw
    cmp     ax, 20h ; ' '
    jz      short loc_1FCC2
    jg      short loc_1FCF4
    cmp     ax, 0Bh
    jz      short loc_1FCE0
    cmp     ax, 12h
    jz      short loc_1FCEA
    jmp     short loc_1FCBA
    ; align 2
    db 144
loc_1FCB2:
    mov     di, 2
    mov     [bp+var_elemDepOffset], offset unk_3E676
loc_1FCBA:
    or      di, di
    jnz     short loc_1FD14
    jmp     loc_1FB0A
    ; align 2
    db 144
loc_1FCC2:
    mov     di, 2
    mov     [bp+var_elemDepOffset], offset unk_3E682
    jmp     short loc_1FCBA
loc_1FCCC:
    mov     di, 2
    mov     [bp+var_elemDepOffset], offset unk_3E68E
    jmp     short loc_1FCBA
loc_1FCD6:
    mov     di, 4
    mov     [bp+var_elemDepOffset], offset unk_3E69A
    jmp     short loc_1FCBA
loc_1FCE0:
    mov     di, 1
    mov     [bp+var_elemDepOffset], offset unk_3E640
    jmp     short loc_1FCBA
loc_1FCEA:
    mov     di, 8
    mov     [bp+var_elemDepOffset], offset unk_3E646
    jmp     short loc_1FCBA
loc_1FCF4:
    cmp     ax, 22h ; '"'
    jz      short loc_1FCD6
    jg      short loc_1FD02
    cmp     ax, 21h ; '!'
    jz      short loc_1FCCC
    jmp     short loc_1FCBA
loc_1FD02:
    cmp     ax, 23h ; '#'
    jz      short loc_1FCB2
    cmp     ax, 47h ; 'G'
    jl      short loc_1FCBA
    cmp     ax, 4Ah ; 'J'
    jle     short loc_1FCE0
    jmp     short loc_1FCBA
    ; align 2
    db 144
loc_1FD14:
    mov     bx, [bp+arg_2]
    shl     bx, 1
    mov     bx, terrainrows[bx]
    add     bx, [bp+arg_0]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_10], al
    cmp     al, 6
    jnz     short loc_1FD3A
    mov     ax, hillHeightConsts+2
    mov     [bp+var_A], ax
    jmp     short loc_1FD3F
loc_1FD3A:
    mov     [bp+var_A], 0
loc_1FD3F:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     ax, trkObjectList.ss_rotY[bx]
    mov     [bp+var_elemOrient], ax
    sub     si, si
    jmp     short loc_1FDA6
    ; align 2
    db 144
loc_1FD5C:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, ax
    mov     ax, [bx]
    add     ax, [bp+var_6]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx+2]
    add     ax, [bp+var_A]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx+2], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx+4]
loc_1FD99:
    add     ax, [bp+var_C]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx+4], ax
loc_1FDA5:
    inc     si
loc_1FDA6:
    cmp     si, di
    jl      short loc_1FDAD
    jmp     loc_1FE8C
loc_1FDAD:
    mov     ax, [bp+var_elemOrient]
    or      ax, ax
    jz      short loc_1FD5C
    cmp     ax, 100h
    jnz     short loc_1FDBC
    jmp     loc_1FE4A
loc_1FDBC:
    cmp     ax, 200h
    jz      short loc_1FE08
    cmp     ax, 300h
    jnz     short loc_1FDA5
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, ax
    mov     ax, [bx+4]
    neg     ax
    add     ax, [bp+var_6]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx], ax
loc_1FDE8:
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx+2]
    add     ax, [bp+var_A]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx+2], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx]
    jmp     short loc_1FD99
    ; align 2
    db 144
loc_1FE08:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, ax
    mov     ax, [bx]
    neg     ax
    add     ax, [bp+var_6]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx+2]
    add     ax, [bp+var_A]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx+2], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx+4]
    jmp     short loc_1FE87
    ; align 2
    db 144
loc_1FE4A:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, ax
    mov     ax, [bx+4]
    add     ax, [bp+var_6]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx+2]
    add     ax, [bp+var_A]
    mov     bx, [bp+arg_4]
    add     bx, [bp+var_14]
    mov     [bx+2], ax
    mov     bx, [bp+var_elemDepOffset]
    add     bx, [bp+var_14]
    mov     ax, [bx]
loc_1FE87:
    neg     ax
    jmp     loc_1FD99
loc_1FE8C:
    mov     ax, di
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
bto_auxiliary1 endp
ported_shape3d_load_all_ proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    sub     ax, ax
    mov     word ptr game1ptr+2, ax
    mov     word ptr game1ptr, ax
    mov     word ptr game2ptr+2, ax
    mov     word ptr game2ptr, ax
    call    mmgr_get_res_ofs_diff_scaled
    or      dx, dx
    jg      short loc_1FEC2
    jl      short loc_1FEB9
    cmp     ax, 0FDE8h
    jnb     short loc_1FEC2
loc_1FEB9:
    mov     ax, 1
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_1FEC2:
    mov     ax, offset aGame1; "game1"
    push    ax
    call    file_load_3dres
    add     sp, 2
    mov     word ptr game1ptr, ax
    mov     word ptr game1ptr+2, dx
    mov     ax, offset aGame2; "game2"
    push    ax
    call    file_load_3dres
    add     sp, 2
    mov     word ptr game2ptr, ax
    mov     word ptr game2ptr+2, dx
    sub     si, si
loc_1FEEA:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, offset aBarn; "barn"
    push    ax
    push    word ptr game1ptr+2
    push    word ptr game1ptr
    call    locate_shape_nofatal
    add     sp, 6
    mov     word ptr curshapeptr, ax
    mov     word ptr curshapeptr+2, dx
    or      ax, dx
    jnz     short loc_1FF38
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, offset aBarn; "barn"
    push    ax
    push    word ptr game2ptr+2
    push    word ptr game2ptr
    call    locate_shape_fatal
    add     sp, 6
    mov     word ptr curshapeptr, ax
    mov     word ptr curshapeptr+2, dx
loc_1FF38:
    mov     ax, 16h
    imul    si
    add     ax, offset game3dshapes
    push    ax
    push    word ptr curshapeptr+2
    push    word ptr curshapeptr
    call    shape3d_init_shape
    add     sp, 6
    inc     si
    cmp     si, 74h ; 't'
    jl      short loc_1FEEA
    sub     ax, ax
    pop     si
    mov     sp, bp
    pop     bp
    retf
ported_shape3d_load_all_ endp
ported_shape3d_free_all_ proc far

    mov     ax, word ptr game1ptr
    or      ax, word ptr game1ptr+2
    jz      short loc_1FF77
    push    word ptr game1ptr+2
    push    word ptr game1ptr
    call    mmgr_free
    add     sp, 4
loc_1FF77:
    mov     ax, word ptr game2ptr
    or      ax, word ptr game2ptr+2
    jz      short locret_1FF90
    push    word ptr game2ptr+2
    push    word ptr game2ptr
    call    mmgr_free
    add     sp, 4
locret_1FF90:
    retf
    ; align 2
    db 144
ported_shape3d_free_all_ endp
ported_shape3d_load_car_shapes_ proc far
    var_10 = byte ptr -16
    var_E = dword ptr -14
    var_A = dword ptr -10
    var_6 = dword ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_playercarid = word ptr 6
    arg_opponentcarid = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    di
    push    si
    mov     bx, [bp+arg_playercarid]
    mov     al, [bx]
    mov     byte ptr aStxxx+2, al
    mov     al, [bx+1]
    mov     byte ptr aStxxx+3, al
    mov     al, [bx+2]
    mov     byte ptr aStxxx+4, al
    mov     al, [bx+3]
    mov     byte ptr aStxxx+5, al
    mov     ax, offset aStxxx; "stxxx"
    push    ax
    call    file_load_3dres
    add     sp, 2
    mov     word ptr carresptr, ax
    mov     word ptr carresptr+2, dx
    mov     ax, (offset game3dshapes.shape3d_numverts+0AA8h)
    push    ax
    mov     ax, offset aCar0; "car0"
    push    ax
    push    dx
    push    word ptr carresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0AD4h)
    push    ax
loc_1FFEA:
    mov     ax, offset aCar1; "car1"
    push    ax
loc_1FFEE:
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, word ptr game3dshapes.shape3d_verts+0AD4h
    mov     dx, word ptr game3dshapes.shape3d_verts+0AD6h
    add     ax, 30h ; '0'
    mov     word ptr [bp+var_E], ax
    mov     word ptr [bp+var_E+2], dx
    les     bx, [bp+var_E]
    mov     ax, es:[bx+VECTOR.vz]
    mov     carshapevec.vz, ax
    mov     ax, es:[bx+(VECTOR.vx+12h)]
    add     ax, es:[bx+VECTOR.vx]
    sar     ax, 1
    mov     carshapevec.vx, ax
    mov     ax, es:[bx+(VECTOR.vz+24h)]
    mov     carshapevec2.vz, ax
    mov     ax, es:[bx+(VECTOR.vx+24h)]
    add     ax, es:[bx+(VECTOR.vx+36h)]
    sar     ax, 1
    mov     carshapevec2.vx, ax
    sub     si, si
loc_20044:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    mov     ax, carshapevec.vx
    les     bx, [bp+var_E]
    sub     ax, es:[bx+di+VECTOR.vx]
    mov     word ptr carshapevecs.vx[di], ax
    les     bx, [bp+var_E]
    mov     ax, carshapevec.vz
    sub     ax, es:[bx+di+VECTOR.vz]
    mov     carshapevecs.vz[di], ax
    les     bx, [bp+var_E]
    mov     ax, es:[bx+di+VECTOR.vy]
    mov     carshapevecs.vy[di], ax
    les     bx, [bp+var_E]
    mov     ax, carshapevec2.vx
    sub     ax, es:[bx+di+(VECTOR.vx+24h)]
    mov     word ptr carshapevecs2.vx[di], ax
    les     bx, [bp+var_E]
    mov     ax, carshapevec2.vz
    sub     ax, es:[bx+di+(VECTOR.vz+24h)]
    mov     carshapevecs2.vz[di], ax
    les     bx, [bp+var_E]
    mov     ax, es:[bx+di+(VECTOR.vy+24h)]
    mov     carshapevecs2.vy[di], ax
    les     bx, [bp+var_E]
    push    si
    push    di
    lea     si, [bx+di+(VECTOR.vx+48h)]
    lea     di, carshapevecs3.vx[di]
    push    ds
    push    ds
    push    es
    pop     ds
    pop     es
    movsw
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    les     bx, [bp+var_E]
    push    si
    push    di
    lea     si, [bx+di+(VECTOR.vx+6Ch)]
    lea     di, carshapevecs4.vx[di]
    push    ds
    push    ds
    push    es
    pop     ds
    pop     es
    movsw
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    inc     si
    cmp     si, 6
    jge     short loc_200D4
    jmp     loc_20044
loc_200D4:
    sub     si, si
loc_200D6:
    mov     bx, si
    shl     bx, 1
    mov     word_443E8[bx], 0
    inc     si
    cmp     si, 5
    jl      short loc_200D6
    mov     ax, (offset game3dshapes.shape3d_numverts+0B00h)
    push    ax
    mov     ax, offset aCar2; "car2"
    push    ax
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+9F8h)
    push    ax
    mov     ax, offset aExp0_0; "exp0"
    push    ax
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0A0Eh)
    push    ax
    mov     ax, offset aExp1_0; "exp1"
    push    ax
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0A24h)
    push    ax
    mov     ax, offset aExp2_0; "exp2"
    push    ax
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0A3Ah)
    push    ax
    mov     ax, offset aExp3_0; "exp3"
    push    ax
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     bx, [bp+arg_opponentcarid]
    mov     al, [bx]
    mov     [bp+var_10], al
    cmp     al, 0FFh
    jnz     short loc_2019F
    jmp     loc_2042A
loc_2019F:
    mov     bx, [bp+arg_playercarid]
    cmp     [bx], al
    jz      short loc_201A9
    jmp     loc_2022A
loc_201A9:
    mov     di, [bp+arg_opponentcarid]
    mov     al, [di+1]
    cmp     [bx+1], al
    jnz     short loc_2022A
    mov     al, [di+2]
    cmp     [bx+2], al
    jnz     short loc_2022A
    mov     al, [di+3]
    cmp     [bx+3], al
    jnz     short loc_2022A
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    mmgr_get_chunk_size_bytes
    add     sp, 4
    mov     word ptr [bp+var_6], ax
    mov     word ptr [bp+var_6+2], dx
    push    dx
    push    ax
    mov     ax, offset aCar2_0; "car2"
    push    ax
    call    mmgr_alloc_resbytes
    add     sp, 6
    mov     word ptr car2resptr, ax
    mov     word ptr car2resptr+2, dx
    sub     ax, ax
    mov     word ptr [bp+var_A+2], ax
    mov     word ptr [bp+var_A], ax
    jmp     short loc_20204
    ; align 4
    db 144
    db 144
    db 144
loc_201FC:
    add     word ptr [bp+var_A], 1
    adc     word ptr [bp+var_A+2], 0
loc_20204:
    mov     ax, word ptr [bp+var_6]
    mov     dx, word ptr [bp+var_6+2]
    cmp     word ptr [bp+var_A+2], dx
    jg      short loc_20257
    jl      short loc_20216
    cmp     word ptr [bp+var_A], ax
    jnb     short loc_20257
loc_20216:
    mov     bx, word ptr [bp+var_A]
    les     di, carresptr
    mov     al, es:[bx+di]
    les     di, car2resptr
    mov     es:[bx+di], al
    jmp     short loc_201FC
    ; align 2
    db 144
loc_2022A:
    mov     bx, [bp+arg_opponentcarid]
    mov     al, [bx]
    mov     byte ptr aStxxx+2, al
    mov     al, [bx+1]
    mov     byte ptr aStxxx+3, al
    mov     al, [bx+2]
    mov     byte ptr aStxxx+4, al
    mov     al, [bx+3]
loc_20241:
    mov     byte ptr aStxxx+5, al
    mov     ax, offset aStxxx; "stxxx"
    push    ax
    call    file_load_3dres
    add     sp, 2
    mov     word ptr car2resptr, ax
    mov     word ptr car2resptr+2, dx
loc_20257:
    mov     ax, (offset game3dshapes.shape3d_numverts+0ABEh)
    push    ax
    mov     ax, offset aCar0_0; "car0"
    push    ax
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0AEAh)
    push    ax
    mov     ax, offset aCar1_0; "car1"
    push    ax
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, word ptr game3dshapes.shape3d_verts+0AEAh
    mov     dx, word ptr game3dshapes.shape3d_verts+0AECh
    add     ax, 30h ; '0'
    mov     word ptr [bp+var_E], ax
    mov     word ptr [bp+var_E+2], dx
    les     bx, [bp+var_E]
    mov     ax, es:[bx+VECTOR.vz]
    mov     oppcarshapevec.vz, ax
    mov     ax, es:[bx+(VECTOR.vx+12h)]
    add     ax, es:[bx+VECTOR.vx]
    sar     ax, 1
    mov     oppcarshapevec.vx, ax
    mov     ax, es:[bx+(VECTOR.vz+24h)]
    mov     oppcarshapevec2.vz, ax
    mov     ax, es:[bx+(VECTOR.vx+24h)]
    add     ax, es:[bx+(VECTOR.vx+36h)]
    sar     ax, 1
    mov     oppcarshapevec2.vx, ax
    sub     si, si
loc_202D7:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    mov     ax, oppcarshapevec.vx
    les     bx, [bp+var_E]
    sub     ax, es:[bx+di+VECTOR.vx]
    mov     word ptr oppcarshapevecs.vx[di], ax
    les     bx, [bp+var_E]
    mov     ax, oppcarshapevec.vz
    sub     ax, es:[bx+di+VECTOR.vz]
    mov     oppcarshapevecs.vz[di], ax
    les     bx, [bp+var_E]
    mov     ax, es:[bx+di+VECTOR.vy]
    mov     oppcarshapevecs.vy[di], ax
    les     bx, [bp+var_E]
    mov     ax, oppcarshapevec2.vx
    sub     ax, es:[bx+di+(VECTOR.vx+24h)]
    mov     word ptr oppcarshapevecs2.vx[di], ax
    les     bx, [bp+var_E]
    mov     ax, oppcarshapevec2.vz
    sub     ax, es:[bx+di+(VECTOR.vz+24h)]
    mov     oppcarshapevecs2.vz[di], ax
    les     bx, [bp+var_E]
    mov     ax, es:[bx+di+(VECTOR.vy+24h)]
    mov     oppcarshapevecs2.vy[di], ax
    les     bx, [bp+var_E]
    push    si
    push    di
    lea     si, [bx+di+(VECTOR.vx+48h)]
    lea     di, oppcarshapevecs3.vx[di]
    push    ds
    push    ds
    push    es
    pop     ds
    pop     es
    movsw
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    les     bx, [bp+var_E]
    push    si
    push    di
    lea     si, [bx+di+(VECTOR.vx+6Ch)]
    lea     di, oppcarshapevecs4.vx[di]
    push    ds
    push    ds
    push    es
    pop     ds
    pop     es
    movsw
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    inc     si
    cmp     si, 6
    jge     short loc_20367
    jmp     loc_202D7
loc_20367:
    sub     si, si
loc_20369:
    mov     bx, si
    shl     bx, 1
    mov     word_4448A[bx], 0
    inc     si
    cmp     si, 5
    jl      short loc_20369
    mov     ax, (offset game3dshapes.shape3d_numverts+0B16h)
    push    ax
    mov     ax, offset aCar2_1; "car2"
    push    ax
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0A50h)
    push    ax
    mov     ax, offset aExp0_1; "exp0"
    push    ax
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0A66h)
    push    ax
    mov     ax, offset aExp1_1; "exp1"
    push    ax
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0A7Ch)
    push    ax
    mov     ax, offset aExp2_1; "exp2"
    push    ax
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    mov     ax, (offset game3dshapes.shape3d_numverts+0A92h)
    push    ax
    mov     ax, offset aExp3_1; "exp3"
    push    ax
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    locate_shape_fatal
    add     sp, 6
    push    dx
    push    ax
    call    shape3d_init_shape
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_2042A:
    sub     ax, ax
    mov     word ptr car2resptr+2, ax
    mov     word ptr car2resptr, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
ported_shape3d_load_car_shapes_ endp
ported_shape3d_free_car_shapes_ proc far

    mov     ax, word ptr car2resptr
    or      ax, word ptr car2resptr+2
    jz      short loc_20477
    mov     ax, offset oppcarshapevec
    push    ax
    mov     ax, offset oppcarshapevecs
    push    ax
    mov     ax, offset word_4448A
    push    ax
    mov     ax, offset unk_3E710
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, word ptr game3dshapes.shape3d_verts+0AEAh
    mov     dx, word ptr game3dshapes.shape3d_verts+0AECh
    add     ax, 30h ; '0'
    push    dx
    push    ax
    push    cs
    call near ptr ported_sub_204AE_
    add     sp, 0Eh
    push    word ptr car2resptr+2
    push    word ptr car2resptr
    call    mmgr_release
    add     sp, 4
loc_20477:
    mov     ax, offset carshapevec
    push    ax
    mov     ax, offset carshapevecs
    push    ax
    mov     ax, offset word_443E8
    push    ax
    mov     ax, offset unk_3E710
    push    ax
    sub     ax, ax
    push    ax
    mov     ax, word ptr game3dshapes.shape3d_verts+0AD4h
    mov     dx, word ptr game3dshapes.shape3d_verts+0AD6h
    add     ax, 30h ; '0'
    push    dx
    push    ax
    push    cs
    call near ptr ported_sub_204AE_
    add     sp, 0Eh
    push    word ptr carresptr+2
    push    word ptr carresptr
    call    mmgr_free
    add     sp, 4
    retf
ported_shape3d_free_car_shapes_ endp
ported_sub_204AE_ proc far
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_8 = word ptr -8
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_verts = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_vecarray = word ptr 16
    arg_vecptr = word ptr 18

    push    bp
    mov     bp, sp
    sub     sp, 14h
    push    di
    push    si
    mov     bx, [bp+arg_8]
    mov     ax, [bp+arg_4]
    cmp     [bx+8], ax
    jnz     short loc_204C4
    jmp     loc_2064C
loc_204C4:
    sar     ax, 1
    push    ax
    call    sin_fast
    add     sp, 2
    mov     [bp+var_C], ax
    mov     ax, [bp+arg_4]
    sar     ax, 1
    push    ax
    call    cos_fast
    add     sp, 2
    mov     [bp+var_2], ax
    sub     si, si
loc_204E5:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_10], ax
    push    [bp+var_2]
    mov     bx, [bp+arg_vecarray]
    mov     ax, si
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     bx, ax
    push    [bx+VECTOR.vx]
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_C]
    mov     bx, [bp+arg_vecarray]
    add     bx, [bp+var_10]
    push    [bx+VECTOR.vz]
    mov     [bp+var_14], ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_vecptr]
    mov     cx, [bx+VECTOR.vx]
    add     cx, ax
    add     cx, [bp+var_14]
    les     bx, [bp+arg_verts]
    add     bx, [bp+var_10]
    mov     es:[bx+VECTOR.vx], cx
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_12], ax
    push    [bp+var_2]
    mov     bx, [bp+arg_vecarray]
    mov     ax, si
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     bx, ax
    push    [bx+VECTOR.vz]
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_C]
    mov     bx, [bp+arg_vecarray]
    add     bx, [bp+var_12]
    push    [bx+VECTOR.vx]
    mov     [bp+var_14], ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_vecptr]
    mov     cx, [bx+VECTOR.vz]
    add     cx, ax
    add     cx, [bp+var_14]
    les     bx, [bp+arg_verts]
    add     bx, [bp+var_12]
    mov     es:[bx+VECTOR.vz], cx
    inc     si
    cmp     si, 6
    jge     short loc_20592
    jmp     loc_204E5
loc_20592:
    mov     si, 6
loc_20595:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_14], ax
    push    [bp+var_2]
    mov     bx, [bp+arg_vecarray]
    mov     ax, si
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     bx, ax
    push    [bx+VECTOR.vx]
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_C]
    mov     bx, [bp+arg_vecarray]
    add     bx, [bp+var_14]
    push    [bx+VECTOR.vz]
    mov     [bp+var_10], ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_vecptr]
    mov     cx, [bx+(size VECTOR)]
    add     cx, ax
    add     cx, [bp+var_10]
    les     bx, [bp+arg_verts]
    add     bx, [bp+var_14]
    mov     es:[bx+VECTOR.vx], cx
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_12], ax
    push    [bp+var_2]
    mov     bx, [bp+arg_vecarray]
    mov     ax, si
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     bx, ax
    push    [bx+VECTOR.vz]
    call    multiply_and_scale
    add     sp, 4
    push    [bp+var_C]
    mov     bx, [bp+arg_vecarray]
    add     bx, [bp+var_12]
    push    [bx+VECTOR.vx]
    mov     [bp+var_10], ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_vecptr]
    mov     cx, [bx+(VECTOR.vz+6)]
    add     cx, ax
    add     cx, [bp+var_10]
    les     bx, [bp+arg_verts]
    add     bx, [bp+var_12]
    mov     es:[bx+VECTOR.vz], cx
    inc     si
    cmp     si, 0Ch
    jge     short loc_20643
    jmp     loc_20595
loc_20643:
    mov     bx, [bp+arg_8]
    mov     ax, [bp+arg_4]
    mov     [bx+8], ax
loc_2064C:
    sub     di, di
    jmp     short loc_20687
loc_20650:
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, [bp+arg_vecarray]
    add     bx, ax
    mov     ax, [bx+VECTOR.vy]
    sub     ax, [bp+var_8]
    les     bx, [bp+arg_verts]
    add     bx, [bp+var_14]
    mov     es:[bx+VECTOR.vy], ax
    inc     si
loc_20673:
    cmp     [bp+var_4], si
    jg      short loc_20650
    mov     bx, [bp+arg_8]
    mov     ax, di
    shl     ax, 1
    add     bx, ax
    mov     ax, [bp+var_8]
    mov     [bx], ax
loc_20686:
    inc     di
loc_20687:
    cmp     di, 4
    jge     short loc_206CE
    mov     ax, di
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     bx, [bp+arg_6]
    add     bx, ax
    mov     ax, [bx]
    cwd
    xor     ax, dx
    sub     ax, dx
loc_2069F:
    mov     cx, 6
    sar     ax, cl
    xor     ax, dx
    sub     ax, dx
    mov     [bp+var_8], ax
    mov     bx, [bp+arg_8]
    add     bx, [bp+var_14]
    cmp     [bx], ax
    jz      short loc_20686
    mov     ax, di
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_E], ax
    add     ax, 6
    mov     [bp+var_4], ax
    mov     si, [bp+var_E]
    jmp     short loc_20673
    ; align 2
    db 144
loc_206CE:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
ported_sub_204AE_ endp
track_setup proc far
    var_AF0 = dword ptr -2800
    var_AEC = word ptr -2796
    var_AEA = word ptr -2794
    var_AE8 = byte ptr -2792
    var_MprevTileElem = byte ptr -2790
    var_connCheckFlag = byte ptr -2788
    var_tcompPtrL = word ptr -2786
    var_tcompPtrH = word ptr -2784
    var_ADE = word ptr -2782
    var_ADC = word ptr -2780
    var_ADA = word ptr -2778
    var_AD8 = word ptr -2776
    var_AD6 = word ptr -2774
    var_AD4 = byte ptr -2772
    var_tileTerr = byte ptr -1870
    var_74C = byte ptr -1868
    var_tcompPtr2L = word ptr -1866
    var_tcompPtr2H = word ptr -1864
    var_746 = byte ptr -1862
    var_McurrExitPoint = byte ptr -1860
    var_subTOIBlock = byte ptr -1858
    var_MprevConnStatus = byte ptr -1856
    var_MconnStatus = byte ptr -1854
    var_trkRowIndex = byte ptr -1850
    var_738 = byte ptr -1848
    var_trackErrorCode = byte ptr -944
    var_ptrCurrTOInfo = word ptr -942
    var_3AC = word ptr -940
    var_3AA = byte ptr -938
    var_3A8 = byte ptr -936
    var_sfCount = byte ptr -934
    var_trkColIndex = byte ptr -932
    var_3A2 = word ptr -930
    var_MinternalTOI1 = dword ptr -928
    var_ptrTOInfo = word ptr -924
    var_MprevRowIndex = byte ptr -922
    var_398 = byte ptr -920
    var_prevConnCode = byte ptr -18
    var_MprevColIndex = byte ptr -16
    var_tileElem = byte ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_trackDirection = word ptr -8
    var_tileEntryPoint = byte ptr -6
    var_4 = byte ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2092 = word ptr 8344

    push    bp
    mov     bp, sp
    sub     sp, 0AF0h
    push    di
    push    si
    mov     ax, 380h
    cwd
    push    dx
    push    ax
    mov     ax, offset aTcomp; "tcomp"
    push    ax
    call    mmgr_alloc_resbytes
    add     sp, 6
    mov     [bp+var_tcompPtrL], ax
    mov     [bp+var_tcompPtrH], dx
    or      ax, dx
    jnz     short loc_20704
    mov     ax, 2
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_20704:
    mov     ax, [bp+var_tcompPtrL]
    mov     dx, [bp+var_tcompPtrH]
    mov     [bp+var_tcompPtr2L], ax
    mov     [bp+var_tcompPtr2H], dx
    mov     [bp+var_sfCount], 0
    mov     [bp+var_4], 0
    mov     track_pieces_counter, 0
    sub     si, si
loc_20725:
    les     bx, trackdata19
    mov     byte ptr es:[bx+si], 0FFh
    inc     si
    cmp     si, 385h
    jl      short loc_20725
    mov     [bp+var_trkRowIndex], 0
    jmp     short loc_207A4
    ; align 2
    db 144
loc_2073C:
    mov     bl, [bp+var_tileTerr]
    sub     bh, bh
    mov     al, terrConnDataWtoE[bx]
    mov     [bp+var_prevConnCode], al
    inc     [bp+var_trkColIndex]
loc_2074D:
    cmp     [bp+var_trkColIndex], 1Eh
    jge     short loc_207A0
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileTerr], al
    mov     bl, al
    sub     bh, bh
    mov     al, [bp+var_prevConnCode]
    cmp     terrConnDataEtoW[bx], al
    jz      short loc_2073C
    cmp     al, 63h ; 'c'
    jz      short loc_2073C
loc_20788:
    mov     [bp+var_trackErrorCode], terr_mism
loc_2078D:
    cmp     [bp+var_trkColIndex], 0FFh
    jz      short loc_20797
    jmp     loc_2177A
loc_20797:
    mov     [bp+var_trkColIndex], 0
    jmp     loc_21786
    ; align 2
    db 144
loc_207A0:
    inc     [bp+var_trkRowIndex]
loc_207A4:
    cmp     [bp+var_trkRowIndex], 1Eh
    jge     short loc_207B6
    mov     [bp+var_prevConnCode], 63h ; 'c'
    mov     [bp+var_trkColIndex], 0
    jmp     short loc_2074D
loc_207B6:
    mov     [bp+var_trkColIndex], 0
    jmp     short loc_20812
    ; align 2
    db 144
loc_207BE:
    mov     bl, [bp+var_tileTerr]
    sub     bh, bh
    mov     al, terrConnDataStoN[bx]
    mov     [bp+var_prevConnCode], al
    inc     [bp+var_trkRowIndex]
loc_207CF:
    cmp     [bp+var_trkRowIndex], 1Eh
    jge     short loc_2080E
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileTerr], al
    mov     bl, al
    sub     bh, bh
    mov     al, [bp+var_prevConnCode]
    cmp     terrConnDataNtoS[bx], al
    jz      short loc_207BE
    cmp     al, 63h ; 'c'
    jz      short loc_207BE
    jmp     loc_20788
    ; align 2
    db 144
loc_2080E:
    inc     [bp+var_trkColIndex]
loc_20812:
    cmp     [bp+var_trkColIndex], 1Eh
    jge     short loc_20824
    mov     [bp+var_prevConnCode], 63h ; 'c'
    mov     [bp+var_trkRowIndex], 0
    jmp     short loc_207CF
loc_20824:
    mov     [bp+var_trkRowIndex], 0
    jmp     loc_20956
loc_2082C:
    mov     track_angle, 0
loc_20832:
    cmp     [bp+var_sfCount], 0
    jz      short loc_2087A
    mov     [bp+var_trackErrorCode], many_sf
    jmp     loc_2078D
    ; align 2
    db 144
loc_20842:
    mov     track_angle, 200h
    jmp     short loc_20832
loc_2084A:
    mov     track_angle, 100h
    jmp     short loc_20832
loc_20852:
    mov     track_angle, 300h
    jmp     short loc_20832
loc_2085A:
    cmp     ax, 94h ; 'î'
    jz      short loc_20842
    cmp     ax, 95h ; 'ï'
    jz      short loc_2084A
    cmp     ax, 96h ; 'ñ'
    jz      short loc_20852
    cmp     ax, 0B3h ; '≥'
    jz      short loc_20842
    cmp     ax, 0B4h ; '¥'
    jz      short loc_2084A
    cmp     ax, 0B5h ; 'µ'
loc_20876:
    jz      short loc_20852
    jmp     short loc_208BB
loc_2087A:
    mov     al, [bp+var_trkColIndex]
    mov     startcol2, al
    mov     al, [bp+var_trkRowIndex]
    mov     startrow2, al
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileTerr], al
    cmp     al, 6           ; hilltop
    jnz     short loc_208B2
    mov     hillFlag, 1
    jmp     short loc_208B7
loc_208B2:
    mov     hillFlag, 0
loc_208B7:
    inc     [bp+var_sfCount]
loc_208BB:
    inc     [bp+var_trkColIndex]
loc_208BF:
    cmp     [bp+var_trkColIndex], 1Eh
    jl      short loc_208C9
    jmp     loc_20952
loc_208C9:
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, trackrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileElem], al
    cmp     al, 0FDh ; '˝'  ; <filler
    jb      short loc_208F3
    mov     [bp+var_tileElem], 0
loc_208F3:
    cmp     [bp+var_tileElem], 0B6h ; '∂'
    jb      short loc_20919
    mov     [bp+var_tileElem], 4
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, trackrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td14_elem_map_main
    mov     byte ptr es:[bx], 4
loc_20919:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    cmp     ax, 93h ; 'ì'
    jnz     short loc_20926
    jmp     loc_2082C
loc_20926:
    jbe     short loc_2092B
    jmp     loc_2085A
loc_2092B:
    cmp     ax, 1
    jnz     short loc_20933
    jmp     loc_2082C
loc_20933:
    cmp     ax, 86h ; 'Ü'
    jnz     short loc_2093B
    jmp     loc_2082C
loc_2093B:
    cmp     ax, 87h ; 'á'
    jnz     short loc_20943
    jmp     loc_20842
loc_20943:
    cmp     ax, 88h ; 'à'
    jnz     short loc_2094B
    jmp     loc_2084A
loc_2094B:
    cmp     ax, 89h ; 'â'
    jmp     loc_20876
    ; align 2
    db 144
loc_20952:
    inc     [bp+var_trkRowIndex]
loc_20956:
    cmp     [bp+var_trkRowIndex], 1Eh
    jge     short loc_20966
    mov     [bp+var_trkColIndex], 0
    jmp     loc_208BF
    ; align 2
    db 144
loc_20966:
    cmp     [bp+var_sfCount], 0
    jnz     short loc_20976
    mov     [bp+var_trackErrorCode], no_sf
    jmp     loc_2078D
    ; align 2
    db 144
loc_20976:
    mov     track_pieces_counter, 0
    mov     [bp+var_746], 0
    mov     byte_45635, 0
    mov     byte_4616E, 0
    mov     [bp+var_3A8], 0
    mov     [bp+var_AE8], 0
    sub     si, si
loc_20997:
    mov     [bp+si+var_738], 0
    mov     ax, si
    shl     ax, 1
    mov     [bp+var_AEA], ax
    mov     bx, ax
    add     bx, word ptr td01_track_file_cpy
    mov     es, word ptr td01_track_file_cpy+2
    mov     word ptr es:[bx], 0FFFFh
    mov     bx, [bp+var_AEA]
    add     bx, word ptr td02_penalty_related
    mov     es, word ptr td02_penalty_related+2
    mov     word ptr es:[bx], 0FFFFh
    inc     si
    cmp     si, 385h
    jl      short loc_20997
    mov     al, startcol2
    mov     [bp+var_trkColIndex], al
    mov     al, startrow2
    mov     [bp+var_trkRowIndex], al
    mov     ax, track_angle
    mov     [bp+var_trackDirection], ax
    mov     [bp+var_prevConnCode], 0
    mov     [bp+var_3AC], 0FFFFh
loc_209E9:
    mov     [bp+var_2], 0
    cmp     [bp+var_trkColIndex], 0
    jl      short loc_20A0C
    cmp     [bp+var_trkRowIndex], 0
    jl      short loc_20A0C
    cmp     [bp+var_trkColIndex], 1Dh
    jg      short loc_20A0C
    cmp     [bp+var_trkRowIndex], 1Dh
    jg      short loc_20A0C
    jmp     loc_20AC2
loc_20A0C:
    cmp     [bp+var_746], 0
    jnz     short loc_20A16
    jmp     loc_20F20
loc_20A16:
    dec     [bp+var_746]
    mov     al, [bp+var_746]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_tcompPtr2L]
    mov     dx, [bp+var_tcompPtr2H]
    mov     word ptr [bp+var_MinternalTOI1], ax
    mov     word ptr [bp+var_MinternalTOI1+2], dx
    les     bx, [bp+var_MinternalTOI1]
    mov     al, es:[bx]
    mov     [bp+var_trkColIndex], al
    mov     al, es:[bx+1]
    mov     [bp+var_trkRowIndex], al
    mov     al, es:[bx+2]
    mov     [bp+var_tileElem], al
    mov     al, es:[bx+3]
    mov     [bp+var_subTOIBlock], al
    mov     al, es:[bx+4]
    mov     [bp+var_MconnStatus], al
    mov     al, es:[bx+0Bh]
    mov     [bp+var_prevConnCode], al
    mov     ax, es:[bx+0Ch]
    mov     [bp+var_3AC], ax
    mov     al, es:[bx+5]
    mov     [bp+var_3A8], al
    mov     al, es:[bx+6]
    mov     [bp+var_MprevColIndex], al
    mov     al, es:[bx+7]
    mov     [bp+var_MprevRowIndex], al
    mov     al, es:[bx+8]
    mov     [bp+var_MprevTileElem], al
    mov     al, es:[bx+9]
    mov     [bp+var_3AA], al
    mov     al, es:[bx+0Ah]
    mov     [bp+var_MprevConnStatus], al
    mov     [bp+var_2], 1
loc_20AA8:
    cmp     [bp+var_2], 0
    jnz     short loc_20AB1
    jmp     loc_209E9
loc_20AB1:
    cmp     [bp+var_4], 1
    ja      short loc_20ABA
    jmp     loc_20F6A
loc_20ABA:
    mov     [bp+var_trackErrorCode], long_jump
    jmp     loc_2078D
loc_20AC2:
    mov     al, [bp+var_trkColIndex]
    cbw
    mov     [bp+var_AEA], ax
    mov     al, [bp+var_trkRowIndex]
    cbw
    shl     ax, 1
    mov     [bp+var_AEC], ax
    mov     bx, ax
    mov     bx, trackrows[bx]
    add     bx, [bp+var_AEA]
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileElem], al
    mov     bx, [bp+var_AEC]
    mov     bx, terrainrows[bx]
    add     bx, [bp+var_AEA]
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileTerr], al
    cmp     [bp+var_tileElem], 0
    jz      short loc_20B30
    or      al, al
    jz      short loc_20B30
    cmp     al, 7
    jb      short loc_20B30
    cmp     al, 0Bh
    jnb     short loc_20B30
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    push    ax
    mov     al, [bp+var_tileTerr]
    push    ax
    push    cs
    call near ptr subst_hillroad_track
    add     sp, 4
    mov     [bp+var_tileElem], al
loc_20B30:
    cmp     [bp+var_tileElem], 0FDh ; '˝'
    jnb     short loc_20B39
    jmp     loc_20C12
loc_20B39:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    cmp     ax, 0FDh ; '˝'
    jz      short loc_20B76
    cmp     ax, 0FEh ; '˛'
    jz      short loc_20BA2
    cmp     ax, 0FFh
    jnz     short loc_20B50
    jmp     loc_20BD4
loc_20B50:
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, trackrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td14_elem_map_main
    mov     es, word ptr td14_elem_map_main+2
    mov     al, es:[bx]
    mov     [bp+var_tileElem], al
    jmp     loc_20C2E
    ; align 2
    db 144
loc_20B76:
    dec     [bp+var_trkColIndex]
    dec     [bp+var_trkRowIndex]
    mov     ax, [bp+var_trackDirection]
    or      ax, ax
    jz      short loc_20B96
    cmp     ax, 100h
    jz      short loc_20C02
    cmp     ax, 200h
    jz      short loc_20C02
    cmp     ax, 300h
    jz      short loc_20B9C
    jmp     short loc_20B50
loc_20B96:
    mov     [bp+var_tileEntryPoint], 0Ch
    jmp     short loc_20B50
loc_20B9C:
    mov     [bp+var_tileEntryPoint], 9
    jmp     short loc_20B50
loc_20BA2:
    dec     [bp+var_trkRowIndex]
    mov     ax, [bp+var_trackDirection]
    or      ax, ax
    jz      short loc_20BBE
    cmp     ax, 100h
    jz      short loc_20BC4
    cmp     ax, 200h
    jz      short loc_20C02
    cmp     ax, 300h
    jz      short loc_20BCC
    jmp     short loc_20B50
loc_20BBE:
    mov     [bp+var_tileEntryPoint], 0Bh
    jmp     short loc_20B50
loc_20BC4:
    mov     [bp+var_tileEntryPoint], 6
    jmp     short loc_20B50
    ; align 4
    db 144
    db 144
loc_20BCC:
    mov     [bp+var_tileEntryPoint], 7
    jmp     loc_20B50
    ; align 2
    db 144
loc_20BD4:
    dec     [bp+var_trkColIndex]
    mov     ax, [bp+var_trackDirection]
    or      ax, ax
    jz      short loc_20BF2
    cmp     ax, 100h
    jz      short loc_20C02
    cmp     ax, 200h
    jz      short loc_20BFA
    cmp     ax, 300h
    jz      short loc_20C0A
    jmp     loc_20B50
    ; align 2
    db 144
loc_20BF2:
    mov     [bp+var_tileEntryPoint], 0Ah
    jmp     loc_20B50
    ; align 2
    db 144
loc_20BFA:
    mov     [bp+var_tileEntryPoint], 5
    jmp     loc_20B50
    ; align 2
    db 144
loc_20C02:
    mov     [bp+var_tileEntryPoint], 0
    jmp     loc_20B50
    ; align 2
    db 144
loc_20C0A:
    mov     [bp+var_tileEntryPoint], 8
    jmp     loc_20B50
    ; align 2
    db 144
loc_20C12:
    mov     ax, [bp+var_trackDirection]
    or      ax, ax
    jz      short loc_20C2A
    cmp     ax, 100h
    jz      short loc_20C48
    cmp     ax, 200h
    jz      short loc_20C42
    cmp     ax, 300h
    jz      short loc_20C4E
    jmp     short loc_20C2E
loc_20C2A:
    mov     [bp+var_tileEntryPoint], 2
loc_20C2E:
    cmp     [bp+var_4], 0
    jnz     short loc_20C54
    cmp     [bp+var_tileEntryPoint], 0
    jnz     short loc_20C54
    mov     [bp+var_trackErrorCode], int_err
    jmp     loc_2078D
loc_20C42:
    mov     [bp+var_tileEntryPoint], 1
    jmp     short loc_20C2E
loc_20C48:
    mov     [bp+var_tileEntryPoint], 4
    jmp     short loc_20C2E
loc_20C4E:
    mov     [bp+var_tileEntryPoint], 3
    jmp     short loc_20C2E
loc_20C54:
    mov     [bp+var_2], 0
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1           ; *14
    mov     ax, word ptr trkObjectList.ss_trkObjInfoPtr[bx]
    mov     [bp+var_ptrTOInfo], ax
    or      ax, ax
    jnz     short loc_20C78
    jmp     loc_20E82
loc_20C78:
    sub     si, si
    jmp     loc_20E3A
    ; align 2
    db 144
loc_20C7E:
    mov     [bp+var_connCheckFlag], 0
    jmp     short loc_20CA2
    ; align 2
    db 144
loc_20C86:
    mov     bx, [bp+var_ptrCurrTOInfo]
    mov     al, [bp+var_tileEntryPoint]
    cmp     [bx+TRKOBJINFO.si_exitPoint], al
    jnz     short loc_20CA2
    mov     al, [bp+var_prevConnCode]
    cmp     [bx+TRKOBJINFO.si_exitType], al
    jz      short loc_20C9D
    jmp     loc_20E79
loc_20C9D:
    mov     [bp+var_connCheckFlag], 1
loc_20CA2:
    cmp     [bp+var_connCheckFlag], 0
    jge     short loc_20CAC
    jmp     loc_20D48
loc_20CAC:
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, trackrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, bp
    cmp     byte ptr [bx-738h], 0; ??
    jz      short loc_20D48
    sub     di, di
    jmp     short loc_20D0E
    ; align 2
    db 144
loc_20CCE:
    mov     [bp+var_connCheckFlag], 0FFh
    mov     ax, [bp+var_3AC]
    shl     ax, 1
    add     ax, word ptr td01_track_file_cpy
    mov     dx, word ptr td01_track_file_cpy+2
    mov     word ptr [bp+var_AF0], ax
    mov     word ptr [bp+var_AF0+2], dx
    les     bx, [bp+var_AF0]
    cmp     word ptr es:[bx], 0FFFFh
    jz      short loc_20D01
    mov     bx, [bp+var_3AC]
    shl     bx, 1
    add     bx, word ptr td02_penalty_related
    mov     es, word ptr td02_penalty_related+2
loc_20D01:
    mov     es:[bx], di
    or      di, di
    jnz     short loc_20D0D
    mov     [bp+var_AE8], 1
loc_20D0D:
    inc     di
loc_20D0E:
    cmp     track_pieces_counter, di
    jle     short loc_20D48
    les     bx, td21_col_from_path
    mov     al, [bp+var_trkColIndex]
    cmp     es:[bx+di], al
    jnz     short loc_20D0D
    les     bx, td22_row_from_path
    mov     al, [bp+var_trkRowIndex]
    cmp     es:[bx+di], al
    jnz     short loc_20D0D
    mov     ax, si
    cmp     [bp+di+var_AD4], al
    jnz     short loc_20D0D
    mov     al, [bp+var_connCheckFlag]
    cmp     [bp+di+var_398], al
    jz      short loc_20CCE
    mov     [bp+var_trackErrorCode], wrong_way
    jmp     loc_2078D
loc_20D48:
    cmp     [bp+var_connCheckFlag], 0
    jge     short loc_20D52
    jmp     loc_20E39
loc_20D52:
    cmp     [bp+var_2], 0
    jnz     short loc_20D6A
    mov     ax, si
    mov     [bp+var_subTOIBlock], al
    mov     al, [bp+var_connCheckFlag]
    mov     [bp+var_MconnStatus], al
    jmp     loc_20E36
    ; align 2
    db 144
loc_20D6A:
    cmp     [bp+var_746], 40h ; '@'
    jnz     short loc_20D7A
    mov     [bp+var_trackErrorCode], many_path
    jmp     loc_2078D
    ; align 2
    db 144
loc_20D7A:
    mov     al, [bp+var_746]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_tcompPtr2L]
    mov     dx, [bp+var_tcompPtr2H]
    mov     word ptr [bp+var_MinternalTOI1], ax
    mov     word ptr [bp+var_MinternalTOI1+2], dx
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_trkColIndex]
    mov     es:[bx], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_trkRowIndex]
    mov     es:[bx+1], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_tileElem]
    mov     es:[bx+2], al
    les     bx, [bp+var_MinternalTOI1]
    mov     ax, si
    mov     es:[bx+3], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_connCheckFlag]
    mov     es:[bx+4], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_prevConnCode]
    mov     es:[bx+0Bh], al
    les     bx, [bp+var_MinternalTOI1]
    mov     ax, [bp+var_3AC]
    mov     es:[bx+0Ch], ax
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_3A8]
    mov     es:[bx+5], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_MprevColIndex]
    mov     es:[bx+6], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_MprevRowIndex]
    mov     es:[bx+7], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_MprevTileElem]
    mov     es:[bx+8], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_3AA]
    mov     es:[bx+9], al
    les     bx, [bp+var_MinternalTOI1]
    mov     al, [bp+var_MprevConnStatus]
    mov     es:[bx+0Ah], al
    inc     [bp+var_746]
loc_20E36:
    inc     [bp+var_2]
loc_20E39:
    inc     si
loc_20E3A:
    mov     bx, [bp+var_ptrTOInfo]
    mov     al, [bx+TRKOBJINFO.si_noOfBlocks]
    sub     ah, ah
    cmp     ax, si
    jbe     short loc_20E82
    mov     [bp+var_connCheckFlag], 0FFh
    mov     ax, bx
    mov     cx, si
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    shl     cx, 1
    add     cx, dx
    shl     cx, 1           ; cx = si*14
    add     ax, cx
    mov     [bp+var_ptrCurrTOInfo], ax
    mov     bx, ax
    mov     al, [bp+var_tileEntryPoint]
    cmp     [bx+TRKOBJINFO.si_entryPoint], al
    jz      short loc_20E6E
    jmp     loc_20C86
loc_20E6E:
    mov     al, [bp+var_prevConnCode]
    cmp     [bx+TRKOBJINFO.si_entryType], al
    jnz     short loc_20E79
    jmp     loc_20C7E
loc_20E79:
    mov     [bp+var_trackErrorCode], elem_mism
    jmp     loc_2078D
    ; align 2
    db 144
loc_20E82:
    cmp     [bp+var_2], 0
    jz      short loc_20E8B
    jmp     loc_20AA8
loc_20E8B:
    cmp     [bp+var_prevConnCode], 1
    jz      short loc_20E94
    jmp     loc_20A0C
loc_20E94:
    cmp     [bp+var_4], 2
    jb      short loc_20E9D
    jmp     loc_20A0C
loc_20E9D:
    cmp     [bp+var_3A8], 2
    jnb     short loc_20EAC
    mov     [bp+var_trackErrorCode], no_runway
    jmp     loc_2078D
loc_20EAC:
    inc     [bp+var_3A8]
    inc     [bp+var_4]
    mov     ax, [bp+var_trackDirection]
    or      ax, ax
    jz      short loc_20ECC
    cmp     ax, 100h
    jz      short loc_20EF6
    cmp     ax, 200h
    jz      short loc_20EE4
    cmp     ax, 300h
    jz      short loc_20F08
    jmp     loc_209E9
loc_20ECC:
    mov     al, [bp+var_MprevColIndex]
    mov     [bp+var_trkColIndex], al
    mov     al, [bp+var_MprevRowIndex]
    sub     al, [bp+var_4]
    dec     al
loc_20EDC:
    mov     [bp+var_trkRowIndex], al
    jmp     loc_209E9
    ; align 2
    db 144
loc_20EE4:
    mov     al, [bp+var_MprevColIndex]
    mov     [bp+var_trkColIndex], al
    mov     al, [bp+var_MprevRowIndex]
    add     al, [bp+var_4]
    inc     al
    jmp     short loc_20EDC
loc_20EF6:
    mov     al, [bp+var_MprevRowIndex]
    mov     [bp+var_trkRowIndex], al
    mov     al, [bp+var_MprevColIndex]
    add     al, [bp+var_4]
    inc     al
    jmp     short loc_20F18
loc_20F08:
    mov     al, [bp+var_MprevRowIndex]
    mov     [bp+var_trkRowIndex], al
    mov     al, [bp+var_MprevColIndex]
    sub     al, [bp+var_4]
    dec     al
loc_20F18:
    mov     [bp+var_trkColIndex], al
    jmp     loc_209E9
    ; align 2
    db 144
loc_20F20:
    cmp     [bp+var_AE8], 0
    jnz     short loc_20F30
    mov     [bp+var_trackErrorCode], no_path
    jmp     loc_2078D
    ; align 2
    db 144
loc_20F30:
    mov     al, startcol2
    mov     byte_45D90, al
    mov     al, startrow2
    mov     byte_45E16, al
    mov     ax, track_pieces_counter
    cwd
    mov     cx, 3
    idiv    cx
    mov     si, ax
    cmp     si, 40h ; '@'
    jle     short loc_20F4F
    mov     si, 40h ; '@'
loc_20F4F:
    mov     ax, si
    mov     byte_4616E, al
    sub     si, si
loc_20F56:
    mov     [bp+si+var_AD4], 0
    inc     si
    cmp     si, 385h
    jl      short loc_20F56
    sub     di, di
    sub     si, si
    jmp     loc_21688
    ; align 2
    db 144
loc_20F6A:
    mov     [bp+var_4], 0
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, trackrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, bp
    mov     byte ptr [bx-738h], 1
    mov     bx, track_pieces_counter
    add     bx, bp
    mov     al, [bp+var_subTOIBlock]
    mov     [bx-0AD4h], al
    mov     bx, track_pieces_counter
    add     bx, bp
    mov     al, [bp+var_MconnStatus]
    mov     [bx-398h], al
    cmp     [bp+var_3AC], 0FFFFh
    jz      short loc_20FE0
    mov     ax, [bp+var_3AC]
    shl     ax, 1
    add     ax, word ptr td01_track_file_cpy
    mov     dx, word ptr td01_track_file_cpy+2
    mov     word ptr [bp+var_AF0], ax
    mov     word ptr [bp+var_AF0+2], dx
    les     bx, [bp+var_AF0]
loc_20FC6:
    cmp     word ptr es:[bx], 0FFFFh
    jz      short loc_20FDA
    mov     bx, [bp+var_3AC]
    shl     bx, 1
    add     bx, word ptr td02_penalty_related
    mov     es, word ptr td02_penalty_related+2
loc_20FDA:
    mov     ax, track_pieces_counter
    mov     es:[bx], ax
loc_20FE0:
    mov     ax, track_pieces_counter
    mov     [bp+var_3AC], ax
    mov     bx, ax
    add     bx, word ptr td21_col_from_path
    mov     es, word ptr td21_col_from_path+2
    mov     al, [bp+var_trkColIndex]
    mov     es:[bx], al
    mov     bx, track_pieces_counter
    add     bx, word ptr td22_row_from_path
    mov     es, word ptr td22_row_from_path+2
    mov     al, [bp+var_trkRowIndex]
    mov     es:[bx], al
loc_2100B:
    mov     bx, track_pieces_counter
    add     bx, word ptr trackdata18
    mov     es, word ptr trackdata18+2
    mov     al, [bp+var_MconnStatus]
    mov     cl, 4           ; high nibble
    shl     al, cl
    add     al, [bp+var_subTOIBlock]
    mov     es:[bx], al
    mov     bx, track_pieces_counter
    add     bx, word ptr td17_trk_elem_ordered
    mov     es, word ptr td17_trk_elem_ordered+2
    mov     al, [bp+var_tileElem]
    mov     es:[bx], al
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
loc_21047:
    shl     bx, 1
    mov     ax, word ptr trkObjectList.ss_trkObjInfoPtr[bx]
    mov     [bp+var_ptrTOInfo], ax
    mov     al, [bp+var_subTOIBlock]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_ptrTOInfo]
    mov     [bp+var_ptrCurrTOInfo], ax
    mov     bx, ax
    mov     al, [bx+TRKOBJINFO.si_opp3]
    mov     [bp+var_74C], al
    or      al, al
    jnz     short loc_21080
    inc     [bp+var_3A8]
    jmp     loc_21367
    ; align 2
    db 144
loc_21080:
    cmp     [bp+var_74C], 0FFh
loc_21085:
    jnz     short loc_2108A
    jmp     loc_21362
loc_2108A:
    cmp     [bp+var_3A8], 3
    ja      short loc_21094
    jmp     loc_21362
loc_21094:
    cmp     byte_45635, 30h ; '0'
    jnz     short loc_2109E
    jmp     loc_21362
loc_2109E:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     ax, word ptr trkObjectList.ss_trkObjInfoPtr[bx]
    mov     [bp+var_ptrTOInfo], ax
    mov     al, [bp+var_subTOIBlock]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_ptrTOInfo]
    mov     [bp+var_ptrCurrTOInfo], ax
    mov     bx, ax
    mov     al, [bx+TRKOBJINFO.si_opp3]
    mov     [bp+var_74C], al
    mov     al, [bp+var_MprevTileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     ax, word ptr trkObjectList.ss_trkObjInfoPtr[bx]
    mov     [bp+var_ptrTOInfo], ax
    mov     al, [bp+var_3AA]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_ptrTOInfo]
    mov     [bp+var_ptrCurrTOInfo], ax
    cmp     [bp+var_MprevConnStatus], 0
    jz      short loc_21122
    mov     bx, ax
    cmp     word ptr [bx+0Ah], 0
    jz      short loc_21126
    mov     ax, [bx+0Ah]
    jmp     short loc_21129
loc_21122:
    mov     bx, [bp+var_ptrCurrTOInfo]
loc_21126:
    mov     ax, [bx+TRKOBJINFO.si_cameraDataOffset]
loc_21129:
    mov     [bp+var_ADE], ax
    mov     [bp+var_ADC], ds
    cmp     [bp+var_MprevConnStatus], 0
    jz      short loc_21156
    mov     bx, [bp+var_ptrCurrTOInfo]
    mov     al, [bx+TRKOBJINFO.si_arrowType]
    sub     ah, ah
    shl     ax, 1
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_ADE]
    mov     dx, ds
    add     ax, 0Ch
    jmp     short loc_21174
loc_21156:
    mov     bx, [bp+var_ptrCurrTOInfo]
loc_2115A:
    mov     al, [bx+TRKOBJINFO.si_arrowType]
    sub     ah, ah
    shl     ax, 1
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_ADE]
loc_2116D:
    mov     dx, [bp+var_ADC]
    add     ax, 6
loc_21174:
    push    si
    push    di
    lea     di, [bp+var_ADA]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    movsw
loc_21182:
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    cmp     [bp+var_MconnStatus], 0
    jz      short loc_2119C
    mov     al, [bp+var_74C]
    cbw
    mov     bx, ax
loc_21195:
    mov     al, byte_3E724[bx]
    jmp     short loc_211A7
    ; align 2
    db 144
loc_2119C:
    mov     al, [bp+var_74C]
    cbw
    mov     bx, ax
    mov     al, byte_3E71E[bx]
loc_211A7:
    mov     [bp+var_74C], al
    mov     bx, [bp+var_ptrCurrTOInfo]
    mov     ax, [bx+TRKOBJINFO.si_arrowOrient]
    mov     [bp+var_trackDirection], ax
    cmp     ax, 100h
    jz      short loc_21214
    cmp     ax, 200h
    jz      short loc_211FE
    cmp     ax, 300h
    jnz     short loc_211DE
    mov     ax, [bp+var_ADA]
    mov     [bp+var_3A2], ax
    mov     ax, [bp+var_AD6]
    neg     ax
    mov     [bp+var_ADA], ax
    mov     ax, [bp+var_3A2]
loc_211DA:
    mov     [bp+var_AD6], ax
loc_211DE:
    cmp     [bp+var_MprevConnStatus], 0
    jz      short loc_2122C
    mov     al, byte_45635
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, word ptr td08_direction_related
    mov     es, word ptr td08_direction_related+2
    mov     ax, [bp+var_trackDirection]
    xor     ah, 2
    jmp     short loc_2123F
    ; align 2
    db 144
loc_211FE:
    mov     ax, [bp+var_AD6]
    neg     ax
    mov     [bp+var_AD6], ax
    mov     ax, [bp+var_ADA]
    neg     ax
    mov     [bp+var_ADA], ax
    jmp     short loc_211DE
loc_21214:
    mov     ax, [bp+var_ADA]
    mov     [bp+var_3A2], ax
    mov     ax, [bp+var_AD6]
    mov     [bp+var_ADA], ax
    mov     ax, [bp+var_3A2]
    neg     ax
    jmp     short loc_211DA
loc_2122C:
    mov     al, byte_45635
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, word ptr td08_direction_related
    mov     es, word ptr td08_direction_related+2
    mov     ax, [bp+var_trackDirection]
loc_2123F:
    mov     es:[bx], ax
    mov     al, byte_45635
    cbw
    mov     bx, ax
    add     bx, word ptr trackdata23
    mov     es, word ptr trackdata23+2
    mov     al, [bp+var_74C]
    mov     es:[bx], al
    mov     al, [bp+var_MprevRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_MprevColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    cmp     byte ptr es:[bx], 6
    jnz     short loc_2127E
    add     [bp+var_AD8], 1C2h
loc_2127E:
    mov     al, byte_45635
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    mov     ax, [bp+var_AD8]
    mov     es:[bx+2], ax
    mov     al, [bp+var_MprevTileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jz      short loc_212C2
    mov     al, [bp+var_MprevRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackpos[bx]
    jmp     short loc_212CF
loc_212C2:
    mov     al, [bp+var_MprevRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
loc_212CF:
    add     ax, [bp+var_AD6]
    mov     cx, ax
    mov     al, byte_45635
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    mov     es:[bx+4], cx
    mov     al, [bp+var_MprevTileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 2
    jz      short loc_21314
    mov     al, [bp+var_MprevColIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, (trackpos2+2)[bx]
    jmp     short loc_21320
loc_21314:
    mov     al, [bp+var_MprevColIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
loc_21320:
    add     ax, [bp+var_ADA]
    mov     cx, ax
    mov     al, byte_45635
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, word ptr td10_track_check_rel
    mov     es, word ptr td10_track_check_rel+2
    mov     es:[bx], cx
    mov     al, [bp+var_MprevRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, trackrows[bx]
    mov     al, [bp+var_MprevColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr trackdata19
    mov     es, word ptr trackdata19+2
    mov     al, byte_45635
    mov     es:[bx], al
    inc     byte_45635
loc_21362:
    mov     [bp+var_3A8], 0
loc_21367:
    inc     track_pieces_counter
    cmp     track_pieces_counter, 385h
    jnz     short loc_2137C
    mov     [bp+var_trackErrorCode], many_elem
    jmp     loc_2078D
    ; align 2
    db 144
loc_2137C:
    mov     al, [bp+var_tileElem]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     ax, word ptr trkObjectList.ss_trkObjInfoPtr[bx]
    mov     [bp+var_ptrTOInfo], ax
    mov     al, [bp+var_subTOIBlock]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_ptrTOInfo]
    mov     [bp+var_ptrCurrTOInfo], ax
    cmp     [bp+var_MconnStatus], 0
    jz      short loc_213C4
    mov     bx, ax
    mov     al, [bx+TRKOBJINFO.si_entryPoint]
    mov     [bp+var_McurrExitPoint], al
    mov     al, [bx+TRKOBJINFO.si_entryType]
    jmp     short loc_213D2
loc_213C4:
    mov     bx, [bp+var_ptrCurrTOInfo]
    mov     al, [bx+TRKOBJINFO.si_exitPoint]
    mov     [bp+var_McurrExitPoint], al
    mov     al, [bx+TRKOBJINFO.si_exitType]
loc_213D2:
    mov     [bp+var_prevConnCode], al
    mov     al, [bp+var_trkColIndex]
    mov     [bp+var_MprevColIndex], al
    mov     al, [bp+var_trkRowIndex]
    mov     [bp+var_MprevRowIndex], al
    mov     al, [bp+var_MconnStatus]
    mov     [bp+var_MprevConnStatus], al
    mov     al, [bp+var_subTOIBlock]
    mov     [bp+var_3AA], al
    mov     al, [bp+var_tileElem]
    mov     [bp+var_MprevTileElem], al
    mov     al, [bp+var_McurrExitPoint]
    sub     ah, ah
    sub     ax, 1
    cmp     ax, 0Bh
    jbe     short loc_2140C ; filler-ish
    jmp     loc_209E9
loc_2140C:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_2147C[bx]
loc_21414:
    dec     [bp+var_trkRowIndex]
loc_21418:
    mov     [bp+var_trackDirection], 0
    jmp     loc_209E9
loc_21420:
    dec     [bp+var_trkRowIndex]
    inc     [bp+var_trkColIndex]
    jmp     short loc_21418
loc_2142A:
    inc     [bp+var_trkRowIndex]
loc_2142E:
    dec     [bp+var_trkColIndex]
loc_21432:
    mov     [bp+var_trackDirection], 300h
loc_21437:
    jmp     loc_209E9
loc_2143A:
    inc     [bp+var_trkColIndex]
loc_2143E:
    inc     [bp+var_trkRowIndex]
loc_21442:
    mov     [bp+var_trackDirection], 200h
    jmp     loc_209E9
loc_2144A:
    inc     [bp+var_trkColIndex]
loc_2144E:
    add     [bp+var_trkRowIndex], 2
    jmp     short loc_21442
    ; align 2
    db 144
loc_21456:
    inc     [bp+var_trkColIndex]
loc_2145A:
    mov     [bp+var_trackDirection], 100h
    jmp     loc_209E9
loc_21462:
    inc     [bp+var_trkColIndex]
loc_21466:
    inc     [bp+var_trkRowIndex]
    jmp     short loc_2145A
loc_2146C:
    add     [bp+var_trkColIndex], 2
    jmp     short loc_2145A
    ; align 2
    db 144
loc_21474:
    add     [bp+var_trkColIndex], 2
    jmp     short loc_21466
    ; align 2
    db 144
off_2147C     dw offset loc_21414
    dw offset loc_2143E
    dw offset loc_21456
    dw offset loc_2142E
    dw offset loc_21420
    dw offset loc_2142A
    dw offset loc_21462
    dw offset loc_2146C
    dw offset loc_21474
    dw offset loc_2143A
    dw offset loc_2144E
    dw offset loc_2144A
    jmp     loc_209E9
    ; align 2
    db 144
loc_21498:
    mov     al, [bp+var_subTOIBlock]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, [bp+var_ptrCurrTOInfo]
    mov     ax, [bx+8]
loc_214B1:
    mov     [bp+var_ADE], ax
    mov     [bp+var_ADC], ds
    mov     al, [bp+var_subTOIBlock]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+var_ptrCurrTOInfo]
    mov     word ptr [bp+var_AF0], ax
    mov     bx, ax
    mov     al, [bx+5]
    sub     ah, ah
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, [bp+var_ADE]
    mov     dx, ds
    push    si
    push    di
    lea     di, [bp+var_ADA]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    movsw
    movsw
    movsw
    pop     ds
    pop     di
    pop     si
    mov     ax, [bx+6]
    mov     [bp+var_trackDirection], ax
    cmp     ax, 100h
    jz      short loc_21576
    cmp     ax, 200h
    jz      short loc_21560
    cmp     ax, 300h
    jnz     short loc_2152A
    mov     ax, [bp+var_ADA]
    mov     [bp+var_3A2], ax
    mov     ax, [bp+var_AD6]
    neg     ax
    mov     [bp+var_ADA], ax
    mov     ax, [bp+var_3A2]
loc_21526:
    mov     [bp+var_AD6], ax
loc_2152A:
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     bx, terrainrows[bx]
    mov     al, [bp+var_trkColIndex]
    cbw
    add     bx, ax
    add     bx, word ptr td15_terr_map_main
    mov     es, word ptr td15_terr_map_main+2
    cmp     byte ptr es:[bx], 6
    jnz     short loc_2158E
    mov     bx, di
    shl     bx, 1
    add     bx, word ptr trackdata7
    mov     es, word ptr trackdata7+2
    mov     word ptr es:[bx], 1C2h
    jmp     short loc_2159F
    ; align 2
    db 144
loc_21560:
    mov     ax, [bp+var_AD6]
    neg     ax
    mov     [bp+var_AD6], ax
    mov     ax, [bp+var_ADA]
    neg     ax
    mov     [bp+var_ADA], ax
    jmp     short loc_2152A
loc_21576:
    mov     ax, [bp+var_ADA]
    mov     [bp+var_3A2], ax
    mov     ax, [bp+var_AD6]
    mov     [bp+var_ADA], ax
    mov     ax, [bp+var_3A2]
    neg     ax
    jmp     short loc_21526
loc_2158E:
    mov     bx, di
    shl     bx, 1
    add     bx, word ptr trackdata7
    mov     es, word ptr trackdata7+2
    mov     word ptr es:[bx], 0
loc_2159F:
    mov     ax, di
    shl     ax, 1
    mov     word ptr [bp+var_AF0], ax
    mov     bx, ax
    add     bx, word ptr trackdata6
    mov     es, word ptr trackdata6+2
    mov     word ptr es:[bx], 0
    mov     ax, di
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     [bp+var_AEC], ax
    mov     bx, word ptr [bp+var_AF0]
    add     bx, word ptr trackdata7
loc_215CC:
    mov     es, word ptr trackdata7+2
    mov     ax, es:[bx]
    add     ax, [bp+var_AD8]
    mov     bx, [bp+var_AEC]
    add     bx, word ptr trackdata9
    mov     es, word ptr trackdata9+2
    mov     es:[bx+2], ax
    mov     bx, [bp+var_C]
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 1
    jz      short loc_21614
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackpos[bx]
    add     ax, [bp+var_AD6]
    mov     bx, [bp+var_AEC]
    jmp     short loc_2162F
loc_21614:
    mov     al, [bp+var_trkRowIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos[bx]
    add     ax, [bp+var_AD6]
    mov     bx, di
    mov     cx, bx
    shl     bx, 1
    add     bx, cx
    shl     bx, 1
loc_2162F:
    add     bx, word ptr trackdata9
    mov     es, word ptr trackdata9+2
    mov     es:[bx+4], ax
    mov     bx, [bp+var_C]
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    test    trkObjectList.ss_multiTileFlag[bx], 2
    jz      short loc_21660
    mov     al, [bp+var_trkColIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, (trackpos2+2)[bx]
    jmp     short loc_2166D
loc_21660:
    mov     al, [bp+var_trkColIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, trackcenterpos2[bx]
loc_2166D:
    add     ax, [bp+var_ADA]
    mov     bx, di
    mov     cx, bx
    shl     bx, 1
    add     bx, cx
    shl     bx, 1
    add     bx, word ptr trackdata9
    mov     es, word ptr trackdata9+2
    mov     es:[bx], ax
    inc     di
loc_21687:
    inc     si
loc_21688:
    mov     al, byte_4616E
    cbw
    mov     word ptr [bp+var_AF0], ax
    cmp     ax, si
    jg      short loc_21697
    jmp     loc_2176E
loc_21697:
    mov     ax, track_pieces_counter
    imul    si
    cwd
    mov     cx, word ptr [bp+var_AF0]
    idiv    cx
    mov     [bp+var_A], ax
    mov     bx, ax
    add     bx, word ptr td21_col_from_path
    mov     es, word ptr td21_col_from_path+2
    mov     al, es:[bx]
    mov     [bp+var_trkColIndex], al
    mov     bx, [bp+var_A]
    add     bx, word ptr td22_row_from_path
    mov     es, word ptr td22_row_from_path+2
    mov     al, es:[bx]
    mov     [bp+var_trkRowIndex], al
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, terrainrows[bx]
    mov     cx, ax
    mov     al, [bp+var_trkColIndex]
    cbw
    add     cx, ax
    add     cx, bp
    sub     cx, 0AD4h
    mov     [bp+var_AEC], cx
    mov     bx, cx
    cmp     byte ptr [bx], 0
    jnz     short loc_21687
    mov     byte ptr [bx], 1
    mov     bx, [bp+var_A]
    add     bx, word ptr td17_trk_elem_ordered
    mov     es, word ptr td17_trk_elem_ordered+2
    mov     al, es:[bx]
    sub     ah, ah
    mov     [bp+var_C], ax
    mov     bx, [bp+var_A]
    add     bx, word ptr trackdata18
    mov     es, word ptr trackdata18+2
    mov     al, es:[bx]
smart
    and     al, 0Fh         ; mask out the high nibble
nosmart
    mov     [bp+var_subTOIBlock], al
    mov     bx, [bp+var_A]
    add     bx, word ptr trackdata18
    mov     al, es:[bx]
smart
    and     al, 10h         ; 5th bit (low to high)
nosmart
    mov     [bp+var_connCheckFlag], al
    mov     bx, [bp+var_C]
    mov     ax, bx
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    mov     ax, word ptr trkObjectList.ss_trkObjInfoPtr[bx]
    mov     [bp+var_ptrCurrTOInfo], ax
    cmp     [bp+var_connCheckFlag], 0
    jnz     short loc_21747
    jmp     loc_21498
loc_21747:
    mov     al, [bp+var_subTOIBlock]
    sub     ah, ah
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
loc_21759:
    add     bx, [bp+var_ptrCurrTOInfo]
    mov     ax, [bx+0Ah]
    mov     [bp+var_AEA], ax
    or      ax, ax
    jnz     short loc_2176B
    jmp     loc_21498
loc_2176B:
    jmp     loc_214B1
loc_2176E:
    mov     ax, di
    mov     byte_4616E, al
    mov     [bp+var_trackErrorCode], 0
    jmp     short loc_217AE
loc_2177A:
    cmp     [bp+var_trkColIndex], 1Eh
    jnz     short loc_21786
    mov     [bp+var_trkColIndex], 1Dh
loc_21786:
    cmp     [bp+var_trkRowIndex], 0FFh
    jnz     short loc_21794
    mov     [bp+var_trkRowIndex], 0
    jmp     short loc_217A0
loc_21794:
    cmp     [bp+var_trkRowIndex], 1Eh
    jnz     short loc_217A0
    mov     [bp+var_trkRowIndex], 1Dh
loc_217A0:
    mov     al, [bp+var_trkColIndex]
    mov     byte_45D90, al
    mov     al, [bp+var_trkRowIndex]
    mov     byte_45E16, al
loc_217AE:
    push    [bp+var_tcompPtrH]
    push    [bp+var_tcompPtrL]
    call    mmgr_release
    add     sp, 4
loc_217BE:
    mov     al, [bp+var_trackErrorCode]
loc_217C2:
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
track_setup endp
load_opponent_data proc far
    var_F30 = word ptr -3888
    var_B2E = word ptr -2862
    var_B2C = word ptr -2860
    var_B2A = word ptr -2858
    var_B28 = word ptr -2856
    var_B26 = word ptr -2854
    var_B24 = word ptr -2852
    var_414 = word ptr -1044
    var_412 = word ptr -1042
    var_410 = word ptr -1040
    var_20E = word ptr -526
    var_20C = word ptr -524
    var_A = dword ptr -10
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
loc_217CB:
    mov     bp, sp
    sub     sp, 0F30h
    push    di
    push    si
loc_217D3:
    mov     al, gameconfig.game_opponenttype
loc_217D6:
    add     al, 30h ; '0'
    mov     byte ptr aOpp1+3, al
    mov     ax, offset aOpp1; "opp1"
    push    ax
    call    file_load_resfile
    add     sp, 2
    mov     [bp+var_B2E], ax
    mov     [bp+var_B2C], dx
    mov     ax, offset aNam ; "nam"
    push    ax
    push    dx
    push    [bp+var_B2E]
    call    locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset unk_46464
    push    ax
    call    copy_string
    add     sp, 6
    mov     ax, offset aPath; "path"
    push    ax
    push    [bp+var_B2C]
    push    [bp+var_B2E]
    call    locate_shape_alt
    add     sp, 6
    mov     [bp+var_414], ax
    mov     [bp+var_412], dx
    mov     ax, offset aSped; "sped"
    push    ax
    push    [bp+var_B2C]
    push    [bp+var_B2E]
    call    locate_shape_alt
    add     sp, 6
    mov     word ptr [bp+var_A], ax
    mov     word ptr [bp+var_A+2], dx
    sub     si, si
loc_21846:
    les     bx, [bp+var_A]
    mov     al, es:[bx+si]
    mov     oppnentSped[si], al
    inc     si
    cmp     si, 10h
    jl      short loc_21846
    mov     [bp+var_B26], 423Fh
    mov     [bp+var_B24], 0Fh
    mov     [bp+var_B28], 0
    sub     ax, ax
    mov     [bp+var_20C], ax
    mov     [bp+var_20E], ax
    mov     [bp+var_B2A], ax
    sub     si, si
loc_21878:
    mov     [bp+var_410], 0
    mov     bx, si
    shl     bx, 1
    add     bx, word ptr td01_track_file_cpy
    mov     es, word ptr td01_track_file_cpy+2
    mov     ax, es:[bx]
    mov     [bp+var_4], ax
    or      ax, ax
    jnz     short loc_218A2
    mov     [bp+var_2], 1
loc_21899:
    mov     [bp+var_410], 1
    jmp     short loc_218DA
    ; align 2
    db 144
loc_218A2:
    cmp     [bp+var_4], 0FFFFh
    jnz     short loc_218B0
    mov     [bp+var_2], 0
    jmp     short loc_21899
    ; align 2
    db 144
loc_218B0:
    cmp     [bp+var_B28], 0
    jz      short loc_218DA
    sub     di, di
    jmp     short loc_218D4
    ; align 2
    db 144
loc_218BC:
    mov     bx, di
    shl     bx, 1
    add     bx, bp
    cmp     [bx-0B20h], si
    jnz     short loc_218D3
    mov     [bp+var_2], 0
    mov     [bp+var_410], 1
loc_218D3:
    inc     di
loc_218D4:
    cmp     [bp+var_B28], di
    jg      short loc_218BC
loc_218DA:
    mov     bx, [bp+var_B28]
    inc     [bp+var_B28]
    shl     bx, 1
    add     bx, bp
    mov     [bx-0B20h], si
    les     bx, td17_trk_elem_ordered
    mov     bl, es:[bx+si]
    sub     bh, bh
    add     bx, word ptr [bp+var_A]
    mov     es, word ptr [bp+var_A+2]
    mov     al, es:[bx]
    sub     ah, ah
    inc     ax
    sub     dx, dx
    add     [bp+var_20E], ax
    adc     [bp+var_20C], dx
    cmp     [bp+var_410], dx
    jnz     short loc_21912
    jmp     loc_219FE
loc_21912:
    cmp     [bp+var_2], dx
    jnz     short loc_2191A
    jmp     loc_219A5
loc_2191A:
    mov     ax, [bp+var_B26]
    mov     dx, [bp+var_B24]
    cmp     [bp+var_20C], dx
    ja      short loc_219A5
    jb      short loc_21930
    cmp     [bp+var_20E], ax
    jnb     short loc_219A5
loc_21930:
    mov     bx, [bp+var_B28]
    inc     [bp+var_B28]
    shl     bx, 1
    add     bx, bp
    mov     word ptr [bx-0B20h], 0
    mov     ax, [bp+var_20E]
    mov     dx, [bp+var_20C]
    mov     [bp+var_B26], ax
    mov     [bp+var_B24], dx
    sub     di, di
    jmp     short loc_21978
    ; align 4
    db 144
    db 144
loc_21958:
    mov     ax, di
loc_2195A:
    shl     ax, 1
    mov     [bp+var_F30], ax
    mov     bx, ax
    add     bx, bp
    mov     ax, [bx-0B20h]
    mov     bx, [bp+var_F30]
    add     bx, word ptr trackdata3
    mov     es, word ptr trackdata3+2
    mov     es:[bx], ax
    inc     di
loc_21978:
    cmp     [bp+var_B28], di
    jg      short loc_21958
    mov     bx, [bp+var_B28]
    shl     bx, 1
    add     bx, word ptr trackdata3
    mov     es, word ptr trackdata3+2
loc_2198C:
    mov     word ptr es:[bx], 0
    mov     bx, [bp+var_B28]
    shl     bx, 1
    add     bx, word ptr trackdata3
    mov     es, word ptr trackdata3+2
    mov     word ptr es:[bx+2], 1
loc_219A5:
    cmp     [bp+var_B2A], 0
loc_219AA:
    jnz     short loc_219C2
loc_219AC:
    push    [bp+var_B2C]
    push    [bp+var_B2E]
    call    unload_resource
    add     sp, 4
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_219C2:
    dec     [bp+var_B2A]
    mov     ax, [bp+var_B2A]
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_F30], ax
    mov     bx, ax
    mov     si, [bx-20Ah]
    mov     ax, [bx-40Eh]
    mov     [bp+var_B28], ax
    mov     bx, [bp+var_B2A]
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    mov     ax, [bx-0F2Eh]
    mov     dx, [bx-0F2Ch]
    mov     [bp+var_20E], ax
    mov     [bp+var_20C], dx
    jmp     loc_21878
    ; align 2
    db 144
loc_219FE:
    mov     bx, si
    shl     bx, 1
    add     bx, word ptr td02_penalty_related
    mov     es, word ptr td02_penalty_related+2
    mov     ax, es:[bx]
    mov     [bp+var_6], ax
    cmp     ax, 0FFFFh
    jz      short loc_21A54
    mov     ax, [bp+var_B2A]
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_F30], ax
    mov     bx, ax
    mov     ax, [bp+var_6]
    mov     [bx-20Ah], ax
    mov     bx, [bp+var_F30]
loc_21A2E:
    mov     ax, [bp+var_B28]
    mov     [bx-40Eh], ax
    mov     bx, [bp+var_B2A]
    inc     [bp+var_B2A]
    shl     bx, 1
    shl     bx, 1
loc_21A42:
    add     bx, bp
    mov     ax, [bp+var_20E]
    mov     dx, [bp+var_20C]
    mov     [bx-0F2Eh], ax
    mov     [bx-0F2Ch], dx
loc_21A54:
    mov     si, [bp+var_4]
    jmp     loc_21878
load_opponent_data endp
subst_hillroad_track proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6
    arg_2 = byte ptr 8

    push    bp
    mov     bp, sp
    mov     al, [bp+arg_0]
    sub     ah, ah
    cmp     ax, 7
    jz      short loc_21A80
    cmp     ax, 8
    jz      short loc_21ABE
    cmp     ax, 9
    jnz     short loc_21A74
    jmp     loc_21AFE
loc_21A74:
    cmp     ax, 0Ah
    jnz     short loc_21A7C
    jmp     loc_21B3C
loc_21A7C:
    sub     ax, ax
    pop     bp
    retf
loc_21A80:
    mov     al, [bp+arg_2]
    sub     ah, ah
    cmp     ax, 4
    jz      short loc_21AA6
    cmp     ax, 0Eh
    jz      short loc_21AAC
    cmp     ax, 18h
    jz      short loc_21AB2
    cmp     ax, 27h ; '''
    jz      short loc_21AB8
    cmp     ax, 3Bh ; ';'
    jz      short loc_21AB8
    cmp     ax, 62h ; 'b'
    jz      short loc_21AB8
    jmp     short loc_21A7C
    ; align 2
    db 144
loc_21AA6:
    mov     ax, 0B6h ; '∂'
    jmp     loc_21B77
loc_21AAC:
    mov     ax, 0BAh ; '∫'
    jmp     loc_21B77
loc_21AB2:
    mov     ax, 0BEh ; 'æ'
    jmp     loc_21B77
loc_21AB8:
    mov     ax, 0C2h ; '¬'
    jmp     loc_21B77
loc_21ABE:
    mov     al, [bp+arg_2]
    sub     ah, ah
    cmp     ax, 5
    jz      short loc_21AE4
    cmp     ax, 0Fh
    jz      short loc_21AEA
    cmp     ax, 19h
    jz      short loc_21AF0
    cmp     ax, 24h ; '$'
    jz      short loc_21AF8
    cmp     ax, 38h ; '8'
    jz      short loc_21AF8
    cmp     ax, 5Fh ; '_'
    jz      short loc_21AF8
    jmp     short loc_21A7C
    ; align 2
    db 144
loc_21AE4:
    mov     ax, 0B7h ; '∑'
    jmp     loc_21B77
loc_21AEA:
    mov     ax, 0BBh ; 'ª'
    jmp     loc_21B77
loc_21AF0:
    mov     ax, 0BFh ; 'ø'
    jmp     loc_21B77
    ; align 4
    db 144
    db 144
loc_21AF8:
    mov     ax, 0C3h ; '√'
    jmp     short loc_21B77
    ; align 2
    db 144
loc_21AFE:
    mov     al, [bp+arg_2]
    sub     ah, ah
    cmp     ax, 4
    jz      short loc_21B24
    cmp     ax, 0Eh
    jz      short loc_21B2A
    cmp     ax, 18h
    jz      short loc_21B30
    cmp     ax, 26h ; '&'
    jz      short loc_21B36
    cmp     ax, 3Ah ; ':'
    jz      short loc_21B36
    cmp     ax, 61h ; 'a'
    jz      short loc_21B36
    jmp     loc_21A7C
loc_21B24:
    mov     ax, 0B8h ; '∏'
    jmp     short loc_21B77
    ; align 2
    db 144
loc_21B2A:
    mov     ax, 0BCh ; 'º'
    jmp     short loc_21B77
    ; align 2
    db 144
loc_21B30:
    mov     ax, 0C0h ; '¿'
    jmp     short loc_21B77
    ; align 2
    db 144
loc_21B36:
    mov     ax, 0C4h ; 'ƒ'
    pop     bp
    retf
    ; align 2
    db 144
loc_21B3C:
    mov     al, [bp+arg_2]
    sub     ah, ah
    cmp     ax, 5
    jz      short loc_21B62
    cmp     ax, 0Fh
    jz      short loc_21B68
    cmp     ax, 19h
    jz      short loc_21B6E
    cmp     ax, 25h ; '%'
    jz      short loc_21B74
    cmp     ax, 39h ; '9'
    jz      short loc_21B74
    cmp     ax, 60h ; '`'
    jz      short loc_21B74
    jmp     loc_21A7C
loc_21B62:
    mov     ax, 0B9h ; 'π'
    pop     bp
    retf
    ; align 2
    db 144
loc_21B68:
    mov     ax, 0BDh ; 'Ω'
    pop     bp
    retf
    ; align 2
    db 144
loc_21B6E:
    mov     ax, 0C1h ; '¡'
    pop     bp
    retf
    ; align 2
    db 144
loc_21B74:
    mov     ax, 0C5h ; '≈'
loc_21B77:
    pop     bp
    retf
subst_hillroad_track endp
seg004 ends
end
