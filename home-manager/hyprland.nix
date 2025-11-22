{ config
, pkgs
, ...
}: {
  # Sway
  wayland.windowManager.hyprland = {
    enable = true;
  };
}
