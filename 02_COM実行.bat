@ECHO OFF

REM --���ϐ�
CALL C:\init\init.bat

FOR /F "usebackq" %%A IN (`DIR /S/B ".\*.COM"`) DO SET ComFile=%%A
msdos %ComFile%
ECHO;

PAUSE
EXIT
