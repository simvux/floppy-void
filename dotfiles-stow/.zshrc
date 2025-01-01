PROMPT=" %F{2}∀ %F{3}%20d%u%F{4} > %F{2}"

# Everything initializes too quickly and Hyprland reports the incorrect window size 
# leading to an artifact. 
sleep 0.05s

autoload -Uz compinit
compinit

# unsetopt PROMPT_SP

if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    export XKB_DEFAULT_LAYOUT=se
    export PATH="$HOME/.local/bin:$PATH"
    exec dbus-run-session Hyprland
fi

source /home/simon/.alias
source $HOME/.antidote/antidote.zsh
antidote load

# Environment
export LUMINAPATH=/home/simon/code/rust/lumina/luminapath/
export lumina=/home/simon/code/rust/lumina
export GOPATH=/home/simon/code/go
export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH=/home/simon/.cargo/bin:/opt/rocm/bin:/home/simon/.local/bin:$NPM_PACKAGES/bin:$GOPATH/bin:$PATH

# Vim-Mode plugin cursor switching
MODE_CURSOR_VIINS="#ff89ff blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff89ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #ff89ff"
KEYTIMEOUT=1

# Less colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

function ask() {
    # (. ~/app/sgpt-env/bin/activate && sgpt --chat 'aliased-chat' $1)
    /home/simon/app/sgpt-env/sgpt/dist/app --chat 'aliased-chat' $1
}

# Automatically ls after cd
function chpwd() {
    emulate -L zsh
    ls
}
