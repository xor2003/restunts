the tools directory contains tools for a minimal build environment.

included tools: tasm, wlink, make, bcc


setpath.bat modifies the PATH environment variable to point at the assembler, compiler, linker and
make utilities contained in tools/bin.

mount_stunts_to_s.bat mounts the parent directory to s:. this is useful when testing the stunts
installation included in the repo, since stunts does not run from too deep directory hierarchies.

the include directory contains include files for borlands crt. the crt obj files are currently 
located in ..\src\restunts\crt

