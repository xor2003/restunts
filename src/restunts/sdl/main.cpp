#include <map>
#include <string>
#include "SDL.h"
extern "C" {
#include "fileio.h"
#include "memmgr.h"
#include "shape3d.h"
}

/* Function Prototypes */
void PrintKeyInfo( SDL_KeyboardEvent *key );
void PrintModifiers( SDLMod mod );

int game_thread(void* param);

extern "C" {

int stuntsmain(int argc, char** argv);

void far* fontnptr;
void far* fontdefptr;
void far* mainresptr;
short is_audioloaded;
void far* songfileptr;
void far* voicefileptr;

void fatal_error(const char* fmterr, ...) {
	printf(fmterr);
}

void far* init_audio_resources(void far* songptr, void far* voiceptr, const char* name) {
	return 0;
}

void load_audio_finalize(void far* audiores) {
}

void far* load_song_file(const char* filename) {
	return 0;
}

void far* load_voice_file(const char* filename) {
	return 0;
}

void far* load_sfx_file(const char* filename) {
	return 0;
}

void far* file_load_shape2d_nofatal_thunk(const char* filename) {
	return 0;
}

void far* file_load_shape2d_res_nofatal_thunk(const char* filename) {
	return 0;
}

void far* file_load_shape2d_nofatal(char* shapename) {
	return 0;
}

void far* file_load_shape2d_nofatal2(char* shapename) {
	return 0;
}

int do_dea_textres(void) {
	printf("do_dea_textres() (insert disk)\n");
	return 0;
}

unsigned long file_decomp_rle(void far* src, void far* dst, unsigned paras) {
	printf("file_decomp_rle() not implemented!\n");
	return 0;
}
/*
void copy_paras_reverse(unsigned short srcseg, unsigned short destseg, short paras) {
	printf("copy_paras_reverse() not implemented!\n");
}

unsigned short mmgr_resize_memory(unsigned short arg_0, unsigned short arg_2, unsigned short arg_4) {
	printf("mmgr_resize_memory() not implemented!\n");
	return 0;
}

std::map<std::string, char*> memchunks;

void far* mmgr_alloc_pages(const char* arg_0, unsigned short arg_2) {
	printf("alloc pages %s\n", arg_0);
	char* chunk = new char[arg_2 * 16];
	memchunks[arg_0] = chunk;
	return chunk;
}

void far* mmgr_get_chunk_by_name(const char* arg_0) {
	printf("get chunk by name %s\n", arg_0);
	std::map<std::string, char*>::iterator i = memchunks.find(arg_0);
	if (i == memchunks.end()) return 0;
	return i->second;
}

void far* mmgr_free(char far* ptr) {
	printf("mmgr_free() not implemented!\n");
	return 0;
}

unsigned long mmgr_get_res_ofs_diff_scaled() {
	printf("mmgr_get_res_ofs_diff_scaled() not implemented!\n");
	return 0xFDE8;
}

*/

extern void draw_filled_lines(unsigned, unsigned, unsigned, unsigned, unsigned);

void (*spritefunc)(unsigned, unsigned, unsigned, unsigned, unsigned);

void preRender_default(int color, int vertlinecount, int* vertlines) {
	int i;
	printf("%i lines in color %i:\n", vertlinecount, color);
	
	spritefunc = &draw_filled_lines;
	
	for (i = 0; i < vertlinecount * 2; i++) {
		printf("    %i: %i\n", i, vertlines[i]);
	}
}


extern void shape3d_load_car_shapes(char* carid, char* oppcarid);
//void shape3d_load_all();

const char* aSInvalidPackTy = "Invalid Pack Type";

const char* aSFileError = "File error";
const char* aSFileError_0 = "File error 0";
const char* aSFileError_1 = "File error 1";
const char* aLocateshape4_4sShapeNotF = "shape not found %-4.4s";
const char* aLocatesound4_4sSoundNotF = "sound not found %-4.4s";
char textresprefix = 'e';


struct MATRIX mat_x_rot;
struct MATRIX mat_y_rot;
struct MATRIX mat_z_rot;
struct MATRIX mat_rot_temp;
struct MATRIX mat_temp;
struct MATRIX mat_y0, mat_y100, mat_y200, mat_y300;

struct RECTANGLE select_rect_rc;
unsigned mat_y_rot_angle;
unsigned cos80, sin80, cos80_2, sin80_2;

unsigned projectiondata1 = 0;
unsigned projectiondata2 = 0;
unsigned projectiondata3 = 0x0A;
unsigned projectiondata4 = 0;
unsigned projectiondata5 = 0x0A;
unsigned projectiondata6 = 0x64;
unsigned projectiondata7 = 0;
unsigned projectiondata8 = 0x64;
unsigned projectiondata9 = 0;
unsigned projectiondata10 = 0;
char byte_45514;

unsigned word_40ECE;
unsigned transshapenumverts;
unsigned char far* transshapeprimitives;
struct VECTOR far* transshapeverts;
unsigned transshapenumpaints;
unsigned char transshapematerial;
unsigned char transshapeflags;
struct RECTANGLE* transshaperectptr;

unsigned char byte_4393D;
unsigned word_4394E;
unsigned word_45D98;
unsigned word_4554A;
unsigned word_443F2;
unsigned char transshapenumvertscopy;
unsigned select_rect_param;
char far* transshapeprimptr;
unsigned polyinfoptrnext;
char far* polyinfoptr;
char far* transshapepolyinfo;
struct POINT2D far* transshapepolyinfopts;
unsigned polyinfonumpolys;
char transprimitivepaintjob;
unsigned char far* transshapeprimindexptr;

unsigned char far* polyinfoptrs[0x190];
struct POINT2D* polyvertpointptrtab[10];
unsigned word_40ED6[0x190 + 1]; // the +1 replaces word_411F6
//unsigned word_411F6;

char primtypetab[] = {
	0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 0, 0
};

long invpow2tbl[] = { 
	0x80000000, 0x40000000, 0x20000000, 0x10000000, 8000000,
	0x4000000, 0x2000000, 0x1000000, 0x800000, 
	0x400000, 0x200000, 0x100000, 0x80000, 
	0x40000, 0x20000, 0x10000, 0x8000, 0x4000, 0x2000, 
	0x1000, 0x800, 0x400, 0x200, 0x100, 0x80, 0x40, 0x20,
	0x10, 0x8, 0x4, 0x2, 0x1
};

char primidxcounttab[] = {
		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0x0A, 2, 6, 3, 0, 0
};

char atantable[] = {
	
	0x0, 0x1, 0x1, 0x2, 0x3, 0x3, 0x4, 0x4, 0x5, 0x6, 0x6, 0x7, 0x8, 0x8, 0x9, 0x0A,
	0x0A, 0x0B, 0x0B, 0x0C, 0x0D, 0x0D, 0x0E, 0x0F, 0x0F, 0x10, 0x10, 0x11, 0x12, 0x12, 0x13, 0x14,
	0x14, 0x15, 0x16, 0x16, 0x17, 0x17, 0x18, 0x19, 0x19, 0x1A, 0x1B, 0x1B, 0x1C, 0x1C, 0x1D, 0x1E,
	0x1E, 0x1F, 0x1F, 0x20, 0x21, 0x21, 0x22, 0x22, 0x23, 0x24, 0x24, 0x25, 0x26, 0x26, 0x27, 0x27,
	0x28, 0x29, 0x29, 0x2A, 0x2A, 0x2B, 0x2C, 0x2C, 0x2D, 0x2D, 0x2E, 0x2E, 0x2F, 0x30, 0x30, 0x31,
	0x31, 0x32, 0x33, 0x33, 0x34, 0x34, 0x35, 0x35, 0x36, 0x37, 0x37, 0x38, 0x38, 0x39, 0x39, 0x3A,
	0x3A, 0x3B, 0x3C, 0x3C, 0x3D, 0x3D, 0x3E, 0x3E, 0x3F, 0x3F, 0x40, 0x41, 0x41, 0x42, 0x42, 0x43,
	0x43, 0x44, 0x44, 0x45, 0x45, 0x46, 0x46, 0x47, 0x47, 0x48, 0x48, 0x49, 0x4A, 0x4A, 0x4B, 0x4B,
	0x4C, 0x4C, 0x4D, 0x4D, 0x4E, 0x4E, 0x4F, 0x4F, 0x50, 0x50, 0x51, 0x51, 0x52, 0x52, 0x53, 0x53,
	0x54, 0x54, 0x54, 0x55, 0x55, 0x56, 0x56, 0x57, 0x57, 0x58, 0x58, 0x59, 0x59, 0x5A, 0x5A, 0x5B,
	0x5B, 0x5B, 0x5C, 0x5C, 0x5D, 0x5D, 0x5E, 0x5E, 0x5F, 0x5F, 0x60, 0x60, 0x60, 0x61, 0x61, 0x62,
	0x62, 0x63, 0x63, 0x63, 0x64, 0x64, 0x65, 0x65, 0x66, 0x66, 0x66, 0x67, 0x67, 0x68, 0x68, 0x68,
	0x69, 0x69, 0x6A, 0x6A, 0x6A, 0x6B, 0x6B, 0x6C, 0x6C, 0x6C, 0x6D, 0x6D, 0x6E, 0x6E, 0x6E, 0x6F,
	0x6F, 0x70, 0x70, 0x70, 0x71, 0x71, 0x71, 0x72, 0x72, 0x73, 0x73, 0x73, 0x74, 0x74, 0x74, 0x75,
	0x75, 0x76, 0x76, 0x76, 0x77, 0x77, 0x77, 0x78, 0x78, 0x78, 0x79, 0x79, 0x79, 0x7A, 0x7A, 0x7A,
	0x7B, 0x7B, 0x7B, 0x7C, 0x7C, 0x7C, 0x7D, 0x7D, 0x7D, 0x7E, 0x7E, 0x7E, 0x7F, 0x7F, 0x7F, 0x80,
	0x80, 0x0
};

extern struct SHAPE3D game3dshapes[130];
extern unsigned transformed_shape_op(struct TRANSFORMEDSHAPE3D* shape);


unsigned material_color_list[] = {
	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
	0x8, 0x9, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
	0x6C, 0x74, 0x0F, 0x1C, 0x1D, 0x0E, 0x1C, 0x1F,
	0x0E, 0x0C8, 0x0C6, 0x0C4, 0x70, 0x72, 0x74, 0x0C2,
	0x0C5, 0x0C8, 0x92, 0x25, 0x23, 0x0B5, 0x1D, 0x1F,
	0x13, 0x3, 0x0B, 0x1B, 0x0, 0x4, 0x4, 0x0C,
	0x9C, 0x9A, 0x98, 0x96, 0x2A, 0x28, 0x26, 0x25,
	0x1B, 0x1A, 0x19, 0x18, 0x48, 0x46, 0x44, 0x42,
	0x7B, 0x79, 0x78, 0x75, 0x5C, 0x5A, 0x58, 0x57,
	0x0AD, 0x0AB, 0x0A9, 0x0A7, 0x14, 0x13, 0x12, 0x11,
	0x4D, 0x4C, 0x4A, 0x49, 0x2D, 0x2C, 0x2A, 0x29,
	0x9F, 0x0AF, 0x0AE, 0x0AC, 0x1D, 0x1C, 0x12, 0x5A,
	0x0F, 0x7, 0x0C8, 0x0DB, 0x88, 0x63, 0x65, 0x67,
	0x68, 0x6A, 0x11, 0x14, 0x3C, 0x4D, 0x2E, 0x3D,
	0x2D, 0x0CA, 0x0BE, 0x0BA, 0x0B7, 0x0B4, 0x0, 0x1C,
	0x1E, 0x10, 0x14, 0x44, 0x36, 0x27, 0x2B, 0x0C,
	0x11
};

unsigned material_pattern_list[] = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
	1, 0, 0
};

