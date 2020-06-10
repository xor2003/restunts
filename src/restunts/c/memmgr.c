#ifdef RESTUNTS_DOS
#include <dos.h>
#endif
#include <stdlib.h>
#include "externs.h"
#include "memmgr.h"

#ifdef RESTUNTS_DOS

#define pushregs()\
	_asm {\
		push dx\
	}\


#define popregs()\
	_asm {\
		pop dx\
	}

void far* dos_get_psp(void) {
	unsigned short resseg, resofs;
	__asm {
		push ds
		mov ah, 62h
		int 21h
		mov resseg, ds
		mov resofs, bx
		pop ds
	}
	return MK_FP(resseg, resofs);
}

unsigned short dos_alloc(unsigned short paras) {
	unsigned short resseg;
	__asm {
		mov bx, paras
		mov ah, 48h
		int 21h
		mov resseg, ax
	}
	return resseg;
}

unsigned short dos_setblock(unsigned short blockseg, unsigned short newsize) {
	unsigned short res;
	__asm {
		mov bx, newsize
		mov es, blockseg
		mov ah, 4ah
		int 21h
		mov res, bx	// bx = max blocks
	}
	return res;
}

#else
void pushregs() {}
void popregs() {}
	
size_t word_3FF82 = 0; // last para reserved by memmgr
size_t word_3FF84 = 0; // first para reserved by memmgr
unsigned short resmaxsize = 0; // size of largest chunk?

struct MEMCHUNK resources[] = {
	{ 0, 0, 0, 2 },
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 

	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 

	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 
	{ 0, 0, 0, 1 },
};
struct MEMCHUNK* resendptr1 = &resources[49]; // eller 49?
struct MEMCHUNK* resendptr2 = &resources[49]; // ditto
struct MEMCHUNK* resptr1 = resources;
struct MEMCHUNK* resptr2 = resources;

#endif

const char* mmgr_path_to_name(const char* filename) {
	const char* c;
	const char* result;

	pushregs();
	
	result = filename;
	for (c = filename; *c; c++) {
		if (*c == ':' || *c == '\\') 
			result = c + 1;
	}
	
	popregs();
	return result;
}

extern void far* ported_mmgr_alloc_pages_(const char* arg_0, unsigned short arg_2);

void far* mmgr_alloc_pages(const char* arg_0, unsigned short arg_2) {
	int i;
	struct MEMCHUNK* resdi;
	struct MEMCHUNK* ressi;
	const char* chunkname;
	unsigned rax, rdx;

	resdi = resptr2;
	ressi = resendptr1;
	rdx = resdi->resofs + resdi->ressize;

	resdi++;
	if (ressi <= resdi) {
		if (ressi == resendptr2) 
			fatal_error("reservememory - OUT OF MEMORY SLOTS RESERVING %s", arg_0);

		ressi++;
		resendptr1 = ressi;
	}

	resptr2 = resdi;
	chunkname = mmgr_path_to_name(arg_0);
	for (i = 0; i < 0xC; i++)
		resdi->resname[i] = chunkname[i];

	rax = arg_2;
	resdi->resofs = rdx;
	resdi->ressize = rax;
	resdi->resunk = 2;

	rax += rdx;
	if (rax > resmaxsize) 
		resmaxsize = rax;

	if (rax > ressi->resofs) {
		ressi = resendptr1;
		resdi = resptr2;
		rax = resdi->resofs + resdi->ressize;
	
		while (rax > ressi->resofs) {
			if (ressi == resendptr2) {
				fatal_error("reservememory - OUT OF MEMORY RESERVING %s P=%x HW=%x\r\n", arg_0, resdi->ressize, resmaxsize);
			}

			ressi->resunk = 0;
			ressi++;
			resendptr1 = ressi;
		}
	}

	return MK_FP(rdx, 0);
}

void far* mmgr_alloc_resbytes(const char* name, long int size) {
	return mmgr_alloc_pages(name, size / 16);
}

