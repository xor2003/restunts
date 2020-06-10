#ifdef RESTUNTS_DOS
#include <dos.h>
#include <mem.h>
#elif RESTUNTS_SDL

#endif
#include <stddef.h>
#include <stdlib.h>

#include "externs.h"
#include "memmgr.h"
#include "fileio.h"
#include "shape2d.h"

extern char aWindowdefOutOfRowTableSpa[];
extern char aMcgaWindow[];
extern char aWindowReleased[];
extern struct SPRITE far* wndsprite;

extern unsigned char* far wnd_defs; // a reserved memory chunk of 0xE10 bytes in seg012. contents are SPRITE structs followed by lineoffsets. cast to a far pointer for access to the contents in other segments.
extern char* far next_wnd_def; // near pointer relative to seg012 to the current SPRITE in wnd_defs. cast to a far pointer for access to the contents in other segments
extern struct SPRITE far sprite1; // seg012
extern struct SPRITE far sprite2; // seg012
extern struct SPRITE far* mcgawndsprite;

struct SPRITE far* sprite_make_wnd(unsigned int width, unsigned int height, unsigned int unk) {
	int pages, i;
	char* wnd;
	char* nextwnd;
	struct SPRITE far * farwnd;
	char far* shapebuf;
	struct SHAPE2D far* hdr;
	unsigned int lineofs;
	unsigned int* lineofsptr;
	unsigned int far* farlineofsptr;
	unsigned short wnddefseg;
	
	(void)unk;

	wnddefseg = FP_SEG(&wnd_defs);

	pages = ((width * height + sizeof(struct SHAPE2D)) >> 4) + 1;
	shapebuf = mmgr_alloc_pages("MCGA WINDOW", pages);
	
	hdr = (struct SHAPE2D far*)MK_FP(FP_SEG(shapebuf), 0);
	hdr->s2d_width = width;
	hdr->s2d_height = height;
	hdr->s2d_pos_x = 0;
	hdr->s2d_pos_y = 0;
	hdr->s2d_unk1 = 0;
	hdr->s2d_unk2 = 0;

	// it is safe to read/write the pointers to next_wnd_def/wnd_defs, but not the contents
	wnd = next_wnd_def;
	nextwnd = next_wnd_def + sizeof(struct SPRITE) + height * sizeof(unsigned int);
	if (FP_OFF(nextwnd) >= FP_OFF(&wnd_defs) + 0xE10) {
		fatal_error(aWindowdefOutOfRowTableSpa);
	}
	next_wnd_def = nextwnd;

	// get a writable far pointer to the wndsprite
	farwnd = MK_FP(wnddefseg, FP_OFF(wnd));

	lineofsptr = (unsigned int*)(wnd + sizeof(struct SPRITE));
	farwnd->sprite_bitmapptr = hdr;
	farwnd->sprite_lineofs = lineofsptr;
	farwnd->sprite_left = 0;
	farwnd->sprite_left2 = 0;
	farwnd->sprite_right = width;
	farwnd->sprite_pitch = width;	// ??
	farwnd->sprite_top = 0;
	farwnd->sprite_height = height;
	farwnd->sprite_width2 = width;
	farwnd->sprite_widthsum = width;
	
	// create a writable far pointer to the line offsets
	farlineofsptr = MK_FP(wnddefseg, FP_OFF(lineofsptr));
	lineofs = sizeof(struct SHAPE2D);
	for (i = 0; i < height; i++) {
		*farlineofsptr = lineofs;
		farlineofsptr++;
		lineofs += width;
	}

	return farwnd;
}

void sprite_free_wnd(struct SPRITE far* wndsprite) {
	unsigned short spritesize;
	spritesize = sizeof(struct SPRITE) + wndsprite->sprite_height * sizeof(unsigned short);
	if (FP_OFF(wndsprite) + spritesize != FP_OFF(next_wnd_def)) {
		fatal_error(aWindowReleased);
	}
	next_wnd_def = next_wnd_def - spritesize;
	mmgr_release((void far*)wndsprite->sprite_bitmapptr);
}

void sprite_set_1_from_argptr(struct SPRITE far* argsprite) {
	fmemcpy(&sprite1, argsprite, sizeof(struct SPRITE));
}

void sprite_copy_2_to_1(void) {
	sprite_set_1_from_argptr(&sprite2);
}