unsigned material_pattern2_list[] = {
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x77DD, 0x0DD77, 0x77DD, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x77DD, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x77DD, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF, 0x0FFFF,
	0x0FFFF, 0x0FFFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
	0x0, 0x0CC33, 0x33CC, 0x0B66D, 0x4992, 0x0B66D, 0x4992, 0x0B66D,
	0x4992, 0x0, 0x0
};
unsigned* material_clrlist_ptr = material_color_list;
unsigned* material_clrlist_ptr2 = material_color_list;
unsigned* material_patlist_ptr = material_pattern_list;
unsigned* material_patlist2_ptr = material_pattern2_list;

unsigned* material_clrlist_ptr_cpy;
unsigned* material_clrlist_ptr_cpy2;
unsigned* material_patlist_ptr_cpy;
unsigned* material_patlist_ptr_cpy2;
unsigned someZeroVideoConst;

void copy_material_list_pointers(unsigned* m1, unsigned* m2, unsigned* m3, unsigned* m4, unsigned unk) {
	material_clrlist_ptr_cpy = m1;
	material_clrlist_ptr_cpy2 = m2;
	material_patlist_ptr_cpy = m3;
	material_patlist_ptr_cpy2 = m4;
	someZeroVideoConst = unk;
}

void init_video() {
	// init memgr - called from init_video()
	mmgr_alloc_a000();
	copy_material_list_pointers(material_clrlist_ptr, material_clrlist_ptr2, material_patlist_ptr, material_patlist2_ptr, 0);
}

} // extern "C"


