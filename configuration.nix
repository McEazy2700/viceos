# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./configs/nix/audio.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";

  # Bootloader.
  boot = {
    plymouth = {
      enable = true;
      themePackages = [pkgs.adi1090x-plymouth-themes]; # Replace with your theme package
      theme = "ironman";
    };
    initrd.systemd.enable = true;
  };
  environment.variables = {
    PATH = ["$HOME/.cargo/bin" "$HOME/.local/bin" "$HOME/go/bin"];
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    # systemd-boot.enable = true;
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    timeout = 3;
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
      theme = pkgs.stdenv.mkDerivation {
        pname = "distro-grub-themes";
        version = "3.1";
        src = pkgs.fetchFromGitHub {
          owner = "AdisonCavani";
          repo = "distro-grub-themes";
          rev = "v3.1";
          hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
        };
        installPhase = "cp -r customize/nixos $out";
      };
      configurationLimit = 10;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [3000 8080 8081 4943];
    };
  };

  # Set your time zone.
  time.timeZone = "Africa/Lagos";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NG";
    LC_IDENTIFICATION = "en_NG";
    LC_MEASUREMENT = "en_NG";
    LC_MONETARY = "en_NG";
    LC_NAME = "en_NG";
    LC_NUMERIC = "en_NG";
    LC_PAPER = "en_NG";
    LC_TELEPHONE = "en_NG";
    LC_TIME = "en_NG";
  };

  # Enable the X11 windowing system.
  services = {
    timesyncd.enable = true;
    openvpn.servers.myvpn = {
      config = "/etc/openvpn/USA_freeopenvpn_tcp.ovpn";
      autoStart = false;
    };
    xserver = {
      enable = true;
      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    tor = {
      enable = true;
    };
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 md5
        host all all ::1/128 md5
        host all all 192.168.42.113/24 md5
      '';
    };
  };

  programs = {
    nix-ld.enable = true;
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    firefox.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.getty.autologinUser = "vice";

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    enableAllFirmware = true;
    xone.enable = true;
  };
  security.rtkit.enable = true;

  # Enable XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.vice = {
      isNormalUser = true;
      description = "Ezekiel Victor";
      extraGroups = ["networkmanager" "wheel" "audio"];
      packages = with pkgs; [
        thunderbird
      ];
    };
    defaultUserShell = pkgs.fish;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    cascadia-code
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gcc
    clang
    unzip
    ripgrep
    bruno
    ffmpeg
    gh
    git
    podman
    podman-tui
    podman-compose
    podman-desktop
    tor-browser
    qemu_full
    fastfetch
    mangohud
    acpi
    code-cursor
    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    })
  ];

  programs.fish.enable = true;
  users.users.vice.shell = pkgs.fish;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
