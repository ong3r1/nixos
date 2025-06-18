# Steps
- Clone repo
- Symlink hardware configuration `ln -s /etc/nixos/hardware-configuration.nix ./nixos/harware-configuration.nix`
- Rebuild `sudo nixos-rebuild switch --flake .#ong3r1`
