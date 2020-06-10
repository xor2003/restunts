#include "externs.h"
#include "math.h"

extern long pState_lvec1_x;
extern long pState_lvec1_y;
extern long pState_lvec1_z;
extern int pState_minusRotate_z_1;
extern int pState_minusRotate_z_2;
extern int pState_minusRotate_y_1;
extern int pState_minusRotate_y_2;
extern int pState_minusRotate_x_1;
extern int pState_minusRotate_x_2;
extern struct MATRIX mat_unk;
extern struct VECTOR vec_unk2;
extern int planindex;
extern int planindex_copy;
extern int pState_f36Mminf40sar2;
extern struct VECTOR vec_planerotopresult;
extern char current_surf_type;
extern int nextPosAndNormalIP;
extern int wallindex;
extern int elRdWallRelated;
extern int wallHeight;
extern int wallStartX;
extern int wallStartZ;
extern int wallOrientation;
extern struct PLANE far* planptr;
extern struct PLANE far* current_planptr;
extern int elem_xCenter;
extern int elem_zCenter;
extern int terrainHeight;
extern char byte_4392C;

extern struct POINT2D unk_3BD62[2];
extern struct POINT2D unk_3BD5A[2];
extern struct POINT2D unk_3BD6A[2];
extern int word_3BD72[4];
extern int word_4408C;
extern int word_43964;

extern void update_crash_state(int, int);
extern int car_car_coll_detect_maybe(struct POINT2D*, struct VECTOR*, struct POINT2D*, struct VECTOR*);

extern int bto_auxiliary1(int, int, struct VECTOR*);

void update_player_state(struct CARSTATE* arg_pState, struct SIMD* arg_pSimd, struct CARSTATE* arg_oState, struct SIMD* arg_oSimd, int arg_MplayerFlag) {
	struct MATRIX var_MmatFromAngleZ;
	int var_pSpeed2Scaled;
	struct VECTOR vec_FC;
	struct VECTOR vec_1C6;
	int var_140someWhlData[4];
	struct VECTORLONG* var_DEptrTo1C0;
	struct VECTORLONG* var_146ptrTo176;
	int pState_f40_sar2;
	char var_EC;
	int var_F0;
	struct VECTOR vec_E4;
	struct VECTORLONG vecl_1C0[4];
	struct VECTORLONG vecl_176[4];
	int var_wheelIndex;
	char var_2;
	struct VECTOR vec_182, vec_1E4, vec_C, vec_1C, vec_17C, var_122;
	struct VECTOR var_11ApStateWorldCrds[2], vec_18EoStateWorldCrds[2];
	struct MATRIX mat_134;
	char var_136;
	int var_F4, var_F2, var_EE, var_138;
	unsigned int var_190;
	struct MATRIX* var_EA;
	int si;
	int var_16[4];
	struct PLANE far* var_6;
	struct VECTOR vec_1DE[4];
	int var_E;
	char var_11C;
	struct VECTOR var_DC[32];
	
	//return ported_update_player_state_(arg_pState, arg_pSimd, arg_oState, arg_oSimd, arg_MplayerFlag);

	pState_lvec1_x = arg_pState->car_posWorld1.lx;
	pState_lvec1_y = arg_pState->car_posWorld1.ly;
	pState_lvec1_z = arg_pState->car_posWorld1.lz;
	arg_pState->car_posWorld2.lx = arg_pState->car_posWorld1.lx;
	arg_pState->car_posWorld2.ly = arg_pState->car_posWorld1.ly;
	arg_pState->car_posWorld2.lz = arg_pState->car_posWorld1.lz;
	pState_minusRotate_z_1 = arg_pState->car_rotate.z;
	pState_minusRotate_z_2 = arg_pState->car_rotate.z;
	pState_minusRotate_x_1 = arg_pState->car_rotate.y;
	pState_minusRotate_x_2 = arg_pState->car_rotate.y;
	pState_minusRotate_y_1 = arg_pState->car_rotate.x;
	pState_minusRotate_y_2 = arg_pState->car_rotate.x;

	if (arg_pState->car_sumSurfAllWheels != 0) {
		pState_f40_sar2 = arg_pState->car_40MfrontWhlAngle >> 2;
	} else {
		pState_f40_sar2 = 0;
	}

	if (framespersec == 0xA) {
		var_pSpeed2Scaled = ((long)arg_pState->car_speed2 * 0x580) / 0x1E00;
	} else {
		var_pSpeed2Scaled = ((long)arg_pState->car_speed2 * 0x580) / 0x3C00;
	}

	mat_unk = *mat_rot_zxy(-pState_minusRotate_z_1, -pState_minusRotate_x_1, -pState_minusRotate_y_1, 0);
	if (pState_minusRotate_x_1 != 0 || pState_minusRotate_z_1 != 0) {
		vec_1C6.x = 0;
		vec_1C6.y = 0;
		vec_1C6.z = 0x82;
		mat_mul_vector(&vec_1C6, &mat_unk, &vec_FC);
		arg_pState->car_pseudoGravity = -vec_FC.y;
	} else {
		arg_pState->car_pseudoGravity = 0;
	}

	if ((arg_pState->car_angle_z & 0x3FF) != 0) {
		var_EC = 1;
		var_MmatFromAngleZ = *mat_rot_zxy(0, 0, -arg_pState->car_angle_z, 0);
	} else {
		var_EC = 0;
	}

	vec_1C6.x = 0;
	vec_1C6.y = 0x7530;
	vec_1C6.z = 0;
	mat_mul_vector(&vec_1C6, &mat_unk, &vec_FC);
	if (arg_pState->car_sumSurfAllWheels == 0)
		goto loc_14F76;
	if (vec_FC.y >= 0)
		goto loc_14F76;
	if (arg_pState->car_speed2 <= 0x1E00)
		goto loc_14F6E;
	var_F0 = 192;
	vec_1C6.y = -192; // 0xFF40
	mat_mul_vector(&vec_1C6, &mat_unk, &vec_E4);
	goto loc_14F7C;
/*
    mov     [bp+vec_1C6.vx], 0
    mov     [bp+vec_1C6.vy], 7530h; 30000
    mov     [bp+vec_1C6.vz], 0
    lea     ax, [bp+vec_FC]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     bx, [bp+arg_pState]
    cmp     [bx+CARSTATE.car_sumSurfAllWheels], 0
    jz      short loc_14F76
    cmp     [bp+vec_FC.vy], 0
    jge     short loc_14F76
    cmp     [bx+CARSTATE.car_speed2], 1E00h
    jbe     short loc_14F6E
    mov     [bp+var_F0], 0C0h ; 'À'
    mov     [bp+vec_1C6.vy], 0FF40h
    lea     ax, [bp+var_E4]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    jmp     short loc_14F7C
    ; align 2
    db 144*/
loc_14F6E:
    //mov     [bp+var_F0], 0FF40h
    //jmp     short loc_14F7C
	var_F0 = -192; // 0FF40h
	goto loc_14F7C;
loc_14F76:
    var_F0 = 0;
loc_14F7C:
	vec_unk2.x = 0;
	vec_unk2.y = 0;
	planindex_copy = -1;
	var_DEptrTo1C0 = vecl_1C0;
	var_146ptrTo176 = vecl_176;
	var_wheelIndex = 0;
	goto loc_14FFA;
/*
    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     planindex_copy, 0FFFFh
    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    lea     ax, [bp+vecl_176]
    mov     [bp+var_146ptrTo176], ax
    mov     [bp+var_wheelIndex], 0
    jmp     short loc_14FFA
    ; align 2
    db 144*/
loc_14FA6:
    //mov     bx, [bp+arg_pState]
    //mov     ax, [bx+CARSTATE.car_36MwhlAngle]
	pState_f36Mminf40sar2 = arg_pState->car_36MwhlAngle;
loc_14FAC:
//    mov     pState_f36Mminf40sar2, ax
	var_140someWhlData[var_wheelIndex] = pState_f36Mminf40sar2;
	plane_rotate_op();
	var_DEptrTo1C0->lx += vec_planerotopresult.x;
	var_DEptrTo1C0->ly += vec_planerotopresult.y;
	var_DEptrTo1C0->lz += vec_planerotopresult.z;
/*
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, pState_f36Mminf40sar2
    mov     [bp+di+var_140someWhlData], ax
    push    cs
    call near ptr plane_rotate_op
    mov     ax, vec_planerotopresult.vx
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, vec_planerotopresult.vy
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, vec_planerotopresult.vz
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx*/
loc_14FEC:
	var_DEptrTo1C0++;
	var_146ptrTo176++;
	var_wheelIndex++;
/*    add     [bp+var_DEptrTo1C0], 0Ch
    add     [bp+var_146ptrTo176], 0Ch
    inc     [bp+var_wheelIndex]*/
loc_14FFA:
	if (var_wheelIndex < 4)
		goto loc_15004;
	goto loc_1513E;
/*    cmp     [bp+var_wheelIndex], 4
    jl      short loc_15004
    jmp     loc_1513E*/
loc_15004:
	vec_1C6 = arg_pSimd->wheel_coords[var_wheelIndex];
	vec_1C6.y = -(arg_pState->car_rc2[var_wheelIndex] + 0x180);
	if (var_F0 >= 0)
		goto loc_1504A;
	vec_1C6.y -= var_F0;
/*
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1           ; *6
    mov     bx, [bp+arg_pSimd]
    push    si
    lea     si, [bx+di+SIMD.wheel_coords]
    lea     di, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+di+CARSTATE.car_rc2]
    add     ax, 180h        ; 384 = 24*16
    neg     ax
    mov     [bp+vec_1C6.vy], ax; adjusting wheel heights?
    cmp     [bp+var_F0], 0
    jge     short loc_1504A
    mov     ax, [bp+var_F0]
    sub     [bp+vec_1C6.vy], ax*/
loc_1504A:
	if (var_EC == 0)
		goto loc_15077;
	mat_mul_vector(&vec_1C6, &var_MmatFromAngleZ, &vec_FC);
	vec_1C6 = vec_FC;
/*
    cmp     [bp+var_EC], 0
    jz      short loc_15077
    lea     ax, [bp+vec_FC]
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    push    si
    lea     di, [bp+vec_1C6]
    lea     si, [bp+vec_FC]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si*/
loc_15077:
	mat_mul_vector(&vec_1C6, &mat_unk, &vec_FC);
	var_DEptrTo1C0->lx = vec_FC.x + pState_lvec1_x;
	var_DEptrTo1C0->ly = vec_FC.y + pState_lvec1_y;
	var_DEptrTo1C0->lz = vec_FC.z + pState_lvec1_z;
/*    lea     ax, [bp+vec_FC]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+vec_FC.vx]
    cwd
    add     ax, pState_lvec1_x_ax
    adc     dx, pState_lvec1_x_dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], ax
    mov     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_FC.vy]
    cwd
    add     ax, pState_lvec1_y_ax
    adc     dx, pState_lvec1_y_dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], ax
    mov     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_FC.vz]
    cwd
    add     ax, pState_lvec1_z_ax
    adc     dx, pState_lvec1_z_dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], ax
    mov     word ptr [bx+(VECTORLONG.lz+2)], dx*/
	var_146ptrTo176->lx = var_DEptrTo1C0->lx;
	var_146ptrTo176->ly = var_DEptrTo1C0->ly;
	var_146ptrTo176->lz = var_DEptrTo1C0->lz;
	if (var_pSpeed2Scaled != 0)
		goto loc_15115;
	goto loc_14FEC;
/*
    mov     bx, [bp+var_146ptrTo176]
    mov     di, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [di+VECTORLONG.lx]
    mov     dx, word ptr [di+(VECTORLONG.lx+2)]
    mov     word ptr [bx+VECTORLONG.lx], ax
    mov     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     bx, [bp+var_146ptrTo176]
    mov     di, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [di+VECTORLONG.ly]
    mov     dx, word ptr [di+(VECTORLONG.ly+2)]
    mov     word ptr [bx+VECTORLONG.ly], ax
    mov     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     bx, [bp+var_146ptrTo176]
    mov     di, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [di+VECTORLONG.lz]
    mov     dx, word ptr [di+(VECTORLONG.lz+2)]
    mov     word ptr [bx+VECTORLONG.lz], ax
    mov     word ptr [bx+(VECTORLONG.lz+2)], dx
    cmp     [bp+var_pSpeed2Scaled], 0
    jnz     short loc_15115
    jmp     loc_14FEC*/
loc_15115:
	vec_unk2.z = var_pSpeed2Scaled;
	if (pState_f40_sar2 != 0)
		goto loc_15126;
	goto loc_14FA6;
/*    mov     ax, [bp+var_pSpeed2Scaled]
    mov     vec_unk2.vz, ax
    cmp     [bp+pState_f40_sar2], 0
    jnz     short loc_15126
    jmp     loc_14FA6*/
loc_15126:
	if (var_wheelIndex < 2)
		goto loc_15130;
	goto loc_14FA6;
/*    cmp     [bp+var_wheelIndex], 2
    jl      short loc_15130
    jmp     loc_14FA6*/
loc_15130:
	pState_f36Mminf40sar2 = arg_pState->car_36MwhlAngle - pState_f40_sar2;
	goto loc_14FAC;
/*
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_36MwhlAngle]
    sub     ax, [bp+pState_f40_sar2]
    jmp     loc_14FAC
    ; align 2
    db 144*/
loc_1513E:
    var_2 = 0;
loc_15142:
	var_2++;
	if (var_2 != 5)
		goto loc_151A2;
	arg_pState->car_36MwhlAngle = 0x200;
	update_crash_state(1, arg_MplayerFlag);
/*    inc     [bp+var_2]
    cmp     [bp+var_2], 5
    jnz     short loc_151A2
    mov     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_36MwhlAngle], 200h
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4*/
loc_15163:
	if (arg_pState->car_surfaceWhl[0] != 5)
		goto loc_15192;
	if (arg_pState->car_surfaceWhl[1] != 5)
		goto loc_15192;
	if (arg_pState->car_surfaceWhl[2] != 5)
		goto loc_15192;
	if (arg_pState->car_surfaceWhl[3] != 5)
		goto loc_15192;
	update_crash_state(2, arg_MplayerFlag);
/*    mov     bx, [bp+arg_pState]; grip data...
    cmp     [bx+CARSTATE.car_surfaceWhl1], 5
    jnz     short loc_15192
    cmp     [bx+CARSTATE.car_surfaceWhl2], 5
    jnz     short loc_15192
    cmp     [bx+CARSTATE.car_surfaceWhl3], 5
    jnz     short loc_15192
    cmp     [bx+CARSTATE.car_surfaceWhl4], 5
    jnz     short loc_15192
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 2
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4*/
loc_15192:
	var_DEptrTo1C0 = vecl_1C0;
	var_wheelIndex = 0;
	goto loc_15DD1;
/*    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    mov     [bp+var_wheelIndex], 0
    jmp     loc_15DD1*/
loc_151A2:
	var_DEptrTo1C0 = vecl_1C0;
	var_146ptrTo176 = vecl_176;
	var_wheelIndex = 0;
	goto loc_15D39;
/*    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    lea     ax, [bp+vecl_176]
    mov     [bp+var_146ptrTo176], ax
    mov     [bp+var_wheelIndex], 0
    jmp     loc_15D39*/
loc_151BA:
	build_track_object(&vec_1C6, &arg_pState->car_whlWorldCrds1[var_wheelIndex]);
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+arg_pState]
    add     ax, CARSTATE.car_whlWorldCrds1
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    build_track_object
    add     sp, 4*/
