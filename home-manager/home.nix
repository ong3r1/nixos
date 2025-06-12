{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ong3r1";
  home.homeDirectory = "/home/ong3r1";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    git
    gh
    lazygit
    lazydocker
    vscode
    curl
    fzf
    fd
    zsh
    oh-my-zsh
    vlc
    nodejs
    pyenv
    bat
    libsForQt5.qt5ct
    codespell
    neovim
    tmux
    htop
    (pkgs.writeShellScriptBin "obsidian" ''
      LIBGL_ALWAYS_SOFTWARE=1 \
      OBSIDIAN_USE_WAYLAND=1 \
      ${pkgs.electron}/bin/electron \
        --disable-gpu \
        --disable-software-rasterizer \
        ${pkgs.obsidian}/libexec/obsidian
    '')
    obs-studio
    kitty
    nerd-fonts.meslo-lg

    # Sway and related packages
    sway
    swaynotificationcenter # Notifications
    swaylock
    swayidle
    wl-clipboard
    waybar
    brightnessctl
    networkmanagerapplet
    pavucontrol
    playerctl         # Media control
    wofi              # Application launcher

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Sway
  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      exec_always --no-startup-id keepassxc --minimize
      exec_always --no-startup-id nm-applet
    '';
  };

  services.mako = {
    enable = true;

    # Optional configs
    settings = {
      font = "MesloLGS Nerd Font";
      background-color = "#1e1e2e";
      border-color = "#89b4fa";
      border-size = 2;
      padding = "10";
      margin = "10";
      anchor = "top-right";
    };
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ong3r1/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
    BAT_THEME = "DarkNeon";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  programs.waybar = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
