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
seg029 segment byte public 'STUNTSC' use16
    assume cs:seg029
    assume es:nothing, ss:nothing, ds:dseg
    public audioresource_compare_chunknames
    public byte_39B14
    public audioresource_get_chunk_index
    public audioresource_find
    public audioresource_copy_n_bytes
algn_39AD1:
    ; align 4
    db 144
    db 0
    db 0
audioresource_compare_chunknames proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_casesensitive = word ptr 6
    arg_chunkname = dword ptr 8
    arg_foundname = dword ptr 12
    arg_num = word ptr 16

    push    bp
loc_39AD5:
    mov     bp, sp
loc_39AD7:
    sub     sp, 2
loc_39ADA:
    push    di
    push    si
loc_39ADC:
    cmp     [bp+arg_num], 0
loc_39AE0:
    jz      short loc_39B50
    mov     di, [bp+arg_casesensitive]
    mov     si, [bp+arg_num]
loc_39AE8:
    les     bx, [bp+arg_chunkname]
    cmp     byte ptr es:[bx], 0
loc_39AEF:
    jz      short loc_39B4D ; goto end
    les     bx, [bp+arg_foundname]
    cmp     byte ptr es:[bx], 0
    jz      short loc_39B4D ; goto end
    or      di, di
    jz      short loc_39B16
    mov     al, es:[bx]     ; al = arg_foundname[]
    les     bx, [bp+arg_chunkname]
    cmp     es:[bx], al
    jz      short loc_39B16
loc_39B09:
    sub     ax, ax
    mov     [bp+arg_num], si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
byte_39B14     db 144
    db 144
loc_39B16:
    or      di, di
    jnz     short loc_39B44
loc_39B1A:
    les     bx, [bp+arg_foundname]
    mov     al, es:[bx]
    sub     ah, ah
    push    ax
loc_39B23:
    call    toupper
    add     sp, 2
loc_39B2B:
    les     bx, [bp+arg_chunkname]
    mov     cl, es:[bx]
    sub     ch, ch
    push    cx
loc_39B34:
    mov     [bp+var_2], ax
    call    toupper
loc_39B3C:
    add     sp, 2
    cmp     ax, [bp+var_2]
    jnz     short loc_39B09
loc_39B44:
    inc     word ptr [bp+arg_chunkname]
    inc     word ptr [bp+arg_foundname]
    dec     si
    jnz     short loc_39AE8
loc_39B4D:
    mov     [bp+arg_num], si
loc_39B50:
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audioresource_compare_chunknames endp
audioresource_get_chunk_index proc far
    var_chunkname = word ptr -14
    var_chunknameseg = word ptr -12
    var_A = word ptr -10
    var_counter = word ptr -8
    var_namebuf = byte ptr -6
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_num = word ptr 6
    arg_numchunks = word ptr 8
    arg_chunkname = word ptr 10
    arg_chunkptr = dword ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    di
    push    si
    mov     [bp+var_2], 0
    mov     [bp+var_counter], 0
    cmp     [bp+arg_numchunks], 0
    jle     short loc_39BD3
    mov     ax, [bp+arg_chunkname]
    mov     [bp+var_chunkname], ax
    mov     [bp+var_chunknameseg], ds
    mov     si, [bp+var_counter]
loc_39B7D:
    sub     cx, cx
    les     di, [bp+arg_chunkptr]
loc_39B82:
    mov     bx, cx
    add     bx, bp
    mov     al, es:[di]
    mov     [bx+var_namebuf], al
    inc     di
    inc     cx
    cmp     cx, 4
    jl      short loc_39B82
    mov     word ptr [bp+arg_chunkptr], di; point at next chunk name
    mov     word ptr [bp+arg_chunkptr+2], es
    mov     [bp+var_A], cx
    mov     ax, 4
    push    ax
    push    [bp+var_chunknameseg]
    push    [bp+var_chunkname]
    lea     ax, [bp+var_namebuf]
    push    ss
    push    ax
    sub     ax, ax
    push    ax
    push    cs
    call near ptr audioresource_compare_chunknames
    add     sp, 0Ch
    or      ax, ax
    jz      short loc_39BC4 ; if ax = 0, then try next
    mov     ax, si
    mov     [bp+var_counter], si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_39BC4:
    mov     ax, [bp+arg_num]
    add     word ptr [bp+arg_chunkptr], ax
    inc     si
    cmp     si, [bp+arg_numchunks]
    jl      short loc_39B7D
    mov     [bp+var_counter], si
