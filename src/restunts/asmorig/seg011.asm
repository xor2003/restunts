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
seg011 segment byte public 'STUNTSC' use16
    assume cs:seg011
    assume es:nothing, ss:nothing, ds:dseg
    public polarRadius3D
    ; align 2
    db 0
polarRadius3D proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_2EA09:
    mov     bp, sp
loc_2EA0B:
    mov     bx, [bp+arg_0]
loc_2EA0E:
    push    word ptr [bx+4]
loc_2EA11:
    push    word ptr [bx+2]
    push    word ptr [bx]
loc_2EA16:
    call    polarRadius2D
loc_2EA1B:
    add     sp, 4
loc_2EA1E:
    push    ax
loc_2EA1F:
    call    polarRadius2D
loc_2EA24:
    add     sp, 4
    pop     bp
locret_2EA28:
    retf
polarRadius3D endp
seg011 ends
end
