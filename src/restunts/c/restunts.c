#include <dos.h>
#include <stddef.h>
#include "restunts.h"
#include "fileio.h"
#include "keyboard.h"
#include "math.h"
#include "memmgr.h"
#include "shape2d.h"
#include "shape3d.h"

// Entries in the CVX gamestate buffer.
#define RST_CVX_NUM 20

// ASCII code properties map.
#define RST_ASC_CHAR_UPPER 0x01
#define RST_ASC_CHAR_LOWER 0x02
#define RST_ASC_NUMBER     0x04
#define RST_ASC_WHITESPACE 0x08
#define RST_ASC_PUNCTATION 0x10
#define RST_ASC_CONTROL    0x20
#define RST_ASC_SPACE      0x40
#define RST_ASC_HEX        0x80

// Use the Stunts' data for now.
extern unsigned const char* g_ascii_props;
/*
unsigned const char g_ascii_props[256] = {
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x28, 0x28, 0x28, 0x28, 0x28, 0x20, 0x20,
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
	0x48, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
	0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
	0x10, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x10, 0x10, 0x10, 0x10, 0x10,
	0x10, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x10, 0x10, 0x10, 0x10, 0x20,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};
*/

int get_0(void)
{
	return 0;
}

unsigned long timer_get_counter(void)
{
	/*
	unsigned long val;

	disable();
	val = timer_callback_counter;
	enable();

	return val;
	*/

	// Compiler produces too sloppy code; stick to asm for now...
	__asm {
		cli
		mov     ax, word ptr timer_callback_counter
		mov     dx, word ptr timer_callback_counter+2
		sti
	}
}

unsigned long timer_get_delta(void)
{
    /*
	unsigned long last, curr;
	
	last = last_timer_callback_counter;
	
	disable();
	curr = timer_get_counter();
	enable();
	
	last_timer_callback_counter = curr;

	return curr - last;
	*/
	
	// Compiler produces too sloppy code; stick to asm for now...
	__asm {
		mov     bx, word ptr last_timer_callback_counter
		mov     cx, word ptr last_timer_callback_counter+2
		cli
		mov     ax, word ptr timer_callback_counter
		mov     dx, word ptr timer_callback_counter+2
		sti
		mov     word ptr last_timer_callback_counter, ax
		mov     word ptr last_timer_callback_counter+2, dx
		sub     ax, bx
		sbb     dx, cx
	}
}

unsigned long timer_get_delta_alt(void)
{
	return timer_get_delta();
}

unsigned long timer_custom_delta(unsigned long ticks)
{
	return timer_get_counter() - ticks;
}

void timer_reset()
{
	timer_callback_counter = 0;
}

unsigned long timer_copy_counter(unsigned long ticks)
{
	timer_copy_unk = timer_get_counter() + ticks;
	return timer_copy_unk;
}

unsigned long timer_wait_for_dx(void)
{
	unsigned long res;
	do {
		res = timer_get_counter();
	} while (res < timer_copy_unk);
	
	return res;
}

int timer_compare_dx(void)
{
	return timer_get_counter() >= timer_copy_unk;
}

unsigned long timer_get_counter_unk(unsigned long ticks)
{
	unsigned long target, res;
	target = timer_get_counter() + ticks;
	
	do {
		res = timer_get_counter();
	} while (res < target);
	
	return res;
}

#define KEVINRANDOM_SEED_LEN 6
void init_kevinrandom(const char* seed)
{
	int i;

	for (i = 0; i < KEVINRANDOM_SEED_LEN; ++i) {
		g_kevinrandom_seed[i] = seed[i];
	}
}

void get_kevinrandom_seed(char* seed)
{
	int i;

	for (i = 0; i < KEVINRANDOM_SEED_LEN; ++i) {
		seed[i] = g_kevinrandom_seed[i];
	}
}

int get_kevinrandom(void)
{
	g_kevinrandom_seed[4] += g_kevinrandom_seed[5];
	g_kevinrandom_seed[3] += g_kevinrandom_seed[4];
	g_kevinrandom_seed[2] += g_kevinrandom_seed[3];
	g_kevinrandom_seed[1] += g_kevinrandom_seed[2];
	g_kevinrandom_seed[0] += g_kevinrandom_seed[1];
	
	!++g_kevinrandom_seed[5] 
	&& !++g_kevinrandom_seed[4]
	&& !++g_kevinrandom_seed[3]
	&& !++g_kevinrandom_seed[2]
	&& !++g_kevinrandom_seed[1]
	&& ++g_kevinrandom_seed[0];

	return g_kevinrandom_seed[0];
}

int get_super_random(void)
{
	int val = rand() + get_kevinrandom() + timer_get_counter() + gState_frame;
	return val < 0 ? -val : val;
}

int video_get_status(void)
{
	return inport(0x3DA) & 0x8;
}

int random_wait(void)
{
	int status1, i;
	
	status1 = video_get_status();
	
	for (i = 0; status1 == video_get_status() && i < 12000; ++i);
	
	if (i == 1024) {
		i = aMisc_1[0];
	}
	
	while (i--) {
		rand();
		get_kevinrandom();
	}
	
	i &= 0xFF;
	
	while (i--) {
		get_kevinrandom();
		rand();
	}
	
	return 0;
}

int toupper(int ch)
{
	if (ch >= 'a' && ch < 'z') {
		ch -= ' ';
	}
	
	return ch;
}

void init_row_tables(void) {
	int i;
	for (i = 0; i < 30; i++) {
		trackrows[i] = 30 * (29 - i);
		terrainrows[i] = 30 * i;
		trackpos[i] = (29 - i) << 10;
		trackpos2[i] = i << 10;
		trackcenterpos[i] = ((29 - i) << 10) + 0x200;
		terrainpos[i] = i << 10;
		terraincenterpos[i] = (i << 10) + 0x200;
		trackcenterpos2[i] = (i << 10) + 0x200;
	}
}

void set_default_car(void) {
	gameconfig.game_playercarid[0]     = 'C';
	gameconfig.game_playercarid[1]     = 'O';
	gameconfig.game_playercarid[2]     = 'U';
	gameconfig.game_playercarid[3]     = 'N';
	gameconfig.game_playermaterial     = 0;
	gameconfig.game_playertransmission = 1;
	gameconfig.game_opponenttype       = 0;
	gameconfig.game_opponentmaterial   = 0;
	gameconfig.game_opponentcarid[0]   = 0xFF;
}

