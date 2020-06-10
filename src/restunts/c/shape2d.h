#ifndef RESTUNTS_SHAPE2D_H
#define RESTUNTS_SHAPE2D_H

#pragma pack (push, 1)
struct SHAPE2D {
	unsigned short s2d_width;
	unsigned short s2d_height;
	unsigned short s2d_unk1;
	unsigned short s2d_unk2;
	unsigned short s2d_pos_x;
	unsigned short s2d_pos_y;
	unsigned char s2d_unk3;
	unsigned char s2d_unk4;
	unsigned char s2d_unk5;
	unsigned char s2d_unk6;
};

struct SPRITE {
	struct SHAPE2D far* sprite_bitmapptr;
	unsigned short sprite_unk1;
	unsigned short sprite_unk2;
	unsigned short sprite_unk3;
	unsigned int* sprite_lineofs;
	unsigned short sprite_left;
	unsigned short sprite_right;
	unsigned short sprite_top;
	unsigned short sprite_height;
	unsigned short sprite_pitch;
	unsigned short sprite_unk4;
	unsigned short sprite_width2;
	unsigned short sprite_left2;
	unsigned short sprite_widthsum;
};
#pragma pack (pop)

struct SPRITE far* sprite_make_wnd(unsigned int width, unsigned int height, unsigned int);
void sprite_free_wnd(struct SPRITE far* wndsprite);

void sprite_set_1_from_argptr(struct SPRITE far* argsprite);

void sprite_copy_2_to_1(void);
void sprite_copy_2_to_1_2(void);
void sprite_copy_2_to_1_clear(void);
void sprite_copy_wnd_to_1(void);
void sprite_copy_wnd_to_1_clear(void);

void sprite_copy_both_to_arg(struct SPRITE* argsprite);
void sprite_copy_arg_to_both(struct SPRITE* argsprite);

void sprite_clear_1_color(unsigned char color);

void sprite_putimage(struct SHAPE2D far* shape);
void sprite_putimage_and(struct SHAPE2D far* shape, unsigned short a, unsigned short b);
void sprite_putimage_or(struct SHAPE2D far* shape, unsigned short a, unsigned short b);

void setup_mcgawnd1(void);
void setup_mcgawnd2(void);

struct SHAPE2D far* file_get_shape2d(unsigned char far* memchunk, int index);

unsigned short file_get_res_shape_count(void far* memchunk);

void file_unflip_shape2d(unsigned char far* memchunk, char far* mempages);

void file_unflip_shape2d_pes(unsigned char far* memchunk, char far* mempages);

void file_load_shape2d_expand(unsigned char far* memchunk, char far* mempages);

unsigned short file_get_unflip_size(char far* memchunk);

unsigned short file_load_shape2d_expandedsize(void far* memchunk);

void file_load_shape2d_palmap_init(unsigned char far* pal);
void file_load_shape2d_palmap_apply(unsigned char far* memchunk, unsigned char palmap[]);

void far* file_load_shape2d_esh(void far* memchunk, const char* str);
void far* file_load_shape2d(char* shapename, int fatal);

void far* file_load_shape2d_fatal(char* shapename);
void far* file_load_shape2d_nofatal(char* shapename);
void far* file_load_shape2d_nofatal2(char* shapename);

void far* file_load_shape2d_res(char* resname, int fatal);
void far* file_load_shape2d_res_fatal(char* resname);
void far* file_load_shape2d_res_nofatal(char* resname);

#endif
