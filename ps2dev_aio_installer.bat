@echo off
setlocal

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0ps2dev_aio_installer.ps1" %*
exit /b %ERRORLEVEL%
