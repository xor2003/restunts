#include "word_pair.hpp"

word_pair_t::word_pair_t( word_t& p_hi, word_t& p_lo ):m_hi(p_hi),m_lo(p_lo)
{
}

dword_t word_pair_t::get() const
{
	dword_t tmp = (m_hi << 16) | m_lo;
	return tmp;
}

void word_pair_t::set( const dword_t& p_value ) const
{
	m_hi = ( p_value & 0xFFFF0000 ) >> 16;
	m_lo = ( p_value & 0xFFFF );
}

word_pair_t::operator dword_t () const
{
	return get();
}

const void word_pair_t::operator=(const dword_t& p_value )
{
	set( p_value );
}
