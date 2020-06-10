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
seg020 segment byte public 'STUNTSC' use16
    assume cs:seg020
    assume es:nothing, ss:nothing, ds:dseg
    public preRender_sphere_helper
algn_36BBD:
    ; align 2
    db 144
preRender_sphere_helper proc far
    var_80 = byte ptr -128
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6
    arg_2 = word ptr 8

    push    bp
loc_36BBF:
    mov     bp, sp
    sub     sp, 80h
loc_36BC5:
    lea     ax, [bp+var_80]
loc_36BC8:
    push    ax
    push    [bp+arg_0]
loc_36BCC:
    call    preRender_sphere_helper2
loc_36BD1:
    add     sp, 4
loc_36BD4:
    lea     ax, [bp+var_80]
    push    ax
loc_36BD8:
    mov     ax, 20h ; ' '
    push    ax
loc_36BDC:
    push    [bp+arg_2]
loc_36BDF:
    call    preRender_default_alt
loc_36BE4:
    mov     sp, bp
loc_36BE6:
    pop     bp
    retf
preRender_sphere_helper endp
seg020 ends
end
