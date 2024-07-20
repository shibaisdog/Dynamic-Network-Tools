@echo off
cd "%~dp0/dnt"
dart pub get
dart compile exe "%~dp0/dnt/bin/main.dart" -o "%~dp0/dnt.exe"
setx Path "%~dp0"