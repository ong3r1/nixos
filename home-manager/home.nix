{
  config,
  pkgs,
  ...
}: let
  myKeepassXC = pkgs.keepassxc;
  py = pkgs.python3Packages;
  js = pkgs.nodePackages;
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

    sessionVariables = {
      EDITOR = "nvim";
      BAT_THEME = "DarkNeon";
      QT_QPA_PLATFORMTHEME = "qt5ct";
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
      gh
      genymotion
      gcc
      gnupg
      lazygit
      vscode
      curl
      nixd
      alejandra
      cargo
      rustc
      fd
      ripgrep
      oh-my-zsh
      vlc
      nodejs
      py.black
      py.isort
      py.flake8
      rustfmt
      clippy
      js.prettier
      js.eslint
      go
      go-tools
      golangci-lint
      pyright
      rust-analyzer
      typescript-language-server
      gopls
      sqls
      pgformatter
      sqlcheck
      bat
      font-awesome
      material-design-icons
      libsForQt5.qt5ct
      codespell
      btop
      obsidian
      obs-studio
      alacritty
      nerd-fonts.meslo-lg
      nerd-fonts.jetbrains-mono
      libnotify
      thunderbird
      tmuxinator
      # Sway and Wayland related packages
      swaynotificationcenter # Notifications
      swayidle
      wl-clipboard
      waybar
      feh
      brightnessctl
      pamixer
      playerctl
      networkmanagerapplet
      pavucontrol
      grim
      slurp
      swappy
      playerctl # Media control
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
