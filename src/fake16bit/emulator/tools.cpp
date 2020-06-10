#include "tools.hpp"

#include <cassert>
#include <cstdio>

static bool is_uint16( int p_value )
{
	return ( p_value >= 0 && p_value <= 0xFFFF );
}

static bool is_valid_address( int p_seg, int p_ofs )
{
	return ( is_uint16( p_seg ) && is_uint16( p_ofs ) );
}

static bool is_uint20( int p_value )
{
	return ( p_value >= 0 && p_value <= 0xFFFFF );
}

static int get_absolute_address( int p_seg, int p_ofs )
{
	int abs = p_seg * 0x10 + p_ofs;

	assert( is_uint20( abs ) );

	return abs;
}

void print_seg_ofs_info( int p_seg, int p_ofs, int p_distance )
{
	assert( is_valid_address( p_seg, p_ofs ) );

	bool normalized = ( p_ofs == 0 );

	printf("begin\n");

	printf("  original: %X:%X\n", p_seg, p_ofs );

	int abs = get_absolute_address( p_seg, p_ofs );
	printf("  absolute: %X\n", abs );

	int rest = ( abs % 0x10 );
	int seg = abs / 0x10;

	if( !normalized )
	{
		if( rest == 0 )
		{
			printf("  normalized: %X:0\n", seg );
		}
		else
		{
			printf("  biggest seg: %X:%X\n", seg, rest );
		}
	}

	if( p_distance != 0 )
	{
		if( p_distance < 0 )
		{
			printf("end (distance = -%X)\n", -p_distance );
		}
		else
		{
			printf("end (distance = %X)\n", p_distance );
		}

		int new_abs = abs + p_distance;
		is_uint20( new_abs );

		printf("  absolute: %X\n", new_abs );

		int new_ofs = p_ofs + p_distance;
		if( is_uint16( new_ofs ) )
		{
			printf("  without seg change: %X:%X\n", p_seg, new_ofs );
		}

		int new_rest = ( new_abs % 0x10 );
		int new_seg = ( new_abs / 0x10 );

		if( new_rest == 0 )
		{
			printf("  normalized: %X:0\n", new_seg );
		}
		else
		{
			printf("  biggest seg: %X:%X\n", new_seg, new_rest );
		}
	}
}
