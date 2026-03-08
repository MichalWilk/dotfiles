if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    start-hyprland || exec zsh
fi

# ── Sync PATH to environment.d for GUI apps (once at login) ──
mkdir -p ~/.config/environment.d
install -m 600 /dev/null ~/.config/environment.d/paths.conf
echo "PATH=$PATH" > ~/.config/environment.d/paths.conf

