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
    include seg031.inc
    include seg032.inc
    include seg033.inc
    include seg035.inc
    include seg036.inc
    include seg037.inc
    include seg038.inc
    include seg039.inc
    include dseg.inc
    include seg041.inc
seg034 segment byte public 'STUNTSC' use16
    assume cs:seg034
    assume es:nothing, ss:nothing, ds:dseg
    public file_load_shape2d_fatal
    public file_load_shape2d_nofatal
    public file_load_shape2d
    public file_load_shape2d_palmap_init
algn_3A9D5:
    ; align 2
    db 144
file_load_shape2d_fatal proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_shapename = word ptr 6

    push    bp
loc_3A9D7:
    mov     bp, sp
loc_3A9D9:
    mov     ax, 1
loc_3A9DC:
    push    ax
loc_3A9DD:
    push    [bp+arg_shapename]
loc_3A9E0:
    push    cs
loc_3A9E1:
    call near ptr file_load_shape2d
loc_3A9E4:
    add     sp, 4
    pop     bp
locret_3A9E8:
    retf
    ; align 2
    db 144
file_load_shape2d_fatal endp
file_load_shape2d_nofatal proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_3A9EB:
    mov     bp, sp
loc_3A9ED:
    sub     ax, ax
    push    ax
loc_3A9F0:
    push    [bp+arg_0]
    push    cs
loc_3A9F4:
    call near ptr file_load_shape2d
loc_3A9F7:
    add     sp, 4
loc_3A9FA:
    pop     bp
    retf
file_load_shape2d_nofatal endp
file_load_shape2d proc far
    var_strchar = byte ptr -128
    var_expandedsize = word ptr -126
    var_str = byte ptr -124
    var_mgaofs = word ptr -24
    var_mgaseg = word ptr -22
    var_counter = word ptr -20
    var_oldstrptr = word ptr -18
    var_mempages = dword ptr -16
    var_strptr = dword ptr -12
    var_memchunkofs = word ptr -4
    var_memchunkseg = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_shapename = word ptr 6
    arg_fatal = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 80h
    push    si
    push    [bp+arg_shapename]
    lea     ax, [bp+var_str]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    lea     ax, [bp+var_str]
    mov     word ptr [bp+var_strptr], ax
    jmp     short loc_3AA25
    ; align 2
    db 144
loc_3AA1C:
    cmp     [bp+var_strchar], 2Eh ; '.'
    jz      short loc_3AA31
loc_3AA22:
    inc     word ptr [bp+var_strptr]
loc_3AA25:
    mov     bx, word ptr [bp+var_strptr]
    mov     al, [bx]
loc_3AA2A:
    mov     [bp+var_strchar], al
    or      al, al
    jnz     short loc_3AA1C
loc_3AA31:
    mov     bx, word ptr [bp+var_strptr]
loc_3AA34:
    cmp     byte ptr [bx], 0
    jnz     short loc_3AA92
loc_3AA39:
    mov     [bp+var_counter], 0
    jmp     short loc_3AA53
loc_3AA40:
    lea     ax, [bp+var_str]
    push    ax
    call    file_find
    add     sp, 2
    or      ax, ax
    jnz     short _try_load_pvs
    inc     [bp+var_counter]
loc_3AA53:
    mov     bx, [bp+var_counter]
    shl     bx, 1
    mov     si, shapeexts[bx]
    cmp     byte ptr [si], 0
    jz      short _try_load_pvs
    mov     ax, word ptr [bp+var_strptr]
    mov     [bp+var_oldstrptr], ax
    push    si
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    lea     ax, [bp+var_str]
    push    ax
    call    mmgr_get_chunk_by_name
    add     sp, 2
    mov     [bp+var_memchunkofs], ax
    mov     [bp+var_memchunkseg], dx
    or      dx, ax
    jz      short loc_3AA40
