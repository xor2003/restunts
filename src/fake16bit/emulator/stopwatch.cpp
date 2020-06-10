#include "stopwatch.hpp"

#include <Windows.h>
#include <cassert>

stopwatch_t::stopwatch_t():m_start(0),m_stop(0),m_freq(0)
{
	BOOL res = QueryPerformanceFrequency( (LARGE_INTEGER*)&m_freq);
	assert(res);

	//QueryPerformanceCounter minimum resolution: 1/m_freq Seconds
}

void stopwatch_t::get_counter( __int64& p_counter )
{
	BOOL res = QueryPerformanceCounter( (LARGE_INTEGER*)&p_counter );
	assert( res );
}

void stopwatch_t::start()
{
	get_counter( m_start );
}

void stopwatch_t::stop()
{
	get_counter( m_stop );
}

// duration in seconds
double stopwatch_t::duration()
{
	return ( (m_stop - m_start) * 1.0 / m_freq );
}


