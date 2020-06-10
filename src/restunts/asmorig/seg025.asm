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
seg025 segment byte public 'STUNTSC' use16
    assume cs:seg025
    assume es:nothing, ss:nothing, ds:dseg
    public sub_3702E
algn_3702D:
    ; align 2
    db 144
sub_3702E proc far
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
loc_3702F:
    mov     bp, sp
loc_37031:
    sub     sp, 4
loc_37034:
    push    si
loc_37035:
    mov     ax, [bp+arg_4]
loc_37038:
    sub     ax, [bp+arg_0]
    inc     ax
loc_3703C:
    mov     [bp+var_2], ax
loc_3703F:
    mov     ax, [bp+arg_6]
loc_37042:
    sub     ax, [bp+arg_2]
    dec     ax
loc_37046:
    mov     [bp+var_4], ax
loc_37049:
    cmp     [bp+var_2], 0
loc_3704D:
    jle     short loc_3707F
loc_3704F:
    push    [bp+arg_8]
loc_37052:
    mov     ax, 1
    push    ax
loc_37056:
    push    [bp+var_2]
loc_37059:
    push    [bp+arg_2]
loc_3705C:
    push    [bp+arg_0]
loc_3705F:
    call    sub_35B76
loc_37064:
    add     sp, 0Ah
loc_37067:
    push    [bp+arg_8]
loc_3706A:
    mov     ax, 1
    push    ax
loc_3706E:
    push    [bp+var_2]
loc_37071:
    push    [bp+arg_6]
loc_37074:
    push    [bp+arg_0]
loc_37077:
    call    sub_35B76
loc_3707C:
    add     sp, 0Ah
loc_3707F:
    cmp     [bp+var_4], 0
loc_37083:
    jle     short loc_370B5
    mov     si, [bp+arg_2]
loc_37088:
    inc     si
loc_37089:
    push    [bp+arg_8]
loc_3708C:
    push    [bp+var_4]
    mov     ax, 1
loc_37092:
    push    ax
    push    si
loc_37094:
    push    [bp+arg_0]
loc_37097:
    call    sub_35B76
loc_3709C:
    add     sp, 0Ah
loc_3709F:
    push    [bp+arg_8]
loc_370A2:
    push    [bp+var_4]
loc_370A5:
    mov     ax, 1
loc_370A8:
    push    ax
    push    si
loc_370AA:
    push    [bp+arg_4]
loc_370AD:
    call    sub_35B76
loc_370B2:
    add     sp, 0Ah
loc_370B5:
    pop     si
loc_370B6:
    mov     sp, bp
loc_370B8:
    pop     bp
locret_370B9:
    retf
sub_3702E endp
seg025 ends
end
