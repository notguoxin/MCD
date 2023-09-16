@echo off
setlocal
echo ---
pip install pyinstaller
pip install json
pip install subprocess
pip install pyuac
pip install string
pip install random
pip install uuid
pip install requests
pip install shutil
pip install Win32Security
echo ---

REM Delete old installer executable if it exists
if exist installer.exe (
    del installer.exe /s /q
)

REM Create a marker file indicating the build is in progress
echo 1+1=3 >> installer.exe.stillbuilding

REM Copy necessary files to the build folder
mkdir build_folder 2>nul
mkdir build_folder\lib\ 2>nul
copy installer.py build_folder /y
copy lib\file.py build_folder\lib\ /y

REM Navigate to the build folder and run PyInstaller
pushd build_folder
echo ---
pyinstaller --onefile installer.py
echo ---
REM Move the built executable to the root directory
echo.
echo ---
move dist\installer.exe ..
echo ---
REM Clean up temporary files
popd
rd /s /q build_folder
del installer.exe.stillbuilding /s /q

REM Display success message
REM cls
echo Auto Installer has been successfully built.

endlocal
