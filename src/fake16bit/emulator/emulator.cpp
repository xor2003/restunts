#include "emulator.hpp"

#include <cassert>

emulator_t::emulator_t( pbyte_t p_memory, on_access_t& p_on_access ):
	AX(m_regs.word.ax),
	AH(m_regs.byte.ah),
	AL(m_regs.byte.al),
	BX(m_regs.word.bx),
	BH(m_regs.byte.bh),
	BL(m_regs.byte.bl),
	CX(m_regs.word.cx),
	CH(m_regs.byte.ch),
	CL(m_regs.byte.cl),
	DX(m_regs.word.dx),
	DH(m_regs.byte.dh),
	DL(m_regs.byte.dl),
	CS(m_cs),
	ES(m_es),
	DS(m_ds),
	SS(m_ss),
	SI(m_si),
	DI(m_di),
	SP(m_sp),
	FLAGS(m_flags),
	DXAX(m_regs.word.dx,m_regs.word.ax),
	AXDX(m_regs.word.ax,m_regs.word.dx),
	m_memory( p_memory ),
	m_on_access( p_on_access )
{
	AX = 0;
	BX = 0;
	CX = 0;
	DX = 0;
	CS = 0;
	ES = 0;
	DS = 0;
	SS = 0;
	SI = 0;
	DI = 0;
	SP = 0;
	FLAGS = 0;

	m_on_access.set_emulator( this );
}

#define _FLAGS_PROLOG(FLAGS) __asm\
{\
	__asm pushf \
	\
	__asm mov bx,FLAGS \
	__asm push bx \
	__asm popf \
}

#define _FLAGS_EPILOG(FLAGS) __asm\
{\
	__asm pushf \
	__asm pop bx \
	__asm mov FLAGS,bx \
	\
	__asm popf \
}


void emulator_t::SUB( byte_t& p_op1, const byte_t p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		sub al,dl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::SUB( word_t& p_op1, const word_t p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		sub ax,dx

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

//AX = AL * p_op / flag changes
void emulator_t::MUL( const byte_t p_op )
{
	word_t flags = FLAGS;
	byte_t al_in = AL;
	word_t ax_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,al_in
		mov dl,p_op
		mul dl

		mov ax_out,ax

		_FLAGS_EPILOG(flags)
	}
	AX = ax_out;
	FLAGS = flags;
}

//DX:AX = AX * p_op / flag changes
void emulator_t::MUL( const word_t p_op )
{
	word_t flags = FLAGS;
	word_t ax_in = AX;
	word_t ax_out = 0;
	word_t dx_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov ax,ax_in
		mov dx,p_op
		mul dx

		mov ax_out,ax
		mov dx_out,dx

		_FLAGS_EPILOG(flags)
	}
	AX = ax_out;
	DX = dx_out;
	FLAGS = flags;
}

void emulator_t::MULw( const word_t p_op )
{
	MUL( p_op );
}

//AX = AL * p_op / flag changes
void emulator_t::IMUL( const byte_t p_op )
{
	word_t flags = FLAGS;
	byte_t al_in = AL;
	word_t ax_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)
		
		mov al,al_in
		mov dl,p_op
		imul dl

		mov ax_out,ax

		_FLAGS_EPILOG(flags)
	}
	AX = ax_out;
	FLAGS = flags;
}

//DX:AX = AX * p_op / flag changes
void emulator_t::IMUL( const word_t p_op )
{
	word_t flags = FLAGS;
	word_t ax_in = AX;
	word_t ax_out = 0;
	word_t dx_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,ax_in
		mov dx,p_op
		mul dx

		mov ax_out,ax
		mov dx_out,dx
		
		_FLAGS_EPILOG(flags)
	}
	AX = ax_out;
	DX = dx_out;
	FLAGS = flags;
}