_end_load_2dshape:
    mov     ax, [bp+var_memchunkofs]
    mov     dx, [bp+var_memchunkseg]
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_3AA92:
    lea     ax, [bp+var_str]
    push    ax
    call    mmgr_get_chunk_by_name
    add     sp, 2
    mov     [bp+var_memchunkofs], ax
    mov     [bp+var_memchunkseg], dx
    or      dx, ax
    jnz     short _end_load_2dshape
_try_load_pvs:
    push    word ptr [bp+var_strptr]
    lea     ax, [bp+var_strptr+2]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset a_pvs; ".PVS"
    push    ax
    lea     ax, [bp+var_strptr+2]
    push    ax              ; char *
    call    _stricmp
    add     sp, 4
    or      ax, ax
    jnz     short _try_load_xvs
    push    [bp+arg_fatal]
    lea     ax, [bp+var_str]
    push    ax
    call    file_decomp
    add     sp, 4
    mov     [bp+var_memchunkofs], ax
    mov     [bp+var_memchunkseg], dx
    or      ax, dx
    jz      short _end_load_2dshape
    push    dx
    push    [bp+var_memchunkofs]
    call    file_get_unflip_size
    add     sp, 4
    push    ax
    mov     ax, offset aUnflip_0; "UNFLIP"
    push    ax
    call    mmgr_alloc_pages
    add     sp, 4
    mov     word ptr [bp+var_mempages], ax
    mov     word ptr [bp+var_mempages+2], dx
    push    dx
    push    ax
    push    [bp+var_memchunkseg]
    push    [bp+var_memchunkofs]
    call    file_unflip_shape2d
    add     sp, 8
    push    word ptr [bp+var_mempages+2]
    push    word ptr [bp+var_mempages]
    call    mmgr_release
    add     sp, 4
    jmp     _end_load_2dshape
_try_load_xvs:
    mov     ax, offset a_xvs; ".XVS"
    push    ax
    lea     ax, [bp+var_strptr+2]
    push    ax              ; char *
    call    _stricmp
    add     sp, 4
    or      ax, ax
    jnz     short _try_load_pes
    push    [bp+arg_fatal]
    lea     ax, [bp+var_str]
    push    ax
    call    file_decomp
_do_end_load_2dshape:
    add     sp, 4
loc_3AB47:
    mov     [bp+var_memchunkofs], ax
    mov     [bp+var_memchunkseg], dx
    jmp     _end_load_2dshape
_try_load_pes:
    mov     ax, offset a_pes; ".PES"
    push    ax
    lea     ax, [bp+var_strptr+2]
    push    ax              ; char *
    call    _stricmp
    add     sp, 4
    or      ax, ax
    jz      short loc_3AB67
    jmp     _try_load_esh
loc_3AB67:
    push    [bp+arg_fatal]
    lea     ax, [bp+var_str]
    push    ax
    call    file_decomp
    add     sp, 4
    mov     [bp+var_memchunkofs], ax
    mov     [bp+var_memchunkseg], dx
    or      ax, dx
    jnz     short loc_3AB83
    jmp     _end_load_2dshape
loc_3AB83:
    mov     ax, 3E8h
    push    ax
    mov     ax, offset aUnflip; "UNFLIP"
    push    ax
    call    mmgr_alloc_pages
    add     sp, 4
    mov     word ptr [bp+var_mempages], ax
    mov     word ptr [bp+var_mempages+2], dx
    push    dx
    push    ax
    push    [bp+var_memchunkseg]
    push    [bp+var_memchunkofs]
    call    file_unflip_shape2d_pes
    add     sp, 8
    push    word ptr [bp+var_mempages+2]
    push    word ptr [bp+var_mempages]
    call    mmgr_release
    add     sp, 4
