# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  custom-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "purple_leaves"; # Or your preferred variant
  };
in
{
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

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
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
        # nix-path = config.nix.nixPath;
        auto-optimise-store = true;
      };
      # Opinionated: disable channels
      channel.enable = true;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  fonts = {
    packages = with pkgs; [
      inter
      eb-garamond
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "MesloLGS Nerd Font" ];
        sansSerif = [ "Inter" ];
        serif = [ "EB Garamond" ];
      };
    };
  };

  # Bootloader.
  boot = {
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "red_loader";
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
      kernelModules = [ "i915" ];
      systemd = {
        enable = true;
      };
    };
    kernelParams = [
      "quiet"
      "splash"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  virtualisation = {
    # Enable the core virtualization daemon.
    libvirtd = {
      enable = true;
      qemu = {
        # Enable the swtpm service for software TPM emulation.
        swtpm.enable = true;
      };
    };

    # Enable podman
    podman = {
      enable = true;
      # This creates the default bridge network Podman needs
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  boot.kernel.sysctl = {
    "fs.epoll.max_user_watches" = 1048576;
    "kernel.unprivileged_userns_clone" = 1;
  };

  fileSystems."/dev/binderfs" = {
    device = "binderfs";
    fsType = "binder";
    options = [ "defaults" ];
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
  };

  systemd = {
    services = {
      "getty@tty1".enable = false;
      flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ]; # Ensure flatpak executable is in PATH
        script = ''
          flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };
    };
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

    extraHosts = ''
      127.0.0.1 server.local
    '';
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
    systemPackages = with pkgs; [
      alsa-utils
      android-tools
      dbus
      ffmpeg
      gnupg
      pinentry-gtk2
      qemu_kvm
      sops
      swtpm
      waybar
    ];
    etc = {
      "gnupg/gpg-agent.conf".text = lib.mkForce ''
        pinentry-program ${pkgs.pinentry-gtk2}/bin/pinentry
        default-cache-ttl 600
        max-cache-ttl 7200
        allow-loopback-pinentry
      '';
      "loader/loader.conf".text = ''
        default nixos
        timeout 3
        console-mode max
        editor   no
      '';
    };
  };

  # Sops
  sops = {
    defaultSopsFile = ./secrets/secrets.yml;
    age = {
      keyFile = null;
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.

  # Sway
  programs = {
    hyprland.enable = true;
    zsh = {
      enable = true;
    };
    virt-manager.enable = true;
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
    dbus.enable = true;

    journald.extraConfig = ''
      SystemMaxUse=1G
    '';

    flatpak = {
      enable = true;
    };

    tailscale.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${custom-astronaut}/share/sddm/themes/sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
      extraPackages = [
        custom-astronaut
        pkgs.kdePackages.qtmultimedia
        pkgs.kdePackages.qtsvg
        pkgs.kdePackages.qt5compat # Needed for some animations/effects
      ];
    };

    printing = {
      enable = true;
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true; # Or media-session.enable = true; if still using that older one
      alsa.enable = true;
      audio.enable = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

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

    # 1. Disable the conflicting default daemon
    power-profiles-daemon.enable = false;

    # 2. Enable thermald (Essential for Intel CPUs to prevent over-throttling)
    thermald.enable = true;

    throttled.enable = true;

    tlp = {
      enable = true;
      settings = {
        # CPU Governor
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # Energy Performance Preference (EPP)
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Battery Charge Thresholds (ThinkPad specific)
        # Starts charging at 40%, stops at 80% to prevent wear
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;

        # Disable Bluetooth at boot (as we discussed)
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";

        # Keep the laptop cool and quiet on battery
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
      };
    };
  };

  # Configure keymap in X11
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          # This ensures that bluez doesn't auto-enable every adapter it finds
          # which can sometimes override the powerOnBoot setting.
          AutoEnable = false;
        };
      };
    };
    graphics = {
      enable = true;
    };
  };

  # Enable CUPS to print documents.
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
  };

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
      extraGroups = [
        "adbusers"
        "docker"
        "wheel"
        "networkmanager"
        "video"
        "storage"
        "plugdev"
        "input"
        "render"
        "keys"
        "libvirtd"
      ];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  system.stateVersion = "25.05";
}
