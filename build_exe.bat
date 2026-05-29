@echo off
REM Build script para generar GlassTracker.exe (Windows)
echo Construyendo GlassTracker...
python -m pip install --upgrade pyinstaller
python -m PyInstaller --noconfirm --onefile --windowed --add-data "tasks.json;." --name GlassTracker glass_tracker_gui.py
echo Terminado. El ejecutable se encuentra en "dist\\GlassTracker.exe"
echo Presiona una tecla para salir...
pause >nul
