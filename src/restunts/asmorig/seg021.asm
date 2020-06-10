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
seg021 segment byte public 'STUNTSC' use16
    assume cs:seg021
    assume es:nothing, ss:nothing, ds:dseg
    public heapsort_by_order
heapsort_by_order proc far
    var_index = word ptr -8
    var_counter = word ptr -6
    var_halfindex = word ptr -4
    var_value = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_count = word ptr 6
    arg_intbuffer = word ptr 8
    arg_orderbuffer = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    di
    push    si
    mov     ax, [bp+arg_count]
    cwd
    sub     ax, dx
    sar     ax, 1
    jmp     short loc_36C6B
loc_36BFA:
    mov     si, [bp+var_index]
    shl     si, 1
    mov     bx, [bp+arg_intbuffer]
    mov     ax, [bx+si]
    mov     [bp+var_value], ax
    mov     di, [bp+var_index]
    add     di, [bp+var_halfindex]
    shl     di, 1
    mov     ax, [bx+di]
    mov     [bx+si], ax
    mov     ax, [bp+var_value]
    mov     [bx+di], ax
    mov     bx, [bp+arg_orderbuffer]
    mov     ax, [bx+si]
    mov     [bp+var_value], ax
    mov     ax, [bx+di]
    mov     [bx+si], ax
    mov     ax, [bp+var_value]
    mov     [bx+di], ax
    mov     ax, [bp+var_halfindex]
    sub     [bp+var_index], ax
loc_36C2F:
    cmp     [bp+var_index], 0
    jl      short loc_36C4B
    mov     bx, [bp+var_index]
    shl     bx, 1
    mov     si, [bp+arg_intbuffer]
    mov     ax, [bx+si]
    mov     bx, [bp+var_index]
    add     bx, [bp+var_halfindex]
    shl     bx, 1
    cmp     [bx+si], ax
    jg      short loc_36BFA
loc_36C4B:
    inc     [bp+var_counter]
loc_36C4E:
    mov     ax, [bp+arg_count]
    cmp     [bp+var_counter], ax
    jge     short loc_36C62
    mov     ax, [bp+var_counter]
    sub     ax, [bp+var_halfindex]
    mov     [bp+var_index], ax
    jmp     short loc_36C2F
    ; align 2
    db 144
loc_36C62:
    mov     cx, 2
    mov     ax, [bp+var_halfindex]
    cwd
    idiv    cx
loc_36C6B:
    mov     [bp+var_halfindex], ax
    or      ax, ax
    jle     short loc_36C78
    mov     [bp+var_counter], ax
    jmp     short loc_36C4E
    ; align 2
    db 144
loc_36C78:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
heapsort_by_order endp
seg021 ends
end