void sprite_copy_2_to_1_2(void) {
	sprite_set_1_from_argptr(&sprite2);
}

void sprite_copy_2_to_1_clear(void) {
	sprite_set_1_from_argptr(&sprite2);
	sprite_clear_1_color(0);
}

void sprite_copy_wnd_to_1(void) {
	sprite_set_1_from_argptr(wndsprite);
}

void sprite_copy_wnd_to_1_clear(void) {
	sprite_set_1_from_argptr(wndsprite);
	sprite_clear_1_color(0);
}

void sprite_copy_both_to_arg(struct SPRITE* argsprite) {
	fmemcpy(argsprite, &sprite1, sizeof(struct SPRITE) * 2);
}

void sprite_copy_arg_to_both(struct SPRITE* argsprite) {
	fmemcpy(&sprite1, argsprite, sizeof(struct SPRITE) * 2);
}

void sprite_clear_1_color(unsigned char color) {
	
	int height, top, left, right, pitch, lines, width, widthdiff, i, j;
	unsigned int ofs;
	unsigned char far* bitmapptr;
	unsigned int far* lineofs;

	top = sprite1.sprite_top;
	left = sprite1.sprite_left;
	right = sprite1.sprite_right;
	pitch = sprite1.sprite_pitch;
	bitmapptr = (unsigned char far*)sprite1.sprite_bitmapptr;
	lineofs = MK_FP(FP_SEG(&sprite1), FP_OFF(sprite1.sprite_lineofs));

	lines = sprite1.sprite_height - top;
	if (lines <= 0) return;

	ofs = lineofs[top] + left;

	width = right - left;
	if (width <= 0) return ;
	
	widthdiff = pitch - width;

	for (i = 0; i < lines; i++) {
		for (j = 0; j < width; j++) {
			bitmapptr[ofs ++] = color;
		}
		ofs += widthdiff;
	}
}

#if 0
void sprite_putimage(struct SHAPE2D far* shape) {

	int lines, widthdiff, i, j;
	unsigned int ofs;
	unsigned char far* destbitmapptr;
	unsigned int far* destlineofs;
	unsigned char far* srcbitmapptr;
	ported_sprite_putimage_(shape);
	return ;
/*
	this fails in the opponent car selector on the overlaid opponent bitmap:

	destbitmapptr = (unsigned char far*)sprite1.sprite_bitmapptr;
	destlineofs = MK_FP(FP_SEG(&sprite1), FP_OFF(sprite1.sprite_lineofs));
	srcbitmapptr = ((unsigned char far*)shape) + sizeof(struct SHAPE2D);

	if (shape->s2d_pos_y + shape->s2d_height > sprite1.sprite_height) {
		lines = sprite1.sprite_height - shape->s2d_pos_y;
	} else {
		lines = shape->s2d_height;
	}

	ofs = destlineofs[shape->s2d_pos_y] + shape->s2d_pos_x;
	widthdiff = sprite1.sprite_pitch - shape->s2d_width;

	for (i = 0; i < lines; i++) {
		for (j = 0; j < shape->s2d_width; j++) {
			destbitmapptr[ofs ++] = *srcbitmapptr++;
		}
		ofs += widthdiff;
	}
	*/
}

void sprite_putimage_and(struct SHAPE2D far* shape, unsigned short a, unsigned short b) {
	ported_sprite_putimage_and_(shape, a, b);
}

void sprite_putimage_or(struct SHAPE2D far* shape, unsigned short a, unsigned short b) {
	ported_sprite_putimage_or_(shape, a, b);
}
#endif

void setup_mcgawnd1(void) {
	if (!mcgawndsprite) {
		mcgawndsprite = sprite_make_wnd(320, 200, 0x0F);
	}

	sprite_set_1_from_argptr(&sprite2);
	sprite_putimage(mcgawndsprite->sprite_bitmapptr);
}

void setup_mcgawnd2(void) {
	if (!mcgawndsprite) {
		mcgawndsprite = sprite_make_wnd(320, 200, 0x0F);
	}
	
	sprite_set_1_from_argptr(mcgawndsprite);
}

// like locate_resource_by_index()
struct SHAPE2D far* file_get_shape2d(unsigned char far* memchunk, int index) {
	unsigned short shapecount, offsetofs, dataofs;
	unsigned long chunkofs;
	unsigned char huge* result;
	
