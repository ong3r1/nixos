{
  config,
  pkgs,
  ...
}: let
  myKeepassXC = pkgs.keepassxc;
  py = pkgs.python3Packages;
  js = pkgs.nodePackages;
  # uid = toString config.home.userInfo.uid;
in {
  imports = [
    # Import the Sway configuration
    ./sway.nix

    # Import the Tmux configuration
    ./tmux.nix

    # nixvim
    ./neovim.nix

    # Import the Zsh configuration
    # ./zsh.nix

    # Import the FZF configuration
    # ./fzf.nix

    # Import the Firefox configuration
    # ./firefox.nix

    # Import the GPG configuration
    # ./gpg.nix
  ];

  home = {
    username = "ong3r1";
    homeDirectory = "/home/ong3r1";
    stateVersion = "25.05"; # Please read the comment before changing.
    activation.debug = ''
      echo "DEBUG: HOME USERNAME = ${config.home.username}"
    '';
    sessionVariables = {
      EDITOR = "nvim";
      BAT_THEME = "DarkNeon";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      # SSH_AUTH_SOCK = "/run/user/${uid}/gnupg/S.gpg-agent.ssh";
    };

    file = {
      # Sway
      ".config/sway" = {
        source = ../dotfiles/.config/sway;
        recursive = true;
      };

      # Swaylock
      ".config/swaylock" = {
        source = ../dotfiles/.config/swaylock;
        recursive = true;
      };

      # Waybar
      ".config/waybar" = {
        source = ../dotfiles/.config/waybar;
        recursive = true;
      };

      # kitty
      ".config/alacritty" = {
        source = ../dotfiles/.config/alacritty;
        recursive = true;
      };
    };

    packages = with pkgs; [
      alacritty
      alejandra
      bat
      btop
      cargo
      clippy
      codespell
      curl
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
      js.eslint
      js.prettier
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
      rust-analyzer
      rustc
      rustfmt
      sqlcheck
      sqls
      thunderbird
      tmuxinator
      tree
      typescript-language-server
      vlc
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
      swayidle
      swaynotificationcenter # Notifications
      waybar
      wl-clipboard
      wofi # Application launcher
    ];
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  # 1. Enable and configure Zsh as your default shell
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true; # Enable Zsh completion
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell"; # You can change this to any other theme you prefer
      };
    };

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

    firefox = {
      enable = true;
      nativeMessagingHosts = [myKeepassXC];
    };

    keepassxc = {
      enable = true;
    };

    waybar = {
      enable = true;
    };

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

  xdg = {
    configFile = {
      "nvim/lua/config/lint.lua".source = ../dotfiles/.config/nvim/lua/config/lint.lua;
      "nvim/lua/config/appearance.lua".source = ../dotfiles/.config/nvim/lua/config/appearance.lua;
      "nvim/lua/config/fmt.lua".source = ../dotfiles/.config/nvim/lua/config/fmt.lua;
      "nvim/lua/config/bread-crumbs.lua".source = ../dotfiles/.config/nvim/lua/config/bread-crumbs.lua;
    };
  };
}
