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
seg008 segment byte public 'STUNTSC' use16
    assume cs:seg008
    assume es:nothing, ss:nothing, ds:dseg
    public sub_274B0
    public sub_275C6
    public show_dialog
    public do_fileselect_dialog
    public file_build_path
    public do_savefile_dialog
    public parse_filepath_separators
    public input_checking
    public input_do_checking
    public file_load_resfile
    public unload_resource
    public locate_shape_alt
    public locate_text_res
    public copy_string
    public mouse_track_op
    public mouse_draw_transparent_check
    public mouse_draw_opaque_check
    public mouse_draw_opaque
    public mouse_draw_transparent
    public mouse_multi_hittest
    public check_input
    public nopsub_28F26
    public sprite_copy_2_to_1_2
    public sprite_copy_2_to_1_clear
    public sprite_copy_wnd_to_1
    public sprite_copy_wnd_to_1_clear
    public intro_draw_text
    public hiscore_draw_text
    public call_read_line
    public input_repeat_check
    public draw_lines_unk
    public draw_button
    public shape3d_init_shape
    public font_op2_alt
    public sprite_blit_to_video
    public show_waiting
    public print_int_as_string_maybe
    public sub_29772
    public mouse_timer_sprite_unk
    public file_load_audiores
    public audio_unload
    public font_set_fontdef2
    public font_set_fontdef
    public format_frame_as_string
    public get_super_random
    public file_load_resource
    public off_29A4E
    public sub_29A86
    public input_push_status
    public input_pop_status
    public do_joy_restext
    public do_key_restext
    public do_mou_restext
    public do_pau_restext
    public do_mof_restext
    public do_sonsof_restext
    public do_dos_restext
    public do_mrl_textres
    public do_dea_textres
    public ensure_file_exists
    public do_mer_restext
    public timer_get_delta_alt
    public file_load_3dres
sub_274B0 proc far
    var_40 = byte ptr -64
    var_22 = byte ptr -34
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 40h
    push    di
    push    si
    mov     ax, video_flag1_is1
    imul    video_flag4_is1
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_6]
    sub     ax, [bp+arg_4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+arg_2]
    sub     ax, [bp+arg_0]
    cwd
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    add     ax, 12h
    adc     dx, 0
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    call    mmgr_get_res_ofs_diff_scaled
    cmp     dx, [bp+var_2]
    jg      short loc_27506
    jl      short loc_274FD
    cmp     ax, [bp+var_4]
    ja      short loc_27506
loc_274FD:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_27506:
    push    cs
    call near ptr mouse_draw_opaque_check
    mov     ax, 0Fh
    push    ax
    mov     ax, [bp+arg_6]
    sub     ax, [bp+arg_4]
    push    ax
    mov     ax, [bp+arg_2]
    sub     ax, [bp+arg_0]
    push    ax
    call    sprite_make_wnd
    add     sp, 6
    mov     bl, byte_3B8FC
    sub     bh, bh
    shl     bx, 1
    shl     bx, 1
    mov     word ptr sprite_ptrs[bx], ax
    mov     word ptr (sprite_ptrs+2)[bx], dx
    mov     al, byte_3B8FC
    sub     ah, ah
    mov     si, ax
    shl     si, 1
    mov     ax, [bp+arg_0]
    mov     word_4646A[si], ax
    mov     ax, [bp+arg_4]
    mov     word_46486[si], ax
    lea     ax, [bp+var_40]
    push    ax
    call    sprite_copy_both_to_arg
    add     sp, 2
    mov     al, 3Ch ; '<'
    mul     byte_3B8FC
    mov     bx, ax
    les     di, trackdata12
    push    si
    lea     di, [bx+di]
    lea     si, [bp+var_40]
    mov     cx, 0Fh
    repne movsw
    pop     si
    mov     al, byte_3B8FC
    sub     ah, ah
    shl     ax, 1
    mov     cx, 1Eh
    mul     cx
    mov     di, ax
    les     bx, trackdata12
    push    si
    lea     di, [bx+di+1Eh]
    lea     si, [bp+var_22]
    mov     cx, 0Fh
    repne movsw
    pop     si
    call    sprite_copy_2_to_1
    push    [bp+arg_4]
    push    [bp+arg_0]
    mov     bl, byte_3B8FC
    sub     bh, bh
    shl     bx, 1
    shl     bx, 1
    les     bx, sprite_ptrs[bx]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_clear_shape_alt
    add     sp, 8
    inc     byte_3B8FC
    mov     ax, 1
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sub_274B0 endp
sub_275C6 proc far
    var_3C = byte ptr -60
    var_1E = byte ptr -30
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 3Ch
    push    di
    push    si
    cmp     byte_3B8FC, 0
    jnz     short loc_275D8
    jmp     loc_27680
loc_275D8:
    dec     byte_3B8FC
    push    cs
    call near ptr mouse_draw_opaque_check
    mov     al, byte_3B8FC
    sub     ah, ah
    mov     si, ax
    mov     di, si
    shl     di, 1
    push    word_46486[di]
    push    word_4646A[di]
    mov     bx, si
    shl     bx, 1
    shl     bx, 1
    les     bx, sprite_ptrs[bx]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_shape_to_1
    add     sp, 8
    mov     al, 3Ch ; '<'
    mul     byte_3B8FC
    add     ax, word ptr trackdata12
    mov     dx, word ptr trackdata12+2
    push    si
    push    di
    lea     di, [bp+var_3C]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
loc_27626:
    mov     cx, 0Fh
    repne movsw
    pop     ds
    pop     di
    pop     si
    mov     al, byte_3B8FC
    sub     ah, ah
    shl     ax, 1
    mov     cx, 1Eh
    mul     cx
    add     ax, word ptr trackdata12
    mov     dx, word ptr trackdata12+2
    add     ax, cx
    push    si
    push    di
    lea     di, [bp+var_1E]
    mov     si, ax
    push    ds
    mov     ds, dx
    mov     cx, 0Fh
    repne movsw
    pop     ds
    pop     di
    pop     si
    lea     ax, [bp+var_3C]
    push    ax
    call    sprite_copy_arg_to_both
    add     sp, 2
    mov     bl, byte_3B8FC
    sub     bh, bh
    shl     bx, 1
    shl     bx, 1
    push    word ptr (sprite_ptrs+2)[bx]
    push    word ptr sprite_ptrs[bx]
    call    sprite_free_wnd
    add     sp, 4
    push    cs
    call near ptr mouse_draw_transparent_check
loc_27680:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
sub_275C6 endp
show_dialog proc far
    var_1D8 = byte ptr -472
    var_1D6 = word ptr -470
    var_1D4 = byte ptr -468
    var_1D2 = word ptr -466
    var_1D0 = dword ptr -464
    var_1CC = word ptr -460
    var_1CA = byte ptr -458
    var_1C8 = word ptr -456
    var_1C6 = word ptr -454
    var_1C4 = byte ptr -452
    var_1C2 = word ptr -450
    var_1C0 = byte ptr -448
    var_1BE = byte ptr -446
    var_196 = word ptr -406
    var_194 = word ptr -404
    var_192 = byte ptr -402
    var_142 = word ptr -322
    var_140 = byte ptr -320
    var_13E = dword ptr -318
    var_13A = dword ptr -314
    var_EE = byte ptr -238
    var_C6 = byte ptr -198
    var_9E = byte ptr -158
    var_9C = word ptr -156
    var_9A = word ptr -154
    var_98 = byte ptr -152
    var_84 = byte ptr -132
    var_82 = word ptr -130
    var_80 = byte ptr -128
    var_30 = word ptr -48
    var_2E = word ptr -46
    var_2C = word ptr -44
    var_2A = word ptr -42
    var_28 = word ptr -40
    var_26 = word ptr -38
    var_24 = word ptr -36
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18
    arg_E = word ptr 20
    arg_10 = byte ptr 22

    push    bp
    mov     bp, sp
    sub     sp, 1D8h
    push    di
    push    si
    mov     ax, fontdef_unk_0E
    add     ax, 2
    mov     [bp+var_1D6], ax
    mov     [bp+var_1C6], 0
    mov     [bp+var_194], 20h ; ' '
    push    cs
    call near ptr mouse_draw_opaque_check
    mov     ax, [bp+arg_4]
    mov     dx, [bp+arg_6]
    mov     word ptr [bp+var_1D0], ax
    mov     word ptr [bp+var_1D0+2], dx
    mov     [bp+var_82], 0
    jmp     loc_2775A
loc_276C0:
    cmp     [bp+var_1D8], 5Dh ; ']'
    jnz     short loc_27702
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    lea     ax, [bp+var_80]
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_1C2], ax
    mov     ax, [bp+var_194]
    cmp     [bp+var_1C2], ax
    jle     short loc_276F1
    mov     ax, [bp+var_1C2]
    mov     [bp+var_194], ax
loc_276F1:
    mov     [bp+var_82], 0
    mov     ax, [bp+var_1D6]
    add     [bp+var_1C6], ax
    jmp     short loc_27756
    ; align 2
    db 144
loc_27702:
    les     bx, [bp+var_1D0]
    cmp     byte ptr es:[bx], 7Dh ; '}'
    jnz     short loc_27744
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    lea     ax, [bp+var_80]
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_1C2], ax
    mov     ax, [bp+var_194]
    cmp     [bp+var_1C2], ax
    jle     short loc_27736
    mov     ax, [bp+var_1C2]
    mov     [bp+var_194], ax
loc_27736:
    mov     [bp+var_82], 0
    add     [bp+var_1C6], 4
    jmp     short loc_27756
    ; align 2
    db 144
loc_27744:
    les     bx, [bp+var_1D0]
    mov     al, es:[bx]
    mov     si, [bp+var_82]
    inc     [bp+var_82]
    mov     [bp+si+var_80], al
loc_27756:
    inc     word ptr [bp+var_1D0]
loc_2775A:
    les     bx, [bp+var_1D0]
    mov     al, es:[bx]
    mov     [bp+var_1D8], al
    or      al, al
    jz      short loc_2776C
    jmp     loc_276C0
loc_2776C:
    mov     ax, [bp+var_194]
    add     ax, 18h
smart
    and     al, 0F8h
nosmart
    mov     [bp+var_194], ax
    cmp     [bp+arg_8], 0FFFFh
    jnz     short loc_27790
    mov     ax, 140h
    sub     ax, [bp+var_194]
    cwd
    sub     ax, dx
    sar     ax, 1
smart
    and     al, 0F8h
nosmart
    mov     [bp+arg_8], ax
loc_27790:
    cmp     [bp+arg_A], 0FFFFh
    jnz     short loc_277A5
    mov     ax, 0C8h ; 'È'
    sub     ax, [bp+var_1C6]
    cwd
    sub     ax, dx
    sar     ax, 1
    mov     [bp+arg_A], ax
loc_277A5:
    mov     ax, [bp+arg_8]
    mov     [bp+var_30], ax
    add     ax, [bp+var_194]
    mov     [bp+var_2E], ax
    mov     ax, [bp+arg_A]
    sub     ax, 8
    mov     [bp+var_2C], ax
    mov     ax, [bp+arg_A]
    add     ax, [bp+var_1C6]
    add     ax, 8
    mov     [bp+var_2A], ax
    add     [bp+arg_8], 8
    sub     [bp+var_194], 10h
    cmp     [bp+arg_2], 0
    jz      short loc_277F6
    push    ax
    push    [bp+var_2C]
    push    [bp+var_2E]
    push    [bp+var_30]
    push    cs
    call near ptr sub_274B0
    add     sp, 8
    or      al, al
    jnz     short loc_277F6
    mov     ax, 0FFFFh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_277F6:
    call    sprite_copy_2_to_1
    push    [bp+var_2A]
    push    [bp+var_2C]
    push    [bp+var_2E]
    push    [bp+var_30]
    call    sprite_set_1_size
    add     sp, 8
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    push    [bp+arg_C]
    mov     ax, [bp+arg_A]
    add     ax, [bp+var_1C6]
    add     ax, 4
    push    ax
    mov     ax, [bp+arg_8]
    add     ax, [bp+var_194]
    add     ax, 4
    push    ax
    mov     ax, [bp+arg_A]
    sub     ax, 4
    push    ax
    mov     ax, [bp+arg_8]
    sub     ax, 4
    push    ax
    call    sprite_1_unk4
    add     sp, 0Ah
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    mov     word_3EB90, 0
    sub     ax, ax
    push    ax
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    mov     [bp+var_82], 0
    mov     [bp+var_9E], 0
    mov     ax, [bp+arg_4]
    mov     dx, [bp+arg_6]
    mov     word ptr [bp+var_1D0], ax
    mov     word ptr [bp+var_1D0+2], dx
    mov     [bp+var_1C6], 1
    jmp     loc_2798E
    ; align 2
    db 144
loc_27890:
    cmp     [bp+var_1D8], 5Bh ; '['
    jnz     short loc_2789A
    jmp     loc_279A0
loc_2789A:
    cmp     [bp+var_1D8], 5Dh ; ']'
    jnz     short loc_278E2
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    mov     ax, [bp+arg_A]
    add     ax, [bp+var_1C6]
    push    ax
    push    [bp+arg_8]
    lea     ax, [bp+var_80]
    push    ax
    call    sub_345BC
    add     sp, 6
    mov     [bp+var_82], 0
    mov     ax, [bp+var_1D6]
    add     [bp+var_1C6], ax
loc_278CE:
    mov     ax, word ptr [bp+var_1D0]
    mov     dx, word ptr [bp+var_1D0+2]
    mov     [bp+var_9C], ax
    mov     [bp+var_9A], dx
    jmp     loc_2798A
    ; align 2
    db 144
loc_278E2:
    les     bx, [bp+var_1D0]
    cmp     byte ptr es:[bx], 7Dh ; '}'
    jnz     short loc_27918
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    mov     ax, [bp+arg_A]
    add     ax, [bp+var_1C6]
    push    ax
    push    [bp+arg_8]
    lea     ax, [bp+var_80]
    push    ax
    call    sub_345BC
    add     sp, 6
    mov     [bp+var_82], 0
    add     [bp+var_1C6], 4
    jmp     short loc_278CE
loc_27918:
    les     bx, [bp+var_1D0]
    cmp     byte ptr es:[bx], 40h ; '@'
    jnz     short loc_27978
    cmp     [bp+arg_0], 3
    jnz     short loc_2796A
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    lea     ax, [bp+var_80]
    push    ax
    call    font_op2
    add     sp, 2
    add     ax, [bp+arg_8]
    mov     cx, ax
    mov     al, [bp+var_9E]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     si, [bp+arg_E]
    mov     [bx+si], cx
    mov     al, [bp+var_9E]
    cbw
    mov     si, ax
    shl     si, 1
    mov     bx, [bp+arg_E]
    mov     ax, [bp+arg_A]
    add     ax, [bp+var_1C6]
    mov     [bx+si+2], ax
    add     [bp+var_9E], 2
loc_2796A:
    mov     si, [bp+var_82]
    inc     [bp+var_82]
    mov     [bp+si+var_80], 20h ; ' '
    jmp     short loc_2798A
loc_27978:
    les     bx, [bp+var_1D0]
    mov     al, es:[bx]
    mov     si, [bp+var_82]
    inc     [bp+var_82]
    mov     [bp+si+var_80], al
loc_2798A:
    inc     word ptr [bp+var_1D0]
loc_2798E:
    les     bx, [bp+var_1D0]
    mov     al, es:[bx]
    mov     [bp+var_1D8], al
    or      al, al
    jz      short loc_279A0
    jmp     loc_27890
loc_279A0:
    mov     [bp+var_140], 0
    jmp     loc_27B08
