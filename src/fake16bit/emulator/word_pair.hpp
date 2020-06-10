#pragma once

#include "types.hpp"

class word_pair_t
{
public:
	word_pair_t( word_t& p_hi, word_t& p_lo );

	dword_t get() const;

	void set( const dword_t& p_value ) const;

	operator dword_t () const;

	const void operator=(const dword_t& p_value );

private:
	word_t& m_hi;
	word_t& m_lo;
};