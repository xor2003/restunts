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
seg028 segment byte public 'STUNTSC' use16
    assume cs:seg028
    assume es:nothing, ss:nothing, ds:dseg
    public audiodriver_timer
    public sub_3868A
    public sub_386D6
    public sub_38702
    public off_38A1E
    public sub_38AC4
    public sub_38AEA
    public sub_38BEA
    public audio_unk2
    public sub_38CF8
    public sub_38DE6
    public off_38E7E
    public sub_39050
    public sub_39088
    public loc_390C8
    public byte_3930E
    public sub_3945A
    public off_395A8
    public sub_3963C
    public sub_3968A
    public sub_39700
    public audio_driver_func1E
audiodriver_timer proc far

    push    ds
loc_3863D:
    mov     ax, seg dseg
loc_38640:
    mov     ds, ax
loc_38642:
    mov     ax, word ptr audiodriverbinary
loc_38645:
    or      ax, word ptr audiodriverbinary+2
loc_38649:
    jz      short loc_38688
loc_3864B:
    cmp     word_4063A, 0
loc_38650:
    jnz     short loc_38688
loc_38652:
    cmp     word_407AA, 0
loc_38657:
    jnz     short loc_38688
loc_38659:
    inc     word_407AA
    push    cs
loc_3865E:
    call near ptr sub_39700
loc_38661:
    cmp     byte_40632, 1
loc_38666:
    jnz     short loc_3867C
loc_38668:
    cmp     audioflag2, 1
loc_3866D:
    jnz     short loc_3867C
loc_3866F:
    cmp     byte_40630, 0
loc_38674:
    jnz     short loc_3867C
loc_38676:
    push    cs
loc_38677:
    call near ptr sub_3868A
loc_3867A:
    jmp     short loc_38680
loc_3867C:
    push    cs
    call near ptr sub_3963C
loc_38680:
    push    cs
    call near ptr sub_386D6
loc_38684:
    dec     word_407AA
loc_38688:
    pop     ds
    retf
audiodriver_timer endp
sub_3868A proc far
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
loc_3868B:
    mov     bp, sp
    sub     sp, 2
    push    ds
    mov     ax, seg dseg
loc_38694:
    mov     ds, ax
    add     word_44D48, 80h ; '€'
loc_3869C:
    jmp     short loc_386B6
loc_3869E:
    mov     al, [bp+var_2]
    sub     ah, ah
    push    ax
loc_386A4:
    push    cs
loc_386A5:
    call near ptr sub_38702
loc_386A8:
    add     sp, 2
    inc     [bp+var_2]
loc_386AE:
    mov     al, byte_44290
    cmp     [bp+var_2], al
    jb      short loc_3869E
loc_386B6:
    mov     ax, word_454BA
loc_386B9:
    cmp     word_44D48, ax
    jb      short loc_386D0
    push    cs
    call near ptr sub_3963C
    mov     ax, word_454BA
    sub     word_44D48, ax
    mov     [bp+var_2], 0
    jmp     short loc_386AE
loc_386D0:
    pop     ds
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sub_3868A endp
sub_386D6 proc far
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
loc_386E2:
    mov     [bp+var_2], 10h
loc_386E6:
    mov     al, [bp+var_2]
    sub     ah, ah
    push    ax
loc_386EC:
    push    cs
loc_386ED:
    call near ptr sub_38702
loc_386F0:
    add     sp, 2
loc_386F3:
    inc     [bp+var_2]
loc_386F6:
    cmp     [bp+var_2], 17h
loc_386FA:
    jb      short loc_386E6
loc_386FC:
    pop     ds
loc_386FD:
    mov     sp, bp
loc_386FF:
    pop     bp
    retf
    ; align 2
    db 144
sub_386D6 endp
sub_38702 proc far
    var_E = byte ptr -14
    var_C = dword ptr -12
    var_8 = dword ptr -8
    var_4 = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     [bp+var_2], 0
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, 81FCh
    mov     [bp+var_4], ax
    mov     bx, ax
    mov     ax, [bx+18h]
    or      ax, [bx+1Ah]
    jz      short loc_3872D
    jmp     loc_38A98
loc_3872D:
    mov     ax, [bx]
    or      ax, [bx+2]
    jnz     short loc_38737
    jmp     loc_38AA0
loc_38737:
    mov     ax, [bx+18h]
    or      ax, [bx+1Ah]
    jz      short loc_38742
    jmp     loc_38A98
loc_38742:
    mov     ax, [bx]
    or      ax, [bx+2]
    jnz     short loc_3874C
    jmp     loc_38A98
loc_3874C:
    push    word ptr [bx+2]
    push    word ptr [bx]
    mov     ax, 728Eh
    push    ax
    push    cs
    call near ptr sub_3945A
    add     sp, 6
    mov     bx, [bp+var_4]
    mov     al, byte_42A08
    sub     ah, ah
    add     [bx], ax
    cmp     byte_42A02, 0D9h ; 'Ù'
    jnb     short loc_38770
    jmp     loc_38A44
loc_38770:
    mov     al, byte_42A03
    mov     [bp+var_2], al
    mov     al, byte_42A02
    sub     ax, 0D9h ; 'Ù'
    cmp     ax, 11h
    jbe     short loc_38784
    jmp     loc_38A67
loc_38784:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_38A1E[bx]
loc_3878C:
    mov     bx, [bp+var_4]
    cmp     byte ptr [bx+4], 0
    jz      short loc_387B2
    mov     si, [bx+4]
smart
    and     si, 0FFh
nosmart
    shl     si, 1
    shl     si, 1
    mov     ax, [bx+si+5]
    mov     dx, [bx+si+7]
    mov     [bx], ax
loc_387A8:
    mov     [bx+2], dx
    dec     byte ptr [bx+4]
    jmp     loc_38A67
    ; align 2
    db 144
loc_387B2:
    mov     ax, [bx+48h]
    mov     dx, [bx+4Ah]
    mov     word ptr [bp+var_8], ax
    mov     word ptr [bp+var_8+2], dx
    sub     ax, ax
    mov     [bx+2], ax
    mov     [bx], ax
    push    [bp+arg_0]
    push    [bp+arg_0]
    push    cs
    call near ptr audio_driver_func1E
    add     sp, 4
loc_387D2:
    mov     ax, word ptr [bp+var_8]
    or      ax, word ptr [bp+var_8+2]
    jnz     short loc_387DD
    jmp     loc_38A67
loc_387DD:
    push    [bp+arg_0]
    call    [bp+var_8]
    add     sp, 2
    jmp     loc_38A67
    ; align 2
    db 144
loc_387EA:
    mov     ax, 717Eh
    push    ax
    mov     al, byte_42A08
    sub     ah, ah
    sub     ax, 4
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 39h ; '9'
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    jmp     loc_38A64
    ; align 2
    db 144
loc_3880E:
    mov     bx, [bp+arg_0]
    mov     al, [bp+var_2]
    mov     [bx-6A6Ah], al
    jmp     loc_38A67
    ; align 2
    db 144
loc_3881C:
    mov     bx, [bp+var_4]
    inc     byte ptr [bx+4]
    mov     ax, [bx]
    mov     dx, [bx+2]
    mov     si, [bx+4]
smart
    and     si, 0FFh
nosmart
    shl     si, 1
    shl     si, 1
    mov     [bx+si+5], ax
    mov     [bx+si+7], dx
    mov     ax, word_42A04
    mov     dx, word_42A06
    add     ax, 4
    jmp     short loc_38899
loc_38844:
    mov     bx, [bp+var_4]
    sub     ax, ax
    mov     [bx+2], ax
    mov     [bx], ax
    mov     ax, [bx+48h]
    mov     dx, [bx+4Ah]
    mov     word ptr [bp+var_8], ax
    mov     word ptr [bp+var_8+2], dx
    push    [bp+arg_0]
    push    [bp+arg_0]
    push    cs
    call near ptr audio_driver_func1E
    add     sp, 4
    sub     ax, ax
    push    ax
    mov     al, byte_45950
    sub     ah, ah
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    ax
    push    [bp+arg_0]
    push    [bp+arg_0]
    call    audio_init_chunk
    add     sp, 0Eh
    jmp     loc_387D2
