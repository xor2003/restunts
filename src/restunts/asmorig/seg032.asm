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
    include seg033.inc
    include seg034.inc
    include seg035.inc
    include seg036.inc
    include seg037.inc
    include seg038.inc
    include seg039.inc
    include dseg.inc
    include seg041.inc
seg032 segment byte public 'STUNTSC' use16
    assume cs:seg032
    assume es:nothing, ss:nothing, ds:dseg
    public read_line
    public read_line_helper
    public read_line_helper2
algn_3A4B5:
    ; align 2
    db 144
read_line proc far
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6
    arg_2 = dword ptr 8
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18
    arg_E = dword ptr 20
    arg_12 = word ptr 24
    arg_14 = word ptr 26

    push    bp
loc_3A4B7:
    mov     bp, sp
loc_3A4B9:
    sub     sp, 0Ah
loc_3A4BC:
    push    si
loc_3A4BD:
    call    sprite_copy_2_to_1
loc_3A4C2:
    mov     ax, [bp+arg_A]
loc_3A4C5:
    mov     word_42A18, ax
loc_3A4C8:
    mov     ax, [bp+arg_C]
loc_3A4CB:
    mov     word_42A1A, ax
loc_3A4CE:
    mov     ax, word ptr [bp+arg_2]
loc_3A4D1:
    mov     off_42A1E, ax
loc_3A4D4:
    mov     ax, [bp+arg_8]
loc_3A4D7:
    mov     word_42A20, ax
loc_3A4DA:
    mov     bx, [bp+arg_6]
loc_3A4DD:
    mov     si, word ptr [bp+arg_2]
loc_3A4E0:
    mov     byte ptr [bx+si], 0
loc_3A4E3:
    test    [bp+arg_0], 1
loc_3A4E7:
    jz      short loc_3A4EE
loc_3A4E9:
    mov     bx, si
loc_3A4EB:
    mov     byte ptr [bx], 0
loc_3A4EE:
    test    [bp+arg_0], 2
loc_3A4F2:
    jz      short loc_3A4FC
loc_3A4F4:
    mov     word_42A22, 0
loc_3A4FA:
    jmp     short loc_3A50A
loc_3A4FC:
    push    word ptr [bp+arg_2]; char *
    call    _strlen
loc_3A504:
    add     sp, 2
    mov     word_42A22, ax
loc_3A50A:
    push    word ptr [bp+arg_2]; char *
    call    _strlen
loc_3A512:
    add     sp, 2
    mov     [bp+var_6], ax
    jmp     short loc_3A526
loc_3A51A:
    mov     bx, [bp+var_6]
    inc     [bp+var_6]
    mov     si, word ptr [bp+arg_2]
loc_3A523:
    mov     byte ptr [bx+si], 20h ; ' '
loc_3A526:
    mov     ax, [bp+arg_6]
    cmp     [bp+var_6], ax
    jl      short loc_3A51A
    push    cs
    call near ptr read_line_helper2
    mov     word_42A16, 1
loc_3A538:
    mov     word_42A1C, 1
    mov     [bp+var_A], 0
    push    cs
    call near ptr read_line_helper
    push    [bp+arg_14]
    push    [bp+arg_12]
    call    timer_copy_counter; Stores a copy of the timer counter with the given ticks added.
    add     sp, 4
    mov     ax, 4
    cwd
    push    dx
    push    ax
    call    set_add_value
    add     sp, 4
loc_3A563:
    mov     [bp+var_2], 1
loc_3A568:
    cmp     word ptr [bp+arg_2+2], 0
loc_3A56C:
    jz      short loc_3A57F
loc_3A56E:
    mov     ax, word ptr [bp+arg_2+2]
loc_3A571:
    mov     [bp+var_8], ax
loc_3A574:
    mov     word ptr [bp+arg_2+2], 0
loc_3A579:
    jmp     short loc_3A599
algn_3A57B:
    ; align 2
    db 144
loc_3A57C:
    call    [bp+arg_E]
