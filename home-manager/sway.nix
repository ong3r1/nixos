{ config, pkgs, ... }:

{
  # Sway
  wayland.windowManager.sway = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