	shapecount = *(unsigned short far*)&memchunk[4];
	offsetofs = (index << 2) + (shapecount << 2) + 6;
	dataofs = (shapecount << 3) + 6;
	chunkofs = *(unsigned long far*)(&memchunk[offsetofs]);
	result = memchunk;
	result += dataofs + chunkofs;
	return (struct SHAPE2D far*)result;
}

unsigned short file_get_res_shape_count(void far* memchunk) {
	return ((unsigned short far*)memchunk)[2];
}

void file_unflip_shape2d(unsigned char far* memchunk, char far* mempages) {

	int shapecount, counter, width, height;
	struct SHAPE2D far* memshape;
	char far* membitmapptr;
	unsigned char flag;
	int i, j;

	shapecount = *(unsigned short far*)&memchunk[4];
	counter = 0;
	do {
		memshape = file_get_shape2d(memchunk, counter);
		membitmapptr = ((char far*)memshape) + sizeof(struct SHAPE2D);
		flag = memshape->s2d_unk6;
		if ((flag & 0xF0) == 0) {
			flag = memshape->s2d_unk5 >> 4;
			if (flag != 0) {
				if (flag < 4) {
					width = memshape->s2d_width;
					height = memshape->s2d_height;
					switch (flag - 1) {
						case 0:
							// regular flip
							for (j = 0; j < height; j++) { // height
								for (i = 0; i < width; i++) { // width
									mempages[i + j * width] = membitmapptr[j + i * height];
								}
							}
							break;
						case 1:
							// interlaced flip?
							for (j = 0; j < height; j += 2) { // height
								for (i = 0; i < width; i++) { // width
									mempages[i + j * width] = membitmapptr[(j / 2) + i * height];
								}
							}
							for (j = 0; j < height; j += 2) { // height
								for (i = 0; i < width; i++) { // width
									mempages[width + i + j * width] = membitmapptr[((height + j + 1) / 2) + i * height];
								}
							}
							break;
						case 2:
							// refer to loc_32BDE in the original function
							fatal_error("unhandled flip type 2");
							break;
					}
					
					// copy flipped bits from mempages -> subres
					for (j = 0; j < height; j++) { // height
						for (i = 0; i < width; i++) { // width
							membitmapptr[i + j * width] = mempages[i + j * width];
						}
					}
				}
			}
		}
		counter++;
		shapecount--;
	} while (shapecount > 0);
	
/*    asm {

	this is the unimplemented unflip case 2 above:

// switch 2
loc_32BDE:
    mov     bx, dx // dx = row counter
    shr     bx, 1
    add     bx, 10h
    add     bx, [var_6]
    mov     cx, [var_C] // width
    mov     si, [var_E]  // height
    shr     si, 1
    adc     si, 0		// si = (height + 1) / 2

loc_32BF3:
    mov     al, [bx]
    stosb
    add     bx, si
    loop    loc_32BF3

    inc     dx
    cmp     dx, [var_E]
    jz      short loc_32C15 // done

    mov     cx, [var_C]
    mov     si, [var_E]
    shr     si, 1
loc_32C08:
    mov     al, [bx]
    stosb
    add     bx, si
    loop    loc_32C08
    inc     dx
    cmp     dx, [var_E]
    jnz     short loc_32BDE
    */

}

void file_unflip_shape2d_pes(unsigned char far* memchunk, char far* mempages) {
	int shapecount, width, height, i, j, x, y;
	unsigned char val;
	unsigned char far* membitmapptr;
	struct SHAPE2D far* memshape;

	shapecount = file_get_res_shape_count(memchunk);

	for (i = 0; i < shapecount; ++i) {
		memshape = file_get_shape2d(memchunk, i);

		if (!(memshape->s2d_unk6 & 0xF0)) {
			val = (memshape->s2d_unk5 >> 4) & 0x0F;

			if (val) {
				width = memshape->s2d_width;
				height = memshape->s2d_height;
				membitmapptr = ((unsigned char far*)memshape) + sizeof(struct SHAPE2D);
				
				for (j = 0; j < 4; ++j) {
					if (val & 0x01) {
						for (y = 0; y < height; ++y) {
							for (x = 0; x < width; ++x) {
								mempages[y * width + x] = membitmapptr[x * height + y];
							}
						}
						
						// Copy flipped data from mempages -> subres
						for (y = 0; y < height; ++y) {
							for (x = 0; x < width; ++x) {
								membitmapptr[y * width + x] = mempages[y * width + x];
							}
						}
					}
					membitmapptr += width * height;
					val >>= 1;
				}
			}
		}
	}
}

