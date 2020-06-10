; this file contains external references to functions implemented in c which 
; replace an original asm implementation. the contents in this file has to be
; kept in sync with the names of ported functions in PortFuncName in anders.idc

; forward for crt hack in seg010.asm

endseg segment byte private 'ENDSEG' use16
endseg ends

; externs for implementations in math.c

extrn sin_fast:proc
extrn cos_fast:proc
extrn polarAngle:proc
extrn polarRadius3D:proc
extrn polarRadius2D:proc
extrn rect_compare_point:proc
extrn rect_adjust_from_point:proc
extrn rect_union:proc
extrn rect_intersect:proc
extrn rectlist_add_rect:proc
extrn rectlist_add_rects:proc
extrn rect_is_overlapping:proc
extrn rect_is_inside:proc
extrn rect_is_adjacent:proc
extrn rect_array_sort_by_top:proc
extrn mat_mul_vector:proc
extrn mat_mul_vector2:proc
extrn mat_multiply:proc
extrn mat_invert:proc
extrn mat_rot_x:proc
extrn mat_rot_y:proc
extrn mat_rot_z:proc
extrn mat_rot_zxy:proc
extrn vector_op_unk:proc
extrn vector_op_unk2:proc
extrn vector_to_point:proc
extrn multiply_and_scale:proc
extrn plane_origin_op:proc
extrn vec_normalInnerProduct:proc
extrn plane_rotate_op:proc


; externs for implementations in heapsort.c

extrn heapsort_by_order:proc


; externs for implementations in fileio.c

extrn file_find:proc
extrn file_find_next:proc
extrn file_find_next_alt:proc
extrn file_paras:proc
extrn file_paras_fatal:proc
extrn file_paras_nofatal:proc
extrn file_decomp_paras:proc
extrn file_decomp_paras_fatal:proc
extrn file_decomp_paras_nofatal:proc
extrn file_read:proc
extrn file_read_fatal:proc
extrn file_read_nofatal:proc
extrn file_write_fatal:proc
extrn file_write_nofatal:proc
extrn file_decomp:proc
extrn file_decomp_fatal:proc
extrn file_decomp_nofatal:proc
extrn file_decomp_rle:proc
extrn file_decomp_rle_seq:proc
extrn file_decomp_rle_single:proc
extrn file_decomp_vle:proc
extrn file_load_binary:proc
extrn file_load_binary_fatal:proc
extrn file_load_binary_nofatal:proc
extrn file_load_resource:proc
extrn file_load_resfile:proc
extrn unload_resource:proc
extrn file_load_3dres:proc
extrn file_load_audiores:proc
extrn file_build_path:proc
extrn file_combine_and_find:proc
extrn file_load_replay:proc
extrn file_write_replay:proc


; externs for implementations in memmgr.c

extrn mmgr_path_to_name:proc
extrn mmgr_alloc_pages:proc
extrn mmgr_alloc_resmem:proc
extrn mmgr_alloc_a000:proc
extrn mmgr_get_ofs_diff:proc
extrn mmgr_free:proc
extrn mmgr_copy_paras:proc
extrn copy_paras_reverse:proc

extrn mmgr_get_chunk_by_name:proc

extrn mmgr_find_free:proc
extrn mmgr_release:proc
extrn mmgr_get_chunk_size:proc
extrn mmgr_resize_memory:proc
extrn mmgr_op_unk:proc
extrn mmgr_alloc_resbytes:proc
extrn mmgr_get_res_ofs_diff_scaled:proc
extrn mmgr_get_chunk_size_bytes:proc

extrn locate_shape_fatal:proc
extrn locate_shape_nofatal:proc
extrn locate_shape_alt:proc
extrn locate_sound_fatal:proc
extrn locate_many_resources:proc
extrn locate_text_res:proc


; externs for implementations in shape3d.c