loc_38886:
    mov     bx, [bp+var_4]
    mov     byte ptr [bx+4], 0
    mov     byte ptr [bx+32h], 0
    mov     si, bx
    mov     ax, [si+5]
    mov     dx, [si+7]
loc_38899:
    mov     [bx], ax
    mov     [bx+2], dx
    jmp     loc_38A67
    ; align 2
    db 144
loc_388A2:
    push    [bp+var_4]
    mov     al, [bp+var_2]
    sub     ah, ah
    push    ax
    push    cs
    call near ptr sub_38AC4
    add     sp, 4
    mov     bx, [bp+var_4]
    mov     [bx+1Eh], ax
    mov     [bx+20h], dx
    cmp     byte_40634, 0
    jnz     short loc_388C5
    jmp     loc_38A67
loc_388C5:
    les     bx, [bx+1Eh]
    mov     al, es:[bx+43h]
    mov     [bp+var_E], al
    cmp     al, 10h
    jnb     short loc_388D8
    mov     bx, [bp+var_4]
    jmp     short loc_388E2
loc_388D8:
    mov     bx, [bp+var_4]
    mov     al, byte ptr [bp+arg_0]
smart
    and     al, 0Fh
nosmart
    inc     al
loc_388E2:
    mov     [bx+47h], al
    mov     al, [bx+28h]
    sub     ah, ah
    push    ax
    sub     ax, ax
    push    ax
    mov     al, [bx+47h]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 12h
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 6
    mov     bx, [bp+var_4]
    push    word ptr [bx+20h]
    push    word ptr [bx+1Eh]
    push    bx
    sub     ax, ax
    push    ax
    mov     al, [bx+47h]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 21h ; '!'
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 0Ah
    jmp     loc_38A67
loc_38936:
    cmp     [bp+arg_0], 10h
    jl      short loc_3893F
    jmp     loc_38A67
loc_3893F:
    mov     al, [bp+var_2]
    sub     ah, ah
    mov     cx, ax
    mov     ax, 7D00h
    cwd
    div     cx
    mov     word_454BA, ax
    jmp     loc_38A67
loc_38952:
    mov     al, [bp+var_2]
    sub     ah, ah
    push    ax
    push    [bp+arg_0]
    push    cs
    call near ptr audio_unk2
    jmp     loc_38A64
loc_38962:
    push    word_42A04
    mov     al, [bp+var_2]
    sub     ah, ah
    push    ax
    push    [bp+arg_0]
    push    cs
    call near ptr sub_38AEA
    add     sp, 6
    jmp     loc_38A67
    ; align 2
    db 144
loc_3897A:
    mov     bx, [bp+var_4]
    mov     al, [bp+var_2]
    mov     [bx+16h], al
    jmp     loc_38A67
loc_38986:
    mov     bx, [bp+var_4]
    mov     al, [bp+var_2]
    mov     [bx+24h], al
    jmp     loc_38A67
loc_38992:
    mov     bx, [bp+var_4]
    mov     ax, [bx]
    mov     dx, [bx+2]
    mov     si, [bx+32h]
smart
    and     si, 0FFh
nosmart
    shl     si, 1
    shl     si, 1
    mov     [bx+si+33h], ax
    mov     [bx+si+35h], dx
    mov     si, [bx+32h]
smart
    and     si, 0FFh
nosmart
    mov     al, [bp+var_2]
    dec     al
    mov     [bx+si+43h], al
    inc     byte ptr [bx+32h]
    jmp     loc_38A67
loc_389C0:
    mov     bx, [bp+var_4]
    cmp     byte ptr [bx+32h], 0
    jnz     short loc_389CC
    jmp     loc_38A67
loc_389CC:
    mov     al, [bx+32h]
    sub     ah, ah
    mov     si, ax
    mov     di, bx
    mov     bx, si
    shl     bx, 1
    shl     bx, 1
    mov     ax, [bx+di+2Fh]
    mov     dx, [bx+di+31h]
    mov     bx, di
    mov     [bx], ax
    mov     [bx+2], dx
    mov     al, [bx+si+42h]
    dec     byte ptr [bx+si+42h]
    or      al, al
    jnz     short loc_38A67
    dec     byte ptr [bx+32h]
    jmp     short loc_38A67
    ; align 2
    db 144
loc_389F8:
    mov     bx, [bp+var_4]
    mov     al, [bp+var_2]
    mov     [bx+22h], al
    jmp     short loc_38A67
    ; align 2
    db 144
loc_38A04:
    mov     bx, [bp+var_4]
    mov     al, [bp+var_2]
    mov     [bx+47h], al
    jmp     short loc_38A67
    ; align 2
    db 144
loc_38A10:
    push    word_42A04
    push    [bp+arg_0]
    push    cs
    call near ptr sub_38BEA
    jmp     short loc_38A64
    ; align 2
    db 144
off_38A1E     dw offset loc_3878C
    dw offset loc_38844
    dw offset loc_38886
    dw offset loc_388A2
    dw offset loc_38936
    dw offset loc_38952
    dw offset loc_38962
    dw offset loc_3897A
    dw offset loc_38986
    dw offset loc_38992
    dw offset loc_389C0
    dw offset loc_389F8
    dw offset loc_38A10
    dw offset loc_3881C
    dw offset loc_38A67
    dw offset loc_387EA
    dw offset loc_38A04
    dw offset loc_3880E
    jmp     short loc_38A67
loc_38A44:
    cmp     byte_42A02, 80h ; '€'
    jnb     short loc_38A54
    mov     bx, [bp+var_4]
    mov     al, [bx+22h]
    mov     byte_42A03, al
loc_38A54:
smart
    and     byte_42A02, 7Fh
nosmart
    push    [bp+arg_0]
    mov     ax, 728Eh
    push    ax
    push    cs
    call near ptr sub_38DE6
loc_38A64:
    add     sp, 4
loc_38A67:
    mov     bx, [bp+var_4]
    mov     ax, [bx]
    or      ax, [bx+2]
    jnz     short loc_38A74
    jmp     loc_38737
loc_38A74:
    push    word ptr [bx+2]
    push    word ptr [bx]
    mov     ax, 7282h
    push    ax
    push    cs
    call near ptr sub_3945A
    add     sp, 6
    mov     bx, [bp+var_4]
    mov     ax, word_429F2
    mov     dx, word_429F4
    mov     [bx+18h], ax
    mov     [bx+1Ah], dx
    jmp     loc_38737
    ; align 2
    db 144
loc_38A98:
    sub     word ptr [bx+18h], 1
    sbb     word ptr [bx+1Ah], 0
loc_38AA0:
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 4Ch ; 'L'
    imul    word ptr [bp+6]
    mov     bx, ax
    mov     al, [bp+8]
    mov     [bx-7DBDh], al
    pop     ds
    pop     bp
    retf
    ; align 2
    db 144
sub_38702 endp
sub_38AC4 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     si, [bp+arg_0]
smart
    and     si, 0FFh
nosmart
    shl     si, 1
    shl     si, 1
    mov     bx, [bp+arg_2]
    les     bx, [bx+2Eh]
    mov     ax, es:[bx+si]
    mov     dx, es:[bx+si+2]
    pop     ds
    pop     si
    pop     bp
    retf
sub_38AC4 endp
sub_38AEA proc far
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_A = word ptr -10
    var_8 = dword ptr -8
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = byte ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 12h
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, 81FCh
    mov     [bp+var_4], ax
    cmp     [bp+arg_2], 40h ; '@'
    jnz     short loc_38B12
    mov     bx, ax
    mov     al, byte ptr [bp+arg_4]
    mov     [bx+25h], al
