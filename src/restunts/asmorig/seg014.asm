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
seg014 segment byte public 'STUNTSC' use16
    assume cs:seg014
    assume es:nothing, ss:nothing, ds:dseg
    public preRender_wheel_helper3
algn_36245:
    ; align 2
    db 144
preRender_wheel_helper3 proc far
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
loc_36247:
    mov     bp, sp
loc_36249:
    sub     sp, 0Ah
loc_3624C:
    push    di
loc_3624D:
    push    si
loc_3624E:
    mov     bx, [bp+arg_0]
loc_36251:
    mov     si, [bx]
loc_36253:
    mov     ax, [bx+4]
loc_36256:
    sub     ax, si
loc_36258:
    mov     bx, [bp+arg_2]
loc_3625B:
    mov     [bx], ax
loc_3625D:
    mov     bx, [bp+arg_0]
loc_36260:
    mov     ax, [bx+6]
loc_36263:
    sub     ax, [bx+2]
loc_36266:
    mov     bx, [bp+arg_2]
loc_36269:
    mov     [bx+2], ax
loc_3626C:
    mov     bx, [bp+arg_0]
loc_3626F:
    mov     ax, [bx+8]
loc_36272:
    sub     ax, si
loc_36274:
    mov     bx, [bp+arg_2]
loc_36277:
    mov     [bx+10h], ax
loc_3627A:
    mov     bx, [bp+arg_0]
loc_3627D:
    mov     ax, [bx+0Ah]
loc_36280:
    sub     ax, [bx+2]
loc_36283:
    mov     bx, [bp+arg_2]
loc_36286:
    mov     [bx+12h], ax
loc_36289:
    mov     ax, 2D41h
loc_3628C:
    push    ax
    mov     ax, [bx+10h]
    add     ax, [bx]
    push    ax
loc_36293:
    call    multiply_and_scale
    add     sp, 4
loc_3629B:
    mov     bx, [bp+arg_2]
    mov     [bx+8], ax
    mov     ax, 2D41h
loc_362A4:
    push    ax
    mov     ax, [bx+2]
    add     ax, [bx+12h]
    push    ax
loc_362AC:
    call    multiply_and_scale
    add     sp, 4
loc_362B4:
    mov     bx, [bp+arg_2]
loc_362B7:
    mov     [bx+0Ah], ax
    mov     si, [bx+10h]
    sar     si, 1
    mov     ax, offset unk_3F0AE
    push    ax
    mov     ax, [bx]
    add     ax, si
    push    ax
loc_362C8:
    call    multiply_and_scale
loc_362CD:
    add     sp, 4
loc_362D0:
    mov     bx, [bp+arg_2]
    mov     [bx+4], ax
    mov     di, [bx+12h]
    sar     di, 1
    mov     ax, 393Eh
    push    ax
    mov     ax, [bx+2]
loc_362E2:
    add     ax, di
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_2]
    mov     [bx+6], ax
loc_362F3:
    mov     ax, [bx]
    sar     ax, 1
    mov     [bp+var_4], ax
loc_362FA:
    mov     ax, 393Eh
loc_362FD:
    push    ax
loc_362FE:
    mov     ax, [bx+10h]
loc_36301:
    add     ax, [bp+var_4]
loc_36304:
    push    ax
loc_36305:
    call    multiply_and_scale
loc_3630A:
    add     sp, 4
loc_3630D:
    mov     bx, [bp+arg_2]
loc_36310:
    mov     [bx+0Ch], ax
    mov     ax, [bx+2]
loc_36316:
    sar     ax, 1
    mov     [bp+var_6], ax
    mov     ax, 393Eh
loc_3631E:
    push    ax
    mov     ax, [bx+12h]
    add     ax, [bp+var_6]
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_2]
loc_36331:
    mov     [bx+0Eh], ax
    mov     ax, [bx]
    neg     ax
    mov     [bp+var_8], ax
    mov     ax, 2D41h
    push    ax
    mov     ax, [bx+10h]
    add     ax, [bp+var_8]
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_2]
    mov     [bx+18h], ax
    mov     ax, [bx+2]
    neg     ax
    mov     [bp+var_A], ax
    mov     ax, 2D41h
    push    ax
    mov     ax, [bx+12h]
    add     ax, [bp+var_A]
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_2]
    mov     [bx+1Ah], ax
    mov     ax, 393Eh
    push    ax
    mov     ax, [bp+var_8]
    add     ax, si
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_2]
    mov     [bx+1Ch], ax
    mov     ax, 393Eh
    push    ax
    mov     ax, [bp+var_A]
    add     ax, di
    push    ax
loc_36397:
    call    multiply_and_scale
    add     sp, 4
    mov     bx, [bp+arg_2]
    mov     [bx+1Eh], ax
    mov     ax, 393Eh
    push    ax
    mov     ax, [bx+10h]
    sub     ax, [bp+var_4]
    push    ax
    call    multiply_and_scale
    add     sp, 4
loc_363B8:
    mov     bx, [bp+arg_2]
    mov     [bx+14h], ax
    mov     ax, 393Eh
    push    ax
loc_363C2:
    mov     ax, [bx+12h]
    sub     ax, [bp+var_6]
    push    ax
    call    multiply_and_scale
loc_363CE:
    add     sp, 4
loc_363D1:
    mov     bx, [bp+arg_2]
loc_363D4:
    mov     [bx+16h], ax
loc_363D7:
    mov     [bp+var_2], 0
loc_363DC:
    mov     si, [bp+var_2]
    mov     cl, 2
loc_363E1:
    shl     si, cl
loc_363E3:
    add     si, [bp+arg_2]
loc_363E6:
    mov     bx, [bp+arg_0]
loc_363E9:
    mov     di, [bx]
loc_363EB:
    mov     ax, di
    sub     ax, [si]
    mov     [si+20h], ax
loc_363F2:
    mov     ax, [bx+2]
loc_363F5:
    sub     ax, [si+2]
loc_363F8:
    mov     [si+22h], ax
    add     [si], di
loc_363FD:
    mov     ax, [bx+2]
loc_36400:
    add     [si+2], ax
    inc     [bp+var_2]
loc_36406:
    cmp     [bp+var_2], 8
loc_3640A:
    jl      short loc_363DC
loc_3640C:
    pop     si
    pop     di
loc_3640E:
    mov     sp, bp
loc_36410:
    pop     bp
locret_36411:
    retf
preRender_wheel_helper3 endp
seg014 ends
end