loc_279A8:
    inc     word ptr [bp+var_1D0]
    mov     al, [bp+var_140]
    cbw
    mov     si, ax
    mov     bx, si
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    mov     ax, word ptr [bp+var_1D0]
    mov     dx, word ptr [bp+var_1D0+2]
    mov     [bx-13Eh], ax
    mov     [bx-13Ch], dx
    mov     bx, [bp+var_82]
    add     bx, bp
    mov     byte ptr [bx-80h], 0
    lea     ax, [bp+var_80]
    push    ax
    call    font_op2
    add     sp, 2
    add     ax, [bp+arg_8]
    mov     bx, si
    shl     bx, 1
    add     bx, bp
    mov     [bx-28h], ax
    mov     si, [bp+arg_A]
    add     si, [bp+var_1C6]
    mov     al, [bp+var_140]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, bp
    mov     [di-1BEh], si
    mov     ax, [bp+var_1D6]
    add     ax, si
    mov     [di-0EEh], ax
    mov     [bp+var_1CA], 0
    mov     bx, [bp+var_82]
    inc     [bp+var_82]
    add     bx, bp
    mov     byte ptr [bx-80h], 20h ; ' '
    mov     [bp+var_1C2], 0
    jmp     loc_27AAE
    ; align 2
    db 144
loc_27A2A:
    cmp     [bp+var_1D8], 5Bh ; '['
    jnz     short loc_27A34
    jmp     loc_27AC0
loc_27A34:
    cmp     [bp+var_1D8], 5Dh ; ']'
    jnz     short loc_27A64
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    lea     ax, [bp+var_80]
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_1C2], ax
    mov     [bp+var_82], 0
    mov     ax, [bp+var_1D6]
    add     [bp+var_1C6], ax
    jmp     short loc_27AAA
    ; align 2
    db 144
loc_27A64:
    les     bx, [bp+var_1D0]
    cmp     byte ptr es:[bx], 7Dh ; '}'
    jnz     short loc_27A94
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    lea     ax, [bp+var_80]
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_1C2], ax
    mov     [bp+var_82], 0
    add     [bp+var_1C6], 3
    jmp     short loc_27AAA
    ; align 2
    db 144
loc_27A94:
    les     bx, [bp+var_1D0]
    mov     al, es:[bx]
    mov     si, [bp+var_82]
    inc     [bp+var_82]
    mov     [bp+si+var_80], al
    inc     [bp+var_1CA]
loc_27AAA:
    inc     word ptr [bp+var_1D0]
loc_27AAE:
    les     bx, [bp+var_1D0]
loc_27AB2:
    mov     al, es:[bx]
    mov     [bp+var_1D8], al
    or      al, al
    jz      short loc_27AC0
    jmp     loc_27A2A
loc_27AC0:
    mov     al, [bp+var_140]
    cbw
    mov     si, ax
    mov     al, [bp+var_1CA]
    mov     [bp+si+var_98], al
    mov     si, [bp+var_82]
    mov     [bp+si+var_80], 0
    cmp     [bp+var_1C2], 0
    jnz     short loc_27AEE
    lea     ax, [bp+var_80]
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_1C2], ax
loc_27AEE:
    mov     al, [bp+var_140]
    cbw
    mov     si, ax
    shl     si, 1
    add     si, bp
    mov     ax, [si-28h]
    add     ax, [bp+var_1C2]
    mov     [si-0C6h], ax
    inc     [bp+var_140]
loc_27B08:
    les     bx, [bp+var_1D0]
    cmp     byte ptr es:[bx], 5Bh ; '['
    jnz     short loc_27B15
    jmp     loc_279A8
loc_27B15:
    cmp     [bp+var_140], 2
    jle     short loc_27B56
    mov     ax, [bp+var_26]
    cmp     [bp+var_28], ax
    jnz     short loc_27B56
    mov     ax, [bp+var_24]
    cmp     [bp+var_26], ax
    jnz     short loc_27B56
    mov     [bp+var_196], 0
    jmp     short loc_27B4B
loc_27B34:
    mov     si, [bp+var_196]
    shl     si, 1
    add     si, bp
    mov     ax, [si-28h]
    add     ax, [bp+var_194]
loc_27B43:
    mov     [si-0C6h], ax
    inc     [bp+var_196]
loc_27B4B:
    mov     al, [bp+var_140]
    cbw
    cmp     ax, [bp+var_196]
    jg      short loc_27B34
loc_27B56:
    push    cs
    call near ptr mouse_draw_transparent_check
    mov     [bp+var_1D4], 1
    mov     ax, [bp+arg_0]
    or      ax, ax
    jz      short loc_27BBC
    cmp     ax, 1
    jz      short loc_27B98
    cmp     ax, 2
    jz      short loc_27BD4
    cmp     ax, 3
    jz      short loc_27BC4
    cmp     ax, 4
    jnz     short loc_27B88
    mov     ax, 8
    cwd
    push    dx
    push    ax
    call    sub_2EB1E
    add     sp, 4
loc_27B88:
    cmp     [bp+arg_2], 0
    jz      short loc_27B92
    push    cs
    call near ptr sub_275C6
loc_27B92:
    mov     al, [bp+var_1D4]
    jmp     short loc_27BCD
loc_27B98:
    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_checking
    add     sp, 2
    mov     [bp+var_142], ax
    or      ax, ax
    jz      short loc_27B98
    cmp     ax, 1Bh
    jnz     short loc_27BB6
    mov     [bp+var_1D4], 0
loc_27BB6:
    push    cs
    call near ptr check_input
    jmp     short loc_27B88
loc_27BBC:
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_27BC4:
    mov     al, [bp+var_9E]
    cbw
    mov     cl, 2
    idiv    cl
loc_27BCD:
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_27BD4:
    mov     al, [bp+arg_10]
    mov     [bp+var_1D4], al
    mov     [bp+var_1C0], 0FFh
    push    cs
    call near ptr timer_get_delta_alt
    push    cs
    call near ptr mouse_draw_opaque_check
    cmp     [bp+var_140], 2
    jnz     short loc_27C68
    mov     [bp+var_196], 0
loc_27BF5:
    mov     bx, [bp+var_196]
    les     si, [bp+var_13E]
    mov     al, es:[bx+si]
    sub     ah, ah
    mov     [bp+var_1C8], ax
    inc     [bp+var_196]
    cmp     ax, 20h ; ' '
    jz      short loc_27BF5
    mov     bx, ax
    test    g_ascii_props[bx], 1
    jz      short loc_27C2C
    test    g_ascii_props[bx], 1
    jz      short loc_27C26
    add     ax, 20h ; ' '
    jmp     short loc_27C28
    db 144
    db 144
loc_27C26:
    mov     ax, bx
loc_27C28:
    mov     [bp+var_1C8], ax
loc_27C2C:
    mov     [bp+var_196], 0
loc_27C32:
    mov     bx, [bp+var_196]
    les     si, [bp+var_13A]
    mov     al, es:[bx+si]
    sub     ah, ah
    mov     [bp+var_1CC], ax
    inc     [bp+var_196]
    cmp     ax, 20h ; ' '
    jz      short loc_27C32
    mov     bx, ax
    test    g_ascii_props[bx], 1
    jz      short loc_27C68
    test    g_ascii_props[bx], 1
    jz      short loc_27C62
    add     ax, 20h ; ' '
    jmp     short loc_27C64
    ; align 2
    db 144
loc_27C62:
    mov     ax, bx
loc_27C64:
    mov     [bp+var_1CC], ax
loc_27C68:
    mov     [bp+var_84], 1
loc_27C6D:
    cmp     [bp+var_84], 0
    jnz     short loc_27C77
    jmp     loc_27B88
loc_27C77:
    mov     al, [bp+var_1C0]
    cmp     [bp+var_1D4], al
    jnz     short loc_27C84
    jmp     loc_27D6D
loc_27C84:
    push    cs
    call near ptr mouse_draw_opaque_check
    mov     [bp+var_196], 0
    jmp     loc_27D25
    ; align 2
    db 144
loc_27C92:
    mov     al, [bp+var_1D4]
    cbw
    cmp     ax, [bp+var_196]
    jnz     short loc_27CA8
    push    dialog_fnt_colour
    push    word_3EB90
    jmp     short loc_27CB0
    ; align 2
    db 144
loc_27CA8:
    push    word_3EB90
    push    dialog_fnt_colour
loc_27CB0:
    call    font_set_unk
    add     sp, 4
    mov     si, [bp+var_196]
    shl     si, 1
    shl     si, 1
    mov     ax, word ptr [bp+si+var_13E]
    mov     dx, word ptr [bp+si+var_13E+2]
    mov     word ptr [bp+var_1D0], ax
    mov     word ptr [bp+var_1D0+2], dx
    mov     [bp+var_82], 0
    jmp     short loc_27CED
loc_27CD8:
    mov     bx, [bp+var_82]
    les     si, [bp+var_1D0]
    mov     al, es:[bx+si]
    mov     si, bx
    mov     [bp+si+var_192], al
    inc     [bp+var_82]
loc_27CED:
    mov     si, [bp+var_196]
    mov     al, [bp+si+var_98]
    cbw
    cmp     ax, [bp+var_82]
    jg      short loc_27CD8
    mov     di, [bp+var_82]
    mov     [bp+di+var_192], 0
    mov     si, [bp+var_196]
    shl     si, 1
    add     si, bp
    push    word ptr [si-1BEh]
    push    word ptr [si-28h]
    lea     ax, [bp+var_192]
    push    ax
    call    sub_345BC
    add     sp, 6
    inc     [bp+var_196]
loc_27D25:
    mov     al, [bp+var_140]
    cbw
    cmp     ax, [bp+var_196]
    jle     short loc_27D56
    cmp     [bp+arg_E], 0
    jnz     short loc_27D39
    jmp     loc_27C92
loc_27D39:
    mov     bx, [bp+var_196]
    shl     bx, 1
    mov     si, [bp+arg_E]
    cmp     word ptr [bx+si], 0
    jnz     short loc_27D4A
    jmp     loc_27C92
loc_27D4A:
    push    word_3EB90
    push    performGraphColor
    jmp     loc_27CB0
    ; align 2
    db 144
loc_27D56:
    push    cs
    call near ptr mouse_draw_transparent_check
    cmp     [bp+var_1C0], 0FFh
    jnz     short loc_27D65
    push    cs
    call near ptr check_input
loc_27D65:
    mov     al, [bp+var_1D4]
    mov     [bp+var_1C0], al
loc_27D6D:
    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_checking
    add     sp, 2
    mov     [bp+var_142], ax
    lea     ax, [bp+var_EE]
    push    ax
    lea     ax, [bp+var_1BE]
    push    ax
    lea     ax, [bp+var_C6]
    push    ax
    lea     ax, [bp+var_28]
    push    ax
    mov     al, [bp+var_140]
    cbw
    push    ax
    push    cs
    call near ptr mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_1C4], al
    cmp     al, 0FFh
    jz      short loc_27DBC
    cmp     [bp+arg_E], 0
    jz      short loc_27DB8
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     si, [bp+arg_E]
    cmp     word ptr [bx+si], 0
    jnz     short loc_27DBC
loc_27DB8:
    mov     [bp+var_1D4], al
loc_27DBC:
    cmp     [bp+var_140], 2
    jnz     short loc_27E15
    cmp     [bp+var_142], 0
    jz      short loc_27E15
    mov     ax, [bp+var_142]
    mov     [bp+var_1D2], ax
    mov     bx, ax
    test    g_ascii_props[bx], 1
    jz      short loc_27DEE
    test    g_ascii_props[bx], 1
    jz      short loc_27DE8
    add     ax, 20h ; ' '
    jmp     short loc_27DEA
    ; align 2
    db 144
loc_27DE8:
    mov     ax, bx
loc_27DEA:
    mov     [bp+var_1D2], ax
loc_27DEE:
    mov     ax, [bp+var_1D2]
    cmp     [bp+var_1C8], ax
    jnz     short loc_27E00
    mov     [bp+var_1D4], 0
    jmp     short loc_27E0F
    ; align 2
    db 144
loc_27E00:
    mov     ax, [bp+var_1D2]
    cmp     [bp+var_1CC], ax
    jnz     short loc_27E15
    mov     [bp+var_1D4], 1
loc_27E0F:
    mov     [bp+var_142], 0Dh
loc_27E15:
    mov     ax, [bp+var_142]
    cmp     ax, 20h ; ' '
    jnz     short loc_27E21
    jmp     loc_27EA9
loc_27E21:
    jbe     short loc_27E26
    jmp     loc_27EB6
loc_27E26:
    cmp     ax, 0Dh
    jz      short loc_27EA9
    cmp     ax, 1Bh
    jz      short loc_27EA4
    jmp     loc_27C6D
    ; align 2
    db 144
loc_27E34:
    cmp     [bp+var_1D4], 0
    jz      short loc_27E42
    dec     [bp+var_1D4]
    jmp     short loc_27E4C
    ; align 2
    db 144
loc_27E42:
    mov     al, [bp+var_140]
    dec     al
    mov     [bp+var_1D4], al
loc_27E4C:
    cmp     [bp+arg_E], 0
    jnz     short loc_27E55
    jmp     loc_27C6D
loc_27E55:
    mov     al, [bp+var_1D4]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     si, [bp+arg_E]
    cmp     word ptr [bx+si], 0
    jnz     short loc_27E34
    jmp     loc_27C6D
    ; align 2
    db 144
loc_27E6A:
    mov     al, [bp+var_1D4]
    cbw
    inc     ax
    mov     cx, ax
    mov     al, [bp+var_140]
    cbw
    cmp     cx, ax
    jge     short loc_27E82
    inc     [bp+var_1D4]
    jmp     short loc_27E87
    ; align 2
    db 144
loc_27E82:
    mov     [bp+var_1D4], 0
loc_27E87:
    cmp     [bp+arg_E], 0
    jnz     short loc_27E90
    jmp     loc_27C6D
loc_27E90:
    mov     al, [bp+var_1D4]
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     si, [bp+arg_E]
    cmp     word ptr [bx+si], 0
    jnz     short loc_27E6A
    jmp     loc_27C6D
loc_27EA4:
    mov     [bp+var_1D4], 0FFh
loc_27EA9:
    mov     [bp+var_84], 0
    push    cs
    call near ptr check_input
    jmp     loc_27C6D
    ; align 2
    db 144
loc_27EB6:
    cmp     ax, 4800h
    jnz     short loc_27EBE
    jmp     loc_27E34
loc_27EBE:
    cmp     ax, 4B00h
    jnz     short loc_27EC6
    jmp     loc_27E34
loc_27EC6:
    cmp     ax, 4D00h
    jz      short loc_27E6A
    cmp     ax, 5000h
    jz      short loc_27E6A
    jmp     loc_27C6D
    ; align 2
    db 144
