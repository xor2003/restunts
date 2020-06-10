#pragma once

class stopwatch_t
{
public:
	stopwatch_t();

	void get_counter( __int64& p_counter );

	void start();

	void stop();

	// duration in seconds
	double duration();

private:
	__int64 m_start;
	__int64 m_stop;
	__int64 m_freq;
};
