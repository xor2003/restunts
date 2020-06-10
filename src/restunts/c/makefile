!ifndef TARGET
TARGET=dos
!endif

OBJDIR = build\$(TARGET)

# Set up tools for DOS
!if ($(TARGET)==dos)
CC = bcc /c /u- /mm /v /n$(OBJDIR) /DRESTUNTS_DOS

# Set up tools for SDL
!elif ($(TARGET)==sdl)
SDLPATH = s:\src\sdl
CC = cl  /Zi /MD /c /I$(SDLPATH)\include /DRESTUNTS_SDL /Fo$(OBJDIR)\$?

!else
!error Unsupported C target: $(TARGET)
!endif


all: $(OBJDIR)\fileio.obj $(OBJDIR)\math.obj $(OBJDIR)\memmgr.obj $(OBJDIR)\restunts.obj $(OBJDIR)\shape3d.obj $(OBJDIR)\shape2d.obj $(OBJDIR)\keyboard.obj $(OBJDIR)\heapsort.obj $(OBJDIR)\frame.obj $(OBJDIR)\state.obj $(OBJDIR)\stateply.obj $(OBJDIR)\statecrs.obj $(OBJDIR)\statecar.obj 

$(OBJDIR)\fileio.obj: fileio.c
	$(CC) $?

$(OBJDIR)\math.obj: math.c
	$(CC) $?

$(OBJDIR)\memmgr.obj: memmgr.c
	$(CC) $?

$(OBJDIR)\restunts.obj: restunts.c
	$(CC) $?

$(OBJDIR)\shape3d.obj: shape3d.c
	$(CC) $?

$(OBJDIR)\shape2d.obj: shape2d.c
	$(CC) $?

$(OBJDIR)\keyboard.obj: keyboard.c
	$(CC) $?

$(OBJDIR)\heapsort.obj: heapsort.c
	$(CC) $?

$(OBJDIR)\frame.obj: frame.c
	$(CC) $?

$(OBJDIR)\state.obj: state.c
	$(CC) $?

$(OBJDIR)\stateply.obj: stateply.c
	$(CC) $?

$(OBJDIR)\statecrs.obj: statecrs.c
	$(CC) $?

$(OBJDIR)\statecar.obj: statecar.c
	$(CC) $?

clean:
	del $(OBJDIR)\fileio.obj
	del $(OBJDIR)\math.obj
	del $(OBJDIR)\memmgr.obj
	del $(OBJDIR)\restunts.obj
	del $(OBJDIR)\shape3d.obj
	del $(OBJDIR)\shape2d.obj
	del $(OBJDIR)\keyboard.obj
	del $(OBJDIR)\heapsort.obj
	del $(OBJDIR)\frame.obj
	del $(OBJDIR)\state.obj
	del $(OBJDIR)\stateply.obj
	del $(OBJDIR)\statecrs.obj
	del $(OBJDIR)\statecar.obj
