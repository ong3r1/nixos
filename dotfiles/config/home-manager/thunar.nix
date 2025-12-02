{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
  ];

    # Wrap thunar with correct plugin path
  home.file.".local/bin/thunar".text = ''
    #!/usr/bin/env bash
    export THUNARX_DIRS="${pkgs.xfce.thunar-archive-plugin}/lib/thunarx-3"
    exec ${pkgs.xfce.thunar}/bin/thunar "$@"
  '';
  home.file.".local/bin/thunar".executable = true;
}
