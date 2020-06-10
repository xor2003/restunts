#pragma once

#include "emulator.hpp"

const int FLAG_TESTS = 128; // 2^7

class emulator_test_t
{
public:
	emulator_test_t( emulator_t& p_emulator );

	void test();

private:
	emulator_t& m_emulator;

	void test_sub_byte();
	void test_sub_word();
	void test_mul_imul_diff_byte();

	typedef word_t test_flags_t[FLAG_TESTS];
	test_flags_t m_test_flags;

	void create_test_flags( test_flags_t& p_test_flags );
};