void init_trackdata(void) {
	char far* trkptr;
	trkptr = mmgr_alloc_resbytes("trakdata", 0x6BF3);

	td01_track_file_cpy = trkptr;
	
	trkptr += 0x70a;
	td02_penalty_related = trkptr;
	
	trkptr += 0x70a;
	trackdata3 = trkptr;

	trkptr += 0x70a;
	td04_aerotable_pl = trkptr;

	trkptr += 0x80;
	td05_aerotable_op = trkptr;

	trkptr += 0x80;
	trackdata6 = trkptr;

	trkptr += 0x80;
	trackdata7 = trkptr;

	trkptr += 0x80;
	td08_direction_related = trkptr;

	trkptr += 0x60;
	trackdata9 = trkptr;

	trkptr += 0x180;
	td10_track_check_rel = trkptr;

	trkptr += 0x120;
	td11_highscores = trkptr;

	trkptr += 0x16c;
	trackdata12 = trkptr;

	trkptr += 0x0f0;
	td13_rpl_header = trkptr;

	trkptr += 0x1a;
	td14_elem_map_main = trkptr;

	trkptr += 0x385;
	td15_terr_map_main = trkptr;

	trkptr += 0x385;
	td16_rpl_buffer = trkptr;

	trkptr += 0x2ee0;
	td17_trk_elem_ordered = trkptr;

	trkptr += 0x385;
	trackdata18 = trkptr;

	trkptr += 0x385;
	trackdata19 = trkptr;

	trkptr += 0x385;
	td20_trk_file_appnd = trkptr;

	trkptr += 0x7ac;
	td21_col_from_path = trkptr;

	trkptr += 0x385;
	td22_row_from_path = trkptr;

	trkptr += 0x385;
	trackdata23 = trkptr;

	trkptr += 0x30;
}

extern struct SHAPE3D game3dshapes[];

extern unsigned select_cliprect_rotate(int angX, int angY, int angZ, struct RECTANGLE* cliprect, int unk);
//extern void transformed_shape_op(struct TRANSFORMSHAPE3D* shape);
extern void sub_29772(void);
extern void set_projection(int, int, int, int);

struct RECTANGLE shaperect = { 0, 320, 0, 200 };
struct TRANSFORMEDSHAPE3D transshape;
struct RECTANGLE cliprect = { 0, 0x140, 0, 0x5F };
struct VECTOR carpos = { 0, 0x0FCB8, 0x0B40 }; // from the original
//struct VECTOR carpos = { 0, 0, 320 };

extern struct SPRITE far* wndsprite;

extern struct RECTANGLE cliprect_unk;
//cliprect_unk    RECTANGLE <270Fh, 0FFFFh, 270Fh, 0FFFFh>

extern int polyinfonumpolys;
extern unsigned char far* polyinfoptrs[]; // array size = 0x190 
extern unsigned int word_40ED6[]; // array size = 0x190

extern void preRender_default(int color, int vertlinecount, int* vertlines);

void init_unknown(void)
{
	byte_44A8A = 1;
	byte_4552F = 2;
	elapsed_time2 = 0;
	byte_449DA = 0;
	byte_4393C = 0;
	word_44DCA = 0;
}

void init_carstate_from_simd(struct CARSTATE* playerstate, struct SIMD* simd, char transmission, long posX, long posY, long posZ, short track_angle)
{
	int i;
	struct VECTOR whlPos;

	playerstate->car_posWorld1.lx = posX;
	playerstate->car_posWorld2.lx = posX;
	playerstate->car_posWorld1.ly = posY + 512;
	playerstate->car_posWorld2.ly = posY;
	playerstate->car_posWorld1.lz = posZ;
	playerstate->car_posWorld2.lz = posZ;
	
	playerstate->car_rotate.x = track_angle;
	playerstate->car_rotate.y = 0;
	playerstate->car_rotate.z = 0;
	playerstate->car_36MwhlAngle = 0;
	playerstate->car_pseudoGravity = 0;
	playerstate->car_steeringAngle = 0;
	playerstate->car_is_braking = 0;
	playerstate->car_is_accelerating = 0;
	playerstate->car_currpm = simd->idle_rpm;
	playerstate->car_lastrpm = playerstate->car_currpm;
	playerstate->car_idlerpm2 = playerstate->car_currpm;
	playerstate->car_current_gear = 1;
	playerstate->car_speeddiff = 0;
	playerstate->car_speed = 0;
	playerstate->car_speed2 = 0;
	playerstate->car_lastspeed = 0;
	playerstate->car_gearratio = simd->gear_ratios[1];
	playerstate->car_gearratioshr8 = playerstate->car_gearratio >> 8;
	playerstate->car_knob_x = simd->knob_points[1].px;
	playerstate->car_knob_x2 = playerstate->car_knob_x;
	playerstate->car_knob_y = simd->knob_points[1].py;
	playerstate->car_knob_y2 = playerstate->car_knob_y;
	playerstate->car_angle_z = 0;
	playerstate->car_40MfrontWhlAngle = 0;
	playerstate->field_42 = 0;
	playerstate->field_48 = 0;
	playerstate->car_trackdata3_index = 0;
	playerstate->car_sumSurfFrontWheels = 2;
	playerstate->car_sumSurfRearWheels = 2;
	playerstate->car_sumSurfAllWheels = 4;
	playerstate->car_demandedGrip = 0;
	playerstate->car_surfacegrip_sum = 1000;

	whlPos.x = posX / 64;
	whlPos.y = posY / 64;
	whlPos.z = posZ / 64;

	for (i = 0; i < 4; ++i) {
		playerstate->car_surfaceWhl[i] = 1;
		playerstate->car_rc1[i] = 0;
		playerstate->car_rc2[i] = 0;
		playerstate->car_rc3[i] = 0;
		playerstate->car_rc4[i] = 0;
		playerstate->car_rc5[i] = 0;

		playerstate->car_whlWorldCrds1[i] = whlPos;
		playerstate->car_whlWorldCrds2[i] = whlPos;
	}

	playerstate->car_engineLimiterTimer = 0;
	playerstate->car_slidingFlag = 0;
	playerstate->field_C8 = 0;
	playerstate->car_crashBmpFlag = 0;
	playerstate->car_changing_gear = 0;
	playerstate->car_fpsmul2 = 0;
	playerstate->car_transmission = transmission;
	playerstate->field_CD = 0;
	playerstate->field_CE = 0;
	playerstate->field_CF = 1;
}

