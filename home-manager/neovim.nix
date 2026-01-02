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
  };
}
