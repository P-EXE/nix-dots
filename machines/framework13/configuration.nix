{ config, pkgs, inputs, lib, ... } : {
  imports = [
    ./hardware-configuration.nix
    ./virtualization.nix
    ./hyprland.nix
  ];

  musnix.enable = false;

  hwInfo = {
    deviceType = "laptop";
    displays = [{
      name = "eDP-1";
      resolution.x = 2880;
      resolution.y = 1920;
      refreshRate = 60.0;
      orientation = 0;
      offset.x = 0;
      offset.y = 0;
      scale = 1.0;
      pseudoScale = 1.4;
      safezones.top-left = {x = 24; y = 24;};
      safezones.top-right = {x = 24; y = 24;};
    }];
  };

  # Graphical environments
    # Requirements
    services.xserver.enable = true;
    # Displaymanagers
    services.displayManager.gdm.enable = true;
    # Desktops
    services.desktopManager.gnome.enable = false;
    services.desktopManager.plasma6.enable = true;

  # User management
    # Users
    users.users.bob = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" "audio" ];
      packages = with pkgs; [];
    };
    # Groups
    users.groups = {};
    # Home-Manager
    home-manager.users."bob" = import ../../users/bob/home.nix;
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
        hwInfo = config.hwInfo;
      };
      backupFileExtension = "bak5";
    };

  # Network
  networking = {
    hostName = "Framework-13";
#   proxy = {
#      default = "http://user:password@proxy:port/";
#      noProxy = "127.0.0.1,localhost,internal.domain";
    firewall = rec {
      enable = false;
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
      checkReversePath = false;
    };
    networkmanager.enable = true;
  };

# System packages
environment.systemPackages = with pkgs; [
  udiskie
  brightnessctl
  unar
  wireguard-tools
  libimobiledevice
  ifuse # optional, to mount using 'ifuse'
];

# Hardware, Devices & associated services
  # Networking
  services.openssh.enable = true;
  services.printing.enable = true;
  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    #media-session.enable = true;
  };
  # Fingerprint scanner
  services.fprintd.enable = true;
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Blockdevices
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # USB
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  environment.variables.AMD_VULKAN_ICD = "RADV";
  #hardware.graphics.extraPackages = with pkgs; [
  #  amdvlk
  #];

  # Locale
  time.timeZone = "Europe/Vienna";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  #services.xserver.libinput.enable = true;

  # Nix & System
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # Compatability & impure stuff
    #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    #programs.nix-ld.enable = true;
    fonts.fontDir.enable = true;
    # Packages
    nixpkgs.config.allowUnfree = true;
      # Substituters
      nix.settings = {
        builders-use-substitutes = true;
        extra-substituters = [
        ];
        extra-trusted-public-keys = [
        ];
      };

  # Startup & System
    # Bootloader
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.configurationLimit = 3;
    };
    # Kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "25.11"; # Did you read the comment?
}
