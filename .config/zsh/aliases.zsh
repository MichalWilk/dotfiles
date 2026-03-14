# Filesystem
alias ls='eza --icons'
alias ll='eza -la --icons --group-directories-first'
alias la='eza -a --icons'
alias lt='eza -la --icons --sort modified'
alias tree='eza --tree --icons'
alias tree2='eza --tree --icons --level=2'
alias tree3='eza --tree --icons --level=3'

alias cat='bat --paging=never'
alias catp='bat --paging=never --plain'
alias ..='cd ..'
alias ...='cd ../..'

# Safety
alias rm='rm -I'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -p'

# Utils
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ip='ip --color=auto'

# Neovim
alias vi='nvim'
alias vim='nvim'
alias svim='sudoedit'

# Git
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl='git log --oneline -20'
alias gp='git pull'
alias gpu='git push'
alias gui='gitui'

# Podman
alias dk='podman'
alias dkps='podman ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dki='podman images'
alias dkl='podman logs -f'
alias dke='podman exec -it'

# Dotfiles
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dots='dot status'
alias dota='dot add'
alias dotc='dot commit'
alias dotd='dot diff'
alias dotl='dot log --oneline -20'
alias dotp='dot push'

# Mise
alias mx='mise exec --'
alias mr='mise run'
alias mi='mise install'
alias mu='mise use'

# Quick edit
alias zrc='nvim ~/.config/zsh/'
alias hrc='nvim ~/.config/hypr/hyprland.conf'
alias arc='nvim ~/.config/alacritty/alacritty.toml'
