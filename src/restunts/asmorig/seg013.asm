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
seg013 segment byte public 'STUNTSC' use16
    assume cs:seg013
    assume es:nothing, ss:nothing, ds:dseg
    public sprite_1_unk4
sprite_1_unk4 proc far
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
loc_361BD:
    mov     bp, sp
loc_361BF:
    sub     sp, 4
loc_361C2:
    mov     ax, [bp+arg_4]
loc_361C5:
    sub     ax, [bp+arg_0]
loc_361C8:
    inc     ax
loc_361C9:
    mov     [bp+var_2], ax
loc_361CC:
    mov     ax, [bp+arg_6]
loc_361CF:
    sub     ax, [bp+arg_2]
loc_361D2:
    mov     [bp+var_4], ax
loc_361D5:
    cmp     [bp+var_2], 0
loc_361D9:
    jle     short loc_3620B
loc_361DB:
    push    [bp+arg_8]
loc_361DE:
    mov     ax, 1
    push    ax
loc_361E2:
    push    [bp+var_2]
loc_361E5:
    push    [bp+arg_2]
loc_361E8:
    push    [bp+arg_0]
loc_361EB:
    call    sprite_1_unk2
loc_361F0:
    add     sp, 0Ah
loc_361F3:
    push    [bp+arg_8]
loc_361F6:
    mov     ax, 1
    push    ax
loc_361FA:
    push    [bp+var_2]
    push    [bp+arg_6]
loc_36200:
    push    [bp+arg_0]
loc_36203:
    call    sprite_1_unk2
loc_36208:
    add     sp, 0Ah
loc_3620B:
    cmp     [bp+var_4], 0
    jle     short loc_36241
loc_36211:
    push    [bp+arg_8]
loc_36214:
    push    [bp+var_4]
loc_36217:
    mov     ax, 1
loc_3621A:
    push    ax
loc_3621B:
    push    [bp+arg_2]
    push    [bp+arg_0]
loc_36221:
    call    sprite_1_unk2
loc_36226:
    add     sp, 0Ah
loc_36229:
    push    [bp+arg_8]
loc_3622C:
    push    [bp+var_4]
loc_3622F:
    mov     ax, 1
loc_36232:
    push    ax
    push    [bp+arg_2]
loc_36236:
    push    [bp+arg_4]
loc_36239:
    call    sprite_1_unk2
loc_3623E:
    add     sp, 0Ah
loc_36241:
    mov     sp, bp
loc_36243:
    pop     bp
locret_36244:
    retf
sprite_1_unk4 endp
seg013 ends
end
