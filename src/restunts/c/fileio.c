#ifdef RESTUNTS_DOS
#include <dos.h>
#endif
#ifdef RESTUNTS_SDL
#include <stdio.h>
#define huge 
#endif
#include <stddef.h>
#include "externs.h"
#include "fileio.h"
#include "memmgr.h"

#define PAGE_SIZE 0x4000
#define PAGE_GAP  0x400
#define FILENAME_LEN 13

#define RS_RLE_ESCLEN_MAX    0x10
#define RS_RLE_ESCLOOKUP_LEN 0x100
#define RS_RLE_ESCSEQ_POS    0x01

#define RS_VLE_ESC_LEN   0x10
#define RS_VLE_ALPH_LEN  0x100
#define RS_VLE_ESC_WIDTH 0x40
#define RS_VLE_NUM_SYMB  0x80

struct compr_header {
	union {
		char passes;
		char type;
	};
	unsigned short sizel;
	unsigned char  sizeh;
};

struct compr_rle_header {
	unsigned short srcsizel;
	unsigned char  srcsizeh;
	unsigned char  unk; // Always 0.
	unsigned char  esclen;
	unsigned char  esc[RS_VLE_ESC_LEN];
};

#ifdef RESTUNTS_DOS
// Minimal stdio.h "support" until we can link with a real CRT.
#ifndef __STDIO_H
#define __STDIO_H
typedef unsigned size_t;
typedef int FILE;

int g_errno;

FILE* fopen(const char* path, const char* mode)
{
	unsigned short segm = FP_SEG(path);
	unsigned short offs = FP_OFF(path);
	FILE* handle;

	g_errno = 0;

	if (mode[0] == 'w') { // Create new file for writing
		__asm {
			push ds
			mov  ah, 3Ch // Create file
			mov  cx, 0 // No attributes
			mov  ds, segm
			mov  dx, offs
			int  21h
			jnc  short create_ok
			mov  ax, 0
			mov  g_errno, 1
		create_ok:
			mov  handle, ax
			pop  ds
		}
	}
	else { // Open existing file for reading
		__asm {
			push ds
			mov  ah, 3Dh // Open file
			mov  al, 0 // Read only
			mov  ds, segm
			mov  dx, offs
			int  21h
			jnc  short open_ok
			mov  ax, 0
			mov  g_errno, 1
		open_ok:
			mov  handle, ax
			pop  ds
		}
	}

	return handle;
}

int fclose(FILE* file)
{
	int res;

	__asm {
		mov  ah, 3Eh // Close file
		mov  bx, file
		int  21h
		jnc  short close_ok
		mov  ax, 0
		mov  g_errno, 1
	close_ok:
		mov  res, ax
	}
	
	return res;
}

size_t fread(void far* dst, size_t size, size_t nmemb, FILE* file)
{
	unsigned short segm = FP_SEG(dst);
	unsigned short offs = FP_OFF(dst);

	size_t res;
	size *= nmemb;
	
	__asm {
		push ds
		mov  ah, 3Fh // Read from file
		mov  bx, file
		mov  ds, segm
		mov  dx, offs
		mov  cx, size
		int  21h
		jnc  short read_ok
		mov  ax, 0
		mov  g_errno, 1
	read_ok:
		mov  res, ax
		pop  ds
	}
	
	return res;
}

size_t fwrite(const void far* src, size_t size, size_t nmemb, FILE* file)
{
	unsigned short segm = FP_SEG(src);
	unsigned short offs = FP_OFF(src);

	size_t res;
	size *= nmemb;
	
	__asm {
		push ds
		mov  ah, 40h // Write to file
		mov  bx, file
		mov  ds, segm
		mov  dx, offs
		mov  cx, size
		int  21h
		jnc  short write_ok
		mov  ax, 0
		mov  g_errno, 1
	write_ok:
		mov  res, ax
		pop  ds
	}
	
	return res;
}

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

int fseek(FILE *file, long offset, int origin)
{
	unsigned short ol = offset;
	unsigned short oh = offset >> 16;

	origin |= (0x42 << 8); // Seek file cmd as high byte

	__asm {
		mov  ax, origin
		mov  bx, file
		mov  cx, oh
		mov  dx, ol
		int  21h
		jnc  short seek_ok
		mov  g_errno, 1
	seek_ok:
	}

	return 0;
}
long ftell(FILE *file)
{
	unsigned short ol;
	unsigned short oh;

	__asm {
		mov  ah, 42h // Seek file
		mov  al, SEEK_CUR
		mov  bx, file
		mov  cx, 0
		mov  dx, 0
		int  21h
		jnc  short tell_ok
		mov  word ptr g_errno, 1
	tell_ok:
		mov  oh, dx
		mov  ol, ax
	}

	return ((long)oh << 16) | ol;
}

