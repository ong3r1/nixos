{ pkgs, ... }:
pkgs.writeShellScriptBin "toggle-waybar" ''
  # Define the Waybar executable name for the pgrep check
  WAYBAR_PROC_NAME=".waybar-wrapped"

  if pgrep -x "$WAYBAR_PROC_NAME" > /dev/null; then
      # Waybar is running: Kill it (labour saved)
      pkill -x "$WAYBAR_PROC_NAME"
  else
      # Waybar is not running: Launch it using the correct compositor method

      # Use $XDG_CURRENT_DESKTOP for the leverage point
      COMPOSITOR="$(echo $XDG_CURRENT_DESKTOP | tr '[:upper:]' '[:lower:]')"

      case "$COMPOSITOR" in
          sway)
              # Use swaymsg exec for Sway
              swaymsg exec "waybar"
              ;;
          hyprland)
              # Use hyprctl dispatch exec for Hyprland
              hyprctl dispatch exec "waybar"
              ;;
          *)
              # Fallback for other Wayland compositors (or just run waybar)
              waybar &
              ;;
      esac
  fi
''
