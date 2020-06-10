BYTEREGS struc
_al db ?
_ah db ?
_bl db ?
_bh db ?
_cl db ?
_ch db ?
_dl db ?
_dh db ?
BYTEREGS ends
WORDREGS struc
_ax dw ?
_bx dw ?
_cx dw ?
_dx dw ?
_si dw ?
_di dw ?
cflag dw ?
WORDREGS ends
REGS union
  x WORDREGS <>
  h BYTEREGS <>
REGS ends
FILE struc
_ptr dd ?
_cnt dw ?
_base dd ?
_flag db ?
_file db ?
FILE ends
MATRIX struc
_11 dw ?
_21 dw ?
_31 dw ?
_12 dw ?
_22 dw ?
_32 dw ?
_13 dw ?
_23 dw ?
_33 dw ?
MATRIX ends
VECTOR struc
vx dw ?
vy dw ?
vz dw ?
VECTOR ends
MEMCHUNK struc
resname db 12 dup (?)
ressize dw ?
resofs dw ?
resunk dw ?
MEMCHUNK ends
VECTORLONG struc
lx dd ?
ly dd ?
lz dd ?
VECTORLONG ends
PLANE struc
plane_yz dw ?
plane_xy dw ?
plane_origin VECTOR <>
plane_normal VECTOR <>
plane_rotation MATRIX <>
PLANE ends
POINT2D struc
x2 dw ?
y2 dw ?
POINT2D ends
SIMD struc
num_gears db ?
simd_unk db ?
car_mass dw ?
braking_eff dw ?
idle_rpm dw ?
downshift_rpm dw ?
upshift_rpm dw ?
max_rpm dw ?
gear_ratios dw 7 dup (?)
knob_points POINT2D 7 dup (<>)
aero_resistance dw ?
idle_torque db ?
torque_curve db 104 dup (?)
field_A3 db ?
grip dw ?
field_A6 dw 7 dup (?)
sliding dw ?
surface_grip dw 4 dup (?)
simd_unk3 db 10 dup (?)
collide_points POINT2D 2 dup (<>)
car_height dw ?
wheel_coords VECTOR 4 dup (<>)
steeringdots db 62 dup (?)
spdcenter POINT2D <>
spdnumpoints dw ?
spdpoints db 208 dup (?)
revcenter POINT2D <>
revnumpoints dw ?
revpoints db 256 dup (?)
aerorestable dd ?
SIMD ends
SHAPE3DHEADER struc
header_numverts db ?
header_numprimitives db ?
header_numpaints db ?
header_reserved db ?
SHAPE3DHEADER ends
CARSTATE struc
car_posWorld1 VECTORLONG <>
car_posWorld2 VECTORLONG <>
car_rotate VECTOR <>
car_pseudoGravity dw ?
car_steeringAngle dw ?
car_currpm dw ?
car_lastrpm dw ?
car_idlerpm2 dw ?
car_speeddiff dw ?
car_speed dw ?
car_speed2 dw ?
car_lastspeed dw ?
car_gearratio dw ?
car_gearratioshr8 dw ?
car_knob_x dw ?
car_36MwhlAngle dw ?
car_knob_y dw ?
car_knob_x2 dw ?
car_knob_y2 dw ?
car_angle_z dw ?
car_40MfrontWhlAngle dw ?
field_42 dw ?
car_demandedGrip dw ?
car_surfacegrip_sum dw ?
field_48 dw ?
car_trackdata3_index dw ?
car_rc1 dw 4 dup (?)
car_rc2 dw 4 dup (?)
car_rc3 dw 4 dup (?)
car_rc4 dw 4 dup (?)
car_rc5 dw 4 dup (?)
car_whlWorldCrds1 VECTOR 4 dup (<>)
car_whlWorldCrds2 VECTOR 4 dup (<>)
car_vec_unk3 VECTOR <>
car_vec_unk4 VECTOR <>
car_vec_unk5 VECTOR <>
field_B6 dw ?
field_B8 dw ?
field_BA dw ?
car_is_braking db ?
car_is_accelerating db ?
car_current_gear db ?
car_sumSurfFrontWheels db ?
car_sumSurfRearWheels db ?
car_sumSurfAllWheels db ?
car_surfaceWhl db 4 dup (?)
car_engineLimiterTimer db ?
car_slidingFlag db ?
field_C8 db ?
car_crashBmpFlag db ?
car_changing_gear db ?
car_fpsmul2 db ?
car_transmission db ?
field_CD db ?
field_CE db ?
field_CF db ?
CARSTATE ends
SHAPE3D struc
shape3d_numverts dw ?
shape3d_verts dd ?
shape3d_numprimitives dw ?
shape3d_numpaints dw ?
shape3d_primitives dd ?
shape3d_cull1 dd ?
shape3d_cull2 dd ?
SHAPE3D ends
PRIMITIVE struc
primitive_type db ?
primitive_flags db ?
PRIMITIVE ends
TRACKOBJECT struc
ss_trkObjInfoPtr dw ?
ss_rotY dw ?
ss_shapePtr dw ?
ss_loShapePtr dw ?
ss_ssOvelay db ?
ss_surfaceType db ?
ss_ignoreZBias db ?
ss_multiTileFlag db ?
ss_physicalModel db ?
scene_unk5 db ?
TRACKOBJECT ends
TRANSFORMEDSHAPE struc
ts_pos VECTOR <>
ts_shapeptr dw ?
ts_rectptr dw ?
ts_rotvec VECTOR <>
ts_unk dw ?
ts_flags db ?
ts_material db ?
TRANSFORMEDSHAPE ends
TRKOBJINFO struc
si_noOfBlocks db ?
si_entryPoint db ?
si_exitPoint db ?
si_entryType db ?
si_exitType db ?
si_arrowType db ?
si_arrowOrient dw ?
si_cameraDataOffset dw ?
si_opp1 db ?
si_opp2 db ?
si_opp3 db ?
si_oppSpedCode db ?
TRKOBJINFO ends
SHAPE2D struc
s2d_width dw ?
s2d_height dw ?
s2d_unk1 dw ?
s2d_unk2 dw ?
s2d_pos_x dw ?
s2d_pos_y dw ?
s2d_unk3 db ?
s2d_unk4 db ?
s2d_unk5 db ?
s2d_unk6 db ?
SHAPE2D ends
GAMESTATE struc
game_longs1 dd 24 dup (?)
game_longs2 dd 24 dup (?)
game_longs3 dd 24 dup (?)
game_vec1 VECTOR <>
game_vec2 VECTOR <>
game_vec3 VECTOR <>
game_vec4 VECTOR <>
game_frame_in_sec dw ?
game_frames_per_sec dw ?
game_travDist dd ?
game_frame dw ?
game_total_finish dw ?
field_144 dw ?
game_pEndFrame dw ?
game_oEndFrame dw ?
game_penalty dw ?
game_impactSpeed dw ?
game_topSpeed dw ?
game_jumpCount dw ?
playerstate CARSTATE <>
opponentstate CARSTATE <>
field_2F2 dw ?
field_2F4 dw ?
game_startcol dw ?
game_startcol2 dw ?
game_startrow dw ?
game_startrow2 dw ?
field_2FE dw 24 dup (?)
field_32E dw 24 dup (?)
field_35E dw 24 dup (?)
field_38E db 48 dup (?)
field_3BE db 48 dup (?)
kevinseed db 6 dup (?)
field_3F4 db ?
game_inputmode db ?
game_3F6autoLoadEvalFlag db ?
field_3F7 db 2 dup (?)
field_3F9 db ?
field_3FA db 48 dup (?)
field_42A db ?
field_42B db 24 dup (?)
field_443 db 24 dup (?)
field_45B db ?
field_45C db ?
field_45D db ?
field_45E db ?
field_45F db ?
GAMESTATE ends
GAMEINFO struc
game_playercarid db 4 dup (?)
game_playermaterial db ?
game_playertransmission db ?
game_opponenttype db ?
game_opponentcarid db 4 dup (?)
game_opponentmaterial db ?
game_opponenttransmission db ?
game_trackname db 9 dup (?)
game_framespersec dw ?
game_recordedframes dw ?
GAMEINFO ends
SPRITE struc
sprite_bitmapptr dd ?
sprite_unk1 dw ?
sprite_unk2 dw ?
sprite_unk3 dw ?
sprite_lineofs dw ?
sprite_left dw ?
sprite_right dw ?
sprite_top dw ?
sprite_height dw ?
sprite_pitch dw ?
sprite_unk4 dw ?
sprite_width2 dw ?
sprite_left2 dw ?
sprite_widthsum dw ?
SPRITE ends
RECTANGLE struc
rc_left dw ?
rc_right dw ?
rc_top dw ?
rc_bottom dw ?
RECTANGLE ends
; enum enum_surface_type (-16772249)
tarmac = 1
dirt = 2
ice = 3
grass = 4
water = 5
; enum enum_track_errors (-16772170)
ok = 0
no_sf = 1
int_err = 2
many_sf = 3
elem_mism = 4
wrong_way = 5
many_elem = 6
no_path = 7
many_path = 8
no_runway = 9
long_jump = 10
terr_mism = 11
elem_wat = 12
elem_stsl = 13
elem_ansl = 14
