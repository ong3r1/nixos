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
    chezmoi
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
    rofi-wayland
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
    # EDITOR = "emacs";
  };

  # Enable hyprland, a dynamic tiling Wayland compositor.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Enable XWayland support for Hyprland
  }

  environment.sessionVariables = {
    # Set the default terminal emulator to Alacritty.
    XDG_SESSION_DESKTOP = "hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "hyprland";
    WLR_NO_HARDWARE_CURSORS = "1"; # Disable hardware cursors for Hyprland
    nixos_ozone_wl = "1"; # Enable Ozone Wayland for Hyprland
  };

  hardware = {
    # Opengl
    opengl = {
      enable = true; # Enable OpenGL support
      driSupport = true; # Enable DRI support for hardware acceleration
      driSupport32Bit = true; # Enable 32-bit DRI support for compatibility
    };
  }

  # Enable zsh
  programs.zsh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.portal.enable = true; # Enable XDG portals for better integration with applications
  xdg.portal.extraPortals = [ "xdg-desktop-portal-hyprland" ]; # Use Hyprland's portal implementation

  sound.enable = true; # Enable sound support
  security.rtkit.enable = true; # Enable real-time scheduling support
  security.pipewire = {
    enable = true; # Enable PipeWire for audio and video support
    alsa.enable = true; # Enable ALSA support for PipeWire
    alsa.support32Bit = true; # Enable 32-bit ALSA support for compatibility
    pulse.enable = true; # Enable PulseAudio compatibility layer for PipeWire
    jack.enable = true; # Enable JACK compatibility layer for PipeWire
  };
}
