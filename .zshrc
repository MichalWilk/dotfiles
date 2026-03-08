ZSH_CONFIG="$HOME/.config/zsh"
for f in env tools options aliases functions; do
    [[ -f "$ZSH_CONFIG/$f.zsh" ]] && source "$ZSH_CONFIG/$f.zsh"
done
