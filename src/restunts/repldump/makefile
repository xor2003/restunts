!ifndef TARGET
TARGET=ported
!endif

RESTUNTS_OBJDIR = ..\c\build\dos
RESTUNTS_OBJFILES = $(RESTUNTS_OBJDIR)\fileio.obj $(RESTUNTS_OBJDIR)\math.obj $(RESTUNTS_OBJDIR)\memmgr.obj $(RESTUNTS_OBJDIR)\restunts.obj $(RESTUNTS_OBJDIR)\shape3d.obj $(RESTUNTS_OBJDIR)\shape2d.obj $(RESTUNTS_OBJDIR)\keyboard.obj $(RESTUNTS_OBJDIR)\heapsort.obj $(RESTUNTS_OBJDIR)\frame.obj $(RESTUNTS_OBJDIR)\state.obj $(RESTUNTS_OBJDIR)\stateply.obj $(RESTUNTS_OBJDIR)\statecrs.obj $(RESTUNTS_OBJDIR)\statecar.obj

ASM_DIR = ..\asm
ASM_OBJDIR = ..\asm\build
ASM_OBJFILES = $(ASM_OBJDIR)\segments.obj $(ASM_OBJDIR)\seg000.obj $(ASM_OBJDIR)\seg001.obj $(ASM_OBJDIR)\seg002.obj $(ASM_OBJDIR)\seg003.obj $(ASM_OBJDIR)\seg004.obj $(ASM_OBJDIR)\seg005.obj $(ASM_OBJDIR)\seg006.obj $(ASM_OBJDIR)\seg007.obj $(ASM_OBJDIR)\seg008.obj $(ASM_OBJDIR)\seg009.obj $(ASM_OBJDIR)\seg010.obj $(ASM_OBJDIR)\seg011.obj $(ASM_OBJDIR)\seg012.obj $(ASM_OBJDIR)\seg013.obj $(ASM_OBJDIR)\seg014.obj $(ASM_OBJDIR)\seg015.obj $(ASM_OBJDIR)\seg016.obj $(ASM_OBJDIR)\seg017.obj $(ASM_OBJDIR)\seg018.obj $(ASM_OBJDIR)\seg019.obj $(ASM_OBJDIR)\seg020.obj $(ASM_OBJDIR)\seg021.obj $(ASM_OBJDIR)\seg022.obj $(ASM_OBJDIR)\seg023.obj $(ASM_OBJDIR)\seg024.obj $(ASM_OBJDIR)\seg025.obj $(ASM_OBJDIR)\seg026.obj $(ASM_OBJDIR)\seg027.obj $(ASM_OBJDIR)\seg028.obj $(ASM_OBJDIR)\seg029.obj $(ASM_OBJDIR)\seg030.obj $(ASM_OBJDIR)\seg031.obj $(ASM_OBJDIR)\seg032.obj $(ASM_OBJDIR)\seg033.obj $(ASM_OBJDIR)\seg034.obj $(ASM_OBJDIR)\seg035.obj $(ASM_OBJDIR)\seg036.obj $(ASM_OBJDIR)\seg037.obj $(ASM_OBJDIR)\seg038.obj $(ASM_OBJDIR)\seg039.obj $(ASM_OBJDIR)\dseg.obj $(ASM_OBJDIR)\seg041.obj 