loc_38B12:
    cmp     byte_40634, 0
    jz      short loc_38B44
    push    [bp+arg_4]
    mov     al, [bp+arg_2]
    sub     ah, ah
    push    ax
    sub     ax, ax
    push    ax
    mov     bx, [bp+var_4]
    mov     al, [bx+47h]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 15h
    mov     word ptr [bp+var_8+2], dx
    mov     word ptr [bp+var_8], ax
    call    [bp+var_8]
    add     sp, 8
loc_38B44:
    mov     [bp+var_2], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jnz     short loc_38B55
    jmp     loc_38BE3
loc_38B55:
    mov     al, [bp+arg_2]
    mov     [bp+var_A], ax
    mov     si, 0A2B6h
    mov     [bp+var_E], 0A2B7h
    mov     [bp+var_10], si
    mov     [bp+var_12], 0A2CCh
    mov     di, [bp+var_2]
loc_38B6E:
    mov     bx, [bp+var_4]
    mov     al, [si]
    cmp     [bx+23h], al
    jnz     short loc_38B9D
    cmp     byte_40634, 0
    jnz     short loc_38B9D
    push    [bp+arg_4]
    push    [bp+var_A]
    push    si
    push    di
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 15h
    mov     word ptr [bp+var_8+2], dx
    mov     word ptr [bp+var_8], ax
    call    [bp+var_8]
    add     sp, 8
loc_38B9D:
    cmp     [bp+arg_2], 40h ; '@'
    jnz     short loc_38BC4
    cmp     [bp+arg_4], 0
    jnz     short loc_38BC4
    mov     bx, [bp+var_E]
    cmp     byte ptr [bx], 2
    jnz     short loc_38BC4
    mov     bx, [bp+var_10]
    mov     al, [bx]
    mov     bx, [bp+var_4]
    cmp     [bx+23h], al
    jnz     short loc_38BC4
    mov     bx, [bp+var_12]
    mov     byte ptr [bx], 4
loc_38BC4:
    add     si, 2Eh ; '.'
    add     [bp+var_E], 2Eh ; '.'
    add     [bp+var_10], 2Eh ; '.'
    add     [bp+var_12], 2Eh ; '.'
    inc     di
    mov     ax, di
    mov     cl, byte_459D2
    sub     ch, ch
    cmp     ax, cx
    jb      short loc_38B6E
    mov     [bp+var_2], di
loc_38BE3:
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_38AEA endp
sub_38BEA proc far
    var_6 = dword ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, 81FCh
    mov     [bp+var_2], ax
    test    [bp+arg_2], 100h
    jz      short loc_38C0D
smart
    or      byte ptr [bp+arg_2], 80h
nosmart
loc_38C0D:
    mov     al, byte ptr [bp+arg_2]
    cbw
    mov     cx, [bp+arg_2]
    sub     cl, cl
    shr     cx, 1
    add     cx, ax
    sub     cx, 2000h
    mov     [bp+arg_2], cx
    mov     bx, [bp+var_2]
    mov     ax, cx
    mov     [bx+26h], ax
    mov     al, [bx+47h]
    sub     ah, ah
    push    ax
    push    cx
    push    bx
loc_38C31:
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 1Bh
    mov     word ptr [bp+var_6+2], dx
    mov     word ptr [bp+var_6], ax
    call    [bp+var_6]
    add     sp, 6
    pop     ds
    mov     sp, bp
    pop     bp
    retf
sub_38BEA endp
audio_unk2 proc far
    var_C = dword ptr -12
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = byte ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, offset audiochunks_unk
    mov     [bp+var_4], ax
    mov     bx, ax
    mov     al, [bp+arg_2]
    mov     [bx+28h], al
    cmp     byte_40634, 0
    jnz     short loc_38CC8
    mov     [bp+var_2], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jz      short loc_38CF0
    mov     al, [bp+arg_2]
    mov     [bp+var_6], ax
    mov     si, offset unk_45A26
    mov     di, [bp+var_2]
loc_38C8F:
    mov     al, [si]
    sub     ah, ah
    cmp     ax, [bp+arg_0]
    jnz     short loc_38CB3
    push    [bp+var_6]
    push    si
    push    di
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 12h
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 6
loc_38CB3:
    add     si, 2Eh ; '.'
    inc     di
    mov     ax, di
    mov     cl, byte_459D2
    sub     ch, ch
    cmp     ax, cx
    jb      short loc_38C8F
loc_38CC3:
    mov     [bp+var_2], di
    jmp     short loc_38CF0
loc_38CC8:
    mov     al, [bp+arg_2]
    sub     ah, ah
    push    ax
    sub     ax, ax
    push    ax
    mov     bx, [bp+var_4]
    mov     al, [bx+47h]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 12h
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 6
loc_38CF0:
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
audio_unk2 endp
sub_38CF8 proc far
    var_A = dword ptr -10
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = dword ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     si, ax
    mov     ax, word ptr [bp+arg_2]
    mov     dx, word ptr [bp+arg_2+2]
    mov     [si-7DE6h], ax
    mov     [si-7DE4h], dx
    les     bx, [bp+arg_2]
    cmp     byte ptr es:[bx+43h], 10h
    jnb     short loc_38D30
    mov     al, es:[bx+43h]
    mov     [si-7DBDh], al
    jmp     short loc_38D43
loc_38D30:
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     bx, ax
    mov     al, byte ptr [bp+arg_0]
smart
    and     al, 0Fh
nosmart
    inc     al
    mov     [bx-7DBDh], al
loc_38D43:
    cmp     byte_40634, 0
    jnz     short loc_38DAC
    mov     [bp+var_2], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jnz     short loc_38D5B
    jmp     loc_38DDE
loc_38D5B:
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, 81FCh
    mov     [bp+var_4], ax
    mov     si, 0A2B6h
    mov     di, [bp+var_2]
loc_38D6D:
    mov     al, [si]
    sub     ah, ah
    cmp     ax, [bp+arg_0]
    jnz     short loc_38D97
    push    word ptr [bp+arg_2+2]
    push    word ptr [bp+arg_2]
    push    [bp+var_4]
    push    si
    push    di
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 21h ; '!'
    mov     word ptr [bp+var_A+2], dx
    mov     word ptr [bp+var_A], ax
    call    [bp+var_A]
    add     sp, 0Ah
loc_38D97:
    add     si, 2Eh ; '.'
    inc     di
    mov     ax, di
    mov     cl, byte_459D2
    sub     ch, ch
    cmp     ax, cx
    jb      short loc_38D6D
    mov     [bp+var_2], di
    jmp     short loc_38DDE
loc_38DAC:
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    mov     si, ax
    push    word ptr [bp+arg_2+2]
    push    word ptr [bp+arg_2]
    add     ax, 81FCh
    push    ax
    sub     ax, ax
    push    ax
    mov     al, [si-7DBDh]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 21h ; '!'
    mov     word ptr [bp+var_A+2], dx
    mov     word ptr [bp+var_A], ax
    call    [bp+var_A]
    add     sp, 0Ah
loc_38DDE:
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sub_38CF8 endp
sub_38DE6 proc far
    var_12 = dword ptr -18
    var_E = dword ptr -14
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 12h
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_2]
    add     ax, 81FCh
    mov     [bp+var_8], ax
    mov     bx, ax
    mov     ax, [bx+1Eh]
    mov     dx, [bx+20h]
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    les     bx, [bp+var_4]
    cmp     byte ptr es:[bx+5], 5
    jz      short loc_38E1A
    jmp     loc_38E9E
loc_38E1A:
    mov     bx, [bp+arg_0]
    mov     al, [bx+4]
    sub     ah, ah
    sub     ax, 18h
    cmp     ax, 0Fh
    ja      short loc_38E74
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_38E7E[bx]
loc_38E32:
    mov     ax, word ptr basdres
    mov     dx, word ptr basdres+2
loc_38E39:
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
    jmp     short loc_38E9E
    ; align 2
    db 144
