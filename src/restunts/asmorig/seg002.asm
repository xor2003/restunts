.model medium
nosmart
    include structs.inc
    include custom.inc
    include seg000.inc
    include seg001.inc
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
    include seg038.inc
    include seg039.inc
    include dseg.inc
    include seg041.inc
seg002 segment byte public 'STUNTSC' use16
    assume cs:seg002
    assume es:nothing, ss:nothing, ds:dseg
    public update_rpm_from_speed
    public nopsub_19DE8
    public nopsub_19DFF
    public nopsub_19E09
    public nopsub_19E13
    public init_kevinrandom
    public get_kevinrandom_seed
    public get_kevinrandom
    public intr0_handler
    public init_div0
    public byte_19F07
algn_19DC5:
    ; align 2
    db 144
update_rpm_from_speed proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_currRpm = word ptr 6
    arg_speed = word ptr 8
    arg_gearRatio = word ptr 10
    arg_isChangingGear = word ptr 12
    arg_idleRpm = word ptr 14

    push    bp
    mov     bp, sp
    push    bp
    mov     cx, [bp+arg_currRpm]
    mov     ax, [bp+arg_speed]
    cmp     [bp+arg_isChangingGear], 0
    jnz     short loc_19DDB
    mul     [bp+arg_gearRatio]
    mov     cx, dx
loc_19DDB:
    cmp     cx, [bp+arg_idleRpm]
    jnb     short loc_19DE3
    mov     cx, [bp+arg_idleRpm]
loc_19DE3:
    mov     ax, cx
    pop     bp
    pop     bp
    retf
update_rpm_from_speed endp
nopsub_19DE8 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_19DE9:
    mov     bp, sp
    push    bp
loc_19DEC:
    xor     ax, ax
loc_19DEE:
    mov     bx, [bp+arg_0]
loc_19DF1:
    or      bx, bx
loc_19DF3:
    jz      short loc_19DFC
loc_19DF5:
    jl      short loc_19DFB
loc_19DF7:
    inc     ax
loc_19DF8:
    pop     bp
    pop     bp
locret_19DFA:
    retf
loc_19DFB:
    dec     ax
loc_19DFC:
    pop     bp
    pop     bp
locret_19DFE:
    retf
nopsub_19DE8 endp
nopsub_19DFF proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_19E00:
    mov     bp, sp
loc_19E02:
    mov     ax, [bp+arg_0]
loc_19E05:
    int     61h             ; reserved for user interrupt
    pop     bp
locret_19E08:
    retf
nopsub_19DFF endp
nopsub_19E09 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_19E0A:
    mov     bp, sp
loc_19E0C:
    mov     ax, [bp+arg_0]
    int     60h
    pop     bp
    retf
nopsub_19E09 endp
nopsub_19E13 proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
loc_19E14:
    mov     bp, sp
loc_19E16:
    push    bp
    push    si
    mov     si, [bp+arg_0]
loc_19E1B:
    int     62h             ; reserved for user interrupt
    pop     si
loc_19E1E:
    pop     bp
    pop     bp
    retf
nopsub_19E13 endp
init_kevinrandom proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
loc_19E24:
    push    bp
    mov     bx, [bp+arg_0]
    mov     al, [bx]
loc_19E2A:
    mov     g_kevinrandom_seed, al
    mov     al, [bx+1]
loc_19E30:
    mov     g_kevinrandom_seed+1, al
loc_19E33:
    mov     al, [bx+2]
loc_19E36:
    mov     g_kevinrandom_seed+2, al
    mov     al, [bx+3]
    mov     g_kevinrandom_seed+3, al
    mov     al, [bx+4]
    mov     g_kevinrandom_seed+4, al
    mov     al, [bx+5]
    mov     g_kevinrandom_seed+5, al
    pop     bp
loc_19E4C:
    pop     bp
    retf
init_kevinrandom endp
get_kevinrandom_seed proc far
     s = byte ptr 0
     r = byte ptr 2
    arg_0 = word ptr 6

    push    bp
    mov     bp, sp
    push    bp
    mov     bx, [bp+arg_0]
    mov     al, g_kevinrandom_seed
    mov     [bx], al
    mov     al, g_kevinrandom_seed+1
    mov     [bx+1], al
    mov     al, g_kevinrandom_seed+2
    mov     [bx+2], al
    mov     al, g_kevinrandom_seed+3
    mov     [bx+3], al
    mov     al, g_kevinrandom_seed+4
    mov     [bx+4], al
loc_19E72:
    mov     al, g_kevinrandom_seed+5
    mov     [bx+5], al
    pop     bp
    pop     bp
    retf
get_kevinrandom_seed endp
get_kevinrandom proc far

    mov     al, g_kevinrandom_seed+5
loc_19E7E:
    add     al, g_kevinrandom_seed+4
loc_19E82:
    mov     g_kevinrandom_seed+4, al
loc_19E85:
    add     al, g_kevinrandom_seed+3
loc_19E89:
    mov     g_kevinrandom_seed+3, al
loc_19E8C:
    add     al, g_kevinrandom_seed+2
loc_19E90:
    mov     g_kevinrandom_seed+2, al
    add     al, g_kevinrandom_seed+1
loc_19E97:
    mov     g_kevinrandom_seed+1, al
    add     al, g_kevinrandom_seed
    mov     g_kevinrandom_seed, al
    inc     g_kevinrandom_seed+5
    jnz     short loc_19EC3
    inc     g_kevinrandom_seed+4
    jnz     short loc_19EC3
    inc     g_kevinrandom_seed+3
    jnz     short loc_19EC3
    inc     g_kevinrandom_seed+2
    jnz     short loc_19EC3
    inc     g_kevinrandom_seed+1
    jnz     short loc_19EC3
    inc     g_kevinrandom_seed
loc_19EC3:
    mov     al, g_kevinrandom_seed
    xor     ah, ah
    retf
get_kevinrandom endp
intr0_handler proc far
     s = byte ptr 0
     r = byte ptr 2

    push    bp
    mov     bp, sp
    push    ds
    mov     ax, seg dseg
loc_19ED0:
    mov     ds, ax
loc_19ED2:
    mov     ax, [bp+4]
loc_19ED5:
    mov     word_3BE30, ax
loc_19ED8:
    mov     ax, [bp+2]
    mov     word_3BE32, ax
loc_19EDE:
    inc     ax
    inc     ax
loc_19EE0:
    mov     [bp+2], ax
loc_19EE3:
    xor     ax, ax
    pop     ds
    pop     bp
    iret
intr0_handler endp
init_div0 proc far

    push    ds
loc_19EE9:
    mov     ah, 35h ; '5'
loc_19EEB:
    mov     al, 0
    int     21h             ; DOS - 2+ - GET INTERRUPT VECTOR
loc_19EEF:
    mov     word ptr old_intr0_handler+2, es
loc_19EF3:
    mov     word ptr old_intr0_handler, bx
loc_19EF7:
    mov     dx, seg seg002
loc_19EFA:
    mov     ds, dx
loc_19EFC:
    mov     dx, offset intr0_handler
loc_19EFF:
    mov     ah, 25h ; '%'
loc_19F01:
    mov     al, 0
    int     21h             ; DOS - SET INTERRUPT VECTOR
    pop     ds
locret_19F06:
    retf
byte_19F07     db 30
    db 197
    db 22
    db 188
    db 6
    db 180
    db 37
    db 176
    db 0
    db 205
    db 33
init_div0 endp
seg002 ends
end
