{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "ong3r1";
    homeDirectory = "/home/ong3r1";
    stateVersion = "25.05"; # Please read the comment before changing.

    sessionVariables = {
      EDITOR = "neovim";
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
      nerd-fonts.meslo-lg
      nerd-fonts.jetbrains-mono
      libnotify
      thunderbird
      # Sway and Wayland related packages
      swaynotificationcenter # Notifications
      swayidle
      wl-clipboard
      waybar
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

  # Sway
  wayland.windowManager.sway = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

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

  programs.tmux = {
    enable = true;

    # Set your prefix key and other sane defaults
    keyMode = "vi";
    terminal = "screen-256color";

    plugins = [ ]; # No TPM

    extraConfig = ''
      # Quality of Life
      set -g mouse on
      set -g set-clipboard on
      set -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ',xterm-256color:Tc'

      # Vim style navigation
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key -r C-h select-window -t :-
      bind-key -r C-l select-window -t :+
      unbind C-b
      set -g prefix2 C-Space

      # Reload config
      unbind r
      bind r source-file ~/.tmux.conf

      # Base status bar colours (Gruvbox dark)
      set -g status on
      set -g status-interval 5
      set -g status-justify centre
      set -g status-style bg=colour235,fg=colour223

      # Window status
      setw -g window-status-format " #I:#W "
      setw -g window-status-current-format "#[bg=colour239,fg=colour223]#[bg=colour239,fg=colour223,bold] #I:#W #[bg=colour235,fg=colour239,nobold]"
      setw -g window-status-style bg=colour235,fg=colour244
      setw -g window-status-current-style bg=colour239,fg=colour223,bold

      # Pane border
      set -g pane-border-style fg=colour239
      set -g pane-active-border-style fg=colour250

      # Message text (when searching or confirming)
      set -g message-style bg=colour239,fg=colour223

      # Command prompt colours
      set -g message-command-style bg=colour239,fg=colour223

      # Status Left & Right
      set -g status-left "#[bg=colour239,fg=colour223,bold] #S #[bg=colour235,fg=colour239,nobold]"
      set -g status-left-length 40

      set -g status-right "#[bg=colour235,fg=colour239]#[bg=colour239,fg=colour223] %Y-%m-%d  %H:%M #[default]"
      set -g status-right-length 100

      # Mode-style (copy-mode selection)
      set -g mode-style bg=colour239,fg=colour223

      # Bell
      set -g visual-bell on
      set -g bell-action any
    '';
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
