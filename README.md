# dotfiles

Fedora + Hyprland desktop environment built around a warm custom Gruvbox palette called **Ember**.

Managed as a bare git repo (`~/.dotfiles`) with `$HOME` as the work tree.

## Stack

| Layer | Tool |
|-------|------|
| WM | Hyprland (dwindle, no animations) |
| Bar | Waybar |
| Terminal | Kitty (75% opacity, powerline tabs) |
| Shell | ZSH (modular config in `~/.config/zsh/`) |
| Prompt | Starship (powerline, vi-mode) |
| Editor | Neovim (lazy.nvim) |
| Launcher | Fuzzel |
| Lockscreen | Hyprlock |
| Notifications | SwayNC |
| File manager | Double Commander |

## Tools

- **mise** - runtime manager (bun, dotnet, java, kotlin, node, rust)
- **sheldon** - ZSH plugin manager (autosuggestions, syntax-highlighting, fzf-tab)
- **atuin** - shell history
- **direnv** - per-directory environments
- **zoxide** - smart cd
- **eza** - ls replacement
- **bat** - cat replacement
- **fd** / **fzf** - file finder / fuzzy filter
- **starship** - cross-shell prompt
- **delta** - git diff pager (side-by-side)
- **jq** - JSON processor
- **btop** - system monitor
- **podman** - containers
- **grim** / **slurp** / **swappy** - screenshot pipeline
- **wf-recorder** - screen recording
- **playerctl** - media player control
- **wl-clipboard** - Wayland clipboard
- **solaar** - Logitech device manager
- **ddcutil** - monitor brightness (DDC/CI)
- **udiskie** - USB automount

## Ember palette

A warm Gruvbox variant with orange (`#fe8019`) as the primary accent. Full palette and ports: [MichalWilk/ember-color-scheme](https://github.com/MichalWilk/ember-color-scheme).

```
bg      #1a1918      fg      #e8e4dd
bg1     #2e2c2a      fg_dim  #9a9491
bg2     #3e3c3a

red     #e85045      green   #85b829
yellow  #f0be38      blue    #5296c8
purple  #a87ac0      cyan    #5eb8a8
orange  #fe8019
```

Colors are defined per-tool (Hyprland, Waybar, SwayNC, Kitty, Neovim, Starship, FZF) using the same hex values. Hyprland-specific colors are centralized in [`colors.conf`](.config/hypr/colors.conf).

## Structure

- `.config/hypr/` - Hyprland, Hyprlock, Hypridle, Hyprpaper + [`colors.conf`](.config/hypr/colors.conf) as single source of truth for palette
- `.config/nvim/` - Neovim with lazy.nvim, plugins split into `ui`, `editor`, `lsp`, `formatting`
- `.config/zsh/` - modular shell: `env`, `tools`, `options`, `aliases`, `functions`
- `.config/waybar/` - bar config + Ember-styled CSS
- `.config/kitty/` - terminal + 16-color Ember theme
- `bin/` - custom scripts used by Waybar and keybinds (screenshot, power-menu, sysmon-status, etc.)

## Key bindings

Navigation is vim-style (`hjkl`) everywhere - Hyprland, Neovim, FZF, Kitty splits.

Full bindings in [`hyprland.conf`](.config/hypr/hyprland.conf). Logitech MX Mechanical key remaps (XF86 keysyms) in [`solaar/rules.yaml`](.config/solaar/rules.yaml).

## Install

```sh
git clone --bare <repo-url> $HOME/.dotfiles
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout
dot config --local status.showUntrackedFiles no
```

## Dotfiles management

```sh
dot status              # or: dots
dot add <file>          # or: dota <file>
dot commit              # or: dotc
dot push                # or: dotp
dot diff                # or: dotd
```