void emulator_t::ADD( byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		add al,dl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::ADD( word_t& p_op1, const word_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		add ax,dx

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::AND( byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		and al,dl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::AND( word_t& p_op1, const word_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		and ax,dx

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::SHL( byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov cl,op2
		shl al,cl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::SHL( word_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov cl,op2
		shl ax,cl

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::MOVb( const word_t p_seg, const word_t p_ofs, const byte_t p_value )
{
	write_byte( p_seg, p_ofs, p_value );
}

void emulator_t::MOVw( const word_t p_seg, const word_t p_ofs, const word_t p_value )
{
	write_word( p_seg, p_ofs, p_value );
}

dword_t emulator_t::linear_offset( const word_t p_seg, const word_t p_ofs ) const
{
	return ( p_seg * 0x10 + p_ofs );
}

void* emulator_t::ptr( const word_t p_seg, const word_t p_ofs ) const
{
	dword_t offset = linear_offset( p_seg, p_ofs );
	return m_memory + offset;
}

void emulator_t::write_byte( const word_t p_seg, const word_t p_ofs, const byte_t p_value ) const
{
	pbyte_t pbyte = (pbyte_t)ptr( p_seg, p_ofs );
	*pbyte = p_value;

	m_on_access.on_write_byte( p_seg, p_ofs, p_value );
}

void emulator_t::write_word( const word_t p_seg, const word_t p_ofs, const word_t p_value ) const
{
	pword_t pword = (pword_t)ptr( p_seg, p_ofs );
	*pword = p_value;

	m_on_access.on_write_word( p_seg, p_ofs, p_value );
}

void emulator_t::write_dword( const word_t p_seg, const word_t p_ofs, const dword_t p_value ) const
{
	pdword_t pdword = (pdword_t)ptr( p_seg, p_ofs );
	*pdword = p_value;

	m_on_access.on_write_dword( p_seg, p_ofs, p_value );
}

void emulator_t::read_byte( const word_t p_seg, const word_t p_ofs, byte_t& p_value ) const
{
	pbyte_t pbyte = (pbyte_t)ptr( p_seg, p_ofs );
	p_value = *pbyte;

	m_on_access.on_read_byte( p_seg, p_ofs, p_value );
}

void emulator_t::read_word( const word_t p_seg, const word_t p_ofs, word_t& p_value ) const
{
	pword_t pword = (pword_t)ptr( p_seg, p_ofs );
	p_value = *pword;

	m_on_access.on_read_word( p_seg, p_ofs, p_value );
}

void emulator_t::read_dword( const word_t p_seg, const word_t p_ofs, dword_t& p_value ) const
{
	pdword_t pdword = (pdword_t)ptr( p_seg, p_ofs );
	p_value = *pdword;

	m_on_access.on_read_dword( p_seg, p_ofs, p_value );
}

void emulator_t::advance_with_DF( word_t& p_index_reg, const byte_t p_size )
{
	const flags_t& flags = *(flags_t*)FLAGS;

	if( flags.DF )
	{
		p_index_reg += p_size;
	}
	else
	{
		p_index_reg -= p_size;
	}
}

void emulator_t::advance_with_DF_byte( word_t& p_index_reg )
{
	advance_with_DF( p_index_reg, sizeof(byte_t) );
}

void emulator_t::advance_with_DF_word( word_t& p_index_reg )
{
	advance_with_DF( p_index_reg, sizeof(word_t) );
}

void emulator_t::PUSH(const byte_t& p_op )
{
	write_byte( SS, SP, p_op );
	SP += sizeof(p_op);
}

void emulator_t::PUSH(const word_t& p_op )
{
	write_word( SS, SP, p_op );
	SP += sizeof(p_op);
}

void emulator_t::PUSH(const dword_t& p_op )
{
	write_dword( SS, SP, p_op );
	SP += sizeof(p_op);
}

void emulator_t::POP( byte_t& p_op )
{
	read_byte( SS, SP, p_op );
	SP += sizeof( p_op );
}

void emulator_t::POP( word_t& p_op )
{
	read_word( SS, SP, p_op );
	SP += sizeof( p_op );
}

void emulator_t::POP( dword_t& p_op )
{
	read_dword( SS, SP, p_op );
	SP += sizeof( p_op );
}

void emulator_t::OR( byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		or al,dl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::OR( word_t& p_op1, const word_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		or ax,dx

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::INC( byte_t& p_op )
{
	word_t flags = FLAGS;
	byte_t op = p_op;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op
		inc al

		mov op,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op = op;
}

void emulator_t::INC( word_t& p_op )
{
	word_t flags = FLAGS;
	word_t op = p_op;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op
		inc ax

		mov op,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op = op;
}

void emulator_t::CMP( const byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	const byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		cmp al,dl

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
}

void emulator_t::CMP( const word_t& p_op1, const word_t& p_op2 )
{
	word_t flags = FLAGS;
	const word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		cmp ax,dx

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
}

void emulator_t::IDIV( const byte_t p_op )
{
	word_t flags = FLAGS;
	byte_t op = p_op;
	word_t ax_in = AX;
	word_t ax_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov dl,op
		mov ax,ax_in
		idiv dl

		mov ax_out,ax

		_FLAGS_EPILOG(flags)
	}

	AX = ax_out;
	FLAGS = flags;
}

void emulator_t::IDIV( const word_t p_op )
{
	word_t flags = FLAGS;
	word_t op = p_op;
	word_t ax_in = AX;
	word_t dx_in = DX;
	word_t ax_out = 0;
	word_t dx_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov bx,op
		mov ax,ax_in
		mov dx,dx_in
		idiv bx

		mov ax_out,ax
		mov dx_out,dx

		_FLAGS_EPILOG(flags)
	}

	AX = ax_out;
	DX = dx_out;
	FLAGS = flags;
}

void emulator_t::DEC( byte_t& p_op )
{
	word_t flags = FLAGS;
	byte_t op = p_op;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op
		dec al

		mov op,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op = op;
}

void emulator_t::DEC( word_t& p_op )
{
	word_t flags = FLAGS;
	word_t op = p_op;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op
		dec ax

		mov op,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op = op;
}

void emulator_t::SHR( byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov cl,op2
		shr al,cl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::SHR( word_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov cl,op2
		shr ax,cl

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::DIV( const byte_t p_op )
{
	word_t flags = FLAGS;
	byte_t op = p_op;
	word_t ax_in = AX;
	word_t ax_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov dl,op
		mov ax,ax_in
		div dl

		mov ax_out,ax

		_FLAGS_EPILOG(flags)
	}

	AX = ax_out;
	FLAGS = flags;
}

void emulator_t::DIV( const word_t p_op )
{
	word_t flags = FLAGS;
	word_t op = p_op;
	word_t ax_in = AX;
	word_t dx_in = DX;
	word_t ax_out = 0;
	word_t dx_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov bx,op
		mov ax,ax_in
		mov dx,dx_in
		div bx

		mov ax_out,ax
		mov dx_out,dx

		_FLAGS_EPILOG(flags)
	}

	AX = ax_out;
	DX = dx_out;
	FLAGS = flags;
}


void emulator_t::XOR( byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		xor al,dl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::XOR( word_t& p_op1, const word_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		xor ax,dx

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::XCHG( byte_t& p_op1, byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		xchg al,dl

		mov op1,al
		mov op2,dl

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
	p_op2 = op2;
}

void emulator_t::XCHG( word_t& p_op1, word_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		xchg ax,dx

		mov op1,ax
		mov op2,dx

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
	p_op2 = op2;
}

void emulator_t::TEST( const byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	const byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		test al,dl

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
}

void emulator_t::TEST( const word_t& p_op1, const word_t& p_op2 )
{
	word_t flags = FLAGS;
	const word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		test ax,dx

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
}

void emulator_t::SBB( byte_t& p_op1, const byte_t& p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov dl,op2
		sbb al,dl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::SBB( word_t& p_op1, const word_t& p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		sbb ax,dx

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::PUSHF()
{
	PUSH( FLAGS );
}

void emulator_t::STOSB()
{
	//esi in MCGA-Area?

	byte_t op = AL;
	dword_t edi_in = (dword_t)ptr( ES, DI );
	word_t flags = FLAGS;
	dword_t edi_out = 0;
	byte_t al_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op
		mov edi,edi_in
		stosb
		mov edi_out,edi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI += ( edi_out - edi_in );

	//write_byte( ES, DI, AL );
	//advance_with_DF_byte( DI );
}

void emulator_t::STOSW()
{
	//esi in MCGA-Area?

	word_t op = AX;
	dword_t edi_in = (dword_t)ptr( ES, DI );
	word_t flags = FLAGS;
	dword_t edi_out = 0;
	byte_t al_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op
		mov edi,edi_in
		stosw
		mov edi_out,edi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI += ( edi_out - edi_in );

	//write_word( ES, DI, AX );
	//advance_with_DF_word( DI );
}

void emulator_t::REP_STOSB() // CX words at ES:[DI] with AL
{
	//esi in MCGA-Area?

	byte_t op = AL;
	dword_t edi_in = (dword_t)ptr( ES, DI );
	word_t flags = FLAGS;
	dword_t edi_out = 0;
	byte_t al_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op
		mov edi,edi_in
		stosb
		mov edi_out,edi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI += ( edi_out - edi_in );

	//for( int i = 0; i < CX; ++i )
	//{
	//	STOSB();
	//}
}

void emulator_t::REP_STOSW() // CX words at ES:[DI] with AX
{
	//esi in MCGA-Area?

	word_t op = AX;
	dword_t edi_in = (dword_t)ptr( ES, DI );
	word_t flags = FLAGS;
	dword_t edi_out = 0;
	byte_t al_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op
		mov edi,edi_in
		stosw
		mov edi_out,edi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI += ( edi_out - edi_in );

	//for( int i = 0; i < CX; ++i )
	//{
	//	STOSW();
	//}
}

bool emulator_t::JL() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jc end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JNZ() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jnz end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JZ() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jz end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JLE() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jle end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JG() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jg end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JA() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		ja end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JBE() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jbe end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JB() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jb end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JS() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		js end
		mov eax,0
end:	
		
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JNB() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jnb end
		mov eax,0
end:	
		
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JNS() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jns end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JCXZ() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jcxz end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JNO() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jno end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JO() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jo end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

bool emulator_t::JGE() const
{
	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov eax,1
		jge end
		mov eax,0
end:	
		_FLAGS_EPILOG(flags)
	}
}

void emulator_t::INb( const word_t p_port, byte_t& p_value )
{
	assert(false);
}

void emulator_t::OUTb( const word_t p_port, const byte_t p_value )
{
	assert(false);
}

//moves byte DS:[SI] to address ES:[DI]
void emulator_t::MOVSB()
{
	//edi in MCGA-Area?
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( ES, SI );
	dword_t edi_in = (dword_t)ptr( DS, DI );

	dword_t esi_out = 0;
	dword_t edi_out = 0;

	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		mov edi,edi_in
		movsb
		mov edi_out,edi
		mov esi_out,esi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI = ( edi_out - edi_in );
	SI = ( esi_out - esi_in );

	//byte_t value = 0;
	//value = read_byte( ES, SI );
	//write_byte( ES, DI, value );

	//advance_with_DF_byte( SI );
	//advance_with_DF_byte( DI );
}

void emulator_t::MOVSW()
{
	//edi in MCGA-Area?
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( ES, SI );
	dword_t edi_in = (dword_t)ptr( DS, DI );

	dword_t esi_out = 0;
	dword_t edi_out = 0;

	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		mov edi,edi_in
		movsw
		mov edi_out,edi
		mov esi_out,esi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI = ( edi_out - edi_in );
	SI = ( esi_out - esi_in );

	//word_t value = 0;
	//value = read_word( ES, SI );
	//write_word( ES, DI, value );

	//advance_with_DF_word( SI );
	//advance_with_DF_word( DI );
}

void emulator_t::REP_MOVSB()
{
	//edi in MCGA-Area?
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( ES, SI );
	dword_t edi_in = (dword_t)ptr( DS, DI );

	dword_t esi_out = 0;
	dword_t edi_out = 0;

	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		mov edi,edi_in
		rep movsb
		mov edi_out,edi
		mov esi_out,esi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI = ( edi_out - edi_in );
	SI = ( esi_out - esi_in );
}

void emulator_t::REP_MOVSW()
{
	//edi in MCGA-Area?
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( ES, SI );
	dword_t edi_in = (dword_t)ptr( DS, DI );

	dword_t esi_out = 0;
	dword_t edi_out = 0;

	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		mov edi,edi_in
		rep movsw
		mov edi_out,edi
		mov esi_out,esi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI = ( edi_out - edi_in );
	SI = ( esi_out - esi_in );
}

void emulator_t::REPNE_MOVSW()
{
	//edi in MCGA-Area?
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( ES, SI );
	dword_t edi_in = (dword_t)ptr( DS, DI );

	dword_t esi_out = 0;
	dword_t edi_out = 0;

	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		mov edi,edi_in
		repne movsw
		mov edi_out,edi
		mov esi_out,esi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI = ( edi_out - edi_in );
	SI = ( esi_out - esi_in );
}

void emulator_t::load_farptr( word_t& p_seg_reg, word_t& p_index_reg, dword_t& p_op2 )
{
	farptr_t* farptr = (farptr_t*)&p_op2;

	p_seg_reg = farptr->ptr.seg;
	p_index_reg = farptr->ptr.ofs;
}

void emulator_t::LES( word_t& p_op1, dword_t& p_op2 )
{
	load_farptr( ES, p_op1, p_op2 );
}

void emulator_t::LDS( word_t& p_op1, dword_t& p_op2 )
{
	load_farptr( DS, p_op1, p_op2 );
}

void emulator_t::LSS( word_t& p_op1, dword_t& p_op2 )
{
	load_farptr( SS, p_op1, p_op2 );
}

//DS:[SI] into AL
void emulator_t::LODSB()
{
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( ES, SI );
	word_t flags = FLAGS;
	dword_t esi_out = 0;
	byte_t al_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		lodsb
		mov esi_out,edi
		mov al_out,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	SI += ( esi_out - esi_in );
	AL = al_out;

	//AL = read_byte( ES, SI );
	//advance_with_DF_byte( SI );
}

//DS:[SI] into AX
void emulator_t::LODSW()
{
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( ES, SI );
	word_t flags = FLAGS;
	dword_t esi_out = 0;
	word_t ax_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		lodsw
		mov esi_out,edi
		mov ax_out,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	SI += ( esi_out - esi_in );
	AX = ax_out;
	
	//read_word( ES, SI, AX );
	//advance_with_DF_word( SI );
}

//AL to memory byte DS:[(E)BX + unsigned AL].
void emulator_t::XLAT()
{
	dword_t offset = BX + AL;
	read_byte( DS, offset, AL );
}

void emulator_t::CWD()
{
	word_t flags = FLAGS;
	const word_t ax_in = AX;
	word_t ax_out = 0;
	word_t dx_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov ax,ax_in
		cwd
		mov ax_out,ax
		mov dx_out,dx
		_FLAGS_EPILOG(flags)
	}

	AX = ax_out;
	DX = dx_out;
	FLAGS = flags;
}

void emulator_t::CBW()
{
	word_t flags = FLAGS;
	const byte_t al_in = AL;
	word_t ax_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)
		mov al,al_in
		cbw
		mov ax_out,ax
		_FLAGS_EPILOG(flags)
	}

	AX = ax_out;
	FLAGS = flags;
}

void emulator_t::CLI()
{
	flags_t* flags = (flags_t*)&FLAGS;
	flags->IF = false;
}

void emulator_t::STI()
{
	flags_t* flags = (flags_t*)&FLAGS;
	flags->IF = true;
}

void emulator_t::CLC()
{
	flags_t* flags = (flags_t*)&FLAGS;
	flags->CF = false;
}

void emulator_t::STC()
{
	flags_t* flags = (flags_t*)&FLAGS;
	flags->CF = true;
}

void emulator_t::CLD()
{
	flags_t* flags = (flags_t*)&FLAGS;
	flags->DF = false;
}

void emulator_t::STD()
{
	flags_t* flags = (flags_t*)&FLAGS;
	flags->DF = true;
}

void emulator_t::LEA( word_t& p_op1, dword_t& p_op2 )
{
	// is that correct
	p_op1 = p_op2;
}

void emulator_t::LAHF()
{
	word_t flags = FLAGS;
	byte_t al_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		lahf
		mov al_out,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	AL = al_out;
}

void emulator_t::SAHF()
{
	word_t flags = FLAGS;
	byte_t ah_in = AH;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ah,ah_in
		sahf

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
}

void emulator_t::NOT( byte_t& p_op )
{
	byte_t nop = ~p_op;
	p_op = nop;
}

void emulator_t::NOT( word_t& p_op )
{
	word_t nop = ~p_op;
	p_op = nop;
}

void emulator_t::ADC( word_t& p_op1, const word_t p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const word_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov dx,op2
		adc ax,dx

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::NEG( byte_t& p_op )
{
	word_t flags = FLAGS;
	byte_t op = p_op;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op
		neg al

		mov op,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op = op;
}

void emulator_t::NEG( word_t& p_op )
{
	word_t flags = FLAGS;
	word_t op = p_op;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op
		neg ax

		mov op,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op = op;
}

void emulator_t::ROL( byte_t& p_op1, const byte_t p_op2 )
{
	word_t flags = FLAGS;
	byte_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op1
		mov cl,op2
		rol al,cl

		mov op1,al

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::ROL( word_t& p_op1, const byte_t p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov cl,op2
		rol ax,cl

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::RCL( word_t& p_op1, const byte_t p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov cl,op2
		rcl ax,cl

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::RCR( word_t& p_op1, const byte_t p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov cl,op2
		rcr ax,cl

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

void emulator_t::SAR( word_t& p_op1, const byte_t p_op2 )
{
	word_t flags = FLAGS;
	word_t op1 = p_op1;
	const byte_t op2 = p_op2;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov ax,op1
		mov cl,op2
		sar ax,cl

		mov op1,ax

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	p_op1 = op1;
}

//Compares byte at address DS:[SI] with byte at address ES:[DI] and sets the status flags accordingly.
void emulator_t::CMPSB()
{
	//edi in MCGA-Area?
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( DS, SI );
	dword_t edi_in = (dword_t)ptr( ES, DI );

	dword_t esi_out = 0;
	dword_t edi_out = 0;

	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		mov edi,edi_in
		cmpsb
		mov edi_out,edi
		mov esi_out,esi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI = ( edi_out - edi_in );
	SI = ( esi_out - esi_in );
}

//REPE CMPSB Find nonmatching bytes in ES:[DI] and DS:[SI].
void emulator_t::REPE_CMPSB()
{
	//edi in MCGA-Area?
	//esi in MCGA-Area?

	dword_t esi_in = (dword_t)ptr( DS, SI );
	dword_t edi_in = (dword_t)ptr( ES, DI );

	dword_t esi_out = 0;
	dword_t edi_out = 0;

	word_t flags = FLAGS;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov esi,esi_in
		mov edi,edi_in
		repe cmpsb
		mov edi_out,edi
		mov esi_out,esi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI = ( edi_out - edi_in );
	SI = ( esi_out - esi_in );
}

//Compare AL with byte at ES:[DI] and set status flags.
void emulator_t::SCASB()
{
	//edi in MCGA-Area?

	byte_t op = AL;
	dword_t edi_in = (dword_t)ptr( ES, DI );
	word_t flags = FLAGS;
	dword_t edi_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op
		mov edi,edi_in
		scasb
		mov edi_out,edi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI += ( edi_out - edi_in );
}

//Find non-AL byte starting at ES:[DI].
void emulator_t::REPNE_SCASB()
{
	//edi in MCGA-Area?

	byte_t op = AL;
	dword_t edi_in = (dword_t)ptr( ES, DI );
	word_t flags = FLAGS;
	dword_t edi_out = 0;
	__asm
	{
		_FLAGS_PROLOG(flags)

		mov al,op
		mov edi,edi_in
		repne scasb
		mov edi_out,edi

		_FLAGS_EPILOG(flags)
	}

	FLAGS = flags;
	DI += ( edi_out - edi_in );
}