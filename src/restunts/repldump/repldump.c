#include <dos.h>
#include <restunts.h>
#include <memmgr.h>

typedef unsigned size_t;
typedef int FILE;

#ifdef RESTUNTS_ORIGINAL

int g_errno;

FILE* fopen(const char* path, const char* mode)
{
	unsigned short segm = FP_SEG(path);
	unsigned short offs = FP_OFF(path);
	FILE* handle;

	g_errno = 0;

	if (mode[0] == 'w') { // Create new file for writing
		__asm {
			push ds
			mov  ah, 3Ch // Create file
			mov  cx, 0 // No attributes
			mov  ds, segm
			mov  dx, offs
			int  21h
			jnc  short create_ok
			mov  ax, 0
			mov  g_errno, 1
		create_ok:
			mov  handle, ax
			pop  ds
		}
	}
	else { // Open existing file for reading
		__asm {
			push ds
			mov  ah, 3Dh // Open file
			mov  al, 0 // Read only
			mov  ds, segm
			mov  dx, offs
			int  21h
			jnc  short open_ok
			mov  ax, 0
			mov  g_errno, 1
		open_ok:
			mov  handle, ax
			pop  ds
		}
	}

	return handle;
}

int fclose(FILE* file)
{
	int res;

	__asm {
		mov  ah, 3Eh // Close file
		mov  bx, file
		int  21h
		jnc  short close_ok
		mov  ax, 0
		mov  g_errno, 1
	close_ok:
		mov  res, ax
	}
	
	return res;
}

size_t fwrite(const void far* src, size_t size, size_t nmemb, FILE* file)
{
	unsigned short segm = FP_SEG(src);
	unsigned short offs = FP_OFF(src);

	size_t res;
	size *= nmemb;
	
	__asm {
		push ds
		mov  ah, 40h // Write to file
		mov  bx, file
		mov  ds, segm
		mov  dx, offs
		mov  cx, size
		int  21h
		jnc  short write_ok
		mov  ax, 0
		mov  g_errno, 1
	write_ok:
		mov  res, ax
		pop  ds
	}
	
	return res;
}

void init_row_tables(void) {
	int i;
	for (i = 0; i < 30; i++) {
		trackrows[i] = 30 * (29 - i);
		terrainrows[i] = 30 * i;
		trackpos[i] = (29 - i) << 10;
		trackcenterpos[i] = ((29 - i) << 10) + 0x200;
		terrainpos[i] = i << 10;
		terraincenterpos[i] = (i << 10) + 0x200;
	}
	
	for (i = 0; i < 30; i++) {
		trackpos2[i] = i << 10;
		trackcenterpos2[i] = (i << 10) + 0x200;
	}
}

void init_trackdata(void) {
	char far* trkptr;
	trkptr = mmgr_alloc_resbytes("trakdata", 0x6BF3);

	td01_track_file_cpy = trkptr;
	
	trkptr += 0x70a;
	td02_penalty_related = trkptr;
	
	trkptr += 0x70a;
	trackdata3 = trkptr;

	trkptr += 0x70a;
	td04_aerotable_pl = trkptr;

	trkptr += 0x80;
	td05_aerotable_op = trkptr;

	trkptr += 0x80;
	trackdata6 = trkptr;

	trkptr += 0x80;
	trackdata7 = trkptr;

	trkptr += 0x80;
	td08_direction_related = trkptr;

	trkptr += 0x60;
	trackdata9 = trkptr;

	trkptr += 0x180;
	td10_track_check_rel = trkptr;

	trkptr += 0x120;
	td11_highscores = trkptr;

	trkptr += 0x16c;
	trackdata12 = trkptr;

	trkptr += 0x0f0;
	td13_rpl_header = trkptr;

	trkptr += 0x1a;
	td14_elem_map_main = trkptr;

	trkptr += 0x385;
	td15_terr_map_main = trkptr;

	trkptr += 0x385;
	td16_rpl_buffer = trkptr;

	trkptr += 0x2ee0;
	td17_trk_elem_ordered = trkptr;

	trkptr += 0x385;
	trackdata18 = trkptr;

	trkptr += 0x385;
	trackdata19 = trkptr;

	trkptr += 0x385;
	td20_trk_file_appnd = trkptr;

	trkptr += 0x7ac;
	td21_col_from_path = trkptr;

	trkptr += 0x385;
	td22_row_from_path = trkptr;

	trkptr += 0x385;
	trackdata23 = trkptr;

	trkptr += 0x30;
}
#else