void mmgr_alloc_resmem(unsigned short arg_0) {

	void far* psp;
	unsigned maxblocks;
	struct MEMCHUNK* rp;
	char* tempptr;

#ifdef RESTUNTS_DOS
	psp = dos_get_psp();
	pspseg = FP_SEG(psp);
	pspofs = FP_OFF(psp);
	
	if (word_3FF82 == 0) {
		resptr1->resofs = dos_alloc(0x64);
		word_3FF84 = resptr1->resofs;
		maxblocks = dos_setblock(resptr1->resofs, arg_0 - resptr1->resofs);
		maxblocks = dos_setblock(resptr1->resofs, maxblocks);
		resendptr2->resofs = word_3FF84 + maxblocks;
		word_3FF82 = resendptr2->resofs;
		//fatal_error("%u\n", word_3FF82 - word_3FF84);
	}
#else
	if (word_3FF82 == 0) {
		// assume 640k is enough for anybody:
		maxblocks = (640 * 1024) >> 4;
		tempptr = malloc((maxblocks << 4) + 16);
		resptr1->resofs = (((size_t)tempptr) + 16)>>4;
		word_3FF84 = resptr1->resofs;
		resendptr2->resofs = word_3FF84 + maxblocks;
		word_3FF82 = resendptr2->resofs;
		
	}
#endif
	resendptr1 = resendptr2;
	resptr2 = resptr1;
	
	rp = resptr1;
	for (;;) {
		rp++;
		if (rp == resendptr2) break;
		rp->resunk = 0;
	}
}

void mmgr_alloc_a000(void) {
	mmgr_alloc_resmem(0xa000);
}

unsigned short mmgr_get_ofs_diff(void) {
	return resendptr2->resofs - resptr2->resofs - resptr2->ressize;
}

void far* mmgr_free(char far* ptr) {
	int i;
	unsigned ax, bx, cx, dx, di;
	unsigned ptrseg;
	struct MEMCHUNK* ressi;
	struct MEMCHUNK* resbx;

	ressi = resptr2;
	ptrseg = FP_SEG(ptr);

	while (1) {
		if (ressi == resptr1) 
			fatal_error("memory manager - BLOCK NOT FOUND at SEG= %x", ptrseg);
		if (ressi->resofs == ptrseg) break;
		ressi--;
	}

	ptrseg = 0;
	ressi->resunk = 0;
	if (ressi != resptr2) {
		if (ressi == resendptr1) goto loc_31508;
		ax = resendptr1->resofs - resptr2->resofs - resptr2->ressize;
		if (ax < ressi->ressize) goto loc_31508;
	}

	ptrseg = resendptr1->resofs - ressi->ressize;
	resendptr1--;
	resendptr1->resofs = ptrseg;
	resendptr1->ressize = ressi->ressize;
	resendptr1->resunk = 1;

	for (i = 0; i < 0xC; i++) {
		resendptr1->resname[i] = ressi->resname[i];
	}

	copy_paras_reverse(ressi->resofs, ptrseg, ressi->ressize);

loc_31508:
	if (ressi == resptr2) {
		do {
			ressi--;
		} while (ressi->resunk == 0);
		resptr2 = ressi;
	}

	return MK_FP(ptrseg, FP_OFF(ptr));
}

void mmgr_copy_paras(unsigned short srcseg, unsigned short destseg, short paras) {
	unsigned short count; // number of words to copy
	unsigned short far * srcptr;
	unsigned short far * destptr;
	
	while (paras != 0) {
		count = 0x8000; // 64k in words
		paras -= 0x1000; // 64k in paras
		if (paras < 0) {
			count = (paras + 0x1000) << 3;  // count = remaining paras < 0x1000 in words
			paras = 0;
		}
		srcptr = MK_FP(srcseg, 0);
		destptr = MK_FP(destseg, 0);

		while (count) {
			*destptr = *srcptr;
			srcptr++;
			destptr++;
			count--;
		}

		srcseg += 0x1000;
		destseg += 0x1000;
	}
}


void copy_paras_reverse(unsigned short srcseg, unsigned short destseg, short paras) {
	unsigned short count, ofs;
	unsigned short far* destptr;
	unsigned short far* srcptr;

	pushregs();

	srcseg += paras;
	destseg += paras;

	while (paras != 0) {
		count = 0x1000;
		paras -= 0x1000;
		if (paras < 0) {
			count = paras + 0x1000;
			paras = 0;
		}
		srcseg -= count;
		destseg -= count;
		count <<= 3;
		ofs = (count << 1) - 2;

		srcptr = MK_FP(srcseg, ofs);
		destptr = MK_FP(destseg, ofs);
		while (count) {
			*destptr = *srcptr;
			srcptr--;
			destptr--;
			count--;
		}
	}
	popregs();
}

