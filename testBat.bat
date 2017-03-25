@echo off

call :run -i "test.txt"
echo output
@echo on

GOTO End
::--------------------------------------------------------
::-- Function section starts below here
::--------------------------------------------------------
:run
rem call .stack-work\dist\ca59d0ab\build\flp-fun-xzemek04-exe\flp-fun-xzemek04-exe.exe %~1 %~2
for /f %%i in ('.stack-work\dist\ca59d0ab\build\flp-fun-xzemek04-exe\flp-fun-xzemek04-exe.exe %~1 %~2') do set VAR=%%i
echo %VAR%
:End