show_dialog endp
do_fileselect_dialog proc far
    var_71C = word ptr -1820
    var_71A = word ptr -1818
    var_718 = byte ptr -1816
    var_716 = byte ptr -1814
    var_714 = byte ptr -1812
    var_712 = word ptr -1810
    var_710 = word ptr -1808
    var_70E = word ptr -1806
    var_70C = word ptr -1804
    var_70A = word ptr -1802
    var_708 = word ptr -1800
    var_6EA = byte ptr -1770
    var_6E8 = dword ptr -1768
    var_6E4 = byte ptr -1764
    var_6E2 = byte ptr -1762
    var_6E0 = word ptr -1760
    var_6D0 = word ptr -1744
    var_6CC = word ptr -1740
    var_6CA = word ptr -1738
    var_6C8 = byte ptr -1736
    var_6B4 = byte ptr -1716
    var_6A0 = byte ptr -1696
    var_69C = byte ptr -1692
    var_69A = byte ptr -1690
    var_698 = word ptr -1688
    var_18 = byte ptr -24
    var_16 = byte ptr -22
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 71Ch
    push    di
    push    si
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_712]
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aLoa ; "loa"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 3
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    or      ax, ax
    jge     short loc_27F1E
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_27F1E:
    mov     al, g_is_busy
    mov     [bp+var_18], al
    mov     g_is_busy, 1
    mov     ax, [bp+var_708]
    add     ax, 4
    mov     [bp+var_71C], ax
    push    dialogarg2
    push    ax
    mov     ax, [bp+var_70A]
    add     ax, 0ABh ; '«'
    push    ax
    push    [bp+var_71C]
    mov     ax, [bp+var_70A]
    sub     ax, 4
    push    ax
    call    preRender_line
    add     sp, 0Ah
    push    word_3EB90
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    push    [bp+arg_8]
    push    [bp+arg_6]
    mov     ax, offset resID_byte1
    push    ax
    push    cs
    call near ptr copy_string
    add     sp, 6
    push    [bp+var_710]
    push    [bp+var_712]
    mov     ax, offset resID_byte1
    push    ax
    call    sub_345BC
    add     sp, 6
    mov     di, [bp+var_70E]
    lea     ax, [di+0A2h]
    mov     word ptr [bp+var_6E8+2], ax
    mov     [bp+var_6EA], 0
    jmp     short loc_27FDD
    ; align 2
    db 144
loc_27F9E:
    mov     al, [bp+var_6EA]
    cbw
    mov     [bp+var_71C], ax
    mov     bx, ax
    shl     bx, 1
    shl     bx, 1
    add     bx, bp
    mov     ax, [bx-70Ch]
    mov     bx, [bp+var_71C]
    shl     bx, 1
    add     bx, bp
loc_27FBB:
    mov     [bx-6E2h], ax
    mov     al, [bp+var_6EA]
    cbw
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_71C], ax
    mov     bx, ax
    mov     ax, [bx-6E2h]
    add     ax, 0Ah
    mov     [bx-6C8h], ax
    inc     [bp+var_6EA]
loc_27FDD:
    cmp     [bp+var_6EA], 0Ah
    jge     short loc_28016
    mov     al, [bp+var_6EA]
    cbw
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_71C], ax
    mov     bx, ax
    mov     [bx-16h], di
    mov     bx, [bp+var_71C]
    mov     ax, word ptr [bp+var_6E8+2]
    mov     [bx-6B4h], ax
    cmp     [bp+var_6EA], 9
    jnz     short loc_27F9E
    mov     bx, [bp+var_71C]
    mov     ax, [bx-6E4h]
    add     ax, 0Ah
    jmp     short loc_27FBB
loc_28016:
    push    word_3EB90
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    push    [bp+var_70C]
    push    di
    push    word ptr [bp+arg_0]
    call    sub_345BC
    add     sp, 6
loc_28036:
    push    cs
    call near ptr mouse_draw_transparent_check
    mov     [bp+var_714], 0
    push    [bp+arg_4]      ; int
    mov     ax, offset asc_3EB96; "*"
    push    ax
    push    word ptr [bp+arg_0]; char *
    call    file_combine_and_find
    add     sp, 6
    mov     word ptr [bp+var_6E8], ax
    or      ax, ax
    jnz     short loc_28094
    call    nullsub_1
loc_2805E:
    push    word_3EB90
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    mov     ax, (offset terraincenterpos+22h)
    cwd
    push    dx              ; int
    push    ax              ; int
    push    [bp+var_70C]    ; int
    push    di              ; int
    mov     ax, 12h
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr call_read_line
    add     sp, 0Ch
    cmp     ax, 1Bh
    jnz     short loc_28036
loc_2808C:
    mov     [bp+var_6A0], 0
    jmp     loc_285AC
loc_28094:
    push    word ptr [bp+var_6E8]; char *
    lea     ax, [bp+var_698]
    push    ax              ; int
    push    cs
    call near ptr parse_filepath_separators
    add     sp, 4
    inc     [bp+var_714]
loc_280A8:
    call    file_find_next_alt
    mov     word ptr [bp+var_6E8], ax
    or      ax, ax
    jz      short loc_280E2
    push    ax              ; char *
    mov     al, [bp+var_714]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax              ; int
    push    cs
    call near ptr parse_filepath_separators
    add     sp, 4
    inc     [bp+var_714]
    mov     al, [bp+var_714]
    cbw
    cmp     ax, 80h ; '€'
    jnz     short loc_280A8
loc_280E2:
    call    nullsub_1
    cmp     [bp+var_714], 1
    jg      short loc_280F1
    jmp     loc_281CC
loc_280F1:
    sub     si, si
    jmp     loc_281B7
loc_280F6:
    inc     [bp+var_6CA]
loc_280FA:
    mov     al, [bp+var_714]
    cbw
    cmp     ax, [bp+var_6CA]
    ja      short loc_28108
    jmp     loc_281B6
loc_28108:
    mov     ax, [bp+var_6CA]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax              ; char *
    call    _strcmp
    add     sp, 4
    or      ax, ax
    jle     short loc_280F6
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, [bp+var_6CA]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset resID_byte1
    push    ax
    mov     ax, [bp+var_6CA]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    jmp     loc_280F6
    ; align 2
    db 144
loc_281B6:
    inc     si
loc_281B7:
    mov     al, [bp+var_714]
    cbw
    dec     ax
    cmp     ax, si
    jbe     short loc_281CC
    lea     ax, [si+1]
    mov     [bp+var_6CA], ax
    jmp     loc_280FA
    ; align 2
    db 144
loc_281CC:
    cmp     [bp+var_714], 7
    jle     short loc_2824D
    mov     ax, offset aLsu ; "lsu"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    push    cs
    call near ptr copy_string
    add     sp, 6
    push    [bp+var_6E0]
    mov     ax, offset resID_byte1
    push    ax
    push    cs
    call near ptr font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    sub_345BC
    add     sp, 6
    mov     ax, offset aLsd ; "lsd"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    push    cs
    call near ptr copy_string
    add     sp, 6
    mov     ax, [bp+var_6D0]
    dec     ax
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    push    cs
    call near ptr font_op2_alt
    add     sp, 2
    push    ax
    mov     ax, offset resID_byte1
    push    ax
    call    sub_345BC
    add     sp, 6
loc_2824D:
    mov     [bp+var_716], 0
    mov     [bp+var_69A], 0
    mov     [bp+var_6E4], 0FFh
    mov     [bp+var_718], 0FFh
    push    cs
    call near ptr timer_get_delta_alt
    mov     [bp+var_2], 0
loc_28269:
    mov     al, [bp+var_6E4]
    cmp     [bp+var_716], al
    jnz     short loc_28280
    mov     al, [bp+var_718]
    cmp     [bp+var_69A], al
    jnz     short loc_28280
    jmp     loc_28370
loc_28280:
    mov     al, [bp+var_716]
    mov     [bp+var_6E4], al
    mov     al, [bp+var_69A]
    mov     [bp+var_718], al
    push    cs
    call near ptr mouse_draw_opaque_check
    sub     si, si
    jmp     loc_28346
    ; align 2
    db 144
loc_2829A:
    push    word_3EB90
    push    dialog_fnt_colour
loc_282A2:
    call    font_set_unk
    add     sp, 4
    mov     al, [bp+var_69A]
    cbw
    add     ax, si
    mov     [bp+var_71C], ax
    mov     al, [bp+var_714]
    cbw
    cmp     ax, [bp+var_71C]
    jbe     short loc_282F2
    mov     ax, [bp+var_71C]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax
    mov     ax, offset resID_byte1
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     bx, si
    shl     bx, 1
    add     bx, bp
    push    word ptr [bx-6DEh]
    push    di
    mov     ax, offset resID_byte1
    jmp     short loc_28300
loc_282F2:
    mov     bx, si
    shl     bx, 1
    add     bx, bp
    push    word ptr [bx-6DEh]
    push    di
    mov     ax, offset asc_3EBA0; "        "
loc_28300:
    push    ax
    call    sub_345BC
    add     sp, 6
    mov     ax, offset resID_byte1
    push    ax
    call    font_op2
    add     sp, 2
    mov     [bp+var_71A], ax
    push    word_3EB90
    mov     ax, 8
    push    ax
    mov     ax, word ptr [bp+var_6E8+2]
    sub     ax, [bp+var_71A]
    sub     ax, di
    push    ax
    mov     bx, si
    shl     bx, 1
    add     bx, bp
    push    word ptr [bx-6DEh]
    mov     ax, [bp+var_71A]
    add     ax, di
    push    ax
    call    sprite_1_unk
    add     sp, 0Ah
    inc     si
loc_28346:
    cmp     si, 7
    jnb     short loc_2836C
    mov     al, [bp+var_69A]
    cbw
    add     ax, si
    mov     cx, ax
    mov     al, [bp+var_716]
    cbw
    cmp     cx, ax
    jz      short loc_28360
    jmp     loc_2829A
loc_28360:
    push    dialog_fnt_colour
    push    word_3EB90
    jmp     loc_282A2
    ; align 2
    db 144
loc_2836C:
    push    cs
    call near ptr mouse_draw_transparent_check
loc_28370:
    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_checking
    add     sp, 2
    mov     [bp+var_6CC], ax
    lea     ax, [bp+var_6C8]
    push    ax
    lea     ax, [bp+var_6E2]
    push    ax
    lea     ax, [bp+var_6B4]
    push    ax
    lea     ax, [bp+var_16]
    push    ax
    mov     ax, 0Ah
    push    ax
    push    cs
    call near ptr mouse_multi_hittest
    add     sp, 0Ah
    mov     [bp+var_6EA], al
    cmp     al, 0FFh
    jnz     short loc_283A9
    jmp     loc_28452
loc_283A9:
    or      al, al
    jnz     short loc_283CA
    test    byte ptr mouse_butstate, 3
    jnz     short loc_283B7
    jmp     loc_28452
loc_283B7:
    mov     [bp+var_716], 0
    mov     [bp+var_69A], 0FFh
loc_283C1:
    mov     [bp+var_6CC], 0
    jmp     loc_28452
loc_283CA:
    cmp     [bp+var_6EA], 1
    jnz     short loc_28402
    test    byte ptr mouse_butstate, 3
    jz      short loc_28452
    mov     al, [bp+var_69A]
    cbw
    mov     cx, ax
    mov     al, [bp+var_716]
    cbw
    add     ax, cx
    jz      short loc_283EC
    dec     [bp+var_716]
loc_283EC:
    mov     al, [bp+var_69A]
    cmp     [bp+var_716], al
    jge     short loc_283C1
    mov     al, [bp+var_716]
    mov     [bp+var_69A], al
    jmp     short loc_283C1
    db 144
    db 144
loc_28402:
    cmp     [bp+var_6EA], 9
    jnz     short loc_28428
    test    byte ptr mouse_butstate, 3
    jz      short loc_28452
    mov     al, [bp+var_714]
    cbw
    dec     ax
    mov     cx, ax
    mov     al, [bp+var_716]
    cbw
    cmp     cx, ax
    jz      short loc_283C1
    inc     [bp+var_716]
    jmp     short loc_283C1
    ; align 2
    db 144
loc_28428:
    mov     al, [bp+var_6EA]
    cbw
    mov     cx, ax
    mov     al, [bp+var_69A]
    cbw
    add     ax, cx
    sub     ax, 2
    mov     cx, ax
    mov     al, [bp+var_714]
    cbw
    cmp     cx, ax
    jge     short loc_28452
    mov     al, [bp+var_69A]
    add     al, [bp+var_6EA]
    sub     al, 2
    mov     [bp+var_716], al
loc_28452:
    mov     ax, [bp+var_6CC]
    cmp     ax, 0Dh
    jz      short loc_284CE
    cmp     ax, 1Bh
    jz      short loc_284D4
    cmp     ax, 20h ; ' '
    jz      short loc_284CE
    cmp     ax, 4800h
    jz      short loc_28492
    cmp     ax, 5000h
    jz      short loc_284B6
    mov     bx, ax
    test    g_ascii_props[bx], 1
    jnz     short loc_2847F
    test    g_ascii_props[bx], 2
    jz      short loc_28496
loc_2847F:
    mov     bx, [bp+var_6CC]
    test    g_ascii_props[bx], 1
    jz      short loc_284DA
    mov     al, byte ptr [bp+var_6CC]
    add     al, 20h ; ' '
    jmp     short loc_284DE
loc_28492:
    dec     [bp+var_716]
loc_28496:
    mov     al, [bp+var_69A]
    cmp     [bp+var_716], al
    jge     short loc_284A8
    mov     al, [bp+var_716]
    mov     [bp+var_69A], al
loc_284A8:
    cmp     [bp+var_69A], 0
    jl      short loc_284B2
    jmp     loc_28564
loc_284B2:
    jmp     loc_2805E
    ; align 2
    db 144
loc_284B6:
    mov     al, [bp+var_714]
    cbw
    dec     ax
    mov     cx, ax
    mov     al, [bp+var_716]
    cbw
    cmp     cx, ax
    jz      short loc_28496
    inc     [bp+var_716]
    jmp     short loc_28496
    ; align 2
    db 144
loc_284CE:
    mov     [bp+var_2], 1
    jmp     short loc_28496
loc_284D4:
    mov     [bp+var_2], 0FFh
    jmp     short loc_28496
loc_284DA:
    mov     al, byte ptr [bp+var_6CC]
loc_284DE:
    mov     [bp+var_69C], al
    mov     [bp+var_6EA], 0
    jmp     short loc_28516
    ; align 2
    db 144
loc_284EA:
    mov     al, [bp+var_6EA]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    shl     bx, 1
    add     bx, ax
    add     bx, bp
    mov     al, [bx-698h]
loc_28501:
    cmp     al, [bp+var_69C]
    jnz     short loc_28512
    mov     al, [bp+var_6EA]
    mov     [bp+var_716], al
    jmp     short loc_28496
    ; align 2
    db 144
loc_28512:
    inc     [bp+var_6EA]
loc_28516:
    mov     al, [bp+var_714]
    cmp     [bp+var_6EA], al
    jl      short loc_28523
    jmp     loc_28496
loc_28523:
    mov     al, [bp+var_6EA]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    shl     bx, 1
    add     bx, ax
    add     bx, bp
    mov     al, [bx-698h]
    cbw
    mov     bx, ax
    test    g_ascii_props[bx], 1
    jz      short loc_284EA
    mov     al, [bp+var_6EA]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    shl     bx, 1
    add     bx, ax
    add     bx, bp
    mov     al, [bx-698h]
    add     al, 20h ; ' '
    jmp     short loc_28501
    ; align 2
    db 144
loc_28560:
    inc     [bp+var_69A]
loc_28564:
    mov     al, [bp+var_69A]
    cbw
    add     ax, 6
    mov     cx, ax
    mov     al, [bp+var_716]
    cbw
    cmp     cx, ax
    jl      short loc_28560
    cmp     [bp+var_2], 0
    jnz     short loc_28580
    jmp     loc_28269
loc_28580:
    cmp     [bp+var_2], 0FFh
    jnz     short loc_28589
    jmp     loc_2808C
loc_28589:
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, bp
    sub     ax, 698h
    push    ax
    push    word ptr [bp+arg_0+2]; char *
    call    _strcpy
    add     sp, 4
    mov     [bp+var_6A0], 1
