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
    include seg035.inc
    include seg036.inc
    include seg038.inc
    include seg039.inc
    include dseg.inc
    include seg041.inc
seg037 segment byte public 'STUNTSC' use16
    assume cs:seg037
    assume es:nothing, ss:nothing, ds:dseg
    public file_load_shape2d_expandedsize
file_load_shape2d_expandedsize proc far
    var_sizelo = word ptr -14
    var_sizehi = word ptr -12
    var_shapecount = word ptr -10
    var_counter = word ptr -8
    var_6 = word ptr -6
    var_memshape = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_memchunkoff = word ptr 6
    arg_memchunkseg = word ptr 8

    push    bp
loc_3B12B:
    mov     bp, sp
loc_3B12D:
    sub     sp, 0Eh
loc_3B130:
    push    [bp+arg_memchunkseg]
    push    [bp+arg_memchunkoff]
    call    file_get_res_shape_count
    add     sp, 4
loc_3B13E:
    mov     [bp+var_shapecount], ax
    mov     cl, 3
    shl     ax, cl
    add     ax, size SHAPE2D
    cwd
    mov     [bp+var_sizelo], ax
    mov     [bp+var_sizehi], dx
    mov     [bp+var_counter], 0
    jmp     short loc_3B191
loc_3B156:
    push    [bp+var_counter]
    push    [bp+arg_memchunkseg]
    push    [bp+arg_memchunkoff]
    call    file_get_shape2d
    add     sp, 6
    mov     word ptr [bp+var_memshape], ax
loc_3B16A:
    mov     word ptr [bp+var_memshape+2], dx
    les     bx, [bp+var_memshape]
    mov     ax, es:[bx+SHAPE2D.s2d_height]
loc_3B174:
    imul    es:[bx+SHAPE2D.s2d_width]
    mov     cl, 3
    shl     ax, cl
loc_3B17B:
    mov     [bp+var_6], ax
    sub     dx, dx
    add     [bp+var_sizelo], ax
loc_3B183:
    adc     [bp+var_sizehi], dx
    add     [bp+var_sizelo], size SHAPE2D
loc_3B18A:
    adc     [bp+var_sizehi], 0
    inc     [bp+var_counter]
loc_3B191:
    mov     ax, [bp+var_shapecount]
    cmp     [bp+var_counter], ax
    jl      short loc_3B156
    add     [bp+var_sizelo], 10h
    adc     [bp+var_sizehi], 0
    mov     al, 4
    push    ax
    lea     ax, [bp+var_sizelo]
    push    ax
    call    unknown_libname_4; MS Quick C v1.0/v2.01 & MSC v5.1 DOS run-time & graphic
    mov     ax, [bp+var_sizelo]
    mov     sp, bp
    pop     bp
    retf
    ; align 10h
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
file_load_shape2d_expandedsize endp
seg037 ends
end