loc_3A57F:
    call    kb_call_readchar_callback
    mov     [bp+var_8], ax
    or      ax, ax
    jnz     short loc_3A599
    call    sub_2EB07
    or      ax, ax
    jz      short loc_3A57C
    mov     [bp+var_8], 0
loc_3A599:
    cmp     [bp+var_8], 0
    jnz     short loc_3A5F0
loc_3A59F:
    mov     ax, 4
loc_3A5A2:
    cwd
    push    dx
    push    ax
    call    set_add_value
loc_3A5AA:
    add     sp, 4
    mov     ax, word_42A1C
    mov     [bp+var_4], ax
loc_3A5B3:
    mov     word_42A1C, 1
    push    cs
    call near ptr read_line_helper
    cmp     [bp+var_4], 0
    jz      short loc_3A5CC
    mov     word_42A1C, 0
    jmp     short loc_3A5D2
    ; align 2
    db 144
loc_3A5CC:
    mov     word_42A1C, 1
loc_3A5D2:
    mov     ax, [bp+arg_12]
    or      ax, [bp+arg_14]
    jz      short loc_3A568
    call    timer_compare_dx
    or      ax, ax
    jz      short loc_3A568
loc_3A5E3:
    push    cs
    call near ptr read_line_helper
    mov     ax, [bp+var_8]
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_3A5F0:
    push    [bp+arg_14]
    push    [bp+arg_12]
    call    timer_copy_counter; Stores a copy of the timer counter with the given ticks added.
    add     sp, 4
    cmp     [bp+var_8], 0Dh
    jz      short loc_3A5E3
    cmp     [bp+var_8], 1Bh
    jz      short loc_3A5E3
    cmp     [bp+var_8], 4800h
    jz      short loc_3A5E3
    cmp     [bp+var_8], 5000h
    jnz     short loc_3A61E
    test    [bp+arg_0], 8
    jz      short loc_3A5E3
loc_3A61E:
    cmp     [bp+var_8], 9
    jnz     short loc_3A62A
    test    [bp+arg_0], 10h
loc_3A628:
    jz      short loc_3A5E3
loc_3A62A:
    cmp     [bp+var_8], 4D00h
    jnz     short loc_3A648
    push    cs
    call near ptr read_line_helper
    mov     ax, word_42A22
    cmp     [bp+arg_6], ax
    jg      short loc_3A640
    jmp     loc_3A7E9
loc_3A640:
    inc     word_42A22
    jmp     loc_3A7E9
    ; align 2
    db 144
loc_3A648:
    cmp     [bp+var_8], 4B00h
    jnz     short loc_3A664
    push    cs
    call near ptr read_line_helper
    cmp     word_42A22, 0
    jnz     short loc_3A65D
    jmp     loc_3A7E9
loc_3A65D:
    dec     word_42A22
    jmp     loc_3A7E9
loc_3A664:
    cmp     [bp+var_8], 4700h
    jnz     short loc_3A678
    push    cs
    call near ptr read_line_helper
    mov     word_42A22, 0
    jmp     loc_3A7E9
loc_3A678:
    cmp     [bp+var_8], 4F00h
    jnz     short loc_3A694
    push    cs
    call near ptr read_line_helper
    push    word ptr [bp+arg_2]; char *
    call    _strlen
    add     sp, 2
    mov     word_42A22, ax
    jmp     loc_3A7E9
loc_3A694:
    cmp     [bp+var_8], 5200h
    jnz     short loc_3A6C2
    push    cs
    call near ptr read_line_helper
    cmp     [bp+var_A], 0
    jnz     short loc_3A6B4
    mov     [bp+var_A], 1
    mov     word_42A16, 8
    jmp     loc_3A7E9
    ; align 2
    db 144
loc_3A6B4:
    mov     [bp+var_A], 0
    mov     word_42A16, 1
    jmp     loc_3A7E9
loc_3A6C2:
    cmp     [bp+var_8], 5300h
    jnz     short loc_3A710
    mov     ax, word_42A22
    cmp     [bp+arg_6], ax
    jg      short loc_3A6D4
    jmp     loc_3A7ED
