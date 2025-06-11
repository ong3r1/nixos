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
    firefox
    nodejs
    pyenv
    bat
    libsForQt5.qt5ct
    codespell
    neovim
    keepassxc
    tmux
    htop
    obsidian
    obs-studio
    kitty
    hyprland
    waybar
    # EWW # A highly customizable widget system for Wayland compositors.
    eww
    # Mako # A Wayland notification daemon.
    mako
    # Libnotify # A library for creating notifications on Wayland.
    libnotify
    # Swww # A Wayland compositor wallpaper manager.
    swww
    # Rofi # A Wayland launcher and application menu.
    wofi
    # Network manager applet
    networkmanagerapplet
    grim
    slurp
    wl-clipboard

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

  # 1. Enable and configure Zsh as your default shell
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
  };

  # FZF integration with Zsh
  programs.fzf = {
    enable = true;
    enablezshIntegration = true; # This enables FZF integration with Zsh
    defaultCommand = "fd --type f"; # optional: better file search
    defaultOptions = [
      "--preview 'bat --style=numbers --color=always --theme=${batTheme} {} | head -500'"
      "--preview-window=right:60%" # adjust as needed
    ];
    # Optional: You can customize the FZF key bindings and completion options
    # settings = {
    #   keyBindings = "default";
    #   completion = "default";
    # };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Neovim
    ".config/nvim" = {
      source = ../dotfiles/.config/nvim;
      recursive = true;
    };

    # ZSH
    ".zshrc" = {
      source = ../dotfiles/.zshrc;
    };

    # tmux
    ".tmux.conf" = {
      source = ../dotfiles/.tmux;
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
  };

  wayland.windowManager.hyprland = {
    enable = true; # This tells Home Manager to apply your user's Hyprland settings
    # You generally don't need to enable `programs.hyprland` again here if you enabled it system-wide.
    # The `wayland.windowManager.hyprland` option in Home Manager is specifically for user config.

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive,"
        # ... your keybindings
      ];
      # ... animations, rules, layouts, etc.
    };

    extraConfig = ''
      # Any raw Hyprland config lines not covered by specific options
      monitor=,preferred,auto,1
      exec-once = waybar &
      exec-once = mako &
    '';
  };
  
  programs.waybar = {
    enable = true;
    # Configure Waybar here, e.g.:
    # settings = {
    #   "layer" = "top";
    #   "position" = "top";
    #   "modules-left" = [ "hyprland/workspaces" "hyprland/window" ];
    #   # ... etc.
    # };
    # style = ""; # Path to CSS file
    # extraConfig = ""; # Raw JSON for Waybar
  };

  programs.wofi = {
    enable = true;
    # Configure Wofi here, e.g.:
    # style = ""; # Path to CSS
    # extraConfig = ""; # Raw Wofi config
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