int ferror(FILE* file)
{
	int res = g_errno;
	(void)file;
	g_errno = 0;
	return res;
}

int remove(const char* path)
{
	unsigned short segm = FP_SEG(path);
	unsigned short offs = FP_OFF(path);
	int retval;

	__asm {
		push ds
		mov  ah, 41h // Unlink file
		mov  ds, segm
		mov  dx, offs
		int  21h
		jnc  short unlink_ok
		mov  word ptr retval, -1
		mov  g_errno, ax
		jmp  short unlink_done
	unlink_ok:
		mov  word ptr retval, 0
	unlink_done:
		pop ds
	}
	
	return retval;
}
#endif

struct file_find_dos {
	struct find_t dta; // DOS DTA struct
	char path[128];    // Full path to found file
	char* dirdelim;    // Last dir delimiter in path string
} g_find;

// Find file matching given query. Returns pointer to first matched filename
// including path from the query. NULL is returned on error/no hits.
// FIXME: DOS specific implementation.
const char* file_find(const char* query)
{
	char const* chsrc;
	char* chdst;
	char attrs = FA_NORMAL | FA_HIDDEN | FA_SYSTEM;
	int retval;

	__asm {
		mov  ah, 1Ah // Set DTA
		mov  dx, offset g_find.dta
		int  21h

		mov  ah, 4Eh // Find first file
		mov  cl, attrs
		mov  dx, query
		int  21h

		jnc  short find_ok
		mov  word ptr retval, -1
		jmp  short find_done
	find_ok:
		mov  word ptr retval, 0
	find_done:
	}

	// Find failed.
	if (retval) {
		return  0;
	}

	// Copy path from query.
	chdst = g_find.dirdelim = g_find.path;
	for (chsrc = query; *chsrc; ++chsrc, ++chdst) {
		*chdst = *chsrc;
		
		if (*chdst == ':' || *chdst == '\\') {
			g_find.dirdelim = chdst + 1;
		}
	}

	// Copy found filename to result path.
	memcpy(g_find.dirdelim, g_find.dta.name, FILENAME_LEN);

	return g_find.path;
}

// Returns next found filename from file_find() query.
// FIXME: DOS specific implementation.
const char* file_find_next(void)
{
	int retval;

	__asm {
		mov  ah, 1Ah // Set DTA
		mov  dx, offset g_find.dta
		int  21h

		mov  ah, 4Fh // Find next file
		int  21h

		jnc  short findnext_ok
		mov  word ptr retval, -1
		jmp  short findnext_done
	findnext_ok:
		mov  word ptr retval, 0
	findnext_done:
	}

	// Find next failed.
	if (retval) {
		return  0;
	}

	// Copy found filename to result path.
	memcpy(g_find.dirdelim, g_find.dta.name, FILENAME_LEN);

	return g_find.path;
}

const char* file_find_next_alt(void)
{
	return file_find_next();
}

#endif // RESTUNTS_DOS

void file_build_path(const char* dir, const char* name, const char* ext, char* dst)
{
	int dirlen;

	if (dir) {
		strcpy(dst, dir);
		dirlen = strlen(dir);
	}
	else {
		dst[0] = 0;
		dirlen = 0;
	}
	
	// Add directory separator if needed.
	if (dirlen && dir[dirlen - 1] != ':' && dir[dirlen - 1] != '\\') {
		strcat(dst, "\\");
	}
	
	strcat(dst, name);
	strcat(dst, ext);
}

const char* file_combine_and_find(const char* dir, const char* name, const char* ext)
{
	char* path;

	file_build_path(dir, name, ext, path);
	
	return file_find(path);
}

// Get number of 16-byte blocks needed to store entire file.
unsigned short file_paras(const char* filename, int fatal)
{
	long length;
	FILE* file;
	
	if ((file = fopen(filename, "rb")) != 0) {
		fseek(file, 0, SEEK_END);
		length = ftell(file);
		fclose(file);
		
		if (!ferror(file)) {
			// May overflow, but all Stunts files are rather small.
			return (length >> 4) + (length & 0xF ? 1 : 0);
		}
	}

	if (fatal) {
		fatal_error(aSFileError, filename);
	}

	return 0;
}

