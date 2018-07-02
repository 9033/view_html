echo off
chcp 65001
set outputfile=view_list_no-js.html
call :genhtml
pause
goto eof

:forloop
echo ^<a href="%~1\%outputfile%"^>%~1^</a^>^<br^>  >> %outputfile%
setlocal
cd %1
call :genhtml
endlocal
goto eof

:genhtml
call :htmlhead
for /d %%d in (*) do call :forloop "%%d"
call :imgtagging
call :videotagging
call :htmltale
goto eof

:videotagging
for %%i in (*.webm) do echo ^<video controls^>^<source src="%%i" type="video/webm"^>^</video^>^<br^>  >> %outputfile%
for %%i in (*.mp4) do echo ^<video controls^>^<source src="%%i" type="video/mp4"^>^</video^>^<br^>  >> %outputfile%
goto eof

:imgtagging
for %%i in (*.jpg,*.jpeg,*.gif,*.png) do echo ^<img src="%%i"^>^<br^>  >> %outputfile%
goto eof

:htmlhead
echo ^<!DOCTYPE html^>^<html^>^<head^>^<meta charset="UTF-8"^>^<style^>p{font-size:50px;} body{background-color:#888888;color:white;}^</style^>^</head^>^<body^>^<p id="root_tag"^>^</p^> > %outputfile%
goto eof

:htmltale
echo ^</body^>^</html^>  >> %outputfile%
goto eof

:eof
::'call afunc'가 실행되면 파일 끝까지 실행됨.
:: call afunc에서 입력 받는 변수(여기서는 폴더명)을 따옴표로 감쌈
:: afunc에서 물결을 넣어서 따옴표를 없엠
