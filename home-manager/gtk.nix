{ pkgs, ... }:
{
  gtk = {
    enable = true;

    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };

    iconTheme = {
      name = "Qogir-Dark"; # must match actual casing
      package = pkgs.qogir-icon-theme;
    };

    cursorTheme = {
      name = "Qogir-Dark";
      size = 24;
      package = pkgs.qogir-icon-theme;
    };

    font = {
      name = "Fira Sans 10";
    };
  };
}