loc_151DB:
	arg_pState->car_surfaceWhl[var_wheelIndex] = current_surf_type;
	vec_1C6.x = var_DEptrTo1C0->lx >> 6;
	vec_1C6.y = var_DEptrTo1C0->ly >> 6;
	vec_1C6.z = var_DEptrTo1C0->lz >> 6;
	
	if (state.game_inputmode != 2)
		goto loc_15240;
	nextPosAndNormalIP = vec_1C6.y;
	goto loc_15257;
/*
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    mov     bx, [bp+arg_pState]
    mov     al, current_surf_type
    mov     [bx+di+CARSTATE.car_surfaceWhl1], al; a CARSTATE field
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_151F7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_151F7
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_1520F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1520F
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15227:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15227
    mov     [bp+vec_1C6.vz], ax
    cmp     state.game_inputmode, 2
    jnz     short loc_15240
    mov     ax, [bp+vec_1C6.vy]
    jmp     short loc_15257*/
loc_15240:
	nextPosAndNormalIP = plane_origin_op(planindex, vec_1C6.x, vec_1C6.y, vec_1C6.z);
/*    push    [bp+vec_1C6.vz]
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8*/
loc_15257:
    //mov     nextPosAndNormalIP, ax
	if (wallindex != -1)
		goto loc_15264;
	goto loc_15950;
/*    cmp     wallindex, 0FFFFh
    jnz     short loc_15264
    jmp     loc_15950*/
loc_15264:
	if (nextPosAndNormalIP > elRdWallRelated)
		goto loc_15270;
	goto loc_15950;
/*    mov     ax, elRdWallRelated
    cmp     nextPosAndNormalIP, ax
    jg      short loc_15270
    jmp     loc_15950*/
loc_15270:
	if (nextPosAndNormalIP < wallHeight)
		goto loc_1527C;
	goto loc_15950;
/*    mov     ax, wallHeight
    cmp     nextPosAndNormalIP, ax
    jl      short loc_1527C
    jmp     loc_15950*/
loc_1527C:
	vec_182.x = arg_pState->car_whlWorldCrds1[var_wheelIndex].x - wallStartX;
	vec_182.y = 0;
	vec_182.z = arg_pState->car_whlWorldCrds1[var_wheelIndex].z - wallStartZ;
	vec_1E4.x = (var_DEptrTo1C0->lx >> 6) - wallStartX;
	vec_1E4.y = 0;
	vec_1E4.z = (var_DEptrTo1C0->lz >> 6) - wallStartZ;
/*
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, [bp+arg_pState]
    mov     ax, [di+CARSTATE.car_whlWorldCrds1.vx]
    sub     ax, wallStartX
    mov     [bp+vec_182.vx], ax
    mov     [bp+vec_182.vy], 0
    mov     ax, [di+CARSTATE.car_whlWorldCrds1.vz]
    sub     ax, wallStartZ
    mov     [bp+vec_182.vz], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_152B5:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_152B5
    sub     ax, wallStartX
    mov     [bp+vec_1E4.vx], ax
    mov     [bp+vec_1E4.vy], 0
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_152D7:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_152D7
    sub     ax, wallStartZ
    mov     [bp+vec_1E4.vz], ax*/
	mat_rot_y(&mat_134, -wallOrientation - 0x100);
	mat_mul_vector(&vec_182, &mat_134, &vec_C);
	mat_mul_vector(&vec_1E4, &mat_134, &vec_1C);
	if (vec_1C.z <= 0)
		goto loc_15338;
	if (vec_C.z <= 0)
		goto loc_15338;
	goto loc_15950;
	/*
    mov     ax, wallOrientation
    neg     ax
    sub     ax, 100h
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    call    mat_rot_y
    add     sp, 4
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    lea     ax, [bp+vec_182]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    lea     ax, [bp+vec_1C]
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    lea     ax, [bp+vec_1E4]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    cmp     [bp+vec_1C.vz], 0
    jle     short loc_15338
    cmp     [bp+vec_C.vz], 0
    jle     short loc_15338
    jmp     loc_15950*/
loc_15338:
	if (vec_1C.z >= 0)
		goto loc_15347;
	if (vec_C.z >= 0)
		goto loc_15347;
	goto loc_15950;
/*    cmp     [bp+vec_1C.vz], 0
    jge     short loc_15347
    cmp     [bp+vec_C.vz], 0
    jge     short loc_15347
    jmp     loc_15950*/
loc_15347:
	if (vec_1C.z <= vec_C.z)
		goto loc_1537C;
	var_136 = 1;
	vec_FC = vec_1C;
	vec_1C = vec_C;
	vec_C = vec_FC;
	goto loc_15381;
/*    mov     ax, [bp+vec_C.vz]
    cmp     [bp+vec_1C.vz], ax
    jle     short loc_1537C
    mov     [bp+var_136], 1
    push    si
    lea     di, [bp+vec_FC]
    lea     si, [bp+vec_1C]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    push    si
    lea     di, [bp+vec_1C]
    lea     si, [bp+vec_C]
    movsw
    movsw
    movsw
    pop     si
    push    si
    lea     di, [bp+vec_C]
    lea     si, [bp+vec_FC]
    movsw
    movsw
    movsw
    pop     si
    jmp     short loc_15381
    ; align 2
    db 144*/
loc_1537C:
    var_136 = 0;
loc_15381:
	if (vec_1C.z != 0)
		goto loc_15398;
	var_F4 = var_pSpeed2Scaled;
	var_F2 = 0;
	goto loc_1540C;
/*    cmp     [bp+vec_1C.vz], 0
    jnz     short loc_15398
    mov     ax, [bp+var_pSpeed2Scaled]
    mov     [bp+var_F4], ax
    mov     [bp+var_F2], 0
    jmp     short loc_1540C
    ; align 2
    db 144*/
loc_15398:
	if (vec_C.z != 0)
		goto loc_153AE;
	var_F4 = 0;
	var_F2 = var_pSpeed2Scaled;
	goto loc_1540C;
/*
    cmp     [bp+vec_C.vz], 0
    jnz     short loc_153AE
    mov     [bp+var_F4], 0
    mov     ax, [bp+var_pSpeed2Scaled]
    mov     [bp+var_F2], ax
    jmp     short loc_1540C*/
loc_153AE:
	vector_op_unk(&vec_1C, &vec_C, &vec_FC, 0);
	vec_17C.x = (vec_1C.x - vec_FC.x) << 6;
	vec_17C.y = (vec_1C.y - vec_FC.y) << 6;
	vec_17C.z = (vec_1C.z - vec_FC.z) << 6;
	var_F2 = polarRadius3D(&vec_17C);
	var_F4 = var_pSpeed2Scaled - var_F2;
/*    sub     ax, ax
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+vec_1C]
    push    ax
    call    vector_op_unk
    add     sp, 8
    mov     ax, [bp+vec_1C.vx]
    sub     ax, [bp+vec_FC.vx]
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_17C.vx], ax
    mov     ax, [bp+vec_1C.vy]
    sub     ax, [bp+vec_FC.vy]
    shl     ax, cl
    mov     [bp+vec_17C.vy], ax
    mov     ax, [bp+vec_1C.vz]
    sub     ax, [bp+vec_FC.vz]
    shl     ax, cl
    mov     [bp+vec_17C.vz], ax
    lea     ax, [bp+vec_17C]
    push    ax
    call    polarRadius3D
    add     sp, 2
    mov     [bp+var_F2], ax
    mov     ax, [bp+var_pSpeed2Scaled]
    sub     ax, [bp+var_F2]
    mov     [bp+var_F4], ax*/
loc_1540C:
	var_EE = (-pState_minusRotate_y_1 - wallOrientation) & 0x3FF;
	vec_FC.z = var_F2;
	vec_FC.y = 0;
	if (var_EE < 0x100)
		goto loc_1543A;
	if (var_EE <= 0x300)
		goto loc_1544A;
/*    mov     ax, pState_minusRotate_y_1
    neg     ax
    sub     ax, wallOrientation
smart
    and     ah, 3
nosmart
    mov     [bp+var_EE], ax
    mov     ax, [bp+var_F2]
    mov     [bp+vec_FC.vz], ax
    mov     [bp+vec_FC.vy], 0
    cmp     [bp+var_EE], 100h
    jl      short loc_1543A
    cmp     [bp+var_EE], 300h
    jle     short loc_1544A*/
loc_1543A:
	var_EE = wallOrientation;
	vec_FC.x = 768;//0x300;
	goto loc_1545D;
/*    mov     ax, wallOrientation
    mov     [bp+var_EE], ax
    mov     [bp+vec_FC.vx], 300h
    jmp     short loc_1545D
    ; align 2
    db 144*/
loc_1544A:
	var_EE = (wallOrientation + 0x200) & 0x3FF;
	vec_FC.x = -768;//0xFD00; // TODO: a negative number
/*    mov     ax, wallOrientation
    add     ah, 2
smart
    and     ah, 3
nosmart
    mov     [bp+var_EE], ax
    mov     [bp+vec_FC.vx], 0FD00h*/
loc_1545D:
	if (var_136 == 0)
		goto loc_1546E;
	vec_FC.x = -vec_FC.x;
