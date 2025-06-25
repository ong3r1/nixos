{pkgs, ...}:
pkgs.writeShellScriptBin "toggle-waybar" ''
  if pgrep -x ".waybar-wrapped" > /dev/null; then
    pkill -x ".waybar-wrapped"
  else
    swaymsg exec "waybar"
  fi
''
