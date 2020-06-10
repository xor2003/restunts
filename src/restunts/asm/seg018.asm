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
seg018 segment byte public 'STUNTSC' use16
    assume cs:seg018
    assume es:nothing, ss:nothing, ds:dseg
    public kb_shift_checking1
    public kb_shift_checking2
locret_36AF2:
    retf
algn_36AF3:
    ; align 2
    db 144
kb_shift_checking1 proc far

    mov     ax, 40h ; '@'
loc_36AF7:
    mov     es, ax
loc_36AF9:
    or      byte ptr es:17h, 20h; 40h:17h = keyboard shift flags
loc_36AFF:
    call    kb_checking
locret_36B04:
    retf
kb_shift_checking1 endp
kb_shift_checking2 proc far

    mov     ax, 40h ; '@'
loc_36B08:
    mov     es, ax
loc_36B0A:
smart
    and     byte ptr es:17h, 0DFh; 40h:17h = keyboard shift flags
nosmart
loc_36B10:
    call    kb_checking
locret_36B15:
    retf
kb_shift_checking2 endp
seg018 ends
end