struct stunts_engine {
	SDL_Thread* thread;
	int argc;
	char** argv;
	int quit;
	
	stunts_engine(int _argc, char** _argv) {
		argc = _argc;
		argv = _argv;
		quit = 0;
	}
	
	bool init() {
		/* Initialise SDL */
		if( SDL_Init( SDL_INIT_VIDEO ) < 0){
			fprintf( stderr, "Could not initialise SDL: %s\n", SDL_GetError() );
			return false;
		}
	
		/* Set a video mode */
		if( !SDL_SetVideoMode( 320, 200, 0, 0 ) ){
			fprintf( stderr, "Could not set video mode: %s\n", SDL_GetError() );
			SDL_Quit();
			return false;
		}
	
		/* Enable Unicode translation */
		SDL_EnableUNICODE( 1 );
		return true;
	}
	
	void uninit() {
		SDL_Quit();
	}
	
	void run() {
		thread = SDL_CreateThread(game_thread, this);

		SDL_Event event;
		while( !quit ){
			while( SDL_PollEvent( &event ) ){
				switch( event.type ){
					case SDL_KEYDOWN:
					case SDL_KEYUP:
						PrintKeyInfo( &event.key );
						break;
					case SDL_QUIT:
						quit = 1;
						break;
					default:
						break;
				}
			}
		}
	}
	
