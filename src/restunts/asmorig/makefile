!ifndef TARGET
TARGET=dos
!endif

OBJDIR = build

!if ($(TARGET)!=dos)
!error Unsupported ASM target: $(TARGET)
!endif

ASM = tasmbox /m2 /s /zi

all: $(OBJDIR)\segments.obj $(OBJDIR)\seg000.obj $(OBJDIR)\seg001.obj $(OBJDIR)\seg002.obj $(OBJDIR)\seg003.obj $(OBJDIR)\seg004.obj $(OBJDIR)\seg005.obj $(OBJDIR)\seg006.obj $(OBJDIR)\seg007.obj $(OBJDIR)\seg008.obj $(OBJDIR)\seg009.obj $(OBJDIR)\seg010.obj $(OBJDIR)\seg011.obj $(OBJDIR)\seg012.obj $(OBJDIR)\seg013.obj $(OBJDIR)\seg014.obj $(OBJDIR)\seg015.obj $(OBJDIR)\seg016.obj $(OBJDIR)\seg017.obj $(OBJDIR)\seg018.obj $(OBJDIR)\seg019.obj $(OBJDIR)\seg020.obj $(OBJDIR)\seg021.obj $(OBJDIR)\seg022.obj $(OBJDIR)\seg023.obj $(OBJDIR)\seg024.obj $(OBJDIR)\seg025.obj $(OBJDIR)\seg026.obj $(OBJDIR)\seg027.obj $(OBJDIR)\seg028.obj $(OBJDIR)\seg029.obj $(OBJDIR)\seg030.obj $(OBJDIR)\seg031.obj $(OBJDIR)\seg032.obj $(OBJDIR)\seg033.obj $(OBJDIR)\seg034.obj $(OBJDIR)\seg035.obj $(OBJDIR)\seg036.obj $(OBJDIR)\seg037.obj $(OBJDIR)\seg038.obj $(OBJDIR)\seg039.obj $(OBJDIR)\seg041.obj $(OBJDIR)\dseg.obj

$(OBJDIR)\segments.obj: segments.asm
	$(ASM) $?, $<

$(OBJDIR)\seg000.obj: seg000.asm
	$(ASM) $?, $<

$(OBJDIR)\seg001.obj: seg001.asm
	$(ASM) $?, $<

$(OBJDIR)\seg002.obj: seg002.asm
	$(ASM) $?, $<

$(OBJDIR)\seg003.obj: seg003.asm
	$(ASM) $?, $<

$(OBJDIR)\seg004.obj: seg004.asm
	$(ASM) $?, $<

$(OBJDIR)\seg005.obj: seg005.asm
	$(ASM) $?, $<

$(OBJDIR)\seg006.obj: seg006.asm
	$(ASM) $?, $<

$(OBJDIR)\seg007.obj: seg007.asm
	$(ASM) $?, $<

$(OBJDIR)\seg008.obj: seg008.asm
	$(ASM) $?, $<

$(OBJDIR)\seg009.obj: seg009.asm
	$(ASM) $?, $<

$(OBJDIR)\seg010.obj: seg010.asm
	$(ASM) $?, $<

$(OBJDIR)\seg011.obj: seg011.asm
	$(ASM) $?, $<

$(OBJDIR)\seg012.obj: seg012.asm
	$(ASM) $?, $<

$(OBJDIR)\seg013.obj: seg013.asm
	$(ASM) $?, $<

$(OBJDIR)\seg014.obj: seg014.asm
	$(ASM) $?, $<

$(OBJDIR)\seg015.obj: seg015.asm
	$(ASM) $?, $<

$(OBJDIR)\seg016.obj: seg016.asm
	$(ASM) $?, $<

$(OBJDIR)\seg017.obj: seg017.asm
	$(ASM) $?, $<

$(OBJDIR)\seg018.obj: seg018.asm
	$(ASM) $?, $<

$(OBJDIR)\seg019.obj: seg019.asm
	$(ASM) $?, $<

$(OBJDIR)\seg020.obj: seg020.asm
	$(ASM) $?, $<

$(OBJDIR)\seg021.obj: seg021.asm
	$(ASM) $?, $<

$(OBJDIR)\seg022.obj: seg022.asm
	$(ASM) $?, $<

$(OBJDIR)\seg023.obj: seg023.asm
	$(ASM) $?, $<

$(OBJDIR)\seg024.obj: seg024.asm
	$(ASM) $?, $<

$(OBJDIR)\seg025.obj: seg025.asm
	$(ASM) $?, $<

$(OBJDIR)\seg026.obj: seg026.asm
	$(ASM) $?, $<

$(OBJDIR)\seg027.obj: seg027.asm
	$(ASM) $?, $<

$(OBJDIR)\seg028.obj: seg028.asm
	$(ASM) $?, $<

$(OBJDIR)\seg029.obj: seg029.asm
	$(ASM) $?, $<

$(OBJDIR)\seg030.obj: seg030.asm
	$(ASM) $?, $<

$(OBJDIR)\seg031.obj: seg031.asm
	$(ASM) $?, $<

$(OBJDIR)\seg032.obj: seg032.asm
	$(ASM) $?, $<

$(OBJDIR)\seg033.obj: seg033.asm
	$(ASM) $?, $<

$(OBJDIR)\seg034.obj: seg034.asm
	$(ASM) $?, $<

$(OBJDIR)\seg035.obj: seg035.asm
	$(ASM) $?, $<

$(OBJDIR)\seg036.obj: seg036.asm
	$(ASM) $?, $<

$(OBJDIR)\seg037.obj: seg037.asm
	$(ASM) $?, $<

$(OBJDIR)\seg038.obj: seg038.asm
	$(ASM) $?, $<

$(OBJDIR)\seg039.obj: seg039.asm
	$(ASM) $?, $<

$(OBJDIR)\seg041.obj: seg041.asm
	$(ASM) $?, $<

$(OBJDIR)\dseg.obj: dseg.asm
	$(ASM) $?, $<


clean:
	del $(OBJDIR)\seg*.obj
	del $(OBJDIR)\dseg*.obj
