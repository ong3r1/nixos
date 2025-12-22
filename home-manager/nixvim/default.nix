{ inputs
, pkgs
, ...
}: {
  programs.nixvim = {
    imports = [
      ./opts.nix
      ./keymaps.nix
      ./plugins.nix
      ./extra-config.nix
    ];
    enable = true;
  };
}
