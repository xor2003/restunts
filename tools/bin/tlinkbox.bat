@echo off
del tlink.dosbox.conf 2>nul
copy %~dp0dosbox.tmpl.conf tlink.dosbox.conf >nul
echo [autoexec] >>tlink.dosbox.conf
echo MOUNT S S:\ >>tlink.dosbox.conf
echo S: >>tlink.dosbox.conf
echo SET PATH=%%PATH%%;s:\tools\bin >>tlink.dosbox.conf
echo cd %CD% >>tlink.dosbox.conf
echo tlink %* ^>tlinkbox.out >>tlink.dosbox.conf
echo if ERRORLEVEL 0 goto noerror >>tlink.dosbox.conf
echo type tlinkbox.out >>tlink.dosbox.conf
echo pause >>tlink.dosbox.conf
echo :noerror >>tlink.dosbox.conf
echo exit >>tlink.dosbox.conf
dosbox -conf tlink.dosbox.conf
del tlink.dosbox.conf 2>nul
type tlinkbox.out
del tlinkbox.out 2>nul