loc_38E42:
    mov     ax, word ptr snarres
    mov     dx, word ptr snarres+2
    jmp     short loc_38E39
    ; align 2
    db 144
loc_38E4C:
    mov     ax, word ptr rideres
    mov     dx, word ptr rideres+2
    jmp     short loc_38E39
    ; align 2
    db 144
loc_38E56:
    mov     ax, word ptr crshres
    mov     dx, word ptr crshres+2
    jmp     short loc_38E39
    ; align 2
    db 144
loc_38E60:
    mov     ax, word ptr chhtres
    mov     dx, word ptr chhtres+2
    jmp     short loc_38E39
    ; align 2
    db 144
loc_38E6A:
    mov     ax, word ptr ohhtres
    mov     dx, word ptr ohhtres+2
    jmp     short loc_38E39
    ; align 2
    db 144
loc_38E74:
    mov     ax, word ptr tommres
    mov     dx, word ptr tommres+2
    jmp     short loc_38E39
    ; align 2
    db 144
off_38E7E     dw offset loc_38E32
    dw offset loc_38E74
    dw offset loc_38E42
    dw offset loc_38E74
    dw offset loc_38E74
    dw offset loc_38E74
    dw offset loc_38E60
    dw offset loc_38E74
    dw offset loc_38E6A
    dw offset loc_38E74
    dw offset loc_38E6A
    dw offset loc_38E74
    dw offset loc_38E74
    dw offset loc_38E4C
    dw offset loc_38E74
    dw offset loc_38E56
loc_38E9E:
    mov     ax, word ptr [bp+var_4]
    or      ax, word ptr [bp+var_4+2]
    jnz     short loc_38EB0
loc_38EA6:
    mov     ax, 0FFFFh
    pop     ds
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_38EB0:
    push    [bp+var_8]
    push    word ptr [bp+var_4+2]
    push    word ptr [bp+var_4]
    push    cs
    call near ptr loc_390C8
    add     sp, 6
    mov     [bp+var_6], ax
    cmp     ax, 0FFFFh
    jz      short loc_38EA6
    mov     ax, 2Eh ; '.'
    imul    [bp+var_6]
    add     ax, 0A2B6h
    mov     [bp+var_A], ax
    mov     bx, ax
    mov     ax, word ptr [bp+var_4]
    mov     dx, word ptr [bp+var_4+2]
    cmp     [bx+10h], ax
    jnz     short loc_38EE6
    cmp     [bx+12h], dx
    jz      short loc_38F18
loc_38EE6:
    mov     ax, word ptr [bp+var_4]
    mov     dx, word ptr [bp+var_4+2]
    mov     [bx+10h], ax
    mov     [bx+12h], dx
    cmp     byte_40634, 0
    jnz     short loc_38F18
    push    dx
    push    ax
    push    [bp+var_8]
    push    bx
    push    [bp+var_6]
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 21h ; '!'
    mov     word ptr [bp+var_E+2], dx
    mov     word ptr [bp+var_E], ax
    call    [bp+var_E]
    add     sp, 0Ah
loc_38F18:
    mov     bx, [bp+var_A]
    mov     al, byte ptr [bp+arg_2]
    mov     [bx], al
    mov     ax, [bp+var_8]
    mov     [bx+2Ah], ax
    mov     byte ptr [bx+1], 1
    mov     byte ptr [bx+16h], 1
    mov     si, bx
    les     si, [si+10h]
    mov     ax, es:[si+1Ch]
    mov     [bx+14h], ax
    mov     si, [bp+var_8]
    mov     al, [si+24h]
    mov     [bx+2], al
    sub     ax, ax
    mov     [bx+0Ah], ax
    mov     [bx+8], ax
    mov     si, [bp+arg_0]
    mov     ax, [si+6]
    mov     dx, [si+8]
    sub     ax, 1
    sbb     dx, 0
    mov     [bx+0Ch], ax
    mov     [bx+0Eh], dx
    les     si, [bp+var_4]
    mov     ax, es:[si+2Ah]
    mov     [bx+18h], ax
    mov     ax, es:[si+2Ch]
    mov     [bx+1Ah], ax
    mov     ax, es:[si+30h]
    mov     [bx+24h], ax
    mov     word ptr [bx+1Ch], 0
    mov     al, es:[si+34h]
    mov     [bx+26h], al
    mov     byte ptr [bx+27h], 0
    mov     ax, es:[si+36h]
    mov     [bx+1Eh], ax
    mov     ax, es:[si+38h]
    mov     [bx+20h], ax
    mov     byte ptr [bx+28h], 0
    mov     byte ptr [bx+22h], 0
    mov     byte ptr [bx+29h], 0
    cmp     byte_40634, 0
    jnz     short loc_38FAE
    mov     al, byte ptr [bp+var_6]
    jmp     short loc_38FB4
loc_38FAE:
    mov     si, [bp+var_8]
    mov     al, [si+47h]
loc_38FB4:
    mov     [bx+2Ch], al
    mov     bx, [bp+arg_0]
    cmp     byte ptr [bx+4], 0FFh
    jnz     short loc_38FF2
    push    word ptr [bx]
    push    [bp+var_A]
    mov     bx, [bp+var_A]
    mov     al, [bx+2Ch]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
loc_38FD1:
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 24h ; '$'
    mov     word ptr [bp+var_E+2], dx
    mov     word ptr [bp+var_E], ax
    call    [bp+var_E]
    add     sp, 6
loc_38FE4:
    cmp     byte_40634, 0
loc_38FE9:
    jz      short loc_38FF2
loc_38FEB:
    mov     bx, [bp+arg_0]
loc_38FEE:
    mov     byte ptr [bx+4], 3Ch ; '<'
loc_38FF2:
    push    word ptr [bp+var_4+2]
    push    word ptr [bp+var_4]
    mov     bx, [bp+arg_0]
    mov     al, [bx+5]
    sub     ah, ah
    push    ax
    les     bx, [bp+var_4]
    mov     al, es:[bx+10h]
    cbw
    mov     bx, [bp+arg_0]
    mov     cx, ax
    mov     al, [bx+4]
    cbw
    add     ax, cx
    push    ax
    push    [bp+var_8]
    push    [bp+var_A]
    mov     bx, [bp+var_A]
    mov     al, [bx+2Ch]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 9
    mov     word ptr [bp+var_12+2], dx
    mov     word ptr [bp+var_12], ax
    call    [bp+var_12]
    add     sp, 0Eh
    mov     bx, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     al, [si+4]
    mov     byte_44ACA[bx], al
    mov     ax, [bp+var_6]
    pop     ds
    pop     si
    mov     sp, bp
    pop     bp
    retf
sub_38DE6 endp
sub_39050 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     byte_42A0E, 0FFh
    mov     ax, [bp+arg_0]
    mov     word_42A0A, ax
    mov     word_42A0C, 0
    mov     word_42A10, 0FFE0h
    mov     word_42A12, 0FFFFh
    push    [bp+arg_2]
    mov     ax, 729Ah
    push    ax
    push    cs
    call near ptr sub_38DE6
loc_39081:
    add     sp, 4
    pop     ds
    pop     bp
    retf
    ; align 2
    db 144
sub_39050 endp
sub_39088 proc far
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, 2Eh ; '.'
    imul    [bp+arg_0]
    mov     si, ax
    push    [bp+arg_2]
    add     ax, 0A2B6h
    push    ax
    mov     al, [si-5D1Eh]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 24h ; '$'
    mov     word ptr [bp+var_4+2], dx
    mov     word ptr [bp+var_4], ax
    call    [bp+var_4]
    add     sp, 6
    pop     ds
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_390C8:
    push    bp
    mov     bp, sp
    sub     sp, 1Ah
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     word ptr [bp-10h], 0FFFFh
    mov     word ptr [bp-0Eh], 0FFFFh
    sub     ax, ax
    mov     [bp-8], ax
    mov     [bp-0Ah], ax
    mov     [bp-2], ax
    mov     [bp-4], ax
    les     bx, [bp+6]
    cmp     es:[bx+0Ch], ax
    jnz     short loc_390FE
