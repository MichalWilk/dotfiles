# dotfiles

Fedora + Hyprland desktop environment built around a warm custom Gruvbox palette called **Ember**.

Managed as a bare git repo (`~/.dotfiles`) with `$HOME` as the work tree.

## Stack

| Layer | Tool |
|-------|------|
| WM | Hyprland (dwindle, no animations) |
| Bar | Waybar |
| Terminal | Alacritty + tmux |
| Shell | ZSH (modular config in `~/.config/zsh/`) |
| Prompt | Starship (powerline, vi-mode) |
| Editor | Neovim (lazy.nvim) |
| Launcher | Fuzzel |
| Lockscreen | Hyprlock |
| Notifications | SwayNC |
| Cursor | Apple Cursor (macOS) |
| Runtime manager | mise |
| ZSH plugins | sheldon |
| Other | bat, btop, gitui, mpv, solaar, swappy |

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

Colors are defined per-tool (Hyprland, Waybar, SwayNC, Alacritty, tmux, Neovim, Starship, FZF) using the same hex values. Hyprland-specific colors are centralized in [`colors.conf`](.config/hypr/colors.conf).

## Cursor theme

[Apple Cursor (macOS)](https://github.com/ful1e5/apple_cursor) - not packaged in Fedora, install manually:

```sh
curl -sL https://github.com/ful1e5/apple_cursor/releases/latest/download/macOS.tar.xz -o /tmp/macOS-cursor.tar.xz
tar xf /tmp/macOS-cursor.tar.xz -C ~/.local/share/icons/
mkdir -p ~/.icons && ln -sfn ~/.local/share/icons/macOS ~/.icons/macOS
mkdir -p ~/.local/share/icons/default
cat > ~/.local/share/icons/default/index.theme << 'EOF'
[Icon Theme]
Name=Default
Comment=Default cursor theme
Inherits=macOS
EOF
gsettings set org.gnome.desktop.interface cursor-theme 'macOS'
gsettings set org.gnome.desktop.interface cursor-size 32
flatpak override --user --filesystem=~/.local/share/icons:ro --filesystem=~/.icons:ro
```

The `default/index.theme` is an XDG fallback that fixes Flatpak Electron apps ignoring XCURSOR_THEME.

## Structure

Configs live in `~/.config/` (hypr, alacritty, tmux, nvim, zsh, waybar, starship, etc.). Non-standard paths:

- `.config/hypr/colors.conf` - single source of truth for Ember palette
- `.config/nvim/` - lazy.nvim plugins split into `ui`, `editor`, `lsp`, `formatting`
- `.config/zsh/` - modular shell: `env`, `tools`, `options`, `aliases`, `functions`
- `bin/` - custom scripts used by Waybar and keybinds (screenshot, power-menu, sysmon-status, etc.)

## Key bindings

Navigation is vim-style (`hjkl`) everywhere.

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
