@echo off
cd "%~dp0/dnt"
dart pub get
dart compile exe "%~dp0/dnt/bin/main.dart" -o "%~dp0/dnt.exe"
setx DNT_Path "%~dp0"
pause