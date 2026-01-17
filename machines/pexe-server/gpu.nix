let
  gpuIDs = [
    "10de:1b80" # GeForce GTX 1080 Graphics in IOMMMU group 1 01:00.0
    "10de:10f0" # GeForce GTX 1080 Audio in IOMMMU group 1 01:00.1
  ];
in
{ pkgs, lib, config, ... } : {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      #"vfio_virqfd"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    kernelParams = [
      # enable IOMMU
      "intel_iommu=on"
      # isolate the GPU
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
    ];
  };
  hardware.opengl.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}