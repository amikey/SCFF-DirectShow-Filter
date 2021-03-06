@echo off
set VC2015_REGKEY=HKLM\SOFTWARE\Microsoft\DevDiv\VC\Servicing\14.0\RuntimeMinimum
set VC2015_WOW6432_REGKEY=HKLM\SOFTWARE\WOW6432Node\Microsoft\DevDiv\VC\Servicing\14.0\RuntimeMinimum

rem ===================================================================
:_CHECK_RUNTIME
rem ===================================================================
reg query "%VC2015_REGKEY%" /v "Install" >NUL 2>&1
if ERRORLEVEL 1 goto _NO_VC2015_RUNTIME
if "%PROCESSOR_ARCHITECTURE%"=="x86" goto _MAIN_X86
reg query "%VC2015_WOW6432_REGKEY%" /v "Install" >NUL 2>&1
if ERRORLEVEL 1 goto _NO_VC2015_32BIT_RUNTIME
goto _MAIN_AMD64

rem ===================================================================
:_NO_VC2015_RUNTIME
rem ===================================================================
echo "Please install Visual C++ Redistributable Packages for Visual Studio 2015 at first"
pause
exit /b

rem ===================================================================
:_NO_VC2015_32BIT_RUNTIME
rem ===================================================================
echo "Please install Visual C++ Redistributable Packages for Visual Studio 2015 (32bit) at first"
pause
exit /b

rem ===================================================================
:_MAIN_X86
rem ===================================================================
set ROOT_DIR=%~dp0
pushd "%ROOT_DIR%"
regsvrex32 "Win32\scff_dsf_Win32.ax"
popd
exit /b

rem ===================================================================
:_MAIN_AMD64
rem ===================================================================
set ROOT_DIR=%~dp0
pushd "%ROOT_DIR%"
regsvrex32 "Win32\scff_dsf_Win32.ax"
regsvrex64 "x64\scff_dsf_x64.ax"
popd
exit /b