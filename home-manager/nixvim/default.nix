{ inputs
, pkgs
, ...
}: {
  programs.nixvim = {
    imports = [
      ./colourschemes.nix
      ./extra-config.nix
      ./extra-files.nix
      ./globals.nix
      ./keymaps.nix
      ./opts.nix
      ./plugins.nix
    ];
    enable = true;
  };
}
