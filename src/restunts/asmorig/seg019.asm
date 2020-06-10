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
seg019 segment byte public 'STUNTSC' use16
    assume cs:seg019
    assume es:nothing, ss:nothing, ds:dseg
    public preRender_wheel_helper2
preRender_wheel_helper2 proc far
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
loc_36B17:
    mov     bp, sp
loc_36B19:
    sub     sp, 0Ch
loc_36B1C:
    push    si
loc_36B1D:
    mov     bx, [bp+arg_0]
loc_36B20:
    mov     ax, [bx]
loc_36B22:
    mov     dx, [bx+2]
loc_36B25:
    mov     [bp+var_C], ax
loc_36B28:
    mov     [bp+var_A], dx
loc_36B2B:
    mov     si, ax
loc_36B2D:
    push    [bp+arg_4]
loc_36B30:
    mov     ax, [bx+4]
loc_36B33:
    sub     ax, si
    push    ax
loc_36B36:
    call    multiply_and_scale
loc_36B3B:
    add     sp, 4
loc_36B3E:
    add     ax, si
loc_36B40:
    mov     [bp+var_8], ax
loc_36B43:
    push    [bp+arg_4]
loc_36B46:
    mov     bx, [bp+arg_0]
loc_36B49:
    mov     ax, [bx+6]
loc_36B4C:
    sub     ax, [bx+2]
    push    ax
loc_36B50:
    call    multiply_and_scale
loc_36B55:
    add     sp, 4
loc_36B58:
    mov     bx, [bp+arg_0]
loc_36B5B:
    mov     cx, [bx+2]
    add     cx, ax
    mov     [bp+var_6], cx
loc_36B63:
    push    [bp+arg_4]
    mov     ax, [bx+8]
    sub     ax, si
    push    ax
loc_36B6C:
    call    multiply_and_scale
loc_36B71:
    add     sp, 4
loc_36B74:
    add     ax, si
loc_36B76:
    mov     [bp+var_4], ax
    push    [bp+arg_4]
loc_36B7C:
    mov     bx, [bp+arg_0]
    mov     ax, [bx+0Ah]
loc_36B82:
    sub     ax, [bx+2]
    push    ax
loc_36B86:
    call    multiply_and_scale
loc_36B8B:
    add     sp, 4
    mov     bx, [bp+arg_0]
loc_36B91:
    mov     cx, [bx+2]
    add     cx, ax
loc_36B96:
    mov     [bp+var_2], cx
loc_36B99:
    push    [bp+arg_2]
loc_36B9C:
    push    bx
loc_36B9D:
    call    preRender_wheel_helper3
loc_36BA2:
    add     sp, 4
loc_36BA5:
    mov     ax, [bp+arg_2]
loc_36BA8:
    add     ax, 40h ; '@'
    push    ax
loc_36BAC:
    lea     ax, [bp+var_C]
    push    ax
loc_36BB0:
    call    preRender_wheel_helper3
loc_36BB5:
    add     sp, 4
loc_36BB8:
    pop     si
loc_36BB9:
    mov     sp, bp
    pop     bp
locret_36BBC:
    retf
preRender_wheel_helper2 endp
seg019 ends
end
