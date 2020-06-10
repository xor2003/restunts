#include <restunts.h>

#ifdef RESTUNTS_ORIGINAL

int ported_stuntsmain_(int argc, char* argv[]);

// call the implementation in seg010.asm
int stuntsmain(int argc, char* argv[]) {
	return ported_stuntsmain_(argc, argv);
}

#else

// call the implementation in restunts.c
int stuntsmain(int argc, char* argv[]) {
	return stuntsmainimpl(argc, argv);
}

#endif