void init_game_state(short arg)
{
	int i, tmpcol, tmprow;

	if (arg == -1) {
		elapsed_time1 = 0;

		for (i = 0; i < RST_CVX_NUM; ++i) {
			((struct GAMESTATE far*)cvxptr)[i].field_3F4 = 0;
		}
	}
	
	if (framespersec == 10) {
		steerWhlRespTable_ptr = &steerWhlRespTable_10fps;
	}
	else {
		steerWhlRespTable_ptr = &steerWhlRespTable_20fps;
	}
	
	word_45A00 = framespersec * 30;
	word_4499C = 100 / framespersec;

	if (arg != -3) {
		init_unknown();

		state.field_3F4 = 1;
		state.game_frames_per_sec = 1;
		state.game_inputmode = 0;
		state.game_3F6autoLoadEvalFlag = 0;
		state.game_frame_in_sec = 0;
		state.field_2F4 = 0;
		state.field_3F7[0] = 0;
		state.field_3F7[1] = 0;

		for (i = 0; i < 48; ++i) {
			state.field_3FA[i] = 0;
		}
				
		for (i = 0; i < 24; ++i) {
			state.field_38E[i] = 0;
		}

		state.game_vec1[0].x =
			  multiply_and_scale(sin_fast(track_angle + 0x300),  512)
			+ multiply_and_scale(sin_fast(track_angle + 0x200), 4096)
			+ ((short)startcol2 << 10);

		state.game_vec1[0].y = hillHeightConsts[hillFlag] + 960;

		state.game_vec1[0].z =
			  multiply_and_scale(cos_fast(track_angle + 0x300),  512)
			+ multiply_and_scale(cos_fast(track_angle + 0x200), 4096)
			+ trackpos[startrow2];

		state.game_vec1[1] = state.game_vec1[0];
		state.game_vec3 = state.game_vec1[0];
		state.game_vec4 = state.game_vec1[0];
		
		state.game_travDist = 0;
		state.game_frame = 0;
		state.game_total_finish = 0;
		state.field_144 = 0;
		state.game_pEndFrame = 0;
		state.game_oEndFrame = 0;
		state.game_penalty = 0;
		state.game_impactSpeed = 0;
		state.game_topSpeed = 0;
		state.game_jumpCount = 0;

		// Init player car.
		tmpcol =
			  multiply_and_scale(sin_fast(track_angle + 0x200), 210)
			+ multiply_and_scale(sin_fast(track_angle + 0x100),  36);
		
		tmprow =
			  multiply_and_scale(cos_fast(track_angle + 0x200), 210)
			+ multiply_and_scale(cos_fast(track_angle + 0x100),  36);

		init_carstate_from_simd(
			&state.playerstate,
			&simd_player,
			gameconfig.game_playertransmission,
			(long)(trackcenterpos2[startcol2] + tmpcol) * 64L,
			(long)hillHeightConsts[hillFlag] * 64L,
			(long)(trackcenterpos[startrow2] + tmprow) * 64L,
			-track_angle);

		state.field_2F2 = 0;
		state.field_45D = 0;
		state.field_45E = 0;
		state.field_45B = 0;
		state.field_45C = 0;
		
		state.game_startcol  = startcol2;
		state.game_startcol2 = startcol2;
		state.game_startrow  = startrow2;
		state.game_startrow2 = startrow2;

		if (arg != -2) {
			sub_18D60(
				state.playerstate.car_trackdata3_index,
				&state.playerstate.car_vec_unk3,
				state.playerstate.field_CE,
				0);
			
			state.playerstate.field_CE++;
		}

		// Init opponent car.
		tmpcol =
			  multiply_and_scale(sin_fast(track_angle + 0x200), 210)
			+ multiply_and_scale(sin_fast(track_angle + 0x300),  36);
		
		tmprow =
			  multiply_and_scale(cos_fast(track_angle + 0x200), 210)
			+ multiply_and_scale(cos_fast(track_angle + 0x300),  36);

		init_carstate_from_simd(
			&state.opponentstate,
			&simd_opponent,
			1,
			(long)(trackcenterpos2[startcol2] + tmpcol) * 64L,
			(long)hillHeightConsts[hillFlag] * 64L,
			(long)(trackcenterpos[startrow2] + tmprow) * 64L,
			-track_angle);

		if (gameconfig.game_opponenttype && arg != -2) {
			sub_18D60(
				trackdata3[state.opponentstate.car_trackdata3_index], // TODO: Verify
				&state.opponentstate.car_vec_unk3,
				state.opponentstate.field_CE,
				&state.field_3F9); // TODO: Verify
		
			state.opponentstate.field_CE++;
		}

		state.field_42A = 0;
	}
}

void restore_gamestate(unsigned short frame)
{
	unsigned short curframe;

	if (frame == 0 && elapsed_time1 == 0) {
		init_game_state(0);
	}
	
	curframe = frame / word_45A00;
	
	if (curframe == RST_CVX_NUM) {
		curframe--;
	}
	
	// Find last gamestate in cvx.
	if (frame >= state.game_frame) {
		while (1) {
			if (curframe * word_45A00 <= state.game_frame) {
				return;
			}
			else if (((struct GAMESTATE far*)cvxptr)[curframe].field_3F4 != 0) {
				break;
			}
			
			curframe--;
		}
	}
	
	// Copy last gamestate from cvx.
	state = ((struct GAMESTATE far*)cvxptr)[curframe];

	init_kevinrandom(state.kevinseed);
	elapsed_time2 = state.game_frame;
}


void update_gamestate() {
	char var_carInputByte;

	var_carInputByte = td16_rpl_buffer[state.game_frame];
	if (var_carInputByte != 0) {
		state.game_inputmode = 1;
	}
	
	if ((state.game_frame % word_45A00) == 0) {
		get_kevinrandom_seed(state.kevinseed);
	
		fmemcpy(&cvxptr[state.game_frame / word_45A00], MK_FP(FP_SEG(&state), FP_OFF(&state)), sizeof(struct GAMESTATE));
	}

	state.game_frame++;
	if (state.game_3F6autoLoadEvalFlag != 0 && state.game_frame_in_sec < state.game_frames_per_sec) {
		state.game_frame_in_sec++;
		if (state.game_frame_in_sec == state.game_frames_per_sec && byte_449DA == 0) {
			if (state.playerstate.car_crashBmpFlag == 1 && state.playerstate.car_speed2 != 0) {
				state.game_frames_per_sec++;
			} else if (game_replay_mode == 0) {
				byte_449DA = 1;
			}
		}
	}

	if (state.game_inputmode != 0) {
		
		player_op(var_carInputByte);
		
		if (gameconfig.game_opponenttype != 0) {
			opponent_op();
		}

		sub_2298C();
		if (state.field_42A != 0) {
			sub_19BA0();
		}

		audio_carstate();

	} else if (game_replay_mode == 1) {
		// if paused
		audio_carstate();
		if (byte_4393C != 0) {
			if (word_44DCA < 0x1C2) {
				word_44DCA += 8;
			}

			if (byte_4393C == 1 && word_44DCA > 0x180) {
				byte_4393C++;
			}

			if (byte_4393C == 2) {
				if (  multiply_and_scale(cos_fast(track_angle), trackcenterpos[startrow2] - (state.playerstate.car_posWorld1.lz >> 6)) 
					+ multiply_and_scale(sin_fast(track_angle), trackcenterpos2[startcol2] - (state.playerstate.car_posWorld1.lx >> 6)) <= 0xE4) {
					if (state.playerstate.car_speed != 0) {
						player_op(2);
					} else {
						byte_4393C = 0;
					}
				} else 
				if (state.playerstate.car_speed < 0x500) {
					player_op(1);
				} else {
					player_op(0);
				}
			}
		}
	}
}

