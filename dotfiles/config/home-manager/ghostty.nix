{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      ghostty
    ];

    file = {
      ".config/ghostty" = {
        source = ../dotfiles/config/ghostty;
        recursive = true;
      };
    };
  };
}
