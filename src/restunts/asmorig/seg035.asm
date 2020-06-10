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
    include seg034.inc
    include seg036.inc
    include seg037.inc
    include seg038.inc
    include seg039.inc
    include dseg.inc
    include seg041.inc
seg035 segment byte public 'STUNTSC' use16
    assume cs:seg035
    assume es:nothing, ss:nothing, ds:dseg
    public file_load_shape2d_res_fatal
    public file_load_shape2d_res_nofatal
    public file_load_shape2d_res
    public parse_shape2d
    public parse_shape2d_helper3
    ; align 2
    db 144
file_load_shape2d_res_fatal proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_3ACD9:
    mov     bp, sp
loc_3ACDB:
    mov     ax, 1
loc_3ACDE:
    push    ax
loc_3ACDF:
    push    [bp+arg_0]
loc_3ACE2:
    push    cs
loc_3ACE3:
    call near ptr file_load_shape2d_res
loc_3ACE6:
    add     sp, 4
    pop     bp
locret_3ACEA:
    retf
    ; align 2
    db 144
file_load_shape2d_res_fatal endp
file_load_shape2d_res_nofatal proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_3ACED:
    mov     bp, sp
loc_3ACEF:
    sub     ax, ax
    push    ax
loc_3ACF2:
    push    [bp+arg_0]
    push    cs
loc_3ACF6:
    call near ptr file_load_shape2d_res
loc_3ACF9:
    add     sp, 4
loc_3ACFC:
    pop     bp
    retf
file_load_shape2d_res_nofatal endp
file_load_shape2d_res proc far
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_fatal = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    [bp+arg_0]
    call    mmgr_path_to_name
    add     sp, 2
    push    ax
    call    mmgr_get_chunk_by_name
    add     sp, 2
    mov     [bp+var_8], ax
loc_3AD1B:
    mov     [bp+var_6], dx
    or      ax, dx
    jz      short loc_3AD2A
loc_3AD22:
    mov     ax, [bp+var_8]
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_3AD2A:
    push    [bp+arg_fatal]
    push    [bp+arg_0]
loc_3AD30:
    call    file_load_shape2d
    add     sp, 4
    mov     [bp+var_4], ax
loc_3AD3B:
    mov     [bp+var_2], dx
    or      ax, dx
    jnz     short loc_3AD4A
    mov     ax, [bp+var_4]
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_3AD4A:
    push    [bp+var_2]
    push    [bp+var_4]
    call    mmgr_get_chunk_size
    add     sp, 4
    mov     [bp+var_A], ax
    push    ax
    push    [bp+arg_0]
    call    mmgr_alloc_pages
    add     sp, 4
    mov     [bp+var_8], ax
    mov     [bp+var_6], dx
    push    dx
    push    ax
    push    [bp+var_2]
    push    [bp+var_4]
    push    cs
    call near ptr parse_shape2d
    add     sp, 8
    push    [bp+var_2]
    push    [bp+var_4]
    call    mmgr_release
    add     sp, 4
    push    [bp+var_6]
    push    [bp+var_8]
    call    mmgr_op_unk
    add     sp, 4
    mov     sp, bp
    pop     bp
    retf
file_load_shape2d_res endp
parse_shape2d proc far
    var_chunkptr = dword ptr -56
    var_34 = word ptr -52
    var_32 = word ptr -50
    var_30 = word ptr -48
    var_2E = dword ptr -46
    var_counter = word ptr -42
    var_shapecount = word ptr -40
    var_26 = word ptr -38
    var_24 = word ptr -36
    var_1E = word ptr -30
    var_pagesptr = dword ptr -28
    var_pagescnt6ptr = dword ptr -24
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = dword ptr -12
    var_8 = dword ptr -8
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_memchunkofs = word ptr 6
    arg_memchunkseg = word ptr 8
    arg_mempagesofs = word ptr 10
    arg_mempagesseg = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 38h
    push    di
    push    si
    push    [bp+arg_memchunkseg]
    push    [bp+arg_memchunkofs]
    call    file_get_res_shape_count
    add     sp, 4
    mov     [bp+var_shapecount], ax
    shl     ax, 1
    shl     ax, 1
    add     ax, [bp+arg_mempagesofs]
    mov     dx, [bp+arg_mempagesseg]
    add     ax, 6
    mov     word ptr [bp+var_pagescnt6ptr], ax
    mov     word ptr [bp+var_pagescnt6ptr+2], dx
    mov     ax, [bp+arg_mempagesofs]
    mov     word ptr [bp+var_pagesptr], ax
    mov     word ptr [bp+var_pagesptr+2], dx
    mov     ax, [bp+arg_memchunkofs]
    mov     dx, [bp+arg_memchunkseg]
    mov     word ptr [bp+var_chunkptr], ax
    mov     word ptr [bp+var_chunkptr+2], dx
    mov     [bp+var_counter], 0
    jmp     short loc_3ADF9