extern char aCarcoun[];
extern void far* engptr;
extern void far* eng1ptr;
extern void far* fontledresptr;
extern void far* sdgameresptr;
extern void far* wallptr;
extern void far* planptr;
extern int word_43964;
extern char unk_3E7FC[];
extern char byte_459D8;
extern char byte_42D26;
extern char byte_42D2A;
extern int word_4408C;
extern char unk_3E82C[];
extern int word_44D1E;
extern int word_449E4;
extern int word_443F4;

extern char gnam_string[]; // 40 bytes
extern char gsna_string[]; // 5 bytes

extern void copy_string(char*, char far*);

void setup_aero_trackdata(void far* carresptr, int is_opponent) {
	int i;
	if (is_opponent == 0) {
		fmemcpy(MK_FP(FP_SEG(&simd_player), FP_OFF(&simd_player)), locate_shape_alt(carresptr, "simd"), sizeof(struct SIMD));
		simd_player.aerorestable = td04_aerotable_pl;
		// Maximum speed is 40h
		// Division by 2^9.
		// 2^8 shifts one fullbyte, and it is known there is a 1/2 factor in FDrag.
		for (i = 0; i < 0x40; i++) {
			td04_aerotable_pl[i] = ((long)simd_player.aero_resistance * (long)i * (long)i) >> 9;
		}

		copy_string(gnam_string, locate_shape_alt(carresptr, "gnam"));
	} else {
		fmemcpy(MK_FP(FP_SEG(&simd_opponent), FP_OFF(&simd_opponent)), locate_shape_alt(carresptr, "simd"), sizeof(struct SIMD));
		simd_opponent.aerorestable = td05_aerotable_op;

		for (i = 0; i < 0x40; i++) {
			td05_aerotable_op[i] = ((long)simd_opponent.aero_resistance * (long)i * (long)i) >> 9;
		}
		copy_string(gsna_string, locate_shape_alt(carresptr, "gsna"));
	}
}

extern int audio_init_engine(int, void far*, void far*, void far*);

int setup_player_cars(void) {
	void far* carresptr;
	unsigned long var_8;

	wndsprite = 0;
	ensure_file_exists(2);
	shape3d_load_car_shapes(gameconfig.game_playercarid, gameconfig.game_opponentcarid);
	aCarcoun[3] = gameconfig.game_playercarid[0];
	aCarcoun[4] = gameconfig.game_playercarid[1];
	aCarcoun[5] = gameconfig.game_playercarid[2];
	aCarcoun[6] = gameconfig.game_playercarid[3];
	carresptr = file_load_resfile(aCarcoun);
	setup_aero_trackdata(carresptr, 0);
	unload_resource(carresptr);

	if (gameconfig.game_opponenttype != 0) {
		aCarcoun[3] = gameconfig.game_opponentcarid[0];
		aCarcoun[4] = gameconfig.game_opponentcarid[1];
		aCarcoun[5] = gameconfig.game_opponentcarid[2];
		aCarcoun[6] = gameconfig.game_opponentcarid[3];
		carresptr = file_load_resfile(aCarcoun);
		setup_aero_trackdata(carresptr, 1);
		unload_resource(carresptr);
		
		ensure_file_exists(4);
		load_opponent_data();
	}

	ensure_file_exists(3);
	eng1ptr = file_load_resource(5, "eng1");//aEng1); // "eng1"
	engptr = file_load_resource(6, "eng");//aEng); // "eng"
	audio_add_driver_timer();
	word_43964 = audio_init_engine(0x21, &unk_3E7FC, eng1ptr, engptr);

	byte_459D8 = 0;
	byte_42D26 = 0;
	byte_42D2A = 0;
	if (gameconfig.game_opponenttype != 0) {
		word_4408C = audio_init_engine(0x20, &unk_3E82C, eng1ptr, engptr);
	}

	word_44D1E = 0;
	word_449E4 = 0;
	word_443F4 = 0;
	fontledresptr = file_load_resource(0, "fontled.fnt");//aFontled_fnt); // "fontled.fnt"
	timertestflag_copy = timertestflag;
	init_rect_arrays();
	if (idle_expired == 0) {
		setup_car_shapes(0);
	}

	if (idle_expired == 0) {
		sdgameresptr = file_load_resource(3, "sdgame");//aSdgame); // "sdgame"
		loop_game(0, 0, 0);
	}

	gameresptr = file_load_resfile("game");
	planptr = locate_shape_alt(gameresptr, "plan");//aPlan); // "plan"
	wallptr = locate_shape_alt(gameresptr, "wall");//aWall); // "wall"
	load_sdgame2_shapes();
	load_skybox(td14_elem_map_main[0x384]);
	if (shape3d_load_all() != 0) {
		return 1;
	}

	if (video_flag5_is0 == 0) {
		
		var_8 = 0xFA00 / (video_flag1_is1 * video_flag4_is1);
		if (mmgr_get_res_ofs_diff_scaled() <= var_8) {
			return 1;
		}
		wndsprite = sprite_make_wnd(0x140, 0xC8, 0x0F);
	}

	followOpponentFlag = 0;
	is_in_replay_copy = -1;
	return 0;
}

void free_player_cars(void) {
	if (video_flag5_is0 == 0) {
		if (wndsprite != 0) {
			sprite_free_wnd(wndsprite);
		}
	}
	shape3d_free_all();
	unload_skybox();
	free_sdgame2();
	unload_resource(gameresptr);
	if (idle_expired == 0) {
		mmgr_free(sdgameresptr);
		setup_car_shapes(3);
	}

	mmgr_free(fontledresptr);
	audio_remove_driver_timer();
	mmgr_free(engptr);
	mmgr_free(eng1ptr);
	shape3d_free_car_shapes();
}

void shape2d_render_bmp_as_mask(void far* data);

