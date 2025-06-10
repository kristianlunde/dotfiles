#!/usr/bin/env bash

set -e

echo "🔧 Installing Ollama..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "📦 Detected macOS, using brew..."
  if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew is not installed. Install it first: https://brew.sh/"
    exit 1
  fi
  brew install ollama
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "📦 Detected Linux, using official script..."
  curl -fsSL https://ollama.com/install.sh | sh
else
  echo "❌ Unsupported OS: $OSTYPE"
  exit 1
fi

# Check ollama exists now
if ! command -v ollama &>/dev/null; then
  echo "❌ ollama command not found after installation."
  echo "🔧 Try restarting your terminal, or add it to your PATH manually:"
  echo '    export PATH="$HOME/.ollama/bin:$PATH"'
  exit 1
fi

echo "✅ Ollama installed."

# Pull models
echo "📥 Pulling models..."
ollama pull mistral:7b-instruct
ollama pull deepseek-coder

echo "✅ Models pulled:"
ollama list

echo "🎉 Done! Try:"
echo "    ollama run mistral:7b-instruct"
echo "    ollama run deepseek-coder:13b-instruct"
