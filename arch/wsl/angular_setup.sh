#!/bin/bash

# Exit on any error
set -e

echo "📦 Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load nvm for the script
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "🔍 Verifying NVM installation..."
nvm --version || { echo "❌ NVM failed to install."; exit 1; }

echo "⬇️ Installing Node.js v22..."
nvm install 22
nvm use 22
nvm alias default 22

echo "🔍 Verifying Node.js installation..."
node -v || { echo "❌ node not working."; exit 1;}

echo "🔍 Verifying npm..."
npm -v || { echo "❌ npm not working."; exit 1; }

echo "🌐 Installing Angular CLI..."
npm install -g @angular/cli

echo "🔍 Verifying Angular CLI..."
ng version || { echo "❌ angular cli not working."; exit 1; }

echo "✅ Setup complete!"
echo "🔁 Add this to your shell config (~/.bashrc, ~/.zshrc, etc.):"
echo 'export NVM_DIR="$HOME/.nvm"'
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