loc_285AC:
    push    cs
    call near ptr sub_275C6
    mov     al, [bp+var_18]
    mov     g_is_busy, al
    mov     al, [bp+var_6A0]
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
do_fileselect_dialog endp
file_build_path proc far
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = dword ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    cmp     word ptr [bp+arg_0], 0
    jz      short loc_285EC
    push    word ptr [bp+arg_0]
    push    word ptr [bp+arg_6]; char *
    call    _strcpy
    add     sp, 4
    push    word ptr [bp+arg_0]; char *
    call    _strlen
    add     sp, 2
    mov     si, ax
    jmp     short loc_285F4
loc_285EC:
    mov     bx, word ptr [bp+arg_6]
    mov     byte ptr [bx], 0
    sub     si, si
loc_285F4:
    or      si, si
    jz      short loc_28618
    mov     bx, word ptr [bp+arg_0]
    mov     al, [bx+si-1]
    mov     [bp+var_2], al
    cmp     al, ':'
    jz      short loc_28618
    cmp     al, '\'
    jz      short loc_28618
    mov     ax, offset asc_3EBA9; "\\"
    push    ax
    push    word ptr [bp+arg_6]; char *
    call    _strcat
    add     sp, 4
loc_28618:
    push    word ptr [bp+arg_0+2]
    push    word ptr [bp+arg_6]; char *
    call    _strcat
    add     sp, 4
    push    [bp+arg_4]
    push    word ptr [bp+arg_6]; char *
    call    _strcat
    add     sp, 4
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
file_build_path endp
do_savefile_dialog proc far
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_4 = byte ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 12h
    push    di
    push    si
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_12]
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aSav ; "sav"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 3
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    or      ax, ax
    jge     short loc_28682
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_28682:
    mov     [bp+var_4], 0
    push    word_3EB90
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    push    [bp+arg_6]
    push    [bp+arg_4]
    mov     ax, 0AC74h
    push    ax
    push    cs
    call near ptr copy_string
    add     sp, 6
    push    [bp+var_10]
    push    [bp+var_12]
    mov     ax, 0AC74h
    push    ax
    call    sub_345BC
    add     sp, 6
    push    word_3EB90
    push    dialog_fnt_colour
    call    font_set_unk
    add     sp, 4
    push    [bp+var_C]
    push    [bp+var_E]
    push    word ptr [bp+arg_0]
    call    sub_345BC
    add     sp, 6
    push    [bp+var_8]
    push    [bp+var_A]
    push    word ptr [bp+arg_0+2]
    call    sub_345BC
    add     sp, 6
    push    cs
    call near ptr mouse_draw_transparent_check
    jmp     short loc_2872F
    ; align 2
    db 144
loc_286F2:
    mov     bx, word ptr [bp+arg_0+2]
    cmp     byte ptr [bx+di], 20h ; ' '
    jnz     short loc_286FD
    mov     byte ptr [bx+di], 5Fh ; '_'
loc_286FD:
    inc     di
loc_286FE:
    mov     bx, word ptr [bp+arg_0+2]
    cmp     byte ptr [bx+di], 0
    jnz     short loc_286F2
    cmp     si, 1Bh
    jz      short loc_28754
    cmp     si, 0Dh
    jz      short loc_28750
    mov     ax, 7530h
    cwd
    push    dx              ; int
    push    ax              ; int
    push    [bp+var_C]      ; int
    push    [bp+var_E]      ; int
    mov     ax, 12h
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    cs
    call near ptr call_read_line
    add     sp, 0Ch
    cmp     ax, 1Bh
    jz      short loc_28754
loc_2872F:
    mov     ax, 7530h
    cwd
    push    dx              ; int
    push    ax              ; int
    push    [bp+var_8]      ; int
    push    [bp+var_A]      ; int
    mov     ax, 8
    push    ax
    push    word ptr [bp+arg_0+2]; char *
    push    cs
    call near ptr call_read_line
    add     sp, 0Ch
    mov     si, ax
    sub     di, di
    jmp     short loc_286FE
    ; align 2
    db 144
loc_28750:
    mov     [bp+var_4], 1
loc_28754:
    push    cs
    call near ptr sub_275C6
    mov     al, [bp+var_4]
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
do_savefile_dialog endp
parse_filepath_separators proc far
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = dword ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    si
    push    word ptr [bp+arg_2]; char *
    call    _strlen
    add     sp, 2
    mov     [bp+var_4], ax
loc_28777:
    mov     si, [bp+var_4]
    mov     bx, word ptr [bp+arg_2]
    mov     al, [bx+si-1]
    mov     [bp+var_2], al
    cmp     al, 5Ch ; '\'
    jz      short loc_28790
    cmp     al, 3Ah ; ':'
    jz      short loc_28790
    dec     [bp+var_4]
    jnz     short loc_28777
loc_28790:
    mov     [bp+var_6], 0
loc_28795:
    mov     bx, [bp+var_4]
    inc     [bp+var_4]
    mov     si, word ptr [bp+arg_2]
    mov     al, [bx+si]
    mov     bx, [bp+var_6]
    mov     si, [bp+arg_0]
    mov     [bx+si], al
    mov     bx, [bp+var_6]
    inc     [bp+var_6]
    mov     si, [bp+arg_0]
    cmp     byte ptr [bx+si], 2Eh ; '.'
    jnz     short loc_28795
    dec     [bp+var_6]
    mov     bx, [bp+var_6]
    mov     byte ptr [bx+si], 0
    pop     si
    mov     sp, bp
    pop     bp
    retf
parse_filepath_separators endp
input_checking proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     ax, [bp+arg_0]
    add     input_framecount, ax
    cmp     input_framecount, 4E20h; 20000
    jle     short loc_287ED
    sub     input_framecount, 2710h; 10000
    sub     input_framecount2, 2710h
    sub     input_framecount3, 2710h
loc_287ED:
    call    kb_get_char
    mov     si, ax
    or      si, si
    jz      short loc_287FD
    mov     kbormouse, 0
loc_287FD:
    call    get_joy_flags
    mov     di, ax
    call    get_kb_or_joy_flags
    mov     kbjoyflags, ax
    cmp     joyflags, di
    jnz     short loc_28815
    jmp     loc_28896
loc_28815:
    mov     ax, joyflags
    xor     ax, di
    and     ax, di          ; find changed flags from last?
    mov     newjoyflags, ax
    mov     joyflags, di
loc_28823:
    test    byte ptr newjoyflags, 20h
    jz      short loc_28834
    mov     joyinputcode, 0Dh
    jmp     short loc_28881
    ; align 4
    db 144
    db 144
loc_28834:
    test    byte ptr newjoyflags, 10h
    jz      short loc_28844
    mov     joyinputcode, 20h ; ' '
    jmp     short loc_28881
    ; align 2
    db 144
loc_28844:
    test    byte ptr newjoyflags, 1
    jz      short loc_28854
    mov     joyinputcode, 4800h
    jmp     short loc_28881
    ; align 2
    db 144
loc_28854:
    test    byte ptr newjoyflags, 2
    jz      short loc_28864
    mov     joyinputcode, 5000h
    jmp     short loc_28881
    ; align 2
    db 144
loc_28864:
    test    byte ptr newjoyflags, 8
    jz      short loc_28874
    mov     joyinputcode, 4B00h
    jmp     short loc_28881
    ; align 2
    db 144
loc_28874:
    test    byte ptr newjoyflags, 4
    jz      short loc_28881
    mov     joyinputcode, 4D00h
loc_28881:
    cmp     joyinputcode, 0
    jz      short loc_288A9
    mov     ax, input_framecount
    mov     input_framecount3, ax
    mov     kbormouse, 0
    jmp     short loc_288A9
    ; align 2
    db 144
loc_28896:
    or      di, di
    jz      short loc_288A9
    mov     ax, input_framecount3
    add     ax, 14h
    cmp     ax, input_framecount
    jge     short loc_288A9
    jmp     loc_28823
loc_288A9:
    mov     ax, offset mouse_ypos
    push    ax
    mov     ax, offset mouse_xpos
    push    ax
    mov     ax, offset mouse_butstate
    push    ax
    call    mouse_get_state
    add     sp, 6
    mov     ax, mouse_xpos
    cmp     mouse_oldx, ax
    jnz     short loc_288D8
    mov     ax, mouse_ypos
    cmp     mouse_oldy, ax
    jnz     short loc_288D8
    mov     ax, mouse_butstate
    cmp     mouse_oldbut, ax
    jz      short loc_28908
loc_288D8:
    mov     ax, mouse_xpos
    mov     mouse_oldx, ax
    mov     ax, mouse_ypos
    mov     mouse_oldy, ax
    mov     kbormouse, 1
    mov     input_framecounter, 0
    cmp     byte_3B8F7, 0
    jz      short loc_28934
    cmp     mouse_isdirty, 0
    jz      short loc_28901
    push    cs
    call near ptr mouse_draw_opaque
loc_28901:
    push    cs
    call near ptr mouse_draw_transparent
    jmp     short loc_28934
    ; align 2
    db 144
loc_28908:
    cmp     kbormouse, 0
    jz      short loc_28934
    mov     ax, [bp+arg_0]
    add     input_framecounter, ax
    cmp     input_framecounter, 1F4h
    jle     short loc_28934
    mov     input_framecounter, 0
    mov     kbormouse, 0
    cmp     mouse_isdirty, 0
    jz      short loc_28934
    push    cs
    call near ptr mouse_draw_opaque
loc_28934:
    cmp     kbormouse, 0
    jz      short _try_ret_joyinput
    mov     ax, mouse_oldbut
    cmp     mouse_butstate, ax
    jz      short loc_2897C
    mov     ax, mouse_butstate
    mov     mouse_oldbut, ax
loc_2894A:
    test    byte ptr mouse_butstate, 1
    jz      short loc_2895A
    mov     mousebutinputcode, 20h ; ' '
    jmp     short loc_28967
    ; align 2
    db 144
loc_2895A:
    test    byte ptr mouse_butstate, 2
    jz      short loc_28967
    mov     mousebutinputcode, 0Dh
loc_28967:
    cmp     mousebutinputcode, 0
    jz      short loc_28974
    mov     ax, input_framecount
    mov     input_framecount2, ax
loc_28974:
    mov     input_framecounter, 0
    jmp     short _try_ret_mousebut01
loc_2897C:
    cmp     mouse_butstate, 0
    jz      short _try_ret_mousebut01
    mov     ax, input_framecount2
    add     ax, 14h
    cmp     ax, input_framecount
    jl      short loc_2894A
_try_ret_mousebut01:
    cmp     mouse_butstate, 0
    jz      short _try_ret_joyinput
    test    byte ptr mouse_butstate, 1
    jz      short _try_ret_mousebut2
    or      byte ptr kbjoyflags, 20h
    jmp     short _try_ret_joyinput
_try_ret_mousebut2:
    test    byte ptr mouse_butstate, 2
    jz      short _try_ret_joyinput
    or      byte ptr kbjoyflags, 10h
_try_ret_joyinput:
    or      si, si
    jnz     short loc_289D9
    cmp     joyinputcode, 0
    jz      short _try_ret_mousebutinput
    mov     si, joyinputcode
    mov     joyinputcode, 0
    jmp     short loc_289D9
    ; align 2
    db 144
_try_ret_mousebutinput:
    cmp     mousebutinputcode, 0
    jz      short loc_289D9
    mov     si, mousebutinputcode
    mov     mousebutinputcode, 0
loc_289D9:
    mov     ax, si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
input_checking endp
input_do_checking proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    [bp+arg_0]
    push    cs
    call near ptr input_checking
    add     sp, 2
    pop     bp
    retf
    ; align 2
    db 144
input_do_checking endp
file_load_resfile proc far
    var_54 = byte ptr -84
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 54h
loc_289F8:
    push    [bp+arg_0]
    lea     ax, [bp+var_54]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset a_res; ".res"
    push    ax
    lea     ax, [bp+var_54]
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    lea     ax, [bp+var_54]
    push    ax              ; char *
    mov     ax, 1
    push    ax              ; int
    push    cs
    call near ptr file_load_resource
    add     sp, 4
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jnz     short loc_28A6E
    push    [bp+arg_0]
    lea     ax, [bp+var_54]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset a_pre; ".pre"
    push    ax
    lea     ax, [bp+var_54]
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    lea     ax, [bp+var_54]
    push    ax              ; char *
    mov     ax, 7
    push    ax              ; int
    push    cs
    call near ptr file_load_resource
    add     sp, 4
loc_28A5E:
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    or      ax, dx
    jnz     short loc_28A6E
    push    cs
    call near ptr do_dea_textres
    jmp     short loc_289F8
loc_28A6E:
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
file_load_resfile endp
unload_resource proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    mmgr_free
    add     sp, 4
    pop     bp
    retf
    ; align 2
    db 144
unload_resource endp
locate_shape_alt proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    [bp+arg_4]
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    locate_shape_fatal
    add     sp, 6
    pop     bp
    retf
locate_shape_alt endp
locate_text_res proc far
    var_4 = byte ptr -4
    var_3 = byte ptr -3
    var_2 = byte ptr -2
    var_1 = byte ptr -1
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 4
    mov     al, textresprefix
    mov     [bp+var_4], al
    mov     bx, [bp+arg_4]
    mov     al, [bx]
    mov     [bp+var_3], al
    mov     al, [bx+1]
    mov     [bp+var_2], al
    mov     al, [bx+2]
    mov     [bp+var_1], al
    lea     ax, [bp+var_4]
    push    ax
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    locate_shape_fatal
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
locate_text_res endp
copy_string proc far
    var_4 = dword ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = dword ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    mov     ax, word ptr [bp+arg_2]
    mov     dx, word ptr [bp+arg_2+2]
    mov     word ptr [bp+var_4], ax
    mov     word ptr [bp+var_4+2], dx
loc_28AE9:
    mov     bx, [bp+arg_0]
    les     si, [bp+var_4]
    mov     al, es:[si]
    mov     [bx], al
    inc     [bp+arg_0]
    inc     word ptr [bp+var_4]
    les     bx, [bp+var_4]
    cmp     byte ptr es:[bx], 0
    jnz     short loc_28AE9
    mov     bx, [bp+arg_0]
    mov     byte ptr [bx], 0
    pop     si
    mov     sp, bp
    pop     bp
    retf
copy_string endp
mouse_track_op proc far
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18
    arg_E = word ptr 20

    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    di
    push    si
    mov     ax, [bp+arg_8]
    cmp     [bp+arg_4], ax
    jle     short loc_28B28
    mov     [bp+var_A], 0
    mov     ax, [bp+arg_4]
    jmp     short loc_28B30
loc_28B28:
    mov     [bp+var_A], 1
    mov     ax, [bp+arg_8]
loc_28B30:
    mov     [bp+var_6], ax
    mov     ax, [bp+arg_E]
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_14], ax
    mov     ax, [bp+var_6]
    dec     ax
    mov     [bp+var_16], ax
    imul    [bp+arg_A]
    shl     ax, 1
    shl     ax, 1
    cwd
    mov     cx, [bp+var_14]
    idiv    cx
    mov     si, ax
    mov     ax, [bp+arg_A]
    add     ax, [bp+arg_C]
    imul    [bp+var_16]
    shl     ax, 1
    shl     ax, 1
    cwd
    idiv    cx
    mov     di, ax
    sub     ax, si
    mov     [bp+var_12], ax
    mov     ax, [bp+arg_0]
    or      ax, ax
    jz      short loc_28B78
    cmp     ax, 1
    jz      short loc_28BCE
    jmp     short loc_28BC5
loc_28B78:
    sub     ax, ax
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_4]
    push    [bp+arg_6]
    push    [bp+arg_2]
    call    sprite_1_unk
    add     sp, 0Ah
    cmp     [bp+var_A], 0
    jnz     short loc_28BAA
    push    dialog_fnt_colour
    push    [bp+arg_8]
    push    [bp+var_12]
    push    [bp+arg_6]
    mov     ax, [bp+arg_2]
    add     ax, si
    push    ax
    jmp     short loc_28BBD
