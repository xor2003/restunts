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
seg030 segment byte public 'STUNTSC' use16
    assume cs:seg030
    assume es:nothing, ss:nothing, ds:dseg
    public byte_39CCA
    public byte_39CCC
    public audio_make_filename
byte_39CCA     db 144
    db 144
byte_39CCC     db 0
    db 0
audio_make_filename proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10

    push    bp
loc_39CCF:
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    mov     si, offset audio_filetemp
    push    ds
    pop     es
    mov     di, word ptr [bp+arg_0]
loc_39CDE:
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
    sub     di, cx
    xchg    di, si
    shr     cx, 1
    repne movsw
    adc     cx, cx
    repne movsb
    mov     ax, 5Ch ; '\'
    push    ax
    mov     ax, offset audio_filetemp
    push    ax              ; char *
    call    _strrchr
    add     sp, 4
    mov     [bp+var_2], ax
    or      ax, ax
    jz      short loc_39D16
loc_39D0A:
    inc     [bp+var_2]
    mov     bx, [bp+var_2]
    mov     byte ptr [bx], 0
loc_39D13:
    jmp     short loc_39D1B
    ; align 2
    db 144
loc_39D16:
    mov     audio_filetemp, 0
loc_39D1B:
    mov     si, offset audio_filetemp
    push    ds
    pop     es
    mov     di, [bp+arg_4]
loc_39D23:
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
loc_39D2C:
    sub     di, cx
    mov     bx, cx
    xchg    di, si
    mov     cx, 0FFFFh
    repne scasb
    dec     di
    mov     cx, bx
    shr     cx, 1
    repne movsw
    adc     cx, cx
    repne movsb
    mov     ax, 5Ch ; '\'
    push    ax
    push    word ptr [bp+arg_0]; char *
    call    _strrchr
    add     sp, 4
    mov     [bp+var_2], ax
    or      ax, ax
    jz      short loc_39D6A
    inc     [bp+var_2]
    mov     bx, [bp+var_2]
    mov     di, bx
    mov     si, offset audio_filetemp
    mov     ax, ds
    mov     es, ax
    jmp     short loc_39D72
    ; align 2
    db 144
loc_39D6A:
    mov     si, offset audio_filetemp
    push    ds
    pop     es
    mov     di, word ptr [bp+arg_0]
loc_39D72:
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
    sub     di, cx
    mov     bx, cx
    xchg    di, si
    mov     cx, 0FFFFh
    repne scasb
    dec     di
    mov     cx, bx
    shr     cx, 1
    repne movsw
    adc     cx, cx
    repne movsb
    mov     di, offset audio_filetemp
    mov     ax, ds
    mov     es, ax
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
    dec     cx
    mov     bx, cx
    cmp     byte_42D2A[bx], 2Eh ; '.'
    jnz     short loc_39DBF
    mov     di, offset audio_filetemp
    mov     ax, ds
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
    dec     cx
    cmp     cx, 4
    ja      short loc_39E0B
loc_39DBF:
    mov     di, offset unk_407AC
    mov     si, offset audio_filetemp
    mov     ax, ds
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
    sub     di, cx
    mov     bx, cx
    xchg    di, si
    mov     cx, 0FFFFh
    repne scasb
    dec     di
    mov     cx, bx
    shr     cx, 1
    repne movsw
    adc     cx, cx
    repne movsb
    mov     si, offset audio_filetemp
    mov     di, word ptr [bp+arg_0+2]
    mov     cx, 0FFFFh
    xor     ax, ax
    repne scasb
    not     cx
loc_39DF5:
    sub     di, cx
loc_39DF7:
    mov     bx, cx
    xchg    di, si
    mov     cx, 0FFFFh
loc_39DFE:
    repne scasb
    dec     di
loc_39E01:
    mov     cx, bx
    shr     cx, 1
loc_39E05:
    repne movsw
    adc     cx, cx
loc_39E09:
    repne movsb
loc_39E0B:
    mov     ax, offset audio_filetemp
loc_39E0E:
    pop     si
    pop     di
loc_39E10:
    mov     sp, bp
loc_39E12:
    pop     bp
    retf
audio_make_filename endp
seg030 ends
end
