restunts: asm c
	cd dos
	if exist makefile make 
	cd ..

restunts-original: asmorig
	cd dos
	if exist makefile make /DTARGET=original
	cd ..

asm:
	cd asm
	if exist makefile make
	cd ..

asmorig:
	cd asmorig
	if exist makefile make
	cd ..

c:
	cd c
	if exist makefile make
	cd ..

restunts-sdl:
	cd sdl
	if exist makefile make
	cd ..

repldump: asm c
	cd repldump
	if exist makefile make
	cd ..

repldump-original: asmorig
	cd repldump
	if exist makefile make /DTARGET=original
	cd ..

clean:
	cd dos
	if exist makefile make clean
	cd ..
	cd c
	if exist makefile make clean
	cd ..
	cd asm
	if exist makefile make clean
	cd ..
	cd asmorig
	if exist makefile make clean
	cd ..
	cd sdl
	if exist makefile make clean
	cd ..
	cd repldump
	if exist makefile make clean
	cd ..
