#pragma once

typedef unsigned char byte_t;
typedef unsigned short word_t;
typedef unsigned int dword_t;

typedef unsigned __int64 uqword_t;

typedef byte_t* pbyte_t;
typedef word_t* pword_t;
typedef dword_t* pdword_t;

struct ptr_t
{
	word_t ofs;
	word_t seg;
};

union farptr_t
{
	dword_t farptr;
	ptr_t ptr;
};

struct word_regs_t
{        
	word_t ax;
	word_t bx;
	word_t cx;
	word_t dx;
};

struct byte_regs_t 
{        
	byte_t al, ah;
	byte_t bl, bh;
	byte_t cl, ch;
	byte_t dl, dh;
};

union regs_t 
{             
	word_regs_t word;     
	byte_regs_t byte;     
};

/*
0 	CF 	Carry flag 	S
1 	1 	Reserved 	 
2 	PF 	Parity flag 	S
3 	0 	Reserved 	 
4 	AF 	Adjust flag 	S
5 	0 	Reserved 	 
6 	ZF 	Zero flag 	S
7 	SF 	Sign flag 	S
8 	TF 	Trap flag (single step) 	X
9 	IF 	Interrupt enable flag 	X
10 	DF 	Direction flag 	C
11 	OF 	Overflow flag 	S
12, 13 	IOPL 	I/O privilege level (286+ only) 	X
14 	NT 	Nested task flag (286+ only) 	X
15 	0 	Reserved 	 
*/

struct flags_t
{
	bool CF: 1;
	bool reserved1: 1;
	bool PF: 1;
	bool reserved2: 1;
	bool AF: 1;
	bool reserved3: 1;
	bool ZF: 1;
	bool SF: 1;
	bool TF: 1;
	bool IF: 1;
	bool DF: 1;
	bool OF: 1;
	byte_t IOPL: 2;
	bool NT: 1;
	bool reserved4: 1;
};

