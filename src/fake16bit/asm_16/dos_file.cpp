#include "dos_file.hpp"

#include <cassert>

int dos_file_manager::get_handle( int& p_handle )
{
	assert( m_handles.size() > 0 );

	int handle = m_handles.top();
	m_handles.pop();

	return 0;
}

int dos_file_manager::free_handle(int p_handle)
{
	m_handles.push(p_handle);

	return 0;
}

int dos_file_manager::free_file( int p_handle )
{
	assert( m_handle_map.find( p_handle ) != m_handle_map.end() );

	handle_map_iterator_t i = m_handle_map.find( p_handle );
	m_handle_map.erase( i );

	return 0;
}

FILE* dos_file_manager::get_file( int p_handle )
{
	assert( m_handle_map.find( p_handle ) != m_handle_map.end() );
	return m_handle_map[p_handle];
}

void dos_file_manager::set_file( int p_handle, FILE* p_fp )
{
	m_handle_map[p_handle]=p_fp;
}

void dos_file_manager::fill_stack( int p_stack_size )
{
	m_stack_size = p_stack_size;
	for(int i = 0; i < p_stack_size; ++i )
	{
		m_handles.push(i);
	}
}

dos_file_manager::dos_file_manager()
{
	m_current_handle = 0;

	fill_stack( 0xFFFF );
}

int create( std::string& p_filename, int p_attributes, int& p_handle )
{
	return 0;
}

int dos_file_manager::open( std::string& p_filename, int p_mode, int& p_handle )
{
	//p_mode == 
	//00  read only
	//01  write only
	//02  read/write
	assert( p_mode == 0 || p_mode == 1 || p_mode == 2 );
	std::string mode;
	switch( p_mode )
	{
	case 0: mode = "r";
	case 1: mode = "w";
	case 2: mode = "rw";
	}

	FILE* fp = fopen( p_filename.c_str(), mode.c_str() );

	get_handle( p_handle );

	set_file( p_handle, fp );

	return 0;
}

int dos_file_manager::close( int p_handle )
{
	FILE* fp = get_file( p_handle );

	fclose(fp);

	free_file( p_handle );
	free_handle( p_handle );

	return 0;
}

int dos_file_manager::seek( int p_handle, int p_offset, int p_origin )
{
	FILE* fp = m_handle_map[p_handle];

	fseek( fp, p_offset, p_origin );

	return 0;
}

int dos_file_manager::unlink( std::string& p_filename )
{
	//delete file
	//does file exists

	int result = remove( p_filename.c_str() );
	
	return 0;
}

int dos_file_manager::read( int p_handle /*buffer*/ )
{
	FILE* fp = m_handle_map[p_handle];

	//fread( buffer,1,count, fp );

	return 0;
}

int dos_file_manager::write( int p_handle /*buffer*/ )
{
	FILE* fp = m_handle_map[p_handle];

	//fwrite( buffer,1,count, fp );

	return 0;
}
