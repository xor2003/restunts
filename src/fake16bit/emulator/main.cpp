#include <cassert>
#include <cstdio>
#include <cstring>
#include <windows.h>
#include <iostream>

#include "types.hpp"
#include "emulator.hpp"
#include "on_access.hpp"
#include "emulator_test.hpp"

#include "tools.hpp"

void check_type_size()
{
	assert( sizeof( byte_t ) == 1 );
	assert( sizeof( word_t ) == 2 );
	assert( sizeof( dword_t ) == 4 );
}

bool is_in_range( int p_start, int p_size, int p_value )
{
	return ( ( p_value >= p_start ) && ( p_value <= ( p_start + p_size ) ) );
}

int linear_offset( int p_seg, int p_ofs )
{
	return p_seg * 0x10 + p_ofs;
}

void linear_offset_to_seg_ofs( int p_offset, int& p_seg, int& p_ofs )
{
	p_ofs = ( p_offset % 0x10 );
	p_seg = ( p_offset / 0x10 );
}

class my_on_access_t: public on_access_t
{
public:
	my_on_access_t():on_access_t()
	{
	}

	void on_write_byte( const word_t p_seg, const word_t p_ofs, const byte_t p_value )
	{
		int offset = linear_offset( p_seg, p_ofs );
		
		//some consts examples
		const int MCGA_MAX_X = 320;
		const int MCGA_MAX_Y = 200;
		const int MCGA_START_SEG = 0xA000;
		const int MCGA_RAM_SIZE = MCGA_MAX_X*MCGA_MAX_Y;
		const int MCGA_START_OFFSET = linear_offset( MCGA_START_SEG, 0 );

		if( is_in_range( MCGA_START_OFFSET, MCGA_RAM_SIZE, offset) )
		{
			//MCGA[x,y]=color --> 0xA0000 + ( y * 200 ) + x

			int relative = offset - MCGA_START_OFFSET;
			int x = relative % MCGA_MAX_Y;
			int y = relative / MCGA_MAX_Y;

			printf("setpixel(x=%d,y=%d,color-nr=%d)\n", x, y, p_value );
		}
		int brk = 1;
	}

	//could be usefull
	//void on_write_byte_block (if rep movsb or something is used for pixel-writing

	void on_int( const byte_t p_nr )
	{
		//if( p_nr == DOS_API )
		//	if( m_emulator.AH == DOS_FILE_OPEN )
		//     dos_file_open();...
		//if( p_nr == BIOS_KEYBOARD_API )
		//...
	}
};

int main()
{
	//physical memory
	const int MEM_SIZE = 1000000;
	pbyte_t memory = new byte_t[MEM_SIZE];
	::memset( memory, 0xAA, MEM_SIZE );

	//dos_memory_manager_t dos_memory_manager( memory, START, SIZE )
	//dos_file_manager_t dos_file_manager;
	my_on_access_t my_on_access; // ( memory, SDL, dos_memory_manager, dos_file_manager )

	emulator_t e( memory, my_on_access );

	e.MOVb( 0, 0 , 0xBB );
	e.MOVb( 1, 0 , 0xCC );
	e.MOVb( 1, 1 , 0xDD );
	e.MOVb( 0, 18 , 0xEE );
	e.MOVb( 1, 3 , 0xFF );
	e.MOVb( 0xa07e, 4, 0x10 ); // y=10,x=20
	e.MOVb( 0xa19d, 4, 0x10 ); // y=33,x=12
	e.MOVb( 0xa0c8, 5, 0x10 ); // y=16,x=5
	e.MOVb( 0xa0c9, 1, 0x10 ); // y=16,x=17

	int seg = 0; 
	int ofs = 0;
	linear_offset_to_seg_ofs( 0xA0000+16*200+17, seg, ofs ); 

	for( int i = 0; i < 100; ++i )
	{
		printf("%x ", memory[i] );
	}

	//emulator_test_t et( e );
	//et.test();

	//e.MOVb( e.DS, e.BX, 0x00 );

	//some "unit" tests

	e.AL = -127;
	e.CBW();
	short sAX = e.AX;
	assert( sAX == -127 );

	e.AX = 0x1;
	e.ROL( e.AX, 2 );
	assert( e.AX == 4 );

	e.AX = 20;
	e.BX = 10;
	e.CMP( e.AX, e.BX );
	bool jg = e.JG();
	bool jz = e.JZ();
	bool jl = e.JL();
	bool jle = e.JLE();

	e.AX = 0x1234;
	e.BX = 0x4321;
	e.AND( e.AX, e.BX );
	assert( word_t( 0x1234 & 0x4321 ) == e.AX );

	e.AX = 0x1234;
	e.BX = 0x4321;
	e.XOR( e.AX, e.BX );
	assert( word_t( 0x1234 ^ 0x4321 ) == e.AX );

	e.AX = 0x1234;
	e.BX = 0x4321;
	e.XCHG( e.AX, e.BX );
	assert( e.AX == 0x4321 && e.BX == 0x1234 );

	e.AL = 0x12;
	e.BL = 0x43;
	e.XCHG( e.AL, e.BL );
	assert( e.AL == 0x43 && e.BL == 0x12 );

	e.AH = 10;
	e.SUB( e.AH, 20 );
	assert( e.AH == byte_t( 10 - 20) );
	char ah = e.AH;

	e.AX = 1000;
	e.SUB( e.AX, 20 );
	assert( e.AX == word_t( 1000 - 20) );
	short ax = e.AX;

	e.AX = 1000;
	e.ADD( e.AX, 0xfffb ); // e.AX + word_t(-5)
	assert( e.AX == word_t( 1000 - 5 ) );

	e.AX = 6400;
	e.BX = 100;
	e.MUL( e.BX );
	assert( e.DXAX == dword_t( 6400 * 100 ) );
	dword_t valyyy = e.DXAX;

	e.AX = 6400;
	e.BX = 100;
	e.IMUL( e.BX );
	assert( e.DXAX == dword_t( 6400 * 100 ) );
	dword_t valxxx = e.DXAX;

	e.AH = 10;
	e.ADD( e.AH, 20 );
	assert( e.AH == byte_t( 10 + 20) );

	e.AX = 1000;
	e.ADD( e.AX, 20 );
	assert( e.AX == word_t( 1000 + 20) );

	e.AX = 101;
	e.IDIV( byte_t( 10 ) );
	byte_t xah = e.AH;
	byte_t xal = e.AL;
	assert( byte_t( 101 % 10 ) == xah );
	assert( byte_t( 101 / 10 ) == xal );
	int brk = 1;

	e.DXAX = 10001;
	e.IDIV( word_t( 1000 ) );
	word_t xdx = e.DX;
	word_t xax = e.AX;
	assert( word_t( 10001 % 1000 ) == xdx );
	assert( word_t( 10001 / 1000 ) == xax );
	int brk5 = 1;

	return 0;
}