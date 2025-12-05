{ pkgs, ... }: {
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      # Lua
      stylua

      # Python
      black
      isort

      # Rust
      rustfmt

      # Javascript/Typescript/Reacht/HTML/CSS/JSON
      prettierd

      # Go
      go
      go-tools

      # Nix
      alejandra
      nixfmt-rfc-style
      nixpkgs-fmt
    ];

    file = {
      # Config
      ".config/nvim" = {
        source = ../dotfiles/config/nvim;
        recursive = true;
      };
    };
  };

  programs.neovim = {
    defaultEditor = true;
    enable = true;
  };
}
