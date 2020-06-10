SDLPATH = s:\src\sdl
CC = cl /MD /c /EHsc /I$(SDLPATH)\include /I../c /DRESTUNTS_SDL /Zi
LINK = cl
LINKFLAGS = /link /LIBPATH:$(SDLPATH)\lib /SUBSYSTEM:console /DEBUG
OBJDIR = build

CTARGETS = $(OBJDIR)\fileio.obj $(OBJDIR)\memmgr.obj $(OBJDIR)\shape3d.obj $(OBJDIR)\math.obj
#$(OBJDIR)\shape2d.obj 
#$(OBJDIR)\fileio.obj $(OBJDIR)\math.obj $(OBJDIR)\memmgr.obj $(OBJDIR)\restunts.obj $(OBJDIR)\shape3d.obj $(OBJDIR)\shape2d.obj
PROJTARGETS = $(OBJDIR)\main.obj $(OBJDIR)\data3d.obj sdl.lib sdlmain.lib

restunts-sdl.exe: $(OBJDIR)\main.obj $(OBJDIR)\data3d.obj cfiles
	$(LINK) $(PROJTARGETS) $(CTARGETS) $(LINKFLAGS) /OUT:$<

$(OBJDIR)\main.obj: main.cpp
	$(CC) /Fo$< main.cpp

$(OBJDIR)\data3d.obj: data3d.cpp
	$(CC) /Fo$< data3d.cpp

cfiles:
	cd ..\c
	if exist makefile make /DTARGET=sdl
	cd ..\sdl

clean:
	del $(OBJDIR)\main.obj
	del restunts-sdl.exe
	del restunts-sdl.map
