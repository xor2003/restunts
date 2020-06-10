#include "dos_mem.hpp"

#include <cassert>
#include <iostream>
#include <string>

bool is_segment_address( int p_segment )
{
	assert( p_segment <= 0xFFFF );
	int rest = p_segment % 0x10;
	return (rest == 0);
}

dos_mem::dos_mem( int p_base, int p_size )
{
	assert( is_segment_address( p_base ) );

	m_base = p_base; // 16bit seg address where the useable ram starts

	m_size = p_size;
	m_max_paragraphs = m_size / PARAGRAPH_SIZE;

	chunk_t chunk;
	chunk.used = false;
	chunk.start = 0;
	chunk.count = m_max_paragraphs;

	m_chunks.push_front( chunk );
}

bool dos_mem::find_best_fitting_chunk( int needed_size, dos_mem::chunks_iterator_t& p_chunk_iter )
{
	chunks_iterator_t best = m_chunks.end();
	chunks_iterator_t i = m_chunks.begin();
	while( i != m_chunks.end() )
	{
		if( !i->used )
		{
			if( i->count >= needed_size )
			{
				if( best == m_chunks.end() )
				{
					best = i;
				}
				else
				{
					if( i->count < best->count )
					{
						best = i;
					}
				}
			}
		}
		++i;
	}

	p_chunk_iter = best;

	return ( best != m_chunks.end() );
}

void dos_mem::cleanup_chunk( chunk_t* p_chunk )
{
	int size = p_chunk->count * PARAGRAPH_SIZE;
	::memset( ptr( m_base + p_chunk->start, 0 ), 0xCC, size );
}

bool dos_mem::find_largest_free_size( int& p_size )
{
	int size = 0;
	chunks_iterator_t biggest = m_chunks.end();

	for( chunks_iterator_t i = m_chunks.begin(); i != m_chunks.end(); ++i )
	{
		if( !i->used )
		{
			if( i->count > size )
			{
				biggest = i;
			}
		}
	}

	if( biggest != m_chunks.end() )
	{
		p_size = biggest->count;
	}

	return ( biggest != m_chunks.end() );
}

//http://stanislavs.org/helppc/int_21-48.html
// 0 = no error
// 1 = not enough space left
int dos_mem::allocate( int needed_size, int& p_segment, int& p_useable_size )
{
	assert( validate_chunks() == 0 );

	p_useable_size = 0;

	chunks_iterator_t best = m_chunks.end();

	if( find_best_fitting_chunk( needed_size, best ) )
	{
		int rest = best->count - needed_size;

		if( rest > 0 )
		{
			//we need to split
			chunk_t new_chunk;

			new_chunk.used = true;
			new_chunk.start = best->start;
			new_chunk.count = needed_size;

			best->used = false;
			best->start = new_chunk.start + new_chunk.count;
			best->count = rest;

			m_chunks.insert( best, new_chunk );

			p_segment = m_base + new_chunk.start;
		}
		else
		{
			best->used = true;
			p_segment = m_base + best->start;
		}

		return 0;
	}

	find_largest_free_size( p_useable_size );

	return 1;
}

dos_mem::chunks_iterator_t dos_mem::find_chunk( int p_segment )
{
	for( chunks_iterator_t i = m_chunks.begin(); i != m_chunks.end(); ++i )
	{
		if( p_segment == ( m_base + i->start ) )
		{
			return i;
		}
	}

	return m_chunks.end();
}

// 0 = no error
// 1 = cumulated chunk size != managed size
int dos_mem::validate_chunks()
{
	int size = 0;

	for( chunks_iterator_t i = m_chunks.begin(); i != m_chunks.end(); ++i )
	{
		size += i->count;
	}

	if ( size != m_max_paragraphs )
	{
		return 1;
	}

	return 0;
}

