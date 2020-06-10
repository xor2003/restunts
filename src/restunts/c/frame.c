#include "externs.h"
#include "math.h"
#include "shape3d.h"

extern struct RECTANGLE* rectptr_unk2;
extern struct RECTANGLE rect_array_unk[];
extern struct RECTANGLE rect_array_unk2[];
extern struct RECTANGLE rect_unk[];
extern struct RECTANGLE rect_unk2;
extern struct RECTANGLE rect_unk6;
extern struct RECTANGLE rect_unk9;
extern struct RECTANGLE rect_unk11;
extern struct RECTANGLE rect_unk12;
extern struct RECTANGLE rect_unk15;
extern struct RECTANGLE cliprect_unk;
extern struct VECTOR vec_unk2;
extern struct VECTOR vec_planerotopresult;
extern struct MATRIX mat_temp;
extern int word_3B8EC;
extern int word_3B8F0;
extern int word_3B8EE;
extern int word_44D20;
extern char byte_3C09C[];
extern char byte_3C0C6[];
extern char word_46468;
extern int word_3BE34[];
extern char* off_3C084[];
extern struct SHAPE3D* off_3BE44[];
extern int terrainHeight;
extern int planindex;
extern int planindex_copy;
extern char byte_4392C;
extern struct TRANSFORMEDSHAPE3D currenttransshape[29];
//extern struct TRANSFORMEDSHAPE3D transshapeunk;
extern struct TRANSFORMEDSHAPE3D* curtransshape_ptr;
extern struct TRACKOBJECT trkObjectList[215]; // 215 entries
extern unsigned char fence_TrkObjCodes[];
extern int pState_minusRotate_z_2, pState_minusRotate_x_2, pState_minusRotate_y_2, pState_f36Mminf40sar2;

extern char unk_3C0EE[];
extern char unk_3C0F0[];
extern char unk_3C0F8[];
extern char unk_3C0F4[];
extern int word_3C0D6[];
extern int unk_3C0A2[];
extern int unk_3C0A6[];
extern int unk_3C0AE[];
extern int unk_3C0B6[];
extern struct TRACKOBJECT sceneshapes2[];
extern struct TRACKOBJECT sceneshapes3[];
extern struct SHAPE3D game3dshapes[130];
extern struct VECTOR carshapevec;
extern struct VECTOR carshapevecs[6];
extern short word_443E8[];
extern struct VECTOR oppcarshapevec;
extern struct VECTOR oppcarshapevecs[6];
extern short word_4448A[];
extern char backlights_paint_override;
extern int word_449FC[];
extern int word_463D6;
extern int transformedshape_zarray[];
extern int transformedshape_indices[];
extern char transformedshape_arg2array[];
extern int sdgame2_widths[];
extern void far* sdgame2shapes[];
extern void far* fontledresptr;
extern int dialog_fnt_colour;
extern char transformedshape_counter;

void build_track_object(struct VECTOR* a, struct VECTOR* b);
void transformed_shape_add_for_sort(int a, int b);
unsigned char subst_hillroad_track(unsigned char a, unsigned char b);
int skybox_op(int a, struct RECTANGLE* rectptr, int c, struct MATRIX* matptr, int e, int f, int g);
struct RECTANGLE* draw_ingame_text(void);
struct RECTANGLE* init_crak(int frame, int top, int height);
struct RECTANGLE* do_sinking(int frame, int top, int height);
struct RECTANGLE* intro_draw_text(char* str, int a, int b, int c, int d);
void font_set_fontdef2(void far* data);
void format_frame_as_string(char* s, int time, int c);
void shape_op_explosion(int a, void far* shp, int x, int y);
void heapsort_by_order(int n, int* heap, int* data);

