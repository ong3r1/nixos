{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ fuzzel ];

    file = {
      ".config/fuzzel" = {
        source = ../dotfiles/config/fuzzel;
        recursive = true;
      };
    };
  };
}