loc_28BAA:
    push    dialog_fnt_colour
    push    [bp+var_12]
    push    [bp+arg_4]
    mov     ax, [bp+arg_6]
    add     ax, si
    push    ax
    push    [bp+arg_2]
loc_28BBD:
    call    sprite_1_unk
    add     sp, 0Ah
loc_28BC5:
    mov     ax, [bp+arg_A]
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_28BCE:
    cmp     [bp+var_A], 0
    jnz     short loc_28BDC
    mov     ax, mouse_xpos
    sub     ax, [bp+arg_2]
    jmp     short loc_28BE2
loc_28BDC:
    mov     ax, mouse_ypos
    sub     ax, [bp+arg_6]
loc_28BE2:
    mov     [bp+var_4], ax
    cmp     ax, si
    jl      short loc_28BED
    cmp     ax, di
    jle     short loc_28C26
loc_28BED:
    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_checking
    add     sp, 2
    test    byte ptr mouse_butstate, 3
    jnz     short loc_28BED
    cmp     [bp+var_4], si
    jge     short loc_28C14
    cmp     [bp+arg_A], 0
    jnz     short loc_28C0E
    jmp     loc_28CEC
loc_28C0E:
    dec     [bp+arg_A]
    jmp     loc_28CEC
loc_28C14:
    mov     ax, [bp+arg_E]
    dec     ax
    cmp     ax, [bp+arg_A]
    jg      short loc_28C20
    jmp     loc_28CEC
loc_28C20:
    inc     [bp+arg_A]
    jmp     loc_28CEC
loc_28C26:
    mov     [bp+arg_A], 0FFFFh
    mov     [bp+var_C], si
loc_28C2E:
    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_checking
    add     sp, 2
    cmp     [bp+var_A], 0
    jnz     short loc_28C48
    mov     ax, mouse_xpos
    sub     ax, [bp+arg_2]
    jmp     short loc_28C4E
loc_28C48:
    mov     ax, mouse_ypos
    sub     ax, [bp+arg_6]
loc_28C4E:
    mov     [bp+var_E], ax
    sub     ax, [bp+var_4]
    add     ax, si
    mov     [bp+var_2], ax
    or      ax, ax
    jge     short loc_28C64
    mov     [bp+var_2], 0
    jmp     short loc_28C7C
loc_28C64:
    mov     ax, [bp+var_2]
    add     ax, [bp+var_12]
    mov     cx, [bp+var_6]
    dec     cx
    cmp     ax, cx
    jle     short loc_28C7C
    mov     ax, [bp+var_6]
    sub     ax, [bp+var_12]
    dec     ax
    mov     [bp+var_2], ax
loc_28C7C:
    mov     ax, [bp+var_C]
    cmp     [bp+var_2], ax
    jz      short loc_28CE2
    mov     ax, [bp+var_2]
    mov     [bp+var_C], ax
    push    cs
    call near ptr mouse_draw_opaque_check
    sub     ax, ax
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_4]
    push    [bp+arg_6]
    push    [bp+arg_2]
    call    sprite_1_unk
    add     sp, 0Ah
    cmp     [bp+var_A], 0
    jnz     short loc_28CC2
    push    dialog_fnt_colour
    push    [bp+arg_8]
    push    [bp+var_12]
    push    [bp+arg_6]
    mov     ax, [bp+arg_2]
    add     ax, [bp+var_2]
    push    ax
    jmp     short loc_28CD6
    ; align 2
    db 144
loc_28CC2:
    push    dialog_fnt_colour
    push    [bp+var_12]
    push    [bp+arg_4]
    mov     ax, [bp+arg_6]
    add     ax, [bp+var_2]
    push    ax
    push    [bp+arg_2]
loc_28CD6:
    call    sprite_1_unk
    add     sp, 0Ah
    push    cs
    call near ptr mouse_draw_transparent_check
loc_28CE2:
    test    byte ptr mouse_butstate, 3
    jz      short loc_28CEC
    jmp     loc_28C2E
loc_28CEC:
    cmp     [bp+arg_A], 0FFFFh
    jnz     short loc_28D0E
    mov     ax, [bp+var_6]
    cwd
    mov     cx, [bp+arg_E]
    idiv    cx
    cwd
    sub     ax, dx
    sar     ax, 1
    add     ax, [bp+var_2]
    imul    cx
    cwd
    mov     cx, [bp+var_6]
    idiv    cx
    mov     [bp+arg_A], ax
loc_28D0E:
    mov     ax, [bp+arg_E]
    shl     ax, 1
    shl     ax, 1
    mov     [bp+var_16], ax
    mov     ax, [bp+var_6]
    dec     ax
    mov     [bp+var_14], ax
    imul    [bp+arg_A]
    shl     ax, 1
    shl     ax, 1
    cwd
    mov     cx, [bp+var_16]
    idiv    cx
    mov     si, ax
    mov     ax, [bp+arg_A]
    add     ax, [bp+arg_C]
    imul    [bp+var_14]
    shl     ax, 1
    shl     ax, 1
    cwd
    idiv    cx
    mov     di, ax
    sub     ax, si
    mov     [bp+var_12], ax
    push    cs
    call near ptr mouse_draw_opaque_check
    sub     ax, ax
    push    ax
    push    [bp+arg_8]
    push    [bp+arg_4]
    push    [bp+arg_6]
    push    [bp+arg_2]
    call    sprite_1_unk
    add     sp, 0Ah
    cmp     [bp+var_A], 0
    jnz     short loc_28D7C
    push    dialog_fnt_colour
    push    [bp+arg_8]
    push    [bp+var_12]
    push    [bp+arg_6]
    mov     ax, [bp+arg_2]
    add     ax, si
    push    ax
    jmp     short loc_28D8F
    ; align 2
    db 144
loc_28D7C:
    push    dialog_fnt_colour
    push    [bp+var_12]
    push    [bp+arg_4]
    mov     ax, [bp+arg_6]
    add     ax, si
    push    ax
    push    [bp+arg_2]
loc_28D8F:
    call    sprite_1_unk
    add     sp, 0Ah
    push    cs
    call near ptr mouse_draw_transparent_check
    jmp     loc_28BC5
mouse_track_op endp
mouse_draw_transparent_check proc far

    mov     byte_3B8F7, 1
    cmp     kbormouse, 0
    jz      short locret_28DB5
    cmp     mouse_isdirty, 0
    jnz     short locret_28DB5
    push    cs
    call near ptr mouse_draw_transparent
locret_28DB5:
    retf
mouse_draw_transparent_check endp
mouse_draw_opaque_check proc far

    mov     byte_3B8F7, 0
    cmp     mouse_isdirty, 0
    jz      short locret_28DC6
    push    cs
    call near ptr mouse_draw_opaque
locret_28DC6:
    retf
    ; align 2
    db 144
mouse_draw_opaque_check endp
mouse_draw_opaque proc far
    var_3C = byte ptr -60
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 3Ch
    lea     ax, [bp+var_3C]
    push    ax
    call    sprite_copy_both_to_arg
    add     sp, 2
    call    sprite_copy_2_to_1
    les     bx, mouseunkspriteptr
    push    word ptr es:[bx+(SPRITE.sprite_bitmapptr+2)]
    push    word ptr es:[bx+SPRITE.sprite_bitmapptr]
    call    sprite_putimage
    add     sp, 4
    lea     ax, [bp+var_3C]
    push    ax
    call    sprite_copy_arg_to_both
    mov     mouse_isdirty, 0
    mov     sp, bp
    pop     bp
    retf
mouse_draw_opaque endp
mouse_draw_transparent proc far
    var_3C = byte ptr -60
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 3Eh
    push    si
    mov     si, mouse_xpos
    mov     ax, si
    cwd
    mov     cx, video_flag2_is1
    idiv    cx
    sub     si, dx
    lea     ax, [bp+var_3C]
    push    ax
    call    sprite_copy_both_to_arg
    add     sp, 2
    call    sprite_copy_2_to_1
    push    mouse_ypos
    push    si
    les     bx, mouseunkspriteptr
    push    word ptr es:[bx+(SPRITE.sprite_bitmapptr+2)]
    push    word ptr es:[bx+SPRITE.sprite_bitmapptr]
    call    sprite_clear_shape_alt
    add     sp, 8
    push    mouse_ypos
    push    mouse_xpos
    les     bx, mmouspriteptr
    push    word ptr es:[bx+(SPRITE.sprite_bitmapptr+2)]
    push    word ptr es:[bx+SPRITE.sprite_bitmapptr]
    call    sprite_putimage_and
    add     sp, 8
    push    mouse_ypos
    push    mouse_xpos
    les     bx, smouspriteptr
    push    word ptr es:[bx+(SPRITE.sprite_bitmapptr+2)]
    push    word ptr es:[bx+SPRITE.sprite_bitmapptr]
    call    sprite_putimage_or
    add     sp, 8
    lea     ax, [bp+var_3C]
    push    ax
    call    sprite_copy_arg_to_both
    add     sp, 2
    mov     mouse_isdirty, 1
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
mouse_draw_transparent endp
mouse_multi_hittest proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_count = word ptr 6
    arg_x1_array = word ptr 8
    arg_x2_array = word ptr 10
    arg_y1_array = word ptr 12
    arg_y2_array = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    di
    push    si
    cmp     kbormouse, 0
    jz      short loc_28EDA
    sub     si, si
    jmp     short loc_28EA5
    ; align 2
    db 144
loc_28EA4:
    inc     si
loc_28EA5:
    cmp     [bp+arg_count], si
    jle     short loc_28EDA
    mov     di, si
    shl     di, 1
    mov     bx, [bp+arg_x1_array]
    mov     ax, mouse_xpos
    cmp     [bx+di], ax
    jg      short loc_28EA4
    mov     bx, [bp+arg_x2_array]
    cmp     [bx+di], ax
    jl      short loc_28EA4
    mov     bx, [bp+arg_y1_array]
    mov     ax, mouse_ypos
    cmp     [bx+di], ax
    jg      short loc_28EA4
    mov     bx, [bp+arg_y2_array]
    cmp     [bx+di], ax
    jl      short loc_28EA4
    mov     ax, si
    cbw
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_28EDA:
    mov     ax, 0FFFFh
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
mouse_multi_hittest endp
check_input proc far
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
loc_28EEA:
    call    get_kb_or_joy_flags
    test    al, 30h
    jz      short loc_28EFA
loc_28EF3:
    mov     [bp+var_2], 1
    jmp     short loc_28F1C
    ; align 2
    db 144
loc_28EFA:
    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_checking
    add     sp, 2
    or      ax, ax
    jnz     short loc_28EF3
    cmp     kbormouse, 0
    jz      short loc_28F18
    test    byte ptr mouse_butstate, 3
    jnz     short loc_28EF3
loc_28F18:
    mov     [bp+var_2], 0
loc_28F1C:
    cmp     [bp+var_2], 0
    jnz     short loc_28EEA
    mov     sp, bp
    pop     bp
    retf
check_input endp
nopsub_28F26 proc far

    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_checking
    add     sp, 2
    or      ax, ax
    jz      short near ptr nopsub_28F26
    push    cs
    call near ptr check_input
    retf
    ; align 2
    db 144
nopsub_28F26 endp
sprite_copy_2_to_1_2 proc far

    mov     ax, offset sprite2
    mov     dx, seg seg012
    push    dx
    push    ax
    call    sprite_set_1_from_argptr
    add     sp, 4
    retf
    ; align 2
    db 144
sprite_copy_2_to_1_2 endp
sprite_copy_2_to_1_clear proc far

    mov     ax, offset sprite2
    mov     dx, seg seg012
    push    dx
    push    ax
    call    sprite_set_1_from_argptr
    add     sp, 4
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    retf
sprite_copy_2_to_1_clear endp
sprite_copy_wnd_to_1 proc far

    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_set_1_from_argptr
    add     sp, 4
    retf
    ; align 2
    db 144
sprite_copy_wnd_to_1 endp
sprite_copy_wnd_to_1_clear proc far

    push    word ptr wndsprite+2
    push    word ptr wndsprite
    call    sprite_set_1_from_argptr
    add     sp, 4
    sub     ax, ax
    push    ax
    call    sprite_clear_1_color
    add     sp, 2
    retf
sprite_copy_wnd_to_1_clear endp
intro_draw_text proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_4]
    mov     word_4224C, ax
    add     ax, fontdef_unk_0E
    inc     ax
    mov     word_4224E, ax
    mov     ax, [bp+arg_2]
    mov     word_42248, ax
    push    [bp+arg_0]
    call    font_op2
    add     sp, 2
    add     ax, [bp+arg_2]
    inc     ax
    mov     word_4224A, ax
    sub     ax, ax
    push    ax
    push    [bp+arg_8]
    call    font_set_unk
    add     sp, 4
    mov     ax, [bp+arg_4]
    inc     ax
    push    ax
    mov     ax, [bp+arg_2]
    inc     ax
    push    ax
    push    [bp+arg_0]
    call    font_draw_text
    add     sp, 6
    sub     ax, ax
    push    ax
    push    [bp+arg_6]
    call    font_set_unk
    add     sp, 4
    push    [bp+arg_4]
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    font_draw_text
    add     sp, 6
    mov     ax, offset word_42248
    pop     bp
    retf
intro_draw_text endp
hiscore_draw_text proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_4]
    dec     ax
    mov     word_42254, ax
    mov     ax, [bp+arg_4]
    add     ax, fontdef_unk_0E
    inc     ax
    mov     word_42256, ax
    mov     ax, [bp+arg_2]
    dec     ax
    mov     word_42250, ax
    push    [bp+arg_0]
    call    font_op2
    add     sp, 2
    add     ax, [bp+arg_2]
    inc     ax
    mov     word_42252, ax
    sub     ax, ax
    push    ax
    push    [bp+arg_8]
    call    font_set_unk
    add     sp, 4
    mov     ax, [bp+arg_4]
    inc     ax
    push    ax
    mov     ax, [bp+arg_2]
    inc     ax
    push    ax
    push    [bp+arg_0]
    call    font_draw_text
    add     sp, 6
    mov     ax, [bp+arg_4]
    inc     ax
    push    ax
    mov     ax, [bp+arg_2]
    dec     ax
    push    ax
    push    [bp+arg_0]
    call    font_draw_text
    add     sp, 6
    mov     ax, [bp+arg_4]
    dec     ax
    push    ax
    mov     ax, [bp+arg_2]
    inc     ax
    push    ax
    push    [bp+arg_0]
    call    font_draw_text
    add     sp, 6
    mov     ax, [bp+arg_4]
    dec     ax
    push    ax
    mov     ax, [bp+arg_2]
    dec     ax
    push    ax
    push    [bp+arg_0]
    call    font_draw_text
    add     sp, 6
    sub     ax, ax
    push    ax
    push    [bp+arg_6]
    call    font_set_unk
    add     sp, 4
    push    [bp+arg_4]
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    font_draw_text
    add     sp, 6
    mov     ax, offset word_42250
    pop     bp
    retf