ASMORIG_DIR = ..\asmorig
ASMORIG_OBJDIR = ..\asmorig\build
ASMORIG_OBJFILES = $(ASM_OBJDIR)\segments.obj $(ASMORIG_OBJDIR)\seg000.obj $(ASMORIG_OBJDIR)\seg001.obj $(ASMORIG_OBJDIR)\seg002.obj $(ASMORIG_OBJDIR)\seg003.obj $(ASMORIG_OBJDIR)\seg004.obj $(ASMORIG_OBJDIR)\seg005.obj $(ASMORIG_OBJDIR)\seg006.obj $(ASMORIG_OBJDIR)\seg007.obj $(ASMORIG_OBJDIR)\seg008.obj $(ASMORIG_OBJDIR)\seg009.obj $(ASMORIG_OBJDIR)\seg010.obj $(ASMORIG_OBJDIR)\seg011.obj $(ASMORIG_OBJDIR)\seg012.obj $(ASMORIG_OBJDIR)\seg013.obj $(ASMORIG_OBJDIR)\seg014.obj $(ASMORIG_OBJDIR)\seg015.obj $(ASMORIG_OBJDIR)\seg016.obj $(ASMORIG_OBJDIR)\seg017.obj $(ASMORIG_OBJDIR)\seg018.obj $(ASMORIG_OBJDIR)\seg019.obj $(ASMORIG_OBJDIR)\seg020.obj $(ASMORIG_OBJDIR)\seg021.obj $(ASMORIG_OBJDIR)\seg022.obj $(ASMORIG_OBJDIR)\seg023.obj $(ASMORIG_OBJDIR)\seg024.obj $(ASMORIG_OBJDIR)\seg025.obj $(ASMORIG_OBJDIR)\seg026.obj $(ASMORIG_OBJDIR)\seg027.obj $(ASMORIG_OBJDIR)\seg028.obj $(ASMORIG_OBJDIR)\seg029.obj $(ASMORIG_OBJDIR)\seg030.obj $(ASMORIG_OBJDIR)\seg031.obj $(ASMORIG_OBJDIR)\seg032.obj $(ASMORIG_OBJDIR)\seg033.obj $(ASMORIG_OBJDIR)\seg034.obj $(ASMORIG_OBJDIR)\seg035.obj $(ASMORIG_OBJDIR)\seg036.obj $(ASMORIG_OBJDIR)\seg037.obj $(ASMORIG_OBJDIR)\seg038.obj $(ASMORIG_OBJDIR)\seg039.obj $(ASMORIG_OBJDIR)\dseg.obj $(ASMORIG_OBJDIR)\seg041.obj 

OBJDIR = build\$(TARGET)
RESTUNTS_CFLAGS = /c /u- /mm /v /n$(OBJDIR) /DRESTUNTS_DOS

!if ($(TARGET)==ported)

#CTARGETS = $(RESTUNTS_OBJFILES) $(ASM_OBJFILES) $(OBJDIR)\repldump.obj
CTARGETS = $(ASM_OBJFILES) $(RESTUNTS_OBJFILES) $(OBJDIR)\repldump.obj getvect.obj labs.obj memcpy.obj fmemcpy.obj h_ldiv.obj f_lxmul.obj f_scopy.obj h_lrsh.obj h_padd.obj h_pina.obj h_pada.obj f_pcmp.obj h_lursh.obj h_psbp.obj h_llsh.obj

OUTFILE = repldump.exe
CFLAGS = 

!elif ($(TARGET)==original)

#CTARGETS = $(ASMORIG_OBJFILES) $(OBJDIR)\repldump.obj
CTARGETS = $(ASMORIG_OBJFILES) $(OBJDIR)\repldump.obj getvect.obj labs.obj memcpy.obj fmemcpy.obj h_ldiv.obj f_lxmul.obj f_scopy.obj h_lrsh.obj h_padd.obj h_pina.obj h_pada.obj f_pcmp.obj h_lursh.obj h_psbp.obj h_llsh.obj
CFLAGS = /DRESTUNTS_ORIGINAL
OUTFILE = repldumo.exe

!else
!error Unsupported DOS target: $(TARGET)
!endif

ASM = tasmbox /m2 /s
CC = bcc  $(RESTUNTS_CFLAGS) $(CFLAGS)
LINK = call tlinkbox

repldump.exe: $(OBJDIR)\repldump.obj
	echo $(CTARGETS) > restunts.lnk
	echo $(OUTFILE) >> restunts.lnk
	$(LINK) /s /P- /v /js:\tools\lib\ @restunts.lnk
	del restunts.lnk
	copy $(OUTFILE) s:\stunts

$(OBJDIR)\repldump.obj: repldump.c
	$(CC) -I../c $?

clean:
	del build\ported\repldump.obj
	del build\original\repldump.obj
	del repldump.exe
	del repldump.map
	del repldumo.exe
	del repldumo.map