	int run_thread() {
		
		init_video();
		
		printf("hello from game thread\n");
		mainresptr = file_load_resfile("main");
		fontdefptr = file_load_resource(0, "fontdef.fnt");
		fontnptr = file_load_resource(0, "fontn.fnt");

		init_polyinfo();
		shape3d_load_all();
		
		//void* tempdataptr = file_load_resource(2, "sdtitl");
		//void* titlshapeptr = locate_shape_fatal(tempdataptr, "titl");
		

		struct VECTOR carpos = { 0, 0x0FCB8, 0x0B40 }; // from the original
		struct RECTANGLE shaperect = { 0, 320, 0, 200 };
		struct RECTANGLE cliprect = { 0, 0x140, 0, 0x5F };
		struct TRANSFORMEDSHAPE3D transshape;
		int carposangle;
		carposangle = polarAngle(carpos.y, carpos.z);

		select_cliprect_rotate(0, carposangle, 0, &cliprect, 0);
		set_projection(0x24, 0x11, 0x140, 0x64);	// would at best draw just a pixel without this - camera projection??

		transshape.material = 0;
		transshape.rotvec.x = 0;
		transshape.rotvec.y = 0;
		transshape.rotvec.z = 0;
		transshape.pos = carpos;
	
		transshape.unk = 0;//0x7530;
		transshape.ts_flags = 0;
		transshape.rectptr = &shaperect;

		transshape.shapeptr = &game3dshapes[32];

		int result = transformed_shape_op(&transshape);
		
		printf("result %i, polys=%i\n", result, polyinfonumpolys);
		
		get_a_poly_info();
		
		//printf("%i\n", transformed_shape_op(&transshape));

		// font_set_fontdef();
		return 0;//stuntsmain(argc, argv);
	}
};


