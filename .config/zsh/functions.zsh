chpwd() { eza --icons }

# unpack - archive extractor
unpack() {
    case "$1" in
        *.tar.gz|*.tgz)    tar xzf "$1" ;;
        *.tar.bz2|*.tbz2)  tar xjf "$1" ;;
        *.tar.xz|*.txz)    tar xJf "$1" ;;
        *.tar.zst)         tar --zstd -xf "$1" ;;
        *.tar)             tar xf "$1" ;;
        *.gz)              gunzip "$1" ;;
        *.bz2)             bunzip2 "$1" ;;
        *.xz)              unxz "$1" ;;
        *.zst)             unzstd "$1" ;;
        *.zip)             unzip "$1" ;;
        *.rar)             unrar x "$1" ;;
        *.7z)              7z x "$1" ;;
        *)                 echo "unknown format: $1" ;;
    esac
}

mkcd() { mkdir -p "$1" && cd "$1" }

# take - mkcd or clone + cd
take() {
    if [[ "$1" =~ ^((https?|git)://|git@).+\.git$ ]]; then
        git clone "$1" && cd "$(basename "$1" .git)"
    else
        mkcd "$1"
    fi
}

# fkill - fuzzy process kill
fkill() {
    local sig="${1:-15}"
    [[ "$sig" =~ ^[0-9]+$ ]] || { echo "invalid signal: $sig"; return 1; }
    local pid
    pid=$(ps -ef | sed 1d | fzf -m --header='Select process to kill' | awk '{print $2}')
    if [[ -n "$pid" ]]; then
        echo "$pid" | while IFS= read -r p; do kill -"$sig" "$p"; done
    fi
}

cht() { curl -s "https://cheat.sh/$1" | bat --paging=always --plain }

port() { ss -tlnp | grep ":$1 " }

# dotsync - dotfiles commit + push
dotsync() {
    local unstaged
    unstaged=$(dot diff --name-only)
    [[ -z "$unstaged" ]] && { echo "Nothing to sync."; return 0; }
    dot add -u
    dot diff --cached --stat
    echo
    read -q "?Commit and push? [y/N] " || { echo; echo "$unstaged" | xargs -d '\n' dot reset HEAD --; return 1; }
    echo
    dot commit -m "${1:-sync dotfiles}"
    dot push
}

# gsw - fuzzy branch switch
gsw() {
  local branch
  branch=$(git branch --all --sort=-committerdate --format='%(refname:short)' | fzf --height 40%)
  [ -n "$branch" ] && git switch "${branch#origin/}"
}
