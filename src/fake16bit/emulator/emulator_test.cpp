#include "emulator_test.hpp"

#include <cassert>
#include <cstring>
#include <cstdio>
#include <iostream>

emulator_test_t::emulator_test_t( emulator_t& p_emulator ):m_emulator( p_emulator )
{
	create_test_flags( m_test_flags );
}

void emulator_test_t::test()
{
	test_sub_byte();
	test_sub_word();
}

const int BIT_MASK[16] = 
{ 
	0x00000001,0x00000002,0x00000004,0x00000008,
	0x00000010,0x00000020,0x00000040,0x00000080,
	0x00000100,0x00000200,0x00000400,0x00000800,
	0x00001000,0x00002000,0x00004000, 0x00008000
};

void emulator_test_t::create_test_flags( test_flags_t& p_test_flags )
{
	for( int i = 0; i < FLAG_TESTS; ++i )
	{
		p_test_flags[i] = 0;

		flags_t& flags = *(flags_t*)&p_test_flags[i];

		flags.CF = (( i & BIT_MASK[0] ) != 0);
		flags.PF = (( i & BIT_MASK[1] ) != 0);
		flags.AF = (( i & BIT_MASK[2] ) != 0);
		flags.ZF = (( i & BIT_MASK[3] ) != 0);
		flags.SF = (( i & BIT_MASK[4] ) != 0);
		flags.DF = (( i & BIT_MASK[5] ) != 0);
		flags.OF = (( i & BIT_MASK[6] ) != 0);
	}
}

struct flags_change_t
{
	bool CF;
	bool PF;
	bool AF;
	bool ZF;
	bool SF;
	bool TF;
	bool IF;
	bool DF;
	bool OF;
	bool IOPL;
	bool NT;
};

struct flags_change_count_t
{
	uqword_t CF;
	uqword_t PF;
	uqword_t AF;
	uqword_t ZF;
	uqword_t SF;
	uqword_t TF;
	uqword_t IF;
	uqword_t DF;
	uqword_t OF;
	uqword_t IOPL;
	uqword_t NT;
};

const word_t WITHOUT_CONTROL_FLAGS = 0xCD5; // 0000110011010101 (without NT,IOPL,IF,TF) - mask out control flags

static void get_flags_changes( const word_t& p_flags1, const word_t& p_flags2, flags_change_t& p_flags_changes ) 
{
	const word_t flags1_masked = p_flags1 & WITHOUT_CONTROL_FLAGS;
	const word_t flags2_masked = p_flags2 & WITHOUT_CONTROL_FLAGS;

	const flags_t& flags1 = *(flags_t*)&flags1_masked;
	const flags_t& flags2 = *(flags_t*)&flags2_masked;

	assert( flags1.reserved1 == flags2.reserved1 );
	assert( flags1.reserved2 == flags2.reserved2 );
	assert( flags1.reserved3 == flags2.reserved3 );
	assert( flags1.reserved4 == flags2.reserved4 );

	p_flags_changes.CF = ( flags1.CF != flags2.CF );
	p_flags_changes.PF = ( flags1.PF != flags2.PF );
	p_flags_changes.AF = ( flags1.AF != flags2.AF );
	p_flags_changes.ZF = ( flags1.AF != flags2.ZF );
	p_flags_changes.SF = ( flags1.SF != flags2.SF );
	//p_flags_changes.TF = ( flags1.TF != flags2.TF );
	//p_flags_changes.IF = ( flags1.IF != flags2.IF );
	p_flags_changes.DF = ( flags1.DF != flags2.DF );
	p_flags_changes.OF = ( flags1.OF != flags2.OF );
	//p_flags_changes.IOPL = ( flags1.IOPL != flags2.IOPL );
	//p_flags_changes.NT = ( flags1.NT != flags2.NT );
}

static void print_flags( const word_t& p_flags )
{
	printf("flag states: \n");

	const word_t flags_masked = p_flags & WITHOUT_CONTROL_FLAGS;

	const flags_t& flags = *(flags_t*)&flags_masked;

	printf("CF %d\n", flags.CF );
	printf("PF %d\n", flags.PF );
	printf("AF %d\n", flags.AF );
	printf("ZF %d\n", flags.ZF );
	printf("SF %d\n", flags.SF );
	//	printf("TF %d\n", flags.TF );
	//	printf("IF %d\n", flags.IF );
	printf("DF %d\n", flags.DF );
	printf("OF %d\n", flags.OF );
	//	printf("IOPL %d\n", flags.IOLP );
	//	printf("NT %d\n", flags.NT );
}