loc_3A6D4:
    mov     bx, word ptr [bp+arg_2]
    mov     si, ax
    cmp     byte ptr [bx+si], 0
    jnz     short loc_3A6E1
    jmp     loc_3A7ED
loc_3A6E1:
    push    cs
    call near ptr read_line_helper
    mov     ax, word_42A22
    mov     [bp+var_6], ax
    jmp     short loc_3A6FC
    ; align 2
    db 144
loc_3A6EE:
    mov     si, [bp+var_6]
    add     si, word ptr [bp+arg_2]
    mov     al, [si+1]
    mov     [si], al
    inc     [bp+var_6]
loc_3A6FC:
    mov     ax, [bp+arg_6]
    cmp     [bp+var_6], ax
    jl      short loc_3A6EE
loc_3A704:
    mov     si, ax
    mov     bx, word ptr [bp+arg_2]
    mov     byte ptr [bx+si-1], 20h ; ' '
    jmp     loc_3A7E5
loc_3A710:
    cmp     [bp+var_8], 8
    jnz     short loc_3A748
    cmp     word_42A22, 0
    jnz     short loc_3A720
    jmp     loc_3A7ED
loc_3A720:
    push    cs
    call near ptr read_line_helper
    dec     word_42A22
    mov     ax, word_42A22
    mov     [bp+var_6], ax
    jmp     short loc_3A73E
loc_3A730:
    mov     si, [bp+var_6]
    add     si, word ptr [bp+arg_2]
    mov     al, [si+1]
    mov     [si], al
    inc     [bp+var_6]
loc_3A73E:
    mov     ax, [bp+arg_6]
    cmp     [bp+var_6], ax
    jl      short loc_3A730
    jmp     short loc_3A704
loc_3A748:
    cmp     [bp+var_8], 20h ; ' '
    jge     short loc_3A751
    jmp     loc_3A7ED
loc_3A751:
    cmp     [bp+var_8], 7Ah ; 'z'
    jle     short loc_3A75A
    jmp     loc_3A7ED
loc_3A75A:
    mov     ax, word_42A22
    cmp     [bp+arg_6], ax
    jg      short loc_3A765
    jmp     loc_3A7ED
loc_3A765:
    push    cs
    call near ptr read_line_helper
loc_3A769:
    cmp     [bp+var_2], 0
    jz      short loc_3A796
    test    [bp+arg_0], 4
    jnz     short loc_3A796
    mov     word_42A22, 0
    mov     [bp+var_6], 0
    jmp     short loc_3A78E
loc_3A782:
    mov     bx, [bp+var_6]
    mov     si, word ptr [bp+arg_2]
loc_3A788:
    mov     byte ptr [bx+si], 20h ; ' '
    inc     [bp+var_6]
loc_3A78E:
    mov     ax, [bp+arg_6]
    cmp     [bp+var_6], ax
    jl      short loc_3A782
loc_3A796:
    mov     si, word ptr [bp+arg_2]
    add     si, word_42A22
    cmp     byte ptr [si], 0
    jnz     short loc_3A7A6
    mov     byte ptr [si+1], 0
loc_3A7A6:
    cmp     [bp+var_A], 0
    jz      short loc_3A7CE
    mov     ax, [bp+arg_6]
    sub     ax, 2
    mov     [bp+var_6], ax
    jmp     short loc_3A7C6
    ; align 2
    db 144
loc_3A7B8:
    mov     si, [bp+var_6]
    add     si, word ptr [bp+arg_2]
    mov     al, [si]
    mov     [si+1], al
    dec     [bp+var_6]
loc_3A7C6:
    mov     ax, word_42A22
    cmp     [bp+var_6], ax
    jge     short loc_3A7B8
loc_3A7CE:
    mov     bx, word ptr [bp+arg_2]
    mov     si, word_42A22
    mov     al, byte ptr [bp+var_8]
    mov     [bx+si], al
    mov     ax, si
    cmp     [bp+arg_6], ax
    jle     short loc_3A7E5
    inc     word_42A22
