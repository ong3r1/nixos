{ config
, pkgs
, ...
}:
let
  # toggleWaybarScript = import ./toggle-waybar.nix {inherit pkgs;};
  myKeepassXC = pkgs.keepassxc;
  py = pkgs.python3Packages;
  kde = pkgs.kdePackages;
  # uid = toString config.home.userInfo.uid;
in
{
  imports = [
    # File manager
    ./file-manager.nix

    # GTK
    ./gtk.nix

    # Ghostty
    ./ghostty.nix

    # Qt
    ./qt.nix

    # walker
    ./walker.nix

    # Neovim
    ./neovim.nix

    # Starship
    ./starship.nix

    # Import hyprland configuration
    ./hyprland.nix

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
      XDG_DATA_DIRS = "${config.xdg.dataHome}/flatpak/exports/share:/var/lib/flatpak/exports/share:/etc/profiles/per-user/${config.home.username}/share:/usr/local/share:/usr/share";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
      SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
      NIXOS_OZONE_WL = "1";
    };

    file = {
      # Time Logger
      ".local/bin/logr".source = ../dotfiles/scripts/log-retro.sh;

      # Focus Block Timer
      ".local/bin/focus".source = ../dotfiles/scripts/focus-block.sh;

      # Run App Images
      ".local/bin/runai".source = ../dotfiles/scripts/run-appimage.sh;

      # Cycle through keyboard brightness
      ".local/bin/kbd-brightness".source = ../dotfiles/scripts/kbd-brightness.sh;

      # swappy
      ".config/swappy" = {
        source = ../dotfiles/config/swappy;
        recursive = true;
      };
    };

    packages = with pkgs; [
      alejandra
      ashell
      bat
      blueberry
      btop
      calligraplan
      cargo
      clippy
      codespell
      curl
      eza
      fd
      file-roller
      foliate
      font-awesome
      gcc
      gh
      (pkgs.gimp-with-plugins.override {
        plugins = [ pkgs.gmic ];
      })
      glaxnimate
      gmic
      gmic-qt
      gnucash
      go
      go-tools
      gotools
      golangci-lint
      gopls
      hyprlock
      imagemagick
      inkscape
      jq
      just
      lazygit
      libnotify
      libsecret
      lua-language-server
      mako
      material-design-icons
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      ngrok
      nixd
      nixpkgs-fmt
      nodejs
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint_d
      nodePackages.prettier
      obsidian
      oh-my-zsh
      p7zip
      pgformatter
      prettierd
      pureref
      py.black
      py.flake8
      py.isort
      pyright
      python313
      qbittorrent
      ripgrep
      rofi
      rofimoji
      rust-analyzer
      rustc
      rustfmt
      sqlcheck
      sqls
      taskjuggler
      thunderbird
      tmuxinator
      tomato-c
      tor-browser
      tree
      typescript-language-server
      vscode
      # Sway and Wayland related packages
      brightnessctl
      feh
      grim
      grimblast
      networkmanagerapplet
      pamixer
      pavucontrol
      playerctl # Media control
      slurp
      stylua
      swappy
      swaynotificationcenter # Notifications
      unrar
      unzip
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

    # GPG
    gpg = {
      enable = true;
      package = pkgs.gnupg24;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true; # enables seamless integration with nix-shell/nix develop
    };

    firefox = {
      enable = true;
      nativeMessagingHosts = [ myKeepassXC ];
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
        key = "B3E6DF108565F22C"; # Same GPG key ID
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

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 1800;
      maxCacheTtl = 7200;
    };
  };
}