static void print_flags_diff( const word_t& p_flags1, const word_t& p_flags2 )
{
	printf("change in: \n");

	const word_t flags1_masked = p_flags1 & WITHOUT_CONTROL_FLAGS;
	const word_t flags2_masked = p_flags2 & WITHOUT_CONTROL_FLAGS;

	const flags_t& flags1 = *(flags_t*)&flags1_masked;
	const flags_t& flags2 = *(flags_t*)&flags2_masked;

	flags_change_t flags_changes = {0};
	get_flags_changes( p_flags1, p_flags2, flags_changes );

	if( flags_changes.CF )
	{
		printf("CF %d -> %d\n", flags1.CF, flags2.CF );
	}
	if( flags_changes.PF )
	{
		printf("PF %d -> %d\n", flags1.PF, flags2.PF );
	}
	if( flags_changes.AF )
	{
		printf("AF %d -> %d\n", flags1.AF, flags2.AF );
	}
	if( flags_changes.ZF )
	{
		printf("ZF %d -> %d\n", flags1.ZF, flags2.ZF );
	}
	if( flags_changes.SF )
	{
		printf("SF %d -> %d\n", flags1.SF, flags2.SF );
	}
	//if( flags_changes.TF )
	//{
	//	printf("TF %d -> %d\n", flags1.TF, flags2.TF );
	//}
	//if( flags_changes.IF )
	//{
	//	printf("IF %d -> %d\n", flags1.IF, flags2.IF );
	//}
	if( flags_changes.DF )
	{
		printf("DF %d -> %d\n", flags1.DF, flags2.DF );
	}
	if( flags_changes.OF )
	{
		printf("OF %d -> %d\n", flags1.OF, flags2.OF );
	}
	//if( flags_changes.IOPL )
	//{
	//	printf("IOPL %d -> %d\n", flags1.IOPL, flags2.IOPL );
	//}
	//if( flags_changes.NT )
	//{
	//	printf("NT %d -> %d\n", flags1.NT, flags2.NT );
	//}
}

void emulator_test_t::test_sub_byte()
{
	flags_change_count_t fchange_count;
	::memset( &fchange_count, 0, sizeof(fchange_count));

	int fc = 128;
	for( int i = 0; i < fc; ++i )
	{
		word_t org_flags = m_test_flags[i];
		m_emulator.FLAGS = org_flags;

		for( int op1 = 0; op1 < 255; ++op1 )
		{
			for( int op2 = 0; op2 < 255; ++op2 )
			{
				byte_t p1 = (byte_t)op1;
				byte_t p2 = (byte_t)op2;

				byte_t result = p1 - p2;

				m_emulator.SUB( p1, p2 );

				assert( p1 == result );
				
				//printf("-----\n");
				//print_flags( m_emulator.FLAGS );
				//printf("op1: %d - %d => %d\n", op1, op2, p1 );
				//print_flags_diff( org_flags, m_emulator.FLAGS ); 

				flags_change_t fchange;
				get_flags_changes( org_flags, m_emulator.FLAGS, fchange );

				if( fchange.CF ){ fchange_count.CF++; }
				if( fchange.PF ){ fchange_count.PF++; }
				if( fchange.AF ){ fchange_count.AF++; }
				if( fchange.ZF ){ fchange_count.ZF++; }
				if( fchange.SF ){ fchange_count.SF++; }
				//if( fchange.TF ){ fchange_count.TF++; }
				//if( fchange.IF ){ fchange_count.IF++; }
				if( fchange.DF ){ fchange_count.DF++; }
				if( fchange.OF ){ fchange_count.OF++; }
				//if( fchange.IOPL ){ fchange_count.IOPL++; }
				//if( fchange.NT ){ fchange_count.NT++; }
			}
		}
	}

	assert( fchange_count.CF == 4161600 );
	assert( fchange_count.PF == 4161600 );
	assert( fchange_count.AF == 4161600 );
	assert( fchange_count.ZF == 4161600 );
	assert( fchange_count.SF == 4161600 );
	assert( fchange_count.DF == 0 );
	assert( fchange_count.OF == 4161600 );

	int brk = 1;
}

void emulator_test_t::test_sub_word()
{
}

void emulator_test_t::test_mul_imul_diff_byte()
{
	for( int op1 = 0; op1 < 0xFF; ++op1 )
	{
		for( int op2 = 0; op2 < 0xFF; ++op2 )
		{
			byte_t p1 = op1;
			byte_t p2 = op2;

			m_emulator.FLAGS = 0;
			m_emulator.AL = p1;
			m_emulator.MUL( p2 );
			word_t mul_ax = m_emulator.AX;
			short signed_mul_ax = mul_ax;
			word_t mul_f = m_emulator.FLAGS;

			m_emulator.FLAGS = 0;
			m_emulator.AL = p1;
			m_emulator.IMUL( p2 );
			word_t imul_ax = m_emulator.AX;
			short signed_imul_ax = imul_ax;
			word_t imul_f = m_emulator.FLAGS;

			if( mul_ax != imul_ax )
			{
				int brk = 1;
				//signed_mul_ax != signed_imul_ax
			}

			if( mul_f != imul_f )
			{
				int brk = 1;
			}
		}
	}
}
