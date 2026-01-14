{inputs, ...}: {
  imports = [
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
