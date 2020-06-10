#include "on_access.hpp"

on_access_t::on_access_t()
{
}

void on_access_t::on_read_byte( const word_t p_seg, const word_t p_ofs, byte_t& p_value )
{
}

void on_access_t::on_read_word( const word_t p_seg, const word_t p_ofs, word_t& p_value )
{
}

void on_access_t::on_read_dword( const word_t p_seg, const word_t p_ofs, dword_t& p_value )
{
}

void on_access_t::on_write_byte( const word_t p_seg, const word_t p_ofs, const byte_t p_value )
{
}

void on_access_t::on_write_word( const word_t p_seg, const word_t p_ofs, const word_t p_value )
{
}

void on_access_t::on_write_dword( const word_t p_seg, const word_t p_ofs, const dword_t p_value )
{
}

void on_access_t::on_int_byte( const word_t p_port, byte_t& p_value )
{
}

void on_access_t::on_out_byte( const word_t p_port, const byte_t p_value )
{
}

void on_access_t::on_int( const byte_t p_nr )
{
}
