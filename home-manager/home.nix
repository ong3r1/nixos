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

    # Optional: Define aliases for your shell
    shellAliases = {
      # ll = "ls -lh";
      # update = "sudo nixos-rebuild switch --flake ~/.dotfiles/#laptop"; # Example for your specific rebuild command
      # ... other aliases
    };

    # Optional: Add extra configuration for your .zshrc
    # This allows you to add any raw zsh config that doesn't have a specific Home Manager option
    initContent = ''
      # Source Oh My Zsh (assuming it's installed via home.packages)
      source ${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh

      # Set Oh My Zsh theme
      ZSH_THEME="agnoster" # Or "robbyrussell", etc.

      # Enable plugins manually
      # Note: For plugins, you'll often need to ensure they are available as packages
      # or manage them via a custom plugin directory if they're not
      # standard Oh My Zsh plugins
      plugins=(
        git
        colored-man-pages
        # Add more plugins here, e.g.:
        # z # requires 'z' plugin from oh-my-zsh source, or a package
        # fzf # requires 'fzf' plugin from oh-my-zsh source, or a package
      )

      # *****************************************************************
      # ZSH HISTORY CONFIGURATION - SETTING ZSH OPTIONS DIRECTLY
      # *****************************************************************
      setopt APPEND_HISTORY     # Append to history file
      setopt SHARE_HISTORY      # Share history between all sessions
      setopt EXTENDED_HISTORY   # Save history in the format ':<start_time>:<elapsed_seconds>;<command>'
      setopt HIST_EXPIRE_DUPS_FIRST # New lines should not be saved if they duplicate an earlier line
      setopt HIST_IGNORE_DUPS   # Don't record a command if it was the same as the previous one
      setopt HIST_IGNORE_SPACE  # Don't record lines starting with a space
      setopt HIST_REDUCE_BLANKS # Remove extra blank spaces from history entries
      setopt HIST_VERIFY         # Don't execute immediately upon recall from history
      setopt HIST_FCNTL_LOCK     # Enable history locking mechanism for concurrent sessions

      # Set history file size and number of lines to save
      HISTFILE="$HOME/.zsh_history" # Default is ~/.zsh_history, but explicit is fine
      HISTSIZE=10000              # Number of lines to keep in memory for history
      SAVEHIST=10000              # Number of lines to save to the history file

      # *****************************************************************

      # Home Manager environment setup
      if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi


      # Example: auto-jump to frequently visited directories
      # (if 'z' plugin is enabled)
      # zoxide init zsh --cmd cd | source

      # Custom prompt settings (if not using an Oh My Zsh theme)
      # PROMPT="%(?.%F{green}✔.%F{red}✘)%f %B%F{blue}%~%f%b $(git_prompt_info)%B%F{normal}\n\$ %b"
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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
    pinentry.package = pkgs.pinentry-curses; # Or your preferred pinentry
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
