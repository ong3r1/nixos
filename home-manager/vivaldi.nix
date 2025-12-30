{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.vivaldi;
    commandLineArgs = [
      "--password-store=gnome-libsecret"
    ];
  };
}