void run_game(void) {
	int var_16[2];
	int var_12, var_E, var_C;
	struct RECTANGLE var_rect;
	int var_2;
	int regsi;

	var_C = -1;
	rect_windshield.left = 0;
	rect_windshield.right = 320;
	var_2 = -1;
	word_449EA = -1;
	run_game_random = get_kevinrandom() << 3;
	replaybar_toggle = 1;
	is_in_replay = 0;
	if (idle_expired == 0) {
		if (gameconfig.game_recordedframes != 0) {
			cameramode = 0;
			game_replay_mode = 2;
			is_in_replay = 1;
		} else {
			cameramode = 0;
			game_replay_mode = 1;
		}
	} else {
		cameramode++;
		if (cameramode == 4) {
			cameramode = 0;
		}

		game_replay_mode = 2;		
		if (file_load_replay(0, "default") != 0) {
			return ;
		}
		track_setup();
	}

	if (setup_player_cars() != 0) {
		free_player_cars();
		do_mer_restext();
	} else {

		kbormouse = 0;
		byte_449E6 = 0;
		byte_449DA = 1;
		set_frame_callback();
		game_replay_mode_copy = -1;
		byte_44346 = 0;
		byte_4432A = 0;
		byte_46467 = 0;
		dashb_toggle = 0;

		if (idle_expired != 0) {
			framespersec = gameconfig.game_framespersec;

			init_game_state(-1);
		} else {
			if (is_in_replay == 0) {
				cameramode = 0;
				dashb_toggle = 1;
				show_penalty_counter = 0;
				framespersec = framespersec2;
				gameconfig.game_framespersec = framespersec2;
				init_game_state(-1);
				word_45D94 = 0;
				*(char*)&word_45D3E = 0; // byte ptr!
				byte_4393C = 1;
				mouse_minmax_position(byte_3B8F2);
				game_replay_mode = 1;
				
				state.playerstate.car_posWorld1.lx += multiply_and_scale(sin_fast(track_angle), -240) << 6;
				state.playerstate.car_posWorld1.lz += multiply_and_scale(cos_fast(track_angle), -240) << 6;
				state.playerstate.car_posWorld1.ly += 0x580;
				byte_43966 = 1;
			} else {
				cameramode = 0;
				game_replay_mode = 2;
				word_44DCA = 0x1F4;
				framespersec = gameconfig.game_framespersec;
				restore_gamestate(0);
				restore_gamestate(gameconfig.game_recordedframes);

				while (gameconfig.game_recordedframes != state.game_frame) {
					if (input_do_checking(1) == 27)
						break;
					update_gamestate();
				}

				elapsed_time2 = gameconfig.game_recordedframes;
			}
		}

		while (1) {

			if (state.game_frame != elapsed_time2) {
				if ((byte_3B8F2 != 0 || byte_3FE00 != 0) && game_replay_mode == 0) {
					replay_unk();
				}
				update_gamestate();
				continue;
			}
			
			
			if (game_replay_mode == 0 && byte_449DA == 0 && state.game_inputmode != 0) {
				if (var_C == state.game_frame)
					continue;
				var_C = state.game_frame;
			}

			if (state.game_inputmode == 0 && game_replay_mode == 0) {
				elapsed_time2 = 0;
				gameconfig.game_recordedframes = 0;
				state.game_frame = 0;
			}

			if (timertestflag_copy != timertestflag) {
				timertestflag_copy = timertestflag;
				init_rect_arrays();
			}

			if (byte_46467 != 0) {
				input_push_status();
				audio_unk();
				regsi = show_dialog(2, 1, locate_text_res(gameresptr, "rbf"), -1, -1, dialogarg2, 0, 0);
				if (regsi == -1)
					regsi = 0;

				sub_372F4();
				word_3F88E = 0;
				input_pop_status();
				if (regsi != 0) {
					update_crash_state(4, 0);
					byte_449DA = 1;
				}

				byte_46467 = 0;
			}

			if (video_flag5_is0 != 0) {
				setup_mcgawnd2();
				byte_4432A = byte_44346;
			} else {
				sprite_copy_wnd_to_1();
			}

			if (game_replay_mode != game_replay_mode_copy || dashb_toggle != dashb_toggle_copy || replaybar_toggle != replaybar_toggle_copy || is_in_replay != is_in_replay_copy || followOpponentFlag != followOpponentFlag_copy) {
				game_replay_mode_copy = game_replay_mode;
				dashb_toggle_copy = dashb_toggle;
				replaybar_toggle_copy = replaybar_toggle;
				is_in_replay_copy = is_in_replay;
				followOpponentFlag_copy = followOpponentFlag;
				roofbmpheight_copy = 0;
				byte_449E2 = 0;

				if (game_replay_mode != 2 || idle_expired != 0 || (replaybar_toggle == 0 && is_in_replay == 0)) {
					replaybar_enabled = 0;
				} else {
					replaybar_enabled = 1;
				}

				if (idle_expired != 0) {
					dashbmp_y_copy = 0xC8;
				} else 
				if (dashb_toggle == 0 || followOpponentFlag != 0) {
					if (game_replay_mode == 2) {
						if (replaybar_enabled != 0) {
							dashbmp_y_copy = 0x97;
						} else {
							dashbmp_y_copy = 0xC8;
						}
					} else {
						dashbmp_y_copy = 0xC8;
					}
				} else {
					if (game_replay_mode != 2 || replaybar_enabled == 0) {
						height_above_replaybar = 200;
					} else {
						height_above_replaybar = 151;
					}

					byte_449E2 = 1;
					roofbmpheight_copy = roofbmpheight;
					dashbmp_y_copy = dashbmp_y;
				}

				if (var_2 != roofbmpheight_copy || dashbmp_y_copy != word_449EA || var_E != height_above_replaybar) {
					byte_454A4 = video_flag6_is1;
					set_projection(0x23, dashbmp_y_copy / 6, 0x140, dashbmp_y_copy);
					rect_windshield.top = roofbmpheight_copy;
					rect_windshield.bottom = dashbmp_y_copy;
					var_2 = roofbmpheight_copy;
					word_449EA = dashbmp_y_copy;
					var_E = height_above_replaybar;
				}
			}

			if (byte_454A4 != 0) {
				byte_449D8[byte_4432A] = 0;
				if (byte_449E2 != 0) {
					sprite_set_1_size(0, 0x140, dashbmp_y_copy, height_above_replaybar);
					setup_car_shapes(1);
				}

				if (replaybar_enabled != 0) {
					sprite_set_1_size(0, 0x140, 0, 0xC8);
					loop_game(1, state.game_frame, state.game_frame);
				}
			} else {
				if (replaybar_enabled == 0) {
					byte_449D8[byte_4432A] = 0;
				}
			}

			update_frame(byte_44346, &rect_windshield);
			if (dastbmp_y != 0 && byte_449E2 != 0) {			
				if (timertestflag_copy != 0) {
					var_rect.left = 0;
					var_rect.right = 0x140;
					var_rect.top = dastbmp_y;
					var_rect.bottom = dashbmp_y_copy;
					if (rectptr_unk != 0) {
						rect_union(rectptr_unk, &var_rect, rectptr_unk);
					}
				}

				shape2d_render_bmp_as_mask(dasmshapeptr);
				shape2d_op_unk4(dastbmp_y2, dastseg);
			}

			sub_19F14(&rect_windshield);
			if (byte_449E2 != 0) {
				sprite_set_1_size(0, 0x140, dashbmp_y_copy, height_above_replaybar);
				setup_car_shapes(2);
				sprite_set_1_size(0, 0x140, 0, 0xC8);
			}

			if (byte_454A4 != 0) {
				byte_454A4--;
			}

			if (video_flag5_is0 != 0) {
				mouse_draw_opaque_check();
				setup_mcgawnd1();
				byte_44346 ^= 1;
				byte_4432A = byte_44346;
				mouse_draw_transparent_check();
			}

			if (game_replay_mode == 1 && byte_4393C == 0) {
				game_replay_mode = 0;
				framespersec = framespersec2;
				gameconfig.game_framespersec = framespersec2;
				init_game_state(-1);
			}

			if (idle_expired == 0) {
				if (byte_449DA != 0) {

					if ((game_replay_mode != 0 || state.game_3F6autoLoadEvalFlag == 4) && byte_449DA != 2) {
						byte_449DA = 0;
						game_replay_mode = 2;
						mouse_minmax_position(0);
						loop_game(0, 0, 0);
						loop_game(2, 4, 0);
						is_in_replay = 1;
						audio_carstate();
					} else {
						break;
					}
				}

				if (game_replay_mode == 2) {
					loop_game(3, 0, 0);
					continue;
				}

				do {
					var_12 = kb_get_char();
					if (var_12 != 0) {
						handle_ingame_kb_shortcuts(var_12);
					}

				} while (var_12 == 0x4800 || var_12 == 0x4B00 || var_12 == 0x4D00 || var_12 == 0x5000);

				if (game_replay_mode == 1) {
					mouse_get_state(&mouse_butstate, &mouse_xpos, &mouse_ypos);
					if (((mouse_butstate & 3) != 0) || ((get_kb_or_joy_flags() & 0x30) != 0)) {
						game_replay_mode = 0;
						byte_4393C = 0;
						framespersec = framespersec2;
						gameconfig.game_framespersec = framespersec2;
						init_game_state(-1);
					}
				}

			} else {
				if (kb_get_char() != 0 || byte_449DA != 0 || get_kb_or_joy_flags() != 0) {
					break;
				}
			}
		}

		if (video_flag5_is0 != 0 && get_0() != 0) {
			mouse_draw_opaque_check();
			setup_mcgawnd2();
			sub_35C4E(0, 0, 0x140, 0xC8, 0);
			setup_mcgawnd1();
			mouse_draw_transparent_check();
		}

		sprite_copy_2_to_1_2();
		is_in_replay = 1;
		audio_carstate();
		audio_remove_driver_timer();
		if (game_replay_mode == 0 && gameconfig.game_opponenttype != 0 && state.opponentstate.car_crashBmpFlag == 0) {
			show_dialog(3, 0, locate_text_res(gameresptr, "cop"), -1, 0x50, performGraphColor, &var_16, 0);
			*(char*)&word_45D3E = 1;
			regsi = framespersec;
			regsi--;

			while (1) {
				replay_unk2(1);
				update_gamestate();
				regsi++;
				if (regsi == framespersec) {
					regsi = 0;
					format_frame_as_string(&resID_byte1, state.game_frame + elapsed_time1, 1);
					mouse_draw_opaque_check();
					sub_345BC(&resID_byte1, font_op2_alt(&resID_byte1), var_16[1]);
					mouse_draw_transparent_check();
				}

				if (input_do_checking(1) == 27)
					break;
				if (state.opponentstate.car_crashBmpFlag != 0)
					break;
				if (0x5DC * framespersec == state.game_frame + elapsed_time1)
					break;
			}
		}

		*(char*)&word_45D3E = 0; // byte ptr 
		mouse_minmax_position(0);
		remove_frame_callback();
		free_player_cars();
	}

	waitflag = 0x64;
	check_input();
	show_waiting();

	return ;
}

