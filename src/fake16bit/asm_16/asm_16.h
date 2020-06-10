#ifndef ASM_16_H_INCLUDE
#define ASM_16_H_INCLUDE

const int DOS_SEG = 0x60;
const int MCGA_SEG = 0xa000;
const int MEMORY_SIZE = 0x100000; // 2^20
const int PARAGRAPH_SIZE = 0x10;

const int DOS_API = 0x21;

const int DOS_FUNCTION_MEM_ALLOC = 0x48;
const int DOS_FUNCTION_MEM_FREE = 0x49;
const int DOS_FUNCTION_MEM_REALLOC = 0x4a;

//TODO
const int DOS_FUNCTION_FILE_CREATE = 0x3c; // http://stanislavs.org/helppc/int_21-3c.html
const int DOS_FUNCTION_FILE_OPEN = 0x3d; // http://stanislavs.org/helppc/int_21-3d.html
const int DOS_FUNCTION_FILE_CLOSE = 0x3e; // http://stanislavs.org/helppc/int_21-3e.html
const int DOS_FUNCTION_FILE_READ = 0x3f; // http://stanislavs.org/helppc/int_21-3f.html
const int DOS_FUNCTION_FILE_WRITE = 0x40; // http://stanislavs.org/helppc/int_21-40.html
const int DOS_FUNCTION_FILE_SEEK = 0x42; // http://stanislavs.org/helppc/int_21-42.html
const int DOS_FUNCTION_FILE_UNLINK = 0x41; // http://stanislavs.org/helppc/int_21-41.html
//
//const int DOS_FUNCTION_SET_DTA = 0x1a; // http://stanislavs.org/helppc/int_21-1a.html
//const int DOS_FUNCTION_FILE_FIND = 0x4e; // http://stanislavs.org/helppc/int_21-4e.html
//const int DOS_FUNCTION_FILE_FIND_NEXT = 0x4f; // http://stanislavs.org/helppc/int_21-4f.html

//from dosbox
#define DOSERR_NONE 0
#define DOSERR_FUNCTION_NUMBER_INVALID 1
#define DOSERR_FILE_NOT_FOUND 2
#define DOSERR_PATH_NOT_FOUND 3
#define DOSERR_TOO_MANY_OPEN_FILES 4
#define DOSERR_ACCESS_DENIED 5
#define DOSERR_INVALID_HANDLE 6
#define DOSERR_MCB_DESTROYED 7
#define DOSERR_INSUFFICIENT_MEMORY 8
#define DOSERR_MB_ADDRESS_INVALID 9
#define DOSERR_ENVIRONMENT_INVALID 10
#define DOSERR_FORMAT_INVALID 11
#define DOSERR_ACCESS_CODE_INVALID 12
#define DOSERR_DATA_INVALID 13
#define DOSERR_RESERVED 14
#define DOSERR_FIXUP_OVERFLOW 14
#define DOSERR_INVALID_DRIVE 15
#define DOSERR_REMOVE_CURRENT_DIRECTORY 16
#define DOSERR_NOT_SAME_DEVICE 17
#define DOSERR_NO_MORE_FILES 18
#define DOSERR_FILE_ALREADY_EXISTS 80

/*
we need a memory access object for better readability

class ptr<ValueType>
{
  ValueType& operator =( )
  ...
  ...
}

ptr<byte_t> byte;

byte(seg,ofs)=0x200
al=byte(seg,ofs);

al=byte_ds(ofs);
al=ptr<vector_t>( ds, bx );

ptr<vector_t>(ds,bx).x = 102;

vector_t& vec = ptr<vector_t>(ds,bx);

vec.x = 102;
*/

/*
struct file_info_t

typedef std::vector<file_info> found_files_t;

found_files_t g_found_files;
size_t g_last_found_file = 0;

int find_file( ... )
{
  found_files_t tmp;

  find files ... tmp.push( file_info );

  g_last_found_file = 0;
  g_found_files = tmp; // overrides global "found files list" (we need only one for stunts)
  
  return 2 (DOSERR_FILE_NOT_FOUND) /18

  return g_last_found_file++;
}

int find_file_next
{
  if( g_last_found_file < g_found_files.size() )
    return g_last_found_file++;

  else
    error return 18 (DOSERR_NO_MORE_FILES)
}
*/