hiscore_draw_text endp
call_read_line proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    push    cs
    call near ptr mouse_draw_opaque_check
    push    [bp+arg_A]      ; int
    push    [bp+arg_8]      ; int
    mov     ax, 2
    mov     dx, seg seg018
    push    dx
    push    ax              ; __int32
    push    [bp+arg_6]      ; int
    push    [bp+arg_4]      ; int
    mov     ax, word ptr [bp+arg_0+2]
    mov     cx, ax
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    add     ax, cx
    add     ax, 9
    push    ax              ; int
    push    cx              ; int
    sub     ax, ax
    push    ax
    push    word ptr [bp+arg_0]; char *
    mov     ax, 2
    push    ax              ; char
    call    read_line
    add     sp, 16h
    mov     [bp+var_4], ax
    push    cs
    call near ptr mouse_draw_transparent_check
    push    word ptr [bp+arg_0]; char *
    call    _strlen
    add     sp, 2
    mov     word ptr [bp+arg_0+2], ax
    dec     ax
    mov     [bp+var_2], ax
    jmp     short loc_2911D
loc_2911A:
    dec     [bp+var_2]
loc_2911D:
    mov     bx, [bp+var_2]
    mov     si, word ptr [bp+arg_0]
    cmp     byte ptr [bx+si], 20h ; ' '
    jz      short loc_2911A
    mov     si, bx
    mov     bx, word ptr [bp+arg_0]
    mov     byte ptr [bx+si+1], 0
    mov     ax, [bp+var_4]
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
call_read_line endp
input_repeat_check proc far
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    sub     di, di
    push    cs
    call near ptr timer_get_delta_alt
    jmp     short loc_29161
loc_2914A:
    push    cs
    call near ptr timer_get_delta_alt
    mov     [bp+var_4], ax
    add     di, ax
    push    ax
    push    cs
    call near ptr input_do_checking
    add     sp, 2
    mov     si, ax
    or      si, si
    jnz     short loc_29168
loc_29161:
    cmp     [bp+arg_0], di
    jg      short loc_2914A
    sub     ax, ax
loc_29168:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
input_repeat_check endp
draw_lines_unk proc far
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18

    push    bp
    mov     bp, sp
    sub     sp, 14h
    push    di
    push    si
    mov     si, [bp+arg_0]
    add     si, [bp+arg_4]
    mov     di, [bp+arg_2]
    add     di, [bp+arg_6]
    push    [bp+arg_8]
    push    [bp+arg_2]
    push    si
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_2]
    inc     ax
    mov     [bp+var_6], ax
    push    [bp+arg_8]
    push    ax
    lea     ax, [si-1]
    push    ax
    push    [bp+var_6]
    mov     ax, [bp+arg_0]
    inc     ax
    push    ax
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_2]
    add     ax, 2
    mov     [bp+var_8], ax
    push    [bp+arg_A]
    push    ax
    lea     ax, [si-2]
    push    ax
    push    [bp+var_8]
    mov     ax, [bp+arg_0]
    add     ax, 2
    push    ax
    call    preRender_line
    add     sp, 0Ah
    push    [bp+arg_8]
    push    di
    push    [bp+arg_0]
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_0]
    inc     ax
    mov     [bp+var_A], ax
    push    [bp+arg_8]
    lea     ax, [di-1]
    push    ax
    push    [bp+var_A]
    mov     ax, [bp+arg_2]
    inc     ax
    push    ax
    push    [bp+var_A]
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_0]
    add     ax, 2
    mov     [bp+var_C], ax
    push    [bp+arg_A]
    lea     ax, [di-2]
    push    ax
    push    [bp+var_C]
    mov     ax, [bp+arg_2]
    add     ax, 2
    push    ax
    push    [bp+var_C]
    call    preRender_line
    add     sp, 0Ah
    push    [bp+arg_C]
    push    di
    push    si
    push    di
    push    [bp+arg_0]
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [di-1]
    mov     [bp+var_E], ax
    push    [bp+arg_C]
    push    ax
    lea     ax, [si-1]
    push    ax
    push    [bp+var_E]
    mov     ax, [bp+arg_0]
    inc     ax
    push    ax
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [di-2]
    mov     [bp+var_10], ax
    push    [bp+arg_A]
    push    ax
    lea     ax, [si-2]
    push    ax
    push    [bp+var_10]
    mov     ax, [bp+arg_0]
    add     ax, 2
    push    ax
    call    preRender_line
    add     sp, 0Ah
    push    [bp+arg_C]
    push    di
    push    si
    push    [bp+arg_2]
    push    si
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [si-1]
    mov     [bp+var_12], ax
    push    [bp+arg_C]
    lea     ax, [di-1]
    push    ax
    push    [bp+var_12]
    mov     ax, [bp+arg_2]
    inc     ax
    push    ax
    push    [bp+var_12]
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [si-2]
    mov     [bp+var_14], ax
    push    [bp+arg_A]
    lea     ax, [di-2]
    push    ax
    push    [bp+var_14]
    mov     ax, [bp+arg_2]
    add     ax, 2
    push    ax
    push    [bp+var_14]
    call    preRender_line
    add     sp, 0Ah
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
draw_lines_unk endp
draw_button proc far
    var_72 = word ptr -114
    var_70 = word ptr -112
    var_6E = word ptr -110
    var_6C = word ptr -108
    var_6A = word ptr -106
    var_68 = word ptr -104
    var_66 = word ptr -102
    var_64 = word ptr -100
    var_62 = word ptr -98
    var_60 = word ptr -96
    var_5C = word ptr -92
    var_5A = byte ptr -90
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = byte ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18
    arg_E = word ptr 20
    arg_10 = word ptr 22
    arg_12 = word ptr 24

    push    bp
    mov     bp, sp
    sub     sp, 72h
    push    di
    push    si
    mov     si, [bp+arg_4]
    add     si, [bp+arg_8]
    mov     di, [bp+arg_6]
    add     di, [bp+arg_A]
    push    [bp+arg_10]
    push    [bp+arg_A]
    push    [bp+arg_8]
    push    [bp+arg_6]
    push    [bp+arg_4]
    call    sprite_1_unk
    add     sp, 0Ah
    push    [bp+arg_C]
    push    [bp+arg_6]
    push    si
    push    [bp+arg_6]
    push    [bp+arg_4]
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_6]
    inc     ax
    mov     [bp+var_64], ax
    push    [bp+arg_C]
    push    ax
    lea     ax, [si-1]
    push    ax
    push    [bp+var_64]
    mov     ax, [bp+arg_4]
    inc     ax
    push    ax
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_6]
    add     ax, 2
    mov     [bp+var_66], ax
    push    [bp+arg_C]
    push    ax
    lea     ax, [si-2]
    push    ax
    push    [bp+var_66]
    mov     ax, [bp+arg_4]
    add     ax, 2
    push    ax
    call    preRender_line
    add     sp, 0Ah
    push    [bp+arg_C]
    push    di
    push    [bp+arg_4]
    push    [bp+arg_6]
    push    [bp+arg_4]
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_4]
    inc     ax
    mov     [bp+var_68], ax
    push    [bp+arg_C]
    lea     ax, [di-1]
    push    ax
    push    [bp+var_68]
    mov     ax, [bp+arg_6]
    inc     ax
    push    ax
    push    [bp+var_68]
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_4]
    add     ax, 2
    mov     [bp+var_6A], ax
    push    [bp+arg_C]
    lea     ax, [di-2]
    push    ax
    push    [bp+var_6A]
    mov     ax, [bp+arg_6]
    add     ax, 2
    push    ax
    push    [bp+var_6A]
    call    preRender_line
    add     sp, 0Ah
    push    [bp+arg_E]
    push    di
    push    si
    push    di
    push    [bp+arg_4]
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [di-1]
    mov     [bp+var_6C], ax
    push    [bp+arg_E]
    push    ax
    lea     ax, [si-1]
    push    ax
    push    [bp+var_6C]
    mov     ax, [bp+arg_4]
    inc     ax
    push    ax
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [di-2]
    mov     [bp+var_6E], ax
    push    [bp+arg_E]
    push    ax
    lea     ax, [si-2]
    push    ax
    push    [bp+var_6E]
    mov     ax, [bp+arg_4]
    add     ax, 2
    push    ax
    call    preRender_line
    add     sp, 0Ah
    push    [bp+arg_E]
    push    di
    push    si
    push    [bp+arg_6]
    push    si
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [si-1]
    mov     [bp+var_70], ax
    push    [bp+arg_E]
    lea     ax, [di-1]
    push    ax
    push    [bp+var_70]
    mov     ax, [bp+arg_6]
    inc     ax
    push    ax
    push    [bp+var_70]
    call    preRender_line
    add     sp, 0Ah
    lea     ax, [si-2]
    mov     [bp+var_72], ax
    push    [bp+arg_E]
    lea     ax, [di-2]
    push    ax
    push    [bp+var_72]
    mov     ax, [bp+arg_6]
    add     ax, 2
    push    ax
    push    [bp+var_72]
    call    preRender_line
    add     sp, 0Ah
    mov     ax, [bp+arg_0]
    or      ax, [bp+arg_2]
    jnz     short loc_29466
    jmp     loc_29554
loc_29466:
    sub     ax, ax
    push    ax
    push    [bp+arg_12]
    call    font_set_unk
    add     sp, 4
    push    [bp+arg_2]
    push    [bp+arg_0]
    mov     ax, 0AC74h
    push    ax
    push    cs
    call near ptr copy_string
    add     sp, 6
    mov     [bp+var_5C], 1
    mov     ax, 0AC74h
    push    ax              ; char *
    call    _strlen
    add     sp, 2
    mov     [bp+var_62], ax
    mov     [bp+var_8], 0
    jmp     short loc_294B0
loc_294A0:
    mov     bx, [bp+var_8]
    cmp     resID_byte1[bx], 5Dh ; ']'
    jnz     short loc_294AD
    inc     [bp+var_5C]
loc_294AD:
    inc     [bp+var_8]
loc_294B0:
    mov     ax, [bp+var_62]
    cmp     [bp+var_8], ax
    jl      short loc_294A0
    mov     [bp+var_2], 0
    mov     [bp+var_6], 0
    mov     ax, [bp+arg_A]
    mov     dx, [bp+var_5C]
    mov     cl, 3
    shl     dx, cl
    sub     ax, dx
    cwd
    sub     ax, dx
    sar     ax, 1
    inc     ax
    mov     [bp+var_60], ax
    mov     [bp+var_8], 0
    jmp     short loc_294EF
loc_294DE:
    mov     bx, [bp+var_2]
    add     bx, bp
    mov     al, [bp+var_4]
    mov     [bx-5Ah], al
    inc     [bp+var_2]
loc_294EC:
    inc     [bp+var_8]
loc_294EF:
    mov     ax, [bp+var_62]
    inc     ax
    cmp     ax, [bp+var_8]
    jle     short loc_29554
    mov     bx, [bp+var_8]
    mov     al, resID_byte1[bx]
    mov     [bp+var_4], al
    cmp     al, 5Dh ; ']'
    jz      short loc_2950A
    or      al, al
    jnz     short loc_294DE
loc_2950A:
    mov     bx, [bp+var_2]
    add     bx, bp
    mov     byte ptr [bx-5Ah], 0
    mov     ax, [bp+var_6]
    mov     cl, 3
    shl     ax, cl
    add     ax, [bp+arg_6]
    add     ax, [bp+var_60]
    push    ax
    lea     ax, [bp+var_5A]
    push    ax
    call    font_op2
    add     sp, 2
    mov     cx, ax
    mov     ax, [bp+arg_8]
    sub     ax, cx
    cwd
    sub     ax, dx
    sar     ax, 1
    add     ax, [bp+arg_4]
    push    ax
    lea     ax, [bp+var_5A]
    push    ax
    call    font_draw_text  ; when nop instead of this call = no text on buttons
    add     sp, 6
    inc     [bp+var_6]
    mov     [bp+var_2], 0
    jmp     short loc_294EC
algn_29553:
    ; align 2
    db 144
loc_29554:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
draw_button endp
shape3d_init_shape proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    mov     bx, [bp+arg_4]
    les     si, [bp+arg_0]
    mov     al, es:[si+SHAPE3DHEADER.header_numverts]
    sub     ah, ah
    mov     [bx+SHAPE3D.shape3d_numverts], ax
    mov     bx, [bp+arg_4]
    les     si, [bp+arg_0]
    mov     al, es:[si+SHAPE3DHEADER.header_numprimitives]
    mov     [bx+SHAPE3D.shape3d_numprimitives], ax
    mov     bx, [bp+arg_4]
    les     si, [bp+arg_0]
    mov     al, es:[si+SHAPE3DHEADER.header_numpaints]
    mov     byte ptr [bx+SHAPE3D.shape3d_numpaints], al
    mov     bx, [bp+arg_4]
    mov     ax, word ptr [bp+arg_0]
    mov     dx, word ptr [bp+arg_0+2]
    add     ax, 4
    mov     word ptr [bx+SHAPE3D.shape3d_verts], ax
    mov     word ptr [bx+(SHAPE3D.shape3d_verts+2)], dx
    mov     bx, [bp+arg_4]
    mov     si, bx
    mov     ax, word ptr [si+SHAPE3DHEADER.header_numverts]
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, word ptr [bp+arg_0]
    mov     dx, word ptr [bp+arg_0+2]
    add     ax, 4
    mov     word ptr [bx+SHAPE3D.shape3d_cull1], ax
    mov     word ptr [bx+(SHAPE3D.shape3d_cull1+2)], dx
    mov     bx, [bp+arg_4]
    mov     si, bx
    mov     ax, [si+SHAPE3D.shape3d_numprimitives]
    shl     ax, 1
    shl     ax, 1
    mov     cx, [si+SHAPE3D.shape3d_numverts]
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    shl     cx, 1
    add     ax, cx
    add     ax, word ptr [bp+arg_0]
    mov     dx, word ptr [bp+arg_0+2]
    add     ax, 4
    mov     word ptr [bx+SHAPE3D.shape3d_cull2], ax
    mov     word ptr [bx+(SHAPE3D.shape3d_cull2+2)], dx
    mov     bx, [bp+arg_4]
    mov     si, bx
    mov     ax, [si+SHAPE3D.shape3d_numprimitives]
    mov     cl, 3
    shl     ax, cl
    mov     cx, [si+SHAPE3D.shape3d_numverts]
    mov     dx, cx
    shl     cx, 1
    add     cx, dx
    shl     cx, 1
    add     ax, cx
    add     ax, word ptr [bp+arg_0]
    mov     dx, word ptr [bp+arg_0+2]
    add     ax, 4
    mov     word ptr [bx+SHAPE3D.shape3d_primitives], ax
    mov     word ptr [bx+(SHAPE3D.shape3d_primitives+2)], dx
    pop     si
    pop     bp
    retf
shape3d_init_shape endp
font_op2_alt proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    [bp+arg_0]
    call    font_op2
    add     sp, 2
    sub     ax, 140h
    neg     ax
    cwd
    sub     ax, dx
    sar     ax, 1
    pop     bp
    retf
font_op2_alt endp
sprite_blit_to_video proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    push    cs
    call near ptr sprite_copy_2_to_1_2
    push    cs
    call near ptr mouse_draw_opaque_check
    cmp     [bp+arg_4], 0FFFEh
    jnz     short loc_29654
    les     bx, [bp+arg_0]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
loc_29648:
    push    cs
    call near ptr mouse_draw_transparent_check
    sub     ax, ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_29654:
    mov     ax, [bp+arg_4]
    sub     si, si
    jmp     short loc_29670
    ; align 2
    db 144
loc_2965C:
    push    si
    les     bx, [bp+arg_0]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_1_unk3
    add     sp, 6
    inc     si