loc_390F7:
    mov     ax, 0FFFFh
    jmp     loc_39452
    ; align 2
    db 144
loc_390FE:
    cmp     byte_40634, 0
    jnz     short loc_39108
    jmp     loc_391F0
loc_39108:
    sub     si, si
    mov     di, 0A2B6h
loc_3910D:
    mov     cx, di
    mov     bx, cx
    cmp     byte ptr [bx+1], 0
    jnz     short loc_39122
loc_39117:
    mov     ax, si
    mov     [bp-6], si
    mov     [bp-0Ch], cx
    jmp     loc_39452
loc_39122:
    mov     bx, cx
    cmp     byte ptr [bx+1], 1
    jnz     short loc_3914D
    mov     ax, [bp-0Ah]
    mov     dx, [bp-8]
    cmp     [bx+0Ah], dx
    jb      short loc_3914D
    ja      short loc_3913C
    cmp     [bx+8], ax
    jbe     short loc_3914D
loc_3913C:
    mov     bx, cx
    mov     ax, [bx+8]
    mov     dx, [bx+0Ah]
    mov     [bp-0Ah], ax
    mov     [bp-8], dx
    mov     [bp-10h], si
loc_3914D:
    mov     bx, cx
    cmp     byte ptr [bx+1], 2
    jnz     short loc_39178
    mov     ax, [bp-4]
    mov     dx, [bp-2]
    cmp     [bx+0Ah], dx
    jb      short loc_39178
    ja      short loc_39167
    cmp     [bx+8], ax
    jbe     short loc_39178
loc_39167:
    mov     bx, cx
    mov     ax, [bx+8]
    mov     dx, [bx+0Ah]
    mov     [bp-4], ax
    mov     [bp-2], dx
    mov     [bp-0Eh], si
loc_39178:
    add     di, 2Eh ; '.'
    inc     si
    cmp     si, 10h
    jl      short loc_3910D
    mov     [bp-6], si
    mov     [bp-0Ch], cx
    cmp     word ptr [bp-0Eh], 0FFFFh
    jz      short loc_39194
loc_3918D:
    mov     ax, [bp-0Eh]
    jmp     loc_39452
    ; align 2
    db 144
loc_39194:
    cmp     word ptr [bp-10h], 0FFFFh
    jnz     short loc_3919D
    jmp     loc_390F7
loc_3919D:
    mov     ax, 2Eh ; '.'
    imul    word ptr [bp-10h]
    mov     si, ax
    add     ax, 0A2B6h
    push    ax
    mov     al, [si-5D1Eh]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 0Ch
    mov     [bp-14h], dx
    mov     [bp-16h], ax
    call    dword ptr [bp-16h]
    add     sp, 4
    mov     ax, si
    add     ax, 0A2B6h
    push    ax
    mov     al, [si-5D1Eh]
    sub     ah, ah
    push    ax
loc_391D3:
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 0Fh
    mov     [bp-14h], dx
    mov     [bp-16h], ax
    call    dword ptr [bp-16h]
    add     sp, 4
    mov     ax, [bp-10h]
    jmp     loc_39452
    ; align 2
    db 144
loc_391F0:
    mov     bx, [bp+0Ah]
    mov     si, bx
    mov     al, [si+16h]
    cmp     [bx+15h], al
    jnb     short loc_39200
    jmp     loc_39344
loc_39200:
    mov     word ptr [bp-6], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jnz     short loc_39211
    jmp     loc_392C5
loc_39211:
    mov     [bp-12h], ax
    mov     word ptr [bp-18h], 4E9Eh
    mov     word ptr [bp-1Ah], 0A2B6h
    mov     di, [bp-6]
    mov     si, [bp-0Ch]
    mov     cx, bx
loc_39226:
    mov     bx, [bp-18h]
    mov     ax, [bx]
    les     bx, [bp+6]
    test    es:[bx+0Ch], ax
    jz      short loc_392AC
    mov     si, [bp-1Ah]
    mov     bx, cx
    mov     al, [si]
    cmp     [bx+23h], al
    jnz     short loc_392AC
    cmp     byte ptr [si+1], 0
    jnz     short loc_39254
    inc     byte ptr [bx+15h]
    mov     ax, di
    mov     [bp-6], di
    mov     [bp-0Ch], si
    jmp     loc_39452
loc_39254:
    mov     bx, cx
    mov     al, [si+2]
    cmp     [bx+24h], al
    jb      short loc_392AC
    cmp     byte ptr [si+1], 1
    jnz     short loc_39285
    mov     ax, [bp-0Ah]
    mov     dx, [bp-8]
    cmp     [si+0Ah], dx
    jb      short loc_39285
    ja      short loc_39276
    cmp     [si+8], ax
    jbe     short loc_39285
loc_39276:
    mov     ax, [si+8]
    mov     dx, [si+0Ah]
    mov     [bp-0Ah], ax
    mov     [bp-8], dx
    mov     [bp-10h], di
loc_39285:
    cmp     byte ptr [si+1], 2
    jnz     short loc_392AC
    mov     ax, [bp-4]
    mov     dx, [bp-2]
    cmp     [si+0Ah], dx
    jb      short loc_392AC
    ja      short loc_3929D
    cmp     [si+8], ax
    jbe     short loc_392AC
loc_3929D:
    mov     ax, [si+8]
    mov     dx, [si+0Ah]
    mov     [bp-4], ax
    mov     [bp-2], dx
    mov     [bp-0Eh], di
loc_392AC:
    add     word ptr [bp-18h], 2
    add     word ptr [bp-1Ah], 2Eh ; '.'
    inc     di
    mov     ax, di
    cmp     ax, [bp-12h]
    jnb     short loc_392BF
    jmp     loc_39226
loc_392BF:
    mov     [bp-6], di
    mov     [bp-0Ch], si
loc_392C5:
    cmp     word ptr [bp-0Eh], 0FFFFh
    jz      short near ptr byte_3930E
loc_392CB:
    mov     ax, 2Eh ; '.'
    imul    word ptr [bp-0Eh]
    mov     si, ax
    add     si, 0A2B6h
    push    si
    push    word ptr [bp-0Eh]
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 0Ch
    mov     [bp-14h], dx
    mov     [bp-16h], ax
    call    dword ptr [bp-16h]
    add     sp, 4
    push    si
    push    word ptr [bp-0Eh]
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 0Fh
    mov     [bp-14h], dx
    mov     [bp-16h], ax
    call    dword ptr [bp-16h]
    add     sp, 4
    jmp     loc_3918D
byte_3930E     db 131
    db 126
    db 240
    push    word ptr [di+3]
    jmp     loc_390F7
loc_39317:
    mov     ax, 2Eh ; '.'
    imul    word ptr [bp-10h]
    mov     si, ax
    add     si, 0A2B6h
    push    si
    push    word ptr [bp-10h]
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 0Ch
    mov     [bp-14h], dx
    mov     [bp-16h], ax
    call    dword ptr [bp-16h]
    add     sp, 4
    push    si
    push    word ptr [bp-10h]
    jmp     loc_391D3
loc_39344:
    mov     word ptr [bp-6], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jnz     short loc_39355
    jmp     loc_39401
loc_39355:
    mov     [bp-1Ah], ax
    mov     di, 0A2B6h
    mov     word ptr [bp-12h], 4E9Eh
    mov     si, [bp-6]
loc_39363:
    mov     cx, di
    mov     bx, [bp-12h]
    mov     ax, [bx]
    les     bx, [bp+6]
    test    es:[bx+0Ch], ax
    jz      short loc_393E9
    mov     bx, cx
    cmp     byte ptr [bx+1], 0
    jnz     short loc_39386
    mov     bx, [bp+0Ah]
    inc     byte ptr [bx+15h]
    jmp     loc_39117
    db 144
    db 144
