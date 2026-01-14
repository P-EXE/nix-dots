{ pkgs, ... }: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      # docker alias for podman
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    docker-compose
    podman-compose
  ];
}