/*    cmp     [bp+var_136], 0
    jz      short loc_1546E
    mov     ax, [bp+vec_FC.vx]
    neg     ax
    mov     [bp+vec_FC.vx], ax*/
loc_1546E:
	var_EA = mat_rot_zxy(-pState_minusRotate_z_1, -pState_minusRotate_x_1, var_EE, 0);
	mat_mul_vector(&vec_FC, var_EA, &vec_1C);
	si = (-pState_minusRotate_y_1 - var_EE) & 0x3FF;
	var_138 = 0;
	if (si <= 0x100)
		goto loc_154CA;
	si = 0x400 - si;
	var_138 = 1;
/*    sub     ax, ax
    push    ax
    push    [bp+var_EE]
    mov     ax, pState_minusRotate_x_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_z_1
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_EA], ax
    lea     ax, [bp+vec_1C]
    push    ax
    push    [bp+var_EA]
    lea     ax, [bp+vec_FC]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, pState_minusRotate_y_1
    neg     ax
    mov     si, ax
    sub     si, [bp+var_EE]
smart
    and     si, 3FFh
nosmart
    mov     [bp+var_138], 0
    cmp     si, 100h
    jle     short loc_154CA
    mov     ax, 400h
    sub     ax, si
    mov     si, ax
    mov     [bp+var_138], 1*/
loc_154CA:
	// TODO: suspicious (gets here when colliding)
	var_190 = -((si * 0x46 >> 8) - 0x64) << 8;
	if (arg_pState->car_speed2 <= var_190)
		goto loc_15513;
	if (var_138 == 0)
		goto loc_154F8;
	var_138 = -si << 1; //.. ax = -i
	goto loc_154FA;
/*
    mov     ax, 46h ; 'F'
    imul    si
    mov     cl, 8
    sar     ax, cl
    sub     ax, 64h ; 'd'
    neg     ax
    mov     ch, al
    sub     cl, cl
    mov     [bp+var_190], cx
    mov     bx, [bp+arg_pState]
    mov     ax, cx
    cmp     [bx+CARSTATE.car_speed2], ax
    jbe     short loc_15513
    cmp     [bp+var_138], 0
    jz      short loc_154F8
    mov     ax, si
    neg     ax
    jmp     short loc_154FA
    ; align 2
    db 144*/
loc_154F8:
    //mov     ax, si
	var_138 = si << 1;
loc_154FA:
    //shl     ax, 1
    //mov     [bp+var_138], ax
	arg_pState->car_36MwhlAngle = var_138;
	update_crash_state(1, arg_MplayerFlag);
/*
    mov     [bx+CARSTATE.car_36MwhlAngle], ax
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4*/
loc_15513:
	arg_pState->field_CF |= 0x10;
	var_DEptrTo1C0 = vecl_1C0;
	var_146ptrTo176 = vecl_176;
	si = 0;
	goto loc_15599;
/*    mov     bx, [bp+arg_pState]
smart
    or      [bx+CARSTATE.field_CF], 10h
nosmart
    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    lea     ax, [bp+vecl_176]
    mov     [bp+var_146ptrTo176], ax
    sub     si, si
    jmp     short loc_15599
    ; align 2
    db 144*/
loc_15530:
	vec_C.x = 0;
	vec_C.y = 0;
	vec_C.z = 0;
/*    mov     [bp+vec_C.vx], 0
    mov     [bp+vec_C.vy], 0
    mov     [bp+vec_C.vz], 0*/
loc_1553F:
	var_DEptrTo1C0->lx = vec_C.x + vec_1C.x + var_146ptrTo176->lx;
	var_DEptrTo1C0->ly = vec_C.y + vec_1C.y + var_146ptrTo176->ly;
	var_DEptrTo1C0->lz = vec_C.z + vec_1C.z + var_146ptrTo176->lz;
	var_DEptrTo1C0++;
	var_146ptrTo176++;
	si++;
/*    mov     ax, [bp+vec_C.vx]
    add     ax, [bp+vec_1C.vx]
    cwd
    mov     bx, [bp+var_146ptrTo176]
    add     ax, word ptr [bx+VECTORLONG.lx]
    adc     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], ax
    mov     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_C.vy]
    add     ax, [bp+vec_1C.vy]
    cwd
    mov     bx, [bp+var_146ptrTo176]
    add     ax, word ptr [bx+VECTORLONG.ly]
    adc     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], ax
    mov     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_C.vz]
    add     ax, [bp+vec_1C.vz]
    cwd
    mov     bx, [bp+var_146ptrTo176]
    add     ax, word ptr [bx+VECTORLONG.lz]
    adc     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], ax
    mov     word ptr [bx+(VECTORLONG.lz+2)], dx
    add     [bp+var_DEptrTo1C0], 0Ch
    add     [bp+var_146ptrTo176], 0Ch
    inc     si*/
loc_15599:
	if (si < 4)
		goto loc_155A1;
	goto loc_15142;
/*    cmp     si, 4
    jl      short loc_155A1
    jmp     loc_15142*/
loc_155A1:
	if (var_F4 == 0)
		goto loc_15530;
	vec_C.x = ((var_DEptrTo1C0->lx - var_146ptrTo176->lx) * var_F4) / var_pSpeed2Scaled;
	vec_C.y = ((var_DEptrTo1C0->ly - var_146ptrTo176->ly) * var_F4) / var_pSpeed2Scaled;
	vec_C.z = ((var_DEptrTo1C0->lz - var_146ptrTo176->lz) * var_F4) / var_pSpeed2Scaled;
	goto loc_1553F;
/*    cmp     [bp+var_F4], 0
    jz      short loc_15530
    mov     ax, [bp+var_pSpeed2Scaled]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lx]
    sbb     dx, word ptr [bx+(VECTORLONG.lx+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vx], ax
    mov     ax, [bp+var_pSpeed2Scaled]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.ly]
    sbb     dx, word ptr [bx+(VECTORLONG.ly+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vy], ax
    mov     ax, [bp+var_pSpeed2Scaled]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lz]
    sbb     dx, word ptr [bx+(VECTORLONG.lz+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vz], ax
    jmp     loc_1553F*/
loc_15642:
	arg_pState->car_rc1[var_wheelIndex] += word_3BD72[var_wheelIndex];
	var_DEptrTo1C0->ly -= arg_pState->car_rc1[var_wheelIndex];
	if (framespersec != 0xA)
		goto loc_156A3;
	arg_pState->car_rc1[var_wheelIndex] += word_3BD72[var_wheelIndex];
	var_DEptrTo1C0->ly -= arg_pState->car_rc1[var_wheelIndex];
/*
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, word_3BD72[di]
    add     [bx+di+CARSTATE.car_rc1], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rc1]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.ly], ax
    sbb     word ptr [bx+(VECTORLONG.ly+2)], dx
    cmp     framespersec, 0Ah
    jnz     short loc_156A3
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, word_3BD72[di]
    add     [bx+di+CARSTATE.car_rc1], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rc1]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.ly], ax
    sbb     word ptr [bx+(VECTORLONG.ly+2)], dx*/
loc_156A3:
	vec_1C6.y = var_DEptrTo1C0->ly >> 6;
	if (state.game_inputmode == 2) {
		nextPosAndNormalIP = vec_1C6.y;
		//goto loc_156D6;
	} else { 
		nextPosAndNormalIP = plane_origin_op(planindex, vec_1C6.x, vec_1C6.y, vec_1C6.z);
	}
/*    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_156AF:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_156AF
    mov     [bp+vec_1C6.vy], ax
    cmp     state.game_inputmode, 2
    jz      short loc_156D6
    push    [bp+vec_1C6.vz]
    push    ax
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8*/
loc_156D6:
    //mov     nextPosAndNormalIP, ax
	if (nextPosAndNormalIP <= 0xC)
		goto loc_156ED;
	arg_pState->car_surfaceWhl[var_wheelIndex] = 0;
	/*
    cmp     ax, 0Ch
    jle     short loc_156ED
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    mov     bx, [bp+arg_pState]
    mov     [bx+di+CARSTATE.car_surfaceWhl1], 0*/
loc_156ED:
	var_16[var_wheelIndex] = nextPosAndNormalIP;
	if (nextPosAndNormalIP != 0)
		goto loc_15703;
	goto loc_15CE8;
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, nextPosAndNormalIP
    mov     [bp+di+var_16], ax
    or      ax, ax
    jnz     short loc_15703
    jmp     loc_15CE8*/
loc_15703:
	if (nextPosAndNormalIP < 0)
		goto loc_1570A;
	goto loc_15D2B;
/*    or      ax, ax
    jl      short loc_1570A
    jmp     loc_15D2B*/
loc_1570A:
	var_6 = &planptr[planindex];
	var_122.x = var_6->plane_origin.x + elem_xCenter;
	var_122.y = var_6->plane_origin.y + terrainHeight;
	var_122.z = var_6->plane_origin.z + elem_zCenter;
/*    mov     ax, 22h ; '"'
    imul    planindex
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     word ptr [bp+var_6], ax
    mov     word ptr [bp+var_6+2], dx
    les     bx, [bp+var_6]
    mov     ax, es:[bx+PLANE.plane_origin.vx]
    add     ax, elem_xCenter
    mov     [bp+var_122.vx], ax
    mov     ax, es:[bx+PLANE.plane_origin.vy]
    add     ax, terrainHeight
    mov     [bp+var_122.vy], ax
    mov     ax, es:[bx+PLANE.plane_origin.vz]
    add     ax, elem_zCenter
    mov     [bp+var_122.vz], ax
*/
	vec_182.x = (var_146ptrTo176->lx >> 6) - var_122.x;
	vec_182.y = (var_146ptrTo176->ly >> 6) - var_122.y;
	vec_182.z = (var_146ptrTo176->lz >> 6) - var_122.z;
/*
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15751:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15751
    sub     ax, [bp+var_122.vx]
    mov     [bp+vec_182.vx], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_1576D:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1576D
    sub     ax, [bp+var_122.vy]
    mov     [bp+vec_182.vy], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15789:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15789
    sub     ax, [bp+var_122.vz]
    mov     [bp+vec_182.vz], ax*/
	vec_1E4.x = (var_DEptrTo1C0->lx >> 6) - var_122.x;
	vec_1E4.y = (var_DEptrTo1C0->ly >> 6) - var_122.y;
	vec_1E4.z = (var_DEptrTo1C0->lz >> 6) - var_122.z;
/*
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_157A4:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_157A4
    sub     ax, [bp+var_122.vx]
    mov     [bp+vec_1E4.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_157C0:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_157C0
    sub     ax, [bp+var_122.vy]
    mov     [bp+vec_1E4.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_157DC:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_157DC
    sub     ax, [bp+var_122.vz]
    mov     [bp+vec_1E4.vz], ax*/
	mat_134 = var_6->plane_rotation;
	mat_invert(&mat_134, &var_MmatFromAngleZ);
	mat_mul_vector(&vec_182, &var_MmatFromAngleZ, &vec_C);
	/*
    mov     ax, word ptr [bp+var_6]
    mov     dx, word ptr [bp+var_6+2]
    add     ax, 10h         ; plane rotation matrix
    push    si
    lea     di, [bp+mat_134]
    mov     si, ax
    push    ss
    pop     es
    push    ds
    mov     ds, dx
    mov     cx, 9
    repne movsw
    pop     ds
    pop     si
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+mat_134]
    push    ax
    call    mat_invert
    add     sp, 4
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_182]
    push    ax
    call    mat_mul_vector
    add     sp, 6*/
	mat_mul_vector(&vec_1E4, &var_MmatFromAngleZ, &vec_1C);
	var_136 = 0;
	if (byte_4392C != 0)
		goto loc_15879;
	if (vec_C.y >= -12)//0xFFF4)
		goto loc_15879;
	if (vec_1C.y >= -12)//0xFFF4)
		goto loc_15879;
	if (vec_1C.y <= -24)//0xFFE8)
		goto loc_158DA;
	update_crash_state(5, arg_MplayerFlag);
	var_136 = 1;
/*    lea     ax, [bp+vec_1C]
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_1E4]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     [bp+var_136], 0
    cmp     byte_4392C, 0
    jnz     short loc_15879
    cmp     [bp+vec_C.vy], 0FFF4h
    jge     short loc_15879
    cmp     [bp+vec_1C.vy], 0FFF4h
    jge     short loc_15879
    cmp     [bp+vec_1C.vy], 0FFE8h
    jle     short loc_158DA
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 5
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4
    mov     [bp+var_136], 1*/