loc_3ADE4:
    les     bx, [bp+var_chunkptr]
    inc     word ptr [bp+var_chunkptr]
    mov     al, es:[bx]
    les     bx, [bp+var_pagesptr]
    inc     word ptr [bp+var_pagesptr]
    mov     es:[bx], al
    inc     [bp+var_counter]
loc_3ADF9:
    mov     ax, [bp+var_shapecount]
    shl     ax, 1
    shl     ax, 1
    add     ax, 6
    cmp     ax, [bp+var_counter]
    jg      short loc_3ADE4
    mov     ax, [bp+var_shapecount]
    mov     cl, 3
    shl     ax, cl
    add     ax, [bp+arg_mempagesofs]
    mov     dx, [bp+arg_mempagesseg]
    add     ax, 6
    mov     word ptr [bp+var_8], ax
    mov     word ptr [bp+var_8+2], dx
    mov     [bp+var_26], ax
    mov     [bp+var_24], dx
    mov     [bp+var_counter], 0
    jmp     loc_3AF5B
loc_3AE2C:
    push    word ptr [bp+var_2E+2]
    push    word ptr [bp+var_2E]
    push    cs
    call near ptr parse_shape2d_helper3
    add     sp, 4
    mov     [bp+var_10], ax
    cmp     ax, 3
    jg      short loc_3AE4C
    mov     ax, [bp+var_1E]
    cmp     [bp+var_E], ax
    jnb     short loc_3AE4C
    jmp     loc_3AF3F
loc_3AE4C:
    cmp     [bp+var_E], 7Fh ; ''
    jg      short loc_3AE74
    cmp     [bp+var_E], 0
    jz      short loc_3AEC9
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     ax, [bp+var_E]
    neg     ax
    mov     es:[bx], al
    mov     ax, [bp+var_E]
    sub     [bp+var_1E], ax
    mov     [bp+var_30], 0
    jmp     short loc_3AEC1
    ; align 2
    db 144
loc_3AE74:
    sub     [bp+var_E], 7Fh ; ''
    sub     [bp+var_1E], 7Fh ; ''
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     byte ptr es:[bx], 81h ; 'Å'
    mov     [bp+var_30], 0
    jmp     short loc_3AE91
    ; align 2
    db 144
loc_3AE8E:
    inc     [bp+var_30]
loc_3AE91:
    cmp     [bp+var_30], 7Fh ; ''
    jge     short loc_3AE4C
    les     bx, [bp+var_4]
    inc     word ptr [bp+var_4]
    mov     al, es:[bx]
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     es:[bx], al
    jmp     short loc_3AE8E
    ; align 2
    db 144
loc_3AEAC:
    les     bx, [bp+var_4]
    inc     word ptr [bp+var_4]
    mov     al, es:[bx]
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     es:[bx], al
    inc     [bp+var_30]
loc_3AEC1:
    mov     ax, [bp+var_E]
    cmp     [bp+var_30], ax
    jl      short loc_3AEAC
loc_3AEC9:
    mov     ax, [bp+var_1E]
    cmp     [bp+var_10], ax
    jbe     short loc_3AEFB
    mov     [bp+var_10], ax
    jmp     short loc_3AEFB
loc_3AED6:
    sub     [bp+var_10], 7Fh ; ''
    sub     [bp+var_1E], 7Fh ; ''
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     byte ptr es:[bx], 7Fh ; ''
    les     bx, [bp+var_2E]
    mov     al, es:[bx]
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     es:[bx], al
    add     word ptr [bp+var_2E], 7Fh ; ''
loc_3AEFB:
    cmp     [bp+var_10], 7Fh ; ''
    jg      short loc_3AED6
    cmp     [bp+var_10], 3
    jle     short loc_3AF2E
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     al, byte ptr [bp+var_10]
    mov     es:[bx], al
    mov     ax, [bp+var_10]
    sub     [bp+var_1E], ax
    les     bx, [bp+var_2E]
    mov     al, es:[bx]
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     es:[bx], al
    mov     ax, [bp+var_10]
    add     word ptr [bp+var_2E], ax
loc_3AF2E:
    mov     ax, word ptr [bp+var_2E]
    mov     dx, word ptr [bp+var_2E+2]
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    mov     [bp+var_E], 0
loc_3AF3F:
    inc     word ptr [bp+var_2E]
    inc     [bp+var_E]