void init_div0(void)
{
	// Use original code until we can link with a libc for intdosx().
	ported_init_div0_();

	/*
	union REGS inregs, outregs;
	struct SREGS segregs;
	
	// Get current division by zero interrupt.
	inregs.h.ah = 0x35;
	inregs.h.al = 0;
	intdosx(&inregs, &outregs, &segregs);
	
	old_intr0_handler = MK_FP(segregs.es, outregs.x.bx);
	
	// Set division by zero interrupt.
	inregs.h.ah = 0x25;
	inregs.h.al = 0;
	segregs.ds  = FP_SEG(intr0_handler);
	inregs.x.dx = FP_OFF(intr0_handler);
	intdosx(&inregs, &outregs, &segregs);
	*/
}

void copy_material_list_pointers(void* clrlist, void* clrlist2, void* patlist, void* patlist2, unsigned short videoConst)
{
	material_clrlist_ptr_cpy = clrlist;
	material_clrlist2_ptr_cpy = clrlist2;
	material_patlist_ptr_cpy = patlist;
	material_patlist2_ptr_cpy = patlist2;
	someZeroVideoConst = videoConst;
}

void init_main(int argc, char* argv[])
{
	unsigned int i, j;
	unsigned char argmode4, argnosound, argnounknown;
	unsigned long timerdelta1, timerdelta2, timerdelta3;
	struct POINT2D tmppoint;
	struct RECTANGLE tmprect;

	// Keyboard
	kb_init_interrupt();
	kb_shift_checking2();
	kb_call_readchar_callback();

	kb_reg_callback(0x0007, &do_mrl_textres);
	kb_reg_callback(0x000A, &do_joy_restext);
	kb_reg_callback(0x000B, &do_key_restext);
	kb_reg_callback(0x3200, &do_mof_restext);
	kb_reg_callback(0x0010, &do_pau_restext);
	kb_reg_callback('p', &do_pau_restext);
	kb_reg_callback(0x0011, &do_dos_restext);
	kb_reg_callback(0x0013, &do_sonsof_restext);
	kb_reg_callback(0x0018, &do_dos_restext);
	
	// Video
	video_flag1_is1 = 1;
	video_flag2_is1 = 1;
	video_flag3_isFFFF = -1;
	video_flag4_is1 = 1;

	mmgr_alloc_a000();
	
	video_flag5_is0 = 0;
	video_flag6_is1 = 1;
	
	textresprefix = 'e';
	
	// Parse arguments.
	argmode4 = 0;
	argnosound = 0;
	argnounknown = 0;
	
	for (i = 1; argc > i; ++i) {
		if (argv[i][0] == '/') {
			switch (argv[i][1]) {
				case 'h':
					argmode4 = 4;
					break;

				case 'n':
					if (argv[i][2] == 's') {
						argnosound = 1;
					}
					else if (argv[i][2] == 'd') {
						argnounknown = 1;
					}
					break;

				case 's':
					if ((((g_ascii_props[argv[i][2]] & RST_ASC_CHAR_UPPER) ? (argv[i][2] + ' ') : (argv[i][2])) == 's')
					 && (((g_ascii_props[argv[i][3]] & RST_ASC_CHAR_UPPER) ? (argv[i][3] + ' ') : (argv[i][3])) == 'b')) {
						audiodriverstring[0] = argv[i][2];
						audiodriverstring[1] = argv[i][3];
					}
					else {
						audiodriverstring[0] = 'a';
						audiodriverstring[1] = 'd';
					}
					break;
			}
		}
	}
	
	// Unused "/nd" switch. Maybe used when loading other video drivers?
	(void)argnounknown;

	// Video mode.
	video_set_mode_13h();
	if (argmode4) {
		video_set_mode4();
	}

	timer_setup_interrupt();

	sprite_copy_2_to_1_clear();

	mouse_init(0x0140, 0x00C8);

	// Audio driver.
	if (audio_load_driver(&audiodriverstring, 0, 0)) {
		audio_stop_unk();
		libsub_quit_to_dos_alt(1);
	}
	
	if (argnosound) {
		audio_toggle_flag2();
		audio_toggle_flag6();
	}
	
	set_criterr_handler(&do_dea_textres);
	
	load_palandcursor();
	
	// Timing measures.
	sprite_copy_2_to_1();
	sprite_set_1_size(0, 320, 0, 120);

	timer_get_delta_alt();
	for (i = 0; i < 15; ++i) {
		ported_sprite_clear_1_color_(0); // the c impl is too slow/wrong and produces faulty timing values
	}
	timerdelta1 = timer_get_delta_alt();
	
	sprite_set_1_size(0, 320, 0, 60);

	for (i = 0; i < 15; ++i) {
		tmprect.left = tmprect.right = tmprect.top = tmprect.bottom = 0;
		
		for (j = 0; j < 400; ++j) {
			tmppoint.px = tmppoint.py = j;
			rect_adjust_from_point(&tmppoint, &tmprect);
		}
		
		sprite_clear_1_color(0);
	}
	
	timerdelta2 = timer_get_delta_alt();

	for (i = 0; i < 146; ++i) {
		for (j = 0; j < 255; ++j) {
			rect_adjust_from_point(&tmppoint, &tmprect);
		}
	}
	
	timerdelta3 = timer_get_delta_alt();
	
	timertestflag = (timerdelta2 <= timerdelta1);
	framespersec2 = (timerdelta3 >= 75) ? 10 : 20;

	if (timerdelta3 < 35) {
		timertestflag2 = 0;
	}
	else if (timerdelta3 < 55) {
		timertestflag2 = 1;
	}
	else if (timerdelta3 < 75) {
		timertestflag2 = 2;
	}
	else if (timerdelta3 < 100) {
		timertestflag2 = 3;
	}
	else if (timertestflag) {
		timertestflag2 = 4;
	}
	else {
		timertestflag2 = 3;
	}

	framespersec = framespersec2;
	timertestflag_copy = timertestflag;
	
	random_wait();
	
	copy_material_list_pointers(material_clrlist_ptr, material_clrlist2_ptr, material_patlist_ptr, material_patlist2_ptr, 0);
}

