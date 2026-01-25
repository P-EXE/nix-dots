{ pkgs, ... } : {
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/shares/blackbox/public" = {
    device = "//server.lab.pexe.internal/public/";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nix-dots/secrets/samba"];
  };
  fileSystems."/mnt/shares/blackbox/private" = {
    device = "//server.lab.pexe.internal/private/";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nix-dots/secrets/samba"];
  };
  systemd.tmpfiles.rules = [
    "d /mnt/shares/blackbox/public 1777 root root -"
    "d /mnt/shares/blackbox/private 1777 root root -"
  ];
}