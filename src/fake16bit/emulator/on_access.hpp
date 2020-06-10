#pragma once

#include "types.hpp"

// a small delegator
// for not mixing up the emulator code with SDL, Sound and Dos Memory/Filesystem-Stuff
class emulator_t;

class on_access_t
{
public:
	on_access_t();

	virtual void on_read_byte( const word_t p_seg, const word_t p_ofs, byte_t& p_value );
	virtual void on_read_word( const word_t p_seg, const word_t p_ofs, word_t& p_value );
	virtual void on_read_dword( const word_t p_seg, const word_t p_ofs, dword_t& p_value );

	virtual void on_write_byte( const word_t p_seg, const word_t p_ofs, const byte_t p_value );
	virtual void on_write_word( const word_t p_seg, const word_t p_ofs, const word_t p_value );
	virtual void on_write_dword( const word_t p_seg, const word_t p_ofs, const dword_t p_value );

	virtual void on_int_byte( const word_t p_port, byte_t& p_value );
	virtual void on_out_byte( const word_t p_port, const byte_t p_value );

	virtual void on_int( const byte_t p_nr );

	void set_emulator( emulator_t* p_emulator )
	{
		m_emulator = p_emulator;
	}

private:
	emulator_t* m_emulator;
};