int stuntsmain2(int argc, char* argv[]) {
	int result;
	char far* textresptr;
	int carposangle;
	struct SPRITE far* var42wnd;
	int counter;
	int inch;
	int shapeindex;

	// initialization
	init_main(argc, argv);
	init_div0();
	init_row_tables();
	
	mainresptr = file_load_resfile("main");
	fontdefptr = file_load_resource(0, "fontdef.fnt");
	fontnptr = file_load_resource(0, "fontn.fnt");
	
	font_set_fontdef();
	init_polyinfo();
	init_trackdata();

	init_unknown();
	
	init_kevinrandom("kevin");

	strcpy(gameconfig.game_trackname, "DEFAULT");
	
	input_do_checking(1);
	input_do_checking(1);
	mouse_draw_opaque_check();

	kbormouse = 0;
	passed_security = 1;  // set to 0 for the original copy protection	
	//set_default_car();
		
	// try do something
	sub_29772();
	set_projection(0x24, 0x11, 0x140, 0x64);	// would at best draw just a pixel without this - camera projection??

	wndsprite = sprite_make_wnd(320, 100, 0x0F);

	//run_intro_looped();
	
	carposangle = polarAngle(carpos.y, carpos.z);

	shape3d_load_all();
	shape3d_load_car_shapes("coun", "coun");
	select_cliprect_rotate(0, carposangle, 0, &cliprect, 0);

	//shaperect = cliprect;
	transshape.material = 0;
	transshape.rotvec.x = 0;
	transshape.rotvec.y = 0;
	transshape.pos = carpos;

	transshape.unk = 0;//0x7530;
	transshape.ts_flags = 0;
	transshape.rectptr = &shaperect;

	counter = 0;
	shapeindex = 24;
	for (; ; counter++) {

		transshape.rotvec.z = 0; //counter + 0x230;
		
		// seg000:1C58                 mov     [bp+var_transshape.ts_shapeptr], (offset game3dshapes.shape3d_numverts+0AA8h)
		// 0xAA8 / sizeof(SHAPE3D) = 0xAA8 / 0x16 = 124, points at where car0 is loaded during shape3d_load_car_shapes();

		transshape.shapeptr = &game3dshapes[shapeindex];

		//transshape.shapeptr = &game3dshapes[124];
		//transshape.shapeptr = &game3dshapes[124];
		
		transformed_shape_op(&transshape);
		
		sprite_copy_wnd_to_1();
		sprite_clear_1_color(3);
		
		//sprite_set_1_size(50, 200, 50, 100);
		get_a_poly_info(); // renders to sprite1
	
		//sprite_copy_2_to_1_2();
		sprite_blit_to_video(wndsprite); // sprite_blit_to_video(wndsprite);
		
		inch = get_kb_or_joy_flags();//kb_get_char();
		if (inch == 4) { // right
			shapeindex++;
			shapeindex = (shapeindex + 0x74) % 0x74;
		} else
		if (inch == 8) { // left
			shapeindex--;
			shapeindex = (shapeindex + 0x74) % 0x74;
		} else
		if (inch != 0) {
			textresptr = locate_text_res(mainresptr, "dos");
			//result = show_dialog(2, 1, textresptr, 0xFFFF, 0xFFFF, dialogarg2, 0, 0); // center
			result = show_dialog(2, 1, textresptr, 0, 170, dialogarg2, 0, 0);
			if (result >= 1)
				break;
		}
	}

	//var42wnd = sprite_make_wnd(320, 200);
	//setup_mcgawnd2();
	//sprite_set_1_size(0, 320, 0, 200);
	//sprite_copy_2_to_1_2();
	//sprite_clear_1_color(2);
		//sprite_copy_wnd_to_1();
		//sprite_copy_2_to_1_2();
	
		//sprite_putimage(wndsprite->sprite_bitmapptr);
		//sprite_putimage(var42wnd->sprite_bitmapptr);
	
	//fatal_error("happy yet?");


	// shutdown
	mouse_draw_opaque_check();
	audio_stop_unk();
	audiodrv_atexit();
	kb_exit_handler();
	kb_shift_checking1();
	video_set_mode7();
	
	fatal_error("err %i", inch);

	return 0;
}

