let
  pkgs = import <nixpkgs> {};
in
  pkgs.writeShellScript "toggle-waybar" ''
    if pgrep -f "waybar" > /dev/null; then
      pkill -f "waybar"
    else
      waybar &
    fi
  ''