loc_15879:
	if (vec_1C.y == 0)
		goto loc_15882;
	goto loc_1599E;
/*    cmp     [bp+vec_1C.vy], 0
    jz      short loc_15882
    jmp     loc_1599E*/
loc_15882:
	vec_unk2.x = 0;
	vec_unk2.y = 0;
	vec_unk2.z = 0x40;
	planindex_copy = planindex;
	pState_f36Mminf40sar2 = var_140someWhlData[var_wheelIndex];
	plane_rotate_op();
	var_DEptrTo1C0->lx -= vec_planerotopresult.x;
	var_DEptrTo1C0->ly -= vec_planerotopresult.y;
	var_DEptrTo1C0->lz -= vec_planerotopresult.z;
	goto loc_15CDF;
/*    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     vec_unk2.vz, 40h ; '@'
    mov     ax, planindex
    mov     planindex_copy, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, [bp+di+var_140someWhlData]
    mov     pState_f36Mminf40sar2, ax
    push    cs
    call near ptr plane_rotate_op
    mov     ax, vec_planerotopresult.vx
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.lx], ax
    sbb     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, vec_planerotopresult.vy
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.ly], ax
    sbb     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, vec_planerotopresult.vz
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    sub     word ptr [bx+VECTORLONG.lz], ax
    sbb     word ptr [bx+(VECTORLONG.lz+2)], dx
    jmp     loc_15CDF*/
loc_158DA:
	planindex = 0;
	current_planptr = planptr;
	byte_4392C = 1;
	vec_1C6.x = var_DEptrTo1C0->lx >> 6;
	vec_1C6.y = var_DEptrTo1C0->ly >> 6;
	vec_1C6.z = var_DEptrTo1C0->lz >> 6;
/*    mov     planindex, 0
    mov     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     current_planptr_ax, ax
    mov     current_planptr_dx, dx
    mov     byte_4392C, 1
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_158FE:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_158FE
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15916:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15916
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_1592E:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1592E
    mov     [bp+vec_1C6.vz], ax*/
	nextPosAndNormalIP = plane_origin_op(0, vec_1C6.x, vec_1C6.y, vec_1C6.z);
/*    push    ax
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    sub     ax, ax
    push    ax
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     nextPosAndNormalIP, ax*/
loc_15950:
	if (nextPosAndNormalIP > 0)
		goto loc_1595A;
	goto loc_156ED;
/*    cmp     nextPosAndNormalIP, 0
    jg      short loc_1595A
    jmp     loc_156ED*/
loc_1595A:
	if (var_F0 > 0)
		goto loc_15964;
	goto loc_15642;
/*    cmp     [bp+var_F0], 0
    jg      short loc_15964
    jmp     loc_15642*/
loc_15964:
	if (nextPosAndNormalIP < 0x18)
		goto loc_1596E;
	goto loc_15642;
/*    cmp     nextPosAndNormalIP, 18h
    jl      short loc_1596E
    jmp     loc_15642*/
loc_1596E:
	var_DEptrTo1C0->lx += vec_E4.x;
	var_DEptrTo1C0->ly += vec_E4.y;
	var_DEptrTo1C0->lz += vec_E4.z;
	goto loc_156ED;
/*    mov     ax, [bp+var_E4]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+var_E2]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+var_E0]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx
    jmp     loc_156ED
    ; align 2
    db 144*/
loc_1599E:
	if (vec_C.y <= 0)
		goto loc_159AD;
	if (vec_1C.y >= 0)
		goto loc_159AD;
	goto loc_15A30;
/*    cmp     [bp+vec_C.vy], 0
    jle     short loc_159AD
    cmp     [bp+vec_1C.vy], 0
    jge     short loc_159AD
    jmp     loc_15A30*/
loc_159AD:
	vec_unk2.x = 0;
	vec_unk2.y = 0;
	vec_unk2.z = var_pSpeed2Scaled;
	planindex_copy = planindex;
	pState_f36Mminf40sar2 = var_140someWhlData[var_wheelIndex];
	plane_rotate_op();
	var_DEptrTo1C0->lx = var_146ptrTo176->lx + vec_planerotopresult.x;
	var_DEptrTo1C0->ly = var_146ptrTo176->ly + vec_planerotopresult.y;
	var_DEptrTo1C0->lz = var_146ptrTo176->lz + vec_planerotopresult.z;
	goto loc_15C04;
/*    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     ax, [bp+var_pSpeed2Scaled]
    mov     vec_unk2.vz, ax
    mov     ax, planindex
    mov     planindex_copy, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     ax, [bp+di+var_140someWhlData]
    mov     pState_f36Mminf40sar2, ax
    push    cs
    call near ptr plane_rotate_op
    mov     ax, vec_planerotopresult.vx
    cwd
    mov     bx, [bp+var_146ptrTo176]
    mov     cx, word ptr [bx+VECTORLONG.lx]
    mov     di, word ptr [bx+(VECTORLONG.lx+2)]
    add     cx, ax
    adc     di, dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], cx
    mov     word ptr [bx+(VECTORLONG.lx+2)], di
    mov     ax, vec_planerotopresult.vy
    cwd
    mov     bx, [bp+var_146ptrTo176]
    mov     cx, word ptr [bx+VECTORLONG.ly]
    mov     di, word ptr [bx+(VECTORLONG.ly+2)]
    add     cx, ax
    adc     di, dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], cx
    mov     word ptr [bx+(VECTORLONG.ly+2)], di
    mov     ax, vec_planerotopresult.vz
    cwd
    mov     bx, [bp+var_146ptrTo176]
    mov     cx, word ptr [bx+VECTORLONG.lz]
    mov     di, word ptr [bx+(VECTORLONG.lz+2)]
    add     cx, ax
    adc     di, dx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], cx
    mov     word ptr [bx+(VECTORLONG.lz+2)], di
    jmp     loc_15C04
    ; align 2
    db 144*/
loc_15A30:
	var_EE = vec_C.z;
	vec_C.z = -vec_C.y;
	vec_C.y = var_EE;

	var_EE = vec_1C.z;
	vec_1C.z = -vec_1C.y;
	vec_1C.y = var_EE;
	vector_op_unk(&vec_1C, &vec_C, &vec_FC, 0);
	vec_17C.x = (vec_1C.x - vec_FC.x) << 6;
	vec_17C.y = (vec_1C.y - vec_FC.y) << 6;
	vec_17C.z = (vec_1C.z - vec_FC.z) << 6;
/*
    mov     ax, [bp+vec_C.vz]
    mov     [bp+var_EE], ax
    mov     ax, [bp+vec_C.vy]
    neg     ax
    mov     [bp+vec_C.vz], ax
    mov     ax, [bp+var_EE]
    mov     [bp+vec_C.vy], ax

    mov     ax, [bp+vec_1C.vz]
    mov     [bp+var_EE], ax
    mov     ax, [bp+vec_1C.vy]
    neg     ax
    mov     [bp+vec_1C.vz], ax
    mov     ax, [bp+var_EE]
    mov     [bp+vec_1C.vy], ax
	
    sub     ax, ax
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    lea     ax, [bp+vec_C]
    push    ax
    lea     ax, [bp+vec_1C]
    push    ax
    call    vector_op_unk
    add     sp, 8
    mov     ax, [bp+vec_1C.vx]
    sub     ax, [bp+vec_FC.vx]
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_17C.vx], ax
    mov     ax, [bp+vec_1C.vy]
    sub     ax, [bp+vec_FC.vy]
    shl     ax, cl
    mov     [bp+vec_17C.vy], ax
    mov     ax, [bp+vec_1C.vz]
    sub     ax, [bp+vec_FC.vz]
    shl     ax, cl
    mov     [bp+vec_17C.vz], ax*/
	var_EE = polarRadius3D(&vec_17C);
	var_F4 = arg_pState->car_rc1[var_wheelIndex] + var_pSpeed2Scaled;
	var_F2 = var_F4 - var_EE;
	vec_C.x = ((var_DEptrTo1C0->lx - var_146ptrTo176->lx) * var_F2) / var_F4;
	vec_C.y = ((var_DEptrTo1C0->ly - var_146ptrTo176->ly) * var_F2) / var_F4;
	vec_C.z = ((var_DEptrTo1C0->lz - var_146ptrTo176->lz) * var_F2) / var_F4;
/*    lea     ax, [bp+vec_17C]
    push    ax
    call    polarRadius3D
    add     sp, 2
    mov     [bp+var_EE], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+di+CARSTATE.car_rc1]
    add     ax, [bp+var_pSpeed2Scaled]
    mov     [bp+var_F4], ax
    sub     ax, [bp+var_EE]
    mov     [bp+var_F2], ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F2]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lx]
    sbb     dx, word ptr [bx+(VECTORLONG.lx+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vx], ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F2]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.ly]
    sbb     dx, word ptr [bx+(VECTORLONG.ly+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vy], ax
    mov     ax, [bp+var_F4]
    cwd
    push    dx
    push    ax
    mov     ax, [bp+var_F2]
    cwd
    push    dx
    push    ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     bx, [bp+var_146ptrTo176]
    sub     ax, word ptr [bx+VECTORLONG.lz]
    sbb     dx, word ptr [bx+(VECTORLONG.lz+2)]
    push    dx
    push    ax
    call    __aFlmul
    push    dx
    push    ax
    call    __aFldiv
    mov     [bp+vec_C.vz], ax*/
	vec_unk2.x = 0;
	vec_unk2.y = 0;
	vec_unk2.z = var_EE;
	planindex_copy = planindex;
	pState_f36Mminf40sar2 = var_140someWhlData[var_wheelIndex];
	plane_rotate_op();
	var_DEptrTo1C0->lx = var_146ptrTo176->lx + vec_C.x + vec_planerotopresult.x;
	var_DEptrTo1C0->ly = var_146ptrTo176->ly + vec_C.y + vec_planerotopresult.y;
	var_DEptrTo1C0->lz = var_146ptrTo176->lz + vec_C.z + vec_planerotopresult.z;
/*
    mov     vec_unk2.vx, 0
    mov     vec_unk2.vy, 0
    mov     ax, [bp+var_EE]
    mov     vec_unk2.vz, ax
    mov     ax, planindex
    mov     planindex_copy, ax
    mov     ax, [bp+di+var_140someWhlData]
    mov     pState_f36Mminf40sar2, ax
    push    cs
    call near ptr plane_rotate_op
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cx, ax
    mov     ax, [bp+vec_C.vx]
    mov     bx, dx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, vec_planerotopresult.vx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, bx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lx], cx
    mov     word ptr [bx+(VECTORLONG.lx+2)], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cx, ax
    mov     ax, [bp+vec_C.vy]
    mov     bx, dx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, vec_planerotopresult.vy
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, bx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.ly], cx
    mov     word ptr [bx+(VECTORLONG.ly+2)], ax
    mov     bx, [bp+var_146ptrTo176]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cx, ax
    mov     ax, [bp+vec_C.vz]
    mov     bx, dx
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, vec_planerotopresult.vz
    cwd
    add     cx, ax
    adc     bx, dx
    mov     ax, bx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     word ptr [bx+VECTORLONG.lz], cx
    mov     word ptr [bx+(VECTORLONG.lz+2)], ax*/
loc_15C04:
	vec_1C6.x = var_DEptrTo1C0->lx >> 6;
	vec_1C6.y = var_DEptrTo1C0->ly >> 6;
	vec_1C6.z = var_DEptrTo1C0->lz >> 6;
/*    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15C0F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15C0F
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15C27:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15C27
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15C3F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15C3F
    mov     [bp+vec_1C6.vz], ax*/
	nextPosAndNormalIP = plane_origin_op(planindex, vec_1C6.x, vec_1C6.y, vec_1C6.z);
	if (nextPosAndNormalIP >= 0)
		goto loc_15CDF;
	if (var_136 == 0)
		goto loc_15C75;
	nextPosAndNormalIP = (-nextPosAndNormalIP) + 6;
/*    push    ax
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     nextPosAndNormalIP, ax
    or      ax, ax
    jge     short loc_15CDF
    cmp     [bp+var_136], 0
    jz      short loc_15C75
    neg     ax
    add     ax, 6
    mov     nextPosAndNormalIP, ax*/
