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
      ];

      ############################
      ##  Keybindings
      ############################
      # We use ++ to merge the static list with the generated workspace list
      bind =
        [
          # --- Terminal & Launcher ---
          "$mod, Return, exec, ghostty"
          "$mod, d, exec, fuzzel --show drun"

          # --- Window Management ---
          "$mod, q, killactive"
          "$mod, Shift, space, togglefloating"
          "$mod, f, fullscreen"

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
          "$mod, Shift, h, movewindow, l"
          "$mod, Shift, j, movewindow, d"
          "$mod, Shift, k, movewindow, u"
          "$mod, Shift, l, movewindow, r" # This now works (conflict removed)
          "$mod, Shift, Left, movewindow, l"
          "$mod, Shift, Down, movewindow, d"
          "$mod, Shift, Up, movewindow, u"
          "$mod, Shift, Right, movewindow, r"

          # --- Layouts ---
          # Toggle split direction (Horizontal/Vertical)
          "$mod, v, togglesplit"

          # Group Windows (The Hyprland equivalent of "Tabbed")
          "$mod, w, togglegroup" # Create/Toggle a group
          "$mod, n, changegroupactive, f" # Switch to next window in group
          "$mod, p, changegroupactive, b" # Switch to prev window in group

          # --- Screenshots ---
          ", Print, exec, grimblast copy area"
          "$mod, Shift, Print, exec, grimblast copy screen"
          "$mod, Ctrl, Print, exec, grimblast copy active"

          # --- App Shortcuts ---
          "$mod, i, exec, firefox"
          "$mod, o, exec, obsidian"
          "$mod, t, exec, thunderbird"
          "$mod, p, exec, thunar"

          # --- Session Management ---
          "$mod, Shift, Escape, exec, hyprlock" # CHANGED: Moved from 'l' to 'Escape' to fix conflict
          "$mod, Shift, e, exit"

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
                  "$mod, Shift, ${toString ws}, movetoworkspace, ${toString ws}"
                ]
              )
              10
          )
        );

      ############################
      ##  Window Rules
      ############################
      windowrulev2 = [
        "workspace 3, class:^(obsidian)$"
        "workspace 2, class:^(firefox)$"
        "workspace 1, class:^(ghostty)$"
        "workspace 4, class:^(thunderbird)$"
        "float, title:^(KeePassXC)$"
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
        "swaync"
        "nm-applet"
        "hyprpaper"
        "eww daemon && eww open bar"
        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE"
        "swayidle -w timeout 300 'hyprlock' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'hyprlock'"
      ];
    };
  };

  ############################
  ## Wallpaper (Hyprpaper)
  ############################
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/Pictures/wallpapers/forest.jpg" ];
      wallpaper = [
        "eDP-1,~/Pictures/wallpapers/forest.jpg"
      ];
    };
  };

  ############################
  ## Lock screen
  ############################
  programs.hyprlock.enable = true;
}
