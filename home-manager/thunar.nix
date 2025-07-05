{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      xfce.thunar
      xfce.thunar-archive-plugin # for archive integration
      xfce.thunar-volman # for volume management (though usually handled by DE)
      xfce.thunar-vcs-plugin # for git support
    ];
  };
}