void update_frame(char arg_0, struct RECTANGLE* arg_cliprectptr) {
	int si;
	char var_122;
	char var_E4;
	char var_DC[2];
	struct RECTANGLE* var_rectptr;
	struct MATRIX var_mat, var_mat2;
	struct MATRIX* var_matptr;
	struct VECTOR var_vec4, var_vec5, var_vec6, var_vec7, var_vec8;
	int var_angX2, var_angY2, var_angZ2;
	int var_angX, var_angY, var_E0;
	int var_38, var_angZ;
	int var_transformresult;
	int var_52;
	char* var_50;
	int var_2;
	int var_counter, var_counter2;
	char var_posadjust, var_pos2adjust;
	char var_poslookup, var_pos2lookup;
	char var_poslookupadjust, var_pos2lookupadjust;
	char var_D8, var_E2;
	unsigned char var_1A[24];
	char var_32[24];
	char var_BC[24];
	char var_postab[24];
	char var_pos2tab[24];
	unsigned char var_14C[24];
	char var_130;
	char var_3C;
	char var_60;
	char var_6E;
	char var_4A;
	char var_4E;
	int var_6C;
	int var_A4;
	int var_hillheight;
	int var_multitileflag;
	struct TRACKOBJECT* var_trkobjectptr;
	struct TRACKOBJECT* var_trkobject_ptr; // NOTE: beware of similar names!!
	char var_FC;
	char* var_10E;
	int di;
	int var_132;
	int var_5E;
	int var_3A;
	int* var_DA;
	int var_12A;
	unsigned char var_4C;
	struct RECTANGLE var_rect, var_rect2;
	struct VECTOR far* var_108;
	struct CARSTATE* var_stateptr;
	unsigned char elem_map_value;
	unsigned char terr_map_value;

	var_DC[0] = 0;
	var_DC[1] = 0;
	if (video_flag5_is0 == 0 || arg_0 == 0) {
		rectptr_unk = rect_array_unk;
		rectptr_unk2 = rect_array_unk2;
	} else {
		rectptr_unk2 = rect_array_unk;
		rectptr_unk = rect_array_unk2;
	}

	if (timertestflag_copy != 0) {
		var_122 = 8;
		var_rectptr = rect_unk;
		for (si = 0; si < 15; si++) {
			*var_rectptr = cliprect_unk;
			var_rectptr++;
		}
	} else {
		var_122 = 0;
	}

	if (followOpponentFlag == 0) {		
		var_vec5.x = state.playerstate.car_posWorld1.lx >> 6;
		var_vec5.y = state.playerstate.car_posWorld1.ly >> 6;
		var_vec5.z = state.playerstate.car_posWorld1.lz >> 6;
		var_angX2 = state.playerstate.car_rotate.y;
		var_angZ2 = state.playerstate.car_rotate.z;
		var_angY2 = state.playerstate.car_rotate.x;
	} else {
		var_vec5.x = state.opponentstate.car_posWorld1.lx >> 6;
		var_vec5.y = state.opponentstate.car_posWorld1.ly >> 6;
		var_vec5.z = state.opponentstate.car_posWorld1.lz >> 6;
		var_angX2 = state.opponentstate.car_rotate.y;
		var_angZ2 = state.opponentstate.car_rotate.z;
		var_angY2 = state.opponentstate.car_rotate.x;
	}

	var_angY = -1;
	var_E0 = 0;
	
	if (cameramode == 0) {
		var_angY = var_angY2 & 0x3ff;
		var_angX = var_angX2 & 0x3ff;
		var_E0   = var_angZ2 & 0x3ff;
		var_matptr = mat_rot_zxy(-var_angZ2, -var_angX2, -var_angY2, 0);
		var_vec6.x = 0;
		var_vec6.z = 0;
		var_vec6.y = simd_player.car_height - 6;

		mat_mul_vector(&var_vec6, var_matptr, &var_vec7);
		var_vec4.x = var_vec5.x + var_vec7.x;
		var_vec4.y = var_vec5.y + var_vec7.y;
		var_vec4.z = var_vec5.z + var_vec7.z;
	} else if (cameramode == 1) {
		var_vec4.x = state.game_vec1[followOpponentFlag].x;
		var_vec4.z = state.game_vec1[followOpponentFlag].z;
		var_vec4.y = state.game_vec1[followOpponentFlag].y;
	} else if (cameramode == 2) {
		var_vec6.x = 0;
		var_vec6.y = 0;
		var_vec6.z = 0x4000;
		var_matptr = mat_rot_zxy(-var_angZ2, -var_angX2, -var_angY2, 0);
		mat_mul_vector(&var_vec6, var_matptr, &var_vec7);

		var_vec6.x = 0;
		var_vec6.y = 0;
		var_vec6.z = word_3B8EC;
		var_matptr = mat_rot_zxy(0, -word_3B8F0, polarAngle(var_vec7.x, var_vec7.z) - word_3B8EE, 0);

		mat_mul_vector(&var_vec6, var_matptr, &var_vec7);
		var_vec4.x = var_vec5.x + var_vec7.x;
		var_vec4.y = var_vec5.y + var_vec7.y;
		var_vec4.z = var_vec5.z + var_vec7.z;
	} else if (cameramode == 3) {
		var_vec4.x = trackdata9[state.field_3F7[followOpponentFlag] * 3 + 0];
		var_vec4.y = trackdata9[state.field_3F7[followOpponentFlag] * 3 + 1] + word_44D20 + 0x5A;
		var_vec4.z = trackdata9[state.field_3F7[followOpponentFlag] * 3 + 2];
	}

	if (var_angY == -1) {
		build_track_object(&var_vec4, &var_vec4);
		if (var_vec4.y < terrainHeight) {
			var_vec4.y = terrainHeight;
		}

		if (byte_4392C != 0) {		
			si = plane_origin_op(planindex, var_vec4.x, var_vec4.y, var_vec4.z);
			if (si < 0xC) {			
				vec_unk2.x = 0;
				vec_unk2.y = 0xC - si;
				vec_unk2.z = 0;
				planindex_copy = planindex;
				pState_f36Mminf40sar2 = 0;
				pState_minusRotate_x_2 = 0;
				pState_minusRotate_z_2 = 0;
				pState_minusRotate_y_2 = 0;
				plane_rotate_op();
				var_vec4.x += vec_planerotopresult.x;
				var_vec4.y += vec_planerotopresult.y;
				var_vec4.z += vec_planerotopresult.z;
			}
		}

		var_angY = (-polarAngle(var_vec5.x - var_vec4.x, var_vec5.z - var_vec4.z)) & 0x3FF;
		var_38 = polarRadius2D(var_vec5.x - var_vec4.x, var_vec5.z - var_vec4.z);
		var_angX = polarAngle(var_vec5.y - var_vec4.y + 0x32, var_38) & 0x3FF;
	}

	if (var_E0 > 1 && var_E0 < 0x3FF) {
		var_angZ = var_E0;
	} else {
		var_angZ = 0;
	}

	if (state.game_frame == 0) {
		var_E4 = byte_3C0C6[word_46468&0xF];
	} else {
		var_E4 = byte_3C0C6[state.game_frame&0xF];
	}

	var_52 = select_cliprect_rotate(var_angZ, var_angX, var_angY, arg_cliprectptr, 0);
	var_50 = off_3C084[(var_52 & 0x3FF) >> 7];

	var_mat = *mat_rot_zxy(var_angZ, var_angX, 0, 1);
	var_vec6.x = 0;
	var_vec6.y = 0;
	var_vec6.z = 0x3E8;
	mat_mul_vector(&var_vec6, &var_mat, &var_vec8);
	if (var_vec8.z > 0) {
		var_2 = 1;
	} else {
		var_2 = -1;
	}

	if (timertestflag2 == 0) {
		currenttransshape[0].rectptr = &rect_unk9;
		currenttransshape[0].ts_flags = var_122 | 7;
		currenttransshape[0].rotvec.x = 0;
		currenttransshape[0].rotvec.y = 0;
		currenttransshape[0].unk = 0x400;
		currenttransshape[0].material = 0;

		for (var_counter = 0; var_counter < 8; var_counter++) {
			si = (word_3BE34[var_counter] + var_angY + run_game_random) & 0x3ff;
			if (si < 0x87 || si > 0x379) {
				mat_rot_y(&var_mat2, si);
				var_vec6.x = 0;
				var_vec6.y = 0xAE6 - var_vec4.y;
				var_vec6.z = 0x3A98; //15000
				mat_mul_vector(&var_vec6, &var_mat2, &var_vec7);
				var_vec7.z = 0x3A98; //15000
				mat_mul_vector(&var_vec7, &var_mat, &currenttransshape[0].pos);
				if (currenttransshape[0].pos.z > 0xC8) {
					currenttransshape[0].shapeptr = off_3BE44[var_counter];
					currenttransshape[0].rotvec.z = -var_angY;
					var_transformresult = transformed_shape_op(&currenttransshape[0]);
				}
			}
		}
	}

/*
; -----------------------------------------------------------------------------------------------
*/

	var_pos2adjust = var_vec4.x >> 0xA;
	var_posadjust = -((var_vec4.z >> 0xA) - 0x1D);
	if (timertestflag2 != 0) {
		var_D8 = state.playerstate.car_posWorld1.lx >> 16;
		var_E2 = 0x1D - (state.playerstate.car_posWorld1.lz >> 16);
	}

	for (si = 0; si < 0x17; si++) {
		var_32[si] = 0;
	}

	var_130 = byte_3C09C[timertestflag2];
	
	for (si = 0x16; si >= 0; si--) {
		if (var_32[si] != 0)
			continue;

		if (var_50[si * 3 + 2] <= var_130) {
			var_pos2lookup = var_50[si * 3] + var_pos2adjust;
			var_poslookup = var_50[si * 3 + 1] + var_posadjust;
			if (var_pos2lookup >= 0 && var_pos2lookup <= 0x1D && var_poslookup >= 0 && var_poslookup <= 0x1D) {
				elem_map_value = td14_elem_map_main[var_pos2lookup + trackrows[var_poslookup]];
				terr_map_value = td15_terr_map_main[var_pos2lookup + terrainrows[var_poslookup]];
				
				if (elem_map_value != 0) {

					if (terr_map_value >= 7 && terr_map_value < 0xB) {
						elem_map_value = subst_hillroad_track(terr_map_value, elem_map_value);
						terr_map_value = 0;
					}
					
					if (elem_map_value == 0xFD) {
						// the item on the top left needs this space
						var_pos2lookup--;
						var_poslookup--;
						elem_map_value = td14_elem_map_main[var_pos2lookup + trackrows[var_poslookup]];
						terr_map_value = td15_terr_map_main[var_pos2lookup + terrainrows[var_poslookup]];
					} else if (elem_map_value == 0xFE) {
						// the item on the top needs this space
						var_poslookup--;
						elem_map_value = td14_elem_map_main[var_pos2lookup + trackrows[var_poslookup]];
						terr_map_value = td15_terr_map_main[var_pos2lookup + terrainrows[var_poslookup]];
					} else if (elem_map_value == 0xFF) {
						// the item on the left needs this space
						var_pos2lookup--;
						elem_map_value = td14_elem_map_main[var_pos2lookup + trackrows[var_poslookup]];
						terr_map_value = td15_terr_map_main[var_pos2lookup + terrainrows[var_poslookup]];
					}
				}

				var_1A[si] = terr_map_value;
				var_BC[si] = var_50[si * 3 + 2];
				
				if (elem_map_value != 0 && timertestflag2 != 0 && 
					trkObjectList[elem_map_value].ss_physicalModel >= 0x40 &&
					(var_pos2lookup != var_D8 || var_poslookup != var_E2))
				{
					elem_map_value = 0;
				}

				var_pos2tab[si] = var_pos2lookup;
				var_postab[si] = var_poslookup;
				var_14C[si] = elem_map_value;
				if (elem_map_value != 0) {

					var_multitileflag = trkObjectList[elem_map_value].ss_multiTileFlag;
					if (var_multitileflag != 0) {

						var_pos2lookupadjust = var_pos2lookup - var_pos2adjust;
						var_poslookupadjust = var_poslookup - var_posadjust;
						if (var_multitileflag == 1) {
							for (di = 0; di < si; di++) {
								if (var_50[di * 3] == var_pos2lookupadjust && (var_50[di * 3 + 1] == var_poslookupadjust || var_50[di * 3 + 1] == var_poslookupadjust + 1)) {
									var_32[di] = 1;
								}
							}
						} else if (var_multitileflag == 2) {
							for (di = 0; di < si; di++) {
								if (var_50[si * 3 + 1] == var_poslookupadjust && (var_50[si * 3] == var_pos2lookupadjust || var_50[si * 3] != var_pos2lookupadjust + 1)) {
									var_32[di] = 1;
								}
							}
						} else if (var_multitileflag == 3) {
							for (di = 0; di < si; di++) {
								if ((var_50[di * 3] == var_pos2lookupadjust || var_50[di * 3] == var_pos2lookupadjust + 1) && 
									(var_50[di * 3 + 1] == var_poslookupadjust || var_50[di * 3 + 1] == var_poslookupadjust + 1))
								{
									var_32[di] = 1;
								}
							}
						}
					}
				}
				
			} else {
				var_32[si] = 2;
			}
		} else {
			var_32[si] = 2;
		}
	}
	
//; -----------------------------------------------------------------------------
	
	var_3C = -1;
	var_6C = 0;
	if (cameramode != 0 || followOpponentFlag != 0) {

		if (state.playerstate.car_crashBmpFlag != 2) {

			var_matptr = mat_rot_zxy(-state.playerstate.car_rotate.z, -state.playerstate.car_rotate.y, -state.playerstate.car_rotate.x, 0);
			var_multitileflag = -1;
			di = -1;
			for (var_counter2 = 0; var_counter2 < 4; var_counter2++) {
				var_vec6 = simd_player.wheel_coords[var_counter2];
				mat_mul_vector(&var_vec6, var_matptr, &var_vec8); //; rotating car wheels, maybe?
				var_pos2lookup = (var_vec8.x + state.playerstate.car_posWorld1.lx) >> 16; // bits 16-24
				var_poslookup = -(((var_vec8.z + state.playerstate.car_posWorld1.lz) >> 16) - 0x1D);

				for (si = 0x16; si > var_multitileflag; si--) {
					if (var_32[si] != 2 && var_50[si * 3] + var_pos2adjust == var_pos2lookup && var_50[si * 3 + 1] + var_posadjust == var_poslookup) {
						var_3C = var_pos2lookup;
						var_60 = var_poslookup;
						var_multitileflag = si;
						di = var_counter2;
					}
				}
			}

			if (di != -1) {
				if (state.playerstate.car_surfaceWhl[0] != 4 || state.playerstate.car_surfaceWhl[1] != 4 || state.playerstate.car_surfaceWhl[2] != 4 || state.playerstate.car_surfaceWhl[3] != 4) {
					var_vec6.x = 0;
					var_vec6.z = 0;
					var_vec6.y = 0x7530;
					mat_mul_vector(&var_vec6, var_matptr, &var_vec8);
					mat_mul_vector(&var_vec8, &mat_temp, &var_vec6);
					if (var_vec6.z <= 0) {
						var_6C = -0x800 ;
					} else {
						var_6C = 0x800;
					}
				}
			}
		}
	}

	var_4A = -1;
	var_A4 = 0;
	if (gameconfig.game_opponenttype != 0) {

		if (cameramode != 0 || followOpponentFlag == 0) {
			if (state.opponentstate.car_crashBmpFlag != 2) {
				var_matptr = mat_rot_zxy(-state.opponentstate.car_rotate.z, -state.opponentstate.car_rotate.y, -state.opponentstate.car_rotate.x, 0);
				var_multitileflag = -1;
				di = -1;

				for (var_counter2 = 0; var_counter2 < 4; var_counter2++) {
					var_vec6 = simd_opponent.wheel_coords[var_counter2];
					mat_mul_vector(&var_vec6, var_matptr, &var_vec8); //; rotating car wheels, maybe?
					var_pos2lookup = (var_vec8.x + state.opponentstate.car_posWorld1.lx) >> 16; // bits 16-24
					var_poslookup = -(((var_vec8.z + state.opponentstate.car_posWorld1.lz) >> 16) - 0x1D);

					for (si = 0x16; si > var_multitileflag; si--) {
						if (var_32[si] != 2 && var_50[si * 3] + var_pos2adjust == var_pos2lookup && var_50[si * 3 + 1] + var_posadjust == var_poslookup) {
							var_4A = var_pos2lookup;
							var_6E = var_poslookup;
							var_multitileflag = si;
							di = var_counter2;
						}
					}
				}

				if (di != -1) {
						
					if (state.opponentstate.car_surfaceWhl[0] != 4 || state.opponentstate.car_surfaceWhl[1] != 4 || state.opponentstate.car_surfaceWhl[2] != 4 || state.opponentstate.car_surfaceWhl[3] != 4) {
						var_vec6.x = 0;
						var_vec6.y = 0;
						var_vec6.z = 0x7530;
						mat_mul_vector(&var_vec6, var_matptr, &var_vec8);
						mat_mul_vector(&var_vec8, &mat_temp, &var_vec6);
						if (var_vec6.z <= 0) {
							var_A4 = -0x800; //0xF800; // signed number!
						} else {
							var_A4 = 0x800;
						}
					}
				}
			}
		}
	}
//; -----------------------------------------------------------------------------


	var_4E = 0;
	si = 0;
	
	for (si = 0; si < 0x17; si++) {
		if (var_32[si] != 0) {
			continue;
		}
		var_pos2lookup = var_pos2tab[si];
		var_poslookup = var_postab[si];
		elem_map_value = var_14C[si];
		terr_map_value = var_1A[si];
		var_FC = var_BC[si];
		var_12A = 0;
		if (elem_map_value == 0) {
			var_counter = 1;
			var_10E = unk_3C0F4;
		} else {
			var_trkobject_ptr = &trkObjectList[elem_map_value];
			if (var_trkobject_ptr->ss_multiTileFlag == 0) {
				var_counter = 1;
				var_10E = unk_3C0EE;
			} else if (var_trkobject_ptr->ss_multiTileFlag == 1) {
				var_counter = 2;
				var_10E = unk_3C0F0;
			} else if (var_trkobject_ptr->ss_multiTileFlag == 2) {
				var_counter = 3;
				var_10E = unk_3C0F4;
			} else if (var_trkobject_ptr->ss_multiTileFlag == 3) {
				var_counter = 4;
				var_10E = unk_3C0F8;
			}
		}

		for (var_multitileflag = 0; var_multitileflag < var_counter; var_multitileflag++) {
			var_pos2lookupadjust = var_10E[var_multitileflag * 2] + var_pos2lookup;
			var_poslookupadjust = var_10E[var_multitileflag * 2 + 1] + var_poslookup;
			
			if (timertestflag2 == 0 || (var_pos2lookupadjust == var_D8 && var_poslookupadjust == var_E2)) {
				if (var_pos2lookupadjust == 0) {
					if (var_poslookupadjust == 0) {
						di = 7;
					} else if (var_poslookupadjust == 0x1D) {
						di = 5;
					} else {
						di = 6;
					}
				} else if (var_pos2lookupadjust == 0x1D) {
					if (var_poslookupadjust == 0) {
						di = 1;
					} else
					if (var_poslookupadjust == 0x1D) {
						di = 1;
					} else {
						di = 2;
					}
				} else {
					if (var_poslookupadjust == 0) {
						di = 0;
					} else if (var_poslookupadjust == 0x1D) {
						di = 4;
					} else {
						di = -1;
					}
				}

				if (di != -1) {
					var_trkobjectptr = &trkObjectList[fence_TrkObjCodes[di]];
					if (var_FC == 0) {
						currenttransshape[0].shapeptr = var_trkobjectptr->ss_shapePtr;
					} else {
						currenttransshape[0].shapeptr = var_trkobjectptr->ss_loShapePtr;
					}

					currenttransshape[0].pos.x = trackcenterpos2[var_pos2lookupadjust] - var_vec4.x;
					currenttransshape[0].pos.y = -var_vec4.y;
					currenttransshape[0].pos.z = trackcenterpos[var_poslookupadjust] - var_vec4.z;
					currenttransshape[0].rectptr = &rect_unk2;
					currenttransshape[0].ts_flags = var_122 | 5;
					currenttransshape[0].rotvec.x = 0;
					currenttransshape[0].rotvec.y = 0;
					currenttransshape[0].rotvec.z = word_3C0D6[di];
					currenttransshape[0].unk = 0x400;
					currenttransshape[0].material = 0;
					var_transformresult = transformed_shape_op(&currenttransshape[0]);
					if (var_transformresult > 0) {
						// break loop .. start end game
						break;
					}
				}
			}
		}

		// terrain type 0x06: a flat piece of land at an elevated level  
		if (terr_map_value != 6) {
			var_hillheight = 0;
			if (elem_map_value >= 0x69 && elem_map_value <= 0x6C) {
				for (var_multitileflag = 0; var_multitileflag < 4; var_multitileflag++) {
					if (var_multitileflag == 0) {
						var_pos2lookupadjust = var_pos2lookup;
						var_poslookupadjust = var_poslookup;
					} else if (var_multitileflag == 1) {
						var_pos2lookupadjust = var_pos2lookup + 1;
						var_poslookupadjust = var_poslookup;
					} else if (var_multitileflag == 2) {
						var_pos2lookupadjust = var_pos2lookup;
						var_poslookupadjust = var_poslookup + 1;
					} else if (var_multitileflag == 3) {
						var_pos2lookupadjust = var_pos2lookup + 1;
						var_poslookupadjust = var_poslookup + 1;
					}
					terr_map_value = td15_terr_map_main[var_pos2lookupadjust + terrainrows[var_poslookupadjust]];
					if (terr_map_value != 0) {
						var_trkobject_ptr = &sceneshapes2[terr_map_value];
						currenttransshape[0].shapeptr = var_trkobject_ptr->ss_shapePtr;
						currenttransshape[0].pos.x = trackcenterpos2[var_pos2lookupadjust] - var_vec4.x;
						currenttransshape[0].pos.y = -var_vec4.y;
						currenttransshape[0].pos.z = trackcenterpos[var_poslookupadjust] - var_vec4.z;
						currenttransshape[0].rectptr = &rect_unk2;
						currenttransshape[0].ts_flags = var_122 | 5;
						currenttransshape[0].rotvec.x = 0;
						currenttransshape[0].rotvec.y = 0;
						currenttransshape[0].rotvec.z = var_trkobject_ptr->ss_rotY;
						currenttransshape[0].unk = 0x400;
						currenttransshape[0].material = 0;
						var_transformresult = transformed_shape_op(&currenttransshape[0]);
						if (var_transformresult > 0)
							break;
					}
				}
				
				terr_map_value = 0;
			}
		} else {
			var_hillheight = hillHeightConsts[1];
			if (elem_map_value != 0) {
				terr_map_value = 0;
			}
		}

		if (terr_map_value != 0) {
			var_trkobject_ptr = &sceneshapes2[terr_map_value];
			currenttransshape[0].shapeptr = var_trkobject_ptr->ss_shapePtr;
			currenttransshape[0].pos.x = trackcenterpos2[var_pos2lookup] - var_vec4.x;
			currenttransshape[0].pos.y = var_hillheight - var_vec4.y;
			currenttransshape[0].pos.z = trackcenterpos[var_poslookup] - var_vec4.z;
			if (var_hillheight == 0) {
				currenttransshape[0].rectptr = &rect_unk2;
			} else {
				currenttransshape[0].rectptr = &rect_unk6;
			}

			currenttransshape[0].ts_flags = var_122 | 5;
			currenttransshape[0].rotvec.x = 0;
			currenttransshape[0].rotvec.y = 0;
			currenttransshape[0].rotvec.z = var_trkobject_ptr->ss_rotY;
			currenttransshape[0].unk = 0x400;
			currenttransshape[0].material = 0;
			var_transformresult = transformed_shape_op(&currenttransshape[0]);
			if (var_transformresult > 0)
				break;
		}

		transformedshape_counter = 0;
		curtransshape_ptr = currenttransshape;
		if (elem_map_value == 0) {
			var_pos2lookupadjust = var_pos2lookup;
			var_poslookupadjust = var_poslookup;
		} else {
			var_trkobject_ptr = &trkObjectList[elem_map_value];
			if ((var_trkobject_ptr->ss_multiTileFlag & 1) != 0) {
				var_5E = trackpos[var_poslookup];
				var_poslookupadjust = var_poslookup + 1;
			} else {
				var_5E = trackcenterpos[var_poslookup];
				var_poslookupadjust = var_poslookup;
			}

			if ((var_trkobject_ptr->ss_multiTileFlag & 2) != 0) {
				var_3A = trackpos2[1 + var_pos2lookup];
				var_pos2lookupadjust = var_pos2lookup + 1;
			} else {
				var_3A = trackcenterpos2[var_pos2lookup];
				var_pos2lookupadjust = var_pos2lookup;
			}

			var_vec8.x = var_3A - var_vec4.x;
			var_vec8.y = var_hillheight - var_vec4.y;
			var_vec8.z = var_5E - var_vec4.z;
			if (var_hillheight != 0) {
				if (var_trkobject_ptr->ss_multiTileFlag == 0) {
					di = 1;
					var_DA = unk_3C0A2;
				} else if (var_trkobject_ptr->ss_multiTileFlag == 1) {
					di = 2;
					var_DA = unk_3C0A6;
				} else if (var_trkobject_ptr->ss_multiTileFlag == 2) {
					di = 2;
					var_DA = unk_3C0AE;
				} else if (var_trkobject_ptr->ss_multiTileFlag == 3) {
					di = 4;
					var_DA = unk_3C0B6;
				}

				for (var_multitileflag = 0; var_multitileflag < di; var_multitileflag++) {
					currenttransshape[0].pos.x = *var_DA + var_vec8.x;
					var_DA++;
					currenttransshape[0].pos.y = var_vec8.y;
					currenttransshape[0].pos.z = *var_DA + var_vec8.z;
					var_DA++;
					currenttransshape[0].shapeptr = &game3dshapes[0x3B2 / sizeof(struct SHAPE3D)];
					currenttransshape[0].rectptr = &rect_unk6;
					currenttransshape[0].ts_flags = var_122 | 5;
					currenttransshape[0].rotvec.x = 0;
					currenttransshape[0].rotvec.y = 0;
					currenttransshape[0].rotvec.z = 0;
					currenttransshape[0].unk = 0x800;
					currenttransshape[0].material = 0;
					var_transformresult = transformed_shape_op(&currenttransshape[0]);
					if (var_transformresult > 0)
						break;
				}
			}

			if (var_trkobject_ptr->ss_ssOvelay != 0) {
				var_trkobjectptr = &trkObjectList[var_trkobject_ptr->ss_ssOvelay];
				if (var_FC != 0) {
					currenttransshape[1].shapeptr = var_trkobjectptr->ss_loShapePtr;
				} else {
					currenttransshape[1].shapeptr = var_trkobjectptr->ss_shapePtr;
				}

				if (currenttransshape[1].shapeptr != 0) {
					currenttransshape[1].pos = var_vec8;
					currenttransshape[1].rotvec.x = 0;
					currenttransshape[1].rotvec.y = 0;
					currenttransshape[1].rotvec.z = var_trkobjectptr->ss_rotY;
					if (var_trkobjectptr->ss_multiTileFlag != 0) {
						currenttransshape[1].unk = 0x400;
					} else {
						currenttransshape[1].unk = 0x800;
					}

					if (var_trkobjectptr->ss_surfaceType >= 0) {
						currenttransshape[1].material = var_trkobjectptr->ss_surfaceType;
					} else {
						currenttransshape[1].material = var_E4;
					}

					currenttransshape[1].ts_flags = var_trkobjectptr->ss_ignoreZBias | var_122 | 4;
					if ((currenttransshape[1].ts_flags & 1) != 0) {
						currenttransshape[1].rectptr = &rect_unk2;
						var_transformresult = transformed_shape_op(&currenttransshape[1]);
						if (var_transformresult > 0)
							break;
					} else {
						currenttransshape[1].rectptr = &rect_unk6;
						var_4E = 1;
					}
				}
			}

			if (var_FC != 0) {
				currenttransshape[0].shapeptr = var_trkobject_ptr->ss_loShapePtr;
			} else {
				currenttransshape[0].shapeptr = var_trkobject_ptr->ss_shapePtr;
			}

			currenttransshape[0].pos = var_vec8; // whatever
			currenttransshape[0].rotvec.x = 0;
			currenttransshape[0].rotvec.y = 0;
			currenttransshape[0].rotvec.z = var_trkobject_ptr->ss_rotY;
			if (var_trkobject_ptr->ss_multiTileFlag != 0) {
				currenttransshape[0].unk = 0x400;
			} else {
				currenttransshape[0].unk = 0x800;
			}

			currenttransshape[0].ts_flags = var_trkobject_ptr->ss_ignoreZBias | var_122 | 4;
			if (var_trkobject_ptr->ss_surfaceType >= 0) {
				currenttransshape[0].material = var_trkobject_ptr->ss_surfaceType;
			} else {
				currenttransshape[0].material = var_E4;
			}

			if ((var_trkobject_ptr->ss_ignoreZBias & 1) != 0) {
				currenttransshape[0].rectptr = &rect_unk2;
				var_transformresult = transformed_shape_op(&currenttransshape[0]);
				if (var_transformresult > 0)
					break;
			} else {
				currenttransshape[0].rectptr = &rect_unk6;
				transformed_shape_add_for_sort(0, 0);
				if (var_4E != 0) {
					var_4E = 0;
					transformed_shape_add_for_sort(-0x800 /*0xF800*/, 0);
					if (var_6C != 0) {
						var_6C = -0x400;//0xFC00;
					}

					if (var_A4 != 0) {
						var_A4 -= 0x400;
					}
				}

				if (var_pos2lookup == startcol2 && var_poslookup == startrow2) {
					var_12A = 0;
				} else {
					var_12A = -1;
				}
			}

			var_4C = trackdata19[var_pos2lookup + trackrows[var_poslookup]];
			if (var_4C != 0xFF) {
				if (state.field_3FA[var_4C] == 0) {
					var_trkobject_ptr = &trkObjectList[212 + trackdata23[var_4C]];
					curtransshape_ptr->pos.x = td10_track_check_rel[var_4C * 3 + 0] - var_vec4.x;
					curtransshape_ptr->pos.y = td10_track_check_rel[var_4C * 3 + 1] - var_vec4.y;
					curtransshape_ptr->pos.z = td10_track_check_rel[var_4C * 3 + 2] - var_vec4.z;
					curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_shapePtr;
					curtransshape_ptr->rectptr = &rect_unk6;
					curtransshape_ptr->ts_flags = var_122 | 4;
					curtransshape_ptr->rotvec.x = 0;
					curtransshape_ptr->rotvec.y = 0;
					curtransshape_ptr->rotvec.z = td08_direction_related[var_4C];
					curtransshape_ptr->unk = 0x64;
					curtransshape_ptr->material = 0;
					transformed_shape_add_for_sort(0, 0);
				} else if (state.field_42A != 0) {
					for (di = 0; di < 0x18; di++) {
						if (state.field_38E[di] != 0 && var_4C + 2 == state.field_443[di]) {
							var_trkobject_ptr = &sceneshapes3[state.field_42B[di]];
							curtransshape_ptr->pos.x = (state.game_longs1[di] >> 6) + td10_track_check_rel[var_4C * 3 + 0] - var_vec4.x;
							curtransshape_ptr->pos.y = (state.game_longs2[di] >> 6) + td10_track_check_rel[var_4C * 3 + 1] - var_vec4.y;
							curtransshape_ptr->pos.z = (state.game_longs3[di] >> 6) + td10_track_check_rel[var_4C * 3 + 2] - var_vec4.z;
							curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_shapePtr;
							curtransshape_ptr->rectptr = &rect_unk6;
							curtransshape_ptr->ts_flags = var_122 | 5;
							curtransshape_ptr->rotvec.x = -state.field_2FE[di];
							curtransshape_ptr->rotvec.y = -state.field_32E[di];
							curtransshape_ptr->rotvec.z = -state.field_35E[di];
							curtransshape_ptr->unk = 0x400;
							curtransshape_ptr->material = 0;
							transformed_shape_add_for_sort(0, 0);
						}
					}
				}
			}
		}

		if ((var_3C == var_pos2lookup || var_3C == var_pos2lookupadjust) && (var_60 == var_poslookup || var_60 == var_poslookupadjust)) {
			if (state.field_42A != 0) {
				for (di = 0; di < 0x18; di++) {
					if (state.field_38E[di] != 0 && state.field_443[di] == 0) {
						var_trkobject_ptr = &sceneshapes3[state.field_42B[di]];
						curtransshape_ptr->pos.x = (state.game_longs1[di] + state.playerstate.car_posWorld1.lx >> 6) - var_vec4.x;
						curtransshape_ptr->pos.y = (state.game_longs2[di] + state.playerstate.car_posWorld1.ly >> 6) - var_vec4.y;
						curtransshape_ptr->pos.z = (state.game_longs3[di] + state.playerstate.car_posWorld1.lz >> 6) - var_vec4.z;
						curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_shapePtr;
						curtransshape_ptr->rectptr = &rect_unk6;
						curtransshape_ptr->ts_flags = var_122 | 5;
						curtransshape_ptr->rotvec.x = -state.field_2FE[di];
						curtransshape_ptr->rotvec.y = -state.field_32E[di];
						curtransshape_ptr->rotvec.z = -state.field_35E[di];
						curtransshape_ptr->unk = 0x400;
						curtransshape_ptr->material = gameconfig.game_playermaterial;
						transformed_shape_add_for_sort(var_6C & var_12A, 0);
					}
				}
			}

			var_trkobject_ptr = &trkObjectList[2];//0x1C / sizeof(struct TRACKOBJECT)];
			curtransshape_ptr->pos.x = (state.playerstate.car_posWorld1.lx >> 6) - var_vec4.x;
			curtransshape_ptr->pos.y = (state.playerstate.car_posWorld1.ly >> 6) - var_vec4.y;
			curtransshape_ptr->pos.z = (state.playerstate.car_posWorld1.lz >> 6) - var_vec4.z;
			
			if (var_FC != 0 || timertestflag2 > 2) {
				curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_loShapePtr;
			} else {
				curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_shapePtr;
				sub_204AE(&game3dshapes[0x0AD4 / sizeof(struct SHAPE3D)].shape3d_verts[8], state.playerstate.car_steeringAngle, &state.playerstate.car_rc2, word_443E8, carshapevecs, &carshapevec);
			}

			if (timertestflag_copy != 0) {
				curtransshape_ptr->rectptr = &rect_unk12;
				curtransshape_ptr->ts_flags = 0xC;
			} else if (state.playerstate.car_crashBmpFlag != 1) {
				curtransshape_ptr->ts_flags = 4;
			} else {
				var_rect = cliprect_unk;
				curtransshape_ptr->rectptr = &var_rect;
				curtransshape_ptr->ts_flags = 0xC;
			}

			curtransshape_ptr->rotvec.x = -state.playerstate.car_rotate.z;
			curtransshape_ptr->rotvec.y = -state.playerstate.car_rotate.y;
			curtransshape_ptr->rotvec.z = -state.playerstate.car_rotate.x;
			curtransshape_ptr->unk = 0x12C;
			curtransshape_ptr->material = gameconfig.game_playermaterial;
			transformed_shape_add_for_sort(var_6C & var_12A, 2);
		}
		
		if ((var_4A == var_pos2lookup) || (var_4A == var_pos2lookupadjust)) {
			if ((var_6E == var_poslookup) || (var_6E == var_poslookupadjust)) {
				if (state.field_42A != 0) {
					for (di = 0; di < 0x18; di++) {
						if (state.field_38E[di] != 0) {
							if (state.field_443[di] == 1) {
								var_trkobject_ptr = &sceneshapes3[state.field_42B[di]];
								curtransshape_ptr->pos.x = (state.game_longs1[di] + state.opponentstate.car_posWorld1.lx >> 6) - var_vec4.x;
								curtransshape_ptr->pos.y = (state.game_longs2[di] + state.opponentstate.car_posWorld1.ly >> 6) - var_vec4.y;
								curtransshape_ptr->pos.z = (state.game_longs3[di] + state.opponentstate.car_posWorld1.lz >> 6) - var_vec4.z;
								curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_shapePtr;
								curtransshape_ptr->rectptr = &rect_unk6;
								curtransshape_ptr->ts_flags = var_122 | 5;
								curtransshape_ptr->rotvec.x = -state.field_2FE[di];
								curtransshape_ptr->rotvec.y = -state.field_32E[di];
								curtransshape_ptr->rotvec.z = -state.field_35E[di];
								curtransshape_ptr->unk = 0x400;
								curtransshape_ptr->material = gameconfig.game_opponentmaterial;
								transformed_shape_add_for_sort(var_A4 & var_12A, 0);
							}
						}
					}
				}
				var_trkobject_ptr = &trkObjectList[3];//0x2A / sizeof(struct TRACKOBJECT)];
				curtransshape_ptr->pos.x = (state.opponentstate.car_posWorld1.lx >> 6) - var_vec4.x;
				curtransshape_ptr->pos.y = (state.opponentstate.car_posWorld1.ly >> 6) - var_vec4.y;
				curtransshape_ptr->pos.z = (state.opponentstate.car_posWorld1.lz >> 6) - var_vec4.z;

				if (var_FC != 0 || timertestflag2 > 2) {
					curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_loShapePtr;
				} else {
					curtransshape_ptr->shapeptr = var_trkobject_ptr->ss_shapePtr;
					sub_204AE(&game3dshapes[0x0AEA / sizeof(struct SHAPE3D)].shape3d_verts[8], state.opponentstate.car_steeringAngle, &state.opponentstate.car_rc2, word_4448A, oppcarshapevecs, &oppcarshapevec);
				}

				if (timertestflag_copy != 0) {
					curtransshape_ptr->rectptr = &rect_unk15;
					curtransshape_ptr->ts_flags = 0xC;
				} else {
					if (state.opponentstate.car_crashBmpFlag != 1) {
						curtransshape_ptr->ts_flags = 4;
					} else {
						var_rect2 = cliprect_unk;
						curtransshape_ptr->rectptr = &var_rect2;
						curtransshape_ptr->ts_flags = 0xC;
					}
				}

				curtransshape_ptr->rotvec.x = -state.opponentstate.car_rotate.z;
				curtransshape_ptr->rotvec.y = -state.opponentstate.car_rotate.y;
				curtransshape_ptr->rotvec.z = -state.opponentstate.car_rotate.x;
				curtransshape_ptr->unk = 0x12C;
				curtransshape_ptr->material = gameconfig.game_opponentmaterial;
				transformed_shape_add_for_sort(var_4A & var_12A, 3);
			}
		}

		if (state.game_inputmode == 0) {
			if ((var_pos2lookup == startcol2 || var_pos2lookupadjust == startcol2) && (var_poslookup == startrow2 || var_poslookupadjust == startrow2)) {

				var_multitileflag = multiply_and_scale(cos_fast(word_44DCA), 0x24);
				var_counter = multiply_and_scale(sin_fast(word_44DCA), 0x24) + 0x38;

				var_108 = &game3dshapes[0x98A / sizeof(struct SHAPE3D)].shape3d_verts[8];
				var_108[0].x = var_multitileflag - 0x24;
				var_108[1].x = var_multitileflag - 0x24;
				var_108[2].x = 0x24 - var_multitileflag;
				var_108[3].x = 0x24 - var_multitileflag;

				var_108[0].z = var_counter;
				var_108[1].z = var_counter;
				var_108[2].z = var_counter;
				var_108[3].z = var_counter;
				 
				curtransshape_ptr->pos.x =
					multiply_and_scale(sin_fast(track_angle + 0x100), 0x24) +
					multiply_and_scale(sin_fast(track_angle + 0x200), 0x1B6) + 
					trackcenterpos2[startcol2] - var_vec4.x;
				curtransshape_ptr->pos.y = hillHeightConsts[hillFlag] - var_vec4.y;
				curtransshape_ptr->pos.z =
					multiply_and_scale(cos_fast(track_angle + 0x100), 0x24) +
					multiply_and_scale(cos_fast(track_angle + 0x200), 0x1B6) + 
					trackcenterpos[startrow2] - var_vec4.z;

				curtransshape_ptr->shapeptr = &game3dshapes[0x98A / sizeof(struct SHAPE3D)];
				curtransshape_ptr->rectptr = &rect_unk6;
				curtransshape_ptr->ts_flags = var_122 | 4;
				curtransshape_ptr->rotvec.x = 0;
				curtransshape_ptr->rotvec.y = 0;
				curtransshape_ptr->rotvec.z = track_angle;
				curtransshape_ptr->unk = 0x400;
				var_multitileflag = word_44DCA >> 6;
				if (var_multitileflag > 3) {
					var_multitileflag = 3;
				}

				curtransshape_ptr->material = var_multitileflag;	
				transformed_shape_add_for_sort(var_12A & -0x800 /*0xF800*/, 0);
			}
		}

		if (transformedshape_counter != 0) {
			if (transformedshape_counter > 1) {
				heapsort_by_order(transformedshape_counter, transformedshape_zarray, transformedshape_indices);
			}
			for (var_multitileflag = 0; var_multitileflag < transformedshape_counter; var_multitileflag++) {
				// di is used for index into currenttransshape elsewhere
				di = transformedshape_indices[var_multitileflag];
				if (transformedshape_arg2array[di] == 2) {
					if (state.playerstate.car_is_braking != 0) {
						backlights_paint_override = 0x2F;
					} else {
						backlights_paint_override = 0x2E;
					}
				} else if (transformedshape_arg2array[di] == 3) {
					if (state.opponentstate.car_is_braking == 0) {
						backlights_paint_override = 0x2E;
					} else {
						backlights_paint_override = 0x2F;
					}
				}

				var_transformresult = transformed_shape_op(&currenttransshape[di]); // DI??
				if (var_transformresult > 0)
					break;

				if (var_transformresult == 0) {
					if (transformedshape_arg2array[di] == 2) {
						if (state.playerstate.car_crashBmpFlag == 1) {
							var_DC[0] = 1;
						}
					} else if (transformedshape_arg2array[di] == 3) {
						if (state.opponentstate.car_crashBmpFlag == 1) {
							var_DC[1] = 1;
						}
					}
				}
			}
		}
	}

	var_132 = skybox_op(arg_0, arg_cliprectptr, var_2, &var_mat, var_angZ, var_angY, var_vec4.y);
	sprite_set_1_size(0, 0x140, arg_cliprectptr->top, arg_cliprectptr->bottom);
	get_a_poly_info();
	for (si = 0; si < 2; si++) {
		if (var_DC[si] == 0) {
			continue;
		}
		if (timertestflag_copy == 0) {
			if (si == 0) {
				var_rectptr = &var_rect;
			} else {
				var_rectptr = &var_rect2;
			}
		} else {
			if (si == 0) {
				var_rectptr = &rect_unk12;
			} else {
				var_rectptr = &rect_unk15;
			}
		}

		if (rect_intersect(var_rectptr, arg_cliprectptr) == 0) {
			sprite_set_1_size(var_rectptr->left, var_rectptr->right, var_rectptr->top, var_rectptr->bottom);
			var_vec6.x = (var_rectptr->right + var_rectptr->left) >> 1;
			var_vec6.y = (var_rectptr->top + var_rectptr->bottom) >> 1;
			var_multitileflag = var_rectptr->right - var_rectptr->left;
			var_counter = var_rectptr->bottom - var_rectptr->top;
			if (var_counter > var_multitileflag) {
				var_multitileflag = var_counter;
			}

			di = (state.game_frame >> 2) % 3 ;
			var_counter = ((long)var_multitileflag << 8) / (long)sdgame2_widths[di];
			shape_op_explosion(var_counter, sdgame2shapes[di], var_vec6.x, var_vec6.y);
		}
	}

/*
; --------------------------------------------------------
*/

	sprite_set_1_size(0, 0x140, arg_cliprectptr->top, arg_cliprectptr->bottom);
	if (cameramode == 0) {

		if (followOpponentFlag != 0) {
			var_stateptr = &state.opponentstate;
			si = state.game_oEndFrame;
		} else {
			var_stateptr = &state.playerstate;
			si = state.game_pEndFrame;
		}

		if (var_stateptr->car_crashBmpFlag == 1) {
			if (timertestflag_copy != 0) {
				rect_union(init_crak(state.game_frame - si, arg_cliprectptr->top, arg_cliprectptr->bottom - arg_cliprectptr->top), rect_unk, rect_unk);
			} else {
				init_crak(state.game_frame - si, arg_cliprectptr->top, arg_cliprectptr->bottom - arg_cliprectptr->top);
			}
		} else if (var_stateptr->car_crashBmpFlag == 2) {
			if (timertestflag_copy != 0) {
				rect_union(do_sinking(state.game_frame - si, arg_cliprectptr->top, arg_cliprectptr->bottom - arg_cliprectptr->top), rect_unk, rect_unk);
			} else {
				do_sinking(state.game_frame - si, arg_cliprectptr->top, arg_cliprectptr->bottom - arg_cliprectptr->top);
			}
		}
	}

	if (game_replay_mode == 0) {
		if (state.game_inputmode != 0) {
			format_frame_as_string(&resID_byte1, elapsed_time1 + elapsed_time2, 0);
			font_set_fontdef2(fontledresptr);
			if (timertestflag_copy != 0) {
				rect_union(intro_draw_text(&resID_byte1, 0x8C, roofbmpheight + 2, dialog_fnt_colour, 0), &rect_unk11, &rect_unk11);
			} else {
				intro_draw_text(&resID_byte1, 0x8C, roofbmpheight + 2, dialog_fnt_colour, 0);
			}

			font_set_fontdef();
		}
	}

	if (timertestflag_copy != 0) {
		rect_union(draw_ingame_text(), rect_unk, rect_unk);
		if (var_132 != 0) {
			rect_unk[0] = *arg_cliprectptr;
			for (si = 1; si < 15; si++) {
				rect_unk[si] = cliprect_unk;
			}
		}

		for (si = 0; si < 15; si++) {
			rectptr_unk[si] = rect_unk[si];
		}
		word_449FC[arg_0] = var_angY;
		word_463D6 = var_angY;

	} else {
		draw_ingame_text();
	}

}
