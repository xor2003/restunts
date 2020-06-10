#pragma once

#include "asm_16.h"

#include <list>

// -use an first-best-fit allocation strategy
// -does combine freed chunks
// -freed chunks will be memsetted with 0xCC
// -allocate( paragraph_count ) -> segment
// -reallocate( segment, new_paragraph_count )
// -free( segment )
// something missing?
class dos_mem
{
private:
	int m_base;
	byte* m_real_base;
	int m_size;
	int m_max_paragraphs;

	struct chunk_t
	{
		bool used;
		int start;
		int count;
	};
	typedef std::list<chunk_t> chunks_t;
	typedef chunks_t::iterator chunks_iterator_t; 
	chunks_t m_chunks;

private:
	bool find_best_fitting_chunk( int needed_size, chunks_iterator_t& p_chunk_iter );

	void cleanup_chunk( chunk_t* p_chunk );

	chunks_iterator_t find_chunk( int p_segment );

	// 0 = no error
	// 1 = cumulated chunk size != managed size
	int validate_chunks();

	bool find_free_list( chunks_iterator_t& begin, chunks_iterator_t& end );

	bool find_largest_free_size( int& p_size );

public:
	//bool is_dos_mem( int p_linearoffset ); for checks

	dos_mem( int p_base, int p_size );

	// 0 = no error
	// 1 = not enough space left
	int allocate( int needed_size, int& p_segment, int& p_useable_size );

	// 0 = no error or chunk is already at that size
	// 1 = given segment unknown
	// 2 = not enough space left behind
	int reallocate( int p_segment, int new_needed_size, int& p_useable_size );

	// 0 = no error
	// 1 = unknown segment
	// 2 = is already freed block
	int free( int p_segment );

	void print_chunk_info();

	void combine_free_chunks();
};