extrn shape3d_load_all:proc
extrn shape3d_free_all:proc
extrn shape3d_init_shape:proc
extrn transformed_shape_op:proc
extrn transformed_shape_op_helper2:proc
extrn transformed_shape_op_helper3:proc
;extrn get_a_poly_info:proc
extrn preRender_default:proc
extrn preRender_default_alt:proc
extrn skybox_op_helper:proc
extrn preRender_wheel_helper4:proc
extrn preRender_patterned:proc
extrn preRender_unk:proc
extrn set_projection:proc
extrn select_cliprect_rotate:proc
extrn polyinfo_reset:proc
extrn init_polyinfo:proc
extrn calc_sincos80:proc
extrn draw_line_related:proc
extrn draw_line_related_alt:proc
extrn shape3d_load_car_shapes:proc
extrn shape3d_free_car_shapes:proc
extrn sub_204AE:proc

; externs for implementations in shape2d.c

extrn sprite_make_wnd:proc
extrn sprite_free_wnd:proc
extrn sprite_set_1_from_argptr:proc
extrn sprite_copy_2_to_1:proc
extrn sprite_copy_2_to_1_2:proc
extrn sprite_copy_2_to_1_clear:proc
extrn sprite_copy_wnd_to_1:proc
extrn sprite_copy_wnd_to_1_clear:proc
extrn sprite_copy_both_to_arg:proc
extrn sprite_copy_arg_to_both:proc
extrn sprite_clear_1_color:proc
;extrn sprite_putimage:proc
;extrn sprite_putimage_and:proc
;extrn sprite_putimage_or:proc
extrn setup_mcgawnd1:proc
extrn setup_mcgawnd2:proc
extrn file_load_shape2d:proc
extrn file_load_shape2d_fatal:proc
extrn file_load_shape2d_nofatal:proc
extrn file_load_shape2d_nofatal2:proc
extrn file_load_shape2d_res:proc
extrn file_load_shape2d_res_fatal:proc
extrn file_load_shape2d_res_nofatal:proc
extrn file_load_shape2d_palmap_init:proc
extrn file_load_shape2d_palmap_apply:proc
extrn file_load_shape2d_expandedsize:proc
extrn file_load_shape2d_expand:proc
extrn file_unflip_shape2d:proc
extrn file_unflip_shape2d_pes:proc
extrn file_get_unflip_size:proc
extrn file_load_shape2d_expandedsize:proc
extrn file_get_shape2d:proc
extrn file_get_res_shape_count:proc

; externs for implementations in keyboard.c

extrn kb_init_interrupt:proc
extrn kb_exit_handler:proc
extrn kb_int9_handler:proc
extrn kb_int16_handler:proc
extrn kb_get_key_state:proc
extrn kb_call_readchar_callback:proc
extrn kb_read_char:proc
extrn kb_checking:proc
extrn flush_stdin:proc
extrn kb_check:proc

; externs for implementations in frame.c
extrn update_frame:proc

; externs for implementations in state.c
extrn player_op:proc
extrn update_player_state:proc
extrn update_crash_state:proc
extrn update_car_speed:proc
extrn update_rpm_from_speed:proc

; externs for implementations in restunts.c

extrn timer_get_counter:proc
extrn timer_get_delta:proc
extrn timer_get_delta_alt:proc
extrn timer_custom_delta:proc
extrn timer_reset:proc
extrn timer_copy_counter:proc
extrn timer_wait_for_dx:proc
extrn timer_compare_dx:proc
extrn timer_get_counter_unk:proc

extrn init_kevinrandom:proc
extrn get_kevinrandom_seed:proc
extrn get_kevinrandom:proc
extrn get_super_random:proc
extrn get_0:proc
extrn video_get_status:proc
extrn random_wait:proc
extrn toupper:proc

extrn init_carstate_from_simd:proc
extrn init_unknown:proc
extrn init_game_state:proc
extrn restore_gamestate:proc
extrn update_gamestate:proc
extrn setup_aero_trackdata:proc

extrn run_game:proc
extrn init_div0:proc
extrn copy_material_list_pointers:proc
extrn set_default_car:proc
extrn init_main:proc
extrn stuntsmain:proc

;extrn fatal_error:proc
