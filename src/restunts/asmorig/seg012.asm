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
seg012 segment byte public 'STUNTSC' use16
    assume cs:seg012
    assume es:nothing, ss:nothing, ds:dseg
    public fatal_error
    public polarAngle
    public off_2EA9B
    public sub_2EAD4
    public set_add_value
    public sub_2EB07
    public sub_2EB1E
    public draw_line_related_alt
    public draw_line_related
    public loc_2EB62
    public off_2ECB9
    public word_2ECF8
    public word_2EDBD
    public word_2EE82
    public word_2F02B
    public parse_shape2d_helper
    public parse_shape2d_helper2
    public word_2F354
    public word_2F356
    public word_2F358
    public word_2F35A
    public criterr_interrupt_handler
    public set_criterr_handler
    public criterr_exithandler
    public preRender_unk
    public nopsub_2F424
    public nopsub_2F436
    public word_2F448
    public off_2F44A
    public off_2F4AC
    public word_2F4AE
    public word_2F4B2
    public word_2F4B4
    public word_2F4B8
    public word_2F4C0
    public word_2F4CA
    public word_2F4D6
    public word_2F4E4
    public word_2F4F4
    public word_2F506
    public word_2F51A
    public word_2F530
    public word_2F548
    public word_2F562
    public word_2F57E
    public word_2F59C
    public word_2F5BC
    public word_2F5DE
    public word_2F602
    public word_2F628
    public word_2F650
    public word_2F67A
    public word_2F6A6
    public word_2F6D4
    public word_2F704
    public word_2F736
    public word_2F76A
    public word_2F790
    public word_2F7A0
    public word_2F7D8
    public word_2F812
    public word_2F84E
    public word_2F88C
    public word_2F8CC
    public word_2F90E
    public word_2F952
    public word_2F998
    public word_2F9E0
    public word_2FA2A
    public word_2FA76
    public word_2FAC4
    public word_2FB14
    public word_2FB66
    public word_2FBBA
    public word_2FC10
    public word_2FC68
    public word_2FCC2
    public word_2FD1E
    public word_2FD7C
    public preRender_line
    public add_exit_handler
    public call_exitlist
    public call_exitlist2
    public file_paras
    public file_paras_nofatal
    public file_paras_fatal
    public file_decomp_paras
    public file_decomp_paras_nofatal
    public file_decomp_paras_fatal
    public file_find
    public file_find_next
    public multiply_and_scale
    public video_set_mode4
    public polarRadius2D
    public video_set_mode7
    public nopsub_30180
    public timer_setup_interrupt
    public loc_301FD
    public audio_stop_unk
    public timer_reg_callback
    public timer_remove_callback
    public compare_ds_ss
    public timer_intr_callback
    public sub_303BA
    public set_bios_mode3
    public kb_parse_key
    public kb_reg_callback
    public nopsub_304AF
    public nopsub_304B6
    public kb_get_char
    public get_kb_or_joy_flags
    public nopsub_305C8
    public get_joy_flags
    public sub_307B4
    public sub_307D2
    public sub_307E3
    public nopsub_307FA
    public kb_init_interrupt
    public kb_exit_handler
    public kb_int9_handler
    public kb_int16_handler
    public kb_get_key_state
    public kb_call_readchar_callback
    public kb_read_char
    public kb_checking
    public nopsub_kb_set_readchar_callback
    public nopsub_kb_get_readchar_callback
    public flush_stdin
    public kb_check
    public nopsub_30A77
    public nopsub_30A97
    public file_read
    public file_read_nofatal
    public file_read_fatal
    public file_decomp_rle
    public file_decomp_rle_single
    public file_decomp_rle_seq
    public file_load_binary
    public file_load_binary_nofatal
    public file_decomp
    public file_decomp_nofatal
    public file_decomp_fatal
    public locate_shape_nofatal
    public locate_shape_fatal
    public locate_sound_fatal
    public mmgr_alloc_resmem
    public loc_310CD
    public mmgr_alloc_a000
    public nopsub_310FE
    public nopsub_3111D
    public nopsub_31157
    public nopsub_31169
    public mmgr_get_ofs_diff
    public mmgr_copy_paras
    public copy_paras_reverse
    public mmgr_path_to_name
    public mmgr_alloc_pages
    public mmgr_find_free
    public mmgr_get_chunk_by_name
    public nopsub_31429
    public mmgr_free
    public loc_31498
    public nopsub_31525
    public mmgr_release
    public mmgr_get_chunk_size
    public mmgr_resize_memory
    public mmgr_op_unk
    public preRender_default
    public preRender_default_alt
    public loc_317CE
    public skybox_op_helper
    public preRender_wheel_helper4
    public loc_317FB
    public loc_3180A
    public preRender_helper
    public preRender_helper2
    public off_31A82
    public locret_31AA3
    public preRender_helper3
    public off_31B84
    public off_31CF7
    public nopsub_31F39
    public nopsub_31F55
    public nopsub_3215A
    public nopsub_3216C
    public nopsub_3219D
    public nopsub_322B4
    public nopsub_322C0
    public nopsub_322DF
    public set_projection
    public loc_32334
    public vector_to_point
    public sprite_free_wnd
    public file_write_nofatal
    public file_write_fatal
    public video_add_exithandler
    public video_on_exit
    public sprite_copy_both_to_arg
    public sprite_copy_arg_to_both
    public file_get_res_shape_count
    public file_get_shape2d
    public nopsub_326BA
    public sin_fast
    public off_326F2
    public cos_fast
    public nopsub_32738
    public nopsub_32746
    public nopsub_32751
    public transformed_shape_op_helper2
    public nopsub_3276A
    public timer_get_counter
    public timer_custom_delta
    public timer_get_delta
    public timer_reset
    public timer_copy_counter
    public timer_wait_for_dx
    public timer_compare_dx
    public timer_get_counter_unk
    public font_op
    public font_op2
    public loc_3284A
    public loc_32882
    public preRender_patterned
    public nopsub_328C9
    public nopsub_328DB
    public mat_mul_vector
    public mat_multiply
    public mat_invert
    public fliphandlers
    public file_unflip_shape2d
    public vle_esc1
    public vle_esc2
    public file_decomp_vle
    public nopsub_32FEE
    public video_get_status
    public nopsub_33006
    public vector_op_unk
    public loc_3301F
    public preRender_sphere
    public nopsub_3320E
    public sprite_set_1_size
    public video_clear_color
    public sprite_clear_1_color
    public nopsub_33330
    public draw_unknown_lines
    public putpixel_line1_maybe
    public off_3340A
    public sprite_1_unk2
    public loc_335CF
    public sprite_1_unk
    public loc_335D7
    public loc_33622
    public byte_33646
    public byte_33652
    public byte_33656
    public sprite_1_unk3
    public loc_33697
    public font_draw_text
    public video_set_mode_13h
    public file_load_shape2d_res_fatal_thunk
    public file_load_shape2d_res_nofatal_thunk
    public file_load_shape2d_res_thunk
    public parse_shape2d_thunk
    public file_load_shape2d_fatal_thunk
    public file_load_shape2d_nofatal_thunk
    public file_load_shape2d_thunk
    public sprite_putimage_and_alt2
    public sprite_putimage_and
    public loc_338C9
    public nopsub_339FA
    public putpixel_iconMask
    public loc_33A57
    public nopsub_33AC0
    public nopsub_33AE4
    public shape2d_render_bmp_as_mask
    public loc_33B1D
    public nopsub_33B98
    public sprite_putimage_and_alt
    public sprite_putimage
    public loc_33BF5
    public nopsub_33D0C
    public sprite_shape_to_1
    public sprite_shape_to_1_alt
    public loc_33D69
    public nopsub_33DBE
    public shape2d_op_unk5
    public shape2d_op_unk
    public loc_33E1B
    public loc_33E27
    public nopsub_33E90
    public shape2d_op_unk2
    public shape2d_op_unk3
    public loc_33EED
    public sprite_putimage_or_alt
    public sprite_putimage_or
    public loc_340BD
    public putpixel_iconFillings
    public loc_3424B
    public shape2d_op_unk4
    public loc_34311
    public sprite_putimage_transparent
    public loc_343E9
    public sub_34526
    public loc_34541
    public sub_345BC
    public loc_345E5
    public video_set_palette
    public loc_346A8
    public draw_filled_lines
    public nopsub_34736
    public sprite_clear_shape_alt
    public sprite_clear_shape
    public loc_34799
    public shape_op_explosion
    public sprite1
    public sprite2
    public lineoffsets
    public font_set_unk
    public set_fontdefseg
    public draw_patterned_lines
    public sprite_make_wnd
    public next_wnd_def
    public wnd_defs
    public sprite_set_1_from_argptr
    public sprite_copy_2_to_1
    public putpixel_single_maybe
    public sub_35B76
    public sub_35C4E
    public incnums
    public sub_35DC8
    public sub_35DE6
    public sub_35E08
    public loc_35ED9
    public file_load_shape2d_palmap_apply
    public file_load_shape2d_expand
    public file_unflip_shape2d_pes
algn_2EA29:
    ; align 2
    db 144
fatal_error proc near

    pop     ax
    pop     ax
loc_2EA2C:
    call    sprite_copy_2_to_1
loc_2EA31:
    call    _printf
loc_2EA36:
    call    flush_stdin
loc_2EA3B:
    call    call_exitlist
loc_2EA40:
    call    _printf
loc_2EA45:
    add     sp, 2
loc_2EA48:
    call    _abort
    ; align 2
    db 0
fatal_error endp
polarAngle proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_z = word ptr 6
    arg_x = word ptr 8

    push    bp
    mov     bp, sp
    push    di
    xor     di, di
    mov     dx, [bp+arg_z]
    mov     cx, [bp+arg_x]
    or      dx, dx
    jge     short loc_2EA63
smart
    or      di, 8
nosmart
    neg     dx
loc_2EA63:
    or      cx, cx
    jge     short loc_2EA6C
smart
    or      di, 4
nosmart
    neg     cx
loc_2EA6C:
    cmp     dx, cx
    jl      short loc_2EA77
    jz      short loc_2EA8F
    xchg    dx, cx
loc_2EA74:
smart
    or      di, 2
nosmart
loc_2EA77:
    xor     ax, ax
    div     cx
loc_2EA7B:
    mov     bl, ah
    xor     bh, bh
    add     al, 80h ; 'Ä'
    adc     bx, 0
loc_2EA84:
    mov     al, atantable[bx]
    xor     ah, ah
loc_2EA8A:
    jmp     cs:off_2EA9B[di]
loc_2EA8F:
    or      dx, dx
    jz      short loc_2EAB0
    mov     ax, 80h ; 'Ä'
    jmp     cs:off_2EA9B[di]
off_2EA9B     dw offset loc_2EAB0
    dw offset loc_2EAAB
    dw offset loc_2EAB8
    dw offset loc_2EAB3
    dw offset loc_2EABF
    dw offset loc_2EAC3
    dw offset loc_2EACF
    dw offset loc_2EAC8
loc_2EAAB:
    neg     ax
    add     ah, 1
loc_2EAB0:
    pop     di
    pop     bp
    retf
loc_2EAB3:
    add     ah, 1
    jmp     short loc_2EAB0
loc_2EAB8:
    neg     ax
    add     ah, 2
    jmp     short loc_2EAB0
loc_2EABF:
    neg     ax
    jmp     short loc_2EAB0
loc_2EAC3:
    sub     ah, 1
    jmp     short loc_2EAB0
loc_2EAC8:
    add     ah, 1
    neg     ax
    jmp     short loc_2EAB0
loc_2EACF:
    sub     ah, 2
    jmp     short loc_2EAB0
polarAngle endp
sub_2EAD4 proc far

    cli
    mov     ax, word_3F87C
    mov     dx, word_3F87E
loc_2EADC:
    sti
locret_2EADD:
    retf
sub_2EAD4 endp
set_add_value proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
loc_2EADF:
    mov     bp, sp
loc_2EAE1:
    call    sub_2EAD4
loc_2EAE6:
    add     ax, [bp+arg_0]
loc_2EAE9:
    adc     dx, [bp+arg_2]
loc_2EAEC:
    mov     word_3F1C2, ax
loc_2EAEF:
    mov     word_3F1C4, dx
    pop     bp
    retf
loc_2EAF5:
    call    sub_2EAD4
    cmp     dx, word_3F1C4
    jb      short loc_2EAF5
    cmp     ax, word_3F1C2
    jb      short loc_2EAF5
    retf
set_add_value endp
sub_2EB07 proc far

    call    sub_2EAD4
    xor     cx, cx
    cmp     dx, word_3F1C4
    jb      short loc_2EB1B
    cmp     ax, word_3F1C2
    jb      short loc_2EB1B
    inc     cx
loc_2EB1B:
    mov     ax, cx
    retf
sub_2EB07 endp
sub_2EB1E proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    call    sub_2EAD4
    add     ax, [bp+arg_0]
    adc     dx, [bp+arg_2]
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_2EB35:
    call    sub_2EAD4
    cmp     dx, [bp+var_2]
    jb      short loc_2EB35
    cmp     ax, [bp+var_4]
    jb      short loc_2EB35
    mov     sp, bp
    pop     bp
    retf
sub_2EB1E endp
draw_line_related_alt proc far
    var_4 = byte ptr -4
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    push    di
    mov     [bp+var_4], 1
    jmp     short loc_2EB62
draw_line_related_alt endp
draw_line_related proc far
    var_4 = byte ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_startX = word ptr 6
    arg_startY = word ptr 8
    arg_endX = word ptr 10
    arg_endY = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    push    di
    mov     [bp+var_4], 0
loc_2EB62:
    mov     si, [bp+arg_8]  ; arg_8 is a pointer to something sizeof 0x1C
    mov     word ptr [si+12h], 0FFh
    xor     ax, ax
    mov     [si], ax
    mov     [si+4], ax
    mov     [si+14h], ax
    mov     [si+16h], ax
    mov     [si+18h], ax
    mov     [si+1Ah], ax
    mov     ax, [bp+arg_startY]
    mov     bx, [bp+arg_endY]
    mov     cx, [bp+arg_startX]
    mov     dx, [bp+arg_endX]
    cmp     ax, bx
    jg      short loc_2EB9C
    mov     [si+2], cx
    mov     [si+6], ax
    mov     [si+8], dx
loc_2EB96:
    mov     [si+0Ah], bx
    jmp     short loc_2EBA8
    ; align 2
    db 144
loc_2EB9C:
    mov     [si+2], dx
    mov     [si+6], bx
    mov     [si+8], cx
    mov     [si+0Ah], ax
loc_2EBA8:
    jnz     short loc_2EBAD
    jmp     loc_2F1A3
loc_2EBAD:
    xor     dx, dx
    cmp     [bp+var_4], 0
    jnz     short loc_2EC1A
    mov     ax, [si+6]
    mov     bx, cs:sprite1.sprite_top
    mov     cx, cs:sprite1.sprite_height
    cmp     ax, cx
    jl      short loc_2EBCB
    mov     dl, 8
    jmp     loc_2EF9B
loc_2EBCB:
    cmp     ax, bx
    jge     short loc_2EBD2
    or      dh, 4
loc_2EBD2:
    mov     ax, [si+0Ah]
    cmp     ax, bx
    jge     short loc_2EBDE
    mov     dl, 4
    jmp     loc_2EF9B
loc_2EBDE:
    cmp     ax, cx
    jl      short loc_2EBE5
    or      dl, 8
loc_2EBE5:
    mov     bx, cs:sprite1.sprite_left2
    mov     cx, cs:sprite1.sprite_widthsum
    mov     ax, [si+2]
    cmp     ax, bx
    jge     short loc_2EBF9
    or      dh, 2
loc_2EBF9:
    cmp     ax, cx
    jl      short loc_2EC00
    or      dh, 1
loc_2EC00:
    mov     ax, [si+8]
    cmp     ax, bx
    jge     short loc_2EC0A
    or      dl, 2
loc_2EC0A:
    cmp     ax, cx
    jl      short loc_2EC11
    or      dl, 1
loc_2EC11:
    test    dl, dh
    jz      short loc_2EC1A
    and     dl, dh
    jmp     loc_2EF9B
loc_2EC1A:
    or      dl, dh
    xor     dh, dh
    mov     [bp+var_2], dx
    mov     cx, [si+0Ah]
    sub     cx, [si+6]
    jno     short loc_2EC2C
loc_2EC29:
    jmp     loc_2F253
loc_2EC2C:
    mov     dx, [si+8]
    sub     dx, [si+2]
    jo      short loc_2EC29
    jnz     short loc_2EC41
    inc     cx
    mov     [si+0Eh], cx
    mov     byte ptr [si+12h], 2
    jmp     short loc_2ECAD
    db 144
loc_2EC41:
    jl      short loc_2EC8F
    cmp     dx, cx
    jb      short loc_2EC82
    jz      short loc_2EC88
    mov     byte ptr [si+12h], 8
loc_2EC4D:
    xchg    cx, dx
loc_2EC4F:
    cmp     cx, cs:word_2F448
    jge     short loc_2EC69
    mov     bx, cx
    shl     bx, 1
    mov     bx, cs:off_2F44A[bx]
    add     bx, dx
    add     bx, dx
    mov     ax, cs:[bx]
    jmp     short loc_2EC76
    db 144
loc_2EC69:
    xor     ax, ax
    div     cx
    mov     bx, cx
    shr     bx, 1
    sub     bx, dx
    adc     ax, 0
loc_2EC76:
    mov     [si+0Ch], ax
    inc     cx
    jo      short loc_2EC29
    mov     [si+0Eh], cx
    jmp     short loc_2ECAD
    ; align 2
    db 144
loc_2EC82:
    mov     byte ptr [si+12h], 6
    jmp     short loc_2EC4F
loc_2EC88:
    mov     byte ptr [si+12h], 4
    jmp     short loc_2ECA9
    db 144
loc_2EC8F:
    neg     dx
    jo      short loc_2EC29
    cmp     dx, cx
    jb      short loc_2EC9F
    jz      short loc_2ECA5
    mov     byte ptr [si+12h], 7
    jmp     short loc_2EC4D
loc_2EC9F:
    mov     byte ptr [si+12h], 5
    jmp     short loc_2EC4F
loc_2ECA5:
    mov     byte ptr [si+12h], 3
loc_2ECA9:
    inc     cx
    mov     [si+0Eh], cx
loc_2ECAD:
    mov     bx, [bp+var_2]
    shl     bx, 1
    jz      short loc_2ECD9
    jmp     cs:off_2ECB9[bx]
off_2ECB9     dw offset loc_2ECD9
    dw offset loc_2F01F
    dw offset loc_2EE78
    dw offset loc_2EE78
    dw offset loc_2ECE1
    dw offset loc_2ECE1
    dw offset loc_2ECE1
    dw offset loc_2ECE1
    dw offset loc_2EDA5
    dw offset loc_2EDA5
    dw offset loc_2EDA5
    dw offset loc_2EDA5
    dw offset loc_2ECE1
    dw offset loc_2ECE1
    dw offset loc_2ECE1
    dw offset loc_2ECE1
loc_2ECD9:
    xor     ax, ax
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_2ECE1:
    mov     ax, [si+6]
    mov     cx, cs:sprite1.sprite_top
    mov     [si+6], cx
    sub     cx, ax
    mov     bl, [si+12h]
    shl     bx, 1
    jmp     cs:word_2ECF8[bx]
word_2ECF8     dw 0
    dw 0
    dw offset loc_2ED0A
    dw offset loc_2ED10
    dw offset loc_2ED19
    dw offset loc_2ED22
    dw offset loc_2ED32
    dw offset loc_2ED42
    dw offset loc_2ED7E
loc_2ED0A:
    sub     [si+0Eh], cx
    jmp     loc_2F13E
loc_2ED10:
    sub     [si+2], cx
    sub     [si+0Eh], cx
    jmp     loc_2F13E
loc_2ED19:
    add     [si+2], cx
    sub     [si+0Eh], cx
    jmp     loc_2F13E
loc_2ED22:
    mov     ax, [si+0Ch]
    mul     cx
    sub     [si], ax
    sbb     [si+2], dx
    sub     [si+0Eh], cx
    jmp     loc_2F13E
loc_2ED32:
    mov     ax, [si+0Ch]
    mul     cx
    add     [si], ax
    adc     [si+2], dx
    sub     [si+0Eh], cx
    jmp     loc_2F13E
loc_2ED42:
    mov     [si+6], ax
    mov     dx, cx
    xor     ax, ax
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
    sub     [si+2], ax
    sub     [si+0Eh], ax
    jle     short loc_2ED69
    mul     word ptr [si+0Ch]
    add     [si+4], ax
    adc     [si+6], dx
    jmp     loc_2F13E
loc_2ED69:
    mov     word ptr [si+0Eh], 1
    mov     ax, cs:sprite1.sprite_top
    mov     [si+6], ax
    mov     ax, [si+8]
    mov     [si+2], ax
    jmp     loc_2F13E
loc_2ED7E:
    mov     [si+6], ax
    mov     dx, cx
    xor     ax, ax
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
    add     [si+2], ax
    sub     [si+0Eh], ax
    jle     short loc_2ED69
    mul     word ptr [si+0Ch]
    add     [si+4], ax
    adc     [si+6], dx
    jmp     loc_2F13E
loc_2EDA5:
    mov     cx, [si+0Ah]
    mov     dx, cs:sprite1.sprite_height
    dec     dx
    mov     [si+0Ah], dx
    sub     cx, dx
    mov     bl, [si+12h]
    shl     bx, 1
    jmp     cs:word_2EDBD[bx]
word_2EDBD     dw 0
    dw 0
    dw offset loc_2EDCF
    dw offset loc_2EDD5
    dw offset loc_2EDDE
    dw offset loc_2EDE7
    dw offset loc_2EE0B
    dw offset loc_2EE2A
    dw offset loc_2EE53
loc_2EDCF:
    sub     [si+0Eh], cx
    jmp     loc_2F148
loc_2EDD5:
    add     [si+8], cx
    sub     [si+0Eh], cx
    jmp     loc_2F148
loc_2EDDE:
    sub     [si+8], cx
    sub     [si+0Eh], cx
    jmp     loc_2F148
loc_2EDE7:
    mov     dx, [si+0Eh]
    sub     dx, cx
    mov     [si+0Eh], dx
    dec     dx
    mov     ax, [si+0Ch]
    mul     dx
    mov     bx, [si]
    mov     cx, [si+2]
    sub     bx, ax
    sbb     cx, dx
    add     bx, 8000h
    adc     cx, 0
    mov     [si+8], cx
    jmp     loc_2F148
loc_2EE0B:
    mov     dx, [si+0Eh]
    sub     dx, cx
    mov     [si+0Eh], dx
    dec     dx
    mov     ax, [si+0Ch]
    mul     dx
    add     ax, [si]
    adc     dx, [si+2]
    add     ax, 8000h
    adc     dx, 0
    mov     [si+8], dx
    jmp     loc_2F148
loc_2EE2A:
    xor     ax, ax
    sub     ax, [si+4]
    sbb     dx, [si+6]
    jl      short loc_2EE4F
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
loc_2EE40:
    mov     dx, [si+2]
    sub     dx, ax
    mov     [si+8], dx
    inc     ax
    mov     [si+0Eh], ax
    jmp     loc_2F148
loc_2EE4F:
    xor     ax, ax
    jmp     short loc_2EE40
loc_2EE53:
    xor     ax, ax
    sub     ax, [si+4]
    sbb     dx, [si+6]
    jl      short loc_2EE4F
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
    mov     dx, [si+2]
    add     dx, ax
    mov     [si+8], dx
    inc     ax
    mov     [si+0Eh], ax
    jmp     loc_2F148
loc_2EE78:
    mov     bl, [si+12h]
    shl     bx, 1
    jmp     cs:word_2EE82[bx]
word_2EE82     dw 0
    dw 0
    dw offset loc_2EF98
    dw offset loc_2EE94
    dw offset loc_2EEAD
    dw offset loc_2EEC6
    dw offset loc_2EEFE
    dw offset loc_2EF31
    dw offset loc_2EF61
loc_2EE94:
    mov     cx, cs:sprite1.sprite_left2
    mov     ax, [si+8]
    mov     [si+8], cx
    sub     cx, ax
    add     [si+16h], cx
    sub     [si+0Eh], cx
    sub     [si+0Ah], cx
    jmp     loc_2F196
loc_2EEAD:
    mov     ax, [si+2]
    mov     cx, cs:sprite1.sprite_left2
    mov     [si+2], cx
    sub     cx, ax
    add     [si+14h], cx
    add     [si+6], cx
    sub     [si+0Eh], cx
    jmp     loc_2F196
loc_2EEC6:
    mov     ax, [si]
    mov     dx, [si+2]
    mov     cx, cs:sprite1.sprite_left2
    mov     [si+8], cx
    sub     dx, cx
    jl      short loc_2EEF9
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
    inc     ax
loc_2EEE4:
    mov     cx, [si+0Eh]
    mov     [si+0Eh], ax
    sub     cx, ax
    add     [si+16h], cx
    dec     ax
    add     ax, [si+6]
    mov     [si+0Ah], ax
    jmp     loc_2F196
loc_2EEF9:
    mov     ax, 1
    jmp     short loc_2EEE4
loc_2EEFE:
    mov     dx, cs:sprite1.sprite_left2
    xor     ax, ax
    sub     ax, [si]
    sbb     dx, [si+2]
    jl      short loc_2EF2E
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
    add     [si+6], ax
    add     [si+14h], ax
    sub     [si+0Eh], ax
    jle     short loc_2EF98
    mul     word ptr [si+0Ch]
    add     [si], ax
    adc     [si+2], dx
    jmp     loc_2F196
loc_2EF2E:
    jmp     short loc_2EF98
    nop
loc_2EF31:
    mov     ax, [si+2]
    mov     dx, cs:sprite1.sprite_left2
    mov     [si+8], dx
    sub     ax, dx
    mov     cx, ax
    inc     cx
    mov     [si+0Eh], cx
    mul     word ptr [si+0Ch]
    add     ax, [si+4]
    adc     dx, [si+6]
    add     ax, 8000h
    adc     dx, 0
    mov     ax, [si+0Ah]
    sub     ax, dx
    mov     [si+0Ah], dx
    add     [si+16h], ax
    jmp     loc_2F196
loc_2EF61:
    mov     cx, [si+2]
    mov     ax, cs:sprite1.sprite_left2
    mov     [si+2], ax
    sub     ax, cx
    sub     [si+0Eh], ax
    mul     word ptr [si+0Ch]
    mov     bx, [si+4]
    mov     cx, [si+6]
    add     ax, bx
    adc     dx, cx
    mov     [si+4], ax
    mov     [si+6], dx
    add     bx, 8000h
    adc     cx, 0
    add     ax, 8000h
    adc     dx, 0
    sub     dx, cx
    add     [si+14h], dx
    jmp     loc_2F196
loc_2EF98:
    mov     dx, 2
loc_2EF9B:
    mov     [si+13h], dl
    mov     word ptr [si+0Eh], 0
    mov     al, [si+13h]
    test    al, 4
    jz      short loc_2EFBE
    mov     bx, cs:sprite1.sprite_top
    mov     [si+6], bx
    mov     word ptr [si+4], 0
    dec     bx
    mov     [si+0Ah], bx
    jmp     short loc_2F017
    ; align 2
    db 144
loc_2EFBE:
    test    al, 8
    jz      short loc_2EFD2
    mov     bx, cs:sprite1.sprite_height
    mov     [si+6], bx
    mov     word ptr [si+4], 0
    jmp     short loc_2F017
    ; align 2
    db 144
loc_2EFD2:
    mov     cx, [si+0Ah]
    cmp     cx, cs:sprite1.sprite_height
    jl      short loc_2EFE2
    mov     cx, cs:sprite1.sprite_height
    dec     cx
loc_2EFE2:
    mov     dx, [si+6]
    mov     bx, [si+4]
    add     bx, 8000h
    adc     dx, 0
    cmp     dx, cs:sprite1.sprite_top
    jge     short loc_2EFFB
    mov     dx, cs:sprite1.sprite_top
loc_2EFFB:
    mov     [si+6], dx
    mov     word ptr [si+4], 0
    sub     cx, dx
    dec     dx
    inc     cx
    mov     [si+0Ah], dx
    test    al, 2
    jz      short loc_2F014
    add     [si+16h], cx
    jmp     short loc_2F017
    ; align 2
    db 144
loc_2F014:
    add     [si+1Ah], cx
loc_2F017:
    xor     ah, ah
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_2F01F:
    mov     bl, [si+12h]
loc_2F022:
    xor     bh, bh
    shl     bx, 1
    jmp     cs:word_2F02B[bx]
word_2F02B     dw 0
    dw 0
    dw offset loc_2F03D
    dw offset loc_2F043
    dw offset loc_2F05C
    dw offset loc_2F076
    dw offset loc_2F0A3
    dw offset loc_2F0D7
    dw offset loc_2F110
loc_2F03D:
    mov     dx, 1
    jmp     loc_2EF9B
loc_2F043:
    mov     cx, [si+2]
    mov     ax, cs:sprite1.sprite_widthsum
    dec     ax
    mov     [si+2], ax
    sub     cx, ax
    add     [si+6], cx
    sub     [si+0Eh], cx
    add     [si+18h], cx
    jmp     loc_2ECD9
loc_2F05C:
    mov     cx, cs:sprite1.sprite_widthsum
    dec     cx
    mov     ax, [si+8]
    mov     [si+8], cx
    sub     ax, cx
    add     [si+1Ah], ax
    sub     [si+0Eh], ax
    sub     [si+0Ah], ax
    jmp     loc_2ECD9
loc_2F076:
    mov     ax, [si]
    mov     dx, [si+2]
    sub     dx, cs:sprite1.sprite_widthsum
    inc     dx
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
    sub     [si+0Eh], ax
    jle     short loc_2F03D
    add     [si+6], ax
    add     [si+18h], ax
    mul     word ptr [si+0Ch]
    sub     [si], ax
    sbb     [si+2], dx
    jmp     loc_2ECD9
loc_2F0A3:
    mov     dx, cs:sprite1.sprite_widthsum
    dec     dx
    mov     [si+8], dx
    xor     ax, ax
    sub     ax, [si]
    sbb     dx, [si+2]
    jl      short loc_2F03D
    mov     cx, [si+0Ch]
    div     cx
    shr     cx, 1
    sub     cx, dx
    adc     ax, 0
    inc     ax
    mov     cx, [si+0Eh]
    mov     [si+0Eh], ax
    sub     cx, ax
    add     [si+1Ah], cx
    dec     ax
    add     ax, [si+6]
    mov     [si+0Ah], ax
    jmp     loc_2ECD9
loc_2F0D7:
    mov     ax, [si+2]
    mov     cx, cs:sprite1.sprite_widthsum
    dec     cx
    sub     ax, cx
    mov     [si+2], cx
    sub     [si+0Eh], ax
    mul     word ptr [si+0Ch]
    mov     bx, [si+4]
    mov     cx, [si+6]
    add     ax, bx
    adc     dx, cx
    mov     [si+4], ax
    mov     [si+6], dx
    add     bx, 8000h
    adc     cx, 0
    add     ax, 8000h
    adc     dx, 0
    sub     dx, cx
    add     [si+18h], dx
    jmp     loc_2ECD9
loc_2F110:
    mov     ax, cs:sprite1.sprite_widthsum
    mov     cx, ax
    dec     cx
    mov     [si+8], cx
    sub     ax, [si+2]
    mov     [si+0Eh], ax
    dec     ax
    mul     word ptr [si+0Ch]
    add     ax, [si+4]
    adc     dx, [si+6]
    add     ax, 8000h
    adc     dx, 0
    mov     ax, [si+0Ah]
    sub     ax, dx
    mov     [si+0Ah], dx
    add     [si+1Ah], ax
    jmp     loc_2ECD9
loc_2F13E:
    test    [bp+var_2], 8
    jz      short loc_2F148
    jmp     loc_2EDA5
loc_2F148:
    xor     dx, dx
    mov     ax, [si+2]
    cmp     ax, cs:sprite1.sprite_left2
    jge     short loc_2F157
    or      dh, 2
loc_2F157:
    mov     bx, [si]
    add     bx, 8000h
    adc     ax, 0
    cmp     ax, cs:sprite1.sprite_widthsum
    jl      short loc_2F16A
    or      dh, 1
loc_2F16A:
    mov     ax, [si+8]
    cmp     ax, cs:sprite1.sprite_left2
    jge     short loc_2F177
    or      dl, 2
loc_2F177:
    cmp     ax, cs:sprite1.sprite_widthsum
    jl      short loc_2F181
    or      dl, 1
loc_2F181:
    test    dl, dh
    jz      short loc_2F18A
    and     dl, dh
    jmp     loc_2EF9B
loc_2F18A:
    or      dl, dh
    jz      short loc_2F1A0
    xor     dh, dh
    mov     [bp+var_2], dx
    jmp     loc_2ECAD
loc_2F196:
    test    [bp+var_2], 1
    jz      short loc_2F1A0
    jmp     loc_2F01F
loc_2F1A0:
    jmp     loc_2ECD9
loc_2F1A3:
    mov     byte ptr [si+12h], 1
    cmp     cx, dx
    jnz     short loc_2F1AF
    mov     byte ptr [si+12h], 9
loc_2F1AF:
    jle     short loc_2F1BD
    mov     byte ptr [si+12h], 0
    mov     [si+2], dx
    mov     [si+8], cx
    xchg    cx, dx
loc_2F1BD:
    cmp     [bp+var_4], 0
    jnz     short loc_2F1E4
    mov     bx, cs:sprite1.sprite_top
    cmp     ax, bx
    jge     short loc_2F1ED
    mov     al, 4
    mov     [si+6], bx
    mov     [si+0Ah], bx
loc_2F1D4:
    mov     [si+13h], al
    mov     word ptr [si+0Eh], 0
    xor     ah, ah
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_2F1E4:
    sub     dx, cx
    inc     dx
    mov     [si+0Eh], dx
    jmp     loc_2ECD9
loc_2F1ED:
    mov     bx, cs:sprite1.sprite_height
    cmp     ax, bx
    jl      short loc_2F200
    mov     al, 8
    mov     [si+6], bx
    mov     [si+0Ah], bx
    jmp     short loc_2F1D4
loc_2F200:
    mov     ax, dx
    sub     ax, cx
    inc     ax
    mov     [si+0Eh], ax
    cmp     dx, cs:sprite1.sprite_left2
    jge     short loc_2F21B
    dec     word ptr [si+0Ah]
    mov     word ptr [si+16h], 1
    mov     al, 2
    jmp     short loc_2F1D4
loc_2F21B:
    cmp     cx, cs:sprite1.sprite_widthsum
    jl      short loc_2F22E
    dec     word ptr [si+0Ah]
    mov     word ptr [si+1Ah], 1
    mov     al, 1
    jmp     short loc_2F1D4
loc_2F22E:
    mov     ax, cs:sprite1.sprite_left2
    mov     bx, ax
    sub     ax, cx
    jle     short loc_2F23E
    mov     [si+2], bx
    sub     [si+0Eh], ax
loc_2F23E:
    mov     ax, dx
    mov     bx, cs:sprite1.sprite_widthsum
    dec     bx
    sub     ax, bx
    jle     short loc_2F250
    sub     [si+0Eh], ax
    mov     [si+8], bx
loc_2F250:
    jmp     loc_2ECD9
loc_2F253:
    mov     cx, [si+0Ah]
    sar     cx, 1
    mov     ax, [si+6]
    sar     ax, 1
    sub     cx, ax
    sar     cx, 1
    mov     dx, [si+8]
    sar     dx, 1
    mov     ax, [si+2]
    sar     ax, 1
    sub     dx, ax
    sar     dx, 1
loc_2F26F:
    cmp     word ptr [si+6], 0C180h
    jg      short loc_2F2B0
loc_2F276:
    mov     ax, [si+6]
    add     ax, cx
    mov     [si+6], ax
    mov     bx, ax
    sub     ax, cs:sprite1.sprite_top
    jle     short loc_2F2AB
    cmp     ax, cx
    jle     short loc_2F28D
    mov     ax, cx
loc_2F28D:
    sub     bx, cs:sprite1.sprite_height
    jle     short loc_2F298
    sub     ax, bx
    jle     short loc_2F2AB
loc_2F298:
    mov     bx, [si+2]
    cmp     bx, cs:sprite1.sprite_left2
    jge     short loc_2F2A8
    add     [si+14h], ax
    jmp     short loc_2F2AB
    ; align 2
    db 144
loc_2F2A8:
    add     [si+18h], ax
loc_2F2AB:
    add     [si+2], dx
    jmp     short loc_2F26F
loc_2F2B0:
    cmp     word ptr [si+0Ah], 3E80h
    jge     short loc_2F2D6
    cmp     word ptr [si+2], 0C180h
    jle     short loc_2F276
    cmp     word ptr [si+2], 3E80h
    jge     short loc_2F276
    cmp     word ptr [si+8], 0C180h
    jle     short loc_2F2D6
    cmp     word ptr [si+8], 3E80h
    jge     short loc_2F2D6
    jmp     loc_2EBAD
loc_2F2D6:
    mov     ax, [si+0Ah]
    sub     ax, cx
    mov     [si+0Ah], ax
    mov     bx, ax
    sub     ax, cs:sprite1.sprite_height
    inc     ax
    jge     short loc_2F30F
    neg     ax
    cmp     ax, cx
    jle     short loc_2F2F0
    mov     ax, cx
loc_2F2F0:
    sub     bx, cs:sprite1.sprite_top
    inc     bx
    jge     short loc_2F2FC
    add     ax, bx
    jle     short loc_2F30F
loc_2F2FC:
    mov     bx, [si+8]
    cmp     bx, cs:sprite1.sprite_left2
    jge     short loc_2F30C
    add     [si+16h], ax
    jmp     short loc_2F30F
    ; align 2
    db 144
loc_2F30C:
    add     [si+1Ah], ax
loc_2F30F:
    sub     [si+8], dx
    jmp     short loc_2F2B0
draw_line_related endp
parse_shape2d_helper proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_2]
    xor     dx, dx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     ax, [bp+arg_0]
    adc     dx, 0
    pop     bp
    retf
parse_shape2d_helper endp
parse_shape2d_helper2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_2]
    mov     dx, [bp+arg_0]
    mov     ax, dx
    shr     bx, 1
    rcr     dx, 1
    shr     bx, 1
    rcr     dx, 1
    shr     bx, 1
    rcr     dx, 1
    shr     bx, 1
    rcr     dx, 1
smart
    and     ax, 0Fh
nosmart
    pop     bp
    retf
word_2F354     dw 0
word_2F356     dw 0
word_2F358     dw 0
word_2F35A     dw 0
parse_shape2d_helper2 endp
criterr_interrupt_handler proc far
     r = byte ptr 0

    push    bx
    push    dx
    push    cx
    push    si
    push    di
    push    ds
    push    es
    push    bp
    mov     ax, ss
    mov     ds, ax
    mov     bx, offset word_2F358
    call    dword ptr cs:[bx]
    pop     bp
    pop     es
    pop     ds
    pop     di
    pop     si
    pop     cx
    pop     dx
    pop     bx
    iret
criterr_interrupt_handler endp
set_criterr_handler proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    ds
    push    cs
    mov     ax, offset criterr_exithandler
    push    ax
    call    add_exit_handler
    add     sp, 4
    mov     ax, [bp+arg_0]
    mov     cs:word_2F358, ax
    mov     ax, [bp+arg_2]
    mov     cs:word_2F35A, ax
    xor     ax, ax
    mov     es, ax
    mov     bx, 90h ; 'ê'
    mov     ax, es:[bx]
    mov     cs:word_2F354, ax
    mov     ax, es:[bx+2]
    mov     cs:word_2F356, ax
    mov     dx, offset criterr_interrupt_handler
    mov     ax, cs
    mov     ds, ax
    mov     al, 24h ; '$'
    mov     ah, 25h
    int     21h             ; DOS - SET INTERRUPT VECTOR
    pop     ds
    pop     bp
    retf
set_criterr_handler endp
criterr_exithandler proc far

    push    ds
    mov     ax, cs:word_2F356
    sub     ax, cs:word_2F354
    jz      short loc_2F3D8
    mov     dx, cs:word_2F354
    mov     ds, cs:word_2F356
    mov     al, 24h ; '$'
    mov     ah, 25h
    int     21h             ; DOS - SET INTERRUPT VECTOR
loc_2F3D8:
    pop     ds
    retf
criterr_exithandler endp
preRender_unk proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     si, [bp+arg_8]
    mov     [bp+var_A], 1
    jmp     short loc_2F3FD
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     si, [bp+arg_8]
    mov     [bp+var_A], 0
loc_2F3FD:
    mov     ax, [bp+arg_2]
    mov     word_4031E, ax
    mov     ax, [bp+0Ah]
    mov     word_40320, ax
    mov     ax, [bp+arg_4]
    mov     [bp+arg_2], ax
    mov     ax, [bp+arg_6]
    mov     [bp+arg_4], ax
    mov     ax, offset draw_unknown_lines
    mov     spritefunc, ax
    mov     ax, offset preRender_line
    mov     imagefunc, ax
    jmp     loc_3180A
preRender_unk endp
nopsub_2F424 proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2
    arg_8 = byte ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    lea     si, [bp+arg_8]
    mov     [bp+var_A], 0
    jmp     short loc_2F3FD
nopsub_2F424 endp
nopsub_2F436 proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2
    arg_8 = byte ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    lea     si, [bp+arg_8]
    mov     [bp+var_A], 1
    jmp     short loc_2F3FD
word_2F448     dw 50
off_2F44A     dw offset off_2F4AC
    dw offset off_2F4AC
    dw offset off_2F4AC
    dw offset word_2F4AE
    dw offset word_2F4B2
    dw offset word_2F4B8
    dw offset word_2F4C0
    dw offset word_2F4CA
    dw offset word_2F4D6
    dw offset word_2F4E4
    dw offset word_2F4F4
    dw offset word_2F506
    dw offset word_2F51A
    dw offset word_2F530
    dw offset word_2F548
    dw offset word_2F562
    dw offset word_2F57E
    dw offset word_2F59C
    dw offset word_2F5BC
    dw offset word_2F5DE
    dw offset word_2F602
    dw offset word_2F628
    dw offset word_2F650
    dw offset word_2F67A
    dw offset word_2F6A6
    dw offset word_2F6D4
    dw offset word_2F704
    dw offset word_2F736
    dw offset word_2F76A
    dw offset word_2F7A0
    dw offset word_2F7D8
    dw offset word_2F812
    dw offset word_2F84E
    dw offset word_2F88C
    dw offset word_2F8CC
    dw offset word_2F90E
    dw offset word_2F952
    dw offset word_2F998
    dw offset word_2F9E0
    dw offset word_2FA2A
    dw offset word_2FA76
    dw offset word_2FAC4
    dw offset word_2FB14
    dw offset word_2FB66
    dw offset word_2FBBA
    dw offset word_2FC10
    dw offset word_2FC68
    dw offset word_2FCC2
    dw offset word_2FD1E
off_2F4AC     dw offset word_2FD7C
word_2F4AE     dw 32768
    dw 21845
word_2F4B2     dw 43690
word_2F4B4     dw 16384
    dw 32768
word_2F4B8     dw 49152
    dw 13107
    dw 26214
    dw 39321
word_2F4C0     dw 52428
    dw 10922
    dw 21845
    dw 32768
    dw 43690
word_2F4CA     dw 54613
    dw 9362
    dw 18724
    dw 28086
    dw 37449
    dw 46811
word_2F4D6     dw 56173
    dw 8192
    dw 16384
    dw 24576
    dw 32768
    dw 40960
    dw 49152
word_2F4E4     dw 57344
    dw 7281
    dw 14563
    dw 21845
    dw 29127
    dw 36408
    dw 43690
    dw 50972
word_2F4F4     dw 58254
    dw 6553
    dw 13107
    dw 19660
    dw 26214
    dw 32768
    dw 39321
    dw 45875
    dw 52428
word_2F506     dw 58982
    dw 5957
    dw 11915
    dw 17873
    dw 23831
    dw 29789
    dw 35746
    dw 41704
    dw 47662
    dw 53620
word_2F51A     dw 59578
    dw 5461
    dw 10922
    dw 16384
    dw 21845
    dw 27306
    dw 32768
    dw 38229
    dw 43690
    dw 49152
    dw 54613
word_2F530     dw 60074
    dw 5041
    dw 10082
    dw 15123
    dw 20164
    dw 25206
    dw 30247
    dw 35288
    dw 40329
    dw 45371
    dw 50412
    dw 55453
word_2F548     dw 60494
    dw 4681
    dw 9362
    dw 14043
    dw 18724
    dw 23405
    dw 28086
    dw 32768
    dw 37449
    dw 42130
    dw 46811
    dw 51492
    dw 56173
word_2F562     dw 60854
    dw 4369
    dw 8738
    dw 13107
    dw 17476
    dw 21845
    dw 26214
    dw 30583
    dw 34952
    dw 39321
    dw 43690
    dw 48059
    dw 52428
    dw 56797
word_2F57E     dw 61166
    dw 4096
    dw 8192
    dw 12288
    dw 16384
    dw 20480
    dw 24576
    dw 28672
    dw 32768
    dw 36864
    dw 40960
    dw 45056
    dw 49152
    dw 53248
    dw 57344
word_2F59C     dw 61440
    dw 3855
    dw 7710
    dw 11565
    dw 15420
    dw 19275
    dw 23130
    dw 26985
    dw 30840
    dw 34695
    dw 38550
    dw 42405
    dw 46260
    dw 50115
    dw 53970
    dw 57825
word_2F5BC     dw 61680
    dw 3640
    dw 7281
    dw 10922
    dw 14563
    dw 18204
    dw 21845
    dw 25486
    dw 29127
    dw 32768
    dw 36408
    dw 40049
    dw 43690
    dw 47331
    dw 50972
    dw 54613
    dw 58254
word_2F5DE     dw 61895
    dw 3449
    dw 6898
    dw 10347
    dw 13797
    dw 17246
    dw 20695
    dw 24144
    dw 27594
    dw 31043
    dw 34492
    dw 37941
    dw 41391
    dw 44840
    dw 48289
    dw 51738
    dw 55188
    dw 58637
word_2F602     dw 62086
    dw 3276
    dw 6553
    dw 9830
    dw 13107
    dw 16384
    dw 19660
    dw 22937
    dw 26214
    dw 29491
    dw 32768
    dw 36044
    dw 39321
    dw 42598
    dw 45875
    dw 49152
    dw 52428
    dw 55705
    dw 58982
word_2F628     dw 62259
    dw 3120
    dw 6241
    dw 9362
    dw 12483
    dw 15603
    dw 18724
    dw 21845
    dw 24966
    dw 28086
    dw 31207
    dw 34328
    dw 37449
    dw 40569
    dw 43690
    dw 46811
    dw 49932
    dw 53052
    dw 56173
    dw 59294
word_2F650     dw 62415
    dw 2978
    dw 5957
    dw 8936
    dw 11915
    dw 14894
    dw 17873
    dw 20852
    dw 23831
    dw 26810
    dw 29789
    dw 32768
    dw 35746
    dw 38725
    dw 41704
    dw 44683
    dw 47662
    dw 50641
    dw 53620
    dw 56599
    dw 59578
word_2F67A     dw 62557
    dw 2849
    dw 5698
    dw 8548
    dw 11397
    dw 14246
    dw 17096
    dw 19945
    dw 22795
    dw 25644
    dw 28493
    dw 31343
    dw 34192
    dw 37042
    dw 39891
    dw 42740
    dw 45590
    dw 48439
    dw 51289
    dw 54138
    dw 56987
    dw 59837
word_2F6A6     dw 62686
    dw 2730
    dw 5461
    dw 8192
    dw 10922
    dw 13653
    dw 16384
    dw 19114
    dw 21845
    dw 24576
    dw 27306
    dw 30037
    dw 32768
    dw 35498
    dw 38229
    dw 40960
    dw 43690
    dw 46421
    dw 49152
    dw 51882
    dw 54613
    dw 57344
    dw 60074
word_2F6D4     dw 62805
    dw 2621
    dw 5242
    dw 7864
    dw 10485
    dw 13107
    dw 15728
    dw 18350
    dw 20971
    dw 23592
    dw 26214
    dw 28835
    dw 31457
    dw 34078
    dw 36700
    dw 39321
    dw 41943
    dw 44564
    dw 47185
    dw 49807
    dw 52428
    dw 55050
    dw 57671
    dw 60293
word_2F704     dw 62914
    dw 2520
    dw 5041
    dw 7561
    dw 10082
    dw 12603
    dw 15123
    dw 17644
    dw 20164
    dw 22685
    dw 25206
    dw 27726
    dw 30247
    dw 32768
    dw 35288
    dw 37809
    dw 40329
    dw 42850
    dw 45371
    dw 47891
    dw 50412
    dw 52932
    dw 55453
    dw 57974
    dw 60494
word_2F736     dw 63015
    dw 2427
    dw 4854
    dw 7281
    dw 9709
    dw 12136
    dw 14563
    dw 16990
    dw 19418
    dw 21845
    dw 24272
    dw 26699
    dw 29127
    dw 31554
    dw 33981
    dw 36408
    dw 38836
    dw 41263
    dw 43690
    dw 46117
    dw 48545
    dw 50972
    dw 53399
    dw 55826
    dw 58254
    dw 60681
word_2F76A     dw 63108
    dw 2340
    dw 4681
    dw 7021
    dw 9362
    dw 11702
    dw 14043
    dw 16384
    dw 18724
    dw 21065
    dw 23405
    dw 25746
    dw 28086
    dw 30427
    dw 32768
    dw 35108
    dw 37449
    dw 39789
    dw 42130
word_2F790     dw 44470
    dw 46811
    dw 49152
    dw 51492
    dw 53833
    dw 56173
    dw 58514
    dw 60854
word_2F7A0     dw 63195
    dw 2259
    dw 4519
    dw 6779
    dw 9039
    dw 11299
    dw 13559
    dw 15819
    dw 18078
    dw 20338
    dw 22598
    dw 24858
    dw 27118
    dw 29378
    dw 31638
    dw 33897
    dw 36157
    dw 38417
    dw 40677
    dw 42937
    dw 45197
    dw 47457
    dw 49716
    dw 51976
    dw 54236
    dw 56496
    dw 58756
    dw 61016
word_2F7D8     dw 63276
    dw 2184
    dw 4369
    dw 6553
    dw 8738
    dw 10922
    dw 13107
    dw 15291
    dw 17476
    dw 19660
    dw 21845
    dw 24029
    dw 26214
    dw 28398
    dw 30583
    dw 32768
    dw 34952
    dw 37137
    dw 39321
    dw 41506
    dw 43690
    dw 45875
    dw 48059
    dw 50244
    dw 52428
    dw 54613
    dw 56797
    dw 58982
    dw 61166
word_2F812     dw 63351
    dw 2114
    dw 4228
    dw 6342
    dw 8456
    dw 10570
    dw 12684
    dw 14798
    dw 16912
    dw 19026
    dw 21140
    dw 23254
    dw 25368
    dw 27482
    dw 29596
    dw 31710
    dw 33825
    dw 35939
    dw 38053
    dw 40167
    dw 42281
    dw 44395
    dw 46509
    dw 48623
    dw 50737
    dw 52851
    dw 54965
    dw 57079
    dw 59193
    dw 61307
word_2F84E     dw 63421
    dw 2048
    dw 4096
    dw 6144
    dw 8192
    dw 10240
    dw 12288
    dw 14336
    dw 16384
    dw 18432
    dw 20480
    dw 22528
    dw 24576
    dw 26624
    dw 28672
    dw 30720
    dw 32768
    dw 34816
    dw 36864
    dw 38912
    dw 40960
    dw 43008
    dw 45056
    dw 47104
    dw 49152
    dw 51200
    dw 53248
    dw 55296
    dw 57344
    dw 59392
    dw 61440
word_2F88C     dw 63488
    dw 1985
    dw 3971
    dw 5957
    dw 7943
    dw 9929
    dw 11915
    dw 13901
    dw 15887
    dw 17873
    dw 19859
    dw 21845
    dw 23831
    dw 25817
    dw 27803
    dw 29789
    dw 31775
    dw 33760
    dw 35746
    dw 37732
    dw 39718
    dw 41704
    dw 43690
    dw 45676
    dw 47662
    dw 49648
    dw 51634
    dw 53620
    dw 55606
    dw 57592
    dw 59578
    dw 61564
word_2F8CC     dw 63550
    dw 1927
    dw 3855
    dw 5782
    dw 7710
    dw 9637
    dw 11565
    dw 13492
    dw 15420
    dw 17347
    dw 19275
    dw 21202
    dw 23130
    dw 25057
    dw 26985
    dw 28912
    dw 30840
    dw 32768
    dw 34695
    dw 36623
    dw 38550
    dw 40478
    dw 42405
    dw 44333
    dw 46260
    dw 48188
    dw 50115
    dw 52043
    dw 53970
    dw 55898
    dw 57825
    dw 59753
    dw 61680
word_2F90E     dw 63608
    dw 1872
    dw 3744
    dw 5617
    dw 7489
    dw 9362
    dw 11234
    dw 13107
    dw 14979
    dw 16852
    dw 18724
    dw 20597
    dw 22469
    dw 24341
    dw 26214
    dw 28086
    dw 29959
    dw 31831
    dw 33704
    dw 35576
    dw 37449
    dw 39321
    dw 41194
    dw 43066
    dw 44938
    dw 46811
    dw 48683
    dw 50556
    dw 52428
    dw 54301
    dw 56173
    dw 58046
    dw 59918
    dw 61791
word_2F952     dw 63663
    dw 1820
    dw 3640
    dw 5461
    dw 7281
    dw 9102
    dw 10922
    dw 12743
    dw 14563
    dw 16384
    dw 18204
    dw 20024
    dw 21845
    dw 23665
    dw 25486
    dw 27306
    dw 29127
    dw 30947
    dw 32768
    dw 34588
    dw 36408
    dw 38229
    dw 40049
    dw 41870
    dw 43690
    dw 45511
    dw 47331
    dw 49152
    dw 50972
    dw 52792
    dw 54613
    dw 56433
    dw 58254
    dw 60074
    dw 61895
word_2F998     dw 63715
    dw 1771
    dw 3542
    dw 5313
    dw 7084
    dw 8856
    dw 10627
    dw 12398
    dw 14169
    dw 15941
    dw 17712
    dw 19483
    dw 21254
    dw 23026
    dw 24797
    dw 26568
    dw 28339
    dw 30111
    dw 31882
    dw 33653
    dw 35424
    dw 37196
    dw 38967
    dw 40738
    dw 42509
    dw 44281
    dw 46052
    dw 47823
    dw 49594
    dw 51366
    dw 53137
    dw 54908
    dw 56679
    dw 58451
    dw 60222
    dw 61993
word_2F9E0     dw 63764
    dw 1724
    dw 3449
    dw 5173
    dw 6898
    dw 8623
    dw 10347
    dw 12072
    dw 13797
    dw 15521
    dw 17246
    dw 18970
    dw 20695
    dw 22420
    dw 24144
    dw 25869
    dw 27594
    dw 29318
    dw 31043
    dw 32768
    dw 34492
    dw 36217
    dw 37941
    dw 39666
    dw 41391
    dw 43115
    dw 44840
    dw 46565
    dw 48289
    dw 50014
    dw 51738
    dw 53463
    dw 55188
    dw 56912
    dw 58637
    dw 60362
    dw 62086
word_2FA2A     dw 63811
    dw 1680
    dw 3360
    dw 5041
    dw 6721
    dw 8402
    dw 10082
    dw 11762
    dw 13443
    dw 15123
    dw 16804
    dw 18484
    dw 20164
    dw 21845
    dw 23525
    dw 25206
    dw 26886
    dw 28566
    dw 30247
    dw 31927
    dw 33608
    dw 35288
    dw 36969
    dw 38649
    dw 40329
    dw 42010
    dw 43690
    dw 45371
    dw 47051
    dw 48731
    dw 50412
    dw 52092
    dw 53773
    dw 55453
    dw 57133
    dw 58814
    dw 60494
    dw 62175
word_2FA76     dw 63855
    dw 1638
    dw 3276
    dw 4915
    dw 6553
    dw 8192
    dw 9830
    dw 11468
    dw 13107
    dw 14745
    dw 16384
    dw 18022
    dw 19660
    dw 21299
    dw 22937
    dw 24576
    dw 26214
    dw 27852
    dw 29491
    dw 31129
    dw 32768
    dw 34406
    dw 36044
    dw 37683
    dw 39321
    dw 40960
    dw 42598
    dw 44236
    dw 45875
    dw 47513
    dw 49152
    dw 50790
    dw 52428
    dw 54067
    dw 55705
    dw 57344
    dw 58982
    dw 60620
    dw 62259
word_2FAC4     dw 63897
    dw 1598
    dw 3196
    dw 4795
    dw 6393
    dw 7992
    dw 9590
    dw 11189
    dw 12787
    dw 14385
    dw 15984
    dw 17582
    dw 19181
    dw 20779
    dw 22378
    dw 23976
    dw 25575
    dw 27173
    dw 28771
    dw 30370
    dw 31968
    dw 33567
    dw 35165
    dw 36764
    dw 38362
    dw 39960
    dw 41559
    dw 43157
    dw 44756
    dw 46354
    dw 47953
    dw 49551
    dw 51150
    dw 52748
    dw 54346
    dw 55945
    dw 57543
    dw 59142
    dw 60740
    dw 62339
word_2FB14     dw 63937
    dw 1560
    dw 3120
    dw 4681
    dw 6241
    dw 7801
    dw 9362
    dw 10922
    dw 12483
    dw 14043
    dw 15603
    dw 17164
    dw 18724
    dw 20284
    dw 21845
    dw 23405
    dw 24966
    dw 26526
    dw 28086
    dw 29647
    dw 31207
    dw 32768
    dw 34328
    dw 35888
    dw 37449
    dw 39009
    dw 40569
    dw 42130
    dw 43690
    dw 45251
    dw 46811
    dw 48371
    dw 49932
    dw 51492
    dw 53052
    dw 54613
    dw 56173
    dw 57734
    dw 59294
    dw 60854
    dw 62415
word_2FB66     dw 63975
    dw 1524
    dw 3048
    dw 4572
    dw 6096
    dw 7620
    dw 9144
    dw 10668
    dw 12192
    dw 13716
    dw 15240
    dw 16765
    dw 18289
    dw 19813
    dw 21337
    dw 22861
    dw 24385
    dw 25909
    dw 27433
    dw 28957
    dw 30481
    dw 32005
    dw 33530
    dw 35054
    dw 36578
    dw 38102
    dw 39626
    dw 41150
    dw 42674
    dw 44198
    dw 45722
    dw 47246
    dw 48770
    dw 50295
    dw 51819
    dw 53343
    dw 54867
    dw 56391
    dw 57915
    dw 59439
    dw 60963
    dw 62487
word_2FBBA     dw 64011
    dw 1489
    dw 2978
    dw 4468
    dw 5957
    dw 7447
    dw 8936
    dw 10426
    dw 11915
    dw 13405
    dw 14894
    dw 16384
    dw 17873
    dw 19362
    dw 20852
    dw 22341
    dw 23831
    dw 25320
    dw 26810
    dw 28299
    dw 29789
    dw 31278
    dw 32768
    dw 34257
    dw 35746
    dw 37236
    dw 38725
    dw 40215
    dw 41704
    dw 43194
    dw 44683
    dw 46173
    dw 47662
    dw 49152
    dw 50641
    dw 52130
    dw 53620
    dw 55109
    dw 56599
    dw 58088
    dw 59578
    dw 61067
    dw 62557
word_2FC10     dw 64046
    dw 1456
    dw 2912
    dw 4369
    dw 5825
    dw 7281
    dw 8738
    dw 10194
    dw 11650
    dw 13107
    dw 14563
    dw 16019
    dw 17476
    dw 18932
    dw 20388
    dw 21845
    dw 23301
    dw 24758
    dw 26214
    dw 27670
    dw 29127
    dw 30583
    dw 32039
    dw 33496
    dw 34952
    dw 36408
    dw 37865
    dw 39321
    dw 40777
    dw 42234
    dw 43690
    dw 45147
    dw 46603
    dw 48059
    dw 49516
    dw 50972
    dw 52428
    dw 53885
    dw 55341
    dw 56797
    dw 58254
    dw 59710
    dw 61166
    dw 62623
word_2FC68     dw 64079
    dw 1424
    dw 2849
    dw 4274
    dw 5698
    dw 7123
    dw 8548
    dw 9972
    dw 11397
    dw 12822
    dw 14246
    dw 15671
    dw 17096
    dw 18521
    dw 19945
    dw 21370
    dw 22795
    dw 24219
    dw 25644
    dw 27069
    dw 28493
    dw 29918
    dw 31343
    dw 32768
    dw 34192
    dw 35617
    dw 37042
    dw 38466
    dw 39891
    dw 41316
    dw 42740
    dw 44165
    dw 45590
    dw 47014
    dw 48439
    dw 49864
    dw 51289
    dw 52713
    dw 54138
    dw 55563
    dw 56987
    dw 58412
    dw 59837
    dw 61261
    dw 62686
word_2FCC2     dw 64111
    dw 1394
    dw 2788
    dw 4183
    dw 5577
    dw 6971
    dw 8366
    dw 9760
    dw 11155
    dw 12549
    dw 13943
    dw 15338
    dw 16732
    dw 18126
    dw 19521
    dw 20915
    dw 22310
    dw 23704
    dw 25098
    dw 26493
    dw 27887
    dw 29282
    dw 30676
    dw 32070
    dw 33465
    dw 34859
    dw 36253
    dw 37648
    dw 39042
    dw 40437
    dw 41831
    dw 43225
    dw 44620
    dw 46014
    dw 47409
    dw 48803
    dw 50197
    dw 51592
    dw 52986
    dw 54380
    dw 55775
    dw 57169
    dw 58564
    dw 59958
    dw 61352
    dw 62747
word_2FD1E     dw 64141
    dw 1365
    dw 2730
    dw 4096
    dw 5461
    dw 6826
    dw 8192
    dw 9557
    dw 10922
    dw 12288
    dw 13653
    dw 15018
    dw 16384
    dw 17749
    dw 19114
    dw 20480
    dw 21845
    dw 23210
    dw 24576
    dw 25941
    dw 27306
    dw 28672
    dw 30037
    dw 31402
    dw 32768
    dw 34133
    dw 35498
    dw 36864
    dw 38229
    dw 39594
    dw 40960
    dw 42325
    dw 43690
    dw 45056
    dw 46421
    dw 47786
    dw 49152
    dw 50517
    dw 51882
    dw 53248
    dw 54613
    dw 55978
    dw 57344
    dw 58709
    dw 60074
    dw 61440
    dw 62805
word_2FD7C     dw 64170
    dw 1337
    dw 2674
    dw 4012
    dw 5349
    dw 6687
    dw 8024
    dw 9362
    dw 10699
    dw 12037
    dw 13374
    dw 14712
    dw 16049
    dw 17387
    dw 18724
    dw 20062
    dw 21399
    dw 22736
    dw 24074
    dw 25411
    dw 26749
    dw 28086
    dw 29424
    dw 30761
    dw 32099
    dw 33436
    dw 34774
    dw 36111
    dw 37449
    dw 38786
    dw 40124
    dw 41461
    dw 42799
    dw 44136
    dw 45473
    dw 46811
    dw 48148
    dw 49486
    dw 50823
    dw 52161
    dw 53498
    dw 54836
    dw 56173
    dw 57511
    dw 58848
    dw 60186
    dw 61523
    dw 62861
    dw 64198
nopsub_2F436 endp
preRender_line proc far
    var_1C = byte ptr -28
     s = byte ptr 0
     r = byte ptr 2
    arg_startX = word ptr 6
    arg_startY = word ptr 8
    arg_endX = word ptr 10
    arg_endY = word ptr 12
    arg_color = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 1Ch
    mov     ax, [bp+arg_color]
    lea     bx, [bp+var_1C] ; var_1C is some kind of struct sizeof 0x1C
    mov     [bx+10h], ax
    push    bx
    push    [bp+arg_endY]
    push    [bp+arg_endX]
    push    [bp+arg_startY]
    push    [bp+arg_startX]
    call    draw_line_related
    add     sp, 0Ah
    or      ax, ax
    jnz     short loc_2FE18
    lea     bx, [bp+var_1C]
    cmp     word ptr [bx+0Eh], 0
    jle     short loc_2FE18
    push    bx
    call    putpixel_line1_maybe
    add     sp, 2
loc_2FE18:
    mov     sp, bp
    pop     bp
    retf
preRender_line endp
add_exit_handler proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     cx, 0Ah
    mov     bx, offset exitlistfuncs
    mov     dx, [bp+arg_2]
loc_2FE2B:
    cmp     [bx], ax
    jnz     short loc_2FE34
    cmp     [bx+2], dx
    jz      short loc_2FE57
loc_2FE34:
    cmp     word ptr [bx+2], 0
    jz      short loc_2FE48
    add     bx, 4
    loop    loc_2FE2B
    mov     ax, offset aExitListOverflow; "EXIT LIST OVERFLOW\r\n"
    push    ax
    call    far ptr fatal_error
loc_2FE48:
    mov     word ptr [bx+2], 0
    mov     [bx], ax
    mov     word ptr [bx+6], 0
    mov     [bx+2], dx
loc_2FE57:
    pop     bp
    retf
add_exit_handler endp
call_exitlist proc far
     r = byte ptr 0

    push    di
    mov     di, 28h ; '('
loc_2FE5D:
    mov     ax, (exitlistfuncs+2)[di]
    or      ax, ax
    jz      short loc_2FE6B
    push    di
    call    dword ptr exitlistfuncs[di]
    pop     di
loc_2FE6B:
    sub     di, 4
    jl      short loc_2FE72
    jmp     short loc_2FE5D
loc_2FE72:
    pop     di
    retf
call_exitlist endp
call_exitlist2 proc near

    call    call_exitlist
    xor     ax, ax
    push    ax
    call    far ptr libsub_quit_to_dos_alt
    ; align 2
    db 0
call_exitlist2 endp
file_paras proc far
    var_fatal = word ptr -6
    var_length = word ptr -4
    var_filehandle = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_fatal = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    ds
    push    si
    push    di
    mov     ax, [bp+arg_fatal]
    mov     [bp+var_fatal], ax
    jmp     short _file_paras
    ; align 2
    db 144
file_paras endp
file_paras_nofatal proc far
    var_6 = word ptr -6
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    ds
    push    si
    push    di
    mov     [bp+var_6], 0
    jmp     short _file_paras
    db 144
file_paras_nofatal endp
file_paras_fatal proc near
    var_fatal = word ptr -6
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    ds
    push    si
    push    di
    mov     [bp+var_fatal], 1
    var_fatal = word ptr -6
    var_length = word ptr -4
    var_filehandle = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_fatal = word ptr 8
_file_paras:
    mov     dx, [bp+arg_filename]
    mov     ah, 3Dh ; '='
    xor     al, al
    int     21h             ; DOS - 2+ - OPEN DISK FILE WITH HANDLE
    jnb     short loc_2FEDD
    cmp     [bp+var_fatal], 0
    jnz     short loc_2FECD
    xor     ax, ax
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_2FECD:
    mov     ax, offset aSFileError_1; "%s FILE ERROR"
    mov     bx, ss
    mov     ds, bx
    push    [bp+arg_filename]
    push    ax
    call    far ptr fatal_error
loc_2FEDD:
    mov     [bp+var_filehandle], ax
    mov     bx, ax
    sub     cx, cx
    sub     dx, dx
    mov     ax, 4202h
    int     21h             ; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
    push    dx
    push    ax
    sub     dx, dx
    mov     ax, 4200h
    int     21h             ; DOS - 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
    pop     ax
    pop     dx
    xor     bx, bx
    test    ax, 0Fh
    jz      short loc_2FF00
    mov     bx, 1
loc_2FF00:
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    add     ax, bx
    mov     [bp+var_length], ax
    mov     bx, [bp+var_filehandle]
    mov     ah, 3Eh
    int     21h             ; DOS - 2+ - CLOSE A FILE WITH HANDLE
    mov     ax, [bp+var_length]
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
file_paras_fatal endp
file_decomp_paras proc far
    var_fatal = word ptr -8
    var_6 = byte ptr -6
    var_5 = word ptr -5
    var_filehandle = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_fatal = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    ds
    push    si
    push    di
    mov     ax, [bp+arg_fatal]
    mov     [bp+var_fatal], ax
    jmp     short _file_decomp_paras
    ; align 2
    db 144
file_decomp_paras endp
file_decomp_paras_nofatal proc far
    var_fatal = word ptr -8
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    ds
    push    si
    push    di
    mov     [bp+var_fatal], 0
    jmp     short _file_decomp_paras
    db 144
file_decomp_paras_nofatal endp
file_decomp_paras_fatal proc near
    var_fatal = word ptr -8
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    ds
    push    si
    push    di
    mov     [bp+var_fatal], 1
    var_fatal = word ptr -8
    var_6 = byte ptr -6
    var_5 = word ptr -5
    var_filehandle = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_fatal = word ptr 8
_file_decomp_paras:
    mov     dx, [bp+arg_filename]
    mov     dx, [bp+arg_filename]
    mov     ah, 3Dh ; '='
    xor     al, al
    int     21h             ; DOS - 2+ - OPEN DISK FILE WITH HANDLE
    jnb     short loc_2FF68
    jmp     short loc_2FFB5
    ; align 2
    db 144
    var_fatal = word ptr -8
    var_6 = byte ptr -6
    var_5 = word ptr -5
    var_filehandle = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_fatal = word ptr 8
loc_2FF68:
    mov     [bp+var_filehandle], ax
    mov     bx, [bp+var_filehandle]
    lea     dx, [bp+var_6]
    mov     cx, 4
    mov     ah, 3Fh
    int     21h             ; DOS - 2+ - READ FROM FILE WITH HANDLE
    cmp     ax, cx
    jnz     short loc_2FFAE
    mov     bx, [bp+var_filehandle]
    mov     ah, 3Eh
    int     21h             ; DOS - 2+ - CLOSE A FILE WITH HANDLE
    mov     ax, [bp+var_5]
    mov     dx, [bp-3]
    xor     dh, dh
    xor     bx, bx
    test    ax, 0Fh
    jz      short loc_2FF95
    mov     bx, 1
loc_2FF95:
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    add     ax, bx
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_2FFAE:
    mov     bx, [bp+var_filehandle]
    mov     ah, 3Eh
    int     21h             ; DOS - 2+ - CLOSE A FILE WITH HANDLE
loc_2FFB5:
    cmp     [bp+var_fatal], 0
    jnz     short loc_2FFC4
    xor     ax, ax
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_2FFC4:
    mov     ax, offset aSFileError_1; "%s FILE ERROR"
    mov     bx, ss
    mov     ds, bx
    push    [bp+arg_filename]
    push    ax
loc_2FFCF:
    call    far ptr fatal_error
file_decomp_paras_fatal endp
file_find proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    mov     dx, offset dtatransbuffer
    mov     ah, 1Ah
    int     21h             ; DOS - SET DISK TRANSFER AREA ADDRESS
    mov     dx, [bp+arg_0]
    mov     cl, 6
    mov     ah, 4Eh
    int     21h             ; DOS - 2+ - FIND FIRST ASCIZ (FINDFIRST)
    jb      short _file_find_err
    mov     di, offset foundfile
    mov     foundfileptr, di
    mov     si, [bp+arg_0]
    mov     cx, 57h ; 'W'
    mov     ax, ds
    mov     es, ax
loc_2FFFD:
    lodsb
    stosb
    cmp     al, 0
    jz      short _file_find_ok
    cmp     al, 3Ah ; ':'
    jz      short loc_3000B
    cmp     al, 5Ch ; '\'
    jnz     short loc_3000F
loc_3000B:
    mov     foundfileptr, di
loc_3000F:
    loop    loc_2FFFD
_file_find_ok:
    mov     ax, ds
    mov     es, ax
    mov     si, offset foundfilepath
    mov     di, foundfileptr
    mov     cx, 0Dh
    cld
    rep movsb
    mov     ax, offset foundfile
loc_30025:
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
_file_find_err:
    xor     ax, ax
    jmp     short loc_30025
file_find endp
file_find_next proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    mov     dx, offset dtatransbuffer
    mov     ah, 1Ah
    int     21h             ; DOS - SET DISK TRANSFER AREA ADDRESS
    mov     ah, 4Fh
    int     21h             ; DOS - 2+ - FIND NEXT ASCIZ (FINDNEXT)
    jb      short _file_find_err
    jmp     short _file_find_ok
    ; align 2
    db 0
file_find_next endp
multiply_and_scale proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    imul    [bp+arg_2]
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    adc     dx, 0
    mov     ax, dx
    pop     bp
    retf
multiply_and_scale endp
video_set_mode4 proc far
     r = byte ptr 0

    push    di
    mov     byte_3F85A, 1
    mov     ax, 40h ; '@'
    mov     es, ax
    mov     ax, es:10h
smart
    and     ax, 0FFCFh
nosmart
    or      ax, 20h
    mov     es:10h, ax
    mov     ah, 0
    mov     al, 4
    int     10h             ; - VIDEO - SET VIDEO MODE
    mov     al, 3
    mov     dx, 3BFh
    out     dx, al          ; Printer Status Bits:
    mov     al, 2
    mov     dx, 3B8h
    out     dx, al
    mov     cx, 0Ch
    mov     dx, 3B4h
    xor     bx, bx
loc_30091:
    mov     al, bl
    out     dx, al          ; Video: CRT cntrlr addr
    inc     dx
    mov     al, byte_3F85C[bx]
    out     dx, al          ; Video: CRT controller internal registers
    dec     dx
    inc     bx
    loop    loc_30091
    cld
    mov     ax, 0B800h
    mov     es, ax
    xor     di, di
    mov     cx, 4000h
    xor     ax, ax
    rep stosw
    mov     al, 8Ah ; 'ä'
    mov     dx, 3B8h
    out     dx, al
    pop     di
    retf
    ; align 2
    db 0
video_set_mode4 endp
polarRadius2D proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_z = word ptr 6
    arg_y = word ptr 8

    push    bp
    mov     bp, sp
    push    [bp+arg_y]
    push    [bp+arg_z]
    call    polarAngle
    add     sp, 4
    or      ax, ax
    jge     short loc_300CD
    neg     ax
loc_300CD:
    cmp     ax, 100h
    jl      short loc_300D7
    sub     ax, 200h
    neg     ax
loc_300D7:
    cmp     ax, 80h ; 'Ä'
    jg      short loc_300FE
    push    ax
    call    cos_fast
    add     sp, 2
    mov     bx, ax
    mov     dx, [bp+arg_y]
    or      dx, dx
    jge     short loc_300F0
    neg     dx
loc_300F0:
    xor     ax, ax
    sar     dx, 1
    rcr     ax, 1
    sar     dx, 1
    rcr     ax, 1
    div     bx
    pop     bp
    retf
loc_300FE:
    push    ax
    call    sin_fast
    add     sp, 2
    mov     bx, ax
    mov     dx, [bp+arg_z]
    or      dx, dx
    jge     short loc_30112
    neg     dx
loc_30112:
    xor     ax, ax
    sar     dx, 1
    rcr     ax, 1
    sar     dx, 1
    rcr     ax, 1
    div     bx
    pop     bp
    retf
polarRadius2D endp
video_set_mode7 proc far
     r = byte ptr 0

    push    di
    cmp     byte_3F85A, 0
    jnz     short loc_3012F
    call    set_bios_mode3
    pop     di
    retf
loc_3012F:
    mov     ax, 40h ; '@'
    mov     es, ax
    mov     ax, es:10h
smart
    and     ax, 0FFCFh
nosmart
    or      ax, 30h
    mov     es:10h, ax
    mov     al, 3
    mov     dx, 3BFh
    out     dx, al          ; Printer Status Bits:
    mov     al, 20h ; ' '
    mov     dx, 3B8h
    out     dx, al
    mov     cx, 0Ch
    mov     dx, 3B4h
    xor     bx, bx
loc_30156:
    mov     al, bl
    out     dx, al          ; Video: CRT cntrlr addr
    inc     dx
    mov     al, byte_3F868[bx]
    out     dx, al          ; Video: CRT controller internal registers
    dec     dx
    inc     bx
    loop    loc_30156
    cld
    mov     ax, 0B800h
    mov     es, ax
    xor     di, di
    mov     cx, 4000h
    xor     ax, ax
    rep stosw
    mov     al, 28h ; '('
    mov     dx, 3B8h
    out     dx, al
    mov     ah, 0
    mov     al, 7
    int     10h             ; - VIDEO - SET VIDEO MODE
    pop     di
    retf
video_set_mode7 endp
nopsub_30180 proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    mov     dx, 2E9Ch
    mov     word_3F884, 5
    mov     word_3F886, 5
    mov     word_3F882, 64h ; 'd'
    mov     byte_3F880, 1
    jmp     short loc_301FD
    ; align 2
    db 144
nopsub_30180 endp
timer_setup_interrupt proc far
     r = byte ptr 0

    push    bp
    mov     dx, 2E9Ch       ; 11977. afaict this is used as freq-parameter, which gives
    mov     word_3F884, 5
    mov     word_3F886, 5
    mov     byte_3F880, 0
    mov     byte_3F881, 1
    jmp     short loc_301FD
    db 144
    push    bp
    mov     bp, sp
    mov     dx, 1
    xor     ax, ax
    idiv    word ptr [bp+6]
    mov     word_3F884, ax
    mov     word_3F886, ax
    mov     dx, [bp+6]
    mov     byte_3F880, 0
    mov     byte_3F881, 1
    jmp     short loc_301FD
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    mov     dx, 1
    xor     ax, ax
    idiv    word ptr [bp+6]
    mov     word_3F884, ax
    mov     word_3F886, ax
    mov     dx, [bp+6]
    mov     word_3F882, 64h ; 'd'
    mov     byte_3F880, 1
loc_301FD:
    cli
    mov     byte_3F88C, 0
    mov     word ptr timerintr, 0
    mov     word ptr timerintr+2, 0
    sti
    in      al, 61h         ; PC/XT PPI port B bits:
smart
    and     al, 0FCh
nosmart
    out     61h, al         ; PC/XT PPI port B bits:
    mov     al, 0B6h ; '∂'
    out     43h, al         ; Timer 8253-5 (AT: 8254.2).
    in      al, 21h         ; Interrupt controller, 8259A.
    or      al, 3
    out     21h, al         ; Interrupt controller, 8259A.
    xor     ax, ax
    mov     es, ax
    cli
    mov     ax, es:20h
    cmp     ax, 1909h
    jz      short loc_30231
    mov     word ptr dword_3F874, ax
loc_30231:
    mov     ax, es:22h
    mov     bx, cs
    cmp     ax, bx
    jz      short loc_3024A
    mov     word ptr dword_3F874+2, ax
    mov     word ptr es:20h, offset timer_intr_callback
    mov     word ptr es:22h, cs
loc_3024A:
    in      al, 21h         ; Interrupt controller, 8259A.
smart
    and     al, 0FCh
nosmart
    out     21h, al         ; Interrupt controller, 8259A.
    sti
    mov     al, dl
    out     40h, al         ; Timer 8253-5 (AT: 8254.2).
    mov     al, dh
    out     40h, al         ; Timer 8253-5 (AT: 8254.2).
    push    cs
    mov     ax, offset audio_stop_unk
    push    ax
    call    add_exit_handler
    add     sp, 4
    pop     bp
    retf
timer_setup_interrupt endp
audio_stop_unk proc far

    xor     ax, ax
    mov     es, ax
    mov     ax, es:22h
    mov     dx, cs
    cmp     ax, dx
    jz      short loc_30277
    retf
loc_30277:
    mov     ax, es:20h
    cmp     ax, 1909h
    jz      short loc_30281
    retf
loc_30281:
    in      al, 21h         ; Interrupt controller, 8259A.
    or      al, 3
    out     21h, al         ; Interrupt controller, 8259A.
    cli
    mov     ax, word ptr dword_3F874
    mov     es:20h, ax
    mov     ax, word ptr dword_3F874+2
    mov     es:22h, ax
    in      al, 21h         ; Interrupt controller, 8259A.
smart
    and     al, 0FCh
nosmart
    out     21h, al         ; Interrupt controller, 8259A.
    sti
    mov     al, 0
    out     40h, al         ; Timer 8253-5 (AT: 8254.2).
    out     40h, al         ; Timer 8253-5 (AT: 8254.2).
    in      al, 61h         ; PC/XT PPI port B bits:
smart
    and     al, 0FCh
nosmart
    out     61h, al         ; PC/XT PPI port B bits:
    retf
audio_stop_unk endp
timer_reg_callback proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     cx, 5
    mov     bx, offset timerintr
loc_302B3:
    cmp     word ptr [bx+2], 0
    jz      short loc_302C7
    add     bx, 4
    loop    loc_302B3
    mov     ax, offset aNoRoomLeftOnTimerInterru; "NO ROOM LEFT ON TIMER INTERRUPT ROUTINE"...
    push    ax
    call    far ptr fatal_error
loc_302C7:
    mov     ax, [bp+arg_0]
    mov     [bx], ax
    mov     word ptr [bx+2], 0
    mov     ax, [bp+arg_2]
    mov     [bx+2], ax
    mov     word ptr [bx+6], 0
    pop     bp
    retf
timer_reg_callback endp
timer_remove_callback proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     cx, 5
    mov     bx, offset timerintr
    mov     ax, [bp+arg_0]
    mov     dx, [bp+arg_2]
loc_302ED:
    cmp     [bx], ax
    jnz     short loc_302F6
    cmp     [bx+2], dx
    jz      short loc_302FD
loc_302F6:
    add     bx, 4
    loop    loc_302ED
    pop     bp
    retf
loc_302FD:
    cli
    dec     cx
    jz      short loc_30311
loc_30301:
    mov     ax, [bx+4]
    mov     [bx], ax
    mov     ax, [bx+6]
    mov     [bx+2], ax
    add     bx, 4
    loop    loc_30301
loc_30311:
    mov     word ptr [bx], 0
    mov     word ptr [bx+2], 0
    sti
    pop     bp
    retf
timer_remove_callback endp
compare_ds_ss proc far

    xor     ax, ax
    mov     bx, ss
    mov     dx, ds
    cmp     bx, dx
    jnz     short locret_30328
    inc     ax
locret_30328:
    retf
compare_ds_ss endp
timer_intr_callback proc far
     r = byte ptr 0

    cli
    push    ds
    push    es
    push    ax
    push    bx
    push    cx
    push    dx
    push    si
    push    di
    push    bp
    mov     ax, seg dseg
    mov     ds, ax
    sti
    dec     word_3F886
    jg      short loc_3035C
    inc     word_3F87C
    jnz     short loc_30349
    inc     word_3F87E
loc_30349:
    mov     ax, word_3F884
    mov     word_3F886, ax
    cmp     byte_3F881, 0
    jz      short loc_3035C
    call near ptr sub_303BA
    jmp     short loc_30360
    ; align 2
    db 144
loc_3035C:
    mov     al, 20h ; ' '
    out     20h, al         ; Interrupt controller, 8259A.
loc_30360:
    cmp     byte ptr word_3F88E, 0
    jnz     short loc_303A5
    inc     word ptr timer_callback_counter
    jnz     short loc_30371
    inc     word ptr timer_callback_counter+2
loc_30371:
    xor     di, di
    cli
    cmp     byte_3F88C, 0
    jnz     short loc_30392
    mov     byte_3F88C, 1
    sti
loc_30381:
    mov     ax, word ptr (timerintr+2)[di]
    or      ax, ax
    jz      short loc_303A5
    call    timerintr[di]
    add     di, 4
    jmp     short loc_30381
loc_30392:
    inc     word_3F88A
    mov     ax, word_3F88A
    cmp     word_3F888, ax
    jge     short loc_303B0
    mov     word_3F888, ax
    jmp     short loc_303B0
    db 144
loc_303A5:
    mov     byte_3F88C, 0
    mov     word_3F88A, 0
loc_303B0:
    pop     bp
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    pop     es
    pop     ds
    iret
timer_intr_callback endp
sub_303BA proc near

    cmp     byte_3F880, 0
    jz      short loc_303D1
    dec     word_3F882
    jg      short loc_303D1
    mov     byte_3F880, 0
    mov     byte_3F881, 0
loc_303D1:
    pushf
    call    dword_3F874
    retn
    ; align 2
    db 0
sub_303BA endp
set_bios_mode3 proc far

    xor     ax, ax
    push    ax
    call    video_clear_color
    add     sp, 2
    mov     ax, 40h ; '@'
    mov     es, ax
    mov     ax, es:10h
smart
    and     ax, 0FFCFh
nosmart
    or      ax, 10h
    mov     es:10h, ax
    mov     ah, 0
    mov     al, 3
    int     10h             ; - VIDEO - SET VIDEO MODE
    mov     ah, 0Bh
    mov     bx, 0
    int     10h             ; - VIDEO - SET COLOR PALETTE
    retf
set_bios_mode3 endp
kb_parse_key proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    cli
    cmp     in_kb_parse_key, 0
    jz      short loc_30412
    sti
    pop     bp
    retf
loc_30412:
    mov     in_kb_parse_key, 1
    sti
    mov     bx, [bp+arg_0]
    or      bl, bl
    jz      short loc_30441
smart
    and     bx, 7Fh
nosmart
    mov     [bp+arg_0], bx
    mov     bl, callbackflags[bx]
loc_30429:
    dec     bx
    jl      short loc_30454
    shl     bx, 1
    push    di
    push    si
    shl     bx, 1
    call    dword ptr callbacks[bx]
    pop     si
    pop     di
    xor     ax, ax
    mov     in_kb_parse_key, 0
    pop     bp
    retf
loc_30441:
    mov     bl, bh
    xor     bh, bh
    cmp     bx, 84h ; 'Ñ'
    jl      short loc_3044E
    mov     bx, 84h ; 'Ñ'
loc_3044E:
    mov     bl, callbackflags2[bx]
    jmp     short loc_30429
loc_30454:
    mov     ax, [bp+arg_0]
    mov     in_kb_parse_key, 0
    pop     bp
    retf
kb_parse_key endp
kb_reg_callback proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_2]
    mov     cx, 40h ; '@'
    mov     bx, offset callbacks
    mov     dx, [bp+arg_4]
loc_3046D:
    cmp     [bx], ax
    jnz     short loc_30476
    cmp     [bx+2], dx
    jz      short loc_30488
loc_30476:
    cmp     word ptr [bx+2], 0
    jz      short loc_30483
    add     bx, 4
    loop    loc_3046D
    pop     bp
    retf
loc_30483:
    mov     [bx], ax
    mov     [bx+2], dx
loc_30488:
    mov     ax, 41h ; 'A'
    sub     ax, cx
loc_3048D:
    mov     bx, [bp+arg_0]
    or      bl, bl
    jz      short loc_3049F
    cmp     bx, 7Fh ; ''
    jg      short loc_3049D
    mov     callbackflags[bx], al
loc_3049D:
    pop     bp
    retf
loc_3049F:
    mov     bl, bh
    xor     bh, bh
    cmp     bx, 84h ; 'Ñ'
    jg      short loc_3049D
    mov     callbackflags2[bx], al
    pop     bp
    retf
kb_reg_callback endp
nopsub_304AF proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    xor     ax, ax
    jmp     short loc_3048D
nopsub_304AF endp
nopsub_304B6 proc far

    mov     ah, 1
    int     16h             ; KEYBOARD - CHECK BUFFER, DO NOT CLEAR
    jz      short loc_304DB
    mov     ah, 0
    int     16h             ; KEYBOARD - READ CHAR FROM BUFFER, WAIT IF EMPTY
    or      al, al
    jz      short locret_304C6
    xor     ah, ah
locret_304C6:
    retf
    mov     ah, 1
    int     16h             ; KEYBOARD - CHECK BUFFER, DO NOT CLEAR
    jz      short loc_304DB
    mov     ah, 0
    int     16h             ; KEYBOARD - READ CHAR FROM BUFFER, WAIT IF EMPTY
    push    ax
    call    kb_parse_key
    add     sp, 2
    retf
loc_304DB:
    call    get_joy_flags
    mov     bx, ax
    test    ax, 30h
    jz      short loc_304ED
    mov     ax, 0Dh
    jmp     short loc_304F6
    db 144
loc_304ED:
smart
    and     bx, 0Fh
nosmart
    shl     bx, 1
    mov     ax, [bx+4372h]
loc_304F6:
    cmp     ax, word_3FB02
    jnz     short loc_304FF
loc_304FC:
    xor     ax, ax
    retf
loc_304FF:
    cmp     ax, word_3FB04
    jnz     short loc_3050F
    dec     byte_3FB06
    jg      short loc_304FC
    mov     word_3FB02, ax
    retf
loc_3050F:
    mov     byte_3FB06, 3
    mov     word_3FB04, ax
    jmp     short loc_304FC
nopsub_304B6 endp
kb_get_char proc far

    mov     ah, 1
    int     16h             ; KEYBOARD - CHECK BUFFER, DO NOT CLEAR
    jnz     short loc_30522
    xor     ax, ax
    retf
loc_30522:
    mov     bx, ss
    mov     cx, ds
    cmp     bx, cx
    jnz     short locret_30537
    mov     ah, 0
    int     16h             ; KEYBOARD - READ CHAR FROM BUFFER, WAIT IF EMPTY
    push    ax
    call    kb_parse_key
    add     sp, 2
locret_30537:
    retf
kb_get_char endp
get_kb_or_joy_flags proc far

    xor     ax, ax
    xor     bx, bx
    mov     bl, kbscancodes
    cmp     kbinput[bx], 0
    jz      short loc_30549
    or      al, 10h
loc_30549:
    mov     bl, kbscancodes+1
    cmp     kbinput[bx], 0
    jz      short loc_30556
    or      al, 20h
loc_30556:
    mov     bl, kbscancodes+2
    cmp     kbinput[bx], 0
    jz      short loc_30563
    or      al, 9
loc_30563:
    mov     bl, kbscancodes+3
    cmp     kbinput[bx], 0
    jz      short loc_30570
    or      al, 1
loc_30570:
    mov     bl, kbscancodes+4
    cmp     kbinput[bx], 0
    jz      short loc_3057D
    or      al, 5
loc_3057D:
    mov     bl, kbscancodes+5
    cmp     kbinput[bx], 0
    jz      short loc_3058A
    or      al, 4
loc_3058A:
    mov     bl, kbscancodes+6
    cmp     kbinput[bx], 0
    jz      short loc_30597
    or      al, 6
loc_30597:
    mov     bl, kbscancodes+7
    cmp     kbinput[bx], 0
    jz      short loc_305A4
    or      al, 2
loc_305A4:
    mov     bl, kbscancodes+8
    cmp     kbinput[bx], 0
    jz      short loc_305B1
    or      al, 0Ah
loc_305B1:
    mov     bl, kbscancodes+9
    cmp     kbinput[bx], 0
    jz      short loc_305BE
    or      al, 8
loc_305BE:
    or      ax, ax
    jnz     short locret_305C7
    call    get_joy_flags
locret_305C7:
    retf
get_kb_or_joy_flags endp
nopsub_305C8 proc far

    xor     cx, cx
    xor     bx, bx
    mov     bl, kbscancodes
    cmp     byte ptr [bx+446Ah], 0
    jz      short loc_305DA
    or      cl, 10h
loc_305DA:
    mov     bl, kbscancodes+1
    cmp     byte ptr [bx+446Ah], 0
    jz      short loc_305E8
    or      cl, 20h
loc_305E8:
    xor     ax, ax
    mov     dx, 201h
    test    byte_3FE00, 1
    jz      short loc_305F9
    in      al, dx          ; Game I/O port
    not     al
smart
    and     al, 30h
nosmart
loc_305F9:
    or      ax, cx
    retf
nopsub_305C8 endp
get_joy_flags proc far

    test    byte_3FE00, 1
    jnz     short loc_30606
    xor     ax, ax
    retf
loc_30606:
    mov     joyinput, 0
    mov     dx, 201h
    in      al, dx          ; Game I/O port
    mov     joybutton, al
    mov     bl, 3
    mov     joyflag1, 50h ; 'P'
    mov     joyflag2, 50h ; 'P'
    cli
    out     dx, al          ; Game I/O port
    mov     cx, 14h
loc_30625:
    loop    loc_30625
    mov     cx, 0
loc_3062A:
    in      al, dx          ; Game I/O port
    and     al, bl
    xor     al, bl
    jnz     short loc_3063B
    inc     cx
    cmp     cx, 0FA0h
    jl      short loc_3062A
    jmp     short loc_30658
    db 144
loc_3063B:
    test    al, 1
    jnz     short loc_3064F
loc_3063F:
    test    al, 2
    jz      short loc_3062A
    mov     joyflag2, cx
smart
    and     bl, 1
nosmart
    jnz     short loc_3062A
    jmp     short loc_30658
    db 144
loc_3064F:
    mov     joyflag1, cx
smart
    and     bl, 2
nosmart
    jnz     short loc_3063F
loc_30658:
    sti
    mov     ax, joyflag1
    cmp     ax, word_3FB18
    jge     short loc_306B1
    dec     word_3FB20
    jle     short loc_30674
    cmp     ax, word_3FB1A
    jl      short loc_306E5
    mov     word_3FB1A, ax
    jmp     short loc_306E5
    ; align 2
    db 144
loc_30674:
    mov     bx, word_3FB1A
    mov     word_3FB18, bx
    mov     bx, word_3FB1C
loc_30680:
    sub     bx, word_3FB18
    jle     short loc_30690
    xor     dx, dx
    mov     ax, 4000h
    div     bx
    mov     word_3FB34, ax
loc_30690:
    mov     ax, bx
    mov     dx, 201h
    shr     ax, 1
    mov     bx, ax
    shr     bx, 1
    add     ax, word_3FB18
    add     ax, bx
    mov     word_3FB24, ax
    sub     ax, bx
    sub     ax, bx
    mov     word_3FB22, ax
    mov     ax, joyflag1
    jmp     short loc_306D3
    db 144
loc_306B1:
    cmp     ax, word_3FB1C
    jle     short loc_306D3
    dec     word_3FB20
    jle     short loc_306C9
    cmp     ax, word_3FB1E
    jge     short loc_306E5
    mov     word_3FB1E, ax
    jmp     short loc_306E5
    db 144
loc_306C9:
    mov     bx, word_3FB1E
    mov     word_3FB1C, bx
    jmp     short loc_30680
loc_306D3:
    mov     word_3FB20, 14h
    mov     word_3FB1E, 4E20h
    mov     word_3FB1A, 0
loc_306E5:
    cmp     ax, word_3FB22
    jl      short loc_3074E
    cmp     ax, word_3FB24
    jl      short loc_306F6
    or      joyinput, 4
loc_306F6:
    mov     ax, joyflag2
    cmp     ax, word_3FB26
    jnb     short loc_30755
    dec     word_3FB2E
    jle     short loc_30711
    cmp     ax, word_3FB28
    jl      short loc_30789
    mov     word_3FB28, ax
    jmp     short loc_30789
    db 144
loc_30711:
    mov     bx, word_3FB28
    mov     word_3FB26, bx
    mov     bx, word_3FB2A
loc_3071D:
    sub     bx, word_3FB26
    jle     short loc_3072D
    xor     dx, dx
    mov     ax, 4000h
    div     bx
    mov     word_3FB36, ax
loc_3072D:
    mov     ax, bx
    mov     dx, 201h
    shr     ax, 1
    mov     bx, ax
    shr     bx, 1
    add     ax, word_3FB26
    add     ax, bx
    mov     word_3FB32, ax
    sub     ax, bx
    sub     ax, bx
    mov     word_3FB30, ax
    mov     ax, joyflag2
    jmp     short loc_30777
    ; align 2
    db 144
loc_3074E:
    or      joyinput, 8
    jmp     short loc_306F6
loc_30755:
    cmp     ax, word_3FB2A
    jle     short loc_30777
    dec     word_3FB2E
    jz      short loc_3076D
loc_30761:
    cmp     ax, word_3FB2C
    jge     short loc_30789
    mov     word_3FB2C, ax
    jmp     short loc_30789
    db 144
loc_3076D:
    mov     bx, word_3FB2C
    mov     word_3FB2A, bx
    jmp     short loc_3071D
loc_30777:
    mov     word_3FB2E, 14h
    mov     word_3FB2C, 4E20h
    mov     word_3FB28, 0
loc_30789:
    cmp     ax, word_3FB30
    jb      short loc_307AD
    cmp     ax, word_3FB32
    jb      short loc_3079A
    or      joyinput, 2
loc_3079A:
    in      al, dx          ; Game I/O port
    and     al, joybutton
smart
    and     al, 30h
nosmart
    xor     al, 30h
    or      joyinput, al
    mov     al, joyinput
    xor     ah, ah
    retf
loc_307AD:
    or      joyinput, 1
    jmp     short loc_3079A
get_joy_flags endp
sub_307B4 proc far

    mov     byte_3FE00, 1
    mov     word_3FB18, 50h ; 'P'
    mov     word_3FB1C, 0
    mov     word_3FB26, 50h ; 'P'
    mov     word_3FB2A, 0
    retf
sub_307B4 endp
sub_307D2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
smart
    and     bx, 0Fh
nosmart
    mov     al, byte_3FB38[bx]
    xor     ah, ah
    pop     bp
    retf
sub_307D2 endp
sub_307E3 proc far

    mov     ax, joyflag1
    sub     ax, word_3FB18
    jge     short loc_307EE
    xor     ax, ax
loc_307EE:
    mul     word_3FB34
    mov     al, ah
    mov     ah, dl
    sub     ax, 1Fh
    retf
sub_307E3 endp
nopsub_307FA proc far

    mov     ax, joyflag2
    sub     ax, word_3FB26
    jge     short loc_30805
    xor     ax, ax
loc_30805:
    mul     word_3FB36
    mov     al, ah
    mov     ah, dl
    sub     ax, 1Fh
    retf
    ; align 2
    db 0
nopsub_307FA endp
kb_init_interrupt proc far
     r = byte ptr 0

    push    di
    in      al, 21h         ; Interrupt controller, 8259A.
    mov     ah, al
    or      al, 3
    out     21h, al         ; Interrupt controller, 8259A.
    xor     bx, bx
    mov     es, bx
    mov     bx, es:24h      ; 24h = func ofs for keyboard action
    cmp     bx, offset kb_int9_handler
    jz      short loc_30861
    mov     old_kb_intr_ofs, bx
    mov     bx, es:26h      ; 26h - func seg for keyboard action
    mov     old_kb_intr_seg, bx
    mov     word ptr es:24h, offset kb_int9_handler
    mov     word ptr es:26h, cs
    mov     bx, es:58h      ; 58h - func ofs for bios keyboard
    mov     old_kb_intr_bios_ofs, bx
    mov     bx, es:5Ah      ; 5Ah - func seg for bios keyboard
    mov     old_kb_intr_bios_seg, bx
    mov     word ptr es:58h, offset kb_int16_handler
    mov     word ptr es:5Ah, cs
loc_30861:
    mov     al, ah
    out     21h, al         ; Interrupt controller, 8259A.
    mov     ax, ds
    mov     es, ax
    mov     di, offset kbinput
    mov     cx, 5Ah ; 'Z'
    xor     ax, ax
    cld
    rep stosb
    push    cs
    mov     ax, offset kb_exit_handler
    push    ax
    call    add_exit_handler
    add     sp, 4
    pop     di
    retf
kb_init_interrupt endp
kb_exit_handler proc far

    in      al, 21h         ; Interrupt controller, 8259A.
    mov     ah, al
    or      al, 3
    out     21h, al         ; Interrupt controller, 8259A.
    xor     bx, bx
    mov     es, bx
    mov     bx, old_kb_intr_ofs
    or      bx, bx
    jz      short loc_308C1
    mov     es:24h, bx
    mov     bx, old_kb_intr_seg
    mov     es:26h, bx
    mov     bx, old_kb_intr_bios_ofs
    mov     es:58h, bx
    mov     bx, old_kb_intr_bios_seg
    mov     es:5Ah, bx
    mov     al, es:417h
smart
    and     al, 0F0h
nosmart
    mov     es:417h, al
loc_308C1:
    mov     al, ah
    out     21h, al         ; Interrupt controller, 8259A.
    retf
kb_exit_handler endp
kb_int9_handler proc far

    sti
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    mov     ax, seg dseg
    mov     ds, ax
    in      al, 60h         ; AT Keyboard controller 8042.
    push    ax
    in      al, 61h         ; PC/XT PPI port B bits:
    mov     ah, al
    or      al, 80h
    out     61h, al         ; PC/XT PPI port B bits:
    xchg    ah, al
    out     61h, al         ; PC/XT PPI port B bits:
    pop     ax
    test    al, 80h
    jz      short loc_308F4
smart
    and     al, 7Fh
nosmart
    jmp     loc_30992       ; .. do some stuff, then end
loc_308EA:
    mov     al, 20h ; ' '
    out     20h, al         ; Interrupt controller, 8259A.
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    iret
loc_308F4:
    xor     ah, ah
    mov     bx, ax
    cmp     bx, 5Ah ; 'Z'   ; keymaps are 91 bytes
    jb      short loc_308FF
    xor     bx, bx
loc_308FF:
    mov     kblastinput, bx
    mov     kbinput[bx], 1
    test    kbinput+38h, 1
    jnz     short loc_30986 ; test keymap5
    test    kbinput+1Dh, 1
    jnz     short loc_30980 ; test keymap4
    test    kbinput+2Ah, 1
    jnz     short loc_3097A ; test keymap2
    test    kbinput+36h, 1
    jnz     short loc_3097A ; test keymap2
    test    kbinput+3Ah, 1
    jnz     short loc_3098C ; test keymap3
    mov     al, keymap1[bx]
loc_3092F:
    test    al, 80h
    jnz     short loc_3096C
    xor     ah, ah
loc_30935:
    mov     bx, kb_intr_data
    cli
    mov     kb_intr_data_array[bx], ax
    add     bx, 2
    cmp     bx, kb_intr_data3
    jb      short loc_30949
    xor     bx, bx
loc_30949:
    mov     kb_intr_data, bx
    mov     bx, kb_intr_data4
    add     bx, 2
    cmp     bx, kb_intr_data3
    jbe     short loc_30964
    mov     bx, kb_intr_data3
    mov     ax, kb_intr_data
    mov     kb_intr_data2, ax
loc_30964:
    mov     kb_intr_data4, bx
    sti
    jmp     loc_308EA
loc_3096C:
    mov     ah, al
    xor     al, al
    cmp     ah, 85h ; 'Ö'
    jb      short loc_30978
smart
    and     ah, 7Fh
nosmart
loc_30978:
    jmp     short loc_30935
loc_3097A:
    mov     al, keymap2[bx]
    jmp     short loc_3092F
loc_30980:
    mov     al, keymap4[bx]
    jmp     short loc_3092F
loc_30986:
    mov     al, keymap5[bx]
    jmp     short loc_3092F
loc_3098C:
    mov     al, keymap3[bx]
    jmp     short loc_3092F
loc_30992:
    xor     ah, ah
    mov     bx, ax
    cmp     bx, 5Ah ; 'Z'
    jb      short loc_3099D
    xor     bx, bx
loc_3099D:
    mov     kbinput[bx], 0
    jmp     loc_308EA
kb_int9_handler endp
kb_int16_handler proc far
     r = byte ptr 0

    push    bx
    push    ds
    mov     bx, seg dseg
    mov     ds, bx
    cmp     ah, 0
    jz      short loc_309C3
    cmp     ah, 1
    jz      short loc_309EF
    cmp     ah, 2
    jz      short loc_30A04
loc_309BB:
    xor     ax, ax
loc_309BD:
    sti
    pop     ds
    pop     bx
    retf    2
loc_309C3:
    cli
    cmp     kb_intr_data4, 0
    jz      short loc_309BB
    mov     bx, kb_intr_data2
    mov     ax, kb_intr_data_array[bx]
    add     bx, 2
    cmp     bx, kb_intr_data3
    jb      short loc_309DE
    xor     bx, bx
loc_309DE:
    mov     kb_intr_data2, bx
    mov     bx, kb_intr_data4
    sub     bx, 2
    mov     kb_intr_data4, bx
    jmp     short loc_309BD
loc_309EF:
    cmp     kb_intr_data4, 0
    jz      short loc_309BB
    sti
    mov     bx, kb_intr_data2
    mov     ax, kb_intr_data_array[bx]
    pop     ds
    pop     bx
    retf    2
loc_30A04:
    mov     al, kbinput+2Ah
    or      al, kbinput+36h
    jmp     short loc_309BD
kb_int16_handler endp
kb_get_key_state proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_0]
    mov     al, kbinput[bx]
    xor     ah, ah
    pop     bp
    retf
    ; align 2
    db 0
kb_get_key_state endp
kb_call_readchar_callback proc far

    call    dword ptr readchar_callback_ofs
    retf
kb_call_readchar_callback endp
kb_read_char proc far

    mov     ah, 1
    int     16h             ; KEYBOARD - CHECK BUFFER, DO NOT CLEAR
    jnz     short loc_30A2A
    xor     ax, ax
    retf
loc_30A2A:
    mov     ah, 0
    int     16h             ; KEYBOARD - READ CHAR FROM BUFFER, WAIT IF EMPTY
    or      al, al
    jz      short locret_30A34
    xor     ah, ah
locret_30A34:
    retf
kb_read_char endp
kb_checking proc far

    mov     ah, 1
    int     16h             ; KEYBOARD - CHECK BUFFER, DO NOT CLEAR
    jnz     short loc_30A3D
    xor     ax, ax
loc_30A3D:
    or      al, al
    jz      short locret_30A43
    xor     ah, ah
locret_30A43:
    retf
kb_checking endp
nopsub_kb_set_readchar_callback proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     readchar_callback_ofs, ax
    mov     ax, [bp+arg_2]
    mov     readchar_callback_seg, ax
    pop     bp
    retf
nopsub_kb_set_readchar_callback endp
nopsub_kb_get_readchar_callback proc far

    mov     ax, readchar_callback_ofs
    mov     dx, readchar_callback_seg
    retf
nopsub_kb_get_readchar_callback endp
flush_stdin proc far

    call    kb_call_readchar_callback
    cmp     ax, 0
    jz      short near ptr flush_stdin
    retf
flush_stdin endp
kb_check proc far

    mov     ah, 1
    int     16h             ; KEYBOARD - CHECK BUFFER, DO NOT CLEAR
    jnz     short loc_30A71
    xor     ax, ax
    retf
loc_30A71:
    mov     ah, 0
    int     16h             ; KEYBOARD - READ CHAR FROM BUFFER, WAIT IF EMPTY
    jmp     short near ptr kb_check
kb_check endp
nopsub_30A77 proc far

    call    kb_call_readchar_callback
    cmp     ax, 0
    jnz     short locret_30A96
    call    timer_get_counter
    cmp     dx, word ptr timer_copy_unk+2
    jb      short near ptr nopsub_30A77
    ja      short loc_30A94
    cmp     ax, word ptr timer_copy_unk
    jb      short near ptr nopsub_30A77
loc_30A94:
    xor     ax, ax
locret_30A96:
    retf
nopsub_30A77 endp
nopsub_30A97 proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    call    timer_get_counter
    add     ax, [bp+arg_0]
    adc     dx, [bp+arg_2]
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_30AAE:
    call    kb_call_readchar_callback
    cmp     ax, 0
    jnz     short loc_30ACB
    call    timer_get_counter
    cmp     dx, [bp+var_2]
    jb      short loc_30AAE
loc_30AC2:
    ja      short loc_30AC9
    cmp     ax, [bp+var_4]
    jb      short loc_30AAE
loc_30AC9:
    xor     ax, ax
loc_30ACB:
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
nopsub_30A97 endp
file_read proc far
    var_fatal = word ptr -8
     s = byte ptr 0
     r = byte ptr 2
    arg_fatal = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    ds
    mov     ax, [bp+arg_fatal]
    mov     [bp+var_fatal], ax
    jmp     short _file_read
    ; align 2
    db 144
file_read endp
file_read_nofatal proc far
    var_fatal = word ptr -8
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    ds
    mov     [bp+var_fatal], 0
    jmp     short _file_read
    db 144
file_read_nofatal endp
file_read_fatal proc far
    var_fatal = word ptr -8
    var_curseg = word ptr -6
    var_curoff = word ptr -4
    var_filehandle = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_dstoff = word ptr 8
    arg_dstseg = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 8
    push    ds
    mov     [bp+var_fatal], 1
_file_read:
    mov     ax, [bp+arg_dstoff]
    mov     [bp+var_curoff], ax
    mov     ax, [bp+arg_dstseg]
    mov     [bp+var_curseg], ax
    mov     dx, [bp+arg_filename]
    xor     al, al
    mov     ah, 3Dh
    int     21h             ; DOS - 2+ - OPEN DISK FILE WITH HANDLE
    jb      short error
    mov     [bp+var_filehandle], ax
readloop:
    mov     ds, [bp+var_curseg]
    mov     dx, [bp+var_curoff]
    mov     cx, 4000h
    mov     bx, [bp+var_filehandle]
    mov     ah, 3Fh
    int     21h             ; DOS - 2+ - READ FROM FILE WITH HANDLE
    jb      short error
    add     [bp+var_curseg], 400h
    cmp     ax, 4000h
    jz      short readloop
    mov     bx, [bp+var_filehandle]
    mov     ah, 3Eh
    int     21h             ; DOS - 2+ - CLOSE A FILE WITH HANDLE
    mov     ax, [bp+arg_dstoff]
    mov     dx, [bp+arg_dstseg]
    pop     ds
    mov     sp, bp
    pop     bp
    retf
error:
    cmp     [bp+var_fatal], 0
    jnz     short fatal
    xor     ax, ax
    xor     dx, dx
    pop     ds
    mov     sp, bp
    pop     bp
    retf
fatal:
    mov     ax, offset aSFileError; "%s FILE ERROR\r"
    mov     bx, ss
    mov     ds, bx
    push    [bp+arg_filename]
    push    ax
    call    far ptr fatal_error
file_read_fatal endp
file_decomp_rle proc far
    var_lenlo = word ptr -26
    var_lenhi = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_esclen = word ptr -18
     s = byte ptr 0
     r = byte ptr 2
    arg_srcoff = word ptr 6
    arg_srcseg = word ptr 8
    arg_dstoff = word ptr 12
    arg_dstseg = word ptr 14

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    sub     sp, 116h
    cld
    mov     ax, ds
    mov     es, ax
    mov     si, [bp+arg_srcoff]
    mov     ds, [bp+arg_srcseg]
    mov     ax, [si+1]
    mov     [bp+var_lenlo], ax
    mov     al, [si+3]
    xor     ah, ah
    mov     [bp+var_lenhi], ax
    add     si, 4           ; Skip header + unused byte
    mov     cx, 8
    lea     di, [bp+var_16] ; Read 8 words
    rep movsw
    mov     si, [bp+arg_srcoff]; Reset source pos
    add     si, 9
    mov     dx, [bp+var_esclen]
smart
    and     dx, 7Fh         ; Escape codes length mask
nosmart
    add     si, dx
    mov     [bp+arg_srcoff], si; Skip escape codes
    cmp     byte ptr [bp+var_esclen], 80h ; 'Ä'; Skip seq pass flag
    ja      short skip_seq_pass
    call near ptr file_decomp_rle_seq
    mov     [bp+var_16], ax
    mov     [bp+var_14], dx
    mov     si, ax          ; paras = len / 16
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    test    si, 0Fh
    jz      short no_remainder
    inc     ax
no_remainder:
    push    ax              ; paras
    mov     bx, [bp+arg_dstseg]
    sub     bx, ax
    add     bx, [bp+arg_dstoff]
    mov     [bp+arg_srcseg], bx
    push    bx
    push    [bp+arg_dstoff]
    call    copy_paras_reverse
    add     sp, 6
    xor     si, si
    mov     [bp+arg_srcoff], si
skip_seq_pass:
    call near ptr file_decomp_rle_single
    mov     ax, [bp+var_lenlo]; Return length
    mov     dx, [bp+var_lenhi]
    add     sp, 116h
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
file_decomp_rle endp
file_decomp_rle_single proc near

    mov     cx, 80h ; 'Ä'
    lea     di, [bp-11Ch]
    mov     ax, ss
    mov     es, ax
    mov     ds, ax
    xor     ax, ax
    rep stosw
    mov     cl, [bp-12h]
smart
    and     cx, 7Fh
nosmart
    lea     si, [bp-11h]
    lea     di, [bp-11Ch]
    xor     ax, ax
    xor     bh, bh
loc_30C1A:
    inc     ax
    mov     bl, [si]
    mov     [bx+di], al
    inc     si
    loop    loc_30C1A
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     es, word ptr [bp+0Ch]
    xor     di, di
    mov     dx, [bp-16h]
    mov     ax, [bp-14h]
    mov     [bp-1Ch], ax
loc_30C36:
    cmp     si, 8000h
    jbe     short loc_30C3F
    jmp     short loc_30CB3
    db 144
loc_30C3F:
    cmp     di, 8000h
    jbe     short loc_30C48
    jmp     short loc_30CC1
    ; align 2
    db 144
loc_30C48:
    lodsb
    xor     ah, ah
    lea     bx, [bp-11Ch]
    add     bx, ax
    mov     cl, ss:[bx]
    test    cl, 0FFh
    jnz     short loc_30C68
    stosb
    dec     dx
    jnz     short loc_30C36
    cmp     word ptr [bp-1Ch], 0
    jz      short loc_30C8A
    dec     word ptr [bp-1Ch]
    jmp     short loc_30C36
loc_30C68:
    xor     ch, ch
    cmp     cl, 1
    jz      short loc_30C9A
    cmp     cl, 3
    jz      short loc_30CA5
    dec     cx
    lodsb
    rep stosb
    sub     dx, 2
loc_30C7B:
    mov     ax, [bp-1Ch]
    sbb     ax, 0
    mov     [bp-1Ch], ax
    or      ax, dx
    jz      short loc_30C8A
    jmp     short loc_30C36
loc_30C8A:
    mov     dx, es
    sub     dx, [bp+0Ch]
    mov     ax, 10h
    mul     dx
    add     ax, di
    adc     dx, 0
    retn
loc_30C9A:
    lodsb
    mov     cl, al
    lodsb
    rep stosb
    sub     dx, 3
    jmp     short loc_30C7B
loc_30CA5:
    lodsb
    mov     cl, al
    lodsb
    mov     ch, al
    lodsb
    rep stosb
    sub     dx, 4
    jmp     short loc_30C7B
loc_30CB3:
    sub     si, 8000h
    mov     ax, ds
    add     ax, 800h
    mov     ds, ax
    jmp     loc_30C3F
loc_30CC1:
    sub     di, 8000h
    mov     ax, es
    add     ax, 800h
    mov     es, ax
    jmp     loc_30C48
file_decomp_rle_single endp
file_decomp_rle_seq proc near

    cmp     byte ptr [bp-12h], 1; file_decomp_rle::var_esclen
    jnz     short has_codes
    retn
has_codes:
    mov     ds, word ptr [bp+8]; file_decomp_rle::arg_srcseg
    mov     si, [bp+6]      ; file_decomp_rle::arg_srcoff
    mov     es, word ptr [bp+0Ch]; file_decomp_rle::var_dstoff
    xor     di, di
    mov     bx, [bp-16h]
    mov     ax, [bp-14h]
    mov     [bp-1Ch], ax
    mov     ah, [bp-10h]
loc_30CED:
    cmp     si, 8000h
    ja      short loc_30D0D
loc_30CF3:
    cmp     di, 8000h
    ja      short loc_30D1B
loc_30CF9:
    lodsb
    cmp     al, ah
    jz      short loc_30D39
    stosb
    dec     bx
    jnz     short loc_30CED
    cmp     word ptr [bp-1Ch], 0
    jz      short loc_30D29
    dec     word ptr [bp-1Ch]
    jmp     short loc_30CED
loc_30D0D:
    sub     si, 8000h
    mov     dx, ds
    add     dx, 800h
    mov     ds, dx
    jmp     short loc_30CF3
loc_30D1B:
    sub     di, 8000h
    mov     dx, es
    add     dx, 800h
    mov     es, dx
    jmp     short loc_30CF9
loc_30D29:
    mov     dx, es
    sub     dx, [bp+0Ch]
    mov     ax, 10h
    mul     dx
    add     ax, di
    adc     dx, 0
    retn
loc_30D39:
    mov     dx, di
loc_30D3B:
    lodsb
    cmp     al, ah
    jz      short loc_30D49
    stosb
    dec     bx
    jnz     short loc_30D3B
    dec     word ptr [bp-1Ch]
    jmp     short loc_30D3B
loc_30D49:
    lodsb
    push    si
    push    ds
    mov     cx, es
    mov     ds, cx
    mov     si, dx
    mov     cx, di
    sub     cx, dx
    mov     dl, al
    dec     dl
loc_30D5A:
    push    cx
    push    si
    push    ds
    rep movsb
    pop     ds
    pop     si
    pop     cx
    dec     dl
    jnz     short loc_30D5A
    pop     ds
    pop     si
    sub     bx, 3
    sbb     word ptr [bp-1Ch], 0
    mov     dx, [bp-1Ch]
    or      dx, bx
    jz      short loc_30D29
    jmp     loc_30CED
file_decomp_rle_seq endp
file_load_binary proc far
    var_fatal = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_fatal = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 2
    mov     ax, [bp+arg_fatal]
    mov     [bp+var_fatal], ax
    jmp     short _file_load_binary
    ; align 2
    db 144
file_load_binary endp
file_load_binary_nofatal proc far
    var_fatal = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 2
    mov     [bp+var_fatal], 0
    jmp     short _file_load_binary
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 2
    mov     [bp+var_fatal], 1
_file_load_binary:
    push    [bp+arg_filename]
    call    mmgr_get_chunk_by_name
    add     sp, 2
    or      dx, dx
    jnz     short loc_30DDE
    push    [bp+var_fatal]
    push    [bp+arg_filename]
    call    file_paras
    add     sp, 4
    or      ax, ax
    jz      short emptyfile
    push    ax
    push    [bp+arg_filename]
    call    mmgr_alloc_pages
    add     sp, 4
    push    [bp+var_fatal]
    push    dx
    push    ax
    push    [bp+arg_filename]
    call    file_read
    add     sp, 8
loc_30DDE:
    mov     sp, bp
    pop     bp
    retf
emptyfile:
    xor     dx, dx
    jmp     short loc_30DDE
file_load_binary_nofatal endp
file_decomp proc far
    var_fatal = word ptr -12
     s = byte ptr 0
     r = byte ptr 2
    arg_fatal = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    si
    push    di
    mov     ax, [bp+arg_fatal]
    mov     [bp+var_fatal], ax
    jmp     short _file_decomp
    db 144
file_decomp endp
file_decomp_nofatal proc far
    var_fatal = word ptr -12
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    si
    push    di
    mov     [bp+var_fatal], 0
    jmp     short _file_decomp
    db 144
file_decomp_nofatal endp
file_decomp_fatal proc far
    var_fatal = word ptr -12
    var_nextsrcseg = word ptr -10
    var_passes = word ptr -8
    var_decomp_paras = word ptr -6
    var_dstseg = word ptr -4
    var_dstoff = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    si
    push    di
    mov     [bp+var_fatal], 1
_file_decomp:
    push    [bp+arg_filename]
    call    mmgr_get_chunk_by_name
    add     sp, 2
    or      dx, dx
    jz      short fd_not_found
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_30E29:
    jmp     loc_30F0F
fd_not_found:
    push    [bp+var_fatal]
    push    [bp+arg_filename]
    call    file_decomp_paras
    add     sp, 4
    or      ax, ax
    jz      short loc_30E29
    add     ax, 4
    mov     [bp+var_decomp_paras], ax
    push    ax
    push    [bp+arg_filename]
    call    mmgr_alloc_pages
    add     sp, 4
    mov     [bp+var_dstoff], ax
    mov     [bp+var_dstseg], dx
    push    [bp+var_fatal]
    push    [bp+arg_filename]
    call    file_paras
    add     sp, 4
    or      ax, ax
    jz      short loc_30E29
    mov     dx, [bp+var_decomp_paras]
    sub     dx, ax
    add     dx, [bp+var_dstseg]
    push    [bp+var_fatal]
    push    dx
    push    [bp+var_dstoff]
    push    [bp+arg_filename]
    call    file_read
    add     sp, 8
    or      dx, dx
    jz      short loc_30E29
    mov     [bp+var_passes], 1
    mov     ds, dx
    mov     si, ax
    mov     al, [si]
    test    al, 80h
    jz      short decompress_subfile
smart
    and     ax, 7Fh
nosmart
    mov     [bp+var_passes], ax
    add     si, 4
decompress_subfile:
    push    [bp+var_decomp_paras]
    push    [bp+var_dstseg]
    push    [bp+var_dstoff]
    push    ds
    mov     bl, [si]
    dec     bl
    jl      short loc_30F0C
    cmp     bl, 2
    jge     short loc_30F0C
    push    si
    xor     bh, bh
    shl     bx, 1
    mov     ax, seg dseg
    mov     ds, ax
    shl     bx, 1
    call    dword ptr cs:compression_type[bx]
    add     sp, 0Ah
    dec     [bp+var_passes]
    jle     short fd_done
    mov     si, ax
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    test    si, 0Fh
    jz      short loc_30EE5
    inc     ax
loc_30EE5:
    push    ax
    mov     bx, [bp+var_decomp_paras]
    sub     bx, ax
    add     bx, [bp+var_dstseg]
    mov     [bp+var_nextsrcseg], bx
    push    bx
    push    [bp+var_dstseg]
    call    copy_paras_reverse
    add     sp, 6
    mov     ds, [bp+var_nextsrcseg]
    xor     si, si
    jmp     short decompress_subfile
compression_type     dd file_decomp_rle
    dd file_decomp_vle
loc_30F0C:
    add     sp, 8
loc_30F0F:
    cmp     [bp+var_fatal], 0
    jnz     short loc_30F1F
    xor     ax, ax
    xor     dx, dx
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_30F1F:
    mov     bx, ss
    mov     ds, bx
    push    [bp+arg_filename]
    mov     ax, offset aSInvalidPackTy; "%s INVALID PACK TYPE\r"
    push    ax
    call    far ptr fatal_error
fd_done:
    mov     ax, [bp+var_decomp_paras]
    sub     ax, 4
    push    ax
    push    [bp+var_dstseg]
    push    [bp+var_dstoff]
    call    mmgr_resize_memory
    add     sp, 6
    mov     ax, [bp+var_dstoff]
    mov     dx, [bp+var_dstseg]
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    si
    push    di
    mov     ax, [bp+arg_6]
    mov     [bp+var_fatal], ax
    jmp     short loc_30F7E
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    si
    push    di
    mov     [bp+var_fatal], 0
    jmp     short loc_30F7E
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    si
    push    di
    mov     [bp+var_fatal], 1
loc_30F7E:
    push    [bp+var_fatal]
    push    [bp+arg_filename]
    call    file_decomp_fatal
    add     sp, 4
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
file_decomp_fatal endp
locate_shape_nofatal proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    xor     dx, dx
    jmp     short _alt_locate_resource
    db 144
locate_shape_nofatal endp
locate_shape_fatal proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    mov     dx, 1
    jmp     short _alt_locate_resource
    db 144
locate_shape_fatal endp
locate_sound_fatal proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    mov     dx, 2
_alt_locate_resource:
    cld
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, seg dseg
    mov     es, ax
    mov     di, [bp+arg_4]
    mov     cx, 4
    mov     bx, 0
loc_30FC7:
    cmp     byte ptr es:[bx+di], 0
    jz      short loc_31024
    inc     bx
    loop    loc_30FC7
loc_30FD0:
    mov     ax, [si+4]
    or      ax, ax
    jz      short _end_of_locate
    add     si, 6
    mov     bx, si
loc_30FDC:
    mov     si, bx
    mov     di, [bp+arg_4]
    mov     cx, 4
loc_30FE4:
    cmpsb
    jnz     short loc_30FEC
    loop    loc_30FE4
    jmp     short _found_resource
    ; align 2
    db 144
loc_30FEC:
    cmp     byte ptr [si-1], 0
    jnz     short loc_30FF9
    cmp     byte ptr es:[di-1], 20h ; ' '
    jz      short _found_resource
loc_30FF9:
    add     bx, 4
    dec     ax
    jge     short loc_30FDC
_end_of_locate:
    cmp     dx, 1
    jl      short loc_3101F
    jg      short loc_3100C
    mov     dx, offset aLocateshape4_4sShapeNotF; "locateshape - %-4.4s SHAPE NOT FOUND\r\n"
    jmp     short loc_3100F
    ; align 2
    db 144
loc_3100C:
    mov     dx, offset aLocatesound4_4sSoundNotF; "locatesound - %-4.4s SOUND NOT FOUND\r\n"
loc_3100F:
    mov     ax, seg dseg
    mov     ds, ax
    push    [bp+arg_4]
    push    dx
    call    far ptr fatal_error
    int     20h             ; DOS - PROGRAM TERMINATION
loc_3101F:
    xor     ax, ax
    jmp     short loc_31075
    ; align 2
    db 144
loc_31024:
    mov     byte ptr es:[bx+di], 20h ; ' '
    inc     bx
    loop    loc_31024
    jmp     short loc_30FD0
_found_resource:
    mov     si, [bp+arg_0]
    mov     ax, [si+4]
    shl     ax, 1
    shl     ax, 1
    add     bx, ax
    shl     ax, 1
    add     ax, 6
    mov     cx, ds
    xor     dx, dx
    shl     cx, 1
    rcl     dx, 1
    shl     cx, 1
    rcl     dx, 1
    shl     cx, 1
    rcl     dx, 1
    shl     cx, 1
    rcl     dx, 1
    add     ax, cx
    adc     dx, 0
    add     ax, [bx]
    adc     dx, [bx+2]
    mov     bx, ax
smart
    and     bx, 0Fh
nosmart
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    mov     dx, ax
    mov     ax, bx
loc_31075:
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
locate_sound_fatal endp
mmgr_alloc_resmem proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, 3000h
    int     21h             ; DOS - GET DOS VERSION
    mov     bx, cs
    cmp     al, 3
    jl      short loc_3108E
    mov     ah, 62h
    int     21h             ; DOS - 3+ - GET PSP ADDRESS
loc_3108E:
    mov     pspofs, bx
    mov     pspseg, ds
    cmp     word_3FF82, 0
    jnz     short loc_310CD
    mov     bx, 64h ; 'd'
    mov     ah, 48h
    int     21h             ; DOS - 2+ - ALLOCATE MEMORY
    mov     si, resptr1
    mov     [si+MEMCHUNK.resofs], ax
    mov     word_3FF84, ax
    mov     es, ax
    mov     bx, [bp+arg_0]
    sub     bx, [si+MEMCHUNK.resofs]
    mov     ah, 4Ah
    int     21h             ; DOS - 2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
    mov     ah, 4Ah
    int     21h             ; DOS - 2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
    mov     ax, word_3FF84
    add     ax, bx
    mov     si, resendptr2
    mov     [si+MEMCHUNK.resofs], ax
    mov     word_3FF82, ax
loc_310CD:
    mov     si, resendptr2
    mov     resendptr1, si
    mov     si, resptr1
    mov     resptr2, si
loc_310DD:
    add     si, 12h
    cmp     si, resendptr2
    jz      short loc_310ED
    mov     [si+MEMCHUNK.resunk], 0
    jmp     short loc_310DD
loc_310ED:
    pop     di
    pop     si
    pop     bp
    retf
mmgr_alloc_resmem endp
mmgr_alloc_a000 proc far

    mov     ax, 0A000h
    push    ax
    call    mmgr_alloc_resmem
    add     sp, 2
    retf
mmgr_alloc_a000 endp
nopsub_310FE proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, 0A000h
    push    ax
    call    mmgr_alloc_resmem
    add     sp, 2
    mov     ax, [bp+arg_0]
    mov     bx, resendptr2
    sub     [bx+MEMCHUNK.resofs], ax
    sub     word_3FF82, ax
    pop     bp
    retf
nopsub_310FE endp
nopsub_3111D proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     pspofs, cs
    mov     pspseg, ds
    cmp     word_3FF82, 0
    jnz     short loc_310CD
    mov     bx, [bp+arg_0]
    mov     ah, 48h
    int     21h             ; DOS - 2+ - ALLOCATE MEMORY
    jnb     short loc_3113E
    mov     ah, 48h
    int     21h             ; DOS - 2+ - ALLOCATE MEMORY
loc_3113E:
    mov     si, resptr1
    mov     [si+MEMCHUNK.resofs], ax
    mov     word_3FF84, ax
    add     ax, bx
    mov     si, resendptr2
    mov     [si+MEMCHUNK.resofs], ax
    mov     word_3FF82, ax
    jmp     loc_310CD
nopsub_3111D endp
nopsub_31157 proc far

    mov     bx, resendptr1
    mov     ax, [bx+MEMCHUNK.resofs]
    mov     bx, resptr2
    sub     ax, [bx+MEMCHUNK.resofs]
    sub     ax, [bx+MEMCHUNK.ressize]
    retf
nopsub_31157 endp
nopsub_31169 proc far

    mov     bx, resptr2
    mov     ax, [bx+MEMCHUNK.resofs]
    add     ax, [bx+MEMCHUNK.ressize]
    mov     bx, resptr1
    sub     ax, [bx+MEMCHUNK.resofs]
    retf
nopsub_31169 endp
mmgr_get_ofs_diff proc far

    mov     bx, resendptr2
    mov     ax, [bx+MEMCHUNK.resofs]
    mov     bx, resptr2
    sub     ax, [bx+MEMCHUNK.resofs]
    sub     ax, [bx+MEMCHUNK.ressize]
    retf
mmgr_get_ofs_diff endp
mmgr_copy_paras proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    cld
    mov     ds, [bp+arg_0]
    mov     es, [bp+arg_2]
    mov     bx, [bp+arg_4]
loc_3119D:
    or      bx, bx
    jz      short loc_311D0
    mov     cx, 8000h
    mov     ax, bx
    sub     bx, 1000h
    jnb     short loc_311BA
    add     bx, 1000h
    shl     bx, 1
    shl     bx, 1
    shl     bx, 1
    mov     cx, bx
    xor     bx, bx
loc_311BA:
    xor     si, si
    xor     di, di
    rep movsw
    mov     ax, ds
    add     ax, 1000h
    mov     ds, ax
    mov     ax, es
    add     ax, 1000h
    mov     es, ax
    jmp     short loc_3119D
loc_311D0:
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
mmgr_copy_paras endp
copy_paras_reverse proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    std
    mov     bx, [bp+arg_4]
    mov     ax, [bp+arg_0]
    add     ax, bx
    mov     ds, ax
    mov     ax, [bp+arg_2]
    add     ax, bx
    mov     es, ax
loc_311ED:
    or      bx, bx
    jz      short loc_31222
    mov     cx, 1000h
    sub     bx, 1000h
    jnb     short loc_31202
    add     bx, 1000h
    mov     cx, bx
    xor     bx, bx
loc_31202:
    mov     ax, ds
    sub     ax, cx
    mov     ds, ax
    mov     ax, es
    sub     ax, cx
    mov     es, ax
    shl     cx, 1
    shl     cx, 1
    shl     cx, 1
    mov     ax, cx
    shl     ax, 1
    dec     ax
    dec     ax
    mov     si, ax
    mov     di, ax
    rep movsw
    jmp     short loc_311ED
loc_31222:
    cld
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
copy_paras_reverse endp
mmgr_path_to_name proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    mov     si, [bp+arg_filename]
    mov     bx, si
    cld
loc_31232:
    lodsb
    or      al, al
    jz      short loc_31243
    cmp     al, 3Ah ; ':'
    jz      short loc_3123F
    cmp     al, 5Ch ; '\'
    jnz     short loc_31232
loc_3123F:
    mov     bx, si
    jmp     short loc_31232
loc_31243:
    mov     ax, bx
    pop     si
    pop     bp
    retf
mmgr_path_to_name endp
mmgr_alloc_pages proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     di, resptr2
    mov     si, resendptr1
    mov     dx, [di+MEMCHUNK.resofs]
    add     dx, [di+MEMCHUNK.ressize]
    add     di, 12h
    cmp     si, di
    jbe     short loc_312A7
loc_31262:
    mov     resptr2, di
    push    [bp+arg_0]
    call    mmgr_path_to_name
    add     sp, 2
    mov     si, ax
    xor     bx, bx
    mov     cx, 0Ch
loc_31278:
    mov     al, byte ptr [bx+si+MEMCHUNK.resname]
    mov     byte ptr [bx+di+MEMCHUNK.resname], al
    inc     bx
    loop    loc_31278
    mov     si, resendptr1
    mov     ax, [bp+arg_2]
    mov     [di+MEMCHUNK.resofs], dx
    mov     [di+MEMCHUNK.ressize], ax
    mov     [di+MEMCHUNK.resunk], 2
    add     ax, dx
    cmp     ax, resmaxsize
    jb      short loc_3129C
    mov     resmaxsize, ax
loc_3129C:
    cmp     ax, [si+MEMCHUNK.resofs]
    ja      short loc_312C2
loc_312A1:
    xor     ax, ax
    pop     di
    pop     si
    pop     bp
    retf
loc_312A7:
    cmp     si, resendptr2
    jz      short loc_312B6
    add     si, 12h
    mov     resendptr1, si
    jmp     short loc_31262
loc_312B6:
    push    [bp+arg_0]
    mov     ax, offset aReservememoryO; "reservememory - OUT OF MEMORY SLOTS RES"...
    push    ax
    call    far ptr fatal_error
loc_312C2:
    mov     si, resendptr1
    mov     di, resptr2
    mov     ax, [di+MEMCHUNK.resofs]
    add     ax, [di+MEMCHUNK.ressize]
loc_312D0:
    cmp     ax, [si+MEMCHUNK.resofs]
    jbe     short loc_312A1
    cmp     si, resendptr2
    jz      short loc_312E9
    mov     [si+MEMCHUNK.resunk], 0
    add     si, 12h
    mov     resendptr1, si
    jmp     short loc_312D0
loc_312E9:
    mov     bx, resmaxsize
    push    bx
    push    [di+MEMCHUNK.ressize]
    push    [bp+arg_0]
    mov     ax, offset aReservememoryOutOfMemory; "reservememory - OUT OF MEMORY RESERVING"...
    push    ax
    call    far ptr fatal_error
mmgr_alloc_pages endp
mmgr_find_free proc far
     r = byte ptr 0

    push    si
    push    di
    push    dx
    mov     si, resendptr2
    mov     di, si
    xor     dx, dx
loc_31308:
    test    [si+MEMCHUNK.resunk], 1
    jnz     short loc_31315
    add     dx, [si+MEMCHUNK.ressize]
    jmp     short loc_3131C
    db 144
loc_31315:
    or      dx, dx
    jnz     short loc_31330
loc_31319:
    sub     di, 12h
loc_3131C:
    sub     si, 12h
    cmp     si, resendptr1
    jnb     short loc_31308
    add     di, 12h
    mov     resendptr1, di
    pop     dx
    pop     di
    pop     si
    retf
loc_31330:
    mov     bx, [si+MEMCHUNK.ressize]
    push    bx
    add     di, 12h
    mov     ax, [di+MEMCHUNK.resofs]
    sub     ax, bx
    push    ax
    push    [si+MEMCHUNK.resofs]
    sub     di, 12h
    mov     [di+MEMCHUNK.ressize], bx
    mov     [di+MEMCHUNK.resofs], ax
    mov     cx, [si+MEMCHUNK.resunk]
    mov     [si+MEMCHUNK.resunk], 0
    mov     [di+MEMCHUNK.resunk], cx
    xor     bx, bx
    mov     cx, 0Ch
loc_31359:
    mov     al, byte ptr [bx+si+MEMCHUNK.resname]
    mov     byte ptr [bx+di+MEMCHUNK.resname], al
    inc     bx
    loop    loc_31359
    call    copy_paras_reverse
    add     sp, 6
    jmp     short loc_31319
mmgr_find_free endp
mmgr_get_chunk_by_name proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     si, resendptr1
    push    [bp+arg_0]
    call    mmgr_path_to_name
    add     sp, 2
    mov     di, ax
loc_31380:
    xor     bx, bx
    cmp     [si+MEMCHUNK.resunk], 0
    jz      short loc_313AE
loc_31388:
    mov     al, [bx+di]
    or      al, al
    jz      short loc_3139B
    cmp     al, byte ptr [bx+si+MEMCHUNK.resname]
    jnz     short loc_313A5
    inc     bx
    cmp     bx, 0Ch
    jl      short loc_31388
    jmp     short loc_313B6
    db 144
loc_3139B:
    cmp     byte ptr [bx+si+MEMCHUNK.resname], 2Eh ; '.'
    jz      short loc_313B6
    cmp     byte ptr [bx+si+MEMCHUNK.resname], 0
    jz      short loc_313B6
loc_313A5:
    add     si, 12h
    cmp     si, resendptr2
    jb      short loc_31380
loc_313AE:
    xor     dx, dx
loc_313B0:
    xor     ax, ax
    pop     di
    pop     si
    pop     bp
    retf
loc_313B6:
    mov     di, resptr2
    mov     dx, [di+MEMCHUNK.resofs]
    add     dx, [di+MEMCHUNK.ressize]
    add     di, 12h
    mov     resptr2, di
    mov     ax, [si+MEMCHUNK.ressize]
    push    ax
    push    dx
    push    [si+MEMCHUNK.resofs]
    mov     [si+MEMCHUNK.resunk], 0
    mov     [di+MEMCHUNK.resofs], dx
    mov     [di+MEMCHUNK.ressize], ax
    mov     [di+MEMCHUNK.resunk], 2
    xor     bx, bx
    mov     cx, 0Ch
loc_313E4:
    mov     al, byte ptr [bx+si+MEMCHUNK.resname]
    mov     byte ptr [bx+di+MEMCHUNK.resname], al
    inc     bx
    loop    loc_313E4
    cmp     di, resendptr1
    jnz     short loc_313F6
    add     resendptr1, 12h
loc_313F6:
    call    mmgr_copy_paras
    add     sp, 6
    mov     si, resendptr1
    mov     di, resptr2
    mov     ax, [di+MEMCHUNK.resofs]
    add     ax, [di+MEMCHUNK.ressize]
loc_3140C:
    cmp     ax, [si+MEMCHUNK.resofs]
    jbe     short loc_3141F
    mov     [si+MEMCHUNK.resunk], 0
    add     si, 12h
    mov     resendptr1, si
    jmp     short loc_3140C
loc_3141F:
    call    mmgr_find_free
    mov     dx, [di+MEMCHUNK.resofs]
    jmp     short loc_313B0
mmgr_get_chunk_by_name endp
nopsub_31429 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     si, resendptr1
    push    [bp+arg_0]
    call    mmgr_path_to_name
    add     sp, 2
    mov     di, ax
loc_3143F:
    xor     bx, bx
    cmp     word ptr [si+10h], 0
    jz      short loc_3146D
loc_31447:
    mov     al, [bx+di]
    or      al, al
    jz      short loc_3145A
    cmp     al, [bx+si]
    jnz     short loc_31464
    inc     bx
    cmp     bx, 0Ch
    jl      short loc_31447
    jmp     short loc_31475
    ; align 2
    db 144
loc_3145A:
    cmp     byte ptr [bx+si], 2Eh ; '.'
    jz      short loc_31475
    cmp     byte ptr [bx+si], 0
    jz      short loc_31475
loc_31464:
    add     si, 12h
    cmp     si, resendptr2
    jb      short loc_3143F
loc_3146D:
    xor     dx, dx
    xor     ax, ax
    pop     di
    pop     si
    pop     bp
    retf
loc_31475:
    mov     ax, 1
    pop     di
    pop     si
    pop     bp
    retf
nopsub_31429 endp
mmgr_free proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_2]
    mov     si, resptr2
loc_31488:
    cmp     si, resptr1
    jz      short loc_31498
    cmp     ax, [si+MEMCHUNK.resofs]
    jz      short loc_314A4
    sub     si, 12h
    jmp     short loc_31488
loc_31498:
    push    [bp+arg_2]
    mov     ax, offset aMemoryManagerB; "memory manager - BLOCK NOT FOUND at SEG"...
    push    ax
    call    far ptr fatal_error
loc_314A4:
    mov     [bp+arg_2], 0
    mov     [si+MEMCHUNK.resunk], 0
    cmp     si, resptr2
    jz      short loc_314CE
    mov     bx, resptr2
    mov     di, resendptr1
    cmp     si, di
    jz      short loc_31508
    mov     ax, [di+MEMCHUNK.resofs]
    sub     ax, [bx+MEMCHUNK.resofs]
    sub     ax, [bx+MEMCHUNK.ressize]
    cmp     ax, [si+MEMCHUNK.ressize]
    jb      short loc_31508
loc_314CE:
    mov     bx, [si+MEMCHUNK.ressize]
    push    bx
    mov     di, resendptr1
    mov     ax, [di+MEMCHUNK.resofs]
    sub     ax, bx
    push    ax
    mov     [bp+arg_2], ax
    push    [si+MEMCHUNK.resofs]
    sub     di, 12h
    mov     resendptr1, di
    mov     [di+MEMCHUNK.resofs], ax
    mov     [di+MEMCHUNK.ressize], bx
    mov     [di+MEMCHUNK.resunk], 1
    mov     cx, 0Ch
    xor     bx, bx
loc_314F9:
    mov     al, byte ptr [bx+si+MEMCHUNK.resname]
    mov     byte ptr [bx+di+MEMCHUNK.resname], al
    inc     bx
    loop    loc_314F9
    call    copy_paras_reverse
    add     sp, 6
loc_31508:
    cmp     si, resptr2
    jnz     short loc_3151B
loc_3150E:
    sub     si, 12h
    cmp     [si+MEMCHUNK.resunk], 0
    jz      short loc_3150E
    mov     resptr2, si
loc_3151B:
    mov     ax, [bp+arg_0]
    mov     dx, [bp+arg_2]
    pop     di
    pop     si
    pop     bp
    retf
mmgr_free endp
nopsub_31525 proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    si
    push    di
    mov     ax, [bp+arg_2]
    mov     si, resptr2
loc_31534:
    cmp     si, resptr1
    jz      short loc_31544
    cmp     ax, [si+0Eh]
    jz      short loc_31547
    sub     si, 12h
    jmp     short loc_31534
loc_31544:
    jmp     loc_31498
loc_31547:
    mov     [bp+arg_2], 0
    mov     word ptr [si+10h], 0
    cmp     si, resptr2
    jz      short loc_31570
    mov     bx, resptr2
    mov     di, resendptr2
    mov     ax, [di+0Eh]
    sub     ax, [bx+0Eh]
    sub     ax, [bx+0Ch]
    cmp     ax, [si+0Ch]
    ja      short loc_31570
    jmp     loc_31622
loc_31570:
    mov     di, resptr2
    mov     ax, [di+0Eh]
    add     ax, [di+0Ch]
    mov     [bp+var_2], ax
    mov     [bp+var_4], 0
    mov     di, resendptr1
loc_31586:
    cmp     di, resendptr2
    jz      short loc_315E9
    mov     ax, [di+0Eh]
    sub     ax, [si+0Ch]
    cmp     [bp+var_2], ax
    ja      short loc_315E4
    mov     bx, di
    sub     bx, 12h
    cmp     bx, resptr2
    jz      short loc_315E4
    cmp     [bp+var_4], 0
    jnz     short loc_315B1
    mov     resendptr1, bx
    mov     [bp+var_4], 1
loc_315B1:
    mov     ax, [di+10h]
    mov     [bx+10h], ax
    mov     ax, [di+0Ch]
    mov     [bx+0Ch], ax
    push    ax
    mov     ax, [di+0Eh]
    sub     ax, [si+0Ch]
    mov     [bx+0Eh], ax
    push    ax
    push    word ptr [di+0Eh]
    mov     cx, 0Ch
loc_315CE:
    mov     al, [di]
    mov     [bx], al
    inc     bx
    inc     di
    loop    loc_315CE
    sub     di, 0Ch
    sub     bx, 0Ch
    call    mmgr_copy_paras
    add     sp, 6
loc_315E4:
    add     di, 12h
    jmp     short loc_31586
loc_315E9:
    mov     ax, [di+0Eh]
    sub     di, 12h
    cmp     [bp+var_4], 0
    jnz     short loc_315F9
    mov     resendptr1, di
loc_315F9:
    mov     bx, [si+0Ch]
    mov     [di+0Ch], bx
    push    bx
    sub     ax, bx
    mov     [di+0Eh], ax
    push    ax
    push    word ptr [si+0Eh]
    mov     word ptr [di+10h], 1
    mov     cx, 0Ch
    xor     bx, bx
loc_31613:
    mov     al, [bx+si]
    mov     [bx+di], al
    inc     bx
    loop    loc_31613
    call    copy_paras_reverse
    add     sp, 6
loc_31622:
    cmp     si, resptr2
    jnz     short loc_31635
loc_31628:
    sub     si, 12h
    cmp     word ptr [si+10h], 0
    jz      short loc_31628
    mov     resptr2, si
loc_31635:
    mov     ax, [bp+arg_0]
    mov     dx, [bp+arg_2]
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
nopsub_31525 endp
mmgr_release proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_2]
    mov     si, resptr2
loc_3164D:
    cmp     si, resptr1
    jz      short loc_3165D
    cmp     ax, [si+MEMCHUNK.resofs]
    jz      short loc_31660
    sub     si, 12h
    jmp     short loc_3164D
loc_3165D:
    jmp     loc_31498
loc_31660:
    mov     [si+MEMCHUNK.resunk], 0
    cmp     si, resptr2
    jnz     short loc_31678
loc_3166B:
    sub     si, 12h
    cmp     [si+MEMCHUNK.resunk], 0
    jz      short loc_3166B
    mov     resptr2, si
loc_31678:
    pop     di
    pop     si
    pop     bp
    retf
mmgr_release endp
mmgr_get_chunk_size proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_2]
    mov     si, resptr2
loc_31688:
    cmp     si, resptr1
    jz      short loc_31698
    cmp     ax, [si+MEMCHUNK.resofs]
    jz      short loc_3169B
    sub     si, 12h
    jmp     short loc_31688
loc_31698:
    jmp     loc_31498
loc_3169B:
    mov     ax, [si+MEMCHUNK.ressize]
    pop     di
    pop     si
    pop     bp
    retf
mmgr_get_chunk_size endp
mmgr_resize_memory proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_2]
    mov     si, resptr2
loc_316AE:
    cmp     si, resptr1
    jz      short loc_316BE
    cmp     ax, [si+MEMCHUNK.resofs]
    jz      short loc_316C1
    sub     si, 12h
    jmp     short loc_316AE
loc_316BE:
    jmp     loc_31498
loc_316C1:
    mov     ax, [bp+arg_4]
    cmp     ax, [si+MEMCHUNK.ressize]
    ja      short loc_316D0
    mov     [si+MEMCHUNK.ressize], ax
    pop     di
    pop     si
    pop     bp
    retf
loc_316D0:
    cmp     si, resptr2
    jnz     short loc_316F4
    mov     [si+MEMCHUNK.ressize], ax
    mov     di, resendptr1
    add     ax, [si+MEMCHUNK.resofs]
    cmp     ax, resmaxsize
    jb      short loc_316E9
    mov     resmaxsize, ax
loc_316E9:
    cmp     ax, [di+MEMCHUNK.resofs]
    ja      short loc_316FD
loc_316EE:
    xor     ax, ax
    pop     di
    pop     si
    pop     bp
    retf
loc_316F4:
    mov     ax, offset aResizememoryCa; "resizememory - CANNOT EXPAND BLOCK NOT "...
    push    ax
    call    far ptr fatal_error
loc_316FD:
    mov     si, resendptr1
    mov     di, resptr2
    mov     ax, [di+MEMCHUNK.resofs]
    add     ax, [di+MEMCHUNK.ressize]
loc_3170B:
    cmp     ax, [si+MEMCHUNK.resofs]
    jbe     short loc_316EE
    cmp     si, resendptr2
    jz      short loc_31724
    mov     [si+MEMCHUNK.resunk], 0
    add     si, 12h
    mov     resendptr1, si
    jmp     short loc_3170B
loc_31724:
    mov     bx, resmaxsize
    push    bx
    mov     ax, offset aResizememoryNo; "resizememory - NO MEMORY LEFT TO EXPAND"...
    push    ax
    call    far ptr fatal_error
mmgr_resize_memory endp
mmgr_op_unk proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_2]
    mov     si, resptr2
loc_3173E:
    cmp     si, resptr1
    jz      short loc_3174E
    cmp     ax, [si+MEMCHUNK.resofs]
    jz      short loc_31751
    sub     si, 12h
    jmp     short loc_3173E
loc_3174E:
    jmp     loc_31498
loc_31751:
    mov     di, si
    sub     di, 12h
    cmp     [di+MEMCHUNK.resunk], 0
    jnz     short loc_317AD
loc_3175C:
    sub     di, 12h
    cmp     [di+MEMCHUNK.resunk], 0
    jz      short loc_3175C
    mov     [si+MEMCHUNK.resunk], 0
    mov     bx, [si+MEMCHUNK.ressize]
    push    bx
    mov     ax, [di+MEMCHUNK.resofs]
    add     ax, [di+MEMCHUNK.ressize]
    push    ax
    push    [si+MEMCHUNK.resofs]
    add     di, 12h
    cmp     si, resptr2
    jnz     short loc_31785
    mov     resptr2, di
loc_31785:
    mov     [di+MEMCHUNK.resofs], ax
    mov     [di+MEMCHUNK.ressize], bx
    mov     [di+MEMCHUNK.resunk], 2
    mov     cx, 0Ch
    xor     bx, bx
loc_31795:
    mov     al, byte ptr [bx+si+MEMCHUNK.resname]
    mov     byte ptr [bx+di+MEMCHUNK.resname], al
    inc     bx
    loop    loc_31795
    call    mmgr_copy_paras
    add     sp, 6
loc_317A4:
    mov     dx, [di+MEMCHUNK.resofs]
    xor     ax, ax
    pop     di
    pop     si
    pop     bp
    retf
loc_317AD:
    mov     di, si
    jmp     short loc_317A4
    ; align 2
    db 0
mmgr_op_unk endp
preRender_default proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     [bp+var_A], 1
    jmp     short loc_317CE
preRender_default endp
preRender_default_alt proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2
    arg_6 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     [bp+var_A], 0
loc_317CE:
    mov     ax, offset draw_filled_lines
    mov     spritefunc, ax
    mov     ax, offset preRender_line
    mov     imagefunc, ax
    mov     si, [bp+arg_6]
    jmp     short loc_3180A
preRender_default_alt endp
skybox_op_helper proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     [bp+var_A], 1
    jmp     short loc_317FB
skybox_op_helper endp
preRender_wheel_helper4 proc far
    var_7D0 = word ptr -2000
    var_798 = word ptr -1944
    var_3D8 = word ptr -984
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_vertlineptr = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_color = word ptr 6
    arg_vertlinecount = word ptr 8
    arg_vertlines = byte ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     [bp+var_A], 0
loc_317FB:
    mov     ax, offset draw_filled_lines
    mov     spritefunc, ax
    mov     ax, offset preRender_line
    mov     imagefunc, ax
    lea     si, [bp+arg_vertlines]
loc_3180A:
    mov     [bp+var_vertlineptr], si
    mov     cx, [bp+arg_vertlinecount]
    mov     ax, cx
    dec     ax
    shl     ax, 1
    shl     ax, 1
    add     ax, si
    mov     [bp+var_8], ax
    cld
    mov     ax, ss
    mov     es, ax
    lea     ax, [bp+var_798]
    mov     [bp+var_18], ax
    mov     ax, cs:sprite1.sprite_left2
    mov     [bp+var_2], ax
    mov     ax, cs:sprite1.sprite_widthsum
    dec     ax
    mov     [bp+var_4], ax
    mov     ax, [si+2]
    mov     [bp+var_E], ax
    mov     [bp+var_12], ax
    mov     bx, [si]
    mov     dx, bx
    mov     [bp+var_10], si
    mov     [bp+var_14], si
    add     si, 4
    dec     cx
    jnz     short loc_3186D
    push    [bp+arg_color]
    mov     si, [bp+var_vertlineptr]
    push    word ptr [si+2]
    push    word ptr [si]
    push    word ptr [si+2]
    push    word ptr [si]
    call    dword ptr imagefunc
    add     sp, 0Ah
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_3186D:
    mov     ax, [si+2]
    cmp     ax, [bp+var_E]
    jg      short loc_3187B
    mov     [bp+var_E], ax
    mov     [bp+var_10], si
loc_3187B:
    cmp     ax, [bp+var_12]
    jle     short loc_31886
    mov     [bp+var_12], ax
    mov     [bp+var_14], si
loc_31886:
    mov     ax, [si]
    cmp     ax, bx
    jge     short loc_3188E
    mov     bx, ax
loc_3188E:
    cmp     ax, dx
    jle     short loc_31894
    mov     dx, ax
loc_31894:
    add     si, 4
    loop    loc_3186D
    cmp     dx, [bp+var_2]
    jl      short loc_318F0
    cmp     bx, [bp+var_4]
    jge     short loc_318F0
    mov     ax, [bp+var_12]
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_318F0
    mov     cx, [bp+var_E]
    cmp     cx, cs:sprite1.sprite_height
    jge     short loc_318F0
    mov     [bp+var_C], 0
    cmp     dx, [bp+var_4]
    jg      short loc_318D3
    cmp     bx, [bp+var_2]
    jl      short loc_318D3
    cmp     ax, cs:sprite1.sprite_height
    jge     short loc_318D3
    cmp     cx, cs:sprite1.sprite_top
    jge     short loc_318D7
loc_318D3:
    mov     [bp+var_C], 1
loc_318D7:
    cmp     ax, cx
    jz      short loc_318DF
    cmp     dx, bx
    jnz     short loc_318F6
loc_318DF:
    push    [bp+arg_color]
    mov     si, [bp+var_vertlineptr]
    push    ax
    push    dx
    push    cx
    push    bx
    call    dword ptr imagefunc
    add     sp, 0Ah
loc_318F0:
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_318F6:
    lea     si, [bp+var_7D0]
    mov     di, [bp+var_10]
loc_318FD:
    mov     ax, [di+2]
    mov     cx, [di]
    add     di, 4
    cmp     di, [bp+var_8]
    jbe     short loc_3190D
    mov     di, [bp+var_vertlineptr]
loc_3190D:
    mov     dx, [di+2]
    cmp     dx, ax
    jle     short loc_3193F
    push    si
    push    dx
    push    word ptr [di]
    push    ax
    push    cx
    cmp     [bp+var_C], 0
    jz      short loc_3192E
    call    draw_line_related
    mov     [bp+var_16], di
    call near ptr preRender_helper
    jmp     short loc_31939
    ; align 2
    db 144
loc_3192E:
    call    draw_line_related_alt
    mov     [bp+var_16], di
    call near ptr preRender_helper2
loc_31939:
    mov     di, [bp+var_16]
    add     sp, 0Ah
loc_3193F:
    cmp     di, [bp+var_14]
    jnz     short loc_318FD
    mov     di, [bp+var_10]
loc_31947:
    mov     ax, [di+2]
    mov     cx, [di]
    sub     di, 4
    cmp     di, [bp+var_vertlineptr]
    jnb     short loc_31957
    mov     di, [bp+var_8]
loc_31957:
    mov     dx, [di+2]
    cmp     dx, ax
    jle     short loc_31983
    push    si
    push    dx
    push    word ptr [di]
    push    ax
    push    cx
    cmp     [bp+var_C], 0
    jz      short loc_31972
    call    draw_line_related
    jmp     short loc_31977
    ; align 2
    db 144
loc_31972:
    call    draw_line_related_alt
loc_31977:
    mov     [bp+var_16], di
    call near ptr preRender_helper3
    mov     di, [bp+var_16]
    add     sp, 0Ah
loc_31983:
    cmp     di, [bp+var_14]
    jnz     short loc_31947
    mov     ax, [bp+var_12]
    cmp     ax, cs:sprite1.sprite_height
    jl      short loc_31997
    mov     ax, cs:sprite1.sprite_height
    dec     ax
loc_31997:
    mov     bx, [bp+var_E]
    cmp     bx, cs:sprite1.sprite_top
    jge     short loc_319A6
    mov     bx, cs:sprite1.sprite_top
loc_319A6:
    sub     ax, bx
    jle     short loc_319C7
    inc     ax
    push    [bp+arg_color]
    push    ax
    push    bx
    shl     bx, 1
    lea     ax, [bp+var_3D8]
    add     ax, bx
    push    ax
    lea     ax, [bp+var_798]
    add     ax, bx
    push    ax
    call    dword ptr spritefunc
    add     sp, 0Ah
loc_319C7:
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
preRender_wheel_helper4 endp
preRender_helper proc near
    var_18 = word ptr -24
     s = byte ptr 0
     r = byte ptr 2

    mov     cx, [si+14h]
    or      cx, cx
    jle     short loc_319F9
    mov     di, [si+6]
    mov     dx, [si+4]
    add     dx, 8000h
    adc     di, 0
    sub     di, cx
    shl     di, 1
    add     di, [bp+var_18]
    mov     ax, cs:sprite1.sprite_left2
    push    cx
    push    di
    rep stosw
    pop     di
    pop     cx
    add     di, 3C0h
    dec     ax
    rep stosw
loc_319F9:
    mov     cx, [si+18h]
    or      cx, cx
    jle     short loc_31A25
    mov     di, [si+6]
    mov     dx, [si+4]
    add     dx, 8000h
    adc     di, 0
    sub     di, cx
    shl     di, 1
    add     di, [bp+var_18]
    mov     ax, cs:sprite1.sprite_widthsum
    push    cx
    push    di
    rep stosw
    pop     di
    pop     cx
    add     di, 3C0h
    dec     ax
    rep stosw
loc_31A25:
    mov     cx, [si+16h]
    or      cx, cx
    jle     short loc_31A46
    mov     di, [si+0Ah]
    inc     di
    shl     di, 1
    add     di, [bp+var_18]
    mov     ax, cs:sprite1.sprite_left2
    push    cx
    push    di
    rep stosw
    pop     di
    pop     cx
    add     di, 3C0h
    dec     ax
    rep stosw
loc_31A46:
    mov     cx, [si+1Ah]
    or      cx, cx
    jle     short preRender_helper2
    mov     di, [si+0Ah]
    inc     di
    shl     di, 1
    add     di, [bp+var_18]
    mov     ax, cs:sprite1.sprite_widthsum
    push    cx
    push    di
    rep stosw
    pop     di
    pop     cx
    add     di, 3C0h
    dec     ax
    rep stosw
preRender_helper endp
preRender_helper2 proc near
    var_18 = word ptr -24
     r = byte ptr 0

    mov     cx, [si+0Eh]
    or      cx, cx
    jle     short locret_31AA3
    mov     di, [si+6]
    shl     di, 1
    add     di, [bp+var_18]
    mov     bl, [si+12h]
    xor     bh, bh
    shl     bx, 1
    jmp     cs:off_31A82[bx]
off_31A82     dw offset locret_31AA3
    dw offset locret_31AA3
    dw offset loc_31A96
    dw offset loc_31AA4
    dw offset loc_31AB3
    dw offset loc_31AC2
    dw offset loc_31AE1
    dw offset loc_31B00
    dw offset loc_31B2C
    dw offset locret_31AA3
loc_31A96:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31A9C:
    mov     [di+3C0h], ax
    stosw
    loop    loc_31A9C
locret_31AA3:
    retn
loc_31AA4:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31AAA:
    mov     [di+3C0h], ax
    stosw
    dec     ax
    loop    loc_31AAA
    retn
loc_31AB3:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31AB9:
    mov     [di+3C0h], ax
    stosw
    inc     ax
    loop    loc_31AB9
    retn
loc_31AC2:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     dx, [si]
    add     dx, 8000h
    adc     ax, 0
    mov     bx, [si+0Ch]
loc_31AD4:
    mov     [di+3C0h], ax
    stosw
    sub     dx, bx
    sbb     ax, 0
    loop    loc_31AD4
    retn
loc_31AE1:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     dx, [si]
    add     dx, 8000h
    adc     ax, 0
    mov     bx, [si+0Ch]
loc_31AF3:
    mov     [di+3C0h], ax
    stosw
    add     dx, bx
    adc     ax, 0
    loop    loc_31AF3
    retn
loc_31B00:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     bx, [si+0Ch]
    mov     dx, [si+4]
    add     dx, 8000h
    jnb     short loc_31B15
    add     di, 2
loc_31B15:
    mov     [di+3C0h], ax
loc_31B19:
    add     dx, bx
    jnb     short loc_31B25
    stosw
    dec     ax
    loop    loc_31B15
    sub     di, 2
    retn
loc_31B25:
    dec     ax
    loop    loc_31B19
    inc     ax
    mov     [di], ax
    retn
loc_31B2C:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     bx, [si+0Ch]
    mov     dx, [si+4]
    add     dx, 8000h
    jnb     short loc_31B41
    add     di, 2
loc_31B41:
    mov     [di], ax
loc_31B43:
    add     dx, bx
    jnb     short loc_31B55
    mov     [di+3C0h], ax
    add     di, 2
    inc     ax
    loop    loc_31B41
    sub     di, 2
    retn
loc_31B55:
    inc     ax
    loop    loc_31B43
    dec     ax
    mov     [di+3C0h], ax
    retn
preRender_helper2 endp
preRender_helper3 proc near
    var_18 = word ptr -24
    var_C = byte ptr -12
    var_A = byte ptr -10
     r = byte ptr 0

    mov     cx, [si+0Eh]
    or      cx, cx
    jle     short loc_31BA8
    mov     di, [si+6]
    shl     di, 1
    add     di, [bp+var_18]
    mov     bl, [si+12h]
    xor     bh, bh
    shl     bx, 1
    cmp     [bp+var_A], 0   ; var_A is 1 when calling prerender_default, or 0 when calling prerender_default_alt
    jnz     short loc_31B7F
    jmp     cs:off_31CF7[bx]
loc_31B7F:
    jmp     cs:off_31B84[bx]
off_31B84     dw offset locret_31AA3
    dw offset locret_31AA3
    dw offset loc_31B98
    dw offset loc_31BB7
    dw offset loc_31BDB
    dw offset loc_31BFF
    dw offset loc_31C37
    dw offset loc_31C6F
    dw offset loc_31CB1
    dw offset locret_31AA3
loc_31B98:
    mov     ax, [si+2]
loc_31B9B:
    cmp     [di+3C0h], ax
    jl      short loc_31BAB
    cmp     [di], ax
    jle     short loc_31BAF
    stosw
    loop    loc_31B9B
loc_31BA8:
    jmp     loc_31EB9
loc_31BAB:
    mov     [di+3C0h], ax
loc_31BAF:
    add     di, 2
    loop    loc_31B9B
    jmp     loc_31EB9
loc_31BB7:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31BBD:
    cmp     [di+3C0h], ax
    jl      short loc_31BCE
    cmp     [di], ax
    jle     short loc_31BD2
    stosw
    dec     ax
    loop    loc_31BBD
    jmp     loc_31EB9
loc_31BCE:
    mov     [di+3C0h], ax
loc_31BD2:
    add     di, 2
    dec     ax
    loop    loc_31BBD
    jmp     loc_31EB9
loc_31BDB:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31BE1:
    cmp     [di+3C0h], ax
    jl      short loc_31BF2
    cmp     [di], ax
    jle     short loc_31BF6
    stosw
    inc     ax
    loop    loc_31BE1
    jmp     loc_31EB9
loc_31BF2:
    mov     [di+3C0h], ax
loc_31BF6:
    add     di, 2
    inc     ax
    loop    loc_31BE1
    jmp     loc_31EB9
loc_31BFF:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     dx, [si]
    add     dx, 8000h
    adc     ax, 0
    mov     bx, [si+0Ch]
loc_31C11:
    cmp     [di+3C0h], ax
    jl      short loc_31C26
    cmp     [di], ax
    jle     short loc_31C2A
    stosw
    sub     dx, bx
    sbb     ax, 0
    loop    loc_31C11
    jmp     loc_31EB9
loc_31C26:
    mov     [di+3C0h], ax
loc_31C2A:
    add     di, 2
    sub     dx, bx
    sbb     ax, 0
    loop    loc_31C11
    jmp     loc_31EB9
loc_31C37:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     dx, [si]
    add     dx, 8000h
    adc     ax, 0
    mov     bx, [si+0Ch]
loc_31C49:
    cmp     [di+3C0h], ax
    jl      short loc_31C5E
    cmp     [di], ax
    jle     short loc_31C62
    stosw
    add     dx, bx
    adc     ax, 0
    loop    loc_31C49
    jmp     loc_31EB9
loc_31C5E:
    mov     [di+3C0h], ax
loc_31C62:
    add     di, 2
    add     dx, bx
    adc     ax, 0
    loop    loc_31C49
    jmp     loc_31EB9
loc_31C6F:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     bx, [si+0Ch]
    mov     dx, [si+4]
    add     dx, 8000h
    jnb     short loc_31C84
    add     di, 2
loc_31C84:
    cmp     [di+3C0h], ax
    jge     short loc_31C8E
    mov     [di+3C0h], ax
loc_31C8E:
    add     dx, bx
    jnb     short loc_31CA4
    cmp     [di], ax
    jle     short loc_31C98
    mov     [di], ax
loc_31C98:
    add     di, 2
    dec     ax
    loop    loc_31C84
    sub     di, 2
    jmp     loc_31EB9
loc_31CA4:
    dec     ax
    loop    loc_31C8E
    inc     ax
    cmp     [di], ax
    jle     short loc_31CAE
    mov     [di], ax
loc_31CAE:
    jmp     loc_31EB9
loc_31CB1:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     bx, [si+0Ch]
    mov     dx, [si+4]
    add     dx, 8000h
    jnb     short loc_31CC6
    add     di, 2
loc_31CC6:
    cmp     [di], ax
    jle     short loc_31CCC
    mov     [di], ax
loc_31CCC:
    add     dx, bx
    jnb     short loc_31CE6
    cmp     [di+3C0h], ax
    jge     short loc_31CDA
    mov     [di+3C0h], ax
loc_31CDA:
    add     di, 2
    inc     ax
    loop    loc_31CC6
    sub     di, 2
    jmp     loc_31EB9
loc_31CE6:
    inc     ax
    loop    loc_31CCC
    dec     ax
    cmp     [di+3C0h], ax
    jge     short loc_31CAE
    mov     [di+3C0h], ax
    jmp     loc_31EB9
off_31CF7     dw offset locret_31AA3
    dw offset locret_31AA3
    dw offset loc_31D0B
    dw offset loc_31D31
    dw offset loc_31D5C
    dw offset loc_31D87
    dw offset loc_31DCA
    dw offset loc_31E0D
    dw offset loc_31E61
    dw offset locret_31AA3
loc_31D0B:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31D11:
    cmp     [di], ax
    jg      short loc_31D23
    cmp     [di+3C0h], ax
    jl      short loc_31D28
    add     di, 2
    loop    loc_31D11
    jmp     loc_31EB9
loc_31D23:
    rep stosw
    jmp     loc_31EB9
loc_31D28:
    add     di, 3C0h
    rep stosw
    jmp     loc_31EB9
loc_31D31:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31D37:
    cmp     [di], ax
    jg      short loc_31D4A
    cmp     [di+3C0h], ax
    jl      short loc_31D51
    add     di, 2
    dec     ax
    loop    loc_31D37
    jmp     loc_31EB9
loc_31D4A:
    stosw
    dec     ax
    loop    loc_31D4A
    jmp     loc_31EB9
loc_31D51:
    add     di, 3C0h
loc_31D55:
    stosw
    dec     ax
    loop    loc_31D55
    jmp     loc_31EB9
loc_31D5C:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
loc_31D62:
    cmp     [di], ax
    jg      short loc_31D75
    cmp     [di+3C0h], ax
    jl      short loc_31D7C
    add     di, 2
    inc     ax
    loop    loc_31D62
    jmp     loc_31EB9
loc_31D75:
    stosw
    inc     ax
    loop    loc_31D75
    jmp     loc_31EB9
loc_31D7C:
    add     di, 3C0h
loc_31D80:
    stosw
    inc     ax
    loop    loc_31D80
    jmp     loc_31EB9
loc_31D87:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     dx, [si]
    add     dx, 8000h
    adc     ax, 0
    mov     bx, [si+0Ch]
loc_31D99:
    cmp     [di], ax
    jg      short loc_31DB0
    cmp     [di+3C0h], ax
    jl      short loc_31DBB
    add     di, 2
    sub     dx, bx
    sbb     ax, 0
    loop    loc_31D99
    jmp     loc_31EB9
loc_31DB0:
    stosw
    sub     dx, bx
    sbb     ax, 0
    loop    loc_31DB0
    jmp     loc_31EB9
loc_31DBB:
    add     di, 3C0h
loc_31DBF:
    stosw
    sub     dx, bx
    sbb     ax, 0
    loop    loc_31DBF
    jmp     loc_31EB9
loc_31DCA:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     dx, [si]
    add     dx, 8000h
    adc     ax, 0
    mov     bx, [si+0Ch]
loc_31DDC:
    cmp     [di], ax
    jg      short loc_31DF3
    cmp     [di+3C0h], ax
    jl      short loc_31DFE
    add     di, 2
    add     dx, bx
    adc     ax, 0
    loop    loc_31DDC
    jmp     loc_31EB9
loc_31DF3:
    stosw
    add     dx, bx
    adc     ax, 0
    loop    loc_31DF3
    jmp     loc_31EB9
loc_31DFE:
    add     di, 3C0h
loc_31E02:
    stosw
    add     dx, bx
    adc     ax, 0
    loop    loc_31E02
    jmp     loc_31EB9
loc_31E0D:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     bx, [si+0Ch]
    mov     dx, [si+4]
    add     dx, 8000h
    jnb     short loc_31E22
    add     di, 2
loc_31E22:
    cmp     [di+3C0h], ax
    jl      short loc_31E39
    add     dx, bx
    jnb     short loc_31E33
    cmp     [di], ax
    jg      short loc_31E51
    add     di, 2
loc_31E33:
    dec     ax
    loop    loc_31E22
    jmp     loc_31EB9
loc_31E39:
    add     di, 3C0h
loc_31E3D:
    stosw
loc_31E3E:
    dec     ax
    add     dx, bx
    jnb     short loc_31E48
    loop    loc_31E3D
    jmp     short loc_31EB9
    ; align 2
    db 144
loc_31E48:
    loop    loc_31E3E
    jmp     short loc_31EB9
    db 144
loc_31E4D:
    add     dx, bx
    jnb     short loc_31E58
loc_31E51:
    stosw
    dec     ax
    loop    loc_31E4D
    jmp     short loc_31EB9
    ; align 2
    db 144
loc_31E58:
    dec     ax
    loop    loc_31E4D
    inc     ax
    mov     [di], ax
    jmp     short loc_31EB9
    db 144
loc_31E61:
    mov     cx, [si+0Eh]
    mov     ax, [si+2]
    mov     bx, [si+0Ch]
    mov     dx, [si+4]
    add     dx, 8000h
    jnb     short loc_31E76
    add     di, 2
loc_31E76:
    cmp     [di], ax
    jg      short loc_31EB2
    add     dx, bx
    jnb     short loc_31E87
    cmp     [di+3C0h], ax
    jl      short loc_31E8D
    add     di, 2
loc_31E87:
    inc     ax
    loop    loc_31E76
    jmp     short loc_31EB9
    db 144
loc_31E8D:
    add     di, 3C0h
loc_31E91:
    mov     [di], ax
loc_31E93:
    inc     ax
    add     dx, bx
    jnb     short loc_31EA3
    add     di, 2
    loop    loc_31E91
    dec     ax
    mov     [di], ax
    jmp     short loc_31EB9
    db 144
loc_31EA3:
    loop    loc_31E93
    add     di, 2
    dec     ax
    mov     [di], ax
    jmp     short loc_31EB9
    ; align 2
    db 144
loc_31EAE:
    add     dx, bx
    jnb     short loc_31EB3
loc_31EB2:
    stosw
loc_31EB3:
    inc     ax
    loop    loc_31EAE
    jmp     short loc_31EB9
    db 144
loc_31EB9:
    cmp     [bp+var_C], 0
    jnz     short loc_31EC0
    retn
loc_31EC0:
    mov     cx, [si+14h]
    or      cx, cx
    jle     short loc_31EE1
    mov     di, [si+6]
    mov     dx, [si+4]
    add     dx, 8000h
    adc     di, 0
    sub     di, cx
    shl     di, 1
    add     di, [bp+var_18]
    mov     ax, cs:sprite1.sprite_left2
    rep stosw
loc_31EE1:
    mov     cx, [si+18h]
    or      cx, cx
    jle     short loc_31F07
    mov     di, [si+6]
    mov     dx, [si+4]
    add     dx, 8000h
    adc     di, 0
    sub     di, cx
    shl     di, 1
    add     di, [bp+var_18]
    add     di, 3C0h
    mov     ax, cs:sprite1.sprite_widthsum
    dec     ax
    rep stosw
loc_31F07:
    mov     cx, [si+16h]
    or      cx, cx
    jle     short loc_31F1D
    mov     di, [si+0Ah]
    inc     di
    shl     di, 1
    add     di, [bp+var_18]
    mov     ax, cs:sprite1.sprite_left2
    rep stosw
loc_31F1D:
    mov     cx, [si+1Ah]
    or      cx, cx
    jle     short locret_31F38
    mov     di, [si+0Ah]
    inc     di
    shl     di, 1
    add     di, [bp+var_18]
    add     di, 3C0h
    mov     ax, cs:sprite1.sprite_widthsum
    dec     ax
    rep stosw
locret_31F38:
    retn
preRender_helper3 endp
nopsub_31F39 proc far
    var_7D0 = word ptr -2000
    var_798 = byte ptr -1944
    var_3D8 = byte ptr -984
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = byte ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     [bp+var_A], 1
    mov     ax, offset draw_filled_lines
    mov     spritefunc, ax
    mov     ax, 49A0h
    mov     imagefunc, ax
    jmp     short loc_31F6E
    db 144
nopsub_31F39 endp
nopsub_31F55 proc near
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     [bp+var_A], 0
    mov     ax, offset draw_filled_lines
    mov     spritefunc, ax
    mov     ax, 49A0h
    mov     imagefunc, ax
    var_7D0 = word ptr -2000
    var_798 = byte ptr -1944
    var_3D8 = byte ptr -984
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = byte ptr 10
loc_31F6E:
    lea     si, [bp+arg_4]
    mov     [bp+var_6], si
    mov     cx, [bp+arg_2]
    mov     ax, cx
    dec     ax
    shl     ax, 1
    add     ax, si
    mov     [bp+var_8], ax
    cld
    mov     ax, ss
    mov     es, ax
    lea     ax, [bp+var_798]
    mov     [bp+var_18], ax
    mov     ax, cs:sprite1.sprite_left2
    mov     [bp+var_2], ax
    mov     ax, cs:sprite1.sprite_widthsum
    dec     ax
    mov     [bp+var_4], ax
    mov     di, [si]
    mov     ax, [di+6]
    sub     ax, [di+14h]
    sub     ax, [di+18h]
    mov     [bp+var_E], ax
    mov     ax, [di+0Ah]
    add     ax, [di+16h]
    add     ax, [di+1Ah]
    mov     [bp+var_12], ax
    mov     [bp+var_7D0], 3
    mov     bx, [di+2]
    mov     dx, [di+8]
    cmp     bx, dx
    jle     short loc_31FC8
    xchg    bx, dx
loc_31FC8:
    mov     [bp+var_10], si
    mov     [bp+var_14], si
    add     si, 2
    dec     cx
    jnz     short loc_31FE8
    mov     ax, [bp+arg_0]
    mov     [bp+di+arg_0], ax
    push    di
    call    dword ptr imagefunc
    add     sp, 2
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_31FE8:
    mov     di, [si]
    mov     ax, [di+6]
    sub     ax, [di+14h]
    sub     ax, [di+18h]
    cmp     ax, [bp+var_E]
    jg      short loc_32010
    jnz     short loc_32002
    test    [bp+var_7D0], 1
    jz      short loc_32015
loc_32002:
    mov     [bp+var_E], ax
    mov     [bp+var_10], si
smart
    or      [bp+var_7D0], 1
nosmart
    jmp     short loc_32015
    ; align 2
    db 144
    var_7D0 = word ptr -2000
    var_798 = byte ptr -1944
    var_3D8 = byte ptr -984
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = byte ptr 10
loc_32010:
smart
smart
    and     [bp+var_7D0], 2
nosmart
loc_32015:
    mov     ax, [di+0Ah]
    add     ax, [di+16h]
    add     ax, [di+1Ah]
    cmp     ax, [bp+var_12]
    jl      short loc_3203B
    jnz     short loc_3202D
loc_32025:
    test    [bp+var_7D0], 2
    jnz     short loc_32040
loc_3202D:
    mov     [bp+var_12], ax
    mov     [bp+var_14], si
smart
    or      [bp+var_7D0], 2
nosmart
    jmp     short loc_32040
    db 144
    var_7D0 = word ptr -2000
    var_798 = byte ptr -1944
    var_3D8 = byte ptr -984
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = byte ptr 10
loc_3203B:
smart
smart
    and     [bp+var_7D0], 1
nosmart
loc_32040:
    mov     ax, [di+2]
    cmp     ax, bx
    jge     short loc_32049
    mov     bx, ax
loc_32049:
    cmp     ax, dx
    jle     short loc_3204F
    mov     dx, ax
loc_3204F:
    mov     ax, [di+8]
    cmp     ax, bx
    jge     short loc_32058
    mov     bx, ax
loc_32058:
    cmp     ax, dx
    jle     short loc_3205E
    mov     dx, ax
loc_3205E:
    add     si, 2
    loop    loc_31FE8
    cmp     dx, [bp+var_2]
    jl      short loc_320B6
    cmp     bx, [bp+var_4]
    jge     short loc_320B6
    mov     ax, [bp+var_12]
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_320B6
    mov     cx, [bp+var_E]
    cmp     cx, cs:sprite1.sprite_height
    jge     short loc_320B6
    mov     [bp+var_C], 0
    cmp     dx, [bp+var_4]
    jg      short loc_3209D
    cmp     bx, [bp+var_2]
    jl      short loc_3209D
    cmp     ax, cs:sprite1.sprite_height
    jge     short loc_3209D
    cmp     cx, cs:sprite1.sprite_top
    jge     short loc_320A1
loc_3209D:
    mov     [bp+var_C], 1
loc_320A1:
    cmp     ax, cx
    jz      short loc_320A9
    cmp     dx, bx
    jnz     short loc_320BC
loc_320A9:
    mov     si, [bp+var_6]
    mov     di, [si]
    push    di
    call    dword ptr imagefunc
    add     sp, 2
loc_320B6:
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_320BC:
    mov     di, [bp+var_10]
loc_320BF:
    mov     si, [di]
    cmp     byte ptr [si+12h], 2
    jl      short loc_320DC
    mov     [bp+var_16], di
    cmp     [bp+var_C], 0
    jz      short loc_320D6
    call near ptr preRender_helper
    jmp     short loc_320D9
    ; align 2
    db 144
    var_7D0 = word ptr -2000
    var_798 = byte ptr -1944
    var_3D8 = byte ptr -984
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = byte ptr -12
    var_A = byte ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = byte ptr 10
loc_320D6:
    call near ptr preRender_helper2
loc_320D9:
    mov     di, [bp+var_16]
loc_320DC:
    cmp     di, [bp+var_14]
    jz      short loc_320EE
    add     di, 2
    cmp     di, [bp+var_8]
    jbe     short loc_320BF
    mov     di, [bp+var_6]
    jmp     short loc_320BF
loc_320EE:
    mov     di, [bp+var_10]
loc_320F1:
    sub     di, 2
    cmp     di, [bp+var_6]
    jnb     short loc_320FC
    mov     di, [bp+var_8]
loc_320FC:
    cmp     di, [bp+var_14]
    jz      short loc_32114
    mov     si, [di]
    cmp     byte ptr [si+12h], 2
    jl      short loc_320F1
    mov     [bp+var_16], di
    call near ptr preRender_helper3
    mov     di, [bp+var_16]
    jmp     short loc_320F1
loc_32114:
    mov     ax, [bp+var_12]
    cmp     ax, cs:sprite1.sprite_height
    jl      short loc_32123
    mov     ax, cs:sprite1.sprite_height
    dec     ax
loc_32123:
    mov     bx, [bp+var_E]
    cmp     bx, cs:sprite1.sprite_top
    jge     short loc_32132
    mov     bx, cs:sprite1.sprite_top
loc_32132:
    sub     ax, bx
    jle     short loc_32153
    inc     ax
    push    [bp+arg_0]
    push    ax
    push    bx
    shl     bx, 1
    lea     ax, [bp+var_3D8]
    add     ax, bx
    push    ax
    lea     ax, [bp+var_798]
    add     ax, bx
    push    ax
    call    dword ptr spritefunc
    add     sp, 0Ah
loc_32153:
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
nopsub_31F55 endp
nopsub_3215A proc far
     r = byte ptr 0

    push    di
    mov     ax, 0B000h
    mov     es, ax
    xor     di, di
    mov     cx, 7D0h
    xor     ax, ax
    cld
    rep stosw
    pop     di
    retf
nopsub_3215A endp
nopsub_3216C proc far
     r = byte ptr 0

    push    si
    push    di
    push    ds
    mov     al, byte_4032A
    mov     bl, 0A0h ; '†'
    mul     bl
    mov     si, ax
    mov     di, si
    add     si, 0A0h ; '†'
    mov     ax, 18h
    sub     al, byte_4032A
    mov     bl, 50h ; 'P'
    mul     bl
    mov     cx, ax
    mov     ax, es
    mov     ds, ax
    cld
    rep movsw
    xor     ax, ax
    mov     cx, 50h ; 'P'
    rep stosw
    pop     ds
    pop     di
    pop     si
    retf
nopsub_3216C endp
nopsub_3219D proc far

    pop     ax
    mov     word_40332, ax
    pop     ax
    mov     word_40334, ax
    mov     ax, 4BC6h
    push    ax              ; char *
    call    _sprintf
    add     sp, 2
    mov     byte_4032B, 1
    mov     ax, word_4032E
    mov     word_40330, ax
loc_321BC:
    mov     ax, word_40334
    push    ax
    mov     ax, word_40332
    push    ax
    push    si
    mov     ax, 0B000h
    mov     es, ax
    mov     si, 4BC6h
    mov     dh, byte_4032C
loc_321D1:
    mov     dl, [si]
    inc     si
    or      dl, dl
    jz      short loc_321FD
    cmp     dl, 20h ; ' '
    jl      short loc_3220C
    mov     bx, word_40330
    cmp     bx, 0FA0h
    jl      short loc_321F3
    call    nopsub_3216C
    mov     bx, 0F00h
    mov     word_40330, bx
loc_321F3:
    mov     es:[bx], dx
    add     word_40330, 2
    jmp     short loc_321D1
loc_321FD:
    cmp     byte_4032B, 0
    jz      short loc_3220A
    mov     ax, word_40330
    mov     word_4032E, ax
loc_3220A:
    pop     si
    retf
loc_3220C:
    cmp     dl, 0Ah
    jnz     short loc_3223A
    cmp     word_40330, 0F00h
    jle     short loc_32226
    call    nopsub_3216C
    mov     word_40330, 0F00h
    jmp     short loc_321D1
loc_32226:
    mov     ax, word_40330
    mov     bx, 0A0h ; '†'
    div     bl
    xor     ah, ah
    mul     bl
    add     ax, 0A0h ; '†'
    mov     word_40330, ax
    jmp     short loc_321D1
loc_3223A:
    cmp     dl, 8
    jnz     short loc_3224D
    cmp     word_40330, 0
    jz      short loc_321D1
    sub     word_40330, 2
    jmp     short loc_321D1
loc_3224D:
    cmp     dl, 0Ch
    jnz     short loc_32260
    call    nopsub_3215A
    mov     word_40330, 0
    jmp     loc_321D1
loc_32260:
    cmp     dl, 9
    jnz     short loc_3226F
    add     word_40330, 10h
smart
    and     word_40330, 0FFF0h
nosmart
loc_3226F:
    jmp     loc_321D1
    pop     ax
    mov     word_40332, ax
    pop     ax
    mov     word_40334, ax
    pop     dx
    pop     ax
    mov     bx, 0A0h ; '†'
    mul     bl
    add     ax, dx
    mov     word_40330, ax
    mov     ax, 4BC6h
    push    ax              ; char *
    call    _sprintf
    sub     sp, 2
    mov     byte_4032B, 0
    jmp     loc_321BC
    push    bp
    mov     bp, sp
    mov     ax, [bp+6]
    cmp     ax, 0
    jge     short loc_322A7
    xor     ax, ax
loc_322A7:
    cmp     ax, 18h
    jle     short loc_322AF
    mov     ax, 18h
loc_322AF:
    mov     byte_4032A, al
    pop     bp
    retf
nopsub_3219D endp
nopsub_322B4 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     byte_4032C, al
    pop     bp
    retf
    ; align 2
    db 0
nopsub_322B4 endp
nopsub_322C0 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     projectiondata4, ax
    add     ax, projectiondata3
    mov     projectiondata5, ax
    mov     ax, [bp+arg_2]
    mov     projectiondata7, ax
    add     ax, projectiondata6
    mov     projectiondata8, ax
    pop     bp
    retf
nopsub_322C0 endp
nopsub_322DF proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_0]
    mov     projectiondata1, ax
    mov     ax, [bp+arg_2]
    mov     projectiondata2, ax
    jmp     short loc_32334
    db 144
nopsub_322DF endp
set_projection proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_0]
    xor     dh, dh
    mov     dl, ah
    mov     ah, al
    xor     al, al
    mov     cx, 3
loc_32306:
    shl     ax, 1
    rcl     dx, 1
    loop    loc_32306
    mov     cx, 168h
    div     cx
    shr     ax, 1
    mov     projectiondata1, ax
    mov     ax, [bp+arg_2]
    xor     dh, dh
    mov     dl, ah
    mov     ah, al
    xor     al, al
    mov     cx, 3
loc_32324:
    shl     ax, 1
    rcl     dx, 1
    loop    loc_32324
    mov     cx, 168h
    div     cx
    shr     ax, 1
    mov     projectiondata2, ax
loc_32334:
    mov     ax, [bp+arg_4]
    shr     ax, 1
    mov     projectiondata3, ax
    add     ax, projectiondata4
    mov     projectiondata5, ax
    mov     ax, [bp+arg_6]
    shr     ax, 1
    mov     projectiondata6, ax
    add     ax, projectiondata7
    mov     projectiondata8, ax
    push    projectiondata1
    call    cos_fast
    add     sp, 2
    mul     projectiondata3
    mov     si, ax
    mov     di, dx
    push    projectiondata1
    call    sin_fast
    add     sp, 2
    mov     cx, ax
    mov     dx, di
    mov     ax, si
    div     cx
    mov     projectiondata9, ax
    mov     bx, projectiondata2
    or      bx, bx
    jz      short loc_323B4
    push    projectiondata2
    call    cos_fast
    add     sp, 2
    mul     projectiondata6
    mov     si, ax
    mov     di, dx
    push    projectiondata2
    call    sin_fast
    add     sp, 2
    mov     cx, ax
    mov     dx, di
    mov     ax, si
    div     cx
    mov     projectiondata10, ax
    pop     di
    pop     si
    pop     bp
    retf
loc_323B4:
    mov     bx, ax
    shr     bx, 1
    shr     bx, 1
    shr     bx, 1
    sub     ax, bx
    shr     bx, 1
    sub     ax, bx
    mov     projectiondata10, ax
    push    projectiondata6
    push    ax
    call    polarAngle
    add     sp, 4
    mov     projectiondata2, ax
    pop     di
    pop     si
    pop     bp
    retf
set_projection endp
vector_to_point proc far
    var_8000 = byte ptr -32768
     s = byte ptr 0
     r = byte ptr 2
    arg_vec = word ptr 6
    arg_point2dout = word ptr 8

    push    bp
    mov     bp, sp
    push    di
    push    si
    mov     si, [bp+arg_vec]
    mov     di, [bp+arg_point2dout]
    mov     cx, [si+VECTOR.vz]
    or      cx, cx
    jle     short loc_32431
    mov     ax, [si+VECTOR.vx]
    or      ax, ax
    jl      short loc_3240F
    mul     projectiondata9
    mov     bx, dx
    shl     bx, 1
    or      ax, ax
    jge     short loc_323FE
    inc     bx
loc_323FE:
    cmp     cx, bx
    jle     short loc_32440
    div     cx
    add     ax, projectiondata5
    jo      short loc_3243C
    mov     [di], ax
    jmp     short loc_3244D
    db 144
loc_3240F:
    neg     ax
    mul     projectiondata9
    mov     bx, dx
    shl     bx, 1
    or      ax, ax
    jge     short loc_3241E
    inc     bx
loc_3241E:
    cmp     cx, bx
    jle     short loc_32448
    div     cx
    neg     ax
    add     ax, projectiondata5
    jo      short loc_3243C
    mov     [di], ax
    jmp     short loc_3244D
    db 144
loc_32431:
    mov     ax, 32768
    mov     [di], ax
    mov     [di+2], ax
    jmp     short loc_32472
    ; align 2
    db 144
loc_3243C:
    or      ax, ax
    jge     short loc_32448
loc_32440:
    mov     ax, 7D00h
    mov     [di], ax
    jmp     short loc_3244D
    ; align 2
    db 144
loc_32448:
    mov     ax, 8300h
    mov     [di], ax
loc_3244D:
    mov     ax, [si+VECTOR.vy]
    or      ax, ax
    jl      short loc_32476
    mul     projectiondata10
    mov     bx, dx
    shl     bx, 1
    or      ax, ax
    jge     short loc_32461
    inc     bx
loc_32461:
    cmp     cx, bx
    jle     short loc_3249A
    div     cx
    neg     ax
    add     ax, projectiondata8
    jo      short loc_32496
    mov     [di+2], ax
loc_32472:
    pop     si
    pop     di
    pop     bp
    retf
loc_32476:
    neg     ax
    mul     projectiondata10
    mov     bx, dx
    shl     bx, 1
    or      ax, ax
    jge     short loc_32485
    inc     bx
loc_32485:
    cmp     cx, bx
    jle     short loc_324A2
    div     cx
    add     ax, projectiondata8
    jo      short loc_32496
    mov     [di+2], ax
    jmp     short loc_32472
loc_32496:
    or      ax, ax
    jl      short loc_324A2
loc_3249A:
    mov     ax, -7D00h
    mov     [di+2], ax
    jmp     short loc_32472
loc_324A2:
    mov     ax, 7D00h
    mov     [di+2], ax
    jmp     short loc_32472
vector_to_point endp
sprite_free_wnd proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    mov     es, [bp+arg_2]
    mov     di, [bp+arg_0]
    mov     ds, word ptr es:[di+(SPRITE.sprite_bitmapptr+2)]
    mov     si, word ptr es:[di+SPRITE.sprite_bitmapptr]
    mov     ax, [si+SHAPE2D.s2d_height]
    add     ax, 0Fh
    shl     ax, 1
    mov     dx, ax
    add     dx, di
    mov     bx, cs:next_wnd_def
    cmp     bx, dx
    jnz     short loc_324EC
    sub     bx, ax
    mov     cs:next_wnd_def, bx
    push    ds
    push    si
    mov     ax, ss
    mov     ds, ax
    call    mmgr_release
    add     sp, 4
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
loc_324EC:
    mov     ax, ss
    mov     ds, ax
    lea     ax, aWindowReleased; "Window Released Out of Order\r\n"
    push    ax
    call    far ptr fatal_error
sprite_free_wnd endp
file_write_nofatal proc far
    var_fatal = word ptr -4
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    ds
    push    si
    push    di
    mov     [bp+var_fatal], 0
    jmp     short _file_write
    db 144
file_write_nofatal endp
file_write_fatal proc far
    var_errno = word ptr -6
    var_fatal = word ptr -4
    var_filehandle = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_filename = word ptr 6
    arg_srcoff = word ptr 8
    arg_srcseg = word ptr 10
    arg_lenl = word ptr 12
    arg_lenh = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    ds
    push    si
    push    di
    mov     [bp+var_fatal], 1
_file_write:
    mov     dx, [bp+arg_filename]
    xor     cx, cx
    mov     ah, 3Ch
    int     21h             ; DOS - 2+ - CREATE A FILE WITH HANDLE (CREAT)
    jb      short loc_32570
    mov     [bp+var_filehandle], ax
loc_32527:
    cmp     [bp+arg_lenl], 0
    jnz     short loc_32533
    cmp     [bp+arg_lenh], 0
    jz      short loc_3259E
loc_32533:
    mov     cx, 4000h
    mov     ax, [bp+arg_lenl]
    sub     [bp+arg_lenl], cx
    sbb     [bp+arg_lenh], 0
    jnb     short loc_32553
    mov     cx, [bp+arg_lenl]
    mov     [bp+arg_lenl], 0
    mov     [bp+arg_lenh], 0
    add     cx, 4000h
loc_32553:
    mov     ds, [bp+arg_srcseg]
    mov     dx, [bp+arg_srcoff]
    mov     bx, [bp+var_filehandle]
    mov     ah, 40h
    int     21h             ; DOS - 2+ - WRITE TO FILE WITH HANDLE
    jb      short loc_32570
    cmp     ax, cx
    jnz     short loc_3256D
    add     [bp+arg_srcseg], 400h
    jmp     short loc_32527
loc_3256D:
    mov     ax, 1
loc_32570:
    mov     [bp+var_errno], ax
    mov     bx, [bp+var_filehandle]
    mov     ah, 3Eh
    int     21h             ; DOS - 2+ - CLOSE A FILE WITH HANDLE
    mov     ax, ss
    mov     ds, ax
    mov     dx, [bp+arg_filename]
    mov     ah, 41h
    int     21h             ; DOS - 2+ - DELETE A FILE (UNLINK)
    mov     ax, [bp+var_errno]
    cmp     [bp+var_fatal], 0
    jnz     short loc_325A7
    mov     ax, ss
    mov     ds, ax
    mov     ax, offset aSFileError_0; "%s FILE ERROR\r"
    push    [bp+arg_filename]
    push    ax
    call    far ptr fatal_error
loc_3259E:
    mov     bx, [bp+var_filehandle]
    mov     ah, 3Eh
    int     21h             ; DOS - 2+ - CLOSE A FILE WITH HANDLE
    xor     ax, ax
loc_325A7:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
file_write_fatal endp
video_add_exithandler proc far

    cmp     currentvideomode, 0
    jnz     short locret_325D5
    mov     ah, 0Fh
    int     10h             ; - VIDEO - GET CURRENT VIDEO MODE
    mov     currentvideomode, al
    mov     ax, 40h ; '@'
    mov     es, ax
    mov     al, es:10h
    mov     byte_403F3, al
    push    cs
    mov     ax, offset video_on_exit
    push    ax
    call    add_exit_handler
    add     sp, 4
locret_325D5:
    retf
video_add_exithandler endp
video_on_exit proc far

    mov     ax, 40h ; '@'
    mov     es, ax
    mov     al, byte_403F3
    mov     es:10h, al
    mov     ah, 0
    mov     al, currentvideomode
    int     10h             ; - VIDEO - SET VIDEO MODE
    mov     ax, 40h ; '@'
    mov     es, ax
    mov     al, byte_403F3
    mov     es:10h, al
smart
    and     al, 30h
nosmart
    cmp     al, 30h ; '0'
    jnz     short loc_32606
    xor     ax, ax
    push    ax
    call    video_clear_color
    add     sp, 2
loc_32606:
    mov     ah, 0Bh
    mov     bx, 0
    int     10h             ; - VIDEO - 
    retf
video_on_exit endp
sprite_copy_both_to_arg proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    ds
    push    di
    push    si
    lea     si, sprite1
    mov     di, [bp+arg_0]
    mov     ax, ds
    mov     es, ax
    mov     ax, cs
    mov     ds, ax
    cld
    mov     cx, 1Eh
    rep movsw
    pop     si
    pop     di
    pop     ds
    pop     bp
    retf
sprite_copy_both_to_arg endp
sprite_copy_arg_to_both proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    ds
    push    di
    push    si
    mov     si, [bp+arg_0]
    mov     ax, cs
    mov     es, ax
    lea     di, sprite1
    cld
    mov     cx, 1Eh
    rep movsw
    pop     si
    pop     di
    pop     ds
    pop     bp
    retf
sprite_copy_arg_to_both endp
file_get_res_shape_count proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    mov     es, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, es:[si+4]
    pop     si
    pop     bp
    retf
file_get_res_shape_count endp
file_get_shape2d proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    mov     es, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, es:[si+4]   ; number of objects in resource file
    shl     ax, 1
    shl     ax, 1
    mov     bx, [bp+arg_4]  ; index
    shl     bx, 1
    shl     bx, 1
    add     bx, ax          ; bx = index<<2 + count<<2
    add     bx, 6           ; bx += 6
    shl     ax, 1           ; ax = index<<2 << 1
    add     ax, 6           ; ax += 6
    mov     cx, es
    xor     dx, dx
    shl     cx, 1
    rcl     dx, 1
    shl     cx, 1
    rcl     dx, 1
    shl     cx, 1
    rcl     dx, 1
    shl     cx, 1
    rcl     dx, 1
    add     ax, cx
    adc     dx, 0
    add     ax, es:[bx]
    adc     dx, es:[bx+2]
    mov     bx, ax
smart
    and     bx, 0Fh
nosmart
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    shr     dx, 1
    rcr     ax, 1
    mov     dx, ax
    mov     ax, bx
    pop     si
    pop     bp
    retf
file_get_shape2d endp
nopsub_326BA proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    push    si
    mov     es, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     bx, [bp+arg_4]
    shl     bx, 1
    shl     bx, 1
    mov     ax, es:[bx+si+6]
    mov     dx, es:[bx+si+8]
    mov     si, [bp+arg_6]
    mov     [si], ax
    mov     [si+2], dx
    pop     si
    pop     bp
    retf
nopsub_326BA endp
sin_fast proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
code_sin_fast_main:
    mov     bl, ah
    xor     ah, ah
smart
    and     bx, 3           ; constrain angles to [0, 2pi]
nosmart
    shl     bx, 1
    jmp     cs:off_326F2[bx]
off_326F2     dw offset loc_326FA
    dw offset loc_32704
    dw offset loc_32711
    dw offset loc_3271D
loc_326FA:
    mov     bx, ax
    shl     bx, 1
    mov     ax, sinetable[bx]
    pop     bp
    retf
loc_32704:
    mov     bx, 100h
    sub     bx, ax
    shl     bx, 1
    mov     ax, sinetable[bx]
    pop     bp
    retf
loc_32711:
    mov     bx, ax
    shl     bx, 1
    mov     ax, sinetable[bx]
    neg     ax
    pop     bp
    retf
loc_3271D:
    mov     bx, 100h
    sub     bx, ax
    shl     bx, 1
    mov     ax, sinetable[bx]
    neg     ax
    pop     bp
    retf
sin_fast endp
cos_fast proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    add     ax, 100h
    jmp     short code_sin_fast_main
    ; align 2
    db 0
cos_fast endp
nopsub_32738 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     dx, [bp+arg_2]
    mov     ax, [bp+arg_0]
    div     [bp+arg_4]
    pop     bp
    retf
nopsub_32738 endp
nopsub_32746 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, projectiondata9
    mul     [bp+arg_0]
    pop     bp
    retf
nopsub_32746 endp
nopsub_32751 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    mov     ax, projectiondata10
    mul     [bp+arg_0]
    pop     bp
    retf
nopsub_32751 endp
transformed_shape_op_helper2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, projectiondata9
    mul     [bp+arg_0]
    div     [bp+arg_2]
    pop     bp
    retf
transformed_shape_op_helper2 endp
nopsub_3276A proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, projectiondata10
    mul     [bp+arg_0]
    div     [bp+arg_2]
    pop     bp
    retf
nopsub_3276A endp
timer_get_counter proc far

    cli
    mov     ax, word ptr timer_callback_counter
    mov     dx, word ptr timer_callback_counter+2
    sti
    retf
timer_get_counter endp
timer_custom_delta proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_ticksl = word ptr 6
    arg_ticksh = word ptr 8

    push    bp
    mov     bp, sp
    mov     bx, [bp+arg_ticksl]
    mov     cx, [bp+arg_ticksh]
    cli
    mov     ax, word ptr timer_callback_counter
    mov     dx, word ptr timer_callback_counter+2
    sti
    sub     ax, bx
    sbb     dx, cx
    pop     bp
    retf
timer_custom_delta endp
timer_get_delta proc far

    mov     bx, word ptr last_timer_callback_counter
    mov     cx, word ptr last_timer_callback_counter+2
    cli
    mov     ax, word ptr timer_callback_counter
    mov     dx, word ptr timer_callback_counter+2
    sti
    mov     word ptr last_timer_callback_counter, ax
    mov     word ptr last_timer_callback_counter+2, dx
    sub     ax, bx
    sbb     dx, cx
    retf
timer_get_delta endp
timer_reset proc far

    xor     ax, ax
    mov     word ptr timer_callback_counter, ax
    mov     word ptr timer_callback_counter+2, ax
    retf
timer_reset endp
timer_copy_counter proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_ticksl = word ptr 6
    arg_ticksh = word ptr 8

    push    bp
    mov     bp, sp
    call    timer_get_counter
    add     ax, [bp+arg_ticksl]
    adc     dx, [bp+arg_ticksh]
    mov     word ptr timer_copy_unk, ax
    mov     word ptr timer_copy_unk+2, dx
    pop     bp
    retf
timer_copy_counter endp
timer_wait_for_dx proc far

    call    timer_get_counter
    cmp     dx, word ptr timer_copy_unk+2
    jb      short near ptr timer_wait_for_dx
    ja      short locret_327EA
    cmp     ax, word ptr timer_copy_unk
    jb      short near ptr timer_wait_for_dx
locret_327EA:
    retf
timer_wait_for_dx endp
timer_compare_dx proc far

    call    timer_get_counter
    cmp     dx, word ptr timer_copy_unk+2
    jb      short loc_32802
    ja      short loc_327FE
    cmp     ax, word ptr timer_copy_unk
    jb      short loc_32802
loc_327FE:
    mov     ax, 1
    retf
loc_32802:
    xor     ax, ax
    retf
timer_compare_dx endp
timer_get_counter_unk proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 4
    call    timer_get_counter
    add     ax, [bp+arg_0]
    adc     dx, [bp+arg_2]
    mov     [bp+var_4], ax
    mov     [bp+var_2], dx
loc_3281C:
    call    timer_get_counter
    cmp     dx, [bp+var_2]
    jb      short loc_3281C
    ja      short loc_3282D
    cmp     ax, [bp+var_4]
    jb      short loc_3281C
loc_3282D:
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
timer_get_counter_unk endp
font_op proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_4 = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     dx, [bp+arg_4]
    or      dx, dx
    jnz     short loc_3284A
    xor     ax, ax
    jmp     short loc_32882
    db 144
font_op endp
font_op2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    xor     dx, dx
loc_3284A:
    mov     es, fontdefseg
    mov     si, [bp+arg_0]
    xor     ax, ax
    mov     cl, es:14h
    mov     di, es:10h
loc_3285D:
    mov     bl, [si]
    or      bl, bl
    jz      short loc_32882
    inc     si
    xor     bh, bh
    shl     bx, 1
    mov     bx, es:[bx+16h]
    or      bx, bx
    jz      short loc_3285D
    or      cl, cl
    jz      short loc_3287B
    mov     bl, es:[bx]
    xor     bh, bh
    mov     di, bx
loc_3287B:
    add     ax, di
    dec     dx
    jz      short loc_32882
    jmp     short loc_3285D
loc_32882:
    pop     di
    pop     si
    pop     bp
    retf
font_op2 endp
preRender_patterned proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     si, [bp+arg_6]
    mov     [bp+var_A], 1
    jmp     short loc_328A8
    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    mov     si, [bp+arg_6]
    mov     [bp+var_A], 0
loc_328A8:
    mov     ax, [bp+arg_0]
    mov     word_4031E, ax
    mov     ax, [bp+arg_2]
    mov     [bp+arg_0], ax
    mov     ax, [bp+arg_4]
    mov     [bp+arg_2], ax
    mov     ax, offset draw_patterned_lines
    mov     spritefunc, ax
    mov     ax, offset preRender_line
    mov     imagefunc, ax
    jmp     loc_3180A
preRender_patterned endp
nopsub_328C9 proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2
    arg_6 = byte ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    lea     si, [bp+arg_6]
    mov     [bp+var_A], 1
    jmp     short loc_328A8
nopsub_328C9 endp
nopsub_328DB proc far
    var_A = byte ptr -10
     s = byte ptr 0
     r = byte ptr 2
    arg_6 = byte ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 7D0h
    push    si
    push    di
    lea     si, [bp+arg_6]
    mov     [bp+var_A], 0
    jmp     short loc_328A8
    ; align 2
    db 0
nopsub_328DB endp
mat_mul_vector proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_inpVector = word ptr 6
    arg_matrix = word ptr 8
    arg_outVector = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     bx, [bp+arg_matrix]
    mov     si, [bp+arg_inpVector]
    mov     di, [bp+arg_outVector]
    xor     dx, dx
    mov     ax, [bx+MATRIX._11]
    or      ax, ax
    jz      short loc_32914
    mov     cx, [si+VECTOR.vx]
    or      cx, cx
    jz      short loc_32914
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
loc_32914:
    mov     [di+VECTOR.vx], dx
    mov     ax, [bx+MATRIX._12]
    or      ax, ax
    jz      short loc_32930
    mov     cx, [si+VECTOR.vy]
    or      cx, cx
    jz      short loc_32930
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+VECTOR.vx], dx
loc_32930:
    mov     ax, [bx+MATRIX._13]
    or      ax, ax
    jz      short loc_3294A
    mov     cx, [si+VECTOR.vz]
    or      cx, cx
    jz      short loc_3294A
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+VECTOR.vx], dx
loc_3294A:
    xor     dx, dx
    mov     ax, [bx+MATRIX._21]
    or      ax, ax
    jz      short loc_32963
    mov     cx, [si+VECTOR.vx]
    or      cx, cx
    jz      short loc_32963
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
loc_32963:
    mov     [di+VECTOR.vy], dx
    mov     ax, [bx+MATRIX._22]
    or      ax, ax
    jz      short loc_32981
    mov     cx, [si+VECTOR.vy]
    or      cx, cx
    jz      short loc_32981
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+2], dx
loc_32981:
    mov     ax, [bx+MATRIX._23]
    or      ax, ax
    jz      short loc_3299C
    mov     cx, [si+VECTOR.vz]
    or      cx, cx
    jz      short loc_3299C
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+VECTOR.vy], dx
loc_3299C:
    xor     dx, dx
    mov     ax, [bx+MATRIX._31]
    or      ax, ax
    jz      short loc_329B5
    mov     cx, [si+VECTOR.vx]
    or      cx, cx
    jz      short loc_329B5
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
loc_329B5:
    mov     [di+VECTOR.vz], dx
    mov     ax, [bx+MATRIX._32]
    or      ax, ax
    jz      short loc_329D3
    mov     cx, [si+VECTOR.vy]
    or      cx, cx
    jz      short loc_329D3
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+VECTOR.vz], dx
loc_329D3:
    mov     ax, [bx+MATRIX._33]
    or      ax, ax
    jz      short loc_329EE
    mov     cx, [si+VECTOR.vz]
    or      cx, cx
    jz      short loc_329EE
    imul    cx
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+VECTOR.vz], dx
loc_329EE:
    pop     di
    pop     si
    pop     bp
    retf
mat_mul_vector endp
mat_multiply proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_rightMatrix = word ptr 6
    arg_leftMatrix = word ptr 8
    arg_outputMatrix = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     si, [bp+arg_rightMatrix]
    mov     bx, [bp+arg_leftMatrix]
    mov     di, [bp+arg_outputMatrix]
    mov     cx, 9
loc_32A03:
    xor     dx, dx
    mov     ax, [si+MATRIX._11]
    or      ax, ax
    jz      short loc_32A1A
    cmp     [bx+MATRIX._11], 0
    jz      short loc_32A1A
    imul    [bx+MATRIX._11]
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
loc_32A1A:
    mov     [di+MATRIX._11], dx
    mov     ax, [si+MATRIX._21]
    or      ax, ax
    jz      short loc_32A36
    cmp     [bx+MATRIX._12], 0
    jz      short loc_32A36
    imul    [bx+MATRIX._12]
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+MATRIX._11], dx
loc_32A36:
    mov     ax, [si+MATRIX._31]
    or      ax, ax
    jz      short loc_32A50
    cmp     [bx+MATRIX._13], 0
    jz      short loc_32A50
    imul    [bx+MATRIX._13]
    shl     ax, 1
    rcl     dx, 1
    shl     ax, 1
    rcl     dx, 1
    add     [di+MATRIX._11], dx
loc_32A50:
    add     di, 2
    cmp     cx, 7
    jz      short loc_32A66
    cmp     cx, 4
    jz      short loc_32A66
    add     bx, 2
    loop    loc_32A03
    pop     di
    pop     si
    pop     bp
    retf
loc_32A66:
    sub     bx, 4
    add     si, 6
    loop    loc_32A03
    pop     di
    pop     si
    pop     bp
    retf
mat_multiply endp
mat_invert proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_mat_in = word ptr 6
    arg_mat_out = word ptr 8

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     si, [bp+arg_mat_in]
    mov     di, [bp+arg_mat_out]
    mov     cx, 9
    cmp     si, di
    jnz     short loc_32AA3
    mov     ax, [si+MATRIX._21]
    xchg    ax, [si+MATRIX._12]
    mov     [si+MATRIX._21], ax
    mov     ax, [si+MATRIX._31]
    xchg    ax, [si+MATRIX._13]
    mov     [si+MATRIX._31], ax
    mov     ax, [si+MATRIX._32]
    xchg    ax, [si+MATRIX._23]
    mov     [si+MATRIX._32], ax
    pop     di
    pop     si
    pop     bp
    retf
loc_32AA3:
    mov     ax, [si+MATRIX._11]
    mov     [di+MATRIX._11], ax
    mov     ax, [si+MATRIX._21]
    mov     [di+MATRIX._12], ax
    mov     ax, [si+MATRIX._31]
    mov     [di+MATRIX._13], ax
    mov     ax, [si+MATRIX._12]
    mov     [di+MATRIX._21], ax
    mov     ax, [si+MATRIX._22]
    mov     [di+MATRIX._22], ax
    mov     ax, [si+MATRIX._32]
    mov     [di+MATRIX._23], ax
    mov     ax, [si+MATRIX._13]
    mov     [di+MATRIX._31], ax
    mov     ax, [si+MATRIX._23]
    mov     [di+MATRIX._32], ax
    mov     ax, [si+MATRIX._33]
    mov     [di+MATRIX._33], ax
    pop     di
    pop     si
    pop     bp
    retf
    ; align 2
    db 0
fliphandlers     dw offset fliptype0
    dw offset fliptype1
    dw offset fliptype2
mat_invert endp
file_unflip_shape2d proc far
    var_height = word ptr -14
    var_width = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_numshapes = word ptr -6
    var_counter = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_memchunkofs = word ptr 6
    arg_memchunkseg = word ptr 8
    arg_mempagesofs = word ptr 10
    arg_mempagesseg = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    cld
    mov     ax, [bp+arg_memchunkseg]
    mov     ds, ax
    mov     ax, [bp+arg_memchunkofs]
    mov     si, ax
    mov     ax, [bp+arg_mempagesseg]
    mov     [bp+var_A], ax
    mov     ax, [bp+arg_mempagesofs]
    mov     [bp+var_8], ax
    mov     bx, [si+4]      ; number of shapes in binary
    mov     [bp+var_2], bx
    mov     [bp+var_counter], 0
loc_32B0D:
    push    [bp+var_counter]
    push    [bp+arg_memchunkseg]
    push    [bp+arg_memchunkofs]
    mov     ax, seg dseg
    mov     ds, ax
    call    file_get_shape2d; get shape in binary at index
    add     sp, 6
    mov     [bp+var_numshapes], ax
    mov     si, ax
    mov     ds, dx
    mov     di, [bp+var_8]
    mov     es, [bp+var_A]
    mov     al, [si+SHAPE2D.s2d_unk6]; unk6 = is flipped
smart
    and     al, 0F0h
nosmart
    jnz     short loc_32B4E
    mov     al, [si+SHAPE2D.s2d_unk5]; (unk4 >> 4) = fliptype, 1..3
    shr     al, 1
    shr     al, 1
    shr     al, 1
    shr     al, 1
    jz      short loc_32B4E
    cmp     al, 4
    jb      short loc_32B5F
    mov     ax, 1
    jmp     short loc_32B58
    ; align 2
    db 144
loc_32B4E:
    inc     [bp+var_counter]
    dec     [bp+var_2]
    jg      short loc_32B0D
    xor     ax, ax
loc_32B58:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_32B5F:
    mov     dx, [si+SHAPE2D.s2d_width]
    mov     [bp+var_width], dx
    mov     dx, [si+SHAPE2D.s2d_height]
    mov     [bp+var_height], dx
    xor     dx, dx
    xor     ah, ah
    mov     bx, ax
    dec     bx
    shl     bx, 1
    jmp     cs:fliphandlers[bx]; jump to flip type handler
fliptype0:
    mov     bx, si
    add     bx, 10h
    add     bx, dx
    mov     cx, [bp+var_width]
loc_32B82:
    mov     al, [bx]
    stosb
    add     bx, [bp+var_height]
    loop    loc_32B82
    inc     dx
    cmp     dx, [bp+var_height]
    jnz     short fliptype0
    jmp     loc_32C15
fliptype1:
    mov     bx, dx
    shr     bx, 1
    add     bx, 10h
    add     bx, si
    mov     cx, [bp+var_width]
loc_32B9F:
    mov     al, [bx]
    stosb
    add     bx, [bp+var_height]
    loop    loc_32B9F
    add     di, [bp+var_width]
    inc     dx
    inc     dx
    cmp     dx, [bp+var_height]
    jb      short fliptype1
    mov     dx, 1
    mov     di, [bp+var_8]
    add     di, [bp+var_width]
loc_32BBA:
    mov     bx, dx
    add     bx, [bp+var_height]
    shr     bx, 1
    add     bx, 10h
    add     bx, si
    mov     cx, [bp+var_width]
loc_32BC9:
    mov     al, [bx]
    stosb
    add     bx, [bp+var_height]
    loop    loc_32BC9
    add     di, [bp+var_width]
    inc     dx
    inc     dx
    cmp     dx, [bp+var_height]
    jb      short loc_32BBA
    jmp     short loc_32C15
    ; align 2
    db 144
fliptype2:
    mov     bx, dx
    shr     bx, 1
    add     bx, 10h
    add     bx, [bp+var_numshapes]
    mov     cx, [bp+var_width]
    mov     si, [bp+var_height]
    shr     si, 1
    adc     si, 0
loc_32BF3:
    mov     al, [bx]
    stosb
    add     bx, si
    loop    loc_32BF3
    inc     dx
    cmp     dx, [bp+var_height]
    jz      short loc_32C15
    mov     cx, [bp+var_width]
    mov     si, [bp+var_height]
    shr     si, 1
loc_32C08:
    mov     al, [bx]
    stosb
    add     bx, si
    loop    loc_32C08
    inc     dx
    cmp     dx, [bp+var_height]
    jnz     short fliptype2
loc_32C15:
    mov     di, [bp+var_numshapes]
    mov     ax, ds
    mov     es, ax
    add     di, 10h
    mov     si, [bp+var_8]
    mov     ds, [bp+var_A]
    mov     ax, [bp+var_width]
    mul     [bp+var_height]
    mov     cx, ax
    shr     cx, 1
    jb      short loc_32C36
    rep movsw
    jmp     loc_32B4E
loc_32C36:
    rep movsw
    movsb
    jmp     loc_32B4E
vle_esc1     dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
vle_esc2     db 0
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
file_unflip_shape2d endp
file_decomp_vle proc far
    var_lengths = byte ptr -528
    var_symbols = byte ptr -272
    var_codoff = word ptr -14
    var_codlen = word ptr -10
    var_lenhi = word ptr -8
    var_lenlo = word ptr -6
    var_lenlefthi = word ptr -4
    var_lenleftlo = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_srcoff = word ptr 6
    arg_srcseg = word ptr 8
    arg_dstoff = word ptr 10
    arg_dstseg = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    di
    push    si
    push    ds
    cld
    sub     sp, 200h
    mov     ds, [bp+arg_srcseg]
    mov     si, [bp+arg_srcoff]
    mov     ax, [si+1]
    mov     [bp+var_lenleftlo], ax
    mov     [bp+var_lenlo], ax
    mov     al, [si+3]
    xor     ah, ah
    mov     [bp+var_lenlefthi], ax
    mov     [bp+var_lenhi], ax
    mov     al, [si+4]
    xor     ah, ah
    mov     [bp+var_codlen], ax
smart
    and     ax, 7Fh
nosmart
    add     si, 5
    mov     [bp+var_codoff], si
    lea     cx, callbackflags2+72h
    shl     ax, 1
    mov     di, ax
    xor     bx, bx
    xor     dx, dx
gen_esc:
    mov     cs:vle_esc1[bx], cx
    shl     dx, 1
    sub     cs:vle_esc1[bx], dx
    lodsb
    xor     ah, ah
    add     dx, ax
    add     cx, ax
    or      ax, ax
    jz      short $+2
    mov     word ptr cs:vle_esc2[bx], dx
    add     bx, 2
    cmp     bx, di
    jl      short gen_esc
    sub     cx, 425Ch
    mov     ax, cs
    mov     es, ax
    mov     di, 425Ch
    rep movsb
    push    si
    mov     bx, [bp+var_codlen]
    mov     bh, bl
    cmp     bh, 8
    jle     short loc_32DFE
    mov     bh, 8
loc_32DFE:
    xor     si, si
    mov     bl, 1
    mov     cl, 80h ; 'Ä'
    mov     di, cs:vle_esc1
loc_32E09:
    xchg    si, [bp+var_codoff]
    lodsb
    xchg    si, [bp+var_codoff]
    mov     dh, al
    or      al, al
    jz      short loc_32E29
loc_32E16:
    mov     ch, cl
    mov     dl, cs:[di]
    inc     di
loc_32E1C:
    mov     [bp+si+var_symbols], dl
    mov     [bp+si+var_lengths], bl
    inc     si
    dec     ch
    jnz     short loc_32E1C
loc_32E29:
    dec     dh
    jg      short loc_32E16
    shr     cl, 1
    inc     bl
    cmp     bl, bh
    jle     short loc_32E09
pad_lens:
    mov     [bp+si+var_lengths], 40h ; '@'
    inc     si
    cmp     si, 100h
    jnz     short pad_lens
    pop     si
    mov     bx, si
    mov     es, [bp+arg_dstseg]
    mov     di, [bp+arg_dstoff]
    mov     dl, [bx]
    inc     bx
    mov     dh, [bx]
    inc     bx
    mov     ah, 8
    test    [bp+var_codlen], 80h
    jz      short loc_32E5C
    jmp     loc_32F27
loc_32E5C:
    mov     si, dx
smart
    and     si, 0FFh
nosmart
    mov     cl, [bp+si+var_lengths]
    cmp     cl, 8
    ja      short len_gt_8bit
    mov     al, [bp+si+var_symbols]
    stosb
    cmp     cl, ah
    jle     short loc_32E7F
    xchg    cl, ah
    rol     dx, cl
    xchg    cl, ah
    sub     cl, ah
    jmp     short loc_32EA0
    db 144
loc_32E7F:
    rol     dx, cl
    sub     ah, cl
    or      di, di
    jz      short loc_32E94
loc_32E87:
    dec     [bp+var_lenleftlo]
    jnz     short loc_32E5C
    dec     [bp+var_lenlefthi]
    jge     short loc_32E5C
    jmp     loc_32F16
loc_32E94:
    mov     di, es
    add     di, 1000h
    mov     es, di
    xor     di, di
    jmp     short loc_32E87
loc_32EA0:
    mov     dh, [bx]
    inc     bx
    jz      short loc_32EA9
loc_32EA5:
    mov     ah, 8
    jmp     short loc_32E7F
loc_32EA9:
    mov     bx, ds
    add     bx, 1000h
    mov     ds, bx
    xor     bx, bx
    jmp     short loc_32EA5
len_gt_8bit:
    push    si
    push    bp
    mov     si, bx
    mov     bp, 0Eh
    mov     bh, dh
    xor     dh, dh
    xor     ch, ch
loc_32EC2:
    cmp     ah, 0
    jz      short loc_32F01
loc_32EC7:
    cmp     ch, 0
    jz      short loc_32ED4
    mov     dh, bh
    mov     bx, si
    pop     bp
    pop     si
    jmp     short loc_32E7F
loc_32ED4:
    shl     bh, 1
    rcl     dx, 1
    sub     ah, 1
    add     bp, 2
    cmp     dx, word ptr cs:vle_esc2[bp]
    jnb     short loc_32EC2
    add     dx, cs:vle_esc1[bp]
    mov     bp, dx
    mov     al, cs:[bp+0]
    stosb
    mov     dh, bh
    mov     cl, ah
    rol     dx, cl
    mov     cl, 8
    sub     cl, ah
    mov     ah, 0
    mov     ch, 1
    jmp     short loc_32EC2
loc_32F01:
    mov     bh, [si]
    inc     si
    jz      short loc_32F0A
loc_32F06:
    mov     ah, 8
    jmp     short loc_32EC7
loc_32F0A:
    mov     si, ds
    add     si, 1000h
    mov     ds, si
    xor     si, si
    jmp     short loc_32F06
loc_32F16:
    mov     ax, [bp+var_lenlo]
    mov     dx, [bp+var_lenhi]
    add     sp, 200h
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_32F27:
    mov     si, dx
smart
    and     si, 0FFh
nosmart
    mov     cl, [bp+si+var_lengths]
    cmp     cl, 8
    ja      short loc_32F83
    mov     al, [bp+si+var_symbols]
    add     al, ch
    stosb
    cmp     cl, ah
    jle     short loc_32F4C
    xchg    cl, ah
    rol     dx, cl
    xchg    cl, ah
    sub     cl, ah
    jmp     short loc_32F6E
    ; align 2
    db 144
loc_32F4C:
    rol     dx, cl
    sub     ah, cl
    or      di, di
    jz      short loc_32F62
loc_32F54:
    mov     ch, al
    dec     [bp+var_lenleftlo]
    jnz     short loc_32F27
    dec     [bp+var_lenlefthi]
    jge     short loc_32F27
    jmp     short loc_32F16
loc_32F62:
    mov     di, es
    add     di, 1000h
    mov     es, di
    xor     di, di
    jmp     short loc_32F54
loc_32F6E:
    mov     dh, [bx]
    inc     bx
    jz      short loc_32F77
loc_32F73:
    mov     ah, 8
    jmp     short loc_32F4C
loc_32F77:
    mov     bx, ds
    add     bx, 1000h
    mov     ds, bx
    xor     bx, bx
    jmp     short loc_32F73
loc_32F83:
    push    si
    push    bp
    mov     si, bx
    mov     bp, 0Eh
    mov     bh, dh
    xor     dh, dh
    mov     [bp+var_codoff], 0
loc_32F93:
    cmp     ah, 0
    jz      short loc_32FD8
loc_32F98:
    cmp     [bp+var_codoff], 0
    jz      short loc_32FA6
    mov     dh, bh
    mov     bx, si
    pop     bp
    pop     si
    jmp     short loc_32F4C
loc_32FA6:
    shl     bh, 1
    rcl     dx, 1
    sub     ah, 1
    add     bp, 2
    cmp     dx, cs:[bp+423Ch]
    jnb     short loc_32F93
    add     dx, cs:[bp+421Ch]
    mov     bp, dx
    mov     al, cs:[bp+0]
    add     al, ch
    stosb
    mov     dh, bh
    mov     cl, ah
    rol     dx, cl
    mov     cl, 8
    sub     cl, ah
    mov     ah, 0
    mov     [bp+var_codoff], 1
    jmp     short loc_32F93
loc_32FD8:
    mov     bh, [si]
    inc     si
    jz      short loc_32FE1
loc_32FDD:
    mov     ah, 8
    jmp     short loc_32F98
loc_32FE1:
    mov     si, ds
    add     si, 1000h
    mov     ds, si
    xor     si, si
    jmp     short loc_32FDD
    ; align 2
    db 0
file_decomp_vle endp
nopsub_32FEE proc far

    mov     dx, 3DAh
loc_32FF1:
    in      al, dx          ; Video status bits:
    test    al, 8
    jnz     short loc_32FF1
loc_32FF6:
    in      al, dx          ; Video status bits:
    test    al, 8
    jz      short loc_32FF6
    retf
nopsub_32FEE endp
video_get_status proc far

    mov     dx, 3DAh
    in      al, dx          ; Video status bits:
smart
    and     al, 8
nosmart
    xor     ah, ah
    retf
    ; align 2
    db 0
video_get_status endp
nopsub_33006 proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    si
    push    di
    mov     ax, ds:4E92h
    jmp     short loc_3301F
    ; align 2
    db 144
nopsub_33006 endp
vector_op_unk proc far
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
    push    si
    push    di
    mov     ax, [bp+arg_6]
loc_3301F:
    mov     si, [bp+arg_0]
    mov     bx, [bp+arg_2]
    mov     di, [bp+arg_4]
    mov     [di+VECTOR.vz], ax
    sub     ax, [bx+VECTOR.vz]
    mov     [bp+var_4], ax
    mov     ax, [si+VECTOR.vz]
    sub     ax, [bx+VECTOR.vz]
    or      ax, ax
    jge     short loc_33040
    shr     [bp+var_4], 1
    shr     ax, 1
loc_33040:
    mov     [bp+var_2], ax
    mov     ax, [si+VECTOR.vx]
    sub     ax, [bx+VECTOR.vx]
    imul    [bp+var_4]
    idiv    [bp+var_2]
    add     ax, [bx+VECTOR.vx]
    mov     [di+VECTOR.vx], ax
    mov     ax, [si+VECTOR.vy]
    sub     ax, [bx+VECTOR.vy]
    imul    [bp+var_4]
    idiv    [bp+var_2]
    add     ax, [bx+VECTOR.vy]
    mov     [di+VECTOR.vy], ax
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
    push    bp
    mov     bp, sp
    mov     ax, [bp+6]
    mov     ds:4E92h, ax
vector_op_unk endp
preRender_sphere proc far
    var_79A = byte ptr -1946
    var_3DA = byte ptr -986
    var_1A = word ptr -26
    var_18 = word ptr -24
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
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
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 79Ah
    push    si
    push    di
    mov     dx, [bp+arg_4]
    mov     ax, dx
    shr     ax, 1
    shr     ax, 1
    sub     dx, ax
    shr     ax, 1
    shr     ax, 1
    add     dx, ax
    or      dx, dx
    jg      short loc_33096
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_33096:
    mov     [bp+var_6], dx
    mov     bx, dx
    shr     dx, 1
    jnz     short loc_330B6
    push    [bp+arg_6]
    push    [bp+arg_2]
    push    [bp+arg_0]
    call    putpixel_single_maybe
    add     sp, 6
loc_330B0:
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_330B6:
    sub     bx, dx
    mov     ax, cs:sprite1.sprite_left2
    mov     [bp+var_4], ax
    mov     ax, cs:sprite1.sprite_widthsum
    dec     ax
    mov     [bp+var_2], ax
    mov     cx, [bp+arg_2]
    mov     ax, cx
    sub     ax, dx
    cmp     ax, cs:sprite1.sprite_height
    jge     short loc_330B0
    mov     [bp+var_14], ax
    add     cx, bx
    cmp     cx, cs:sprite1.sprite_top
    jle     short loc_330B0
    mov     dx, bx
    mov     ax, dx
    shr     ax, 1
    shr     ax, 1
    add     dx, ax
    mov     cx, [bp+arg_0]
    mov     ax, cx
    sub     ax, dx
    cmp     ax, [bp+var_2]
    jg      short loc_330B0
    add     cx, dx
    cmp     cx, [bp+var_4]
    jl      short loc_330B0
    cmp     bx, ds:3C56h
    jl      short loc_33148
    mov     ax, [bp+arg_0]
    mov     [bp+var_12], ax
    mov     [bp+var_E], ax
    mov     dx, [bp+arg_4]
    shr     dx, 1
    add     ax, dx
    mov     [bp+var_A], ax
    mov     ax, [bp+arg_2]
    mov     [bp+var_10], ax
    mov     [bp+var_8], ax
    mov     dx, [bp+var_6]
    shr     dx, 1
    add     ax, dx
    mov     [bp+var_C], ax
    mov     dx, [bp+arg_6]
    lea     ax, [bp+var_12]
    add     sp, 780h
    push    dx
    push    ax
    call    preRender_sphere_helper
    add     sp, 4
    sub     sp, 780h
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_33148:
    shl     bx, 1
    mov     ax, ds:off_3F3C8[bx]
    mov     [bp+var_16], ax
    mov     ax, [bp+var_6]
    mov     [bp+var_1A], ax
    dec     ax
    shl     ax, 1
    mov     [bp+var_18], ax
    lea     si, [bp+var_3DA]
    lea     di, [bp+var_79A]
loc_33165:
    mov     bx, [bp+var_16]
    mov     dl, [bx]
    inc     [bp+var_16]
    xor     dh, dh
    mov     bx, [bp+var_18]
    mov     ax, [bp+arg_0]
    sub     ax, dx
    cmp     ax, [bp+var_2]
    jg      short loc_331AD
    cmp     ax, [bp+var_4]
    jge     short loc_33184
    mov     ax, [bp+var_4]
loc_33184:
    mov     [si], ax
    mov     [bx+si], ax
    mov     ax, [bp+arg_0]
    add     ax, dx
    cmp     ax, [bp+var_4]
    jl      short loc_331AD
    cmp     ax, [bp+var_2]
    jle     short loc_3319A
    mov     ax, [bp+var_2]
loc_3319A:
    mov     [di], ax
    mov     [bx+di], ax
    add     si, 2
    add     di, 2
    sub     [bp+var_18], 4
    jge     short loc_33165
    jmp     short loc_331C0
    db 144
loc_331AD:
    inc     [bp+var_14]
    sub     [bp+var_1A], 2
    sub     [bp+var_18], 4
    jge     short loc_33165
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_331C0:
    xor     dx, dx
    mov     ax, cs:sprite1.sprite_top
    sub     ax, [bp+var_14]
    jle     short loc_331D9
    sub     [bp+var_1A], ax
    shl     ax, 1
    mov     dx, ax
    mov     ax, cs:sprite1.sprite_top
    mov     [bp+var_14], ax
loc_331D9:
    mov     ax, [bp+var_14]
    add     ax, [bp+var_1A]
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_331E9
    sub     [bp+var_1A], ax
loc_331E9:
    push    [bp+arg_6]
    push    [bp+var_1A]
    push    [bp+var_14]
    lea     ax, [bp+var_79A]
    add     ax, dx
    push    ax
    lea     ax, [bp+var_3DA]
    add     ax, dx
    push    ax
    call    draw_filled_lines
    add     sp, 0Ah
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
preRender_sphere endp
nopsub_3320E proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14
    arg_A = word ptr 16

    push    bp
    mov     bp, sp
    push    ds
    push    si
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+2]
    cmp     word ptr cs:sprite1.sprite_bitmapptr+2, ax
    jnz     short loc_3325D
    mov     ax, [bp+arg_4]
    mov     [si+1Ah], ax
    mov     cs:sprite1.sprite_left2, ax
    mov     [si+0Ch], ax
    mov     cs:sprite1.sprite_left, ax
    mov     ax, [bp+arg_6]
    mov     [si+1Ch], ax
    mov     cs:sprite1.sprite_widthsum, ax
    mov     [si+0Eh], ax
    mov     cs:sprite1.sprite_right, ax
    mov     ax, [bp+arg_8]
    mov     [si+10h], ax
    mov     cs:sprite1.sprite_top, ax
    mov     ax, [bp+arg_A]
    mov     [si+12h], ax
    mov     cs:sprite1.sprite_height, ax
    pop     si
    pop     ds
    pop     bp
    retf
loc_3325D:
    mov     ax, [bp+arg_4]
    mov     [si+1Ah], ax
    mov     [si+0Ch], ax
    mov     ax, [bp+arg_6]
    mov     [si+1Ch], ax
    mov     [si+0Eh], ax
    mov     ax, [bp+arg_8]
    mov     [si+10h], ax
    mov     ax, [bp+arg_A]
    mov     [si+12h], ax
    pop     si
    pop     ds
    pop     bp
    retf
nopsub_3320E endp
sprite_set_1_size proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_0]
    mov     cs:sprite1.sprite_left2, ax
    mov     cs:sprite1.sprite_left, ax
    mov     ax, [bp+arg_2]
    mov     cs:sprite1.sprite_widthsum, ax
    mov     cs:sprite1.sprite_right, ax
    mov     ax, [bp+arg_4]
    mov     cs:sprite1.sprite_top, ax
    mov     ax, [bp+arg_6]
    mov     cs:sprite1.sprite_height, ax
    pop     bp
    retf
sprite_set_1_size endp
video_clear_color proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    di
    mov     ax, 0A000h
    mov     es, ax
    mov     ax, [bp+arg_0]
    mov     di, 0
    mov     cx, 0FA00h
    rep stosw
    pop     di
    pop     bp
    retf
    ; align 2
    db 0
video_clear_color endp
sprite_clear_1_color proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = byte ptr 6

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     dx, cs:sprite1.sprite_height
    mov     bx, cs:sprite1.sprite_top
    sub     dx, bx
    jle     short loc_3330D
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, cs:sprite1.sprite_left
    mov     bx, cs:sprite1.sprite_right
    sub     bx, cs:sprite1.sprite_left
    jle     short loc_3330D
    mov     si, cs:sprite1.sprite_pitch
    sub     si, bx
    mov     al, [bp+arg_0]
    mov     ah, al
    shr     bx, 1
    jb      short loc_33311
loc_33304:
    mov     cx, bx
    rep stosw
    add     di, si
    dec     dx
    jg      short loc_33304
loc_3330D:
    pop     di
    pop     si
    pop     bp
    retf
loc_33311:
    jz      short loc_33324
    jl      short loc_3330D
    inc     si
loc_33316:
    mov     cx, bx
    rep stosw
    mov     es:[di], al
    add     di, si
    dec     dx
    jg      short loc_33316
    jmp     short loc_3330D
loc_33324:
    inc     si
loc_33325:
    mov     es:[di], al
    add     di, si
    dec     dx
    jg      short loc_33325
    jmp     short loc_3330D
    ; align 2
    db 0
sprite_clear_1_color endp
nopsub_33330 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_A = word ptr 16
    arg_C = word ptr 18

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_C]
    mov     word_4031E, ax
    mov     ax, [bp+arg_A]
    mov     byte ptr word_40320, al
    jmp     short loc_33349
    ; align 2
    db 144
nopsub_33330 endp
draw_unknown_lines proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = byte ptr 14

    push    bp
    mov     bp, sp
    push    si
    push    di
loc_33349:
    cld
    mov     si, [bp+arg_4]
    test    si, 1
    jnz     short loc_3335B
    mov     ax, word_4031E
    xchg    ah, al
    mov     word_4031E, ax
loc_3335B:
    mov     si, [bp+arg_4]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     al, [bp+arg_8]
loc_3336E:
    mov     bx, [bp+arg_2]
    mov     dx, [bx]
    mov     bx, [bp+arg_0]
    mov     bx, [bx]
    mov     ah, byte ptr word_4031E
    mov     cl, bl
smart
    and     cl, 7
nosmart
    rol     ah, cl
    mov     cx, dx
    mov     dl, byte ptr word_40320
    sub     cx, bx
    inc     cx
    jle     short loc_3339A
    mov     di, cs:[si]
    add     di, bx
loc_33393:
    rol     ah, 1
    jb      short loc_333B8
    stosb
    loop    loc_33393
loc_3339A:
    add     [bp+arg_2], 2
    add     [bp+arg_0], 2
    add     si, 2
    mov     dx, word_4031E
    xchg    dh, dl
    mov     word_4031E, dx
    dec     [bp+arg_6]
    jg      short loc_3336E
    pop     di
    pop     si
    pop     bp
    retf
loc_333B8:
    mov     es:[di], dl
    inc     di
    loop    loc_33393
    jmp     short loc_3339A
draw_unknown_lines endp
putpixel_line1_maybe proc far
    var_E = byte ptr -14
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    si
    push    di
    mov     si, [bp+arg_0]
    mov     ax, [si]
    mov     dx, [si+2]
    add     ax, 8000h
    adc     dx, 0
    mov     [bp+var_2], ax
    mov     [bp+var_4], dx
    mov     ax, [si+4]
    mov     dx, [si+6]
    add     ax, 8000h
    adc     dx, 0
    mov     [bp+var_6], ax
    mov     [bp+var_8], dx
    mov     al, [si+10h]
    mov     [bp+var_E], al
    mov     ax, [si+0Ch]
    mov     [bp+var_A], ax
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     bx, [si+12h]
    shl     bx, 1
    jmp     cs:off_3340A[bx]
off_3340A     dw offset loc_3341E
    dw offset loc_3341E
    dw offset loc_33458
    dw offset loc_3347C
    dw offset loc_334A1
    dw offset loc_334C6
    dw offset loc_334F3
    dw offset loc_33520
    dw offset loc_3354C
    dw offset loc_3343C
loc_3341E:
    mov     cx, [si+0Eh]
    mov     al, [bp+var_E]
    mov     di, [bp+var_8]
    shl     di, 1
    add     di, cs:sprite1.sprite_lineofs
    mov     di, cs:[di]
    add     di, [bp+var_4]
    rep stosb
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_3343C:
    mov     al, [bp+var_E]
    mov     di, [bp+var_8]
    shl     di, 1
    add     di, cs:sprite1.sprite_lineofs
    mov     di, cs:[di]
    add     di, [bp+var_4]
    mov     es:[di], al
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_33458:
    mov     cx, [si+0Eh]
    mov     al, [bp+var_E]
    mov     bx, [bp+var_4]
    mov     si, [si+6]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
loc_3346B:
    mov     di, cs:[si]
    mov     es:[bx+di], al
    add     si, 2
    loop    loc_3346B
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_3347C:
    mov     cx, [si+0Eh]
    mov     al, [bp+var_E]
    mov     si, [si+6]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     bx, [bp+var_4]
loc_3348F:
    mov     di, cs:[si]
    mov     es:[bx+di], al
    dec     bx
    add     si, 2
    loop    loc_3348F
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_334A1:
    mov     cx, [si+0Eh]
    mov     al, [bp+var_E]
    mov     si, [si+6]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     bx, [bp+var_4]
loc_334B4:
    mov     di, cs:[si]
    mov     es:[bx+di], al
    inc     bx
    add     si, 2
    loop    loc_334B4
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_334C6:
    mov     cx, [si+0Eh]
    mov     dx, [bp+var_A]
    mov     al, [bp+var_E]
    mov     si, [si+6]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     bx, [bp+var_4]
loc_334DC:
    mov     di, cs:[si]
    mov     es:[bx+di], al
    add     si, 2
    sub     [bp+var_2], dx
    sbb     bx, 0
    loop    loc_334DC
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_334F3:
    mov     cx, [si+0Eh]
    mov     dx, [bp+var_A]
    mov     al, [bp+var_E]
    mov     si, [si+6]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     bx, [bp+var_4]
loc_33509:
    mov     di, cs:[si]
    mov     es:[bx+di], al
    add     si, 2
    add     [bp+var_2], dx
    adc     bx, 0
    loop    loc_33509
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_33520:
    mov     cx, [si+0Eh]
    mov     dx, [bp+var_A]
    mov     al, [bp+var_E]
    mov     bx, [bp+var_4]
loc_3352C:
    mov     si, [bp+var_8]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     di, cs:[si]
    mov     es:[bx+di], al
    dec     bx
    add     [bp+var_6], dx
    adc     [bp+var_8], 0
    loop    loc_3352C
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_3354C:
    mov     cx, [si+0Eh]
    mov     dx, [bp+var_A]
    mov     al, [bp+var_E]
    mov     bx, [bp+var_4]
loc_33558:
    mov     si, [bp+var_8]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     di, cs:[si]
    mov     es:[bx+di], al
    inc     bx
    add     [bp+var_6], dx
    adc     [bp+var_8], 0
    loop    loc_33558
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
putpixel_line1_maybe endp
sprite_1_unk2 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     dx, cs:sprite1.sprite_left
    mov     ax, dx
    sub     ax, [bp+arg_2]
    jle     short loc_33591
    mov     [bp+arg_2], dx
    sub     [bp+arg_6], ax
    jle     short loc_335CF
loc_33591:
    mov     ax, [bp+arg_2]
    add     ax, [bp+arg_6]
    sub     ax, cs:sprite1.sprite_right
    jle     short loc_335A3
    sub     [bp+arg_6], ax
    jle     short loc_335CF
loc_335A3:
    mov     ax, cs:sprite1.sprite_top
    sub     ax, [bp+arg_4]
    jle     short loc_335B8
    sub     [bp+arg_8], ax
    jle     short loc_335CF
    mov     ax, cs:sprite1.sprite_top
    mov     [bp+arg_4], ax
loc_335B8:
    mov     ax, [bp+arg_4]
    add     ax, [bp+arg_8]
    mov     bx, cs:sprite1.sprite_height
    sub     ax, bx
    jle     short loc_335D7
    sub     [bp+arg_8], ax
    jle     short loc_335CF
    jmp     short loc_335D7
    db 144
loc_335CF:
    jmp     short loc_33622
    ; align 2
    db 144
sprite_1_unk2 endp
sprite_1_unk proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = byte ptr 14

    push    bp
    mov     bp, sp
    push    si
    push    di
loc_335D7:
    cld
    cmp     [bp+arg_4], 0
    jle     short loc_335CF
    cmp     [bp+arg_6], 0
    jle     short loc_335CF
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     al, [bp+arg_8]
    mov     ah, al
    mov     dx, [bp+arg_0]
    mov     si, [bp+arg_6]
    mov     bx, [bp+arg_2]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+arg_0]
    mov     dx, cs:sprite1.sprite_pitch
    sub     dx, [bp+arg_4]
    mov     cx, [bp+arg_4]
    sar     cx, 1
    mov     [bp+arg_4], cx
    jb      short loc_33626
    jle     short loc_33622
loc_33618:
    mov     cx, [bp+arg_4]
    rep stosw
    add     di, dx
    dec     si
    jg      short loc_33618
loc_33622:
    pop     di
    pop     si
    pop     bp
    retf
loc_33626:
    jz      short loc_3363A
    jl      short loc_33622
    inc     dx
loc_3362B:
    mov     cx, [bp+arg_4]
    rep stosw
    mov     es:[di], al
    add     di, dx
    dec     si
    jg      short loc_3362B
    jmp     short loc_33622
loc_3363A:
    inc     dx
loc_3363B:
    mov     es:[di], al
    add     di, dx
    dec     si
    jg      short loc_3363B
    jmp     short loc_33622
    ; align 2
    db 0
byte_33646     db 11
    db 5
    db 8
    db 2
    db 10
    db 4
    db 7
    db 1
    db 9
    db 3
    db 6
    db 0
byte_33652     db 1
    db 3
    db 0
    db 2
byte_33656     db 3
    db 1
    db 4
    db 2
    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     ax, [bp+0Ch]
    mov     [bp-2], ax
    mov     ax, [bp+0Eh]
    jmp     short loc_33697
    ; align 2
    db 144
sprite_1_unk endp
sprite_1_unk3 proc far
    var_16 = word ptr -22
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
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
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
loc_33697:
    shl     ax, 1
    add     ax, cs:sprite1.sprite_lineofs
    mov     [bp+var_4], ax
    add     ax, [si+2]
    add     ax, [si+2]
    mov     [bp+var_6], ax
    mov     ax, [si]
    mov     [bp+var_8], ax
    mov     bx, 0Ch
    mul     bx
    mov     [bp+var_A], ax
    add     si, 10h
    mov     [bp+var_C], si
    mov     [bp+var_E], 0Bh
loc_336C2:
    mov     di, [bp+var_E]
    mov     cl, cs:byte_33646[di]
    xor     ch, ch
    mov     ax, [bp+var_8]
    mul     cx
    mov     [bp+var_10], ax
    shl     cx, 1
    add     cx, [bp+var_4]
    mov     [bp+var_12], cx
    mov     si, [bp+var_C]
    add     si, [bp+var_10]
    mov     bx, [bp+arg_4]
    mov     [bp+var_16], bx
loc_336E8:
    mov     di, [bp+var_12]
    cmp     di, [bp+var_6]
    jnb     short loc_33733
    mov     di, cs:[di]
    add     di, [bp+var_2]
    mov     cx, [bp+var_8]
    mov     [bp+var_14], si
    xor     ah, ah
    mov     bx, [bp+var_16]
loc_33701:
smart
    and     bx, 3
nosmart
    mov     al, cs:byte_33652[bx]
    sub     cx, ax
    jle     short loc_33724
    add     si, ax
    add     di, ax
    mov     al, [si]
    mov     es:[di], al
    mov     al, cs:byte_33656[bx]
    add     si, ax
    add     di, ax
    sub     cx, ax
    inc     bx
    jmp     short loc_33701
loc_33724:
    inc     [bp+var_16]
    add     [bp+var_12], 18h
    mov     si, [bp+var_14]
    add     si, [bp+var_A]
    jmp     short loc_336E8
loc_33733:
    inc     [bp+arg_4]
    dec     [bp+var_E]
    jge     short loc_336C2
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
sprite_1_unk3 endp
font_draw_text proc far
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
    push    ds
    push    si
    push    di
    mov     ds, fontdefseg
    mov     ax, [bp+arg_2]
    mov     ds:8, ax
    mov     ax, [bp+arg_4]
    mov     ds:0Ah, ax
    jmp     short loc_3376B
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 4
    push    ds
    push    si
    push    di
    mov     ds, fontdefseg
loc_3376B:
    cld
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
loc_33771:
    mov     si, [bp+arg_0]
    mov     bl, ss:[si]
    cmp     bl, 0
    jz      short loc_337A6
    mov     al, bl
    inc     [bp+arg_0]
    xor     bh, bh
    shl     bx, 1
    add     bx, 16h
    mov     si, [bx]
    cmp     si, 0
    jnz     short loc_337AD
    cmp     al, 0Dh
    jz      short loc_33797
    cmp     al, 0Ah
    jnz     short loc_33771
loc_33797:
    mov     ax, word_3B774
    mov     word ptr aMsRunTimeLibraryCop, ax; "MS Run-Time Library - Copyright (c) 198"...
    mov     ax, word ptr aMsRunTimeLibraryCop+0Ah
    add     word ptr aMsRunTimeLibraryCop+2, ax
    jmp     short loc_33771
loc_337A6:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_337AD:
    mov     ax, word ptr aMsRunTimeLibraryCop; "MS Run-Time Library - Copyright (c) 198"...
    mov     [bp+var_2], ax
    cmp     byte ptr aMsRunTimeLibraryCop+0Ch, 0
    jz      short loc_337CE
    mov     al, [si]
    xor     ah, ah
    inc     si
    mov     word ptr aMsRunTimeLibraryCop+8, ax
    add     ax, 7
    shr     ax, 1
    shr     ax, 1
    shr     ax, 1
    mov     byte ptr aMsRunTimeLibraryCop+4, al
loc_337CE:
    mov     al, byte ptr word_3B770
    mov     ah, byte ptr word_3B772
    mov     cx, word ptr aMsRunTimeLibraryCop+6
    mov     [bp+var_4], cx
    mov     bx, word ptr aMsRunTimeLibraryCop+2
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
loc_337E7:
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dh, byte ptr aMsRunTimeLibraryCop+4
loc_337F1:
    mov     cx, 8
    mov     dl, [si]
loc_337F6:
    shl     dl, 1
    jnb     short loc_337FD
    mov     es:[di], al
loc_337FD:
    inc     di
    loop    loc_337F6
    inc     si
    dec     dh
    jg      short loc_337F1
    inc     bx
    inc     bx
    dec     [bp+var_4]
    jg      short loc_337E7
    mov     ax, word ptr aMsRunTimeLibraryCop+8
    add     word ptr aMsRunTimeLibraryCop, ax; "MS Run-Time Library - Copyright (c) 198"...
    jmp     loc_33771
font_draw_text endp
video_set_mode_13h proc far

    call    video_add_exithandler
    mov     ax, 40h ; '@'
    mov     es, ax
    mov     ax, es:10h
smart
    and     ax, 0FFCFh
nosmart
    or      ax, 10h
    mov     es:10h, ax
    mov     ah, 0Bh
    mov     bx, 0
    int     10h             ; - VIDEO - SET COLOR PALETTE
    mov     ah, 0
    mov     al, 13h
    int     10h             ; - VIDEO - SET VIDEO MODE
    xor     ax, ax
    push    ax
    push    ax
    call    video_clear_color
    add     sp, 4
    retf
video_set_mode_13h endp
file_load_shape2d_res_fatal_thunk proc far

    jmp     file_load_shape2d_res_fatal
file_load_shape2d_res_fatal_thunk endp
file_load_shape2d_res_nofatal_thunk proc far

    jmp     file_load_shape2d_res_nofatal
file_load_shape2d_res_nofatal_thunk endp
file_load_shape2d_res_thunk proc far

    jmp     file_load_shape2d_res
file_load_shape2d_res_thunk endp
parse_shape2d_thunk proc far

    jmp     parse_shape2d
parse_shape2d_thunk endp
file_load_shape2d_fatal_thunk proc far

    jmp     file_load_shape2d_fatal
file_load_shape2d_fatal_thunk endp
file_load_shape2d_nofatal_thunk proc far

    jmp     file_load_shape2d_nofatal
file_load_shape2d_nofatal_thunk endp
file_load_shape2d_thunk proc far

    jmp     file_load_shape2d
    ; align 2
    db 0
file_load_shape2d_thunk endp
sprite_putimage_and_alt2 proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [bp+arg_6]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_338C9
    ; align 2
    db 144
sprite_putimage_and_alt2 endp
sprite_putimage_and proc far
    var_E = word ptr -14
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
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    mov     [bp+var_4], ax
    jmp     short loc_338C9
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
    mov     [bp+var_4], ax
loc_338C9:
    mov     bx, [bp+var_4]
    mov     cx, [si+2]
    lea     dx, [si+10h]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_338EF
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_33916
    sub     cx, ax
    jg      short loc_33916
loc_338E8:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_338EF:
    mov     bx, cs:sprite1.sprite_top
    add     ax, cx
    sub     ax, bx
    jle     short loc_338E8
    xchg    ax, cx
    sub     ax, cx
    mov     [bp+var_8], dx
    mul     word ptr [si]
    mov     dx, [bp+var_8]
    add     dx, ax
    mov     ax, bx
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_33916
    sub     cx, ax
    jle     short loc_338E8
loc_33916:
    mov     [bp+var_C], dx
    mov     [bp+var_A], cx
    mov     [bp+var_4], bx
    mov     cx, [si]
    xor     dx, dx
    mov     bx, [bp+var_2]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_left
    jl      short loc_33941
    add     ax, cx
    sub     ax, cs:sprite1.sprite_right
    jl      short loc_33968
    sub     cx, ax
    jle     short loc_338E8
    mov     dx, ax
    jmp     short loc_33968
    db 144
loc_33941:
    mov     bx, cs:sprite1.sprite_left
    add     ax, cx
    sub     ax, bx
    jle     short loc_338E8
    mov     si, cx
    sub     si, ax
    add     [bp+var_C], si
    mov     si, cs:sprite1.sprite_right
    sub     si, bx
    jle     short loc_338E8
    cmp     ax, si
    jl      short loc_33962
    mov     ax, si
loc_33962:
    xchg    cx, dx
    sub     dx, ax
    add     cx, ax
loc_33968:
    or      cx, cx
    jle     short loc_339B1
    mov     [bp+var_6], cx
    mov     [bp+var_8], dx
    mov     [bp+var_2], bx
    cld
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     si, [bp+var_C]
    mov     dx, [bp+var_A]
    mov     bx, cs:sprite1.sprite_pitch
    sub     bx, [bp+var_6]
    cmp     [bp+var_8], 0
    jz      short loc_339B4
loc_3399F:
    mov     cx, [bp+var_6]
loc_339A2:
    lodsb
    and     es:[di], al
    inc     di
    loop    loc_339A2
    add     si, [bp+var_8]
    add     di, bx
    dec     dx
    jg      short loc_3399F
loc_339B1:
    jmp     loc_338E8
loc_339B4:
    mov     ax, [bp+var_6]
    shr     ax, 1
    mov     [bp+var_E], ax
    jnb     short loc_339D8
    jz      short loc_339EB
    inc     bx
loc_339C1:
    mov     cx, [bp+var_E]
loc_339C4:
    lodsw
    and     es:[di], ax
    inc     di
    inc     di
    loop    loc_339C4
    lodsb
    and     es:[di], al
    add     di, bx
    dec     dx
    jg      short loc_339C1
    jmp     loc_338E8
loc_339D8:
    mov     cx, [bp+var_E]
loc_339DB:
    lodsw
    and     es:[di], ax
    inc     di
    inc     di
    loop    loc_339DB
    add     di, bx
    dec     dx
    jg      short loc_339D8
    jmp     loc_338E8
loc_339EB:
    inc     bx
loc_339EC:
    lodsb
    and     es:[di], al
    add     di, bx
    inc     bx
    dec     dx
    jg      short loc_339EC
    jmp     loc_338E8
    ; align 2
    db 0
sprite_putimage_and endp
nopsub_339FA proc far
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
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_33A57
    ; align 2
    db 144
nopsub_339FA endp
putpixel_iconMask proc far
    var_6 = word ptr -6
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
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    mov     [bp+var_4], ax
    jmp     short loc_33A57
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
    mov     [bp+var_4], ax
loc_33A57:
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    cld
    mov     dx, [si+2]
    mov     bx, cs:sprite1.sprite_pitch
    mov     ax, [si]
    sub     bx, ax
    add     si, 10h
    shr     ax, 1
    mov     [bp+var_6], ax
    jnb     short loc_33AA1
    jz      short loc_33AB3
    inc     bx
loc_33A86:
    mov     cx, [bp+var_6]
loc_33A89:
    lodsw
    and     es:[di], ax
    inc     di
    inc     di
    loop    loc_33A89
    lodsb
    and     es:[di], al
    add     di, bx
    dec     dx
    jg      short loc_33A86
loc_33A9A:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_33AA1:
    mov     cx, [bp+var_6]
loc_33AA4:
    lodsw
    and     es:[di], ax
    inc     di
    inc     di
    loop    loc_33AA4
    add     di, bx
    dec     dx
    jg      short loc_33AA1
    jmp     short loc_33A9A
loc_33AB3:
    inc     bx
loc_33AB4:
    lodsb
    and     es:[di], ax
    add     di, bx
    dec     dx
    jg      short loc_33AB4
    jmp     short loc_33A9A
    ; align 2
    db 0
putpixel_iconMask endp
nopsub_33AC0 proc far
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
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_33B1D
    ; align 2
    db 144
nopsub_33AC0 endp
nopsub_33AE4 proc far
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
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    mov     [bp+var_4], ax
    jmp     short loc_33B1D
    ; align 2
    db 144
nopsub_33AE4 endp
shape2d_render_bmp_as_mask proc far
    var_10 = word ptr -16
    var_E = word ptr -14
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_shapeofs = word ptr 6
    arg_shapeseg = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_shapeseg]
    mov     si, [bp+arg_shapeofs]
    mov     ax, [si+SHAPE2D.s2d_pos_x]
    mov     [bp+var_2], ax
    mov     ax, [si+SHAPE2D.s2d_pos_y]
    mov     [bp+var_4], ax
loc_33B1D:
    cld
    lea     ax, [si+(size SHAPE2D)]
    mov     [bp+var_E], ax
    mov     ax, [si+SHAPE2D.s2d_width]
    mov     [bp+var_6], ax
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     [bp+var_10], bx
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     si, [bp+var_E]
    mov     dx, [bp+var_6]
loc_33B48:
    lodsb
    or      al, al
    jg      short loc_33B56
    jl      short loc_33B76
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_33B56:
    mov     cl, al
    xor     ch, ch
    lodsb
loc_33B5B:
    and     es:[di], al
    inc     di
    dec     dx
    jg      short loc_33B72
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, [bp+var_6]
loc_33B72:
    loop    loc_33B5B
    jmp     short loc_33B48
loc_33B76:
    neg     al
    mov     cl, al
    xor     ch, ch
loc_33B7C:
    lodsb
    and     es:[di], al
    inc     di
    dec     dx
    jg      short loc_33B94
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, [bp+var_6]
loc_33B94:
    loop    loc_33B7C
    jmp     short loc_33B48
shape2d_render_bmp_as_mask endp
nopsub_33B98 proc far
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
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_33BF5
    ; align 2
    db 144
nopsub_33B98 endp
sprite_putimage_and_alt proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [bp+arg_6]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    mov     [bp+var_4], ax
    jmp     short loc_33BF5
    ; align 2
    db 144
sprite_putimage_and_alt endp
sprite_putimage proc far
    var_E = word ptr -14
    var_bitmap = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    shapey = word ptr -4
    shapex = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+SHAPE2D.s2d_pos_x]
    mov     [bp+shapex], ax
    mov     ax, [si+SHAPE2D.s2d_pos_y]
    mov     [bp+shapey], ax
loc_33BF5:
    mov     bx, [bp+shapey]
    mov     cx, [si+SHAPE2D.s2d_height]
    lea     dx, [si+(size SHAPE2D)]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_33C1B
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_33C42
    sub     cx, ax
    jg      short loc_33C42
loc_33C14:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_33C1B:
    mov     bx, cs:sprite1.sprite_top
    add     ax, cx
    sub     ax, bx
    jle     short loc_33C14
    xchg    ax, cx
    sub     ax, cx
    mov     [bp+var_8], dx
    mul     [si+SHAPE2D.s2d_width]
    mov     dx, [bp+var_8]
    add     dx, ax
    mov     ax, bx
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_33C42
    sub     cx, ax
    jle     short loc_33C14
loc_33C42:
    mov     [bp+var_bitmap], dx
    mov     [bp+var_A], cx
    mov     [bp+shapey], bx
    mov     cx, [si+SHAPE2D.s2d_width]
    xor     dx, dx
    mov     bx, [bp+shapex]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_left
    jl      short loc_33C6D
    add     ax, cx
    sub     ax, cs:sprite1.sprite_right
    jl      short loc_33C94
    sub     cx, ax
    jle     short loc_33C14
    mov     dx, ax
    jmp     short loc_33C94
    db 144
loc_33C6D:
    mov     bx, cs:sprite1.sprite_left
    add     ax, cx
    sub     ax, bx
    jle     short loc_33C14
    mov     si, cx
    sub     si, ax
    add     [bp+var_bitmap], si
    mov     si, cs:sprite1.sprite_right
    sub     si, bx
    jle     short loc_33C14
    cmp     ax, si
    jl      short loc_33C8E
    mov     ax, si
loc_33C8E:
    xchg    cx, dx
    sub     dx, ax
    add     cx, ax
loc_33C94:
    or      cx, cx
    jle     short loc_33CD8
    mov     [bp+var_6], cx
    mov     [bp+var_8], dx
    mov     [bp+shapex], bx
    cld
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     bx, [bp+shapey]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+shapex]
    mov     si, [bp+var_bitmap]
    mov     dx, [bp+var_A]
    mov     bx, cs:sprite1.sprite_pitch
    sub     bx, [bp+var_6]
    cmp     [bp+var_8], 0
    jz      short loc_33CDB
loc_33CCB:
    mov     cx, [bp+var_6]
    rep movsb
    add     si, [bp+var_8]
    add     di, bx
    dec     dx
    jg      short loc_33CCB
loc_33CD8:
    jmp     loc_33C14
loc_33CDB:
    mov     ax, [bp+var_6]
    shr     ax, 1
    mov     [bp+var_E], ax
    jnb     short loc_33CF5
    jz      short loc_33D02
loc_33CE7:
    mov     cx, [bp+var_E]
    rep movsw
    movsb
    add     di, bx
    dec     dx
    jg      short loc_33CE7
    jmp     loc_33C14
loc_33CF5:
    mov     cx, [bp+var_E]
    rep movsw
    add     di, bx
    dec     dx
    jg      short loc_33CF5
    jmp     loc_33C14
loc_33D02:
    movsb
    add     di, bx
    inc     bx
    dec     dx
    jg      short loc_33D02
    jmp     loc_33C14
sprite_putimage endp
nopsub_33D0C proc far
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
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_33D69
    ; align 2
    db 144
nopsub_33D0C endp
sprite_shape_to_1 proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [bp+arg_6]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    mov     [bp+var_4], ax
    jmp     short loc_33D69
    ; align 2
    db 144
sprite_shape_to_1 endp
sprite_shape_to_1_alt proc far
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
    mov     [bp+var_4], ax
loc_33D69:
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    cld
    mov     dx, [si+2]
    mov     bx, cs:sprite1.sprite_pitch
    mov     ax, [si]
    sub     bx, ax
    add     si, 10h
    shr     ax, 1
    mov     [bp+var_6], ax
    jnb     short loc_33DA9
    jz      short loc_33DB5
loc_33D97:
    mov     cx, [bp+var_6]
    rep movsw
    movsb
    add     di, bx
    dec     dx
    jg      short loc_33D97
loc_33DA2:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_33DA9:
    mov     cx, [bp+var_6]
    rep movsw
    add     di, bx
    dec     dx
    jg      short loc_33DA9
    jmp     short loc_33DA2
loc_33DB5:
    movsb
    add     di, bx
    dec     dx
    jg      short loc_33DB5
    jmp     short loc_33DA2
    ; align 2
    db 0
sprite_shape_to_1_alt endp
nopsub_33DBE proc far
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
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_33E1B
    ; align 2
    db 144
nopsub_33DBE endp
shape2d_op_unk5 proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [bp+arg_6]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    mov     [bp+var_4], ax
    jmp     short loc_33E1B ; goto shape2d_op_unk3
    ; align 2
    db 144
shape2d_op_unk5 endp
shape2d_op_unk proc far
    var_10 = word ptr -16
    var_E = word ptr -14
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_shapeseg = word ptr 6
    arg_shapeofs = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_shapeofs]
    mov     si, [bp+arg_shapeseg]
    mov     ax, [si+SHAPE2D.s2d_pos_x]
    mov     [bp+var_2], ax
    mov     ax, [si+SHAPE2D.s2d_pos_y]
    mov     [bp+var_4], ax
loc_33E1B:
    cld
    lea     ax, [si+(size SHAPE2D)]
    mov     [bp+var_E], ax
    mov     ax, [si]
    mov     [bp+var_6], ax
loc_33E27:
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     [bp+var_10], bx
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     si, [bp+var_E]
    mov     dx, [bp+var_6]
loc_33E46:
    lodsb
    or      al, al
    jg      short loc_33E54
    jl      short loc_33E71
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_33E54:
    mov     cl, al
    xor     ch, ch
    lodsb
loc_33E59:
    stosb
    dec     dx
    jg      short loc_33E6D
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, [bp+var_6]
loc_33E6D:
    loop    loc_33E59
    jmp     short loc_33E46
loc_33E71:
    neg     al
    mov     cl, al
    xor     ch, ch
loc_33E77:
    movsb
    dec     dx
    jg      short loc_33E8B
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, [bp+var_6]
loc_33E8B:
    loop    loc_33E77
    jmp     short loc_33E46
    ; align 2
    db 0
shape2d_op_unk endp
nopsub_33E90 proc far
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
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_33EED
    ; align 2
    db 144
nopsub_33E90 endp
shape2d_op_unk2 proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [bp+arg_6]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    mov     [bp+var_4], ax
    jmp     short loc_33EED ; goto somewhere inside shape2d_op_unk3
    ; align 2
    db 144
shape2d_op_unk2 endp
shape2d_op_unk3 proc far
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_shape2dofs = word ptr 6
    arg_shape2dseg = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_shape2dseg]
    mov     si, [bp+arg_shape2dofs]
    mov     ax, [si+SHAPE2D.s2d_pos_x]
    mov     [bp+var_2], ax
    mov     ax, [si+SHAPE2D.s2d_pos_y]
    mov     [bp+var_4], ax
loc_33EED:
    cld
    lea     ax, [si+(size SHAPE2D)]
    mov     [bp+var_E], ax
    mov     ax, [si]
    mov     [bp+var_6], ax
    xor     di, di
    xor     dx, dx
    mov     bx, [bp+var_4]
    mov     cx, [si+2]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_33F21
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_33F44
    inc     di
    sub     cx, ax
    jg      short loc_33F44
loc_33F1A:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_33F21:
    inc     di
    mov     bx, cs:sprite1.sprite_top
    add     ax, cx
    sub     ax, bx
    jle     short loc_33F1A
    xchg    ax, cx
    sub     ax, cx
    mul     [bp+var_6]
    mov     dx, ax
    mov     ax, bx
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_33F44
    sub     cx, ax
    jle     short loc_33F1A
loc_33F44:
    mov     [bp+var_8], cx
    mov     [bp+var_4], bx
    mov     [bp+var_A], dx
    xor     dx, dx
    mov     bx, [bp+var_2]
    mov     ax, bx
    mov     cx, [bp+var_6]
    cmp     ax, cs:sprite1.sprite_left
    jl      short loc_33F71
    add     ax, cx
    sub     ax, cs:sprite1.sprite_right
    jle     short loc_33F97
    sub     cx, ax
    jle     short loc_33F1A
    inc     di
    mov     dx, ax
    jmp     short loc_33F97
    db 144
loc_33F71:
    inc     di
    mov     bx, cs:sprite1.sprite_left
    add     ax, cx
    sub     ax, bx
    jle     short loc_33F1A
    mov     si, cx
    sub     si, ax
    add     [bp+var_A], si
    mov     si, cs:sprite1.sprite_right
    sub     si, bx
    cmp     ax, si
    jl      short loc_33F91
    mov     ax, si
loc_33F91:
    xchg    cx, dx
    sub     dx, ax
    add     cx, ax
loc_33F97:
    mov     [bp+var_6], cx
    mov     [bp+var_C], dx
    mov     [bp+var_2], bx
    or      di, di
    jnz     short loc_33FA9
    jmp far ptr loc_33E27
loc_33FA9:
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     [bp+var_10], bx
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     si, [bp+var_E]
    mov     dx, [bp+var_A]
    or      dx, dx
    jnz     short loc_34042
loc_33FCC:
    mov     dx, [bp+var_6]
loc_33FCF:
    lodsb
    or      al, al
    jg      short loc_33FDD
    jl      short loc_3400B
loc_33FD6:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_33FDD:
    mov     cl, al
    xor     ch, ch
    lodsb
loc_33FE2:
    stosb
    dec     dx
    jle     short loc_33FEA
    loop    loc_33FE2
    jmp     short loc_33FCF
loc_33FEA:
    dec     [bp+var_8]
    jz      short loc_33FD6
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    dec     cx
    mov     dx, [bp+var_C]
loc_34000:
    sub     cx, dx
    jz      short loc_33FCC
    jl      short loc_3403E
    mov     dx, [bp+var_6]
    jmp     short loc_33FE2
loc_3400B:
    neg     al
    mov     cl, al
    xor     ch, ch
loc_34011:
    movsb
    dec     dx
    jle     short loc_34019
    loop    loc_34011
    jmp     short loc_33FCF
loc_34019:
    dec     [bp+var_8]
    jz      short loc_33FD6
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    dec     cx
    mov     dx, [bp+var_C]
loc_3402F:
    add     si, dx
    sub     cx, dx
    jz      short loc_33FCC
    jl      short loc_3403C
    mov     dx, [bp+var_6]
    jmp     short loc_34011
loc_3403C:
    add     si, cx
loc_3403E:
    neg     cx
    mov     dx, cx
loc_34042:
    lodsb
    or      al, al
    jg      short loc_34050
    jl      short loc_34057
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_34050:
    mov     cl, al
    xor     ch, ch
    lodsb
    jmp     short loc_34000
loc_34057:
    neg     al
    mov     cl, al
    xor     ch, ch
    jmp     short loc_3402F
    ; align 2
    db 0
shape2d_op_unk3 endp
sprite_putimage_or_alt proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [bp+arg_6]
    sub     ax, [si+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    sub     ax, [si+6]
    mov     [bp+var_4], ax
    jmp     short loc_340BD ; goto sprite_putimage_or
    ; align 2
    db 144
sprite_putimage_or_alt endp
sprite_putimage_or proc far
    var_E = word ptr -14
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
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    mov     [bp+var_4], ax
    jmp     short loc_340BD
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Eh
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
    mov     [bp+var_4], ax
loc_340BD:
    mov     bx, [bp+var_4]
    mov     cx, [si+2]
    lea     dx, [si+10h]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_340E3
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_3410A
    sub     cx, ax
    jg      short loc_3410A
loc_340DC:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_340E3:
    mov     bx, cs:sprite1.sprite_top
    add     ax, cx
    sub     ax, bx
    jle     short loc_340DC
    xchg    ax, cx
    sub     ax, cx
    mov     [bp+var_8], dx
    mul     word ptr [si]
    mov     dx, [bp+var_8]
    add     dx, ax
    mov     ax, bx
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_3410A
    sub     cx, ax
    jle     short loc_340DC
loc_3410A:
    mov     [bp+var_C], dx
    mov     [bp+var_A], cx
    mov     [bp+var_4], bx
    mov     cx, [si]
    xor     dx, dx
    mov     bx, [bp+var_2]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_left
    jl      short loc_34135
    add     ax, cx
    sub     ax, cs:sprite1.sprite_right
    jl      short loc_3415C
    sub     cx, ax
    jle     short loc_340DC
    mov     dx, ax
    jmp     short loc_3415C
    db 144
loc_34135:
    mov     bx, cs:sprite1.sprite_left
    add     ax, cx
    sub     ax, bx
    jle     short loc_340DC
    mov     si, cx
    sub     si, ax
    add     [bp+var_C], si
    mov     si, cs:sprite1.sprite_right
    sub     si, bx
    jle     short loc_340DC
    cmp     ax, si
    jl      short loc_34156
    mov     ax, si
loc_34156:
    xchg    cx, dx
    sub     dx, ax
    add     cx, ax
loc_3415C:
    or      cx, cx
    jle     short loc_341A5
    mov     [bp+var_6], cx
    mov     [bp+var_8], dx
    mov     [bp+var_2], bx
    cld
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     si, [bp+var_C]
    mov     dx, [bp+var_A]
loc_34185:
    mov     bx, cs:sprite1.sprite_pitch
    sub     bx, [bp+var_6]
    cmp     [bp+var_8], 0
    jz      short loc_341A8
loc_34193:
    mov     cx, [bp+var_6]
loc_34196:
    lodsb
    or      es:[di], al
    inc     di
    loop    loc_34196
    add     si, [bp+var_8]
    add     di, bx
    dec     dx
    jg      short loc_34193
loc_341A5:
    jmp     loc_340DC
loc_341A8:
    mov     ax, [bp+var_6]
    shr     ax, 1
    mov     [bp+var_E], ax
    jnb     short loc_341CC
    jz      short loc_341DF
    inc     bx
loc_341B5:
    mov     cx, [bp+var_E]
loc_341B8:
    lodsw
    or      es:[di], ax
    inc     di
    inc     di
    loop    loc_341B8
    lodsb
    or      es:[di], al
    add     di, bx
    dec     dx
    jg      short loc_341B5
    jmp     loc_340DC
loc_341CC:
    mov     cx, [bp+var_E]
loc_341CF:
    lodsw
    or      es:[di], ax
    inc     di
    inc     di
    loop    loc_341CF
    add     di, bx
    dec     dx
    jg      short loc_341CC
    jmp     loc_340DC
loc_341DF:
    inc     bx
loc_341E0:
    lodsb
    or      es:[di], al
    add     di, bx
    inc     bx
    dec     dx
    jg      short loc_341E0
    jmp     loc_340DC
    ; align 2
    db 0
    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     ax, [bp+0Ah]
    sub     ax, [si+4]
    mov     [bp-2], ax
    mov     ax, [bp+0Ch]
    sub     ax, [si+6]
    mov     [bp-4], ax
    jmp     short loc_3424B
    ; align 2
    db 144
sprite_putimage_or endp
putpixel_iconFillings proc far
    var_6 = word ptr -6
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
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [bp+arg_4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    mov     [bp+var_4], ax
    jmp     short loc_3424B
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
    mov     [bp+var_4], ax
loc_3424B:
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    cld
    mov     dx, [si+2]
    mov     bx, cs:sprite1.sprite_pitch
    mov     ax, [si]
    sub     bx, ax
    add     si, 10h
    shr     ax, 1
    mov     [bp+var_6], ax
    jnb     short loc_34295
    jz      short loc_342A7
    inc     bx
loc_3427A:
    mov     cx, [bp+var_6]
loc_3427D:
    lodsw
    or      es:[di], ax
    inc     di
    inc     di
    loop    loc_3427D
    lodsb
    or      es:[di], al
    add     di, bx
    dec     dx
    jg      short loc_3427A
loc_3428E:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_34295:
    mov     cx, [bp+var_6]
loc_34298:
    lodsw
    or      es:[di], ax
    inc     di
    inc     di
    loop    loc_34298
    add     di, bx
    dec     dx
    jg      short loc_34295
    jmp     short loc_3428E
loc_342A7:
    inc     bx
loc_342A8:
    lodsb
    or      es:[di], ax
    add     di, bx
    dec     dx
    jg      short loc_342A8
    jmp     short loc_3428E
    ; align 2
    db 0
    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     ax, [bp+0Ah]
    sub     ax, [si+4]
    mov     [bp-2], ax
    mov     ax, [bp+0Ch]
    sub     ax, [si+6]
    mov     [bp-4], ax
    jmp     short loc_34311
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     ax, [bp+0Ah]
    mov     [bp-2], ax
    mov     ax, [bp+0Ch]
    mov     [bp-4], ax
    jmp     short loc_34311
    ; align 2
    db 144
putpixel_iconFillings endp
shape2d_op_unk4 proc far
    var_10 = word ptr -16
    var_E = word ptr -14
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_shapeofs = word ptr 6
    arg_shapeseg = word ptr 8

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_shapeseg]
    mov     si, [bp+arg_shapeofs]
    mov     ax, [si+SHAPE2D.s2d_pos_x]
    mov     [bp+var_2], ax
    mov     ax, [si+SHAPE2D.s2d_pos_y]
    mov     [bp+var_4], ax
loc_34311:
    cld
    lea     ax, [si+(size SHAPE2D)]
    mov     [bp+var_E], ax
    mov     ax, [si]
    mov     [bp+var_6], ax
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     [bp+var_10], bx
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     si, [bp+var_E]
    mov     dx, [bp+var_6]
loc_3433C:
    lodsb
    or      al, al
    jg      short loc_3434A
    jl      short loc_3436A
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_3434A:
    mov     cl, al
    xor     ch, ch
    lodsb
loc_3434F:
    or      es:[di], al
    inc     di
    dec     dx
    jg      short loc_34366
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, [bp+var_6]
loc_34366:
    loop    loc_3434F
    jmp     short loc_3433C
loc_3436A:
    neg     al
    mov     cl, al
    xor     ch, ch
loc_34370:
    lodsb
    or      es:[di], al
    inc     di
    dec     dx
    jg      short loc_34388
    add     [bp+var_10], 2
    mov     bx, [bp+var_10]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, [bp+var_6]
loc_34388:
    loop    loc_34370
    jmp     short loc_3433C
    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     ax, [bp+0Ah]
    sub     ax, [si+4]
    mov     [bp-2], ax
    mov     ax, [bp+0Ch]
    sub     ax, [si+6]
    mov     [bp-4], ax
    jmp     short loc_343E9
    ; align 2
    db 144
shape2d_op_unk4 endp
sprite_putimage_transparent proc far
    var_bmpptr = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_shapey = word ptr -4
    var_shapex = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    shapeptr = dword ptr 6
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+shapeptr+2]
    mov     si, word ptr [bp+shapeptr]
    mov     ax, [bp+arg_4]
    mov     [bp+var_shapex], ax
    mov     ax, [bp+arg_6]
    mov     [bp+var_shapey], ax
    jmp     short loc_343E9
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Ch
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+shapeptr+2]
    mov     si, word ptr [bp+shapeptr]
    mov     ax, [si+SHAPE2D.s2d_pos_x]
    mov     [bp+var_shapex], ax
    mov     ax, [si+SHAPE2D.s2d_pos_y]
    mov     [bp+var_shapey], ax
loc_343E9:
    mov     bx, [bp+var_shapey]
    mov     cx, [si+SHAPE2D.s2d_height]
    lea     dx, [si+(size SHAPE2D)]
    mov     ax, bx
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_3440F
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_34436
    sub     cx, ax
    jg      short loc_34436
loc_34408:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_3440F:
    mov     bx, cs:sprite1.sprite_top
    add     ax, cx
    sub     ax, bx
    jle     short loc_34408
    xchg    ax, cx
    sub     ax, cx
    mov     [bp+var_bmpptr], dx
    mul     [si+SHAPE2D.s2d_width]
    mov     dx, [bp+var_bmpptr]
    add     dx, ax
    mov     ax, bx
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jle     short loc_34436
    sub     cx, ax
    jle     short loc_34408
loc_34436:
    mov     [bp+var_bmpptr], dx
    mov     [bp+var_A], cx
    mov     [bp+var_shapey], bx
    mov     cx, [si+SHAPE2D.s2d_width]
    xor     dx, dx
    mov     ax, [bp+var_shapex]
    mov     bx, ax
    cmp     ax, cs:sprite1.sprite_left
    jl      short loc_34461
    add     ax, cx
    sub     ax, cs:sprite1.sprite_right
    jl      short loc_34488
    sub     cx, ax
    jle     short loc_34408
    mov     dx, ax
    jmp     short loc_34488
    db 144
loc_34461:
    mov     bx, cs:sprite1.sprite_left
    add     ax, cx
    sub     ax, bx
    jle     short loc_34408
    mov     si, cx
    sub     si, ax
    add     [bp+var_bmpptr], si
    mov     si, cs:sprite1.sprite_right
    sub     si, bx
    jle     short loc_34408
    cmp     ax, si
    jl      short loc_34482
    mov     ax, si
loc_34482:
    xchg    cx, dx
    sub     dx, ax
    add     cx, ax
loc_34488:
    or      cx, cx
    jle     short loc_344DC
    mov     [bp+var_6], cx
    mov     [bp+var_8], dx
    mov     [bp+var_shapex], bx
    cld
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     bx, [bp+var_shapey]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
loc_344A8:
    add     di, [bp+var_shapex]
    mov     si, [bp+var_bmpptr]
    mov     dx, cs:sprite1.sprite_pitch
    sub     dx, [bp+var_6]
    xor     bh, bh
    mov     ah, 0FFh
loc_344BA:
    mov     cx, [bp+var_6]
loc_344BD:
    lodsb
    mov     bl, al
    mov     al, cs:incnums[bx]
    cmp     al, ah
    jz      short loc_344CF
    stosb
    loop    loc_344BD
    jmp     short loc_344D2
    db 144
loc_344CF:
    inc     di
    loop    loc_344BD
loc_344D2:
    add     si, [bp+var_8]
    add     di, dx
    dec     [bp+var_A]
    jg      short loc_344BA
loc_344DC:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     ax, [bp+0Ah]
    sub     ax, [si+4]
    mov     [bp-2], ax
    mov     ax, [bp+0Ch]
    sub     ax, [si+6]
    mov     [bp-4], ax
    jmp     short loc_34541
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+8]
    mov     si, [bp+6]
    mov     ax, [bp+0Ah]
    mov     [bp-2], ax
    mov     ax, [bp+0Ch]
    mov     [bp-4], ax
    jmp     short loc_34541
    ; align 2
    db 144
sprite_putimage_transparent endp
sub_34526 proc far
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
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
    mov     [bp+var_4], ax
loc_34541:
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, cs:sprite1.sprite_pitch
    mov     ax, [si]
    mov     [bp+var_6], ax
    sub     dx, ax
    mov     ax, [si+2]
    mov     [bp+var_8], ax
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    cld
    add     si, 10h
    xor     bx, bx
loc_3456E:
    mov     cx, [bp+var_6]
loc_34571:
    lodsb
    mov     bl, al
    mov     al, cs:incnums[bx]
    cmp     al, 0FFh
    jz      short loc_34583
    stosb
    loop    loc_34571
    jmp     short loc_34586
    db 144
loc_34583:
    inc     di
    loop    loc_34571
loc_34586:
    add     di, dx
    dec     [bp+var_8]
    jg      short loc_3456E
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
    push    bp
    mov     bp, sp
    sub     sp, 4
    push    ds
    push    si
    push    di
    mov     ax, [bp+6]
    mov     byte ptr aCopyrightCUnlimitedSoftwareInc_198+46h, al
    mov     ax, 5416h
    mov     [bp+6], ax
    mov     ds, fontdefseg
    mov     ax, [bp+8]
    mov     word ptr aMsRunTimeLibraryCop, ax; "MS Run-Time Library - Copyright (c) 198"...
    mov     ax, [bp+0Ah]
    mov     word ptr aMsRunTimeLibraryCop+2, ax
    jmp     short loc_345E5
    ; align 2
    db 144
sub_34526 endp
sub_345BC proc far
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
    push    ds
    push    si
    push    di
    mov     ds, fontdefseg  ; ds = seg039
    mov     ax, [bp+arg_2]
    mov     ds:8, ax
    mov     ax, [bp+arg_4]
    mov     word ptr aMsRunTimeLibraryCop+2, ax
    jmp     short loc_345E5
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 4
    push    ds
    push    si
    push    di
    mov     ds, fontdefseg
loc_345E5:
    cld
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
loc_345EB:
    mov     si, [bp+arg_0]
    mov     bl, ss:[si]
    or      bl, bl
    jz      short loc_3461F
    mov     al, bl
    inc     [bp+arg_0]
    xor     bh, bh
    shl     bx, 1
    add     bx, 16h
    mov     si, [bx]
    cmp     si, 0
    jnz     short loc_34626
    cmp     al, 0Dh
    jz      short loc_34610
    cmp     al, 0Ah
    jnz     short loc_345EB
loc_34610:
    mov     ax, word_3B774
    mov     word ptr aMsRunTimeLibraryCop, ax; "MS Run-Time Library - Copyright (c) 198"...
    mov     ax, word ptr aMsRunTimeLibraryCop+0Ah
    add     word ptr aMsRunTimeLibraryCop+2, ax
    jmp     short loc_345EB
loc_3461F:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_34626:
    mov     ax, word ptr aMsRunTimeLibraryCop; "MS Run-Time Library - Copyright (c) 198"...
    mov     [bp+var_2], ax
    cmp     byte ptr aMsRunTimeLibraryCop+0Ch, 0
    jz      short loc_34647
    mov     al, [si]
    xor     ah, ah
    inc     si
    mov     word ptr aMsRunTimeLibraryCop+8, ax
    add     ax, 7
    shr     ax, 1
    shr     ax, 1
    shr     ax, 1
    mov     byte ptr aMsRunTimeLibraryCop+4, al
loc_34647:
    mov     al, byte ptr word_3B770
    mov     ah, byte ptr word_3B772
    mov     cx, word ptr aMsRunTimeLibraryCop+6
    mov     [bp+var_4], cx
    mov     bx, word ptr aMsRunTimeLibraryCop+2
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
loc_34660:
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dh, byte ptr aMsRunTimeLibraryCop+4
loc_3466A:
    mov     cx, 8
    mov     dl, [si]
loc_3466F:
    shl     dl, 1
    jnb     short loc_3468C
    stosb
    loop    loc_3466F
    inc     si
    dec     dh
    jg      short loc_3466A
loc_3467B:
    inc     bx
    inc     bx
    dec     [bp+var_4]
    jg      short loc_34660
    mov     ax, word ptr aMsRunTimeLibraryCop+8
    add     word ptr aMsRunTimeLibraryCop, ax; "MS Run-Time Library - Copyright (c) 198"...
    jmp     loc_345EB
loc_3468C:
    mov     es:[di], ah
    inc     di
    loop    loc_3466F
    inc     si
    dec     dh
    jg      short loc_3466A
    jmp     short loc_3467B
    ; align 2
    db 0
    push    bp
    mov     bp, sp
    mov     ax, [bp+0Ch]
    jmp     short loc_346A8
    db 144
sub_345BC endp
video_set_palette proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10

    push    bp
    mov     bp, sp
    mov     ax, ds
loc_346A8:
    mov     es, ax
    mov     bx, [bp+arg_0]
    mov     dx, [bp+arg_4]
    mov     cx, [bp+arg_2]
    mov     ah, 10h
    mov     al, 12h
    int     10h             ; - VIDEO - SET BLOCK OF DAC REGISTERS (EGA, VGA/MCGA)
    pop     bp
    retf
    ; align 2
    db 0
video_set_palette endp
draw_filled_lines proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_x1arr = word ptr 6
    arg_x2arr = word ptr 8
    arg_y = word ptr 10
    arg_numlines = word ptr 12
    arg_color = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 2
    push    si
    push    di
    cmp     [bp+arg_numlines], 0
    jz      short loc_3470C ; if arg6 == 0, return
    cld
    mov     si, [bp+arg_y]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     ax, [bp+arg_color]
    mov     ah, al
loc_346E0:
    mov     bx, [bp+arg_x2arr]
    mov     cx, [bx]
    mov     bx, [bp+arg_x1arr]
    mov     bx, [bx]
    sub     cx, bx
    inc     cx
    jle     short loc_346FC
    mov     di, cs:[si]     ; si = offset in lineofs table, di = y offset in bitmapptr
    add     di, bx
    test    cx, 0FFF8h
    jnz     short loc_34712 ; jump if (cx & 0xFFF8), ie jump if cx >= 8.
    rep stosb               ; rep count = cx = (arg2->member0 - arg0->member0) + 1
loc_346FC:
    add     [bp+arg_x2arr], 2
    add     [bp+arg_x1arr], 2
    add     si, 2
    dec     [bp+arg_numlines]
    jg      short loc_346E0
loc_3470C:
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
loc_34712:
    test    di, 1           ; looks like its figuring out which alignment optimizations to use
    jnz     short loc_34725
    shr     cx, 1
    jb      short loc_34720
    rep stosw
    jmp     short loc_346FC
loc_34720:
    rep stosw
    stosb
    jmp     short loc_346FC
loc_34725:
    shr     cx, 1
    jb      short loc_34730
    dec     cx
    stosb
    rep stosw
    stosb
    jmp     short loc_346FC
loc_34730:
    stosb
    rep stosw
    jmp     short loc_346FC
    ; align 2
    db 0
draw_filled_lines endp
nopsub_34736 proc far
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
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     di, [bp+arg_0]
    mov     ax, [bp+arg_4]
    sub     ax, [di+4]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_6]
    sub     ax, [di+6]
    mov     [bp+var_4], ax
    jmp     short loc_34799
    ; align 2
    db 144
nopsub_34736 endp
sprite_clear_shape_alt proc far
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 6
    arg_4 = word ptr 8
    arg_6 = word ptr 10
    arg_8 = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     di, [bp+arg_2]
    mov     ax, [bp+arg_6]
    mov     [bp+var_2], ax
    mov     [di+SHAPE2D.s2d_pos_x], ax
    mov     ax, [bp+arg_8]
    mov     [bp+var_4], ax
    mov     [di+SHAPE2D.s2d_pos_y], ax
    jmp     short loc_34799
    ; align 2
    db 144
sprite_clear_shape_alt endp
sprite_clear_shape proc far
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
    sub     sp, 0Ah
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_2]
    mov     di, [bp+arg_0]
    mov     ax, [di+8]
    mov     [bp+var_2], ax
    mov     ax, [di+0Ah]
    mov     [bp+var_4], ax
loc_34799:
    mov     ax, [di]
    mov     [bp+var_8], ax
    mov     ax, [di+2]
    mov     [bp+var_A], ax
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     [bp+var_6], bx
    mov     ds, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, [bp+arg_2]
    add     di, 10h
    cld
    mov     dx, [bp+var_A]
loc_347C0:
    mov     bx, [bp+var_6]
    mov     si, cs:[bx]
    add     si, [bp+var_2]
    mov     cx, [bp+var_8]
    rep movsb
    add     [bp+var_6], 2
    dec     dx
    jg      short loc_347C0
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
sprite_clear_shape endp
shape_op_explosion proc far
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_shapeptr = dword ptr 8
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+arg_shapeptr+2]
    mov     si, word ptr [bp+arg_shapeptr]
    mov     cx, [bp+arg_6]
    mov     ax, [si+SHAPE2D.s2d_unk1]
    imul    [bp+arg_0]
    sub     cl, ah
    sbb     ch, dl
    mov     [bp+var_2], cx
    mov     cx, [bp+arg_8]
    mov     ax, [si+SHAPE2D.s2d_unk2]
    imul    [bp+arg_0]
    sub     cl, ah
    sbb     ch, dl
    mov     [bp+var_4], cx
    jmp     short loc_3484E
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+arg_shapeptr+2]
    mov     si, word ptr [bp+arg_shapeptr]
    mov     ax, [bp+arg_6]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    mov     [bp+var_4], ax
    jmp     short loc_3484E
    ; align 2
    db 144
loc_3482C:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, word ptr [bp+arg_shapeptr+2]
    mov     si, word ptr [bp+arg_shapeptr]
    mov     ax, [si+SHAPE2D.s2d_pos_x]
    mov     [bp+var_2], ax
    mov     ax, [si+SHAPE2D.s2d_pos_y]
    mov     [bp+var_4], ax
loc_3484E:
    cmp     [bp+arg_0], 2
    jb      short loc_3482C
    cld
    mov     ax, [si+SHAPE2D.s2d_height]
    mul     [bp+arg_0]
    mov     al, ah
    mov     ah, dl
    or      ax, ax
    jz      short loc_3482C
    mov     [bp+var_8], ax
    mov     ax, [si+SHAPE2D.s2d_width]
    mov     [bp+var_A], ax
    mul     [bp+arg_0]
    mov     al, ah
    mov     ah, dl
    or      ax, ax
    jz      short loc_3482C
    mov     [bp+var_6], ax
    mov     dx, cs:sprite1.sprite_pitch
    sub     dx, ax
    mov     [bp+var_C], dx
    add     si, 10h
    mov     dx, 1
    xor     ax, ax
    mov     [bp+var_12], ax
    mov     [bp+var_14], ax
    div     [bp+arg_0]
    mov     [bp+var_10], ax
    mov     al, ah
    xor     ah, ah
    shr     ax, 1
    jz      short loc_348A8
    add     si, ax
    mov     cx, ax
loc_348A3:
    add     si, [bp+var_A]
    loop    loc_348A3
loc_348A8:
    mov     cx, [bp+var_6]
    mov     ax, [bp+var_2]
    mov     bx, cs:sprite1.sprite_left2
    cmp     ax, bx
    jge     short loc_348D6
    add     ax, cx
    sub     ax, bx
    jle     short loc_34939
    mov     [bp+var_2], bx
    mov     [bp+var_6], ax
    xchg    ax, cx
    sub     ax, cx
    mul     [bp+var_10]
    xchg    al, dl
    xor     dh, dh
    mov     [bp+var_14], dx
    xchg    al, ah
    add     si, ax
    mov     ax, bx
loc_348D6:
    add     ax, cx
    sub     ax, cs:sprite1.sprite_widthsum
    jl      short loc_348E6
    sub     cx, ax
    jle     short loc_34939
    mov     [bp+var_6], cx
loc_348E6:
    mov     ax, cs:sprite1.sprite_pitch
    sub     ax, cx
    mov     [bp+var_C], ax
    mov     cx, [bp+var_8]
    mov     ax, [bp+var_4]
    mov     bx, cs:sprite1.sprite_top
    cmp     ax, bx
    jge     short loc_34920
    add     ax, cx
    sub     ax, bx
    jle     short loc_34939
    mov     [bp+var_8], ax
    mov     [bp+var_4], bx
    xchg    ax, cx
    sub     ax, cx
    mul     [bp+var_10]
    xchg    al, dl
    xor     dh, dh
    mov     [bp+var_12], dx
    xchg    al, ah
    mul     [bp+var_A]
    add     si, ax
    mov     ax, bx
loc_34920:
    add     ax, cx
    sub     ax, cs:sprite1.sprite_height
    jl      short loc_34930
    sub     cx, ax
    jle     short loc_34939
    mov     [bp+var_8], cx
loc_34930:
    mov     dx, [bp+var_10]
    mov     [bp+var_E], si
    jmp     loc_35ED9
loc_34939:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
sprite1     db 0
    db 0
    db 0
    db 160
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 92
    db 95
    db 0
    db 0
    db 64
    db 1
    db 0
    db 0
    db 200
    db 0
    db 64
    db 1
    db 0
    db 0
    db 64
    db 1
    db 0
    db 0
    db 64
    db 1
sprite2     db 0
    db 0
    db 0
    db 160
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 92
    db 95
    db 0
    db 0
    db 64
    db 1
    db 0
    db 0
    db 200
    db 0
    db 64
    db 1
    db 0
    db 0
    db 64
    db 1
    db 0
    db 0
    db 64
    db 1
lineoffsets     dw 0
    dw 320
    dw 640
    dw 960
    dw 1280
    dw 1600
    dw 1920
    dw 2240
    dw 2560
    dw 2880
    dw 3200
    dw 3520
    dw 3840
    dw 4160
    dw 4480
    dw 4800
    dw 5120
    dw 5440
    dw 5760
    dw 6080
    dw 6400
    dw 6720
    dw 7040
    dw 7360
    dw 7680
    dw 8000
    dw 8320
    dw 8640
    dw 8960
    dw 9280
    dw 9600
    dw 9920
    dw 10240
    dw 10560
    dw 10880
    dw 11200
    dw 11520
    dw 11840
    dw 12160
    dw 12480
    dw 12800
    dw 13120
    dw 13440
    dw 13760
    dw 14080
    dw 14400
    dw 14720
    dw 15040
    dw 15360
    dw 15680
    dw 16000
    dw 16320
    dw 16640
    dw 16960
    dw 17280
    dw 17600
    dw 17920
    dw 18240
    dw 18560
    dw 18880
    dw 19200
    dw 19520
    dw 19840
    dw 20160
    dw 20480
    dw 20800
    dw 21120
    dw 21440
    dw 21760
    dw 22080
    dw 22400
    dw 22720
    dw 23040
    dw 23360
    dw 23680
    dw 24000
    dw 24320
    dw 24640
    dw 24960
    dw 25280
    dw 25600
    dw 25920
    dw 26240
    dw 26560
    dw 26880
    dw 27200
    dw 27520
    dw 27840
    dw 28160
    dw 28480
    dw 28800
    dw 29120
    dw 29440
    dw 29760
    dw 30080
    dw 30400
    dw 30720
    dw 31040
    dw 31360
    dw 31680
    dw 32000
    dw 32320
    dw 32640
    dw 32960
    dw 33280
    dw 33600
    dw 33920
    dw 34240
    dw 34560
    dw 34880
    dw 35200
    dw 35520
    dw 35840
    dw 36160
    dw 36480
    dw 36800
    dw 37120
    dw 37440
    dw 37760
    dw 38080
    dw 38400
    dw 38720
    dw 39040
    dw 39360
    dw 39680
    dw 40000
    dw 40320
    dw 40640
    dw 40960
    dw 41280
    dw 41600
    dw 41920
    dw 42240
    dw 42560
    dw 42880
    dw 43200
    dw 43520
    dw 43840
    dw 44160
    dw 44480
    dw 44800
    dw 45120
    dw 45440
    dw 45760
    dw 46080
    dw 46400
    dw 46720
    dw 47040
    dw 47360
    dw 47680
    dw 48000
    dw 48320
    dw 48640
    dw 48960
    dw 49280
    dw 49600
    dw 49920
    dw 50240
    dw 50560
    dw 50880
    dw 51200
    dw 51520
    dw 51840
    dw 52160
    dw 52480
    dw 52800
    dw 53120
    dw 53440
    dw 53760
    dw 54080
    dw 54400
    dw 54720
    dw 55040
    dw 55360
    dw 55680
    dw 56000
    dw 56320
    dw 56640
    dw 56960
    dw 57280
    dw 57600
    dw 57920
    dw 58240
    dw 58560
    dw 58880
    dw 59200
    dw 59520
    dw 59840
    dw 60160
    dw 60480
    dw 60800
    dw 61120
    dw 61440
    dw 61760
    dw 62080
    dw 62400
    dw 62720
    dw 63040
    dw 63360
    dw 63680
shape_op_explosion endp
font_set_unk proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     es, fontdefseg
    mov     ax, [bp+arg_2]
    xor     ah, ah
    mov     es:2, ax
    mov     ax, [bp+arg_0]
    xor     ah, ah
    mov     es:0, ax
    pop     bp
    retf
    push    bp
    mov     bp, sp
    mov     es, fontdefseg
    mov     ax, [bp+6]
    mov     es:8, ax
    mov     ax, [bp+8]
    mov     es:0Ah, ax
    pop     bp
    retf
    push    bp
    mov     bp, sp
    push    ds
    push    di
    push    si
    xor     si, si
    mov     di, [bp+6]
    mov     ax, ds
    mov     es, ax
    mov     ds, fontdefseg
    cld
    mov     word ptr es:[di+16h], ds
    mov     cx, 0Bh
    rep movsw
    pop     si
    pop     di
    pop     ds
    pop     bp
    retf
    push    bp
    mov     bp, sp
    push    di
    push    si
    mov     si, [bp+6]
    mov     ax, [si+16h]
    mov     fontdefseg, ax
    mov     es, ax
    xor     di, di
    cld
    mov     cx, 0Bh
    rep movsw
    pop     si
    pop     di
    pop     bp
    retf
font_set_unk endp
set_fontdefseg proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    mov     ax, [bp+arg_2]
    mov     fontdefseg, ax
    pop     bp
    retf
    ; align 2
    db 0
    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+10h]
    mov     word_4031E, ax
    jmp     short loc_34B9B
    ; align 2
    db 144
set_fontdefseg endp
draw_patterned_lines proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = byte ptr 14

    push    bp
    mov     bp, sp
    push    si
    push    di
loc_34B9B:
    cld
    mov     si, [bp+arg_4]
    test    si, 1
    jnz     short loc_34BAD
    mov     ax, word_4031E
    xchg    ah, al
    mov     word_4031E, ax
loc_34BAD:
    mov     si, [bp+arg_4]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     al, [bp+arg_8]
loc_34BC0:
    mov     bx, [bp+arg_2]
    mov     dx, [bx]
    mov     bx, [bp+arg_0]
    mov     bx, [bx]
    mov     ah, byte ptr word_4031E
    mov     cl, bl
smart
    and     cl, 7
nosmart
    rol     ah, cl
    mov     cx, dx
    sub     cx, bx
    inc     cx
    jle     short loc_34BE8
    mov     di, cs:[si]
    add     di, bx
loc_34BE1:
    rol     ah, 1
    jnb     short loc_34C06
    stosb
    loop    loc_34BE1
loc_34BE8:
    add     [bp+arg_2], 2
    add     [bp+arg_0], 2
    add     si, 2
    mov     dx, word_4031E
    xchg    dh, dl
    mov     word_4031E, dx
    dec     [bp+arg_6]
    jg      short loc_34BC0
    pop     di
    pop     si
    pop     bp
    retf
loc_34C06:
    inc     di
    loop    loc_34BE1
    jmp     short loc_34BE8
    ; align 2
    db 0
draw_patterned_lines endp
sprite_make_wnd proc far
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
    sub     sp, 8
    push    ds
    push    si
    push    di
    mov     ax, [bp+arg_0]
    mov     [bp+var_8], ax
    mov     bx, [bp+arg_2]
    imul    bx
    add     ax, 10h
    mov     cx, 4
    shr     ax, cl
    inc     ax
    mov     bx, ax
    mov     [bp+var_6], ax
    push    ax
    mov     ax, offset aMcgaWindow; "MCGA WINDOW"
    push    ax
    call    mmgr_alloc_pages
    add     sp, 4
    mov     [bp+var_2], dx
    mov     ds, dx
    xor     bx, bx
    mov     ax, [bp+var_8]
    mov     [bx+SHAPE2D.s2d_width], ax
    mov     ax, [bp+arg_2]
    mov     [bx+SHAPE2D.s2d_height], ax
    xor     ax, ax
    mov     [bx+SHAPE2D.s2d_pos_x], ax
    mov     [bx+SHAPE2D.s2d_pos_y], ax
    mov     [bx+SHAPE2D.s2d_unk1], ax
    mov     [bx+SHAPE2D.s2d_unk2], ax
    mov     ax, 0Fh         ; sizeof SPRITE (in words)
    add     ax, [bp+arg_2]  ; height ??
    shl     ax, 1
    mov     bx, cs:next_wnd_def
    mov     [bp+var_4], bx
    add     ax, bx
    cmp     ax, offset sprite_set_1_from_argptr; sprite_set_1 happens to be the end of the buffer.. see below this func
    jnb     short loc_34CD6
    mov     cs:next_wnd_def, ax
    mov     word ptr cs:[bx+SPRITE.sprite_bitmapptr], 0
    mov     ax, [bp+var_2]
    mov     word ptr cs:[bx+(SPRITE.sprite_bitmapptr+2)], ax
    lea     ax, [bx+(size SPRITE)]
    mov     cs:[bx+SPRITE.sprite_lineofs], ax
    mov     cs:[bx+SPRITE.sprite_left], 0
    mov     cs:[bx+SPRITE.sprite_left2], 0
    mov     ax, [bp+var_8]
    mov     cs:[bx+SPRITE.sprite_right], ax
    mov     cs:[bx+SPRITE.sprite_pitch], ax
    mov     cs:[bx+SPRITE.sprite_top], 0
    mov     ax, [bp+arg_2]
    mov     cs:[bx+SPRITE.sprite_height], ax
    mov     ax, [bp+arg_0]
    mov     cs:[bx+SPRITE.sprite_width2], ax
    mov     cs:[bx+SPRITE.sprite_widthsum], ax
    mov     cx, [bp+arg_2]
    mov     ax, size SHAPE2D
loc_34CBE:
    mov     cs:[bx+(size SPRITE)], ax
    add     bx, 2
    add     ax, [bp+var_8]
    loop    loc_34CBE
    mov     dx, cs
    mov     ax, [bp+var_4]
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_34CD6:
    mov     ax, ss
    mov     ds, ax
    mov     ax, offset aWindowdefOutOfRowTableSpa; "windowdef - OUT OF ROW TABLE SPACE\r"
    push    ax
    call    far ptr fatal_error
    ; align 2
    db 144
next_wnd_def     dw offset wnd_defs
wnd_defs     db 0
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
sprite_make_wnd endp
sprite_set_1_from_argptr proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    cld
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     cx, 0Fh
    mov     ax, cs
    mov     es, ax
    mov     di, offset sprite1
    rep movsw
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
sprite_set_1_from_argptr endp
sprite_copy_2_to_1 proc far

    mov     ax, seg seg012
    push    ax
    mov     ax, offset sprite2
    push    ax
    call    sprite_set_1_from_argptr
    add     sp, 4
    retf
    ; align 2
    db 0
sprite_copy_2_to_1 endp
putpixel_single_maybe proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0x = word ptr 6
    arg_2y = word ptr 8
    arg_4col = word ptr 10

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     ax, [bp+arg_0x]
    cmp     ax, cs:sprite1.sprite_left
    jl      short loc_35B4D
    cmp     ax, cs:sprite1.sprite_right
    jge     short loc_35B4D
    mov     ax, [bp+arg_2y]
    cmp     ax, cs:sprite1.sprite_top
    jl      short loc_35B4D
    cmp     ax, cs:sprite1.sprite_height
    jl      short loc_35B56
loc_35B4D:
    pop     di
    pop     si
    pop     bp
    retf
    push    bp
    mov     bp, sp
    push    si
    push    di
loc_35B56:
    mov     di, [bp+arg_0x]
    mov     si, [bp+arg_2y]
    shl     si, 1
    add     si, cs:sprite1.sprite_lineofs
    add     di, cs:[si]
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     ax, [bp+arg_4col]
    mov     es:[di], al
    pop     di
    pop     si
    pop     bp
    retf
    ; align 2
    db 0
putpixel_single_maybe endp
sub_35B76 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = byte ptr 14

    push    bp
    mov     bp, sp
    push    si
    push    di
    mov     dx, cs:sprite1.sprite_left
    mov     ax, dx
    sub     ax, [bp+arg_0]
    jle     short loc_35B8F
    mov     [bp+arg_0], dx
    sub     [bp+arg_4], ax
    jle     short loc_35BCD
loc_35B8F:
    mov     ax, [bp+arg_0]
    add     ax, [bp+arg_4]
    sub     ax, cs:sprite1.sprite_right
    jle     short loc_35BA1
    sub     [bp+arg_4], ax
    jle     short loc_35BCD
loc_35BA1:
    mov     ax, cs:sprite1.sprite_top
    sub     ax, [bp+arg_2]
    jle     short loc_35BB6
    sub     [bp+arg_6], ax
    jle     short loc_35BCD
    mov     ax, cs:sprite1.sprite_top
    mov     [bp+arg_2], ax
loc_35BB6:
    mov     ax, [bp+arg_2]
    add     ax, [bp+arg_6]
    mov     bx, cs:sprite1.sprite_height
    sub     ax, bx
    jle     short loc_35BD5
    sub     [bp+arg_6], ax
    jle     short loc_35BCD
    jmp     short loc_35BD5
    db 144
loc_35BCD:
    jmp     short loc_35C25
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    push    si
    push    di
loc_35BD5:
    cld
    cmp     [bp+arg_4], 0
    jle     short loc_35BCD
    cmp     [bp+arg_6], 0
    jle     short loc_35BCD
    mov     es, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     al, [bp+arg_8]
    mov     ah, al
    mov     dx, [bp+arg_0]
    mov     si, [bp+arg_6]
    mov     bx, [bp+arg_2]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+arg_0]
    mov     dx, cs:sprite1.sprite_pitch
    sub     dx, [bp+arg_4]
    mov     cx, [bp+arg_4]
loc_35C0D:
    sar     cx, 1
    mov     [bp+arg_4], cx
    jb      short loc_35C29
    jle     short loc_35C25
loc_35C16:
    mov     cx, [bp+arg_4]
loc_35C19:
    xor     es:[di], ax
    inc     di
    inc     di
    loop    loc_35C19
    add     di, dx
    dec     si
    jg      short loc_35C16
loc_35C25:
    pop     di
    pop     si
    pop     bp
    retf
loc_35C29:
    jz      short loc_35C42
    jl      short loc_35C25
    inc     dx
loc_35C2E:
    mov     cx, [bp+arg_4]
loc_35C31:
    xor     es:[di], ax
    inc     di
    inc     di
    loop    loc_35C31
    xor     es:[di], al
    add     di, dx
    dec     si
    jg      short loc_35C2E
    jmp     short loc_35C25
loc_35C42:
    inc     dx
loc_35C43:
    xor     es:[di], al
    add     di, dx
    dec     si
    jg      short loc_35C43
    jmp     short loc_35C25
    ; align 2
    db 0
sub_35B76 endp
sub_35C4E proc far
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
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
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
    sub     sp, 6
    push    si
    push    di
    push    ds
    cld
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     ax, word ptr cs:sprite2.sprite_bitmapptr+2
    mov     ds, ax
    mov     ax, [bp+arg_0]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_4]
    mov     ax, [bp+arg_2]
    shl     ax, 1
    mov     cx, ax
    add     ax, cs:sprite2.sprite_lineofs
    mov     [bp+var_4], ax
    add     cx, cs:sprite1.sprite_lineofs
    mov     ax, [bp+arg_8]
    mov     bx, ax
    add     ax, [bp+arg_0]
    cwd
    idiv    cs:sprite1.sprite_width2
    sub     dx, [bp+arg_0]
    shl     ax, 1
    add     cx, ax
    add     [bp+var_2], dx
    mov     [bp+var_6], cx
    mov     dx, [bp+arg_6]
loc_35C9F:
    mov     cx, [bp+arg_4]
    mov     bx, [bp+var_4]
    mov     si, cs:[bx]
    add     si, [bp+arg_0]
    mov     bx, [bp+var_6]
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    rep movsb
    add     [bp+var_4], 2
    add     [bp+var_6], 2
    dec     dx
    jg      short loc_35C9F
    pop     ds
    pop     di
    pop     si
    mov     sp, bp
    pop     bp
    retf
incnums     db 0
    db 1
    db 2
    db 3
    db 4
    db 5
    db 6
    db 7
    db 8
    db 9
    db 10
    db 11
    db 12
    db 13
    db 14
    db 15
    db 16
    db 17
    db 18
    db 19
    db 20
    db 21
    db 22
    db 23
    db 24
    db 25
    db 26
    db 27
    db 28
    db 29
    db 30
    db 31
    db 32
    db 33
    db 34
    db 35
    db 36
    db 37
    db 38
    db 39
    db 40
    db 41
    db 42
    db 43
    db 44
    db 45
    db 46
    db 47
    db 48
    db 49
    db 50
    db 51
    db 52
    db 53
    db 54
    db 55
    db 56
    db 57
    db 58
    db 59
    db 60
    db 61
    db 62
    db 63
    db 64
    db 65
    db 66
    db 67
    db 68
    db 69
    db 70
    db 71
    db 72
    db 73
    db 74
    db 75
    db 76
    db 77
    db 78
    db 79
    db 80
    db 81
    db 82
    db 83
    db 84
    db 85
    db 86
    db 87
    db 88
    db 89
    db 90
    db 91
    db 92
    db 93
    db 94
    db 95
    db 96
    db 97
    db 98
    db 99
    db 100
    db 101
    db 102
    db 103
    db 104
    db 105
    db 106
    db 107
    db 108
    db 109
    db 110
    db 111
    db 112
    db 113
    db 114
    db 115
    db 116
    db 117
    db 118
    db 119
    db 120
    db 121
    db 122
    db 123
    db 124
    db 125
    db 126
    db 127
    db 128
    db 129
    db 130
    db 131
    db 132
    db 133
    db 134
    db 135
    db 136
    db 137
    db 138
    db 139
    db 140
    db 141
    db 142
    db 143
    db 144
    db 145
    db 146
    db 147
    db 148
    db 149
    db 150
    db 151
    db 152
    db 153
    db 154
    db 155
    db 156
    db 157
    db 158
    db 159
    db 160
    db 161
    db 162
    db 163
    db 164
    db 165
    db 166
    db 167
    db 168
    db 169
    db 170
    db 171
    db 172
    db 173
    db 174
    db 175
    db 176
    db 177
    db 178
    db 179
    db 180
    db 181
    db 182
    db 183
    db 184
    db 185
    db 186
    db 187
    db 188
    db 189
    db 190
    db 191
    db 192
    db 193
    db 194
    db 195
    db 196
    db 197
    db 198
    db 199
    db 200
    db 201
    db 202
    db 203
    db 204
    db 205
    db 206
    db 207
    db 208
    db 209
    db 210
    db 211
    db 212
    db 213
    db 214
    db 215
    db 216
    db 217
    db 218
    db 219
    db 220
    db 221
    db 222
    db 223
    db 224
    db 225
    db 226
    db 227
    db 228
    db 229
    db 230
    db 231
    db 232
    db 233
    db 234
    db 235
    db 236
    db 237
    db 238
    db 239
    db 240
    db 241
    db 242
    db 243
    db 244
    db 245
    db 246
    db 247
    db 248
    db 249
    db 250
    db 251
    db 252
    db 253
    db 254
    db 255
sub_35C4E endp
sub_35DC8 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    mov     cx, (offset byte_3B85E+12h)
    mov     ds, [bp+arg_2]
    mov     si, [bp+arg_0]
    mov     ax, cs
    mov     es, ax
    mov     di, offset word_42A18
    cld
    rep movsb
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
sub_35DC8 endp
sub_35DE6 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8
    arg_4 = word ptr 10
    arg_6 = word ptr 12

    push    bp
    mov     bp, sp
    push    ds
    push    si
    push    di
    mov     cx, [bp+arg_2]
    mov     ds, [bp+arg_6]
    mov     si, [bp+arg_0]
    mov     ax, cs
    mov     es, ax
    lea     di, incnums[si]
    mov     si, [bp+arg_4]
loc_35E00:
    cld
loc_35E01:
    rep movsb
    pop     di
    pop     si
    pop     ds
    pop     bp
    retf
sub_35DE6 endp
sub_35E08 proc far
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
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
    arg_4 = word ptr 10
    arg_6 = word ptr 12
    arg_8 = word ptr 14

    push    bp
    mov     bp, sp
loc_35E0B:
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
loc_35E14:
    mov     si, [bp+arg_2]
    mov     cx, [bp+arg_6]
    mov     ax, [si+4]
    imul    [bp+arg_0]
    sub     cl, ah
    sbb     ch, dl
    mov     [bp+var_2], cx
    mov     cx, [bp+arg_8]
    mov     ax, [si+6]
    imul    [bp+arg_0]
    sub     cl, ah
    sbb     ch, dl
    mov     [bp+var_4], cx
    jmp     short loc_35E7A
    ; align 2
    db 144
    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [bp+arg_6]
    mov     [bp+var_2], ax
    mov     ax, [bp+arg_8]
    mov     [bp+var_4], ax
    jmp     short loc_35E7A
    ; align 2
    db 144
loc_35E58:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
    push    bp
    mov     bp, sp
    sub     sp, 16h
    push    ds
    push    si
    push    di
    mov     ds, [bp+arg_4]
    mov     si, [bp+arg_2]
    mov     ax, [si+8]
    mov     [bp+var_2], ax
    mov     ax, [si+0Ah]
    mov     [bp+var_4], ax
loc_35E7A:
    cmp     [bp+arg_0], 2
    jb      short loc_35E58
    cld
    mov     ax, [si+2]
    mul     [bp+arg_0]
    mov     al, ah
    mov     ah, dl
    or      ax, ax
    jz      short loc_35E58
    mov     [bp+var_8], ax
    mov     ax, [si]
    mov     [bp+var_A], ax
    mul     [bp+arg_0]
    mov     al, ah
    mov     ah, dl
    or      ax, ax
    jz      short loc_35E58
    mov     [bp+var_6], ax
    mov     dx, cs:sprite1.sprite_pitch
    sub     dx, ax
    mov     [bp+var_C], dx
    add     si, 10h
    mov     dx, 1
    xor     ax, ax
    mov     [bp+var_14], ax
    mov     [bp+var_12], ax
    div     [bp+arg_0]
    mov     dx, ax
    mov     al, ah
    xor     ah, ah
    shr     ax, 1
    jz      short loc_35ED3
    add     si, ax
    mov     cx, ax
loc_35ECE:
    add     si, [bp+var_A]
    loop    loc_35ECE
loc_35ED3:
    mov     [bp+var_E], si
    mov     [bp+var_10], dx
    var_14 = word ptr -20
    var_12 = word ptr -18
    var_10 = word ptr -16
    var_E = word ptr -14
    var_C = word ptr -12
    var_A = word ptr -10
    var_8 = word ptr -8
    var_6 = word ptr -6
    var_4 = word ptr -4
    var_2 = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_shapeptr = dword ptr 8
    arg_6 = word ptr 12
    arg_8 = word ptr 14
loc_35ED9:
    mov     ax, word ptr cs:sprite1.sprite_bitmapptr+2
    mov     es, ax
    mov     bx, [bp+var_4]
    shl     bx, 1
    add     bx, cs:sprite1.sprite_lineofs
    mov     di, cs:[bx]
    add     di, [bp+var_2]
    mov     dx, [bp+var_10]
    mov     ax, [bp+var_12]
    mov     ss:54AAh, ax
loc_35EF9:
    mov     cx, [bp+var_6]
    mov     bx, [bp+var_14]
loc_35EFF:
    mov     al, [si]
    cmp     al, 0FFh
    jz      short loc_35F08
    mov     es:[di], al
loc_35F08:
    inc     di
    add     bx, dx
    mov     al, bh
    xor     ah, ah
    add     si, ax
    xor     bh, bh
    loop    loc_35EFF
    dec     [bp+var_8]
    jle     short loc_35F40
    add     di, [bp+var_C]
    mov     si, [bp+var_E]
    add     ss:54AAh, dx
    mov     cl, ss:54ABh
    or      cl, cl
    jz      short loc_35EF9
    xor     ch, ch
loc_35F30:
    add     si, [bp+var_A]
    loop    loc_35F30
    mov     byte ptr ss:54ABh, 0
    mov     [bp+var_E], si
    jmp     short loc_35EF9
loc_35F40:
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
    ; align 2
    db 0
sub_35E08 endp
file_load_shape2d_palmap_apply proc far
    shapecounter = word ptr -4
    var_shapecount = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_memchunkoff = word ptr 6
    arg_memchunkseg = word ptr 8
    arg_palmap = word ptr 10

    push    bp
    mov     bp, sp
    sub     sp, 4
    push    di
    push    si
    mov     es, [bp+arg_memchunkseg]
    mov     di, [bp+arg_memchunkoff]
    mov     si, [bp+arg_palmap]
    mov     cx, es:[di+4]
    mov     [bp+var_shapecount], cx
    xor     ax, ax
    mov     [bp+shapecounter], ax
loc_35F65:
    mov     ax, [bp+shapecounter]
    cmp     ax, [bp+var_shapecount]
    jl      short loc_35F73
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_35F73:
    push    ax
    push    [bp+arg_memchunkseg]
    push    [bp+arg_memchunkoff]
    call    file_get_shape2d
    add     sp, 6
    mov     es, dx
    mov     di, ax
    mov     ax, es:[di+SHAPE2D.s2d_width]
    mul     es:[di+SHAPE2D.s2d_height]
    mov     cx, ax
    add     di, size SHAPE2D
    xor     bx, bx
loc_35F94:
    mov     bl, es:[di]
    mov     al, [bx+si]
    stosb
    loop    loc_35F94
    inc     [bp+shapecounter]
    jmp     short loc_35F65
    ; align 2
    db 0
file_load_shape2d_palmap_apply endp
file_load_shape2d_expand proc far
    var_dstshapeoff = word ptr -16
    var_length = word ptr -14
    var_srcshapeoff = word ptr -12
    var_srcshapeseg = word ptr -10
    var_srcdataoff = word ptr -8
    var_offsets = word ptr -6
    var_shapecounter = word ptr -4
    var_shapecount = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_memchunkoff = word ptr 6
    arg_memchunkseg = word ptr 8
    arg_mempagesoff = word ptr 10
    arg_mempagesseg = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 10h
    push    di
    push    si
    push    ds
    mov     ds, [bp+arg_memchunkseg]
    mov     si, [bp+arg_memchunkoff]
    mov     es, [bp+arg_mempagesseg]
    mov     di, [bp+arg_mempagesoff]
    mov     cx, [si+4]
    mov     [bp+var_shapecount], cx
    shl     cx, 1
    add     cx, 1
    add     si, 4
    add     di, 4
    rep movsw
    xor     ax, ax
loc_35FCC:
    mov     [bp+var_shapecounter], ax
    mov     [bp+var_offsets], di
    mov     es:[di], ax
    mov     es:[di+2], ax
loc_35FD9:
    mov     ax, [bp+var_shapecounter]
    cmp     ax, [bp+var_shapecount]
    jl      short loc_35FE8
    pop     ds
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
loc_35FE8:
    push    ax
loc_35FE9:
    push    [bp+arg_memchunkseg]
loc_35FEC:
    push    [bp+arg_memchunkoff]
    mov     ax, ss
    mov     ds, ax
    call    file_get_shape2d
    add     sp, 6
    mov     ds, dx
    mov     si, ax
    mov     [bp+var_srcshapeseg], dx
    mov     [bp+var_srcshapeoff], ax
    mov     es, [bp+arg_mempagesseg]
    mov     di, [bp+var_offsets]
    mov     bx, es:[di]
    mov     cx, es:[di+2]
    add     di, 4
    mov     [bp+var_offsets], di
    mov     ax, [si]
    mul     word ptr [si+2]
    mov     [bp+var_length], ax
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    add     ax, size SHAPE2D
    add     ax, bx
    adc     dx, cx
    mov     bx, [bp+var_shapecounter]
    inc     bx
    cmp     bx, [bp+var_shapecount]
    jge     short loc_36040
    mov     es:[di], ax
    mov     es:[di+2], dx
    jmp     short loc_3605B
    ; align 2
    db 144
loc_36040:
    mov     bx, [bp+var_shapecount]
    shl     bx, 1
    shl     bx, 1
    shl     bx, 1
    add     bx, 6
    add     ax, bx
    adc     dx, 0
    mov     di, [bp+arg_mempagesoff]
    mov     es:[di], ax
    mov     es:[di+2], dx
loc_3605B:
    push    [bp+var_shapecounter]
    push    [bp+arg_mempagesseg]
    push    [bp+arg_mempagesoff]
    mov     ax, ss
    mov     ds, ax
    call    file_get_shape2d
loc_3606D:
    add     sp, 6
loc_36070:
    mov     es, dx
    mov     di, ax
    mov     [bp+var_dstshapeoff], ax
    mov     ds, [bp+var_srcshapeseg]
    mov     cx, 6
    rep movsw
    mov     si, [bp+var_srcshapeoff]
loc_36082:
    mov     di, [bp+var_dstshapeoff]
    mov     ax, [si]
    shl     ax, 1
    shl     ax, 1
    shl     ax, 1
    mov     es:[di], ax
    mov     al, [si+SHAPE2D.s2d_unk4]
loc_36093:
    shr     al, 1
    shr     al, 1
    shr     al, 1
    shr     al, 1
    mov     ah, al
    add     di, size SHAPE2D
loc_360A0:
    mov     cx, [bp+var_length]
    cmp     cx, 0
    jle     short loc_360EF
    cmp     cx, 1F40h
    jg      short loc_360EF
    shl     cx, 1
    shl     cx, 1
    rep stosw
loc_360B4:
    add     si, 10h
    mov     [bp+var_srcdataoff], si
    xor     bx, bx
loc_360BC:
    mov     si, [bp+var_srcshapeoff]
    mov     ah, [bx+si+SHAPE2D.s2d_unk3]
smart
    and     ah, 0Fh
nosmart
    jz      short loc_360EF
    mov     di, [bp+var_dstshapeoff]
    add     di, 10h
    mov     si, [bp+var_srcdataoff]
loc_360D0:
    mov     dx, [bp+var_length]
loc_360D3:
    lodsb
    mov     cx, 8
loc_360D7:
    shl     al, 1
    jnb     short loc_360DE
    or      es:[di], ah
loc_360DE:
    inc     di
    loop    loc_360D7
    dec     dx
    jg      short loc_360D3
    mov     [bp+var_srcdataoff], si
    shl     ah, 1
    inc     bx
    cmp     bx, 4
    jl      short loc_360BC
loc_360EF:
    inc     [bp+var_shapecounter]
    jmp     loc_35FD9
    ; align 2
    db 0
file_load_shape2d_expand endp
file_unflip_shape2d_pes proc far
    var_val = byte ptr -20
    var_iterations = byte ptr -18
    var_dataptr = word ptr -16
    var_length = word ptr -14
    var_height = word ptr -12
    var_width = word ptr -10
    var_shapeseg = word ptr -8
    var_shapeofs = word ptr -6
    var_shapecounter = word ptr -4
    var_shapecount = word ptr -2
     s = byte ptr 0
     r = byte ptr 2
    arg_memchunkoff = word ptr 6
    arg_memchunkseg = word ptr 8
    arg_mempagesoff = word ptr 10
    arg_mempagesseg = word ptr 12

    push    bp
    mov     bp, sp
    sub     sp, 14h
    push    ds
    push    si
    push    di
    mov     ax, [bp+arg_memchunkseg]
    mov     ds, ax
    mov     ax, [bp+arg_memchunkoff]
    mov     si, ax
    mov     bx, [si+4]
    mov     [bp+var_shapecount], bx
    mov     [bp+var_shapecounter], 0
loc_36114:
    push    [bp+var_shapecounter]
    push    [bp+arg_memchunkseg]
    push    [bp+arg_memchunkoff]
    mov     ax, seg dseg
    mov     ds, ax
    call    file_get_shape2d
    add     sp, 6
    mov     [bp+var_shapeofs], ax
    mov     [bp+var_shapeseg], dx
    mov     si, ax
    mov     ds, dx
    mov     al, [si+SHAPE2D.s2d_unk6]
loc_36137:
smart
    and     al, 0F0h
nosmart
    jnz     short loc_3614E
    mov     bl, [si+SHAPE2D.s2d_unk5]
    shr     bl, 1
    shr     bl, 1
    shr     bl, 1
    shr     bl, 1
smart
    and     bl, 0Fh
nosmart
    mov     [bp+var_val], bl
    jnz     short loc_3615D
loc_3614E:
    inc     [bp+var_shapecounter]
    dec     [bp+var_shapecount]
    jg      short loc_36114
    pop     di
    pop     si
    pop     ds
    mov     sp, bp
    pop     bp
    retf
loc_3615D:
    mov     ax, [si+SHAPE2D.s2d_width]
    mov     [bp+var_width], ax
loc_36162:
    mov     dx, [si+SHAPE2D.s2d_height]
    mov     [bp+var_height], dx
    mul     dx
    mov     [bp+var_length], ax
    add     si, size SHAPE2D
loc_36170:
    mov     [bp+var_dataptr], si
loc_36173:
    mov     [bp+var_iterations], 4
loc_36177:
    shr     [bp+var_val], 1
    jnb     short loc_361AF
loc_3617C:
    mov     es, [bp+arg_mempagesseg]
    mov     di, [bp+arg_mempagesoff]
loc_36182:
    mov     ds, [bp+var_shapeseg]
    xor     dx, dx
loc_36187:
    mov     bx, [bp+var_height]
loc_3618A:
    mov     si, [bp+var_dataptr]
    add     si, dx
    mov     cx, [bp+var_width]
loc_36192:
    mov     al, [si]
    stosb
loc_36195:
    add     si, bx
loc_36197:
    loop    loc_36192
    inc     dx
loc_3619A:
    cmp     dx, bx
    jnz     short loc_3618A
loc_3619E:
    mov     es, [bp+var_shapeseg]
loc_361A1:
    mov     di, [bp+var_dataptr]
loc_361A4:
    mov     ds, [bp+arg_mempagesseg]
loc_361A7:
    mov     si, [bp+arg_mempagesoff]
loc_361AA:
    mov     cx, [bp+var_length]
loc_361AD:
    rep movsb
loc_361AF:
    mov     ax, [bp+var_length]
loc_361B2:
    add     [bp+var_dataptr], ax
loc_361B5:
    dec     [bp+var_iterations]
loc_361B8:
    jnz     short loc_36177
loc_361BA:
    jmp     short loc_3614E
file_unflip_shape2d_pes endp
seg012 ends
end
