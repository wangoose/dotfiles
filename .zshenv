# Android
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# Homebrew
export PATH=/opt/homebrew/bin:$PATH

# User binaries
export PATH="$HOME/.local/bin:$PATH"

# Starship locale
export LANG=en_US.UTF-8

# Environment variables
[[ -f "$HOME/.env" ]] && source "$HOME/.env"
[[ -f "$HOME/.env.local" ]] && source "$HOME/.env.local"
