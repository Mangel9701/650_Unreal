@echo off
setlocal

set "UE_ROOT=E:\Program Files\Epic Games\UE_5.6"
set "PROJECT_FILE=E:\Documentos\Trabajos\GlobalSnopek\650\Unreal\P650\P650.uproject"
set "ARCHIVE_DIR=E:\Documentos\Trabajos\GlobalSnopek\650\Unreal\P650\Builds\Windows"

if not exist "%UE_ROOT%\Engine\Build\BatchFiles\RunUAT.bat" (
    echo ERROR: No se encontro RunUAT.bat en "%UE_ROOT%".
    exit /b 1
)

if not exist "%PROJECT_FILE%" (
    echo ERROR: No se encontro el proyecto "%PROJECT_FILE%".
    exit /b 1
)

if not exist "%ARCHIVE_DIR%" (
    mkdir "%ARCHIVE_DIR%"
)

echo Empaquetando P650 para Windows...
echo Salida: "%ARCHIVE_DIR%"
echo.

call "%UE_ROOT%\Engine\Build\BatchFiles\RunUAT.bat" BuildCookRun ^
    -project="%PROJECT_FILE%" ^
    -noP4 ^
    -platform=Win64 ^
    -clientconfig=Development ^
    -serverconfig=Development ^
    -cook ^
    -build ^
    -stage ^
    -pak ^
    -archive ^
    -archivedirectory="%ARCHIVE_DIR%"

set "RESULT=%ERRORLEVEL%"
echo.

if "%RESULT%"=="0" (
    echo Empaquetado completado correctamente.
) else (
    echo ERROR: El empaquetado fallo con codigo %RESULT%.
)

exit /b %RESULT%
