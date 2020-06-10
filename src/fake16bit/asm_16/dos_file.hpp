#pragma once

#define _CRT_SECURE_NO_WARNINGS

#include <string>
#include <map>
#include <stack>

class dos_file_manager
{
private:
	typedef std::map<int,FILE*> handle_map_t;
	handle_map_t m_handle_map;
	typedef handle_map_t::iterator handle_map_iterator_t;
	int m_current_handle;

	std::stack<int> m_handles;
	int m_stack_size;
	int get_handle( int& p_handle );
	int free_handle(int p_handle);
	void fill_stack( int p_stack_size );

	FILE* get_file( int p_handle );
	void set_file( int p_handle, FILE* p_fp );
	int free_file( int p_handle );

public:
	dos_file_manager();
	int create( std::string& p_filename, int p_attributes, int& p_handle );
	int open( std::string& p_filename, int p_mode, int& p_handle );
	int close( int p_handle );
	int seek( int p_handle, int p_offset, int p_origin );
	int unlink( std::string& p_filename );
	int read( int p_handle /*buffer*/ );
	int write( int p_handle /*buffer*/ );
};