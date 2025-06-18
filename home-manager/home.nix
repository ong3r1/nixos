{ config, pkgs, ... }:

{
  imports = [
    # Import the Sway configuration
    ./sway.nix

    # Import the Tmux configuration
    ./tmux.nix

    # Import the Neovim configuration
    # ./neovim.nix

    # Import the Kitty configuration
    # ./kitty.nix

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
      # Neovim
      ".config/nvim" = {
        source = ../dotfiles/.config/nvim;
        recursive = true;
      };

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

      # Bash Profile
      ".bash_profile" = {
        source = ../dotfiles/.bash_profile;
        executable = true;
      };

      # conda init
      ".conda-init.sh" = {
        source = ../dotfiles/.conda-init.sh;
        executable = true;
      };

      # kitty
      ".config/kitty" = {
        source = ../dotfiles/.config/kitty;
        recursive = true;
      };
    };

    packages = with pkgs; [
      gh
      genymotion
      gcc
      lazygit
      vscode
      curl
      fd
      oh-my-zsh
      vlc
      nodejs
      pyenv
      bat
      font-awesome
      material-design-icons
      libsForQt5.qt5ct
      codespell
      neovim
      btop
      obsidian
      obs-studio
      kitty
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
      playerctl         # Media control
      wofi              # Application launcher
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
  programs.zsh = {
    enable = true;
    enableCompletion = true; # Enable Zsh completion
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # You can change this to any other theme you prefer
    };
    shellAliases = {
      # Cargo initialisation for rust
      source_cargo = "source ~/.source-cargo.sh";
      # Conda alias
      init_conda = "source ~/.conda-init.sh";
    };
  };

  # FZF integration with Zsh
  programs.fzf = {
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

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [pkgs.keepassxc];
  };

  programs.keepassxc = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "ong3r1";
    userEmail = "binmawe@gmail.com";
    signing = {
      key = "1F32DDAF6C4D9048"; # Same GPG key ID
      signByDefault = true;
    };
    # Optional: Make Git use gpg-agent for signing
    extraConfig = {
      commit.gpgsign = true;
      gpg.program = "gpg"; # Ensure it uses the system's gpg
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-qt; # Or your preferred pinentry
    extraConfig = ''
      default-cache-ttl 600
      max-cache-ttl 7200
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
