#!/bin/bash

echo "Installing ComfyUI_LayerStyle dependencies for Colab..."

# Define paths
COMFYUI_DIR="/content/ComfyUI"
LAYER_STYLE_DIR="$COMFYUI_DIR/custom_nodes/ComfyUI_LayerStyle"

# Use the Python from ComfyUI's environment if available
if [ -d "$COMFYUI_DIR" ] && [ -f "$COMFYUI_DIR/main.py" ]; then
  PYTHON_EXEC="python"  # Use system Python in Colab context
else
  echo "Error: ComfyUI installation not found at $COMFYUI_DIR"
  echo "Please install ComfyUI first."
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
done < "$LAYER_STYLE_DIR/requirements.txt"

echo
echo "Installation complete!" 