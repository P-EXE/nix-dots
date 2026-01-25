{ pkgs, ... }: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    vmware = {
      host.enable = true;
    };
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
  };

  # QEMU stuff
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice 
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
  ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

  users.users."bob" = {
    extraGroups = [
      "podman"
      "docker"
      "libvirtd"
      "vboxusers"
    ];
  };
}