void file_load_shape2d_expand(unsigned char far* memchunk, char far* mempages) {
	int shapecount, length, i, j, k, l;
	unsigned char far* memchunkptr, far* mempagesptr, px, pat;
	unsigned long val;
	unsigned long far* offsets, nextoffset;
	struct SHAPE2D far* srcshape, far* dstshape;

	shapecount = file_get_res_shape_count(memchunk);
	
	// Skip size.
	memchunkptr = memchunk + 4;
	mempagesptr = mempages + 4;
	
	// Copy count and ids.
	for (i = 0; i < (shapecount * 2 + 1); ++i) {
		*((unsigned short far*)mempagesptr)++ = *((unsigned short far*)memchunkptr)++;
	}
	
	// Store pointer to offset table.
	offsets = (unsigned long far*)mempagesptr;
	nextoffset = 0;
	
	for (i = 0; i < shapecount; ++i) {
		srcshape = file_get_shape2d(memchunk, i);
		length = srcshape->s2d_width * srcshape->s2d_height;

		offsets[i] = nextoffset;
		nextoffset += sizeof(struct SHAPE2D) + length * 8;
		
		dstshape = file_get_shape2d(mempages, i);
		*dstshape = *srcshape;
		
		dstshape->s2d_width *= 8;

		if (length && length <= 8000) {
			mempagesptr = (unsigned char far*)dstshape + sizeof(struct SHAPE2D);
			
			val = srcshape->s2d_unk4 >> 4;
			val |= val << 8;

			for (j = 0; j < length * 4; ++j) {
				*((unsigned short far*)mempagesptr)++ = val;
			}
			memchunkptr = (unsigned char far*)srcshape + sizeof(struct SHAPE2D);
			
			for (j = 0; j < 4; ++j) {
				pat = (&srcshape->s2d_unk3)[j] & 0x0F;

				if (pat) {
					mempagesptr = (unsigned char far*)dstshape + sizeof(struct SHAPE2D);
					for (k = 0; k < length; ++k) {
						px = *memchunkptr++;
						for (l = 0; l < 8; ++l) {
							if (px & 0x80) {
								*mempagesptr |= pat;
							}
							px <<= 1;
							mempagesptr++;
						}
					}
				}
				else {
					break;
				}
			}
		}
	}
	
	// Final size.
	*(unsigned long far*)mempages = 6 + (shapecount * 8) + nextoffset;
}

unsigned short file_get_unflip_size(char far* memchunk) {
	unsigned short i, shapecount, size, maxsize;
	struct SHAPE2D far* memshape;

	shapecount = file_get_res_shape_count(memchunk);
	maxsize = 0;
	
	for (i = 0; i < shapecount; i++) {
		memshape = file_get_shape2d(memchunk, i);
		size = (memshape->s2d_width * memshape->s2d_height + 0x20) >> 4;
		maxsize = max(maxsize, size);
	}
	return maxsize;
}

unsigned short file_load_shape2d_expandedsize(void far* memchunk) {
	unsigned short shapecount, i;
	long size;
	struct SHAPE2D far* memshape;
	
	shapecount = file_get_res_shape_count(memchunk);

	size = (shapecount * 8) + sizeof(struct SHAPE2D);

	for (i = 0; i < shapecount; ++i) {
		memshape = file_get_shape2d(memchunk, i);
		size += (memshape->s2d_width * memshape->s2d_height * 8) + sizeof(struct SHAPE2D);
	}

	return (size + sizeof(struct SHAPE2D)) >> 4;
}

void file_load_shape2d_palmap_init(unsigned char far* pal) {
	int i;
	
	for (i = 0; i < 0x10; ++i) {
		palmap[i] = pal[i];
	}
}

void file_load_shape2d_palmap_apply(unsigned char far* memchunk, unsigned char palmap[]) {
	unsigned short shapecount, length, i, j;
	unsigned char far* memchunkptr;
	struct SHAPE2D far* memshape;
	
	shapecount = file_get_res_shape_count(memchunk);
	
	for (i = 0; i < shapecount; ++i) {
		memshape = file_get_shape2d(memchunk, i);
		length = memshape->s2d_width * memshape->s2d_height;
		
		memchunkptr = (unsigned char far*)memshape + sizeof(struct SHAPE2D);
		
		for (j = 0; j < length; ++j) {
			*memchunkptr++ = palmap[*memchunkptr];
		}
	}
}