loc_15C75:
	vec_1C6.z = 0;
	vec_1C6.x = 0;
	vec_1C6.y = (-nextPosAndNormalIP) << 6;
	mat_mul_vector2(&vec_1C6, &planptr[planindex].plane_rotation, &vec_FC);
/*
    mov     [bp+vec_1C6.vz], 0
    mov     [bp+vec_1C6.vx], 0
    mov     ax, nextPosAndNormalIP
    neg     ax
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_1C6.vy], ax
    lea     ax, [bp+vec_FC]
    push    ax
    mov     ax, 22h ; '"'
    imul    planindex
    add     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    add     ax, 10h
    push    dx
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    push    cs
    call near ptr ported_mat_mul_vector2_
    add     sp, 8*/
	var_DEptrTo1C0->lx += vec_FC.x;
	var_DEptrTo1C0->ly += vec_FC.y;
	var_DEptrTo1C0->lz += vec_FC.z;
/*    mov     ax, [bp+vec_FC.vx]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_FC.vy]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_FC.vz]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx*/
loc_15CDF:
loc_15CE8:
	if (arg_pState->car_rc1[var_wheelIndex] <= 0xFA)
		goto loc_15CF7;
	arg_pState->field_CF |= 0x20;

/*
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
loc_15CE8:
    mov     bx, [bp+arg_pState]
    cmp     [bx+di+CARSTATE.car_rc1], 0FAh ; 'ú'
    jle     short loc_15CF7
smart
    or      [bx+CARSTATE.field_CF], 20h
nosmart*/
loc_15CF7:
	if (arg_pState->car_rc1[var_wheelIndex] <= 0x5AEB)
		goto loc_15D1A;
	update_crash_state(1, arg_MplayerFlag);
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    cmp     [bx+di+CARSTATE.car_rc1], 5AEBh
    jle     short loc_15D1A
    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4*/
loc_15D1A:
	arg_pState->car_rc1[var_wheelIndex] = 0;
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    mov     [bx+di+CARSTATE.car_rc1], 0*/
loc_15D2B:
	var_DEptrTo1C0++;
	var_146ptrTo176++;
	var_wheelIndex++;
/*    add     [bp+var_DEptrTo1C0], 0Ch
    add     [bp+var_146ptrTo176], 0Ch
    inc     [bp+var_wheelIndex]*/
loc_15D39:
	if (var_wheelIndex < 4)
		goto loc_15D43;
	goto loc_15163;
/*    cmp     [bp+var_wheelIndex], 4
    jl      short loc_15D43
    jmp     loc_15163*/
loc_15D43:
	vec_1C6.x = var_DEptrTo1C0->lx >> 6;
	vec_1C6.y = var_DEptrTo1C0->ly >> 6;
	vec_1C6.z = var_DEptrTo1C0->lz >> 6;
/*
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15D4E:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15D4E
    mov     [bp+vec_1C6.vx], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15D66:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15D66
    mov     [bp+vec_1C6.vy], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15D7E:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15D7E
    mov     [bp+vec_1C6.vz], ax*/
	if (state.game_inputmode == 2)
		goto loc_15D94;
	goto loc_151BA;
/*    cmp     state.game_inputmode, 2
    jz      short loc_15D94
    jmp     loc_151BA*/
loc_15D94:
	wallindex = -1;
	current_surf_type = 1; //tarmac;
	planindex = 0;
	current_planptr = planptr;
	goto loc_151DB;
/*    mov     wallindex, 0FFFFh
    mov     current_surf_type, tarmac
    mov     planindex, 0
    mov     ax, word ptr planptr
    mov     dx, word ptr planptr+2
    mov     current_planptr_ax, ax
    mov     current_planptr_dx, dx
    jmp     loc_151DB*/
loc_15DB6:
	var_DEptrTo1C0->ly += var_EE + 0x180;
/*    mov     ax, [bp+var_EE]
    add     ax, 180h
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx*/
loc_15DC8:
	var_DEptrTo1C0++;
	var_wheelIndex++;
/*    add     [bp+var_DEptrTo1C0], 0Ch
    inc     [bp+var_wheelIndex]*/
loc_15DD1:
	if (var_wheelIndex < 4)
		goto loc_15DDB;
	goto code_update_globalPos;
/*    cmp     [bp+var_wheelIndex], 4
    jl      short loc_15DDB
    jmp     code_update_globalPos*/
loc_15DDB:
	arg_pState->car_whlWorldCrds1[var_wheelIndex].x = var_DEptrTo1C0->lx >> 6;
	arg_pState->car_whlWorldCrds1[var_wheelIndex].y = var_DEptrTo1C0->ly >> 6;
	arg_pState->car_whlWorldCrds1[var_wheelIndex].z = var_DEptrTo1C0->lz >> 6;
/*    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    mov     dx, word ptr [bx+(VECTORLONG.lx+2)]
    mov     cl, 6
loc_15DE6:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15DE6
    mov     cx, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_whlWorldCrds1.vx], cx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    mov     dx, word ptr [bx+(VECTORLONG.ly+2)]
    mov     cl, 6
loc_15E0F:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15E0F
    mov     cx, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_whlWorldCrds1.vy], cx
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    mov     dx, word ptr [bx+(VECTORLONG.lz+2)]
    mov     cl, 6
loc_15E38:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15E38
    mov     cx, ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     bx, ax
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    add     bx, [bp+arg_pState]
    mov     [bx+CARSTATE.car_whlWorldCrds1.vz], cx*/

	var_EE = carState_rc_op(arg_pState, var_16[var_wheelIndex], var_wheelIndex);
	if (pState_minusRotate_z_1 != 0)
		goto loc_15E85;
	if (pState_minusRotate_x_1 != 0)
		goto loc_15E85;
	goto loc_15DB6;
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    push    di
    mov     bx, di
    shl     bx, 1
    add     bx, bp
    push    word ptr [bx-16h]; var_(16-2*wheelIndex)
    push    [bp+arg_pState]
    push    cs
    call near ptr carState_rc_op
    add     sp, 6
    mov     [bp+var_EE], ax
    cmp     pState_minusRotate_z_1, 0
    jnz     short loc_15E85
    cmp     pState_minusRotate_x_1, 0
    jnz     short loc_15E85
    jmp     loc_15DB6*/
loc_15E85:
	vec_1C6.z = 0;
	vec_1C6.x = 0;
	vec_1C6.y = var_EE + 0x180;
	mat_mul_vector(&vec_1C6, &mat_unk, &vec_182);
	var_DEptrTo1C0->lx += vec_182.x;
	var_DEptrTo1C0->ly += vec_182.y;
	var_DEptrTo1C0->lz += vec_182.z;
	goto loc_15DC8;
/*    mov     [bp+vec_1C6.vz], 0
    mov     [bp+vec_1C6.vx], 0
    mov     ax, [bp+var_EE]
    add     ax, 180h
    mov     [bp+vec_1C6.vy], ax
    lea     ax, [bp+vec_182]
    push    ax
    mov     ax, offset mat_unk
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    mov     ax, [bp+vec_182.vx]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lx], ax
    adc     word ptr [bx+(VECTORLONG.lx+2)], dx
    mov     ax, [bp+vec_182.vy]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.ly], ax
    adc     word ptr [bx+(VECTORLONG.ly+2)], dx
    mov     ax, [bp+vec_182.vz]
    cwd
    mov     bx, [bp+var_DEptrTo1C0]
    add     word ptr [bx+VECTORLONG.lz], ax
    adc     word ptr [bx+(VECTORLONG.lz+2)], dx
    jmp     loc_15DC8
    ; align 2
    db 144*/
code_update_globalPos:
	pState_lvec1_x = (vecl_1C0[0].lx + vecl_1C0[1].lx + vecl_1C0[2].lx + vecl_1C0[3].lx) >> 2;
	pState_lvec1_y = (vecl_1C0[0].ly + vecl_1C0[1].ly + vecl_1C0[2].ly + vecl_1C0[3].ly) >> 2;
	pState_lvec1_z = (vecl_1C0[0].lz + vecl_1C0[1].lz + vecl_1C0[2].lz + vecl_1C0[3].lz) >> 2;
/*    mov     ax, word ptr [bp+vecl_1C0.lx]
    mov     dx, word ptr [bp+vecl_1C0.lx+2]
    add     ax, word ptr [bp+var_1B4.lx]
    adc     dx, word ptr [bp+var_1B4.lx+2]
    add     ax, word ptr [bp+var_1A8.lx]
    adc     dx, word ptr [bp+var_1A8.lx+2]
    add     ax, word ptr [bp+var_19C.lx]
    adc     dx, word ptr [bp+var_19C.lx+2]
    mov     cl, 2
loc_15F04:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15F04
    mov     pState_lvec1_x_ax, ax
    mov     pState_lvec1_x_dx, dx
    mov     ax, word ptr [bp+vecl_1C0.ly]
    mov     dx, word ptr [bp+vecl_1C0.ly+2]
    add     ax, word ptr [bp+var_1B4.ly]
    adc     dx, word ptr [bp+var_1B4.ly+2]
    add     ax, word ptr [bp+var_1A8.ly]
    adc     dx, word ptr [bp+var_1A8.ly+2]
    add     ax, word ptr [bp+var_19C.ly]
    adc     dx, word ptr [bp+var_19C.ly+2]
    mov     cl, 2
loc_15F35:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15F35
    mov     pState_lvec1_y_ax, ax
    mov     pState_lvec1_y_dx, dx
    mov     ax, word ptr [bp+vecl_1C0.lz]
    mov     dx, word ptr [bp+vecl_1C0.lz+2]
    add     ax, word ptr [bp+var_1B4.lz]
    adc     dx, word ptr [bp+var_1B4.lz+2]
    add     ax, word ptr [bp+var_1A8.lz]
    adc     dx, word ptr [bp+var_1A8.lz+2]
    add     ax, word ptr [bp+var_19C.lz]
    adc     dx, word ptr [bp+var_19C.lz+2]
    mov     cl, 2
loc_15F66:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_15F66
    mov     pState_lvec1_z_ax, ax
    mov     pState_lvec1_z_dx, dx*/
	var_DEptrTo1C0 = vecl_1C0;
	var_wheelIndex = 0;
/*    lea     ax, [bp+vecl_1C0]
    mov     [bp+var_DEptrTo1C0], ax
    mov     [bp+var_wheelIndex], 0*/
code_update_rotCoords:
	vec_1DE[var_wheelIndex].x = var_DEptrTo1C0->lx - pState_lvec1_x;
	vec_1DE[var_wheelIndex].y = var_DEptrTo1C0->ly - pState_lvec1_y;
	vec_1DE[var_wheelIndex].z = var_DEptrTo1C0->lz - pState_lvec1_z;
	var_DEptrTo1C0++;
	var_wheelIndex++;
	if (var_wheelIndex < 4)
		goto code_update_rotCoords;
	if (pState_lvec1_y >= 0)
		goto loc_15FDE;
	pState_lvec1_y = 0;
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lx]
    sub     ax, pState_lvec1_x_ax
    mov     [di-1DEh], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.ly]
    sub     ax, pState_lvec1_y_ax
    mov     [di-1DCh], ax
    mov     bx, [bp+var_DEptrTo1C0]
    mov     ax, word ptr [bx+VECTORLONG.lz]
    sub     ax, pState_lvec1_z_ax
    mov     [di-1DAh], ax
    add     [bp+var_DEptrTo1C0], 0Ch
    inc     [bp+var_wheelIndex]
    cmp     [bp+var_wheelIndex], 4
    jl      short code_update_rotCoords
    cmp     pState_lvec1_y_dx, 0
    jge     short loc_15FDE
    sub     ax, ax
    mov     pState_lvec1_y_dx, ax
    mov     pState_lvec1_y_ax, ax*/
loc_15FDE:
	if (pState_lvec1_x <= 0x1DF100)
		goto loc_15FFE;
/*
	if (pState_lvec1_x < 0x1D0000)
		goto loc_15FFE;
	if (pState_lvec1_x > 0x1D0000)
		goto loc_15FEF;
	if (pState_lvec1_x <= 0x0F100) // TODO: negative?
		goto loc_15FFE;*/
/*    cmp     pState_lvec1_x_dx, 1Dh
    jl      short loc_15FFE
    jg      short loc_15FEF
    cmp     pState_lvec1_x_ax, 0F100h
    jbe     short loc_15FFE*/
