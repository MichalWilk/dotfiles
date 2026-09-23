-- Hyprland config migrated from hyprland.conf (hyprlang) to Lua.
-- hyprlang is deprecated since Hyprland 0.55 and will be removed in a future release.
-- Colors are inlined below; colors.conf stays for hyprlock (still hyprlang).

------------------------------------------------------------
-- Variables
------------------------------------------------------------

local terminal    = "alacritty"
local fileManager = "doublecmd-qt --no-splash"
local menu        = "fuzzel"
local mainMod     = "SUPER"

local xdgRuntime = os.getenv("XDG_RUNTIME_DIR")

-- Ember palette (subset used for borders)
local orange_a = "rgba(fe8019ff)"
local yellow_a = "rgba(f0be38ff)"
local bg2_a    = "rgba(3e3c3aff)"
local bg3_a    = "rgba(524f4dff)"

------------------------------------------------------------
-- Monitor
------------------------------------------------------------

hl.monitor({ output = "", mode = "3840x2160", position = "0x0", scale = 1.6 })

------------------------------------------------------------
-- Environment
------------------------------------------------------------

hl.env("XCURSOR_THEME", "macOS")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("TERMINAL", terminal)
hl.env("GNOME_KEYRING_CONTROL", xdgRuntime .. "/keyring")
hl.env("SSH_AUTH_SOCK", xdgRuntime .. "/keyring/ssh")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

------------------------------------------------------------
-- Autostart (former exec-once)
------------------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GNOME_KEYRING_CONTROL SSH_AUTH_SOCK")
    -- pulls in graphical-session.target, without which xdg-desktop-portal refuses to start
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("/usr/libexec/polkit-mate-authentication-agent-1")
    hl.exec_cmd("~/bin/gtk-init")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("udiskie --automount --notify --tray")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("solaar -w hide")
    hl.exec_cmd("lan-mouse daemon")
    hl.exec_cmd("/usr/bin/kdeconnectd")
    hl.exec_cmd("pike daemon")
    hl.exec_cmd("jetbrains-toolbox --minimize")
    hl.exec_cmd("bitwarden")
    hl.exec_cmd("flatpak run org.signal.Signal --start-in-tray")
    hl.exec_cmd("slack -u")
    hl.exec_cmd("podman-desktop --minimize")
    hl.exec_cmd("flatpak run com.discordapp.Discord --start-minimized")
    hl.exec_cmd("flatpak run com.rtosta.zapzap --hideStart")
    hl.exec_cmd("claude-desktop --startup")
    hl.exec_cmd("sh -c 'cd ~/bin/vendor/act_runner && ./act_runner daemon'")

    -- Workspace-pinned startup. VERIFY: exec rules table form (see notes).
    hl.exec_cmd("firefox", { workspace = "1 silent" })
    hl.exec_cmd(terminal, { workspace = "2 silent" })
    hl.exec_cmd("flatpak run com.spotify.Client")
    hl.exec_cmd("thunderbird", { workspace = "10 silent" })
end)

------------------------------------------------------------
-- Look and feel
------------------------------------------------------------

hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,
        border_size = 2,
        col = {
            active_border   = { colors = { orange_a, yellow_a }, angle = 45 },
            inactive_border = { colors = { bg2_a, bg3_a }, angle = 45 },
        },
        resize_on_border = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 14,
        rounding_power = 4,
        inactive_opacity = 0.94,
        shadow = {
            enabled = true,
            range = 20,
            render_power = 2,
            color = "rgba(00000066)",
            offset = { 0, 4 },
        },
        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            noise = 0.02,
            contrast = 0.9,
            brightness = 0.82,
            vibrancy = 0.15,
            popups = true,
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
        force_split = 2,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        vrr = 1,
        focus_on_activate = true,
    },

    cursor = {
        inactive_timeout = 5,
    },

    input = {
        kb_layout = "pl",
        numlock_by_default = true,
        follow_mouse = 1,
        natural_scroll = true,
        touchpad = {
            natural_scroll = true,
        },
    },
})

------------------------------------------------------------
-- Layer rules
------------------------------------------------------------