loc_39386:
    mov     bx, cx
loc_39388:
    mov     al, [bx+2]
loc_3938B:
    mov     bx, [bp+0Ah]
loc_3938E:
    cmp     [bx+24h], al
    jb      short loc_393E9
    mov     bx, cx
loc_39395:
    cmp     byte ptr [bx+1], 1
    jnz     short loc_393BE
    mov     ax, [bp-0Ah]
    mov     dx, [bp-8]
    cmp     [bx+0Ah], dx
    jb      short loc_393BE
    ja      short loc_393AD
    cmp     [bx+8], ax
    jbe     short loc_393BE
loc_393AD:
    mov     bx, cx
    mov     ax, [bx+8]
    mov     dx, [bx+0Ah]
    mov     [bp-0Ah], ax
    mov     [bp-8], dx
    mov     [bp-10h], si
loc_393BE:
    mov     bx, cx
    cmp     byte ptr [bx+1], 2
    jnz     short loc_393E9
    mov     ax, [bp-4]
    mov     dx, [bp-2]
    cmp     [bx+0Ah], dx
    jb      short loc_393E9
    ja      short loc_393D8
    cmp     [bx+8], ax
    jbe     short loc_393E9
loc_393D8:
    mov     bx, cx
    mov     ax, [bx+8]
    mov     dx, [bx+0Ah]
    mov     [bp-4], ax
    mov     [bp-2], dx
    mov     [bp-0Eh], si
loc_393E9:
    add     di, 2Eh ; '.'
    add     word ptr [bp-12h], 2
    inc     si
    mov     ax, si
    cmp     ax, [bp-1Ah]
    jnb     short loc_393FB
    jmp     loc_39363
loc_393FB:
    mov     [bp-6], si
    mov     [bp-0Ch], cx
loc_39401:
    cmp     word ptr [bp-0Eh], 0FFFFh
    jz      short loc_39428
    mov     ax, 2Eh ; '.'
    imul    word ptr [bp-0Eh]
    mov     bx, ax
    mov     si, [bx-5D20h]
    cmp     [bp+0Ah], si
    jnz     short loc_3941B
    jmp     loc_392CB
loc_3941B:
    dec     byte ptr [si+15h]
    mov     bx, [bp+0Ah]
    inc     byte ptr [bx+15h]
    jmp     loc_392CB
    ; align 2
    db 144
loc_39428:
    cmp     word ptr [bp-10h], 0FFFFh
    jnz     short loc_39431
    jmp     loc_390F7
loc_39431:
    mov     ax, 2Eh ; '.'
loc_39434:
    imul    word ptr [bp-10h]
    mov     bx, ax
    mov     si, [bx-5D20h]
    cmp     [bp+0Ah], si
    jnz     short loc_39445
    jmp     loc_39317
loc_39445:
    dec     byte ptr [si+15h]
    mov     bx, [bp+0Ah]
    inc     byte ptr [bx+15h]
    jmp     loc_39317
    ; align 2
    db 144
loc_39452:
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sub_39088 endp
sub_3945A proc far
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = byte ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = dword ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     ax, word ptr [bp+arg_2]
    mov     dx, word ptr [bp+arg_2+2]
    mov     [bp+var_6], ax
    mov     [bp+var_4], dx
    mov     bx, [bp+arg_0]
    sub     ax, ax
    mov     [bx+2], ax
    mov     [bx], ax
    mov     si, bx
loc_39480:
    les     bx, [bp+arg_2]
    mov     al, es:[bx]
    sub     ah, ah
smart
    and     ax, 7Fh
nosmart
    sub     dx, dx
    mov     cx, [si]
    mov     bx, [si+2]
    mov     di, cx
    mov     cl, 7
loc_39496:
    shl     di, 1
    rcl     bx, 1
    dec     cl
    jnz     short loc_39496
    add     ax, di
    adc     dx, bx
    mov     [si], ax
    mov     [si+2], dx
    les     bx, [bp+arg_2]
    inc     word ptr [bp+arg_2]
    test    byte ptr es:[bx], 80h
    jnz     short loc_39480
    mov     bx, [bp+arg_0]
    mov     si, word ptr [bp+arg_2]
    inc     word ptr [bp+arg_2]
    mov     al, es:[si]
    mov     [bx+4], al
    mov     [bp+var_8], al
    sub     ah, ah
    sub     ax, 0D9h ; 'Ù'
    cmp     ax, 11h
    jbe     short loc_394D2
    jmp     loc_395CC
loc_394D2:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_395A8[bx]
loc_394DA:
    mov     [bp+var_2], 0
    mov     bx, word ptr [bp+arg_2]
    mov     al, es:[bx]
    sub     ah, ah
    or      ax, ax
    jz      short loc_39518
    mov     [bp+var_A], ax
    mov     [bp+var_C], ax
    mov     bx, [bp+var_2]
    mov     ax, bx
    add     ax, word ptr [bp+arg_2]
    mov     dx, es
    inc     ax
    mov     cx, [bp+var_C]
    shr     cx, 1
    lea     di, [bx+717Eh]
    mov     si, ax
    push    ds
    pop     es
    push    ds
    mov     ds, dx
    repne movsw
    jnb     short loc_39511
    movsb
loc_39511:
    pop     ds
    mov     ax, [bp+var_C]
    add     [bp+var_2], ax
loc_39518:
    les     bx, [bp+arg_2]
    mov     al, es:[bx]
    sub     ah, ah
    add     word ptr [bp+arg_2], ax
    inc     word ptr [bp+arg_2]
    jmp     loc_395CC
    ; align 2
    db 144
loc_3952A:
    mov     bx, [bp+arg_0]
loc_3952D:
    mov     si, word ptr [bp+arg_2]
    inc     word ptr [bp+arg_2]
    mov     al, es:[si]
    mov     [bx+5], al
    push    es
    push    word ptr [bp+arg_2]
    call    audioresource_get_dword
    add     sp, 4
    mov     bx, [bp+arg_0]
    mov     [bx+6], ax
    mov     [bx+8], dx
    add     word ptr [bp+arg_2], 4
    jmp     short loc_395CC
loc_39554:
    mov     bx, [bp+arg_0]
    les     si, [bp+arg_2]
    inc     word ptr [bp+arg_2]
    mov     al, es:[si]
    mov     [bx+5], al
    jmp     short loc_395CC
    ; align 2
    db 144
loc_39566:
    mov     bx, [bp+arg_0]
    mov     si, word ptr [bp+arg_2]
    inc     word ptr [bp+arg_2]
    mov     al, es:[si]
    mov     [bx+5], al
    mov     si, word ptr [bp+arg_2]
    inc     word ptr [bp+arg_2]
    mov     al, es:[si]
    sub     ah, ah
    mov     [bx+6], ax
    mov     word ptr [bx+8], 0
    jmp     short loc_395CC
loc_3958A:
    push    es
    push    word ptr [bp+arg_2]
    call    audioresource_get_word
    add     sp, 4
    mov     bx, [bp+arg_0]
    mov     [bx+6], ax
    mov     word ptr [bx+8], 0
    add     word ptr [bp+arg_2], 2
    jmp     short loc_395CC
    ; align 2
    db 144
off_395A8     dw offset loc_395CC
    dw offset loc_395CC
    dw offset loc_395CC
    dw offset loc_39554
    dw offset loc_39554
    dw offset loc_39554
    dw offset loc_39566
    dw offset loc_39554
    dw offset loc_39554
    dw offset loc_39554
    dw offset loc_395CC
    dw offset loc_39554
    dw offset loc_3958A
    dw offset loc_3952A
    dw offset loc_39518
    dw offset loc_394DA
    dw offset loc_39554
    dw offset loc_39554
