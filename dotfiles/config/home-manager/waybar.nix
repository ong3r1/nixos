{ pkgs, ...}:
let
  toggleWaybarScript = import ./toggle-waybar.nix {inherit pkgs;};
in {
  home = {
    file = {
      # Toggle waybar
      ".config/waybar/toggle-waybar.sh".source = "${toggleWaybarScript}/bin/toggle-waybar";

      # Waybar
      ".config/waybar" = {
        source = ../dotfiles/config/waybar;
        recursive = true;
      };

    };
  };

  programs = {
    waybar.enable = true;
  };
}
