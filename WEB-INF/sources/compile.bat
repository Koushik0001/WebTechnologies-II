@echo off
setlocal

set "SOURCE_DIR=."
set "OUTPUT_DIR=..\classes"
set "ROOT_DIR=%cd%"

cd "..\lib"
set "CLASS_FILES="
for /r "custom\" %%f in (*.java) do (
    echo:
    echo Compiling %%~nxf
    javac "%%~ff"
    set "CLASS_FILES=%CLASS_FILES% custom\%%~nf.class"
)

echo %CLASS_FILES%
jar cvf custom.jar %CLASS_FILES%
cd %ROOT_DIR%

if not exist %OUTPUT_DIR% (
    echo.
    md %OUTPUT_DIR%
    echo %OUTPUT_DIR% directory created successfully... 
    echo.
)


for /r "%SOURCE_DIR%" %%f in (*.java) do (
    echo:
    echo Compiling "%%~nxf"
    javac -cp "..\..\..\..\lib\*;..\lib\*;." -d "%OUTPUT_DIR%" "%%~ff" 
)

echo.
echo.
echo Compilation complete.
echo.
pause