loc_29670:
    cmp     si, 4
    jge     short loc_29648
    push    cs
    call near ptr timer_get_delta_alt
    push    ax
    push    cs
    call near ptr input_do_checking
    add     sp, 2
    mov     di, ax
    or      di, di
    jz      short loc_2965C
    push    cs
    call near ptr sprite_copy_2_to_1_2
    les     bx, [bp+arg_0]
    push    word ptr es:[bx+2]
    push    word ptr es:[bx]
    call    sprite_putimage
    add     sp, 4
    push    cs
    call near ptr mouse_draw_transparent_check
    mov     ax, di
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
sprite_blit_to_video endp
show_waiting proc far

    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    push    waitflag
    mov     ax, 0FFFFh
    push    ax
    mov     ax, offset aWai ; "wai"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    sub     ax, ax
    push    ax
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    push    cs
    call near ptr mouse_draw_opaque_check
    retf
    ; align 2
    db 144
show_waiting endp
print_int_as_string_maybe proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     ax, 0Ah
    push    ax
    push    word ptr [bp+arg_0]; char *
    push    word ptr [bp+arg_0+2]; int
    call    _itoa
    add     sp, 6
    cmp     [bp+arg_6], 0
    jz      short loc_2974D
    sub     si, si
    jmp     short loc_29705
loc_29704:
    inc     si
loc_29705:
    mov     bx, word ptr [bp+arg_0]
    cmp     byte ptr [bx+si], 0
    jnz     short loc_29704
    jmp     short loc_29748
    ; align 2
    db 144
loc_29710:
    cmp     [bp+arg_6], si
    jge     short loc_2972A
    sub     di, di
    jmp     short loc_29723
    ; align 2
    db 144
loc_2971A:
    mov     bx, word ptr [bp+arg_0]
    mov     al, [bx+di+1]
    mov     [bx+di], al
    inc     di
loc_29723:
    cmp     di, si
    jl      short loc_2971A
    dec     si
    jmp     short loc_29748
loc_2972A:
    cmp     [bp+arg_6], si
    jle     short loc_29748
    mov     di, si
    jmp     short loc_2973D
    ; align 2
    db 144
loc_29734:
    mov     bx, word ptr [bp+arg_0]
    mov     al, [bx+di]
    mov     [bx+di+1], al
    dec     di
loc_2973D:
    or      di, di
    jge     short loc_29734
    mov     bx, word ptr [bp+arg_0]
    mov     byte ptr [bx], 20h ; ' '
    inc     si
loc_29748:
    cmp     [bp+arg_6], si
    jnz     short loc_29710
loc_2974D:
    cmp     [bp+arg_4], 0
    jz      short loc_2976B
    sub     si, si
    jmp     short loc_29763
    ; align 2
    db 144
loc_29758:
    mov     bx, word ptr [bp+arg_0]
    mov     ax, si
    inc     si
    add     bx, ax
    mov     byte ptr [bx], 30h ; '0'
loc_29763:
    mov     bx, word ptr [bp+arg_0]
    cmp     byte ptr [bx+si], 20h ; ' '
    jz      short loc_29758
loc_2976B:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
print_int_as_string_maybe endp
sub_29772 proc far

    mov     word_45D1C, 0
    mov     word_45D06, 0
    mov     idle_counter, 0
    retf
    ; align 2
    db 144
sub_29772 endp
mouse_timer_sprite_unk proc far
    var_6 = word ptr -6
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16
    arg_C = word ptr 18

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    di
    push    si
    push    cs
    call near ptr timer_get_delta_alt
    mov     si, ax
    add     word_45D1C, si
    jmp     short loc_2979F
loc_2979A:
    sub     word_45D1C, 3Ch ; '<'
loc_2979F:
    cmp     word_45D1C, 3Ch ; '<'
    jg      short loc_2979A
    cmp     word_45D1C, 1Eh
    jle     short loc_297B2
    mov     di, [bp+arg_A]
    jmp     short loc_297B5
loc_297B2:
    mov     di, [bp+arg_C]
loc_297B5:
    cmp     word_45D06, di
    jz      short loc_297F4
    mov     word_45D06, di
    push    cs
    call near ptr mouse_draw_opaque_check
    mov     ax, [bp+arg_0]
loc_297C6:
    shl     ax, 1
loc_297C8:
    mov     [bp+var_6], ax
    push    di
loc_297CC:
    mov     bx, ax
    add     bx, [bp+arg_8]
    push    word ptr [bx]
    mov     bx, ax
    add     bx, [bp+arg_4]
loc_297D8:
    push    word ptr [bx]
    mov     bx, ax
    add     bx, [bp+arg_6]
    push    word ptr [bx]
    mov     bx, ax
    add     bx, [bp+arg_2]
    push    word ptr [bx]
    call    sprite_1_unk4
    add     sp, 0Ah
    push    cs
    call near ptr mouse_draw_transparent_check
loc_297F4:
    mov     ax, si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
mouse_timer_sprite_unk endp
file_load_audiores proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    [bp+arg_2]      ; char *
    mov     ax, 5
    push    ax              ; int
    push    cs
    call near ptr file_load_resource
    add     sp, 4
    mov     word ptr voicefileptr, ax
    mov     word ptr voicefileptr+2, dx
    push    [bp+arg_0]      ; char *
    mov     ax, 4
    push    ax              ; int
    push    cs
    call near ptr file_load_resource
    add     sp, 4
    mov     word ptr songfileptr, ax
    mov     word ptr songfileptr+2, dx
    push    [bp+arg_4]      ; arg_4 is a string, e.g "TITL"
    push    word ptr voicefileptr+2
    push    word ptr voicefileptr
    push    dx
    push    ax
    call    init_audio_resources
    add     sp, 0Ah
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    push    dx
    push    ax
    call    load_audio_finalize
    mov     is_audioloaded, 1
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
file_load_audiores endp
audio_unload proc far

    mov     ax, 2
    push    ax
    call    audio_driver_func3F
    add     sp, 2
    push    word ptr songfileptr+2
    push    word ptr songfileptr
    call    mmgr_free
    add     sp, 4
    push    word ptr voicefileptr+2
    push    word ptr voicefileptr
    call    mmgr_free
    add     sp, 4
    mov     is_audioloaded, 0
    retf
audio_unload endp
font_set_fontdef2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = dword ptr 6

    push    bp
    mov     bp, sp
    push    word ptr [bp+arg_0+2]
    push    word ptr [bp+arg_0]
    call    set_fontdefseg
    add     sp, 4
    les     bx, [bp+arg_0]
    mov     ax, es:[bx+0Eh]
    mov     fontdef_unk_0E, ax
    pop     bp
    retf
    ; align 2
    db 144
font_set_fontdef2 endp
font_set_fontdef proc far

    push    word ptr fontdefptr+2
    push    word ptr fontdefptr
    push    cs
    call near ptr font_set_fontdef2
    add     sp, 4
    retf
font_set_fontdef endp
format_frame_as_string proc far
    var_16 = word ptr -22
    var_12 = byte ptr -18
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 18h
    push    di
    push    si
    mov     ax, 3Ch ; '<'
    imul    framespersec
    mov     [bp+var_16], ax
    mov     ax, [bp+arg_2]
    sub     dx, dx
    div     [bp+var_16]
    mov     si, ax
    mov     ax, [bp+var_16]
    imul    si
    sub     [bp+arg_2], ax
    mov     ax, [bp+arg_2]
    sub     dx, dx
    div     framespersec
    mov     di, ax
    mov     ax, framespersec
    imul    di
    sub     [bp+arg_2], ax
    mov     ax, 2
    push    ax              ; int
    sub     ax, ax
    push    ax              ; int
    push    si
    lea     ax, [bp+var_12]
    push    ax              ; char *
    push    cs
    call near ptr print_int_as_string_maybe
    add     sp, 8
    lea     ax, [bp+var_12]
    push    ax
    push    [bp+arg_0]      ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset asc_3EBD4; ":"
    push    ax
    push    [bp+arg_0]      ; char *
    call    _strcat
    add     sp, 4
    mov     ax, 2
    push    ax              ; int
    mov     ax, 1
    push    ax              ; int
    push    di
    lea     ax, [bp+var_12]
    push    ax              ; char *
    push    cs
    call near ptr print_int_as_string_maybe
    add     sp, 8
    lea     ax, [bp+var_12]
    push    ax
    push    [bp+arg_0]      ; char *
    call    _strcat
    add     sp, 4
    cmp     [bp+arg_4], 0
    jz      short loc_29988
    mov     ax, offset a_   ; "."
    push    ax
    push    [bp+arg_0]      ; char *
    call    _strcat
    add     sp, 4
    mov     ax, 2
    push    ax              ; int
    mov     ax, 1
    push    ax              ; int
    mov     ax, 64h ; 'd'
    cwd
    mov     cx, framespersec
    idiv    cx
    mul     [bp+arg_2]
    push    ax
loc_2996E:
    lea     ax, [bp+var_12]
    push    ax              ; char *
    push    cs
    call near ptr print_int_as_string_maybe
    add     sp, 8
    lea     ax, [bp+var_12]
    push    ax
    push    [bp+arg_0]      ; char *
    call    _strcat
    add     sp, 4
loc_29988:
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
format_frame_as_string endp
get_super_random proc far
    var_4 = word ptr -4
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    call    _rand
    mov     di, ax
    call    get_kevinrandom
    mov     [bp+var_4], ax
    call    timer_get_counter
    add     ax, [bp+var_4]
    add     ax, di
loc_299AF:
    add     ax, gState_frame
    mov     si, ax
    or      si, si
    jge     short loc_299C2
    neg     ax
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_299C2:
    mov     ax, si
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
get_super_random endp
file_load_resource proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = dword ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
loc_299D0:
    mov     ax, [bp+arg_0]
    cmp     ax, 8
    jbe     short loc_299DB
    jmp     loc_29A60
loc_299DB:
    add     ax, ax
    xchg    ax, bx
    jmp     cs:off_29A4E[bx]
    ; align 2
    db 144
loc_299E4:
    push    word ptr [bp+arg_2]
    call    file_load_binary_nofatal
loc_299EC:
    add     sp, 2
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
    jmp     short loc_29A60
    ; align 2
    db 144
loc_299F8:
    push    word ptr [bp+arg_2]
    call    file_load_binary_nofatal
loc_29A00:
    add     sp, 2
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_29A08:
    push    word ptr [bp+arg_2]
    call    file_decomp_nofatal
    jmp     short loc_29A00
loc_29A12:
    push    word ptr [bp+arg_2]
    call    file_load_shape2d_nofatal_thunk
    jmp     short loc_299EC
loc_29A1C:
    push    word ptr [bp+arg_2]
    call    file_load_shape2d_res_nofatal_thunk
    jmp     short loc_299EC
loc_29A26:
    push    word ptr [bp+arg_2]; char *
    call    load_song_file
    jmp     short loc_299EC
loc_29A30:
    push    word ptr [bp+arg_2]; char *
    call    load_voice_file
    jmp     short loc_299EC
loc_29A3A:
    push    word ptr [bp+arg_2]; char *
    call    load_sfx_file
    jmp     short loc_299EC
loc_29A44:
    push    word ptr [bp+arg_2]
    call    file_load_shape2d_nofatal2
    jmp     short loc_299EC
off_29A4E     dw offset loc_299E4
    dw offset loc_299F8
    dw offset loc_29A12
    dw offset loc_29A1C
    dw offset loc_29A26
    dw offset loc_29A30
    dw offset loc_29A3A
    dw offset loc_29A08
    dw offset loc_29A44
loc_29A60:
    mov     ax, [bp+var_4]
    or      ax, [bp+var_2]
    jz      short loc_29A72
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
loc_29A72:
    push    cs
    call near ptr do_dea_textres
    cmp     ax, 2
    jz      short loc_29A7E
    jmp     loc_299D0
loc_29A7E:
    sub     ax, ax
    cwd
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
file_load_resource endp
sub_29A86 proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 4
loc_29A8C:
    mov     ax, [bp+arg_0]
    cmp     ax, 9
    jz      short loc_29A9C
    cmp     ax, 0Ah
    jz      short loc_29AC6
    jmp     short loc_29AB3
    ; align 2
    db 144
loc_29A9C:
    push    [bp+arg_6]
    push    [bp+arg_4]
    push    [bp+arg_2]
    call    file_read_nofatal
    add     sp, 6
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_29AB3:
    mov     ax, [bp+var_4]
    or      ax, [bp+var_2]
    jz      short loc_29ADC
    mov     ax, [bp+var_4]
    mov     dx, [bp+var_2]
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_29AC6:
    push    [bp+arg_6]
    push    [bp+arg_4]
    push    [bp+arg_2]
    call    file_read_nofatal
    add     sp, 6
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 144
loc_29ADC:
    push    cs
    call near ptr do_dea_textres
    cmp     ax, 2
    jnz     short loc_29A8C
    sub     ax, ax
    cwd
    mov     sp, bp
    pop     bp
    retf
sub_29A86 endp
input_push_status proc far
     r = byte ptr 0

    push    si
    mov     al, byte_3EBD8
    cbw
    mov     si, ax
    mov     al, byte_3B8F7
    mov     byte_45D0C[si], al
    mov     al, kbormouse
    mov     byte_45D14[si], al
    inc     byte_3EBD8
    pop     si
    retf
    ; align 2
    db 144
input_push_status endp
input_pop_status proc far
     r = byte ptr 0

    push    si
    cmp     byte_3EBD8, 0
    jz      short loc_29B30
    dec     byte_3EBD8
    mov     al, byte_3EBD8
    cbw
    mov     si, ax
    mov     al, byte_45D0C[si]
    mov     byte_3B8F7, al
    mov     al, byte_45D14[si]
    mov     kbormouse, al
    or      al, al
    jnz     short loc_29B30
    push    cs
    call near ptr mouse_draw_opaque_check
loc_29B30:
    pop     si
    retf
input_pop_status endp
do_joy_restext proc far
    var_56 = word ptr -86
    var_54 = word ptr -84
    var_52 = word ptr -82
    var_50 = word ptr -80
    var_4E = word ptr -78
    var_4C = word ptr -76
    var_4A = word ptr -74
    var_48 = word ptr -72
    var_46 = word ptr -70
    var_44 = word ptr -68
    var_42 = word ptr -66
    var_40 = word ptr -64
    var_3E = word ptr -62
    var_3C = word ptr -60
    var_3A = word ptr -58
    var_38 = word ptr -56
    var_36 = word ptr -54
    var_34 = word ptr -52
    var_32 = word ptr -50
    var_30 = word ptr -48
    var_2E = word ptr -46
    var_2C = word ptr -44
    var_2A = word ptr -42
    var_28 = word ptr -40
    var_26 = word ptr -38
    var_24 = word ptr -36
    var_22 = word ptr -34
    var_1C = word ptr -28
    var_18 = word ptr -24
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_C = word ptr -12
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 56h
    push    di
    push    si
    push    cs
    call near ptr input_push_status
    mov     word_3F88E, 1
    call    audio_unk
    sub     ax, ax
    push    ax
    lea     ax, [bp+var_2E]
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aJoy ; "joy"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
loc_29B69:
    add     sp, 6
loc_29B6C:
    push    dx
    push    ax
loc_29B6E:
    mov     ax, 1
    push    ax
    mov     ax, 3
    push    ax
loc_29B76:
    push    cs
loc_29B77:
    call near ptr show_dialog
    add     sp, 12h
    or      ax, ax
    jg      short loc_29B84
    jmp     loc_29D76
loc_29B84:
    mov     [bp+var_C], 0