void mmgr_find_free(void) {
	int i;
	unsigned short regax, regdx;
	struct MEMCHUNK* ressi;
	struct MEMCHUNK* resdi;

	pushregs();

	ressi = resendptr2;
	resdi = ressi;
	regdx = 0;

	do {
		if ((ressi->resunk & 1) == 0) {
			regdx += ressi->ressize;
		} else {
		
			if (regdx != 0) {
				resdi++;
				regax = resdi->resofs - ressi->ressize;
				resdi--;
				resdi->ressize = ressi->ressize;
				resdi->resofs = regax;
				ressi->resunk = 0;
				resdi->resunk = ressi->resunk;
				for (i = 0; i < 0xC; i++) {
					resdi->resname[i] = ressi->resname[i];
				}
				copy_paras_reverse(ressi->resofs, regax, ressi->ressize);
			}
		
			resdi--;
		}
		ressi--;
	} while (ressi > resendptr1);

	resdi++;
	resendptr1 = resdi;

	popregs();
}

void far* ported_mmgr_get_chunk_by_name_(const char* name);

void far* mmgr_get_chunk_by_name(const char* name) {
	const char* pcdi;
	int regbx, regax;
	struct MEMCHUNK* ressi;
	int found = 0;
	
	ressi = resendptr1;
	pcdi = mmgr_path_to_name(name);

	for (; ressi < resendptr2; ressi++) {
		regbx = 0;
		if (ressi->resunk == 0) {
			return MK_FP(0, 0);
		}

		for (; regbx < 0xC; regbx++) {
			if (pcdi[regbx] == 0) {
				if (ressi->resname[regbx] == '.' || ressi->resname[regbx] == 0) {
					found = 1;
				}
				break;
			}
			if (ressi->resname[regbx] != 0)
				break;
		}
		if (regbx == 0xC || found == 1) {
			ressi->resunk = 0;
			resptr2->resofs = resptr2->resofs + resptr2->ressize;
			resptr2->ressize = resptr2->ressize;
			memcpy(resptr2->resname, ressi->resname, sizeof(char[12]));
			if (resptr2 == resendptr1) {
				resendptr1++;
			}
			mmgr_copy_paras(ressi->resofs, resptr2->resofs, resptr2->ressize);
			regax = resptr2->resofs + resptr2->ressize;
			while (regax > resendptr1->resofs) {
				resendptr1->resunk = 0;
				resendptr1++;
			}
			mmgr_find_free();
			return MK_FP(resptr2->resofs, 0);
		}

	}

	return MK_FP(0, 0);
}

void mmgr_release(char far* ptr) {
	int i;
	unsigned short regax, regbx, regcx, regdx;
	char* strdi;
	struct MEMCHUNK* ressi;
	struct MEMCHUNK* resdi;

	pushregs();
	__asm {
		push bx
	}
	
	regax = FP_SEG(ptr);
	ressi = resptr2;

	for (;;) {
		if (ressi == resptr1) 
			fatal_error("memory manager - BLOCK NOT FOUND at SEG= %x", regax);
		if (regax == ressi->resofs) break;
		ressi--;
	}
	
	ressi->resunk = 0;
	if (ressi == resptr2) {
		do {
			ressi--;
		} while (ressi->resunk == 0);
		resptr2 = ressi;
	}

	__asm {
		pop bx
	}
	popregs();
}

unsigned short mmgr_get_chunk_size(char far* ptr) {
	int i;
	unsigned short regax, regbx, regcx, regdx;
	char* strdi;
	struct MEMCHUNK* ressi;
	struct MEMCHUNK* resdi;

	regax = FP_SEG(ptr);
	ressi = resptr2;

	for (;;) {
		if (ressi == resptr1) 
			fatal_error("memory manager - BLOCK NOT FOUND at SEG= %x", regax);
		if (regax == ressi->resofs) break;
		ressi--;
	}
	return ressi->ressize;
}

unsigned short mmgr_resize_memory(unsigned short arg_0, unsigned short arg_2, unsigned short arg_4) {
	int i;
	unsigned short regax, regbx, regcx, regdx;
	char* strdi;
	struct MEMCHUNK* ressi;
	struct MEMCHUNK* resdi;

	pushregs();

	(void)arg_0;
	regax = arg_2;
	ressi = resptr2;

	for (;;) {
		if (ressi == resptr1)
			fatal_error("memory manager - BLOCK NOT FOUND at SEG= %x", arg_2);
		if (regax == ressi->resofs) break;
		ressi--;
	}

	regax = arg_4;
	if (regax <= ressi->ressize) {
		ressi->ressize = regax;
		popregs();
		return regax;
	}

	if (ressi != resptr2)
		fatal_error("resizememory - CANNOT EXPAND BLOCK NOT AT TOP");
	ressi->ressize = regax;
	resdi = resendptr1;
	regax += ressi->resofs;
	if (regax >= resmaxsize)
		resmaxsize = regax;

	if (regax <= resdi->resofs) {
		popregs();
		return 0;
	}

	ressi = resendptr1;
	resdi = resptr2;
	regax = resdi->resofs + resdi->ressize;

	for (;;) {
		if (regax <= ressi->resofs) break;
		if (ressi == resendptr2) 
			fatal_error("resizememory - NO MEMORY LEFT TO EXPAND HW=%x", resmaxsize);
	
		ressi->resunk = 0;
		ressi++;
		resendptr1 = ressi;
	}
	popregs();
	return 0;
}

