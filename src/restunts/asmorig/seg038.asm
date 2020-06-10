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
    include seg039.inc
    include dseg.inc
    include seg041.inc
seg038 segment byte public 'STUNTSD' use16
    assume cs:seg038
    assume es:nothing, ss:nothing, ds:dseg
    public plan_memres
    public unk_3B1E2
    public unk_3B1E4
    public unk_3B1E6
    public unk_3B1E8
    public unk_3B1EA
    public unk_3B1EC
    public unk_3B1EE
plan_memres     db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 32
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
unk_3B1E2     db 0
    db 0
unk_3B1E4     db 0
    db 0
unk_3B1E6     db 0
    db 0
unk_3B1E8     db 0
    db 0
unk_3B1EA     db 0
    db 0
unk_3B1EC     db 0
    db 0
unk_3B1EE     db 0
    db 0
seg038 ends
end
