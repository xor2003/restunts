#include <asm_16/asm_16.h>

#include <iostream>
#include <string>

#include <cassert>
#include <list>

/*
the backend:
-is(should be) an "release" mode dll - to gain max. speed for stuff that is always the same
-holds the "memory" which is used as an 1MB dos lower memory fake (all seg:ofs accesses are directed into this one)
-a stack that also uses the 1MB fake

missing (im working on that)
-dos file access
-some keyboard, video bios functions
-redirect port access
-(will) load the game.exe into the 1MB fake - so there is inital no need for faking the data-content - you just use the linear ida offset to access the variable
-some asm commands like jnz(), jmp, call etc.

[transform]

proc sub_1234
  mov dx,seg31
  mov ds,dx
  mov [word ptr ds:bx+10],23
  mov ax,[ds:bx+20]
  mov ax,0
  mov bx,10
  mov [word123],10
  cmp ax,0
  mul bx
  mul bh
  jnz lableX
  mov ax,bx
lableX:
  call sub_4321
  ret
endp

[into]

word* word123 = (word*)ptrl( linear-ida-offset );

void sub_1234()
{
  DX = seg31;
  x = DS;
  wptr(DS,BX+10)=23;
  AX = wptr(DS,BX+20);
  AX = 10;
  word123 = 10;
  CMP(ax,0);
  MUL(BX); // dx:ax = ax * bx --> dxax() = ax * bx; set flags???
  MUL(BH); // ax = al * bh; --> ax() = al() * bh(); set flags???
  if(JNZ()) goto lableX;
  AX = BX;
lableX:
  sub_4321();
  return;
}

benefit?

you can mix 16bit asm semantic with 32bit C/C++ code :)

mul bl                          ;8-Bit-Multiplication, Result in BX
mul [MyWord]                    ;16-Bit-Multiplication, Result in DX:AX
mul edx                         ;32-Bit-Multiplication, Result in EDX:EAX

*/

byte memory[0x100000];
byte* global_test = memory;

byte& wptr( int offset )
{
	return global_test[offset];
}

void INT( const byte& p_nr )
{
}

/*
we SHOULD always use AX and DX in calcutation...not AX,BX...
*/

int main( int argc, char* argv[] )
{
	INT(0x21);

	word flagss;
	_asm
	{
		pushf
		pop bx
		mov flagss,bx
	}

	memory[0]=23;

	byte& p0 = wptr( 0 );
	byte& r0 = memory[0];

	byte* p1 = &wptr( 0 );
	byte* r2 = &memory[0];

	//cmp( ds_b( 0 ), 0 ); // cmp byte ptr ds:[0],0h
	//ds_w(10)=0x200; // mov_w( ds_w(10), 0x200 ); // mov word ptr ds:[10],200h

	//g_line for debugging - find for example vga mem access -> which line is responsible?

	//g_line=__LINE__; ds_w(10)=0x200;         
	//g_line=__LINE__; ds_w(20)=0x200;         
	//g_line=__LINE__; ds_w(30)=0x200;         
	//g_line=__LINE__; cmp( ds_b( 0 ), 0 );
	//g_line=__LINE__; mov_w( ds_w(10), 0x200 );
	//ax = 0x200;
	//mw( word* ptr, word p_value ) ---> mw( ds_w( 10 ), 0x1020 );

	//wm( seg, offs ) set/get
	//bm( seg, offs ) set/get

	//static about read/write memory/data access...

	/*
	wmw( word* p_ptr, word p_value )
	{
		if( in_vga_mem( p_ptr ) )
		{
			//set 2. pixel with color p_value.lo and p_value.hi
		}
       *p_ptr = p_value;
	}

	// there is no need for an read routine because we use the fake vga mem (its in the right state)
	rmw( word& p_value, word* p_ptr )
	{
        *p_ptr = p_value;
	}
	*/
	
	//for statistics or dead code detection
	//g_used[__LINE__]++; g_line=__LINE__; mov_w( ds_w(10), 0x200 );

	//g_used ~700kb in size one unsigned dword for each asm-code line

	//before program end print g_used to file to see which code is used in run

	/*
	void* lptr()
	{
	  if( in_vga_mem( ptr ) )
	  {
	    fprintf( f, "access to vga in line: %d\n", g_line );
	  }

	  if( in_textmode_mem( ptr ) )
	  {
	    fprintf( f, "access to textmode in line: %d\n", g_line );
	  }
    }
	*/

	assert( p1 == r2 );

	initialize();

	global_struct_t& x = *get_global();

	_REGS regs;
	//for easy access
	word& ax = regs.x.ax;
	byte& ah = regs.h.ah;
	byte& al = regs.h.al;
	word& flags = regs.cflag;

	ax = 0xAAFF;
	byte aa = ah;
	byte ff = al;

	// how to sign extend from byte to word?
	char sdx = -5;

	byte xs = -5;
	int xss = xs;
	word sd = (short)(int)xs;
	word sdd = -5;
	short xyy = (short)sdd;

	__asm
	{
		mov al,xs
		cbw // AX = SignExtend(AL);
		mov sd,ax

		mov bx,100
		mov al,0xfb
		cbw
		add bx,0xfffb

		mov sd,bx
	}

	short xxxx = 0xfffb; // -5

	ax = 100;
	subw( ax, 5 );

	ax = 100;
	subw( ax, 20 ); // ax -= 20;
		
	x.ax = 100;
	subw( x.ax, 20 );

	x.bx = 1;
	x.ah = DOS_FUNCTION_MEM_ALLOC;
	intcall(DOS_API);
	if( !x.cf )
	{
		int seg = x.ax;
		word* yyy = wptr( seg, 0 );

		*yyy=100;
		subw( *yyy, 20 );
		assert( *yyy == 80 );

		int ddd=1;

		x.ah = DOS_FUNCTION_MEM_FREE;
		x.es = seg;
		intcall(DOS_API);
		assert( x.cf == 0 );
	}

	//dos mem test

	x.bx = 0xFFFF;
	x.ah = DOS_FUNCTION_MEM_ALLOC;
	intcall(DOS_API);

	if( x.cf && x.ax == NOT_ENOUGH_MEMORY )
	{
		x.ah = DOS_FUNCTION_MEM_ALLOC;
		intcall(DOS_API);

		int seg = x.ax;

		x.es = seg;
		x.bx = 100;
		x.ah = DOS_FUNCTION_MEM_REALLOC;
		intcall(DOS_API);

		int brk = 1;

		x.ah = DOS_FUNCTION_MEM_ALLOC;
		x.bx = 100;
		intcall(DOS_API);

		int seg2 = x.ax;

		x.es = seg;
		x.bx = 0xFFFF;
		x.ah = DOS_FUNCTION_MEM_REALLOC;
		intcall(DOS_API);

		brk = 1;

		x.ah = DOS_FUNCTION_MEM_FREE;
		x.es = seg;
		intcall(DOS_API);

		brk = 1;

		x.ah = DOS_FUNCTION_MEM_FREE;
		x.es = seg;
		intcall(DOS_API);

		brk = 1;
	}

	int brk = 1;

	return 0;

/*
be as syntax near as possible, and fake the complete 16bit semanic
everything in upper-case + _ in front to show how evil this code is and how fast it needs to be replaced :)
*/

}