loc_395CC:
    cmp     [bp+var_8], 0D9h ; 'Ù'
    jnb     short loc_39629
    cmp     [bp+var_8], 80h ; '€'
    jbe     short loc_395E7
    mov     bx, [bp+arg_0]
    les     si, [bp+arg_2]
    inc     word ptr [bp+arg_2]
    mov     al, es:[si]
    mov     [bx+5], al
loc_395E7:
    mov     bx, [bp+arg_0]
    sub     ax, ax
    mov     [bx+8], ax
    mov     [bx+6], ax
    mov     si, bx
loc_395F4:
    les     bx, [bp+arg_2]
    mov     al, es:[bx]
    sub     ah, ah
smart
    and     ax, 7Fh
nosmart
    sub     dx, dx
    mov     cx, [si+6]
    mov     bx, [si+8]
    mov     di, cx
    mov     cl, 7
loc_3960B:
    shl     di, 1
    rcl     bx, 1
    dec     cl
    jnz     short loc_3960B
    add     ax, di
    adc     dx, bx
    mov     [si+6], ax
    mov     [si+8], dx
    les     bx, [bp+arg_2]
    inc     word ptr [bp+arg_2]
    test    byte ptr es:[bx], 80h
    jnz     short loc_395F4
loc_39629:
    mov     bx, [bp+arg_0]
    mov     ax, word ptr [bp+arg_2]
    sub     ax, [bp+var_6]
    mov     [bx+0Ah], al
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_3945A endp
sub_3963C proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     [bp+var_2], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jz      short loc_39683
    mov     di, 0A2B6h
loc_3965B:
    mov     si, di
    cmp     byte ptr [si+1], 0
    jz      short loc_39670
    cmp     byte ptr [si], 10h
    jnb     short loc_39670
    push    si
    push    cs
    call near ptr sub_3968A
    add     sp, 2
loc_39670:
    add     di, 2Eh ; '.'
    inc     [bp+var_2]
    mov     al, byte_459D2
    sub     ah, ah
    cmp     [bp+var_2], ax
    jb      short loc_3965B
    mov     [bp+var_4], si
loc_39683:
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_3963C endp
sub_3968A proc far
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     bx, [bp+arg_0]
    add     word ptr [bx+8], 1
    adc     word ptr [bx+0Ah], 0
    mov     ax, [bx+0Ch]
    or      ax, [bx+0Eh]
    jnz     short loc_396F2
    push    bx
    mov     al, [bx+2Ch]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 0Ch
loc_396BA:
    mov     word ptr [bp+var_4+2], dx
    mov     word ptr [bp+var_4], ax
    call    [bp+var_4]
    add     sp, 4
    mov     bx, [bp+arg_0]
    mov     byte ptr [bx+1], 2
    mov     al, 4Ch ; 'L'
    mul     byte ptr [bx]
    mov     bx, ax
    cmp     byte ptr [bx-7DDFh], 0
    jz      short loc_396E6
    mov     bx, [bp+arg_0]
    mov     byte ptr [bx+16h], 3
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_396E6:
    mov     bx, [bp+arg_0]
    mov     byte ptr [bx+16h], 4
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_396F2:
    sub     word ptr [bx+0Ch], 1
    sbb     word ptr [bx+0Eh], 0
    pop     ds
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sub_3968A endp
sub_39700 proc far
    var_C = dword ptr -12
    var_8 = word ptr -8
    var_6 = dword ptr -6
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    mov     [bp+var_2], 0
    jmp     loc_398D0
    ; align 2
    db 144
loc_39716:
    mov     bx, [bp+var_8]
    mov     byte ptr [bx+16h], 2
loc_3971D:
    cmp     byte ptr [bx+16h], 2
loc_39721:
    jnz     short loc_3973D
    les     si, [bp+var_6]
    mov     ax, es:[si+22h]
loc_3972A:
    sub     [bx+14h], ax
    mov     ax, es:[si+24h]
    cmp     [bx+14h], ax
loc_39734:
    jg      short loc_3973D
loc_39736:
    mov     byte ptr [bx+16h], 3
    mov     [bx+14h], ax
loc_3973D:
    cmp     byte ptr [bx+16h], 3
    jnz     short loc_39754
    les     bx, [bp+var_6]
    cmp     word ptr es:[bx+24h], 0
    jnz     short loc_39754
    mov     bx, [bp+var_8]
    mov     byte ptr [bx+16h], 4
loc_39754:
    mov     bx, [bp+var_8]
    cmp     byte ptr [bx+16h], 4
    jnz     short loc_397B1
    les     si, [bp+var_6]
    mov     ax, es:[si+26h]
    sub     [bx+14h], ax
    cmp     word ptr [bx+14h], 0
    jg      short loc_397B1
    mov     word ptr [bx+14h], 0
    mov     byte ptr [bx+16h], 0
    mov     byte ptr [bx+1], 0
    mov     al, 4Ch ; 'L'
    mul     byte ptr [bx]
    mov     bx, ax
    dec     (audiochunks_unk+15h)[bx]
    push    [bp+var_8]
    mov     bx, [bp+var_8]
    mov     al, [bx+2Ch]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 0Fh
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 4
    mov     bx, [bp+var_8]
    mov     bl, [bx]
    sub     bh, bh
    mov     byte_44ACA[bx], bh
loc_397B1:
    les     bx, [bp+var_6]
    cmp     byte ptr es:[bx+28h], 0
    jnz     short loc_397BE
    jmp     loc_39853
loc_397BE:
    mov     bx, [bp+var_8]
    cmp     word ptr [bx+18h], 0
    jz      short loc_397CE
    dec     word ptr [bx+18h]
    jmp     loc_39853
    ; align 2
    db 144
loc_397CE:
    cmp     word ptr [bx+1Ah], 0
    jz      short loc_39853
    cmp     word ptr [bx+1Ah], 7FFFh
    jz      short loc_397DE
    dec     word ptr [bx+1Ah]
loc_397DE:
    cmp     byte ptr [bx+27h], 0
    jnz     short loc_39850
    les     si, [bp+var_6]
    mov     al, es:[si+29h]
    mov     [bx+27h], al
    cmp     byte ptr [bx+26h], 2
    jnz     short loc_39828
    mov     si, bx
    mov     ax, [si+24h]
    sub     [bx+1Ch], ax
    mov     ax, [bx+1Ch]
    cwd
    xor     ax, dx
    sub     ax, dx
    mov     bx, word ptr [bp+var_6]
    cmp     es:[bx+2Eh], ax
    ja      short loc_39853
    test    byte ptr es:[bx+34h], 1
    jz      short loc_3981E
    mov     bx, si
    mov     byte ptr [bx+26h], 1
    jmp     short loc_39853
    db 144
    db 144
loc_3981E:
    mov     bx, [bp+var_8]
    mov     word ptr [bx+1Ch], 0
    jmp     short loc_39853
loc_39828:
    mov     si, bx
    mov     ax, [si+24h]
    add     [bx+1Ch], ax
    mov     ax, [bx+1Ch]
    cwd
    xor     ax, dx
    sub     ax, dx
    mov     bx, word ptr [bp+var_6]
    cmp     es:[bx+2Eh], ax
    ja      short loc_39853
    test    byte ptr es:[bx+34h], 2
    jz      short loc_3981E
    mov     bx, si
    mov     byte ptr [bx+26h], 2
    jmp     short loc_39853
loc_39850:
    dec     byte ptr [bx+27h]
loc_39853:
    les     bx, [bp+var_6]
    cmp     byte ptr es:[bx+35h], 0
    jz      short loc_398A4
    mov     bx, [bp+var_8]
    cmp     word ptr [bx+1Eh], 0
    jz      short loc_3986C
    dec     word ptr [bx+1Eh]
    jmp     short loc_398A4
    ; align 2
    db 144
loc_3986C:
    cmp     word ptr [bx+20h], 0
    jz      short loc_398A4
    dec     word ptr [bx+20h]
    cmp     byte ptr [bx+28h], 0
    jz      short loc_39880
    dec     byte ptr [bx+28h]
    jmp     short loc_398A4