loc_3ABB7:
    push    [bp+var_memchunkseg]
    push    [bp+var_memchunkofs]
    call    file_load_shape2d_expandedsize
    add     sp, 4
    mov     [bp+var_expandedsize], ax
    mov     ax, offset aMga ; "!MGA"
    push    ax
    push    [bp+var_memchunkseg]
    push    [bp+var_memchunkofs]
    call    locate_shape_nofatal
    add     sp, 6
    mov     [bp+var_mgaofs], ax
    mov     [bp+var_mgaseg], dx
    or      ax, dx
    jz      short loc_3ABF3
    mov     ax, [bp+var_mgaofs]
    add     ax, 10h
    push    dx
    push    ax
    push    cs
    call near ptr file_load_shape2d_palmap_init
    add     sp, 4
loc_3ABF3:
    push    [bp+var_expandedsize]
    lea     ax, [bp+var_str]
    push    ax
    call    mmgr_alloc_pages
    add     sp, 4
    mov     word ptr [bp+var_mempages], ax
    mov     word ptr [bp+var_mempages+2], dx
    les     bx, [bp+var_mempages]
    mov     ax, [bp+var_expandedsize]
    sub     dx, dx
    mov     cl, 4
loc_3AC12:
    shl     ax, 1
    rcl     dx, 1
    dec     cl
    jz      short loc_3AC60
    jmp     short loc_3AC12
_try_load_esh:
    mov     ax, offset a_esh; ".ESH"
    push    ax
    lea     ax, [bp+var_strptr+2]
    push    ax              ; char *
    call    _stricmp
    add     sp, 4
    or      ax, ax
    jnz     short loc_3AC50
    push    [bp+arg_fatal]
    lea     ax, [bp+var_str]
    push    ax
    call    file_load_binary
    add     sp, 4
    mov     [bp+var_memchunkofs], ax
    mov     [bp+var_memchunkseg], dx
    or      ax, dx
    jz      short loc_3AC4C
    jmp     loc_3ABB7
loc_3AC4C:
    jmp     _end_load_2dshape
    ; align 2
    db 144
loc_3AC50:
    push    [bp+arg_fatal]
    lea     ax, [bp+var_str]
    push    ax
loc_3AC57:
    call    file_load_binary
    jmp     _do_end_load_2dshape
    ; align 2
    db 144
loc_3AC60:
    mov     es:[bx], ax
    mov     es:[bx+2], dx
    push    word ptr [bp+var_mempages+2]
    push    word ptr [bp+var_mempages]
    push    [bp+var_memchunkseg]
    push    [bp+var_memchunkofs]
    call    file_load_shape2d_expand
    add     sp, 8
    push    [bp+var_memchunkseg]
    push    [bp+var_memchunkofs]
    call    mmgr_release
    add     sp, 4
    push    word ptr [bp+var_mempages+2]
    push    word ptr [bp+var_mempages]
    call    mmgr_op_unk
    add     sp, 4
loc_3AC97:
    mov     [bp+var_memchunkofs], ax
    mov     [bp+var_memchunkseg], dx
    mov     ax, offset palmap
    push    ax
    push    dx
    push    [bp+var_memchunkofs]
    call    file_load_shape2d_palmap_apply
    add     sp, 6
    jmp     _end_load_2dshape
file_load_shape2d endp
file_load_shape2d_palmap_init proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
loc_3ACB1:
    mov     bp, sp
    sub     sp, 2
loc_3ACB6:
    push    si
loc_3ACB7:
    mov     [bp+var_2], 0
loc_3ACBC:
    mov     bx, [bp+var_2]
loc_3ACBF:
    les     si, [bp+arg_0]
loc_3ACC2:
    mov     al, es:[bx+si]
loc_3ACC5:
    mov     palmap[bx], al
loc_3ACC9:
    inc     [bp+var_2]
loc_3ACCC:
    cmp     [bp+var_2], 10h
loc_3ACD0:
    jl      short loc_3ACBC
loc_3ACD2:
    pop     si
loc_3ACD3:
    mov     sp, bp
loc_3ACD5:
    pop     bp
locret_3ACD6:
    retf
file_load_shape2d_palmap_init endp
seg034 ends
end