loc_15FEF:
	pState_lvec1_x = 0x1DF0FF;
	goto loc_1601B;
/*    mov     pState_lvec1_x_ax, 0F0FFh
    mov     pState_lvec1_x_dx, 1Dh
    jmp     short loc_1601B
    ; align 2
    db 144*/
loc_15FFE:
	if (pState_lvec1_x >= 0xF00)
		goto loc_1601B;
/*	if (pState_lvec1_x > 0)
		goto loc_1601B;
	if (pState_lvec1_x < 0)
		goto loc_1600F;
	if (pState_lvec1_x >= 0xF00) // TODO: ??
		goto loc_1601B;*/
/*    cmp     pState_lvec1_x_dx, 0
    jg      short loc_1601B
    jl      short loc_1600F
    cmp     pState_lvec1_x_ax, 0F00h
    jnb     short loc_1601B*/
loc_1600F:
	pState_lvec1_x = 0xF00;
    //mov     pState_lvec1_x_ax, 0F00h
    //mov     pState_lvec1_x_dx, 0
loc_1601B:
	if (pState_lvec1_z <= 0x1DF100)
		goto loc_1603A;

/*	if (pState_lvec1_z < 0x1D0000)
		goto loc_1603A;
	if (pState_lvec1_z > 0x1D0000)
		goto loc_1602C;
	if (pState_lvec1_z <= 0xF100) // TODO: negative?
		goto loc_1603A;*/
/*    cmp     pState_lvec1_z_dx, 1Dh
    jl      short loc_1603A
    jg      short loc_1602C
    cmp     pState_lvec1_z_ax, 0F100h
    jbe     short loc_1603A*/
loc_1602C:
	pState_lvec1_z = 0x1DF0FF;
	goto loc_16057;
/*    mov     pState_lvec1_z_ax, 0F0FFh
    mov     pState_lvec1_z_dx, 1Dh
    jmp     short loc_16057*/
loc_1603A:
	if (pState_lvec1_z >= 0xF00)
		goto loc_16057;
/*	if (pState_lvec1_z > 0)
		goto loc_16057;
	if (pState_lvec1_z < 0)
		goto loc_1604B;
	if (pState_lvec1_z >= 0xF00)
		goto loc_16057;*/
/*
    cmp     pState_lvec1_z_dx, 0
    jg      short loc_16057
    jl      short loc_1604B
    cmp     pState_lvec1_z_ax, 0F00h
    jnb     short loc_16057*/
loc_1604B:
	pState_lvec1_z = 0xF00;
/*    mov     pState_lvec1_z_ax, 0F00h
    mov     pState_lvec1_z_dx, 0*/
loc_16057:
	var_EE = vec_1DE[3].x + vec_1DE[2].x - vec_1DE[0].x - vec_1DE[1].x;
	var_F2 = vec_1DE[3].z + vec_1DE[2].z - vec_1DE[0].z - vec_1DE[1].z;
	pState_minusRotate_y_1 = polarAngle(var_EE, -var_F2) & 0x3FF;
	mat_rot_y(&var_MmatFromAngleZ, pState_minusRotate_y_1);
	var_wheelIndex = 0;
/*    mov     ax, [bp+vec_1CC.vx]
    add     ax, [bp+vec_1D2.vx]
    sub     ax, [bp+vec_1DE.vx]
    sub     ax, [bp+vec_1D8.vx]
    mov     [bp+var_EE], ax
    mov     ax, [bp+vec_1CC.vz]
    add     ax, [bp+vec_1D2.vz]
    sub     ax, [bp+vec_1DE.vz]
    sub     ax, [bp+vec_1D8.vz]
    mov     [bp+var_F2], ax
    neg     ax
    push    ax
    push    [bp+var_EE]
    call    polarAngle
    add     sp, 4
smart
    and     ah, 3
nosmart
    mov     pState_minusRotate_y_1, ax
    push    ax
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    call    mat_rot_y
    add     sp, 4
    mov     [bp+var_wheelIndex], 0*/
loc_160A7:
	vec_FC = vec_1DE[var_wheelIndex];
	mat_mul_vector(&vec_FC, &var_MmatFromAngleZ, &vec_1DE[var_wheelIndex]);
	var_wheelIndex++;
	if (var_wheelIndex < 4)
		goto loc_160A7;
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    sub     di, 1DEh
    push    si
    push    di
    mov     si, di
    lea     di, [bp+vec_FC]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    push    di
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    inc     [bp+var_wheelIndex]
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_160A7*/
	var_F2 = vec_1DE[3].z + vec_1DE[2].z - vec_1DE[0].z - vec_1DE[1].z;
	var_F4 = vec_1DE[3].y + vec_1DE[2].y - vec_1DE[0].y - vec_1DE[1].y;
	//var_F2 = vec_1CC.z + vec_1D2.z - vec_1DE.z - vec_1D8.z;
	//var_F4 = vec_1CC.y + vec_1D2.y - vec_1DE.y - vec_1D8.y;
	if (var_F4 != 0)
		goto loc_1611C;
	if (var_F2 < 0)
		goto loc_16146;
/*    mov     ax, [bp+vec_1CC.vz]
    add     ax, [bp+vec_1D2.vz]
    sub     ax, [bp+vec_1DE.vz]
    sub     ax, [bp+vec_1D8.vz]
    mov     [bp+var_F2], ax
    mov     ax, [bp+vec_1CC.vy]
    add     ax, [bp+vec_1D2.vy]
    sub     ax, [bp+vec_1DE.vy]
    sub     ax, [bp+vec_1D8.vy]
    mov     [bp+var_F4], ax
    or      ax, ax
    jnz     short loc_1611C
    cmp     [bp+var_F2], 0
    jl      short loc_16146*/
loc_1611C:
	pState_minusRotate_x_1 = polarAngle(-var_F2, var_F4) - 0x100;
	if (pState_minusRotate_x_1 >= 0)
		goto loc_1613E;
	goto loc_16141;
/*
	pState_minusRotate_x_1 = 0;
    push    [bp+var_F4]
    mov     ax, [bp+var_F2]
    neg     ax
    push    ax
    call    polarAngle
    add     sp, 4
    sub     ax, 100h
    mov     pState_minusRotate_x_1, ax
    or      ax, ax
    jge     short loc_1613E
    neg     ax
    jmp     short loc_16141
    ; align 2
    db 144*/
loc_1613E:
	if (pState_minusRotate_x_1 >= 2)
		goto loc_1614C;
	goto loc_16146;
    //mov     ax, pState_minusRotate_x_1
loc_16141:
	if (-pState_minusRotate_x_1 >= 2)
		goto loc_1614C;
	/*cmp     ax, 2
    jge     short loc_1614C*/
loc_16146:
    pState_minusRotate_x_1 = 0;
loc_1614C:
	if (pState_minusRotate_x_1 == 0)
		goto loc_161AB;
	mat_rot_x(&var_MmatFromAngleZ, pState_minusRotate_x_1);
	var_wheelIndex = 0;
/*    cmp     pState_minusRotate_x_1, 0
    jz      short loc_161AB
    push    pState_minusRotate_x_1
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    call    mat_rot_x
    add     sp, 4
    mov     [bp+var_wheelIndex], 0*/
loc_16169:
	vec_FC = vec_1DE[var_wheelIndex];
	mat_mul_vector(&vec_FC, &var_MmatFromAngleZ, &vec_1DE[var_wheelIndex]);
	var_wheelIndex++;
	if (var_wheelIndex < 4)
		goto loc_16169;
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    sub     di, 1DEh
    push    si
    push    di
    mov     si, di
    lea     di, [bp+vec_FC]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     di
    pop     si
    push    di
    lea     ax, [bp+var_MmatFromAngleZ]
    push    ax
    lea     ax, [bp+vec_FC]
    push    ax
    call    mat_mul_vector
    add     sp, 6
    inc     [bp+var_wheelIndex]
    cmp     [bp+var_wheelIndex], 4
    jl      short loc_16169*/
loc_161AB:
	var_F2 = vec_1DE[1].x + vec_1DE[2].x - vec_1DE[0].x - vec_1DE[3].x;
	var_F4 = vec_1DE[1].y + vec_1DE[2].y - vec_1DE[0].y - vec_1DE[3].y;

	//var_F2 = vec_1DE[3].x + vec_1DE[2].x - vec_1DE[0].x - vec_1DE[1].x;
	//var_F4 = vec_1DE[3].y + vec_1DE[2].y - vec_1DE[0].y - vec_1DE[1].y;
	
	//var_F2 = vec_1D8.x + vec_1D2.x - vec_1DE.x - vec_1CC.x;
	//var_F4 = vec_1D8.y + vec_1D2.y - vec_1DE.y - vec_1CC.y;
	if (var_F4 != 0)
		goto loc_161DE;
	if (var_F2 > 0)
		goto loc_16204;
/*    mov     ax, [bp+vec_1D8.vx]
    add     ax, [bp+vec_1D2.vx]
    sub     ax, [bp+vec_1DE.vx]
    sub     ax, [bp+vec_1CC.vx]
    mov     [bp+var_F2], ax
    mov     ax, [bp+vec_1D8.vy]
    add     ax, [bp+vec_1D2.vy]
    sub     ax, [bp+vec_1DE.vy]
    sub     ax, [bp+vec_1CC.vy]
    mov     [bp+var_F4], ax
    or      ax, ax
    jnz     short loc_161DE
    cmp     [bp+var_F2], 0
    jg      short loc_16204*/
loc_161DE:
	pState_minusRotate_z_1 = polarAngle(var_F2, var_F4) - 0x100;
	if (pState_minusRotate_z_1 >= 0)
		goto loc_161FC;
	goto loc_161FF;
/*    push    [bp+var_F4]
    push    [bp+var_F2]
    call    polarAngle
    add     sp, 4
    sub     ax, 100h
    mov     pState_minusRotate_z_1, ax
    or      ax, ax
    jge     short loc_161FC
    neg     ax
    jmp     short loc_161FF*/
loc_161FC:
	if (pState_minusRotate_z_1 >= 2)
		goto loc_1620A;
	goto loc_16204;
    //mov     ax, pState_minusRotate_z_1
loc_161FF:
	if (-pState_minusRotate_z_1 >= 2)
		goto loc_1620A;
    //cmp     ax, 2
    //jge     short loc_1620A
loc_16204:
    pState_minusRotate_z_1 = 0;
loc_1620A:
	arg_pState->car_sumSurfFrontWheels = arg_pState->car_surfaceWhl[0] + arg_pState->car_surfaceWhl[1];
	arg_pState->car_sumSurfRearWheels = arg_pState->car_surfaceWhl[2] + arg_pState->car_surfaceWhl[3];
	if (state.game_inputmode != 2)
		goto loc_16236;
	goto loc_16840;
/*    mov     bx, [bp+arg_pState]
    mov     di, bx
    mov     al, [di+CARSTATE.car_surfaceWhl1]
    add     al, [di+CARSTATE.car_surfaceWhl2]
    mov     [bx+CARSTATE.car_sumSurfFrontWheels], al
    mov     bx, [bp+arg_pState]
    mov     di, bx
    mov     al, [di+CARSTATE.car_surfaceWhl3]
    add     al, [di+CARSTATE.car_surfaceWhl4]
    mov     [bx+CARSTATE.car_sumSurfRearWheels], al
    cmp     state.game_inputmode, 2
    jnz     short loc_16236
    jmp     loc_16840*/
loc_16236:
	if (is_in_replay != 0)
		goto loc_1625F;
	if (arg_MplayerFlag == 0)
		goto loc_1624A;
	audio_unk3(arg_pState->field_CF, word_4408C);
	goto loc_1624E;
/*    cmp     is_in_replay, 0
    jnz     short loc_1625F
    cmp     [bp+arg_MplayerFlag], 0
    jz      short loc_1624A
    push    word_4408C
    jmp     short loc_1624E
    ; align 2
    db 144*/
loc_1624A:
	audio_unk3(arg_pState->field_CF, word_43964);
    //push    word_43964
loc_1624E:
	//audio_unk3(arg_pState->field_CF, );
/*    mov     bx, [bp+arg_pState]
    mov     al, [bx+CARSTATE.field_CF]
    sub     ah, ah
    push    ax
    push    cs
    call near ptr audio_unk3
    add     sp, 4*/