unsigned short file_paras_fatal(const char* filename)
{
	return file_paras(filename, 1);
}

unsigned short file_paras_nofatal(const char* filename)
{
	return file_paras(filename, 0);
}

// Get number of 16-byte blocks needed to store the final result of an assumed compressed file.
unsigned short file_decomp_paras(const char* filename, int fatal)
{
	long length;
	FILE* file;
	struct compr_header hdr;
	
	if ((file = fopen(filename, "rb")) != 0) {
		fread(&hdr, sizeof(hdr), 1, file);
		fclose(file);
		
		if (!ferror(file)) {
			// May overflow, but all Stunts files are rather small.
			length = hdr.sizel | ((long)hdr.sizeh << 16);
			return (length >> 4) + (length & 0xF ? 1 : 0);
		}
	}

	if (fatal) {
		fatal_error(aSFileError_1, filename);
	}

	return 0;
}

unsigned short file_decomp_paras_fatal(const char* filename)
{
	return file_decomp_paras(filename, 1);
}

unsigned short file_decomp_paras_nofatal(const char* filename)
{
	return file_decomp_paras(filename, 0);
}

// Read entire file to given destination. Optionally handle errors as fatal.
void far* file_read(const char* filename, void far* dst, int fatal)
{
	int readlen;
	void far* curdst = dst;
	FILE* file;

	if ((file = fopen(filename, "rb")) != 0) {
		// Read one page at a time.
		do {
			readlen = fread(curdst, PAGE_SIZE, 1, file);
			curdst = MK_FP(FP_SEG(curdst) + PAGE_GAP, FP_OFF(dst));
		} while (readlen == PAGE_SIZE);

		fclose(file);

		if (!ferror(file)) {
			return dst;
		}
	}

	if (fatal) {
		fatal_error(aSFileError, filename);
	}

	return MK_FP(0, 0);
}

// Read entire file to given destination, handle errors as fatal.
void far* file_read_fatal(const char* filename, void far* dst)
{
	return file_read(filename, dst, 1);
}

// Read entire file to given destination, returns NULL pointer if errors occur.
void far* file_read_nofatal(const char* filename, void far* dst)
{
	return file_read(filename, dst, 0);
}

// Write given source buffer to file. Returns a non-zero value on errors unless fatal is set.
short file_write(const char* filename, void far* src, unsigned long length, int fatal)
{
	unsigned short retval;
	unsigned short wrtlen;
	FILE* file;
	
	if ((file = fopen(filename, "wb")) != 0) {
		// Write one page at a time.
		while (length != 0) {
			wrtlen = length > PAGE_SIZE ? PAGE_SIZE : length;

			if (fwrite(src, wrtlen, 1, file) != wrtlen) {
				retval = -1;
				break;
			}
			length -= wrtlen;
			src = MK_FP(FP_SEG(src) + PAGE_GAP, FP_OFF(src));
		}

		fclose(file);
		
		if (!ferror(file)) {
			return 0;
		}
	}
	else {
		retval = (short)file;
	}

	if (fatal) {
		if ((short)file != retval) {
			fclose(file);
		}

		remove(filename);

		fatal_error(aSFileError_0, filename);
	}
	
	return retval;
}

// Write given source buffer to file, handle errors as fatal.
short file_write_fatal(const char* filename, void far* src, unsigned long length)
{
	return file_write(filename, src, length, 1);
}

// Write given source buffer to file, returns a non-zero value on error.
short file_write_nofatal(const char* filename, void far* src, unsigned long length)
{
	return file_write(filename, src, length, 0);
}

// Sequential byte runs pass of run-length encoding.
unsigned long file_decomp_rle_seq(unsigned char huge* src, unsigned char huge* dst, unsigned long srclen, unsigned char esc)
{
	unsigned char cur, rep;
	unsigned char huge* seqstart, huge* seqend;

	unsigned char huge* srcend = src + srclen;
	unsigned char huge* dststart = dst;

	while (src < srcend) {
		cur = *src++;

		// Byte sequence start.
		if (cur == esc) {
			seqstart = src;

			// Copy sequence.
			while ((cur = *src++) != esc) {
				*dst++ = cur;
			}

			 // Number of repetitions, already written once.
			rep = (*src++) - 1;
			seqend = src;

			// Copy remaining repetitions.
			while (rep--) {
				src = seqstart;
				while (src < seqend - 2) {
					*dst++ = *src++;
				}
			}

			src = seqend;
		}
		// No sequence.
		else {
			*dst++ = cur;
		}
	}

	return dst - dststart;
}

