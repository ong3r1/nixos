{ config
, pkgs
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      ############################
      ##  App defaults & Environment
      ############################
      env = [
        "HYPRCURSOR_THEME, Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE, 26"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_PLATFORMTHEME,qt6ct"
      ];

      ############################
      ##  Visual Tweak: General
      ############################
      general = {
        # Border size (in pixels)
        border_size = 1;

        # Colour definitions use ARGB (Alpha-Red-Green-Blue) format
        # 0xFFRRGGBB. The FF (Alpha) controls opacity.

        # Active window border colour (example: Cyan/Teal, opaque)
        "col.active_border" = "rgb(444466)"; # Or a gradient: "rgb(2A009A) rgb(C44569) 45deg"

        # Inactive window border colour (example: Dark Grey, opaque)
        "col.inactive_border" = "rgb(444444)";

        # --- NEW GAP SETTINGS ---
        gaps_in = 4; # Inner gap (between windows)
        gaps_out = 8; # Outer gap (to monitor edge)
      };

      ############################
      ##  Visual Tweak: Decoration
      ############################
      decoration = {
        # Rounded corners radius (in pixels)
        rounding = 8;

        # Power of the curve (2.0 is circular, higher is "squircular")
        rounding_power = 3.0;

        # Other decorative settings you might want:
        # blur.enabled = true;
        # shadow.enabled = true;
      };

      # Configure specific animations
      animations = {
        enabled = true;
        # Default speed is in deciseconds (1ds = 100ms). Lower is faster.
        # Format: animation=NAME, ONOFF, SPEED, CURVE [,STYLE]

        # Windows: Make them fast (Speed 4 = 400ms) and use the custom curve
        "animation" = [
          "windows, 1, 1, default, popin 98%"
          "windowsOut, 1, 1, default, popin 98%"

          # Workspaces: Use the same snappy curve but perhaps a different speed
          "workspaces, 1, 1, default"

          # Fallback (optional, but good practice)
          "border, 1, 5, default"
          "fade, 1, 5, default"
        ];
      };

      ############################
      ##  Keybindings
      ############################
      # We use ++ to merge the static list with the generated workspace list
      bind =
        [
          # --- Terminal & Launcher ---
          "$mod, Return, exec, ghostty"
          "$mod, d, exec, walker"

          # --- Window Management ---
          "$mod, q, killactive"
          "$mod Shift, space, togglefloating"
          "$mod, f, fullscreen"

          # --- Wayar ---
          "$mod, u, exec, ~/.config/waybar/toggle-waybar.sh"

          # --- Focus (Vim & Arrows) ---
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod, Left, movefocus, l"
          "$mod, Down, movefocus, d"
          "$mod, Up, movefocus, u"
          "$mod, Right, movefocus, r"

          # --- Move Windows (Vim & Arrows) ---
          "$mod Shift, h, movewindow, l"
          "$mod Shift, j, movewindow, d"
          "$mod Shift, k, movewindow, u"
          "$mod Shift, l, movewindow, r" # This now works (conflict removed)
          "$mod Shift, Left, movewindow, l"
          "$mod Shift, Down, movewindow, d"
          "$mod Shift, Up, movewindow, u"
          "$mod Shift, Right, movewindow, r"

          # --- Layouts ---
          # Toggle split direction (Horizontal/Vertical)
          "$mod, v, togglesplit"

          # Group Windows (The Hyprland equivalent of "Tabbed")
          "$mod, w, togglegroup" # Create/Toggle a group
          "$mod, n, changegroupactive, f" # Switch to next window in group
          "$mod, b, changegroupactive, b" # Switch to prev window in group

          # --- Screenshots ---
          ", Print, exec, grimblast copy area"
          "$mod Shift, Print, exec, grimblast copy screen"
          "$mod Ctrl, Print, exec, grimblast copy active"

          # --- App Shortcuts ---
          "$mod, i, exec, firefox"
          "$mod, o, exec, obsidian"
          "$mod, t, exec, thunderbird"
          "$mod, p, exec, thunar"

          # --- Session Management ---
          "$mod Shift, Escape, exec, hyprlock"
          "$mod Shift, e, exit"

          # --- Media Keys ---
          ", XF86AudioRaiseVolume, exec, pamixer -i 2"
          ", XF86AudioLowerVolume, exec, pamixer -d 2"
          ", XF86AudioMute, exec, pamixer --toggle-mute"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86KbdBrightnessUp, exec, brightnessctl --device='vendor::kbd_backlight' set +10%"
          ", XF86KbdBrightnessDown, exec, brightnessctl --device='vendor::kbd_backlight' set 10%-"
          ", XF86Keyboard, exec, ~/.local/bin/kbd-brightness"
        ]
        ++ (
          # Workspace bindings generation (Moved inside bind)
          builtins.concatLists (
            builtins.genList
              (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, ${toString ws}, workspace, ${toString ws}"
                  "$mod Shift, ${toString ws}, movetoworkspace, ${toString ws}"
                ]
              )
              9
          )
        );

      ############################
      ##  Window Rules
      ############################
      windowrulev2 = [
        "workspace 3, class:^(obsidian)$"
        "workspace 2, class:^(firefox)$"
        "workspace 1, class:^(com.mitchellh.ghostty)$"
        "workspace 4, class:^(thunderbird)$"
        "noblur, class:Gromit-mpx"
      ];

      ############################
      ##  Input Devices
      ############################
      input = {
        # Keyboard defaults
        kb_layout = "us"; # Modify if you use a different layout

        # Touchpad defaults
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true; # Fixed: was 'dwt'
          middle_button_emulation = true;
          "tap-to-click" = true; # Fixed: was 'tap', quotes required for dashes
        };
      };

      monitor = [
        "eDP-1, preferred, auto, 1"
      ];

      ############################
      ##  Autostart
      ############################
      exec-once = [
        "nm-applet"
        "hyprpaper"
        "hyprpanel"
        "QT_QPA_PLATFORM=xcb keepassxc"
        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE"
        "swayidle -w timeout 300 'hyprlock' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'hyprlock'"
        "blueman-applet"
      ];
    };
  };

  ############################
  ## Lock screen
  ############################
  programs.hyprlock.enable = true;
}
