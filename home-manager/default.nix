{
  config,
  pkgs,
  ...
}: let
  # toggleWaybarScript = import ./toggle-waybar.nix {inherit pkgs;};
  myKeepassXC = pkgs.keepassxc;
  py = pkgs.python3Packages;
  kde = pkgs.kdePackages;
  # uid = toString config.home.userInfo.uid;
in {
  imports = [
    # fuzzel
    ./fuzzel.nix

    # File manager
    ./file-manager.nix

    # GTK
    ./gtk.nix

    # Gemini CLI
    ./gemini.nix

    # Ghostty
    ./ghostty.nix

    # Neovim
    ./neovim.nix

    # Starship
    ./starship.nix

    # Import the Sway configuration
    ./sway.nix

    # Import the Tmux configuration
    ./tmux.nix

    # Thunar
    ./thunar.nix

    # Waybar
    ./waybar.nix

    # Zoxide
    ./zoxide.nix

    # ZSH
    ./zsh.nix
  ];

  home = {
    username = "ong3r1";
    homeDirectory = "/home/ong3r1";
    stateVersion = "25.05"; # Please read the comment before changing.
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.

    activation.debug = ''
      echo "DEBUG: HOME USERNAME = ${config.home.username}"
    '';
    sessionVariables = {
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      BAT_THEME = "DarkNeon";
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };

    file = {
      # Time Logger
      ".local/bin/logr".source = ../dotfiles/scripts/log-retro.sh;

      # Focus Block Timer
      ".local/bin/focus".source = ../dotfiles/scripts/focus-block.sh;

      # Sway
      ".config/sway" = {
        source = ../dotfiles/config/sway;
        recursive = true;
      };

      # swappy
      ".config/swappy" = {
        source = ../dotfiles/config/swappy;
        recursive = true;
      };

      # Swaylock
      ".config/swaylock" = {
        source = ../dotfiles/config/swaylock;
        recursive = true;
      };
    };

    packages = with pkgs; [
      # alacritty
      alejandra
      bat
      btop
      cargo
      clippy
      codespell
      curl
      eza
      fd
      font-awesome
      gcc
      genymotion
      gh
      gnupg
      go
      go-tools
      golangci-lint
      gopls
      jq
      just
      kde.kdenlive
      lazygit
      libnotify
      libsForQt5.qt5ct
      material-design-icons
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      nixd
      nodejs
      obs-studio
      obsidian
      oh-my-zsh
      pgformatter
      py.black
      py.flake8
      py.isort
      pyright
      ripgrep
      rofi
      rofimoji
      rust-analyzer
      rustc
      rustfmt
      sqlcheck
      sqls
      thunderbird
      tomato-c
      tmuxinator
      tree
      typescript-language-server
      vscode
      # Sway and Wayland related packages
      brightnessctl
      feh
      grim
      networkmanagerapplet
      pamixer
      pavucontrol
      playerctl # Media control
      slurp
      swappy
      swaynotificationcenter # Notifications
      watson
      wl-clipboard
      wtype
      zenity
    ];
  };

  programs = {
    # FZF integration with Zsh
    fzf = {
      enable = true;
      enableZshIntegration = true; # This enables FZF integration with Zsh
      defaultCommand = "fd --type f"; # optional: better file search
      defaultOptions = [
        "--preview 'bat --style=numbers --color=always --theme=DarkNeon {} | head -500'"
        "--preview-window=right:60%" # adjust as needed
      ];
      # Optional: You can customize the FZF key bindings and completion options
      # settings = {
      #   keyBindings = "default";
      #   completion = "default";
      # };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;  # enables seamless integration with nix-shell/nix develop
    };

    firefox = {
      enable = true;
      nativeMessagingHosts = [myKeepassXC];
    };

    keepassxc = {
      enable = true;
    };

    # waybar = {
    #   enable = true;
    # };

    git = {
      enable = true;
      userName = "ong3r1";
      userEmail = "binmawe@gmail.com";
      signing = {
        key = "8AD822AA6975D2B7"; # Same GPG key ID
        signByDefault = true;
      };
      # Optional: Make Git use gpg-agent for signing
      extraConfig = {
        commit.gpgsign = true;
        gpg.program = "gpg"; # Ensure it uses the system's gpg
      };
    };

    home-manager = {
      enable = true;
    };
  };
}