// Single byte runs pass of run-length encoding.
unsigned long file_decomp_rle_single(unsigned char huge* src, unsigned char huge* dst, unsigned long len, unsigned char* esclookup)
{
	unsigned char cur, rep;
	unsigned short repw;

	unsigned char huge* dststart = dst;
	unsigned char huge* dstend = dst + len;

	while (dst < dstend) {
		cur = *src++;

		if (esclookup[cur]) {
			switch (esclookup[cur]) {
				case 1:
					rep = *src++;
					cur = *src++;

					while (rep--) {
						*dst++ = cur;
					}
					break;

				case 3:
					repw = *src++;
					repw |= *src++ << 8;
					cur = *src++;

					while (repw--) {
						*dst++ = cur;
					}
					break;

				default:
					rep = esclookup[cur] - 1;
					cur = *src++;

					while (rep--) {
						*dst++ = cur;
					}
					break;
			}
		}
		else {
			*dst++ = cur;
		}
	}

	return dst - dststart;
}

// Decompress run-length encoded sub-file.
unsigned long file_decomp_rle(unsigned char huge* src, unsigned char huge* dst, unsigned short decompparas)
{
	unsigned long len, srclen, passlen;
	unsigned int skipseq, i;
	unsigned char esclookup[RS_RLE_ESCLOOKUP_LEN];
	unsigned char huge* origsrc;
	unsigned short paras;
	struct compr_header far* hdr;
	struct compr_rle_header far* subhdr;

	(void)decompparas;

	// Get decompressed size from header.
	hdr = (struct compr_header far*)src;
	len = hdr->sizel | ((long)hdr->sizeh << 16);
	origsrc = src += sizeof(*hdr);
	
	// Get source size and escape codes.
	subhdr = (struct compr_rle_header far*)src;
	srclen = subhdr->srcsizel | ((long)subhdr->srcsizeh << 16);
	
	skipseq = (subhdr->esclen & 0x80) == 0x80; // MSB denotes skipping the initial pass for byte sequence runs.
	subhdr->esclen &= ~0x80;

	// Set pos to after escape codes.
	src = origsrc + 5 + subhdr->esclen;

	// Escape code lookup.
	for (i = 0; i < RS_RLE_ESCLOOKUP_LEN; ++i) {
		esclookup[i] = 0;
	}

	for (i = 0; i < subhdr->esclen; ++i) {
		esclookup[subhdr->esc[i]] = i + 1;		
	}

	if (!skipseq) {
		passlen = file_decomp_rle_seq(src, dst, srclen, subhdr->esc[RS_RLE_ESCSEQ_POS]);

		paras = (passlen >> 4) + (passlen & 0xF ? 1 : 0);

		// In main decomp func:
		src = MK_FP(decompparas - paras + FP_SEG(dst), FP_OFF(dst));
		copy_paras_reverse(FP_SEG(dst), FP_SEG(src), paras);
	}

	return file_decomp_rle_single(src, dst, len, esclookup);
}

