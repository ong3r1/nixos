{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      walker
    ];

    file = {
      ".config/walker" = {
        source = ../dotfiles/config/walker;
        recursive = true;
      };
    };
  };
}