void far* mmgr_op_unk(char far* ptr) {
	int i;
	unsigned short regax, regbx, regcx, regdx;
	char* strdi;
	struct MEMCHUNK* ressi;
	struct MEMCHUNK* resdi;

	regax = FP_SEG(ptr);
	ressi = resptr2;

	for (;;) {
		if (ressi == resptr1)
			fatal_error("memory manager - BLOCK NOT FOUND at SEG= %x", regax);
		if (regax == ressi->resofs) break;
		ressi--;
	}

	resdi = ressi;
	resdi--;
	if (resdi->resunk == 0) {
	
		do {
			resdi--;
		} while (resdi->resunk == 0);
	
		ressi->resunk = 0;
		regax = resdi->resofs + resdi->ressize;
		resdi++;
		if (ressi == resptr2) {
			resptr2 = resdi;
		}
	
		resdi->resofs = regax;
		resdi->ressize = ressi->ressize;
		resdi->resunk = 2;
		for (i = 0; i < 0xC; i++) {
			resdi->resname[i] = ressi->resname[i];
		}
		mmgr_copy_paras(ressi->resofs, regax, ressi->ressize);

	} else {
		resdi = ressi;
	}

	return MK_FP(resdi->resofs, 0);
}

unsigned long mmgr_get_res_ofs_diff_scaled(void) {
	unsigned long result = mmgr_get_ofs_diff();
	return result << 4;
}

unsigned long mmgr_get_chunk_size_bytes(char far* ptr) {
	unsigned long result = mmgr_get_chunk_size(ptr);
	return result << 4;
}
//#endif


struct resheader {
	unsigned long size;
	unsigned short chunks;
};

char far* locate_resource(char far* data, char* name, unsigned short fatal) {
	unsigned int i, j;
	struct resheader far* hdr = (struct resheader far*)data;
	char far* resnames = (char far*)data + 6; // point at first 4-byte resource identifier
	char huge* result = data; // cannot add >64k on a far pointer, use a huge pointer instead

	//printf("locate_resource: %s\n", name);

	// pad name with spaces
	for (i = 0; i < 4; i++) {
		if (name[i] == 0) {
			for (; i < 4; i++) {
				name[i] = 0x20;
			}
			break;
		}
	}

	for (j = 0; j < hdr->chunks; j++) {
		for (i = 0; i < 4; i++) {
			if (resnames[i] != name[i]) {
				break;
			}
		}
		if (i == 4 || (resnames[i] == 0 && name[i] == 0x20)) {
			result = data;
			result += hdr->chunks * 8 + 6; // header, names and offsets
			result += *(unsigned long int far*)(&resnames[hdr->chunks * 4]); // extract the offset
			return (char far*)result;
		}
		resnames += 4; // move pointer to next 4-byte resource identifier
	}

	if (fatal > 1)
		fatal_error(aLocatesound4_4sSoundNotF, name);
	if (fatal == 1)
		fatal_error(aLocateshape4_4sShapeNotF, name);
	return MK_FP(0, 0);
}

char far* locate_shape_nofatal(char far* data, char* name) {
	return locate_resource(data, name, 0);
}

char far* locate_shape_fatal(char far* data, char* name) {
	return locate_resource(data, name, 1);
}

char far* locate_shape_alt(char far* data, char* name) {
	return locate_shape_fatal(data, name);
}

char far* locate_sound_fatal(char far* data, char* name) {
	return locate_resource(data, name, 2);
}

void locate_many_resources(char far* data, char* names, char far** result) {
	while (*names != 0) {
		*result = locate_shape_fatal(data, names);
		names += 4;
		result ++;
	}
}

char far* locate_text_res(char far* data, char* name) {
	char textname[4];
	textname[0] = textresprefix;
	textname[1] = name[0];
	textname[2] = name[1];
	textname[3] = name[2];
	return locate_shape_fatal(data, textname);
}