// Decompress variable-length encoded sub-file.
unsigned long file_decomp_vle(unsigned char huge* src, unsigned char huge* dst, unsigned short decompparas)
{
	unsigned long len, lenleft;
	unsigned int additive, alphlen, width, widthdistr, i, j;
	unsigned short esc1[RS_VLE_ESC_LEN], esc2[RS_VLE_ESC_LEN];
	unsigned char alph[RS_VLE_ALPH_LEN], symb[RS_VLE_ALPH_LEN], wdth[RS_VLE_ALPH_LEN];
	unsigned char esclen, symbwdth, numsymb, numsymbleft, cursymb, tmp;
	unsigned char curwdt, nextwdt, code;
	unsigned short curword;

	unsigned char huge* wdtpos;
	unsigned char huge* codpos;
	struct compr_header far* hdr;

	(void)decompparas;

	// Get decompressed size from header.
	hdr = (struct compr_header far*)src;
	len = lenleft = hdr->sizel | ((long)hdr->sizeh << 16);
	src += sizeof(*hdr);

	// One-byte escape codes length counter.
	esclen = *src++;
	additive = (esclen & 0x80) == 0x80; // MSB is additive flag
	esclen &= ~0x80;

	// Store postion of width data for later.
	wdtpos = src;

	// Generate escape codes.
	for (i = 0, j = 0, alphlen = 0; i < esclen; ++i, j *= 2) {
		esc1[i] = alphlen - j;
		tmp = *src++;
		j += tmp;
		alphlen += tmp;
		esc2[i] = j;
	}

	// Read alphabet.
	for (i = 0; i < alphlen; ++i) {
		alph[i] = *src++;
	}

	// Store start position of compression codes, roll back to code width data.
	codpos = src;
	src = wdtpos;

	// Generate lookup tables.
	width = 1;
	widthdistr = (esclen >= 8 ? 8 : esclen);
	numsymb = RS_VLE_NUM_SYMB;
	for (i = 0, j = 0; width <= widthdistr; ++width, numsymb >>= 1) {
		for (symbwdth = *src++; symbwdth > 0; --symbwdth, ++j) {
			for (numsymbleft = numsymb; numsymbleft; --numsymbleft, ++i) {
				symb[i] = alph[j];
				wdth[i] = width;
			}
		}
	}

	// Pad widths.
	for (; i < RS_VLE_ALPH_LEN; ++i) {
		wdth[i] = RS_VLE_ESC_WIDTH;
	}

	// Go to compression codes.
	src = codpos;

	curword = *src << 8 | *(src + 1);
	src += 2;
	curwdt = 8;
	cursymb = 0;

	++lenleft;
	while (lenleft) {
		code = curword >> 8;
		nextwdt = wdth[code];
		// Expand.
		if (nextwdt > 8) {
			code = curword;
			curword >>= 8;

			i = 7;
			while (1) {
				if (!curwdt) {
					code = *src++;
					curwdt = 8;
				}

				curword = (curword << 1) + ((code & 0x80) == 0x80);
				code <<= 1;
				--curwdt;
				++i;

				if (curword < esc2[i]) {
					curword += esc1[i];

					if (additive) {
						cursymb += alph[curword];
					}
					else {
						cursymb = alph[curword];
					}
					*dst++ = cursymb;
					--lenleft;

					break;
				}
			}

			curword = (code << curwdt) | *src++;
			nextwdt = 8 - curwdt;
			curwdt = 8;
		}
		// Direct lookup.
		else {
			if (additive) {
				cursymb += symb[code];
			}
			else {
				cursymb = symb[code];
			}

			*dst++ = cursymb;
			--lenleft;

			if (curwdt < nextwdt) {
				curword <<= curwdt;
				nextwdt -= curwdt;
				curwdt = 8;
				curword |= *src++;
			}
		}

		curword <<= nextwdt;
		curwdt -= nextwdt;
	}

	return len;
}

// Decompress file. Returns pointer to result, NULL or raises fatal error.
void far* file_decomp(const char* filename, int fatal)
{
	unsigned long passlen;
	unsigned short paras, decompparas;
	unsigned char passes, type;
	unsigned char far* src;
	unsigned char far* dst;
	int err = 0;

	// Check if resource archive is already loaded.
	dst = mmgr_get_chunk_by_name(filename);
	if (dst) {
		return dst;
	}

	decompparas = file_decomp_paras(filename, fatal);

	if (decompparas) {
		// Allocate extra paragraphs for alphabet and escape tables
		// overhead used during decompression.
		decompparas += 4;
		dst = mmgr_alloc_pages(filename, decompparas);

		paras = file_paras(filename, fatal);
		if (paras) {
			src = MK_FP(decompparas - paras + FP_SEG(dst), FP_OFF(dst));
			src = file_read(filename, src, fatal);
			if (src) {
				passes = *src;

				// If the multi-pass flag is set, the first byte contains the
				// number of compression passes and the next three bytes holds
				// the final decompressed size.
				if (passes & 0x80) {
					passes &= ~0x80;
					src += 4; // Skip past length data.
				}
				// Flag not set, first byte is compression type of the first
				// and only pass.
				else {
					passes = 1;
				}

				// Decode all compression passes.
				while (!err && passes) {
					type = *src;

					switch (type) {
						case 1:
							passlen = file_decomp_rle(src, dst, decompparas);
							break;
						case 2:
							passlen = file_decomp_vle(src, dst, decompparas);
							break;
						default:
							err = 1;
					}

					// Set source for next pass.
					if (!err && (--passes != 0)) {
						paras = (passlen >> 4) + (passlen & 0xF ? 1 : 0);
						src = MK_FP(decompparas - paras + FP_SEG(dst), FP_OFF(dst));
						copy_paras_reverse(FP_SEG(dst), FP_SEG(src), paras);
					}
				}

				// Free unneeded overhead.
				if (!err) {
					decompparas -= 4;
					mmgr_resize_memory(FP_OFF(dst), FP_SEG(dst), decompparas);

					return dst;
				}
			}
		}
	}

	if (fatal) {
		fatal_error(aSInvalidPackTy, filename);
	}

	return MK_FP(0, 0);
}

