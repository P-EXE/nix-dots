{ pkgs, inputs, ... } : {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./programs/programs.nix
  ];

  # Users
  users.users = {
    admin = {
      isNormalUser = true;
      description = "Admin";
      extraGroups = ["networkmanager" "wheel" "samba" "dialout" "podman" "docker"];
    };
    sambauser = {
      isSystemUser = true;
      description = "Samba default user";
      group = "sambauser";
    };
  };
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "admin" = import ./users/admin/home.nix;
    };
  };
  users.groups = {
    sambauser = {};
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    htop
  ];

  # Security
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;

  # Wireless & Connectivity
  # Networking
  networking = {
    hostName = "pexe-server_nixos_blackbox";
    interfaces = {
      enp7s0.ipv4.addresses = [{
        address = "192.168.1.4";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" ];
    firewall = {
      enable = false;
      allowPing = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    proxy = {
      #default = "";
    };
  };
  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };
  networking.networkmanager.enable = true;
  # Printing
  services.printing.enable = true;

  # Localization
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };
  time.timeZone = "Europe/Vienna";

  # Hardware dependent
  # Keyboard
  console.keyMap = "de";
  services.xserver.xkb.layout = "de";
  services.xserver.xkb.variant = "";
  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  # Audio
  #hardware.pulseaudio.enable = true;
  #hardware.pulseaudio.support32bit = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  security.rtkit.enable = true;
  # Drives
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  # Battery
  services.upower.enable = true;

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    edk2-uefi-shell.enable = true;
    edk2-uefi-shell.sortKey = "z_edk2";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  programs.nix-ld.enable = true;

  # System
  system.stateVersion = "24.11";
}