void far* file_load_shape2d_esh(void far* memchunk, const char* str) {
	unsigned short expandedsize;
	void far* mempages;
	void far* palmapres;

	expandedsize = file_load_shape2d_expandedsize(memchunk);

	palmapres = locate_shape_nofatal(memchunk, "!MGA");
	
	if (palmapres) {
		file_load_shape2d_palmap_init(((unsigned char far*)palmapres) + sizeof(struct SHAPE2D));
	}
	
	mempages = mmgr_alloc_pages(str, expandedsize);

	*(long*)mempages = (long)expandedsize * 16;
	
	file_load_shape2d_expand(memchunk, mempages);
	mmgr_release(memchunk);
	memchunk = mmgr_op_unk(mempages);
	file_load_shape2d_palmap_apply(memchunk, palmap);
	
	return memchunk;
}

void far* file_load_shape2d(char* shapename, int fatal) {
	char str[100];
	char* strptr;
	int counter;
	void far* memchunk;
	void far* mempages;
	int unflipsize;

	strcpy(str, shapename);
	strptr = str;
	
	while (*strptr != '.' && *strptr) {
		strptr++;
	}
	
	if (*strptr != 0) {
		fatal_error("unhandled - load_2dshape has dot in the name");
	}

	for (counter = 0; shapeexts[counter] != 0; counter++) {

		strcpy(strptr, shapeexts[counter]);
		memchunk = mmgr_get_chunk_by_name(str);
		if (memchunk) return memchunk; // return existing chunk with same name

		if (file_find(str)) {
			if (stricmp(strptr, ".PVS") == 0) {
				memchunk = file_decomp(str, fatal);
				if (!memchunk) return MK_FP(0, 0);
				
				unflipsize = file_get_unflip_size(memchunk);
				mempages = mmgr_alloc_pages("UNFLIP", unflipsize);
				file_unflip_shape2d(memchunk, mempages);
				mmgr_release(mempages);
				
				return memchunk;
			}
			else if (stricmp(strptr, ".XVS") == 0) {
				return file_decomp(str, fatal);
			}
			else if (stricmp(strptr, ".PES") == 0) {
				memchunk = file_decomp(str, fatal);
				if (!memchunk) return MK_FP(0, 0);
				
				mempages = mmgr_alloc_pages("UNFLIP", 1000);
				file_unflip_shape2d_pes(memchunk, mempages);
				mmgr_release(mempages);

				return file_load_shape2d_esh(memchunk, str);
			}
			else if (stricmp(strptr, ".ESH") == 0) {
				memchunk = file_load_binary(str, fatal);
				if (!memchunk) return MK_FP(0, 0);

				return file_load_shape2d_esh(memchunk, str);
			}
			else { // .VSH
				return file_load_binary(str, fatal);
			}
		}
	}
	fatal_error("unhandled - cannot load %s", str);
	return 0;
}

void far* file_load_shape2d_fatal(char* shapename) {
	return file_load_shape2d(shapename, 1);
}

void far* file_load_shape2d_nofatal(char* shapename) {
	return file_load_shape2d(shapename, 0);
}

void far* file_load_shape2d_nofatal2(char* shapename) {
	return file_load_shape2d(shapename, 0);
}

extern void parse_shape2d(void far* memchunk, void far* mempages);

void far* file_load_shape2d_res(char* resname, int fatal) {
	int chunksize;
	char* shapename = mmgr_path_to_name(resname);
	void far* mempages;
	void far* memchunk = mmgr_get_chunk_by_name(shapename);

	if (memchunk) return memchunk;

	memchunk = file_load_shape2d(shapename, fatal);
	if (!memchunk) return 0;

	chunksize = mmgr_get_chunk_size(memchunk);
	mempages = mmgr_alloc_pages(resname, chunksize);

	parse_shape2d(memchunk, mempages);

	mmgr_release(memchunk);
	return mmgr_op_unk(mempages);
}

void far* file_load_shape2d_res_fatal(char* resname) {
	return file_load_shape2d_res(resname, 1);
}

void far* file_load_shape2d_res_nofatal(char* resname) {
	return file_load_shape2d_res(resname, 0);
}