loc_1625F:
	var_EA = mat_rot_zxy(-pState_minusRotate_z_1, -pState_minusRotate_x_1, -pState_minusRotate_y_1, 0);
	var_wheelIndex = 0;
	goto loc_1632C;
/*    sub     ax, ax
    push    ax
    mov     ax, pState_minusRotate_y_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_x_1
    neg     ax
    push    ax
    mov     ax, pState_minusRotate_z_1
    neg     ax
    push    ax
    call    mat_rot_zxy
    add     sp, 8
    mov     [bp+var_EA], ax
    mov     [bp+var_wheelIndex], 0
    jmp     loc_1632C*/
loc_16288:
	var_E = planindex;
	vec_1C6 = arg_pState->car_whlWorldCrds2[var_wheelIndex];
	build_track_object(&vec_1C6, &vec_17C);
	if (var_E != planindex)
		goto loc_16309;
	var_138 = plane_origin_op(planindex, vec_1C6.x, vec_1C6.y, vec_1C6.z);
	if (game_replay_mode == 1)
		goto loc_16309;
	if (si >= 0)
		goto loc_162EE;
	if (var_138 > 0)
		goto loc_162F9;
/*
    mov     ax, planindex
    mov     [bp+var_E], ax
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    push    si
    lea     si, [bx+di+CARSTATE.car_whlWorldCrds2]
    lea     di, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    lea     ax, [bp+vec_17C]
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    build_track_object
    add     sp, 4
    mov     ax, planindex
    cmp     [bp+var_E], ax
    jnz     short loc_16309
    push    [bp+vec_1C6.vz]
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    ax
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     [bp+var_138], ax
    cmp     game_replay_mode, 1
    jz      short loc_16309
    or      si, si
    jge     short loc_162EE
    or      ax, ax
    jg      short loc_162F9*/
loc_162EE:
	if (si <= 0)
		goto loc_16309;
	if (var_138 >= 0)
		goto loc_16309;
/*    or      si, si
    jle     short loc_16309
    cmp     [bp+var_138], 0
    jge     short loc_16309*/
loc_162F9:
	update_crash_state(5, arg_MplayerFlag);
/*    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 5
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4*/
loc_16309:
	arg_pState->car_whlWorldCrds2[var_wheelIndex] = vec_17C;
	var_wheelIndex++;
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pState]
    push    si
    lea     di, [bx+di+CARSTATE.car_whlWorldCrds2]
    lea     si, [bp+vec_17C]
    push    ds
    pop     es
    movsw
    movsw
    movsw
    pop     si
    inc     [bp+var_wheelIndex]*/
loc_1632C:
	if (var_wheelIndex < 4)
		goto loc_16336;
	goto loc_16428;
/*    cmp     [bp+var_wheelIndex], 4
    jl      short loc_16336
    jmp     loc_16428*/
loc_16336:
	vec_1C6 = arg_pSimd->wheel_coords[var_wheelIndex];
	vec_1C6.y = arg_pSimd->collide_points[0].py << 6;
	mat_mul_vector(&vec_1C6, var_EA, &vec_FC);
/*    mov     al, [bp+var_wheelIndex]
    cbw
    mov     di, ax
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, [bp+arg_pSimd]
    push    si
    lea     si, [bx+di+SIMD.wheel_coords]
    lea     di, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     bx, [bp+arg_pSimd]
    mov     ax, [bx+SIMD.collide_points.y2]
    mov     cl, 6
    shl     ax, cl
    mov     [bp+vec_1C6.vy], ax
    lea     ax, [bp+vec_FC]
    push    ax
    push    [bp+var_EA]
    lea     ax, [bp+vec_1C6]
    push    ax
    call    mat_mul_vector
    add     sp, 6*/
	vec_1C6.x = (vec_FC.x + pState_lvec1_x) >> 6;
	vec_1C6.y = (vec_FC.y + pState_lvec1_y) >> 6;
	vec_1C6.z = (vec_FC.z + pState_lvec1_z) >> 6;
/*    mov     ax, [bp+vec_FC.vx]
    cwd
    add     ax, pState_lvec1_x_ax
    adc     dx, pState_lvec1_x_dx
    mov     cl, 6
loc_16389:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16389
    mov     [bp+vec_1C6.vx], ax
    mov     ax, [bp+vec_FC.vy]
    cwd
    add     ax, pState_lvec1_y_ax
    adc     dx, pState_lvec1_y_dx
    mov     cl, 6
loc_163A4:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_163A4
    mov     [bp+vec_1C6.vy], ax
    mov     ax, [bp+vec_FC.vz]
    cwd
    add     ax, pState_lvec1_z_ax
    adc     dx, pState_lvec1_z_dx
    mov     cl, 6
loc_163BF:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_163BF
    mov     [bp+vec_1C6.vz], ax*/
	vec_17C = vec_1C6;
	build_track_object(&vec_1C6, &arg_pState->car_whlWorldCrds2[var_wheelIndex]);
	si = plane_origin_op(planindex, vec_1C6.x, vec_1C6.y, vec_1C6.z);
	if (planindex < 4)
		goto loc_1641E;
	goto loc_16288;
/*    push    si
    lea     di, [bp+vec_17C]
    lea     si, [bp+vec_1C6]
    push    ss
    pop     es
    movsw
    movsw
    movsw
    pop     si
    mov     al, [bp+var_wheelIndex]
    cbw
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    add     ax, [bp+arg_pState]
    add     ax, CARSTATE.car_whlWorldCrds2
    push    ax
    lea     ax, [bp+vec_1C6]
    push    ax
    call    build_track_object
    add     sp, 4
    push    [bp+vec_1C6.vz]
    push    [bp+vec_1C6.vy]
    push    [bp+vec_1C6.vx]
    push    planindex
    push    cs
    call near ptr plane_origin_op
    add     sp, 8
    mov     si, ax
    cmp     planindex, 4
    jl      short loc_1641E
    jmp     loc_16288*/
loc_1641E:
	if (si <= 0)
		goto loc_16425;
	goto loc_16309;
/*    or      si, si
    jle     short loc_16425
    jmp     loc_16309*/
loc_16425:
    goto     loc_162F9;
loc_16428:
	var_11C = arg_pState->car_sumSurfFrontWheels + arg_pState->car_sumSurfRearWheels;
	if (arg_MplayerFlag != 0)
		goto loc_1644C;
	if (var_11C != 0)
		goto loc_1644C;
	if (arg_pState->car_sumSurfAllWheels == 0)
		goto loc_1644C;
	state.game_jumpCount++;
/*    mov     bx, [bp+arg_pState]
    mov     al, [bx+CARSTATE.car_sumSurfFrontWheels]
    add     al, [bx+CARSTATE.car_sumSurfRearWheels]
    mov     [bp+var_11C], al
    cmp     [bp+arg_MplayerFlag], 0
    jnz     short loc_1644C
    or      al, al
    jnz     short loc_1644C
    cmp     [bx+CARSTATE.car_sumSurfAllWheels], 0
    jz      short loc_1644C
    inc     state.game_jumpCount*/
loc_1644C:
	arg_pState->car_sumSurfAllWheels = var_11C;
	var_11ApStateWorldCrds[0].x = pState_lvec1_x >> 6;
	var_11ApStateWorldCrds[0].y = pState_lvec1_y >> 6;
	var_11ApStateWorldCrds[0].z = pState_lvec1_z >> 6;
/*    mov     al, [bp+var_11C]
    mov     [bx+CARSTATE.car_sumSurfAllWheels], al
    mov     ax, pState_lvec1_x_ax
    mov     dx, pState_lvec1_x_dx
    mov     cl, 6
loc_1645D:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_1645D
    mov     [bp+var_11ApStateWorldCrds.vx], ax
    mov     ax, pState_lvec1_y_ax
    mov     dx, pState_lvec1_y_dx
    mov     cl, 6
loc_16472:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16472
    mov     [bp+var_11ApStateWorldCrds.vy], ax
    mov     ax, pState_lvec1_z_ax
    mov     dx, pState_lvec1_z_dx
    mov     cl, 6
loc_16487:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_16487
    mov     [bp+var_11ApStateWorldCrds.vz], ax*/
	var_11ApStateWorldCrds[1].x = pState_minusRotate_z_1;
	var_11ApStateWorldCrds[1].y = pState_minusRotate_x_1;
	var_11ApStateWorldCrds[1].z = pState_minusRotate_y_1;
	if (gameconfig.game_opponenttype != 0)
		goto loc_164B2;
	goto loc_16578;
/*    mov     ax, pState_minusRotate_z_1
    mov     [bp+var_114], ax
    mov     ax, pState_minusRotate_x_1
    mov     [bp+var_112], ax
    mov     ax, pState_minusRotate_y_1
    mov     [bp+var_110], ax
    cmp     gameconfig.game_opponenttype, 0
    jnz     short loc_164B2
    jmp     loc_16578*/
loc_164B2:
	vec_18EoStateWorldCrds[0].x = arg_oState->car_posWorld1.lx >> 6;
	vec_18EoStateWorldCrds[0].y = arg_oState->car_posWorld1.ly >> 6;
	vec_18EoStateWorldCrds[0].z = arg_oState->car_posWorld1.lz >> 6;
/*    mov     bx, [bp+arg_oState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lx]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lx+2)]
    mov     cl, 6
loc_164BC:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_164BC
    mov     [bp+vec_18EoStateWorldCrds.vx], ax
    mov     bx, [bp+arg_oState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.ly]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.ly+2)]
    mov     cl, 6
loc_164D3:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_164D3
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     bx, [bp+arg_oState]
    mov     ax, word ptr [bx+CARSTATE.car_posWorld1.lz]
    mov     dx, word ptr [bx+(CARSTATE.car_posWorld1.lz+2)]
    mov     cl, 6
loc_164EA:
    sar     dx, 1
    rcr     ax, 1
    dec     cl
    jnz     short loc_164EA
    mov     [bp+vec_18EoStateWorldCrds.vz], ax*/
	vec_18EoStateWorldCrds[1].x = arg_oState->car_rotate.z;
	vec_18EoStateWorldCrds[1].y = arg_oState->car_rotate.y;
	vec_18EoStateWorldCrds[1].z = arg_oState->car_rotate.x;
	if (car_car_coll_detect_maybe(arg_pSimd->collide_points, var_11ApStateWorldCrds, arg_oSimd->collide_points, vec_18EoStateWorldCrds) == 0)
		goto loc_16578;
	if (arg_pState->field_C8 == 0)
		goto loc_1653E;
	goto loc_16892;
/*    mov     bx, [bp+arg_oState]
    mov     ax, [bx+CARSTATE.car_rotate.vz]
    mov     [bp+var_188], ax
    mov     ax, [bx+CARSTATE.car_rotate.vy]
    mov     [bp+var_186], ax
    mov     ax, [bx+CARSTATE.car_rotate.vx]
    mov     [bp+var_184], ax
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_oSimd]
    add     ax, SIMD.collide_points
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    or      al, al
    jz      short loc_16578
    mov     bx, [bp+arg_pState]
    cmp     [bx+CARSTATE.field_C8], 0
    jz      short loc_1653E
    jmp     loc_16892*/
loc_1653E:
	if (car_car_speed_adjust_maybe(arg_pState, arg_oState) != 0)
		goto loc_16550;
	goto loc_16892;
/*    push    [bp+arg_oState]
    push    bx
    push    cs
    call near ptr car_car_speed_adjust_maybe
    add     sp, 4
    or      al, al
    jnz     short loc_16550
    jmp     loc_16892*/
loc_16550:
	update_crash_state(1, arg_MplayerFlag);
	update_crash_state(1, arg_MplayerFlag ^ 1);
	return;
/*    mov     al, [bp+arg_MplayerFlag]
    cbw
    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4
    mov     al, [bp+arg_MplayerFlag]
    cbw
    xor     al, 1*/
loc_16566:
	return;
/*    push    ax
    mov     ax, 1
    push    ax
    push    cs
    call near ptr set_AV_event_triggers
    add     sp, 4
    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf*/
