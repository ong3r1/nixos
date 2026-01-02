{ pkgs, ... }: {
  home = {
    sessionVariables = {
      OPENER = "xdg-open";
    };

    sessionPath = [ "$HOME/.local/bin" ];

    packages = with pkgs; [
      libreoffice
      vlc
      xdg-utils
    ];
  };

  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      recolor-keephue = true;
      selection-clipboard = "clipboard";
    };
  };
}
