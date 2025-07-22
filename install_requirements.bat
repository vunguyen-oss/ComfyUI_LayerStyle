@echo off

set "python_exec=..\..\..\python_embeded\python.exe"
set "requirements_txt=%~dp0\requirements.txt"

echo Installing ComfyUI_LayerStyle dependencies...
echo.

echo 1. Uninstalling conflicting packages...
%python_exec% -s -m pip uninstall -y onnxruntime opencv-python opencv-contrib-python opencv-python-headless opencv-contrib-python-headless

echo 2. Installing all requirements...
%python_exec% -s -m pip install -r %requirements_txt%

echo.
echo Installation complete!
pause

