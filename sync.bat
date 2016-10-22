@echo off
echo ***** NOTICE *****
echo **************************
echo "Music should be present in => C:\Music\"
echo "MP3 player should be mounted in => H:\"
set /p input="Press y to continue or any other key to quit ..."
echo 
if %input% neq y exit()
@echo on

H:
dir /b | findstr /v /i "\.txt$" > folders.txt
for /f "delims=?" %%a in (folders.txt) do (
dir /d /s /b "H:\%%a\" | findstr /v /i "\.txt$" > songs.txt
for /f "delims=?" %%b in (songs.txt) do (
echo y | del "%%b"
)
rd "H:\%%a"
)
del "H:\folders.txt"
del "H:\songs.txt"

C:
dir "C:\Music\" /b /on > "C:\folderlist.txt"
for /f "delims=?" %%a in (C:\folderlist.txt) do (
mkdir "H:\%%a"
dir "C:\Music\%%a\*" /b /on > songlist.txt
for /f "delims=?" %%b in (songlist.txt) do (
copy "C:\Music\%%a\%%b" "H:\%%a\%%b"
)
)
del "C:\folderlist.txt"
del "C:\songlist.txt"

tree H: /f /a > tmp.txt
notepad tmp.txt
del tmp.txt
set /p quit=Completed copying, press any key to continue ...
