# History
HISTFILE=~/.local/share/zsh/history
HISTSIZE=50000
SAVEHIST=50000
mkdir -p "${HISTFILE:h}"

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history

# General options
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt extended_glob
setopt no_match
setopt notify
setopt beep

# Vi mode
bindkey -v
export KEYTIMEOUT=10

# Cursor shape: beam for insert, block for normal
zle-keymap-select() {
    case $KEYMAP in
        vicmd)      print -n '\e[1 q' ;;
        viins|main) print -n '\e[5 q' ;;
    esac
}
zle -N zle-keymap-select

# Start with beam cursor
zle-line-init() { print -n '\e[5 q' }
zle -N zle-line-init

# Preserve useful bindings in insert mode
bindkey '^[[3~' delete-char
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line

# Completion
autoload -Uz compinit
compinit -C

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'

# Directory hashes
hash -d cfg=~/.config
hash -d dl=~/Downloads
hash -d dot=~/.dotfiles
hash -d repos=~/source/repos
