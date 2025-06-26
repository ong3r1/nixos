{pkgs, ...}: {
  home = {
    sessionVariables = {
      OPENER = "xdg-open";
    };

    sessionPath = ["$HOME/.local/bin"];

    packages = with pkgs; [
      lf
      libreoffice
      neovim
      nsxiv
      vlc
      xdg-utils
      zathura
    ];

    file = {
      ".local/bin/lf-opener".source = pkgs.writeShellScript "lf-opener" ''
        export PATH=${pkgs.lib.makeBinPath [
          pkgs.nsxiv
          pkgs.vlc
          pkgs.zathura
          pkgs.libreoffice
          pkgs.neovim
          pkgs.xdg-utils
        ]}
        case "$1" in
          *.png|*.jpg|*.jpeg|*.gif|*.bmp|*.webp) exec nsxiv "$1" ;;
          *.mp4|*.mkv|*.webm|*.avi|*.mov) exec vlc "$1" ;;
          *.pdf) exec zathura "$1" ;;
          *.docx|*.xlsx|*.pptx|*.odt|*.ods|*.odp) exec libreoffice "$1" ;;
          *.txt|*.md|*.nix|*.json|*.csv) exec nvim "$1" ;;
          *) exec xdg-open "$1" ;;
        esac
      '';
    };
  };

  xdg.configFile."lf/lfrc".text = ''
    cmd open-file lf-opener "$f"
    map o open-file
  '';
}