const int NOT_ENOUGH_MEMORY = 0x08;
const int INVALID_MEMORY_BLOCK_ADDRESS = 0x09;

const int BIOS_VIDEO_API = 0x10;
const int BIOS_KEYBOARD_API = 0x16;

#ifdef ASM_16_EXPORTS
#   define ASM_16_API __declspec(dllexport)
#else
#   define ASM_16_API __declspec(dllimport)
#endif

typedef unsigned char byte;
typedef unsigned short word;
typedef unsigned int dword;

struct _WORDREGS 
{        
	word ax;
	word bx;
	word cx;
	word dx;
};

struct _BYTEREGS 
{        
	byte al, ah;
	byte bl, bh;
	byte cl, ch;
	byte dl, dh;
};

union _REGS 
{             
	_WORDREGS x;     
	_BYTEREGS h;     
	word si;
	word di;
	word cs;
	word es;
	word ds;
	word ss;
	word sp;
	word cflag;
};

typedef struct global_struct_s
{
    word ax;
	word bx;
	word cx;
	word dx;

	word cs;
	word ds;
	word ss;
	word es;

	word di;
	word si;

	word ip;
	word sp;
	word bp;

    void* memory;

	// TODO
	byte cf;
	byte ah;
	byte al;

	word flags;

} global_struct_t;

//!!! multiple STACK problems!!!!
//beware of call stack "corruptions"
//when we interchange the game-fake-stack and the real-stack for function calling
//maybe there is something like an CALL_FRAME(); macro in each function need to 
//bring the fake-stack to the right position

//what about global out/inside-function gotos??? i hope there are just a few

