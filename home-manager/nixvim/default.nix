{ inputs
, pkgs
, ...
}: {
  programs.nixvim = {
    imports = [
      ./opts.nix
      ./keymaps.nix
      ./plugins.nix
    ];
    enable = true;
  };
}