loc_39BD3:
    mov     ax, 0FFFFh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
audioresource_get_chunk_index endp
audioresource_find proc far
    var_chunkindex = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_numchunks = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_chunkofs = word ptr 6
    arg_chunkseg = word ptr 8
    arg_chunkname = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 10h
loc_39BE2:
    sub     ax, ax
    mov     [bp+var_8], ax
    mov     [bp+var_A], ax
    mov     ax, 4
    cwd
    add     ax, [bp+arg_chunkofs]
    adc     dx, 0
    mov     cx, 0Ch
    shl     dx, cl
    add     dx, [bp+arg_chunkseg]
    mov     es, dx
    mov     bx, ax
    mov     ax, es:[bx]     ; read a word from songfile+4 = number of (sub)chunks?
    mov     [bp+var_numchunks], ax
    mov     ax, 6
    cwd
    add     ax, [bp+arg_chunkofs]
    adc     dx, 0
    shl     dx, cl
    add     dx, [bp+arg_chunkseg]
    push    dx
    push    ax              ; songfile+6 = chunknames
    push    [bp+arg_chunkname]
    push    [bp+var_numchunks]
    sub     ax, ax
    push    ax
    push    cs
    call near ptr audioresource_get_chunk_index
    add     sp, 0Ah
    mov     [bp+var_chunkindex], ax
    or      ax, ax
    jl      short loc_39C7A ; -1 = not found
    mov     ax, [bp+arg_chunkofs]
    mov     dx, [bp+arg_chunkseg]
    mov     cx, [bp+var_numchunks]
    shl     cx, 1
    shl     cx, 1
    add     ax, cx
    mov     cx, [bp+var_chunkindex]
    shl     cx, 1
    shl     cx, 1
    add     ax, cx
loc_39C46:
    add     ax, 6
    mov     [bp+var_6], ax  ; ax = chunkofs + 6 + (chunkindex << 2) + (numchunk << 2)
    mov     [bp+var_4], dx
    push    dx
    push    ax
    call    audioresource_get_dword; read dword from the audio resource buffer
    add     sp, 4
    mov     [bp+var_E], ax
    mov     [bp+var_C], dx
    mov     ax, [bp+arg_chunkofs]
    mov     dx, [bp+arg_chunkseg]
    mov     bx, [bp+var_numchunks]
    mov     cl, 3
    shl     bx, cl
    add     ax, bx
    add     ax, [bp+var_E]
    add     ax, 6
    mov     [bp+var_A], ax  ; ax = chunkofs + 6 + readdword + (numchunks << 3)
    mov     [bp+var_8], dx
loc_39C7A:
    mov     ax, [bp+var_A]
    mov     dx, [bp+var_8]
    mov     sp, bp
    pop     bp
    retf
audioresource_find endp
audioresource_copy_n_bytes proc far
    var_6 = word ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_srcptr = dword ptr 6
    arg_destptr = dword ptr 10
    arg_size = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    mov     [bp+var_2], 0
    cmp     [bp+arg_size], 0
    jle     short loc_39CC4
    mov     cx, [bp+arg_size]
    mov     ax, cx
    add     [bp+var_2], ax
    les     di, [bp+arg_destptr]
    mov     [bp+var_6], ds
loc_39CA5:
    lds     si, [bp+arg_srcptr]
loc_39CA8:
    mov     al, [si]
    mov     es:[di], al
loc_39CAD:
    mov     ax, si
    mov     dx, ds
    inc     si
loc_39CB2:
    inc     di
    loop    loc_39CA8
loc_39CB5:
    mov     word ptr [bp+arg_srcptr], si; ??
loc_39CB8:
    mov     word ptr [bp+arg_srcptr+2], ds; ??
loc_39CBB:
    mov     ds, [bp+var_6]
loc_39CBE:
    mov     word ptr [bp+arg_destptr], di; ??
loc_39CC1:
    mov     word ptr [bp+arg_destptr+2], es; ??
loc_39CC4:
    pop     si
    pop     di
loc_39CC6:
    mov     sp, bp
loc_39CC8:
    pop     bp
locret_39CC9:
    retf
audioresource_copy_n_bytes endp
seg029 ends
end