//http://stanislavs.org/helppc/int_21-4a.html
// 0 = no error or chunk is already at that size
// 1 = given segment unknown
// 2 = not enough space left behind -> p_useable_size 
// 3 = no useable space for growth
// 4 = give segment already freed
int dos_mem::reallocate( int p_segment, int new_needed_size, int& p_useable_size )
{
	assert( validate_chunks() == 0 );

	p_useable_size = 0;

	chunks_iterator_t chunk = find_chunk( p_segment );

	if( chunk == m_chunks.end() )
	{
		return 1;
	}

	if( !chunk->used )
	{
		return 4;
	}

	if( chunk->count == new_needed_size )
	{
		return 0;
	}

	if( chunk->count > new_needed_size )
	{
		int chunk_size = chunk->count;

		chunk_t old_chunk;
		old_chunk.start = chunk->start;
		old_chunk.count = new_needed_size;
		old_chunk.used = true;

		m_chunks.insert( chunk, old_chunk );

		chunk->start = old_chunk.start + old_chunk.count;
		chunk->count = chunk_size - new_needed_size;
		chunk->used = false;
	}
	else
	{
		int extend_size = new_needed_size - chunk->count;

		chunks_iterator_t next = chunk;
		next++;

		if( next != m_chunks.end() )
		{
			if( !next->used ) 
			{
				if( next->count >= extend_size )
				{
					next->start += extend_size;
					next->count -= extend_size;

					chunk->count += extend_size;

					return 0;
				}
				// what is possible
				p_useable_size = chunk->count + next->count;

				return 2;
			}
		}
		return 3; // no free chunk behind
	}

	return 0;
}

//http://stanislavs.org/helppc/int_21-49.html
// 0 = no error
// 1 = unknown segment
// 2 = is already freed block
int dos_mem::free( int p_segment )
{
	assert( validate_chunks() == 0 );

	chunks_iterator_t chunk = find_chunk( p_segment );

	if( chunk == m_chunks.end() )
	{
		return 1;
	}

	if( !chunk->used )
	{
		return 2;
	}

	chunk->used = false;

	chunk_t c;
	c.start = chunk->start;
	c.used = chunk->used;
	c.count = chunk->count;
	cleanup_chunk( &c );

	combine_free_chunks();

	return 0;
}

bool dos_mem::find_free_list( dos_mem::chunks_iterator_t& begin, dos_mem::chunks_iterator_t& end )
{
	chunks_iterator_t first = m_chunks.end();

	for( chunks_iterator_t i = m_chunks.begin(); i != m_chunks.end(); ++i )
	{
		//--------------
		bool current_is_free = ( !i->used );
		chunks_iterator_t n = i;
		std::advance(n,1);
		bool next_is_free = ( ( n != m_chunks.end() ) && ( !n->used ) );
		//--------------

		if( current_is_free )
		{
			if( first == m_chunks.end( ) )
			{
				first = i;
			}
		}

		if( !next_is_free )
		{
			if( ( first != m_chunks.end()) )
			{
				int distance = std::distance( first, i );
				if( distance > 0 )
				{
					//lets go
					chunks_iterator_t second = i;
					++second;

					begin = first;
					end = second;

					//for( chunks_iterator_t x = begin; x != end; ++x )
					//{
					//	std::cout << "start: " << x->start << " count: " << x->count << std::endl;
					//}

					return true;
				}

				first = m_chunks.end();
			}
		}
	}

	return false;
}

void dos_mem::combine_free_chunks()
{
	assert( validate_chunks() == 0 );

	chunks_iterator_t begin = m_chunks.end();
	chunks_iterator_t end = m_chunks.end();

	bool found = false;
	do
	{
		found = find_free_list( begin, end );

		if( found )
		{
			int new_count = 0;
			for( chunks_iterator_t i = begin; i != end; ++i )
			{
				new_count += i->count;
			}

			begin->count = new_count;
			chunks_iterator_t next = begin;
			++next;
			m_chunks.erase( next, end );
		}
	}			
	while( found );

	assert( validate_chunks() == 0 );
}

void dos_mem::print_chunk_info()
{
	int nr = 0;
	for( chunks_iterator_t i = m_chunks.begin(); i != m_chunks.end(); ++i )
	{
		std::cout << "chunk: " << nr << std::endl;
		std::cout << "  start: " << i->start << std::endl;
		std::cout << "  used: " << std::string( i->used ? "true" : "false" ) << std::endl;
		std::cout << "  count: " << i->count << std::endl;
		++nr;
	}
}
