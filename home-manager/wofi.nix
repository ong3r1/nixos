{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      wofi
      qogir-icon-theme
    ];

    pointerCursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir-Dark";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    file = {
      # Cursor
      ".icons/default/index.theme".text = ''
        [Icon Theme]
        Inherits=${config.home.pointerCursor.name}
      '';

      ".config/wofi" = {
        source = ../dotfiles/.config/wofi;
        recursive = true;
      };
    };

    sessionVariables = {
      GTK_THEME = "Adwaita:dark";
      ICON_THEME = "Qogir-Dark";
      XCURSOR_THEME = "Qogir-Dark";
      XCURSOR_SIZE = "24";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_DATA_DIRS = "${config.home.profileDirectory}/share:${pkgs.gtk3}/share:/usr/share";
    };
  };
}
