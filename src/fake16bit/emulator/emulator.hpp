#pragma once

#include "types.hpp"

#include "word_pair.hpp"

#include "on_access.hpp"

// something like an cpu emulator for stunts only
class emulator_t
{
public:
	emulator_t( pbyte_t p_memory, on_access_t& p_on_access );

	// registers
	word_t& AX;
	byte_t& AH;
	byte_t& AL;

	word_t& BX;
	byte_t& BH;
	byte_t& BL;

	word_t& CX;
	byte_t& CH;
	byte_t& CL;

	word_t& DX;
	byte_t& DH;
	byte_t& DL;
	
	word_t& CS;
	word_t& ES;
	word_t& DS;
	word_t& SS;
	word_t& SI;
	word_t& DI;
	word_t& SP;
	word_t& FLAGS;
	word_pair_t DXAX;
	word_pair_t AXDX;

	void SUB( byte_t& p_op1, const byte_t p_op2 );
	void SUB( word_t& p_op1, const word_t p_op2 );

	void MUL( const byte_t p_op );
	void MUL( const word_t p_op );
	void MULw( const word_t p_op );

	void IMUL( const byte_t p_op );
	void IMUL( const word_t p_op );

	void ADD( byte_t& p_op1, const byte_t& p_op2 );
	void ADD( word_t& p_op1, const word_t& p_op2 );

	void SHL( byte_t& p_op1, const byte_t& p_op2 );
	void SHL( word_t& p_op1, const byte_t& p_op2 );

	void MOVb( const word_t p_seg, const word_t p_ofs, const byte_t p_value );
	void MOVw( const word_t p_seg, const word_t p_ofs, const word_t p_value );

	void PUSH(const byte_t& p_op );
	void PUSH(const word_t& p_op );
	void PUSH(const dword_t& p_op ); // 32bit helper (not in stunts-code)

	void POP( byte_t& p_op );
	void POP( word_t& p_op );
	void POP( dword_t& p_op ); // 32bit helper (not in stunts-code)

	void OR( byte_t& p_op1, const byte_t& p_op2 );
	void OR( word_t& p_op1, const word_t& p_op2 );

	void INC( byte_t& p_op );
	void INC( word_t& p_op );

	void CMP( const byte_t& p_op1, const byte_t& p_op2 );
	void CMP( const word_t& p_op1, const word_t& p_op2 );

	void IDIV( const byte_t p_op );
	void IDIV( const word_t p_op );

	void DEC( byte_t& p_op );
	void DEC( word_t& p_op );

	void SHR( byte_t& p_op1, const byte_t& p_op2 );
	void SHR( word_t& p_op1, const byte_t& p_op2 );

	void DIV( const byte_t p_op );
	void DIV( const word_t p_op );

	void AND( byte_t& p_op1, const byte_t& p_op2 );
	void AND( word_t& p_op1, const word_t& p_op2 );

	void XOR( byte_t& p_op1, const byte_t& p_op2 );
	void XOR( word_t& p_op1, const word_t& p_op2 );
	//if needed we can introduce mem-access menomics
	//void XORpb( pbyte p_op1, const byte_t& p_op2 );

	void XCHG( byte_t& p_op1, byte_t& p_op2 );
	void XCHG( word_t& p_op1, word_t& p_op2 );

	void TEST( const byte_t& p_op1, const byte_t& p_op2 );
	void TEST( const word_t& p_op1, const word_t& p_op2 );

	void SBB( byte_t& p_op1, const byte_t& p_op2 );
	void SBB( word_t& p_op1, const word_t& p_op2 );
	
	void PUSHF();

	void STOSB();
	void REP_STOSB();

	void STOSW();
	void REP_STOSW();

	bool JL() const;
	bool JNZ() const;
	bool JZ() const;
	bool JLE() const;
	bool JG() const;
	bool JA() const;
	bool JBE() const;
	bool JB() const;
	bool JS() const;
	bool JNB() const;
	bool JNS() const;
	bool JCXZ() const;
	bool JNO() const;
	bool JO() const;
	bool JGE() const;

	void INb( const word_t p_port, byte_t& p_value );
	void OUTb( const word_t p_port, const byte_t p_value );

	void MOVSB();
	void MOVSW();
	void REP_MOVSB();
	void REP_MOVSW();
	void REPNE_MOVSW();

	void LES( word_t& p_op1, dword_t& p_op2 );
	void LDS( word_t& p_op1, dword_t& p_op2 );
	void LSS( word_t& p_op1, dword_t& p_op2 );

	void LODSB();
	void LODSW();

	void XLAT();

	void CWD();

	void CBW();

	void STI();
	void CLI();

	void STC();
	void CLC();

	void STD();
	void CLD();

	void LEA( word_t& p_op1, dword_t& p_op2 );

	void LAHF();
	
	void SAHF();

	void NOT( byte_t& p_op );
	void NOT( word_t& p_op );

	void ADC( word_t& p_op1, const word_t p_op2 );

	void NEG( byte_t& p_op );
	void NEG( word_t& p_op );

	void ROL( byte_t& p_op1, const byte_t p_op2 );
	void ROL( word_t& p_op1, const byte_t p_op2 );

	void RCL( word_t& p_op1, const byte_t p_op2 );
	void RCR( word_t& p_op1, const byte_t p_op2 );

	void SAR( word_t& p_op1, const byte_t p_op2 );

	void CMPSB();
	void REPE_CMPSB();

	void SCASB();
	void REPNE_SCASB();

private:
	regs_t m_regs;
	word_t m_cs;
	word_t m_es;
	word_t m_ds;
	word_t m_ss;
	word_t m_si;
	word_t m_di;
	word_t m_sp;
	word_t m_flags;

	pbyte_t m_memory;

	dword_t linear_offset( const word_t p_seg, const word_t p_ofs ) const;

	void* ptr( const word_t p_seg, const word_t p_ofs ) const;

	void write_byte( const word_t p_seg, const word_t p_ofs, const byte_t p_value ) const;
	void write_word( const word_t p_seg, const word_t p_ofs, const word_t p_value ) const;
	void write_dword( const word_t p_seg, const word_t p_ofs, const dword_t p_value ) const;

	void read_byte( const word_t p_seg, const word_t p_ofs, byte_t& p_value ) const;
	void read_word( const word_t p_seg, const word_t p_ofs, word_t& p_value ) const;
	void read_dword( const word_t p_seg, const word_t p_ofs, dword_t& p_value) const;

	void advance_with_DF( word_t& p_index_reg, const byte_t p_size );
	void advance_with_DF_word( word_t& p_index_reg );
	void advance_with_DF_byte( word_t& p_index_reg );

	void load_farptr( word_t& p_seg_reg, word_t& p_index_reg, dword_t& p_op2 );

	on_access_t& m_on_access;
};

/*
MOV

CALL<--

JMP<--

RETF<--

INT<--

IRET<--

LOOP???

RETN<--
*/