loc_29B89:
    mov     bx, [bp+var_C]
    add     bx, bp
    mov     byte ptr [bx-0Ah], 0
    inc     [bp+var_C]
    cmp     [bp+var_C], 9
    jl      short loc_29B89
    mov     byte_3FE00, 1
    push    cs
    call near ptr mouse_draw_opaque_check
    push    dialogarg2
    mov     ax, [bp+var_14]
    sub     ax, [bp+var_28]
    sub     ax, 8
    push    ax
    mov     ax, 1
    push    ax
    push    [bp+var_28]
    mov     ax, [bp+var_2A]
    sub     ax, 4
    push    ax
    call    sprite_1_unk
    add     sp, 0Ah
    push    dialogarg2
    mov     ax, [bp+var_14]
    sub     ax, [bp+var_28]
    sub     ax, 8
    push    ax
    mov     ax, 1
    push    ax
    push    [bp+var_24]
    mov     ax, [bp+var_26]
    sub     ax, 4
    push    ax
    call    sprite_1_unk
    add     sp, 0Ah
    push    dialogarg2
    mov     ax, 1
    push    ax
    mov     ax, [bp+var_22]
    sub     ax, [bp+var_2E]
    push    ax
    mov     ax, [bp+var_1C]
    sub     ax, 4
    push    ax
    push    [bp+var_2E]
    call    sprite_1_unk
    add     sp, 0Ah
    push    dialogarg2
    mov     ax, 1
    push    ax
    mov     ax, [bp+var_22]
    sub     ax, [bp+var_2E]
    push    ax
    mov     ax, [bp+var_18]
    sub     ax, 4
    push    ax
    push    [bp+var_2E]
    call    sprite_1_unk
    add     sp, 0Ah
    mov     ax, [bp+var_2A]
    mov     [bp+var_40], ax
    mov     [bp+var_3E], ax
    mov     [bp+var_36], ax
    mov     ax, [bp+var_26]
    mov     [bp+var_3C], ax
    mov     [bp+var_3A], ax
    mov     [bp+var_38], ax
    mov     ax, [bp+var_2E]
    mov     [bp+var_34], ax
    mov     [bp+var_32], ax
    mov     [bp+var_30], ax
    mov     ax, [bp+var_1C]
    mov     [bp+var_54], ax
    mov     [bp+var_4E], ax
    mov     [bp+var_46], ax
    mov     ax, [bp+var_28]
    mov     [bp+var_52], ax
    mov     [bp+var_50], ax
    mov     [bp+var_44], ax
    mov     ax, [bp+var_18]
    mov     [bp+var_4C], ax
    mov     [bp+var_4A], ax
    mov     [bp+var_48], ax
    mov     ax, [bp+var_2A]
    sub     ax, [bp+var_2E]
    sub     ax, 8
    mov     [bp+var_12], ax
    mov     ax, [bp+var_1C]
    sub     ax, [bp+var_2C]
    sub     ax, 8
    mov     [bp+var_42], ax
    mov     si, 0FFFFh
    call    sub_307B4
loc_29C96:
    call    kb_read_char
    or      ax, ax
    jz      short loc_29CA8
loc_29C9F:
    mov     [bp+var_C], 0
    jmp     short loc_29D25
    ; align 4
    db 144
    db 144
loc_29CA8:
    call    get_joy_flags
    mov     di, ax
    test    di, 30h
    jnz     short loc_29C9F
    push    di
    call    sub_307D2
    add     sp, 2
    mov     di, ax
    cmp     di, si
    jz      short loc_29C96
    mov     [bp+var_C], 0
loc_29CC9:
    mov     ax, [bp+var_C]
    shl     ax, 1
    add     ax, bp
    mov     [bp+var_56], ax
    push    word_3EB90
    push    [bp+var_42]
    push    [bp+var_12]
    mov     bx, ax
    push    word ptr [bx-54h]
    push    word ptr [bx-40h]
    call    sprite_1_unk
    add     sp, 0Ah
    inc     [bp+var_C]
    cmp     [bp+var_C], 9
    jl      short loc_29CC9
    mov     ax, di
    shl     ax, 1
loc_29CFA:
    add     ax, bp
    mov     [bp+var_56], ax
    push    dialog_fnt_colour
    push    [bp+var_42]
    push    [bp+var_12]
    mov     bx, ax
    push    word ptr [bx-54h]
loc_29D0E:
    push    word ptr [bx-40h]
    call    sprite_1_unk
    add     sp, 0Ah
    mov     si, di
    mov     [bp+di+var_A], 1
    jmp     loc_29C96
loc_29D22:
    inc     [bp+var_C]
loc_29D25:
    cmp     [bp+var_C], 9
    jge     short loc_29D3A
    mov     bx, [bp+var_C]
    add     bx, bp
    mov     al, [bx-0Ah]
    and     byte_3FE00, al
    jmp     short loc_29D22
    ; align 2
    db 144
loc_29D3A:
    push    cs
    call near ptr sub_275C6
    cmp     byte_3FE00, 0
    jnz     short loc_29D7B
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aJox ; "jox"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    jmp     short loc_29D7B
    ; align 2
    db 144
loc_29D76:
    mov     byte_3FE00, 0
loc_29D7B:
    call    kb_check
    mov     byte_3B8F2, 0
    call    sub_372F4
    mov     word_3F88E, 0
    push    cs
    call near ptr input_pop_status
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
do_joy_restext endp
do_key_restext proc far

    push    cs
    call near ptr input_push_status
    mov     word_3F88E, 1
    call    audio_unk
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aKey ; "key"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 4
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    mov     byte_3FE00, 0
    mov     byte_3B8F2, 0
    mov     word_3F88E, 0
    call    sub_372F4
    push    cs
    call near ptr input_pop_status
    retf
do_key_restext endp
do_mou_restext proc far

    push    cs
    call near ptr input_push_status
    mov     word_3F88E, 1
    call    audio_unk
    mov     byte_3B8F2, 1
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMou ; "mou"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 4
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    mov     word_3F88E, 0
    call    sub_372F4
    push    cs
    call near ptr input_pop_status
    retf
    ; align 2
    db 144
do_mou_restext endp
do_pau_restext proc far

    push    cs
    call near ptr input_push_status
    mov     word_3F88E, 1
    call    audio_unk
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aPau ; "pau"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    mov     word_3F88E, 0
    call    sub_372F4
    push    cs
    call near ptr input_pop_status
    retf
    ; align 2
    db 144
do_pau_restext endp
do_mof_restext proc far

    push    cs
    call near ptr input_push_status
loc_29E9C:
    mov     word_3F88E, 1
    call    audio_toggle_flag2
    or      ax, ax
    jz      short loc_29EBE
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMon ; "mon"
    jmp     short loc_29ECE
    ; align 2
    db 144
loc_29EBE:
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMof ; "mof"
loc_29ECE:
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 4
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    mov     word_3F88E, 0
    push    cs
    call near ptr input_pop_status
    retf
do_mof_restext endp
do_sonsof_restext proc far

    push    cs
    call near ptr input_push_status
loc_29EFE:
    mov     word_3F88E, 1
    call    audio_toggle_flag6
    or      ax, ax
loc_29F0B:
    jz      short loc_29F20
    sub     ax, ax
    push    ax
    push    ax
loc_29F11:
    push    dialogarg2
loc_29F15:
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aSon ; "son"
    jmp     short loc_29F30
    ; align 2
    db 144
loc_29F20:
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aSof ; "sof"
loc_29F30:
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 4
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    mov     word_3F88E, 0
    push    cs
    call near ptr input_pop_status
    retf
do_sonsof_restext endp
do_dos_restext proc far

    push    cs
    call near ptr input_push_status
    mov     word_3F88E, 1
    call    audio_unk
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aDos_0; "dos"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    cmp     ax, 1
    jnz     short loc_29FA6
    call    far ptr call_exitlist2
loc_29FA6:
    mov     word_3F88E, 0
    call    sub_372F4
    push    cs
    call near ptr input_pop_status
    retf
do_dos_restext endp
do_mrl_textres proc far
    var_212 = word ptr -530
    var_20C = byte ptr -524
    var_205 = byte ptr -517
    var_204 = byte ptr -516
    var_202 = byte ptr -514
    var_201 = byte ptr -513
    var_2 = byte ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 212h
    push    di
    push    si
    push    cs
    call near ptr input_push_status
    mov     word_3F88E, 1
    call    audio_unk
    mov     ax, framespersec2
    mov     [bp+var_212], ax
    mov     [bp+var_2], 0
loc_29FD9:
    mov     ax, offset aMrl ; "mrl"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    lea     ax, [bp+var_202]
    push    ax
    push    cs
    call near ptr copy_string
    add     sp, 6
    sub     si, si
loc_29FFC:
    mov     [bp+si+var_20C], 0
    inc     si
    cmp     si, 9
    jl      short loc_29FFC
    mov     bl, timertestflag2
    sub     bh, bh
    add     bx, bp
    mov     byte ptr [bx-20Ch], 1
    mov     bx, timertestflag
    add     bx, bp
    mov     byte ptr [bx-207h], 1
    cmp     framespersec2, 0Ah
    jnz     short loc_2A02E
    mov     [bp+var_205], 1
    jmp     short loc_2A033
    ; align 2
    db 144
loc_2A02E:
    mov     [bp+var_204], 1
loc_2A033:
    sub     di, di
    sub     si, si
    jmp     short loc_2A050
    ; align 2
    db 144
loc_2A03A:
    inc     di
loc_2A03B:
    cmp     [bp+di+var_202], 5Bh ; '['
    jnz     short loc_2A03A
    cmp     [bp+si+var_20C], 0
    jz      short loc_2A04E
    mov     [bp+di+var_201], 2Ah ; '*'
loc_2A04E:
    inc     di
    inc     si
loc_2A050:
    cmp     si, 9
    jl      short loc_2A03B
    mov     al, [bp+var_2]
    cbw
    push    ax
    sub     ax, ax
    push    ax
    push    performGraphColor
    mov     ax, 0FFFFh
    push    ax
    push    ax
    lea     ax, [bp+var_202]
    push    ss
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    mov     [bp+var_2], al
    cbw
    cmp     ax, 0FFFFh
    jz      short loc_2A0CC
    cmp     ax, 5
    jz      short loc_2A0A4
    cmp     ax, 6
    jz      short loc_2A0AE
    cmp     ax, 7
    jz      short loc_2A0B8
    cmp     ax, 8
    jz      short loc_2A0C2
loc_2A098:
    cmp     ax, 9
    jz      short loc_2A0CC
    mov     timertestflag2, al
    jmp     loc_29FD9
    ; align 2
    db 144
loc_2A0A4:
    mov     timertestflag, 0
    jmp     loc_29FD9
    ; align 2
    db 144
loc_2A0AE:
    mov     timertestflag, 1
    jmp     loc_29FD9
    ; align 2
    db 144
loc_2A0B8:
    mov     framespersec2, 0Ah
    jmp     loc_29FD9
    ; align 2
    db 144
loc_2A0C2:
    mov     framespersec2, 14h
    jmp     loc_29FD9
    ; align 2
    db 144
loc_2A0CC:
    mov     ax, framespersec2
    cmp     [bp+var_212], ax
    jz      short loc_2A103
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMrs ; "mrs"
    push    ax
    push    word ptr mainresptr+2
loc_2A0EA:
    push    word ptr mainresptr
loc_2A0EE:
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
loc_2A103:
    mov     word_3F88E, 0
    call    sub_372F4
    push    cs
    call near ptr input_pop_status
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
do_mrl_textres endp
do_dea_textres proc far
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    cs
    call near ptr input_push_status
    cmp     g_is_busy, 0
    jz      short loc_2A168
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aDea ; "dea"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    mov     [bp+var_2], ax
    or      ax, ax
    jz      short loc_2A196
    mov     [bp+var_2], 0
    jmp     short loc_2A19B
loc_2A168:
    sub     ax, ax
    push    ax
    push    ax
loc_2A16C:
    push    dialogarg2
loc_2A170:
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aDer ; "der"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
loc_2A182:
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    push    ax
    push    cs
    call near ptr show_dialog
loc_2A193:
    add     sp, 12h
loc_2A196:
    mov     [bp+var_2], 1
loc_2A19B:
    push    cs
    call near ptr input_pop_status
    mov     ax, [bp+var_2]
loc_2A1A2:
    mov     sp, bp
    pop     bp
    retf
do_dea_textres endp
ensure_file_exists proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    jmp     short loc_2A1E8
    ; align 2
    db 144
loc_2A1AC:
    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
loc_2A1B4:
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     bx, [bp+arg_0]
    shl     bx, 1
loc_2A1BE:
    push    word ptr (aOpp1_+5)[bx]; "Insert Disk A/B .. etc presskey"
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
loc_2A1D2:
    push    ax
    mov     ax, 1
    push    ax
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    push    cs
    call near ptr mouse_draw_opaque_check
    mov     kbormouse, 0
loc_2A1E8:
    mov     bx, [bp+arg_0]
    shl     bx, 1
    push    findfilenames[bx]
    call    file_find
    add     sp, 2
    or      ax, ax
    jz      short loc_2A1AC
    pop     bp
    retf
    ; align 2
    db 144
ensure_file_exists endp
do_mer_restext proc far

    sub     ax, ax
    push    ax
    push    ax
    push    dialogarg2
    mov     ax, 0FFFFh
    push    ax
    push    ax
    mov     ax, offset aMer ; "mer"
    push    ax
    push    word ptr mainresptr+2
    push    word ptr mainresptr
    push    cs
    call near ptr locate_text_res
    add     sp, 6
    push    dx
    push    ax
    mov     ax, 1
    push    ax
    push    ax
    push    cs
    call near ptr show_dialog
    add     sp, 12h
    retf
    ; align 2
    db 144
do_mer_restext endp
timer_get_delta_alt proc far

    call    timer_get_delta
    retf
timer_get_delta_alt endp
file_load_3dres proc far
    var_54 = byte ptr -84
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_2A237:
    mov     bp, sp
    sub     sp, 54h
loc_2A23C:
    push    [bp+arg_0]
    lea     ax, [bp+var_54]
    push    ax              ; char *
    call    _strcpy
    add     sp, 4
    mov     ax, offset a_p3s; ".p3s"
    push    ax
    lea     ax, [bp+var_54]
    push    ax              ; char *
    call    _strcat
    add     sp, 4
    lea     ax, [bp+var_54]
    push    ax              ; char *
    mov     ax, 7
    push    ax              ; int
    push    cs
loc_2A264:
    call near ptr file_load_resource
    add     sp, 4
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_2A270:
    or      ax, dx
loc_2A272:
    jnz     short loc_2A2B2
loc_2A274:
    push    [bp+arg_0]
loc_2A277:
    lea     ax, [bp+var_54]
    push    ax              ; char *
loc_2A27B:
    call    _strcpy
loc_2A280:
    add     sp, 4
loc_2A283:
    mov     ax, offset a_3sh; ".3sh"
    push    ax
loc_2A287:
    lea     ax, [bp+var_54]
loc_2A28A:
    push    ax              ; char *
loc_2A28B:
    call    _strcat
loc_2A290:
    add     sp, 4
    lea     ax, [bp+var_54]
loc_2A296:
    push    ax              ; char *
loc_2A297:
    mov     ax, 1
loc_2A29A:
    push    ax              ; int
    push    cs
loc_2A29C:
    call near ptr file_load_resource
loc_2A29F:
    add     sp, 4
loc_2A2A2:
    mov     [bp+var_4], ax
loc_2A2A5:
    mov     [bp+var_2], dx
loc_2A2A8:
    or      ax, dx
loc_2A2AA:
    jnz     short loc_2A2B2
loc_2A2AC:
    push    cs
loc_2A2AD:
    call near ptr do_dea_textres
loc_2A2B0:
    jmp     short loc_2A23C
loc_2A2B2:
    mov     ax, [bp+var_4]
loc_2A2B5:
    mov     dx, [bp+var_2]
loc_2A2B8:
    mov     sp, bp
loc_2A2BA:
    pop     bp
    retf
file_load_3dres endp
seg008 ends
end
