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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    git
    lazygit
    lazydocker
    vscode
    curl
    fzf
    fd
    zsh
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
    wl-copy

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

    # Programs that integrate with Hyprland and are user-specific
    programs.waybar.enable = true;
    programs.wofi.enable = true;
    # ...
  };

  # Enable zsh
  programs.zsh.enable = true;
  home.shell = zsh;

  programs.gnupg = {
    enable = true;
    # You can configure gpg-agent settings here too, for user-specific overrides
    # agent = {
    #   enable = true; # Home Manager's specific option for user-level agent config
    #   enableSSHSupport = true;
    #   pinentryPackage = pkgs.pinentry-curses;
    # };
    # Configure gpg.conf settings declaratively:
    settings = {
      default-key = "YOUR_GPG_KEY_ID_HERE"; # Your primary GPG key ID
      # ... other GPG settings like trust-model, etc.
    };
    # You can also add trusted public keys for others if needed
    # trustedKeys = [
    #   {
    #     fingerprint = "0x...FINGERPRINT...";
    #     file = pkgs.fetchurl { url = "https://example.com/public_key.asc"; sha256 = "..."; };
    #   }
    # ];
  };
  
  # For Git signing with your GPG key (also in home.nix)
  programs.git = {
    enable = true;
    userName = "ong3r1";
    userEmail = "binmawe@gmail.com";
    signing = {
      key = "YOUR_GPG_KEY_ID_HERE"; # Same GPG key ID
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