int stuntsmainimpl(int argc, char* argv[]) {

	int i, result;
	int regax, regsi;
	char var_A;
	char far* trkptr;
	char far* textresptr;
	
	//return ported_stuntsmain_(argc, argv);

	init_main(argc, argv);
	init_div0();
	init_row_tables();
	
	mainresptr = file_load_resfile("main");
	
	fontdefptr = file_load_resource(0, "fontdef.fnt");
	fontnptr = file_load_resource(0, "fontn.fnt");

	font_set_fontdef();
	init_polyinfo();
	
	init_trackdata();

	init_unknown();
	
	init_kevinrandom("kevin");
	
	strcpy(gameconfig.game_trackname, "DEFAULT");
	
	//fatal_error("ai");
	
	input_do_checking(1);
	input_do_checking(1);
	mouse_draw_opaque_check();
	
	kbormouse = 0;
	passed_security = 1;  // set to 0 for the original copy protection
	set_default_car();

	regsi = 1;

	while (1) {

		ensure_file_exists(2);
		
		if (regsi != 0) {
			file_build_path(byte_3B80C, gameconfig.game_trackname, ".trk", g_path_buf);
			file_read_fatal(g_path_buf, td14_elem_map_main);
		}
		
		idle_expired = 0;
		result = run_intro_looped();
		if (result == 27) {
			textresptr = locate_text_res(mainresptr, "dos");
			result = show_dialog(2, 1, textresptr, 0xFFFF, 0xFFFF, dialogarg2, 0, 0);
			if (result >= 1) {
				mouse_draw_opaque_check();
				audio_stop_unk();
				audiodrv_atexit();
				kb_exit_handler();
				kb_shift_checking1();
				video_set_mode7();
				return result;
			}
			regsi = 0;
			continue;
		}

		while (1) {
			ensure_file_exists(2);
			if (is_audioloaded == 0) {
				file_load_audiores("skidslct", "skidms", "SLCT");
			}
			result = run_menu();
			if (result == -1)  {
				audio_unload();
				regsi = 0;
				break;
			} else if (result == 0) {
				var_A = 0;
			} else if (result == 1) {
				check_input();
				show_waiting();
				run_car_menu(&gameconfig, &gameconfig.game_playermaterial, &gameconfig.game_playertransmission, 0);
				continue;
			} else if (result == 2) {
				check_input();
				show_waiting();
				run_opponent_menu();
				continue;
			} else if (result == 3) {
				run_tracks_menu(0);
				continue;
			} else if (result == 4) {
				check_input();
				show_waiting();
				result = run_option_menu();
				if (result == 0) {
					continue;
				} else {
					// goto replay-mode if option-menu-result != 0
					var_A = 1;
				}
			} else {
				continue;
			}

			_memcpy(&gameconfigcopy, &gameconfig, sizeof(struct GAMEINFO));
			for (i = 0; i < 0x70A; i++) {
				td20_trk_file_appnd[i] = td14_elem_map_main[i];
			}
			for (i = 0; i < 0x51; i++) {
				td20_trk_file_appnd[i + 0x70A] = byte_3B80C[i];
				td20_trk_file_appnd[i + 0x75B] = byte_3B85E[i];
			}
			
			if (idle_expired == 0) {
				result = track_setup();
				//result = setup_track();
				if (result != 0) {
					run_tracks_menu(1);
					continue;
				}
				random_wait();
				if (passed_security == 0) {
					fatal_error("security check");
					//get_super_random();
					//security_check();
				}
			} else if (file_find("tedit.*") == 0) {
				audio_unload();
				regsi = 0;
				break;
			}

			audio_unload();

			cvxptr = mmgr_alloc_resbytes("cvx", sizeof(struct GAMESTATE) * RST_CVX_NUM);
			init_game_state(-1);
			
			if (var_A != 0) {
				byte_43966 = 0;
 			} else {

				gameconfig.game_recordedframes = 0;
			}

			while (1) {
				show_waiting();
				run_game();
				if (idle_expired == 0 && byte_43966 != 0) {
					result = end_hiscore();
					if (result == 0) {
						// view replay
						byte_43966 = 4;
						continue;
					} else if (result == 1) {
						// drive
						gameconfig.game_recordedframes = 0;
						continue;
					}
				}
				// main menu
				break;
			}

			_memcpy(&gameconfigcopy, &gameconfig, sizeof(struct GAMEINFO));
			for (i = 0; i < 0x70A; i++) {
				td14_elem_map_main[i] = td20_trk_file_appnd[i];
			}
			for (i = 0; i < 0x51; i++) {
				byte_3B80C[i] = td20_trk_file_appnd[i + 0x70A];
				byte_3B85E[i] = td20_trk_file_appnd[i + 0x75B];
			}
			mmgr_release(cvxptr);
			
			if (idle_expired != 0) {
				regsi = 0;
				break;
			}
		}
	
	}
}

