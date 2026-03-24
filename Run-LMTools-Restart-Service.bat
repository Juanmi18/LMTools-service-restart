@echo off
REM Lanzador sencillo para el script de PowerShell que reinicia el servidor de licencias Autodesk
REM AJUSTA LA RUTA AL .ps1 SEGUN TU ENTORNO

powershell -ExecutionPolicy Bypass -File "%~dp0LMTools-Restart-Service.ps1"

pause