@ECHO OFF
setlocal enabledelayedexpansion

REM --Remove previous temporary directories (cannot delete after work due to active processes)
FOR /F "usebackq delims=" %%A IN (`DIR /A:D /S /B !TEMP!\TEMP_*`) DO RMDIR /S /Q %%A 2>nul
DEL /Q .\*.COM 2>nul
DEL /Q .\*_export.dat 2>nul

REM --Create temporary working directory (avoid issues with Japanese paths)
SET YYYYMMDD=%DATE:/=%
SET TMPTIME=%TIME:~0,5%
SET TMPTIME=%TMPTIME::=%
SET HHMM=%TMPTIME: =0%
SET NOW=%YYYYMMDD%%HHMM%
SET TMPDIR=%TEMP%\TEMP_%NOW%
MKDIR %TMPDIR%

REM --Variable definitions
SET BatPath=%~dp0
SET nkf=%TMPDIR%\nkf.exe
SET zyltMain=%TMPDIR%\zyltMain.exe
SET stdlibFile=%TMPDIR%\stdlib.ini

CD %BatPath%

COPY /B .\bin\*.* %TMPDIR%>nul

REM --Import files to the working folder
IF exist *.dat (
	FOR /F "usebackq delims=" %%A IN (`DIR /B .\*.dat`) DO (
		TYPE !BatPath!%%A>!TMPDIR!\import.dat
	)
)
FOR /F "usebackq delims=" %%A IN (`DIR /B .\*.zylt`) DO (
	ECHO Start Processing
REM --Save the program file name
	SET UserFile=%%A
	SET UserFile=!UserFile:.zylt=!
REM --Create stdlib.ini (embed Zylt code into stdlib.ini)
	CALL :MKFILE %%A
REM --Convert to utf-8 (Japanese characters become corrupted in shift-jis)
	CALL :CHW
)


REM --Export files to the program folder
CD %TMPDIR%
IF exist export.dat (
	TYPE !TMPDIR!\export.dat>!BatPath!\!UserFile!_export.dat
)

REM --Rename generated exe with program file name
MOVE %TMPDIR%\output.com %BatPath%\%UserFile%.COM
ECHO Deleting temporary directory
CD %TMPDIR%
REM --Delete contents of working directory (cannot delete the directory itself due to active processes)
TIMEOUT /T 5 >nul
DEL /Q %TMPDIR%\*.* 2>nul

endlocal
PAUSE
EXIT

REM --Copy files to the working folder and append EXE template
:MKFILE
ECHO (let ((tmpdata ^'> %stdlibFile%
TYPE .\%1>> %stdlibFile%
ECHO ))>> %stdlibFile%
ECHO (setq pglst tmpdata)>> %stdlibFile%
ECHO (setq pglstbk tmpdata)>> %stdlibFile%
ECHO (load "zylt.ini")>> %stdlibFile%
ECHO )>> %stdlibFile%
EXIT /B

REM --Convert to utf-8 (Japanese characters become corrupted in shift-jis)
:CHW
CD %TMPDIR%
REM --Convert to utf-8 (Japanese characters become corrupted in shift-jis)
CALL :CH_W stdlib.ini
CALL :CH_W zylt.ini
REM --Run DLisp main executable
ECHO Processing...
CALL %zyltMain%>%TMPDIR%\input.txt
CALL %TMPDIR%\txt2com.exe %TMPDIR%\input.txt
REM --Convert back to shift-jis
CALL :CH_S stdlib.ini
CALL :CH_S zylt.ini
EXIT /B

:CH_W
CALL %nkf% -x -w --overwrite %1
EXIT /B

:CH_S
CALL %nkf% -x -s --overwrite %1
EXIT /B