#ifdef __cplusplus
extern "C" {
#endif

// tools
ASM_16_API int linear_offset( int p_segment, int p_offset );

// memory access
ASM_16_API void* ptrl( int p_linear_offset );
ASM_16_API void* ptr( int p_segment, int p_offset );
ASM_16_API byte* bptr( int p_segment, int p_offset );
ASM_16_API word* wptr( int p_segment, int p_offset );
ASM_16_API dword* dptr( int p_segment, int p_offset );

//mulb --> ax, mulw --> dx:ax
//dword value = rdxax(); (dx:ax)
//wdxax( value ) --> dx:ax

// stack access
ASM_16_API void pushb( byte p_value );
ASM_16_API void pushw( word p_value );
ASM_16_API void pushd( dword p_value );

ASM_16_API byte popb();
ASM_16_API word popw();
ASM_16_API dword popd();

// inline assembler based mnemonics
// to reduce the work needed: we use direct asm in the first shot :)
// first shot/test

ASM_16_API void cmpb( byte p_op1, byte p_op2 );
ASM_16_API void cmpw( word p_op1, word p_op2 );

ASM_16_API bool jc();
ASM_16_API bool jg();

//example:
//can easy replace with "p_op1 -= p_op2" if flags don't play a role
//or with an "emulation" - but we can check when everything is running
ASM_16_API void subw( word& p_op1, word p_op2 );
ASM_16_API void subb( byte& p_op1, byte p_op2 );

ASM_16_API void imulb( byte p_op );
ASM_16_API void imulw( word p_op );

ASM_16_API void rolw( word& p_op1, byte p_op2 ); // rolw( regs.dx, regs.cl );
ASM_16_API void rolb( byte& p_op1, byte p_op2 ); // rolb( *byte_23dd, regs.cl );

ASM_16_API void outb( int p_port, byte p_value );
ASM_16_API void inb( int p_port, byte& p_value );

ASM_16_API void intcall( int p_nr ); // 10h, 16h, 21h

ASM_16_API void doscall(); // 21h

ASM_16_API void initialize( void );

// globals
ASM_16_API global_struct_t* get_global( void );

//http://siyobik.info/index.php?module=x86&id=306
//http://unixwiz.net/techtips/x86-jumps.html
//http://ref.x86asm.net/coder32.html
//http://www.strchr.com/machine_code_redundancy

//for segment override (0x26) or other prefixes
//http://code.google.com/p/distorm/wiki/x86_x64_Machine_Code 

/*
 - Lock and Repeat:
 	- 0xF0 — LOCK
 	- 0xF2 — REPNE/REPNZ - do we need
 	- 0xF3 - REP/REPE/REPZ - do we need
 - Segment Override:
 	- 0x2E - CS - do we need
 	- 0x36 - SS - do we need
 	- 0x3E - DS - do we need
 	- 0x26 - ES - do we need
 	- 0x64 - FS
 	- 0x65 - GS
 - Operand-Size Override: 0x66, switching to non-default size.
 - Address-Size Override: 0x67, switching to non-default size.
*/

/*
    [lahf] => 1 http://www.fermi.mn.it/linux/quarta/x86/lahf.htm
    [jno] => 1
    [pushf] => 1 http://www.fermi.mn.it/linux/quarta/x86/pushf.htm // void pushf(){ pushw( flags ); }
    [xlat] => 1 http://www.fermi.mn.it/linux/quarta/x86/xlat.htm
    [nop] => 1 // void nop(){}
    [std] => 2 // void std(){ flags.df = 1; }
    [sahf] => 2
    [cmps] => 3
    [iret] => 3 // return;
    [clc] => 5 // void clc(){ flags.cf = 0; }
    [js] => 5  // bool js(){ return flags.sf == 1; }
    [jcxz] => 7
    [jo] => 7 // bool jo(){ return flags.of == 1; }
    [stc] => 8 // void std(){ flags.cf = 1; }
    [lds] => 8
    [jns] => 10 // bool jns(){ return !js() }
    [rol] => 10
    [cli] => 15 // void cli(){}
    [not] => 17
    [sti] => 18 // void sti(){}
    [in] => 19
    [retn] => 27 // return;
    [scas] => 28 // repne_scasb(){ cx,... }
    [out] => 30
    [idiv] => 36
    [div] => 46
    [sbb] => 47
    [cld] => 54 // void cld(){ flags.df = 0; }
    [ja] => 56 // bool ja(){ return ( ( flags.cf == 0 ) && ( flags.zf == 0 ) ); }
    [mul] => 60
    [rcl] => 69
    [lods] => 71 http://www.fermi.mn.it/linux/quarta/x86/lods.htm
    [int] => 75 void int(){ MAPPING }
    [xchg] => 77 ... sample opcode: 0x95 -> 0x90 + r
    [jbe] => 81 bool jbe(){ return ( ( flags.cf == 1 ) || ( flags.zf == 1 ) ); }
    [stos] => 101
    [jnb] => 119
    [loop] => 133
    [jb] => 144 bool jb(){ return flags.cf == 1; }
    [imul] => 145
    [and] => 159
    [adc] => 160
    [shr] => 161
    [rcr] => 171
    [test] => 201
    [neg] => 228
    [sar] => 233
    [jg] => 245
    [cwd] => 294 void cwd(){ set_dxax( ax ); }
    [xor] => 318
    [jl] => 360
    [jge] => 360
    [movs] => 396
    [jle] => 399
    [les] => 411
    [dec] => 478
    [or] => 625
    [cbw] => 676 // void cbw(){ regs.ax = regs.al; } (no eax in use)
    [lea] => 678
    [retf] => 691
    [inc] => 827
    [jnz] => 1413
    [jz] => 1527
    [shl] => 1539 ... shlw cl,r/m16 --> shl cl,ax --> shl_r16(cl,ax);
    [pop] => 1796
    [sub] => 2331
    [jmp] => 2653
    [call] => 3066
    [cmp] => 3461
    [add] => 4836
    [push] => 9437
    [mov] => 20408

	cmp ax,0
	ja lableX
	ret

	cmp(ax,0);
	if(ja()) goto lableX;
	return;
*/

#ifdef __cplusplus
}
#endif


#endif // ASM_16_H_INCLUDE
