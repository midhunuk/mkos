#!/bin/bash

# Default venv directory name
VENV_DIR=${1:-venv}

# Check if python3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ python3 could not be found. Please install it first."
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "🔧 Creating virtual environment in '$VENV_DIR'..."
    python3 -m venv "$VENV_DIR"
    echo "✅ Virtual environment created."
else
    echo "ℹ️ Virtual environment already exists at '$VENV_DIR'."
fi

# Print activation instructions
echo ""
echo "🚀 To activate the virtual environment, run:"
echo "source $VENV_DIR/bin/activate"


