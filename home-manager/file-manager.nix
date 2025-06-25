{pkgs, ...}: let
  openerScript = pkgs.writeShellScript "lf-opener" ''
    case "$1" in
      *.png|*.jpg|*.jpeg|*.gif|*.bmp|*.webp) exec ${pkgs.nsxiv}/bin/nsxiv "$1" ;;
      *.mp4|*.mkv|*.webm|*.avi|*.mov) exec ${pkgs.vlc}/bin/vlc "$1" ;;
      *.pdf) exec ${pkgs.zathura}/bin/zathura "$1" ;;
      *.docx|*.xlsx|*.pptx|*.odt|*.ods|*.odp) exec ${pkgs.libreoffice}/bin/libreoffice "$1" ;;
      *.txt|*.md|*.nix|*.json|*.csv) exec ${pkgs.neovim}/bin/nvim "$1" ;;
      *) exec ${pkgs.xdg-utils}/bin/xdg-open "$1" ;;
    esac
  '';
in {
  home = {
    sessionVariables = {
      OPENER = "xdg-open";
    };

    packages = with pkgs; [
      lf
      libreoffice
      neovim
      nsxiv
      vlc
      xdg-utils
      zathura
    ];
  };

  xdg.configFile."lf/lfrc".text = ''
    cmd open-file ${{
      ${openerScript}
    }}
    map o open-file
  '';
}