loc_39880:
    les     si, [bp+var_6]
    mov     al, es:[si+3Ah]
    mov     [bx+28h], al
    mov     al, [bx+29h]
    inc     byte ptr [bx+29h]
    sub     ah, ah
    mov     si, ax
smart
    and     si, 7
nosmart
    mov     bx, word ptr [bp+var_6]
    mov     al, es:[bx+si+3Bh]
    mov     bx, [bp+var_8]
    mov     [bx+22h], al
loc_398A4:
    mov     bx, [bp+var_8]
    push    word ptr [bx+12h]
    push    word ptr [bx+10h]
    push    word ptr [bx+2Ah]
    push    bx
    mov     al, [bx+2Ch]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 27h ; '''
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 0Ah
loc_398CD:
    inc     [bp+var_2]
loc_398D0:
    mov     al, byte_459D2
    sub     ah, ah
    cmp     [bp+var_2], ax
    jnb     short loc_39946
    mov     ax, 2Eh ; '.'
    imul    [bp+var_2]
    add     ax, 0A2B6h
    mov     [bp+var_8], ax
    mov     bx, ax
    cmp     byte ptr [bx+1], 0
loc_398EC:
    jz      short loc_398CD
    cmp     byte ptr [bx], 0Fh
    jbe     short loc_398FB
    push    ax
    push    cs
    call near ptr sub_3968A
    add     sp, 2
loc_398FB:
    mov     bx, [bp+var_8]
    mov     ax, [bx+10h]
    mov     dx, [bx+12h]
    mov     word ptr [bp+var_6], ax
    mov     word ptr [bp+var_6+2], dx
loc_3990A:
    cmp     byte ptr [bx+16h], 1
loc_3990E:
    jz      short loc_39913
    jmp     loc_3971D
loc_39913:
    les     si, [bp+var_6]
    mov     ax, es:[si+20h]
    add     [bx+14h], ax
    mov     ax, es:[si+1Eh]
    cmp     [bx+14h], ax
    jge     short loc_39929
    jmp     loc_3971D
loc_39929:
    mov     [bx+14h], ax
    mov     bx, si
    mov     ax, es:[bx+1Eh]
    cmp     es:[bx+24h], ax
    jge     short loc_3993B
    jmp     loc_39716
loc_3993B:
    mov     bx, [bp+var_8]
    mov     byte ptr [bx+16h], 3
    jmp     loc_3971D
    ; align 2
    db 144
loc_39946:
    mov     ax, 0A2B6h
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 30h ; '0'
    mov     word ptr [bp+var_C+2], dx
    mov     word ptr [bp+var_C], ax
    call    [bp+var_C]
    add     sp, 2
    pop     ds
    pop     si
    mov     sp, bp
    pop     bp
    retf
sub_39700 endp
audio_driver_func1E proc far
    var_16 = dword ptr -22
    var_12 = word ptr -18
    var_10 = dword ptr -16
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    di
    push    si
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    cmp     byte_40634, 0
    jz      short loc_3997E
    jmp     loc_39A04
loc_3997E:
    mov     [bp+var_2], 0
    mov     al, byte_459D2
    sub     ah, ah
    or      ax, ax
    jnz     short loc_3998F
loc_3998C:
    jmp     loc_39A9E
loc_3998F:
    mov     si, 0A2B6h
    mov     [bp+var_8], 0A2B7h
    mov     [bp+var_A], 0A2C6h
    mov     [bp+var_C], 0A2B8h
loc_399A1:
    mov     di, [bp+var_2]
loc_399A4:
    mov     al, [si]
    sub     ah, ah
    cmp     ax, [bp+arg_2]
    ja      short loc_399E2
    cmp     ax, [bp+arg_0]
    jb      short loc_399E2
    push    di
loc_399B3:
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 1Eh
    mov     word ptr [bp+var_10+2], dx
loc_399C0:
    mov     word ptr [bp+var_10], ax
    call    [bp+var_10]
    add     sp, 2
    mov     bx, [bp+var_8]
    mov     byte ptr [bx], 0
    mov     bx, [bp+var_A]
    sub     ax, ax
loc_399D4:
    mov     [bx+2], ax
    mov     [bx], ax
    mov     byte ptr [si], 0FFh
loc_399DC:
    mov     bx, [bp+var_C]
    mov     byte ptr [bx], 0
loc_399E2:
    add     si, 2Eh ; '.'
    add     [bp+var_8], 2Eh ; '.'
    add     [bp+var_A], 2Eh ; '.'
    add     [bp+var_C], 2Eh ; '.'
    inc     di
loc_399F2:
    mov     ax, di
    mov     cl, byte_459D2
    sub     ch, ch
    cmp     ax, cx
    jb      short loc_399A4
    mov     [bp+var_2], di
    jmp     loc_39A9E
loc_39A04:
    mov     ax, [bp+arg_0]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_2]
    cmp     [bp+var_2], ax
    jle     short loc_39A15
    jmp     loc_39A9E
loc_39A15:
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
    add     ax, 8243h
    mov     [bp+var_12], ax
loc_39A21:
    mov     bx, [bp+var_12]
    cmp     byte ptr [bx], 10h
    jnb     short loc_39A8F
    mov     al, [bx]
    sub     ah, ah
    push    ax
    mov     ax, word ptr audiodriverbinary
    mov     dx, word ptr audiodriverbinary+2
    add     ax, 1Eh
    mov     word ptr [bp+var_16+2], dx
    mov     word ptr [bp+var_16], ax
    call    [bp+var_16]
    add     sp, 2
    mov     [bp+var_4], 10h
    mov     si, 0A2B6h
    mov     di, 0A2B7h
    mov     [bp+var_A], 0A2C6h
loc_39A54:
    mov     [bp+var_8], 0A2B8h
    mov     [bp+var_6], 10h
    mov     cx, 10h
loc_39A61:
    mov     al, [si]
    sub     ah, ah
    cmp     [bp+var_2], ax
    jnz     short loc_39A7F
    mov     [di], ah
    mov     bx, [bp+var_A]
    sub     ax, ax
    mov     [bx+2], ax
    mov     [bx], ax
    mov     byte ptr [si], 0FFh
    mov     bx, [bp+var_8]
    mov     byte ptr [bx], 0
loc_39A7F:
    add     si, 2Eh ; '.'
loc_39A82:
    add     di, 2Eh ; '.'
    add     [bp+var_A], 2Eh ; '.'
    add     [bp+var_8], 2Eh ; '.'
    loop    loc_39A61
loc_39A8F:
    add     [bp+var_12], 4Ch ; 'L'
loc_39A93:
    inc     [bp+var_2]
loc_39A96:
    mov     ax, [bp+arg_2]
    cmp     [bp+var_2], ax
    jle     short loc_39A21
loc_39A9E:
    mov     ax, [bp+arg_0]
loc_39AA1:
    mov     [bp+var_2], ax
loc_39AA4:
    mov     ax, [bp+arg_2]
loc_39AA7:
    cmp     [bp+var_2], ax
loc_39AAA:
    jg      short loc_39ACA
loc_39AAC:
    mov     ax, 4Ch ; 'L'
    imul    [bp+arg_0]
loc_39AB2:
    mov     si, ax
loc_39AB4:
    add     si, 8211h
loc_39AB8:
    mov     cx, [bp+arg_2]
    sub     cx, [bp+arg_0]
loc_39ABE:
    inc     cx
loc_39ABF:
    add     [bp+var_2], cx
loc_39AC2:
    mov     byte ptr [si], 0
loc_39AC5:
    add     si, 4Ch ; 'L'
loc_39AC8:
    loop    loc_39AC2
loc_39ACA:
    pop     ds
    pop     si
loc_39ACC:
    pop     di
loc_39ACD:
    mov     sp, bp
    pop     bp
locret_39AD0:
    retf
audio_driver_func1E endp
seg028 ends
end
