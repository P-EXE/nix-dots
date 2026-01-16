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
    spiceUSBRedirection.enable = true;
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

  boot = {
    initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"

    "i915" # Always make sure any graphics early kernel modesetting are after vfio modules
  ];
  kernelParams = [
    "radeon.runpm=0,"
    "radeon.modeset=0,"
    "amdgpu.runpm=0,"
    "amdgpu.modeset=0,"
    "intel_iommu=on" # use amd_iommu=on if on an AMD platform
    "vfio-pci.ids=1002:67b0,1002:aac8,144d:a80a" # Read the Arch Wiki to see how to find your GPU PCI IDs.
    ];
    blacklistedKernelModules = [
      "amdgpu"
      "radeon"
    ];
  };
}