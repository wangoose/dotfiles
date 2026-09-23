# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-hangul zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Zsh 
alias cls="clear"
alias ls="lsd"
alias ll="lsd -alhF"
alias pbc="pbcopy"
alias pbp="pbpaste"

alias zrc="vim ~/.zshrc"
alias zsc="source ~/.zshrc"

# Starship
if [[ -n "$SSH_CONNECTION" ]]; then
  export STARSHIP_CONFIG="$HOME/.config/starship/starship-xterm-256color.toml"
else
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
fi

eval "$(starship init zsh)"

# ADB
alias adbb="eval adb \$("android-select-device.sh")"
alias adbd="adb devices -l"
alias adbk="adb kill-server; adb start-server"
alias adbs="adbb shell"
alias adbt="adbb tcpip 5555"
alias adbc='adbb shell ip addr show wlan0 | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -1 | awk '\''{system("adb connect " $1 ":5555")}'\'
adbcc() { adb connect "192.168.1.$1:5555" }
adbp() { adb pair "192.168.1.$1:$2" }
adbdl() { adbb shell "am start -W -a android.intent.action.VIEW -d \"$1\"" }
alias adbsd="adbb shell setprop debug.layout true"
alias adbsdd="adbb shell setprop debug.layout false"
adbas() { adbb shell am start -a $1 }
adbaf() { adbb shell am force-stop $1 }
adbit() { adbb shell input text $1 }
adbpu() { adbb shell pm uninstall $1 }
adbpc() { adbb shell pm clear $1 }
adbsc() { adbb exec-out screencap -p > "capture_$(date +%Y%m%d_%H%M%S).png" }

alias sym='find . -name "__MACOSX" -type d -exec rm -rf {} \; && find . -name ".DS_Store" -type f -exec rm -rf {} \; && zip -r ../native-debug-symbols.zip ./* && open ../'

dao="com.deepfine.aron"
daoo="deepfine.ai"
daos="com.deepfine.aron/deepfine.ai.feature.version.view.SplashActivity"
daoos="deepfine.ai/deepfine.ai.features.version.view.SplashActivity"
dsv="com.deepfine.spatialViewer"
dsvs="com.deepfine.spatialViewer/com.deepfine.home.view.SchemeActivity"
set="android.settings.SETTINGS"
dev="android.settings.APPLICATION_DEVELOPMENT_SETTINGS"

# Scrcpy
scrcpy() { $HOME/.local/bin/scrcpy "$@" }

scr() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps 30 \
    --max-size=1920 \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --turn-screen-off \
    --video-bit-rate=5M
}

scrr() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps 24 \
    --max-size=1280 \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --turn-screen-off \
    --video-bit-rate=2M \
    --video-buffer=100
}

scrrr() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps=15 \
    --max-size=720 \
    --no-audio \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --stay-awake \
    --turn-screen-off \
    --video-bit-rate=1M \
    --video-buffer=200
}

scrc() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps 30 \
    --max-size=1920 \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --stay-awake \
    --record "$(date +%Y%m%d_%H%M%S).mp4" \
    --video-bit-rate=5M
}

scrrc() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps 24 \
    --max-size=1280 \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --stay-awake \
    --record "$(date +%Y%m%d_%H%M%S).mp4" \
    --video-bit-rate=2M \
    --video-buffer=100
}

scrrrc() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps=15 \
    --max-size=720 \
    --no-audio \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --stay-awake \
    --video-bit-rate=1M \
    --video-buffer=200 \
    --record "$(date +%Y%m%d_%H%M%S).mp4"
}

scrt() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps 30 \
    --max-size=1920 \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --tcpip \
    --turn-screen-off \
    --video-bit-rate=5M
}

scrrt() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps 24 \
    --max-size=1280 \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --tcpip \
    --turn-screen-off \
    --video-bit-rate=2M \
    --video-buffer=100 
}

scrrrt() {
  scrcpy $("android-select-device.sh") \
    --keyboard=uhid \
    --max-fps=15 \
    --max-size=720 \
    --no-audio \
    --power-off-on-close \
    --shortcut-mod=lctrl,lalt,lsuper \
    --tcpip \
    --turn-screen-off \
    --video-bit-rate=1M \
    --video-buffer=200
}

# Mise
eval "$(mise activate zsh)"

# Mole shell completion
if output="$(mole completion zsh 2>/dev/null)"; then eval "$output"; fi

# Miniforge3
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wangoose/Development/Tools/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/wangoose/Development/Tools/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/wangoose/Development/Tools/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/wangoose/Development/Tools/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/wangoose/Development/Tools/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/wangoose/Development/Tools/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# Codex CLI with Headroom + Serena
alias coc="vim ~/.codex/config.toml"

cdx() {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    local port="$1"; shift
    headroom wrap codex --code-memory none -c "mcp_servers.serena.url=\"http://127.0.0.1:${port}/mcp\"" "$@"
  else
    headroom wrap codex --code-memory none "$@"
  fi
}

cdx-df() {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    local port="$1"; shift
    CODEX_HOME=~/.codex-df headroom wrap codex --code-memory none -c "mcp_servers.serena.url=\"http://127.0.0.1:${port}/mcp\"" "$@"
  else
    CODEX_HOME=~/.codex-df headroom wrap codex --code-memory none "$@"
  fi
}

# Start Serena MCP Server over Streamable HTTP
ser() {
  local port="${1:-9121}"
  local project="${2:-$(pwd)}"

  serena start-mcp-server \
    --transport streamable-http \
    --port "$port" \
    --context codex \
    --project "$project"
}