hl.layer_rule({ match = { namespace = "waybar" }, blur = true, blur_popups = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "launcher" }, blur = true, blur_popups = true, ignore_alpha = 0.1 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.3 })

------------------------------------------------------------
-- Keybindings
------------------------------------------------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd("~/bin/scratchpad term com.local.scratchterm " .. terminal .. " --class com.local.scratchterm -e tmux new-session -A -s scratch"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.exec_cmd("~/bin/scratchpad notes com.local.scratchnotes " .. terminal .. " --class com.local.scratchnotes -e tmux new-session -A -s notes nvim ~/notes"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("~/bin/focus-steal-toggle"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(terminal .. " --class com.local.wiremix -e wiremix"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(terminal .. " --class com.local.btop --title=btop -e btop"))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd("bitwarden"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("~/bin/power-menu"))

-- Logi mechanical media keys
-- keyboard lock key (solaar sends XF86ScreenSaver); hyprland 0.56 matches it only by code
hl.bind("code:160", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && pkill -RTMIN+10 waybar"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("ddcutil setvcp 10 + 10"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("ddcutil setvcp 10 - 10"), { locked = true, repeating = true })

-- macOS-like screenshot layout
hl.bind("CTRL + SHIFT + 1", hl.dsp.exec_cmd("~/bin/screenshot fullscreen"))
hl.bind("CTRL + SHIFT + 2", hl.dsp.exec_cmd("~/bin/screenshot window"))
hl.bind("CTRL + SHIFT + 3", hl.dsp.exec_cmd("~/bin/screenshot region"))
hl.bind("CTRL + SHIFT + 4", hl.dsp.exec_cmd("~/bin/screenshot record fullscreen"))
hl.bind("CTRL + SHIFT + 5", hl.dsp.exec_cmd("~/bin/screenshot record window"))
hl.bind("CTRL + SHIFT + 6", hl.dsp.exec_cmd("~/bin/screenshot record region"))
hl.bind("Print", hl.dsp.exec_cmd("~/bin/screenshot toggle"))

-- Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "d" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Resize window
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -40, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 40, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -40 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 40 }), { repeating = true })

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Window grouping (tabs)
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.group.next())

-- Logi extra hardware keys
hl.bind("XF86Explorer", hl.dsp.exec_cmd("~/bin/scratchpad desktop doublecmd-qt doublecmd-qt --no-splash"))
hl.bind("XF86Search", hl.dsp.exec_cmd(menu))
hl.bind("XF86Favorites", hl.dsp.exec_cmd("~/bin/emoji-pick"))

-- DDC/CI monitor control
hl.bind("CTRL + SHIFT + 0", hl.dsp.exec_cmd("~/bin/monitor input"))
hl.bind("CTRL + SHIFT + 9", hl.dsp.exec_cmd("~/bin/monitor mode"))

-- Mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0 }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0 }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40 }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40 }), { repeating = true })
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

------------------------------------------------------------
-- Window rules
------------------------------------------------------------

-- Single window - keep gaps, no border
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })

hl.window_rule({ match = { class = "^(spotify)$" }, workspace = "9 silent" })
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = "^$", title = "^$", xwayland = true }, no_focus = true })

-- JetBrains popup workaround
hl.window_rule({ match = { class = "^jetbrains-.+$", title = "^win.*" }, no_initial_focus = true, rounding = 0 })
hl.window_rule({ match = { class = "^jetbrains-.+$", title = "^Welcome to .+$" }, float = true, center = true })

hl.window_rule({ match = { class = "^(com.local.pike-tui)$" }, float = true, size = { "(monitor_w*0.8)", "(monitor_h*0.8)" }, center = true, pin = true })
hl.window_rule({ match = { class = "^(com.local.wiremix)$" }, float = true, size = { 600, 400 }, center = true, pin = true })
hl.window_rule({ match = { title = "^(btop)$" }, float = true, size = { "(monitor_w*0.8)", "(monitor_h*0.8)" }, center = true, pin = true })

hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { title = "^(Open File)$" }, float = true })
hl.window_rule({ match = { title = "^(Save As)$" }, float = true })
