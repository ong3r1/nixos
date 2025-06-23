# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = true;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Bootloader.
  boot = {
    plymouth = {
      enable = true;
      theme = "red_loader";
      themePackages = [
        (import ../dotfiles/plymouth/themes/red_loader.nix {inherit (pkgs) stdenv;})
      ];
    };
    loader = {
      grub = {
        enable = false;
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    initrd = {
      kernelModules = ["drm"];
      systemd = {
        enable = true;
      };
    };
    kernelParams = ["quiet" "splash"]; # suppresses log spam during boot
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager = {
      enable = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Environment variables
  environment = {
    variables = {
      XDG_SESSION_TYPE = "wayland";
    };
    systemPackages = with pkgs; [sops gnupg pinentry-gtk2];
    etc."gnupg/gpg-agent.conf".text = lib.mkForce ''
      pinentry-program ${pkgs.pinentry-gtk2}/bin/pinentry
      default-cache-ttl 600
      max-cache-ttl 7200
      allow-loopback-pinentry
    '';
  };

  # Sops
  sops = {
    defaultSopsFile = ./secrets/secrets.yml;
    age = {
      keyFile = null;
    };
  };

  # programs.xwayland.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.

  # Sway
  programs = {
    sway = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
    gnupg = {
      agent = {
        enable = true;
        enableExtraSocket = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-gtk2; # Choose from: "curses", "gtk2", "qt", "gnome3"
      };
    };
  };

  services = {
    # Ensure DBus is enabled (critical)
    dbus = {
      enable = true;
    };
    displayManager = {
      defaultSession = "sway";
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
      displayManager = {
        gdm = {
          enable = true;
          wayland = true; # Enable Wayland support
        };
      };
    };
    printing = {
      enable = true;
    };
    pulseaudio = {
      enable = false; # Use Pipewire instead
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true; # Or media-session.enable = true; if still using that older one
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    openssh = {
      enable = true;
      settings = {
        # Opinionated: forbid root login through SSH.
        PermitRootLogin = "no";
        # Opinionated: use keys only.
        # Remove if you want to SSH using passwords
        PasswordAuthentication = false;
      };
    };
    libinput = {
      enable = true;
    };
  };

  # Configure keymap in X11
  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
    };
  };

  # Enable CUPS to print documents.
  security.polkit.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  users.users = {
    ong3r1 = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      description = "Brian Ongeri";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      shell = pkgs.zsh;
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "networkmanager" "video" "input" "render" "keys"];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  system.stateVersion = "25.05";
}