loc_3A7E5:
    push    cs
    call near ptr read_line_helper2
loc_3A7E9:
    push    cs
    call near ptr read_line_helper
loc_3A7ED:
    mov     [bp+var_2], 0
    jmp     loc_3A568
    ; align 2
    db 144
read_line endp
read_line_helper proc far
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    cmp     word_42A1C, 0
    jnz     short loc_3A806
    jmp     loc_3A891
loc_3A806:
    push    off_42A1E       ; char *
loc_3A80A:
    call    _strlen
loc_3A80F:
    add     sp, 2
    cmp     ax, word_42A22
    jge     short loc_3A827
    push    off_42A1E       ; char *
    call    _strlen
loc_3A821:
    add     sp, 2
    mov     word_42A22, ax
loc_3A827:
    mov     ax, 1
    push    ax
    mov     ax, word_42A22
    add     ax, off_42A1E
    push    ax
loc_3A833:
    call    font_op
    add     sp, 4
    mov     [bp+var_2], ax
    or      ax, ax
    jnz     short loc_3A851
loc_3A842:
    mov     ax, 53CAh
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_2], ax
loc_3A851:
    push    word_42A22
loc_3A855:
    push    off_42A1E
    call    font_op
loc_3A85E:
    add     sp, 4
    add     ax, word_42A18
    mov     [bp+var_4], ax
    les     bx, dword ptr word_405FE
    mov     ax, es:[bx+12h]
loc_3A870:
    add     ax, word_42A1A
    sub     ax, word_42A16
    mov     [bp+var_6], ax
    push    word ptr es:[bx]
    push    word_42A16
    push    [bp+var_2]
    push    ax
    push    [bp+var_4]
    call    sub_35B76
    add     sp, 0Ah
loc_3A891:
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
read_line_helper endp
read_line_helper2 proc far
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    si
    cmp     word_42A20, 0
    jz      short loc_3A8DE
    jmp     short loc_3A8CC
loc_3A8A6:
    push    off_42A1E       ; char *
    call    _strlen
    add     sp, 2
    or      ax, ax
    jz      short loc_3A8DE
    push    off_42A1E       ; char *
    call    _strlen
    add     sp, 2
    mov     si, ax
    mov     bx, off_42A1E
    mov     byte ptr [bx+si-1], 0
loc_3A8CC:
    push    off_42A1E
    call    font_op2
    add     sp, 2
loc_3A8D8:
    cmp     ax, word_42A20
    jg      short loc_3A8A6
loc_3A8DE:
    push    off_42A1E       ; char *
    call    _strlen
    add     sp, 2
    mov     [bp+var_2], ax
    mov     ax, word_42A22
    cmp     [bp+var_2], ax
    jge     short loc_3A8FB
    mov     ax, [bp+var_2]
    mov     word_42A22, ax
loc_3A8FB:
    push    word_42A1A
    push    word_42A18
    push    off_42A1E
    call    sub_345BC
    add     sp, 6
    cmp     word_42A20, 0
    jz      short loc_3A953
loc_3A916:
    push    off_42A1E
    call    font_op2
    add     sp, 2
    mov     [bp+var_6], ax
    mov     ax, word_42A20
    sub     ax, [bp+var_6]
    mov     [bp+var_4], ax
    or      ax, ax
    jle     short loc_3A953
    les     bx, dword ptr word_405FE
loc_3A936:
    push    word ptr es:[bx+2]
    push    word ptr es:[bx+12h]
loc_3A93E:
    push    ax
loc_3A93F:
    push    word_42A1A
    mov     ax, [bp+var_6]
loc_3A946:
    add     ax, word_42A18
loc_3A94A:
    push    ax
loc_3A94B:
    call    sprite_1_unk2
loc_3A950:
    add     sp, 0Ah
loc_3A953:
    pop     si
loc_3A954:
    mov     sp, bp
loc_3A956:
    pop     bp
    retf
read_line_helper2 endp
seg032 ends
end