int game_thread(void* param) {
	stunts_engine* stunts = (stunts_engine*)param;
	return stunts->run_thread();
}

/* main */
int main( int argc, char *argv[] ){

	stunts_engine stunts(argc, argv);
	if (stunts.init())
		stunts.run();
	stunts.uninit();
	return 0;
}

/* Print all information about a key event */
void PrintKeyInfo( SDL_KeyboardEvent *key ){
	/* Is it a release or a press? */
	if( key->type == SDL_KEYUP )
		printf( "Release:- " );
	else
		printf( "Press:- " );

	/* Print the hardware scancode first */
	printf( "Scancode: 0x%02X", key->keysym.scancode );
	/* Print the name of the key */
	printf( ", Name: %s", SDL_GetKeyName( key->keysym.sym ) );
	/* We want to print the unicode info, but we need to make */
	/* sure its a press event first (remember, release events */
	/* don't have unicode info                                */
	if( key->type == SDL_KEYDOWN ){
		/* If the Unicode value is less than 0x80 then the    */
		/* unicode value can be used to get a printable       */
		/* representation of the key, using (char)unicode.    */
		printf(", Unicode: " );
		if( key->keysym.unicode < 0x80 && key->keysym.unicode > 0 ){
			printf( "%c (0x%04X)", (char)key->keysym.unicode,
					key->keysym.unicode );
		}
		else{
			printf( "? (0x%04X)", key->keysym.unicode );
		}
	}
	printf( "\n" );
	/* Print modifier info */
	PrintModifiers( key->keysym.mod );
}

/* Print modifier info */
void PrintModifiers( SDLMod mod ){
	printf( "Modifers: " );

	/* If there are none then say so and return */
	if( mod == KMOD_NONE ){
		printf( "None\n" );
		return;
	}

	/* Check for the presence of each SDLMod value */
	/* This looks messy, but there really isn't    */
	/* a clearer way.                              */
	if( mod & KMOD_NUM ) printf( "NUMLOCK " );
	if( mod & KMOD_CAPS ) printf( "CAPSLOCK " );
	if( mod & KMOD_LCTRL ) printf( "LCTRL " );
	if( mod & KMOD_RCTRL ) printf( "RCTRL " );
	if( mod & KMOD_RSHIFT ) printf( "RSHIFT " );
	if( mod & KMOD_LSHIFT ) printf( "LSHIFT " );
	if( mod & KMOD_RALT ) printf( "RALT " );
	if( mod & KMOD_LALT ) printf( "LALT " );
	if( mod & KMOD_CTRL ) printf( "CTRL " );
	if( mod & KMOD_SHIFT ) printf( "SHIFT " );
	if( mod & KMOD_ALT ) printf( "ALT " );
	printf( "\n" );
}