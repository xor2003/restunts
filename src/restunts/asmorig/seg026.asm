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
seg026 segment byte public 'STUNTSC' use16
    assume cs:seg026
    assume es:nothing, ss:nothing, ds:dseg
    public toupper
toupper proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    cmp     [bp+arg_0], 61h ; 'a'
    jl      short loc_370CD
    cmp     [bp+arg_0], 7Ah ; 'z'
    jg      short loc_370CD
    sub     [bp+arg_0], 20h ; ' '
loc_370CD:
    mov     ax, [bp+arg_0]
    pop     bp
    retf
toupper endp
seg026 ends
end