void far* file_decomp_fatal(const char* filename)
{
	return file_decomp(filename, 1);
}

void far* file_decomp_nofatal(const char* filename)
{
	return file_decomp(filename, 0);
}

// Allocates, reads and returns a pointer to the contents of a binary file
void far* file_load_binary(const char* filename, int fatal) {
	void far* memptr;
	int numparas;

	memptr = mmgr_get_chunk_by_name(filename);
	if (FP_SEG(memptr) != 0) return memptr;
	
	numparas = file_paras(filename, fatal);
	if (numparas == 0) return MK_FP(0, 0);
	memptr = mmgr_alloc_pages(filename, numparas);
	return file_read(filename, memptr, fatal);
}

void far* file_load_binary_nofatal(const char* filename) {
	return file_load_binary(filename, 0);
}

void far* file_load_binary_fatal(const char* filename) {
	return file_load_binary(filename, 1);
}

void far* file_load_resource(int type, const char* filename) {
	void far* result;
	int dearesult;
	while (1) {
		switch (type) {
			case 0:
				// try load the file, if it fails, show a dialog, and retry
				result = file_load_binary_nofatal(filename);
				if (result != 0) return result;
				break;

			case 1:
				return file_load_binary_nofatal(filename);

			case 2:
				// try load a 2d shape and retry if it failed
				result = file_load_shape2d_nofatal_thunk(filename);
				if (result != 0) return result;
				break;

			case 3:
				// try load a 2d shape and retry if it failed
				result = file_load_shape2d_res_nofatal_thunk(filename);
				if (result != 0) return result;
				break;

			case 4:
				// try load a song file and retry if it failed
				result = load_song_file(filename);
				if (result != 0) return result;
				break;

			case 5:
				// try load a voice file and retry if it failed
				result = load_voice_file(filename);
				if (result != 0) return result;
				break;

			case 6:
				// try load an sfx file and retry if it failed
				result = load_sfx_file(filename);
				if (result != 0) return result;
				break;

			case 7:
				// try load a compressed file
				return file_decomp_nofatal(filename);

			case 8:
				// try load a 2d shape and retry if it failed
				result = file_load_shape2d_nofatal2(filename);
				if (result != 0) return result;
				break;
			default:
				break;
		}

		dearesult = do_dea_textres();
		if (dearesult == 2) return 0;
	}
}


void far* file_load_resfile(const char* filename) {
	char name[0x50];
	void far* result;
	
	while (1) {
		strcpy(name, filename);
		strcat(name, ".res");
		
		result = file_load_resource(1, name);
		if (result != 0) return result;
	
		strcpy(name, filename);
		strcat(name, ".pre");
		
		result = file_load_resource(7, name);
		if (result != 0) return result;
			
		do_dea_textres();
	}
}

void unload_resource(void far* resptr) {
	mmgr_free(resptr);
}

void far* file_load_3dres(const char* filename) {
	char name[0x50];
	void far* result;
	
	while (1) {
		strcpy(name, filename);
		strcat(name, ".p3s");
		
		result = file_load_resource(7, name);
		if (result != 0) return result;
			
		strcpy(name, filename);
		strcat(name, ".3sh");
		
		result = file_load_resource(1, name);
		if (result != 0) return result;
	
		do_dea_textres();
	}
}

void file_load_audiores(const char* songfile, const char* voicefile, const char* name) {
	void far* audiores;
	voicefileptr = file_load_resource(5, voicefile);
	songfileptr = file_load_resource(4, songfile);
	audiores = init_audio_resources(songfileptr, voicefileptr, name);
	load_audio_finalize(audiores);
	is_audioloaded = 1;
}

short file_load_replay(const char* dir, const char* name)
{
	file_build_path(dir, name, ".rpl", g_path_buf);

	g_is_busy = 1;
	file_read_fatal(g_path_buf, td13_rpl_header);
	gameconfig = *(struct GAMEINFO far*)td13_rpl_header;
	g_is_busy = 0;
	return 0;
}

short file_write_replay(const char* filename)
{
	short ret;

	*(struct GAMEINFO far*)td13_rpl_header = gameconfig;

	g_is_busy = 1;
	ret = file_write_fatal(filename, td13_rpl_header, sizeof(struct GAMEINFO) + gameconfig.game_recordedframes);
	g_is_busy = 0;
	
	return ret;
}
