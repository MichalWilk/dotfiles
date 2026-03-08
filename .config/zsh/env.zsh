export EDITOR=nvim
export VISUAL=nvim

export PAGER='bat --paging=always'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_DEFAULT_OPTS="
  --color=bg+:#2e2c2a,bg:#1a1918,fg:#e8e4dd,fg+:#e8e4dd
  --color=hl:#fe8019,hl+:#fe8019,info:#9a9491,marker:#85b829
  --color=prompt:#fe8019,spinner:#a87ac0,pointer:#fe8019,header:#5296c8
  --color=border:#3e3c3a,separator:#3e3c3a
  --bind 'ctrl-j:down,ctrl-k:up'
  --border rounded
  --height 40%
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --preview-window right:50%"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --level=2 {}'"

export CDPATH=".:$HOME/source/repos"
