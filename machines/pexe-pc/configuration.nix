{ config, pkgs, inputs, lib, ... } : {
  imports = [
    ./hardware-configuration.nix
    ./virtualization.nix
    ./hyprland.nix
  ];

  hwInfo = {
    deviceType = "desktop";
    displays = [
      {
        name = "DP-2";
        resolution.x = 3840;
        resolution.y = 1080;
        refreshRate = 144.0;
        orientation = 0;
        offset.x = 0;
        offset.y = 0;
        scale = 1.0;
      }
      {
        name = "HDMI-A-1";
        resolution.x = 1920;
        resolution.y = 1080;
        refreshRate = 60.0;
        orientation = 0;
        offset.x = 3840;
        offset.y = -200;
        scale = 1.0;
      }
    ];
  };
  
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

# UI
  services.displayManager.sddm = {
    enable = true;
  };
  
# Users
  users.users.bob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
    ];
  };
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      hwInfo = config.hwInfo;
    };
    users = {
      "bob" = import ../../users/bob/home.nix;
    };
    backupFileExtension = "bak1";
  };

# Network
  networking.hostName = "pexe-pc_nixos_whitebox"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # KDEConnect: 1714 - 1764;
  networking.firewall = rec {
    enable = true;
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
    checkReversePath = false;
  };
  services.openssh.enable = true;
  networking.networkmanager.enable = true;

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

# Graphics
  services.xserver.enable = true;

# Hardware & Devices
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.fprintd.enable = true;
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true; 
  services.udisks2.enable = true;
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # nvidia
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    NO_HARDWARE_CURSORS = 1;
  };

# Nix & System
  environment.systemPackages = with pkgs; [
    udiskie
    brightnessctl
    wireguard-tools
    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
  ];
  programs.kdeconnect.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  programs.nix-ld.enable = true;
# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = false;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  #boot.loader.systemd-boot.configurationLimit = 3;
# Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
# substituters
  nix.settings = {
    builders-use-substitutes = true;
    extra-substituters = [
    ];
    extra-trusted-public-keys = [
    ];
  };
  fonts.fontDir.enable = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "25.11"; # Did you read the comment?
}
