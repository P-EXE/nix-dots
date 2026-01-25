{ pkgs, ... }: {
  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    podman = {
      enable = false;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    vmware = {
      host.enable = false;
    };
    virtualbox = {
      host = {
        enable = false;
        enableExtensionPack = true;
      };
    };
  };
  services.spice-vdagentd.enable = true;

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