loc_3AF45:
    cmp     [bp+var_1E], 0
    jz      short loc_3AF4E
    jmp     loc_3AE2C
loc_3AF4E:
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     byte ptr es:[bx], 0
    inc     [bp+var_counter]
loc_3AF5B:
    mov     ax, [bp+var_shapecount]
    cmp     [bp+var_counter], ax
    jl      short loc_3AF66
    jmp     loc_3B020
loc_3AF66:
    push    [bp+var_counter]
    push    [bp+arg_memchunkseg]
    push    [bp+arg_memchunkofs]
    call    file_get_shape2d
    add     sp, 6
    mov     word ptr [bp+var_C], ax
    mov     word ptr [bp+var_C+2], dx
    push    word ptr [bp+var_8+2]
    push    word ptr [bp+var_8]
    call    parse_shape2d_helper
    add     sp, 4
    mov     [bp+var_14], ax
    mov     [bp+var_12], dx
    push    dx
    push    ax
    call    parse_shape2d_helper2
    add     sp, 4
    mov     word ptr [bp+var_8], ax
    mov     word ptr [bp+var_8+2], dx
    push    [bp+var_24]
    push    [bp+var_26]
    call    parse_shape2d_helper
    add     sp, 4
    push    word ptr [bp+var_8+2]
    push    word ptr [bp+var_8]
    mov     si, ax
    mov     di, dx
    call    parse_shape2d_helper
    add     sp, 4
    sub     ax, si
    sbb     dx, di
    les     bx, [bp+var_pagescnt6ptr]
    add     word ptr [bp+var_pagescnt6ptr], 4
    mov     es:[bx], ax
    mov     es:[bx+2], dx
    mov     ax, word ptr [bp+var_C]
    mov     dx, word ptr [bp+var_C+2]
    mov     word ptr [bp+var_2E], ax
    mov     word ptr [bp+var_2E+2], dx
    mov     [bp+var_30], 0
loc_3AFE4:
    les     bx, [bp+var_2E]
    inc     word ptr [bp+var_2E]
    mov     al, es:[bx]
    les     bx, [bp+var_8]
    inc     word ptr [bp+var_8]
    mov     es:[bx], al
    inc     [bp+var_30]
    cmp     [bp+var_30], 10h
    jl      short loc_3AFE4
    mov     ax, word ptr [bp+var_2E]
    mov     dx, word ptr [bp+var_2E+2]
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    mov     [bp+var_E], 0
    les     bx, [bp+var_C]
    mov     ax, es:[bx+2]
    imul    word ptr es:[bx]
    mov     [bp+var_1E], ax
    jmp     loc_3AF45
loc_3B020:
    push    [bp+arg_mempagesseg]
    push    [bp+arg_mempagesofs]
    call    parse_shape2d_helper
    add     sp, 4
    push    word ptr [bp+var_8+2]
    push    word ptr [bp+var_8]
    mov     si, ax
    mov     di, dx
    call    parse_shape2d_helper
    add     sp, 4
    sub     ax, si
    sbb     dx, di
    mov     [bp+var_34], ax
    mov     [bp+var_32], dx
    test    byte ptr [bp+var_34], 0Fh
    jz      short loc_3B068
    mov     cl, 4
loc_3B052:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_3B052
    add     ax, 1
    adc     dx, 0
    mov     [bp+var_34], ax
    mov     [bp+var_32], dx
    jmp     short loc_3B074
loc_3B068:
    mov     al, 4
    push    ax
    lea     ax, [bp+var_34]
    push    ax
    call    unknown_libname_4; MS Quick C v1.0/v2.01 & MSC v5.1 DOS run-time & graphic
loc_3B074:
    push    [bp+var_34]
    push    [bp+arg_mempagesseg]
    push    [bp+arg_mempagesofs]
    call    mmgr_resize_memory
    add     sp, 6
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
parse_shape2d endp
parse_shape2d_helper3 proc far
    var_4 = byte ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    les     bx, [bp+arg_0]
    mov     al, es:[bx]
    mov     [bp+var_4], al
    mov     [bp+var_2], 0
    jmp     short loc_3B0A5
loc_3B0A2:
    inc     [bp+var_2]
loc_3B0A5:
    les     bx, [bp+arg_0]
    inc     word ptr [bp+arg_0]
    mov     al, [bp+var_4]
    cmp     es:[bx], al
    jz      short loc_3B0A2
    mov     ax, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
parse_shape2d_helper3 endp
seg035 ends
end
