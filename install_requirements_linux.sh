#!/bin/bash

echo "Installing ComfyUI_LayerStyle dependencies for Colab..."

# Set the path to the Python executable in the virtual environment using a relative path
PYTHON_EXEC="../../venv/bin/python"

# Check if the Python executable exists
if [ ! -f "$PYTHON_EXEC" ]; then
  echo "Error: Python executable not found at $PYTHON_EXEC (relative to current script)"
  echo "Please ensure the ComfyUI virtual environment is set up correctly."
  exit 1
fi

echo "1. Uninstalling conflicting packages..."
$PYTHON_EXEC -m pip uninstall -y onnxruntime opencv-python opencv-contrib-python opencv-python-headless opencv-contrib-python-headless

echo "2. Installing requirements individually..."
# Reading and installing requirements one by one for better error handling
while read requirement; do
    if [ ! -z "$requirement" ] && [[ ! "$requirement" =~ ^# ]]; then
        echo "Installing: $requirement"
        $PYTHON_EXEC -m pip install "$requirement"
    fi
done < "requirements.txt"

echo
echo "Installation complete!" 