size_t fwrite(const void far* src, size_t size, size_t nmemb, FILE* file);

#endif

int stuntsmain(int argc, char* argv[]) {
	int i;
	char outname[13], carid[5];
	FILE* fout;
	
	if (argc != 2) {
		printf("Usage: %s REPLNAME\n\n", argv[0]);
		return 1;
	}

	init_main(argc, argv);
	init_div0();
	init_row_tables();

	mainresptr = file_load_resfile("main");
	
	fontdefptr = file_load_resource(0, "fontdef.fnt");
	fontnptr = file_load_resource(0, "fontn.fnt");

	font_set_fontdef();
	init_polyinfo();
	
	init_trackdata();

	init_unknown();
	
	init_kevinrandom("kevin");

	printf("Loading replay... ");
	file_load_replay("", argv[1]);
	printf("OK\n");
	_memcpy(carid, gameconfig.game_playercarid, 4);
	carid[4] = 0;
	printf("  Track: '%s' Car: '%s'\n", gameconfig.game_trackname, carid);

	printf("Copying track... ");
	_memcpy(&gameconfigcopy, &gameconfig, sizeof(struct GAMEINFO));
	for (i = 0; i < 0x70A; i++) {
		td20_trk_file_appnd[i] = td14_elem_map_main[i];
	}
	for (i = 0; i < 0x51; i++) {
		td20_trk_file_appnd[i + 0x70A] = byte_3B80C[i];
		td20_trk_file_appnd[i + 0x75B] = byte_3B85E[i];
	}
	printf("OK\n");

	printf("Setting up track... ");
	track_setup();
	printf("OK\n");

	printf("Allocating cvx... ");
	cvxptr = mmgr_alloc_resbytes("cvx", 0x5780);
	printf("OK\n");
	
	printf("Initializing game state... ");
	init_game_state(0xFFFF);
	printf("OK\n");
	
	// Inits from run_game()...
	word_449EA = 0xFFFF;
	run_game_random = get_kevinrandom() << 3;
	replaybar_toggle = 1;
	is_in_replay = 0;
	idle_expired = 0;
	cameramode = 0;
	game_replay_mode = 2;
	is_in_replay = 1;

	printf("Loading assets... ");
	setup_player_cars();
	kbormouse = 0;
	byte_449E6 = 0;
	byte_449DA = 1;
	
	set_frame_callback();
	game_replay_mode_copy = 0xFF;
	byte_44346 = 0;
	byte_4432A = 0;
	byte_46467 = 0;
	dashb_toggle = 0;
	
	cameramode = 0;
	game_replay_mode = 2;
	word_44DCA = 0x1F4;
	framespersec = 20;

	restore_gamestate(0);
	restore_gamestate(gameconfig.game_recordedframes);
	printf("OK\n");
	
	strcpy(outname, argv[1]);
#ifdef RESTUNTS_ORIGINAL
	strcat(outname, ".BIN");
#else
	strcat(outname, ".BNI");
#endif
	outname[12] = 0;
	printf("Creating output file '%s'... ", outname);
	
	fout = fopen(outname, "w");
	if (!fout) {
		printf("FAIL\n");
		return 1;
	}
	printf("OK\n");
	
	fwrite(&gameconfig.game_recordedframes, sizeof(unsigned short), 1, fout);

	printf("Processing %d frames... ", gameconfig.game_recordedframes);

	while (gameconfig.game_recordedframes > state.game_frame) {
		input_do_checking(1);
		update_gamestate();
		fwrite(&state, sizeof(struct GAMESTATE), 1, fout);
		//printf("Current frame %d\n", state.frame);
	}
	
	printf("OK\n");
	
	fclose(fout);
	
	input_do_checking(1);

	fatal_error("\nDone.\n");

	//audio_stop_unk();
	//audiodrv_atexit();
	//kb_exit_handler();
	//kb_shift_checking1();
	//video_set_mode7();

	return 0;
}