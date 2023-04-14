@echo off
setlocal

set "SOURCE_DIR=C:\source"
set "OUTPUT_DIR=C:\output"
set "LIB_DIR=C:\libs"

for /r "%SOURCE_DIR%" %%f in (*.java) do (
    echo Compiling "%%~ff"
    set "CLASSPATH=%LIB_DIR%\*.jar"
    javac -cp "%CLASSPATH%" -d "%OUTPUT_DIR%" "%%~ff"
)

echo Compilation complete.