loc_16578:
	vec_FC.x = var_11ApStateWorldCrds[0].x >> 10;
	vec_FC.z = -((var_11ApStateWorldCrds[0].z >> 10) - 0x1D);
	vec_18EoStateWorldCrds[1].x = 0;
	vec_18EoStateWorldCrds[1].y = 0;
	vec_18EoStateWorldCrds[1].z = 0;
	if (vec_FC.x >= 0)
		goto loc_165AF;
	goto loc_16840;
	/*
    mov     ax, [bp+var_11ApStateWorldCrds.vx]
    mov     cl, 0Ah
    sar     ax, cl
    mov     [bp+vec_FC.vx], ax
    mov     ax, [bp+var_11ApStateWorldCrds.vz]
    sar     ax, cl          ; /2^10 : scale to tile index.
    sub     ax, 1Dh
    neg     ax
    mov     [bp+vec_FC.vz], ax
    mov     [bp+var_188], 0
    mov     [bp+var_186], 0
    mov     [bp+var_184], 0
    cmp     [bp+vec_FC.vx], 0
    jge     short loc_165AF
    jmp     loc_16840*/
loc_165AF:
	if (vec_FC.x < 0x1E)
		goto loc_165B9;
	goto loc_16840;
/*    cmp     [bp+vec_FC.vx], 1Eh
    jl      short loc_165B9
    jmp     loc_16840*/
loc_165B9:
	if (vec_FC.z >= 0)
		goto loc_165C0;
	goto loc_16840;
/*    or      ax, ax
    jge     short loc_165C0
    jmp     loc_16840*/
loc_165C0:
	if (vec_FC.z < 0x1E)
		goto loc_165C8;
	goto loc_16840;
/*    cmp     ax, 1Eh
    jl      short loc_165C8
    jmp     loc_16840*/
loc_165C8:
	var_EC = bto_auxiliary1(vec_FC.x, vec_FC.z, var_DC);
	if (var_EC == 0)
		goto loc_16650;
	si = 0;
	goto loc_165F0;
/*    lea     ax, [bp+var_DC]
    push    ax
    push    [bp+vec_FC.vz]
    push    [bp+vec_FC.vx]
    call    bto_auxiliary1
    add     sp, 6
    mov     [bp+var_EC], al
    or      al, al
    jz      short loc_16650
    sub     si, si
    jmp     short loc_165F0
    ; align 2
    db 144*/
loc_165EA:
	// NOTE: var_144 is unused
	// var_144 += 6;
	si++;
/*    add     [bp+var_144], 6
    inc     si*/
loc_165F0:
	if (var_EC <= si)
		goto loc_16650;
	vec_18EoStateWorldCrds[0].x = var_DC[si].x;
	vec_18EoStateWorldCrds[0].y = var_DC[si].y;
	vec_18EoStateWorldCrds[0].z = var_DC[si].z;
	if (car_car_coll_detect_maybe(arg_pSimd->collide_points, var_11ApStateWorldCrds, unk_3BD6A, vec_18EoStateWorldCrds) == 0)
		goto loc_165EA;
	arg_pState->car_36MwhlAngle -= 0x200;
/*    mov     al, [bp+var_EC]
    sub     ah, ah
    cmp     ax, si
    jbe     short loc_16650
    mov     ax, si
    mov     cx, ax
    shl     ax, 1
    add     ax, cx
    shl     ax, 1
    mov     di, ax
    add     di, bp
    mov     ax, [di-0DCh]
    mov     [bp+vec_18EoStateWorldCrds.vx], ax
    mov     ax, [di-0DAh]
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     ax, [di-0D8h]
    mov     [bp+vec_18EoStateWorldCrds.vz], ax
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD6A
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    or      al, al
    jz      short loc_165EA
    mov     bx, [bp+arg_pState]
    sub     [bx+CARSTATE.car_36MwhlAngle], 200h*/
loc_16648:
	// crash with start/finish pole
	update_crash_state(1, arg_MplayerFlag);
	return ;
/*    mov     al, [bp+arg_MplayerFlag]
    cbw
    jmp     loc_16566
    ; align 2
    db 144*/
loc_16650:
	si = (char)trackdata19[trackrows[vec_FC.z] + vec_FC.x];
	if (si != -1) //0xFF) // note: checking for 0xff elsewhere, should be signed and check for -1
		goto loc_16670;
	goto loc_16710;
/*    mov     bx, [bp+vec_FC.vz]
    shl     bx, 1
    mov     bx, trackrows[bx]
    add     bx, [bp+vec_FC.vx]
    les     di, trackdata19
    mov     al, es:[bx+di]
    cbw
    mov     si, ax
    cmp     si, 0FFFFh
    jnz     short loc_16670
    jmp     loc_16710*/
loc_16670:
	if (state.field_3FA[si] == 0)
		goto loc_1667A;
	goto loc_16710;
/*    cmp     state.field_3FA[si], 0
    jz      short loc_1667A
    jmp     loc_16710*/
loc_1667A:
	vec_18EoStateWorldCrds[0].x = td10_track_check_rel[si * 3 + 0];
	vec_18EoStateWorldCrds[0].y = td10_track_check_rel[si * 3 + 1];
	vec_18EoStateWorldCrds[0].z = td10_track_check_rel[si * 3 + 2];
	if (car_car_coll_detect_maybe(arg_pSimd->collide_points, var_11ApStateWorldCrds, unk_3BD5A, vec_18EoStateWorldCrds) == 0)
		goto loc_16710;
/*    mov     bx, si
    shl     bx, 1
    add     bx, ax
    shl     bx, 1
    les     di, td10_track_check_rel
    mov     ax, es:[bx+di]
    mov     [bp+vec_18EoStateWorldCrds.vx], ax
    mov     di, si
    mov     ax, di
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     bx, word ptr td10_track_check_rel
    mov     ax, es:[bx+di+2]
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     di, si
    mov     ax, di
    shl     di, 1
    add     di, ax
    shl     di, 1
    mov     ax, es:[bx+di+4]
    mov     [bp+vec_18EoStateWorldCrds.vz], ax
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD5A
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    or      al, al
    jz      short loc_16710*/
	state.field_3FA[si] = 1;
	
	state_op_unk(si + 2, -arg_pState->car_rotate.x, ((long)arg_pState->car_speed2 * 0x580) / 0x3C00);
	/*
    mov     state.field_3FA[si], 1
    mov     ax, 3C00h       ; 15360 = track grid length / 2
    cwd
    push    dx
    push    ax
    mov     ax, 580h        ; 1408
    cwd
    push    dx
    push    ax
    mov     bx, [bp+arg_pState]
    sub     ax, ax
    push    ax
    push    [bx+CARSTATE.car_speed2]
    call    __aFlmul
    push    dx
    push    ax
    call    __aFuldiv       ; *11/120
    push    ax
    mov     bx, [bp+arg_pState]
    mov     ax, [bx+CARSTATE.car_rotate.vx]
    neg     ax
    push    ax
    lea     ax, [si+2]
    push    ax
    push    cs
    call near ptr state_op_unk
    add     sp, 6*/
loc_16710:
	// following looks like collision detection against right and left start/finish poles
	if (vec_FC.x == startcol2)
		goto loc_1671F;
	goto loc_16840;
/*
    mov     al, startcol2
    cbw
    mov     di, ax
    cmp     [bp+vec_FC.vx], di
    jz      short loc_1671F
    jmp     loc_16840*/
loc_1671F:
	if (vec_FC.z == startrow2)
		goto loc_1672C;
	goto loc_16840;
/*    mov     al, startrow2
    cbw
    cmp     [bp+vec_FC.vz], ax
    jz      short loc_1672C
    jmp     loc_16840*/
loc_1672C:
	vec_18EoStateWorldCrds[0].x = trackcenterpos2[startcol2] + multiply_and_scale(sin_fast(track_angle + 0x100), 0x7E);
	vec_18EoStateWorldCrds[0].y = hillHeightConsts[hillFlag];
	vec_18EoStateWorldCrds[0].z = trackcenterpos[startrow2] + multiply_and_scale(cos_fast(track_angle + 0x100), 0x7E);
/*    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 1
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     bx, di
    shl     bx, 1
    mov     cx, trackcenterpos2[bx]
    add     cx, ax
    mov     [bp+vec_18EoStateWorldCrds.vx], cx
    mov     al, hillFlag
    cbw
    mov     bx, ax
    shl     bx, 1
    mov     ax, hillHeightConsts[bx]
    mov     [bp+vec_18EoStateWorldCrds.vy], ax
    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 1
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, ax
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    add     cx, trackcenterpos[bx]
    mov     [bp+vec_18EoStateWorldCrds.vz], cx*/
	var_138 = car_car_coll_detect_maybe(arg_pSimd->collide_points, var_11ApStateWorldCrds, unk_3BD62, vec_18EoStateWorldCrds);
	if (var_138 != 0)
		goto loc_16836;
/*
    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD62
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    cbw
    mov     [bp+var_138], ax
    or      ax, ax
    jnz     short loc_16836*/
	vec_18EoStateWorldCrds[0].x = trackcenterpos2[startcol2] + multiply_and_scale(sin_fast(track_angle + 0x300), 0x7E);
	vec_18EoStateWorldCrds[0].z = trackcenterpos[startrow2] + multiply_and_scale(cos_fast(track_angle + 0x300), 0x7E);
/*
    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 3
    push    ax
    call    sin_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, ax
    mov     al, startcol2
    cbw
    mov     bx, ax
    shl     bx, 1
    add     cx, trackcenterpos2[bx]
    mov     [bp+vec_18EoStateWorldCrds.vx], cx
    mov     ax, 7Eh ; '~'
    push    ax
    mov     ax, track_angle
    add     ah, 3
    push    ax
    call    cos_fast
    add     sp, 2
    push    ax
    call    multiply_and_scale
    add     sp, 4
    mov     cx, ax
    mov     al, startrow2
    cbw
    mov     bx, ax
    shl     bx, 1
    add     cx, trackcenterpos[bx]
    mov     [bp+vec_18EoStateWorldCrds.vz], cx*/
	var_138 = car_car_coll_detect_maybe(arg_pSimd->collide_points, var_11ApStateWorldCrds, unk_3BD62, vec_18EoStateWorldCrds);
/*    lea     ax, [bp+vec_18EoStateWorldCrds]
    push    ax
    mov     ax, offset unk_3BD62
    push    ax
    lea     ax, [bp+var_11ApStateWorldCrds]
    push    ax
    mov     ax, [bp+arg_pSimd]
    add     ax, SIMD.collide_points
    push    ax
    push    cs
    call near ptr car_car_coll_detect_maybe
    add     sp, 8
    cbw
    mov     [bp+var_138], ax*/
loc_16836:
	if (var_138 == 0)
		goto loc_16840;
	goto loc_16648;
/*    cmp     [bp+var_138], 0
    jz      short loc_16840
    jmp     loc_16648*/
loc_16840:
	arg_pState->car_posWorld1.lx = pState_lvec1_x;
	arg_pState->car_posWorld1.ly = pState_lvec1_y;
	arg_pState->car_posWorld1.lz = pState_lvec1_z;
	arg_pState->car_rotate.z = pState_minusRotate_z_1;
	arg_pState->car_rotate.y = pState_minusRotate_x_1;
	arg_pState->car_rotate.x = pState_minusRotate_y_1;
	arg_pState->field_C8 = 0;
/*    mov     bx, [bp+arg_pState]
    mov     ax, pState_lvec1_x_ax
    mov     dx, pState_lvec1_x_dx
    mov     word ptr [bx+CARSTATE.car_posWorld1.lx], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld1.lx+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, pState_lvec1_y_ax
    mov     dx, pState_lvec1_y_dx
    mov     word ptr [bx+CARSTATE.car_posWorld1.ly], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld1.ly+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, pState_lvec1_z_ax
    mov     dx, pState_lvec1_z_dx
    mov     word ptr [bx+CARSTATE.car_posWorld1.lz], ax
    mov     word ptr [bx+(CARSTATE.car_posWorld1.lz+2)], dx
    mov     bx, [bp+arg_pState]
    mov     ax, pState_minusRotate_z_1
    mov     [bx+CARSTATE.car_rotate.vz], ax
    mov     bx, [bp+arg_pState]
    mov     ax, pState_minusRotate_x_1
    mov     [bx+CARSTATE.car_rotate.vy], ax
    mov     bx, [bp+arg_pState]
    mov     ax, pState_minusRotate_y_1
    mov     [bx+CARSTATE.car_rotate.vx], ax
    mov     bx, [bp+arg_pState]
    mov     byte ptr [bx+CARSTATE.field_C8], 0*/
loc_16892:
	return ;
/*    pop     si
    pop     di
    mov     sp, bp
    pop     bp
    retf
ported_update_player_state_ endp
*/
}
