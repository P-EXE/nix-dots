{inputs, ...}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./programs/programs.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home.username = "admin";
  home.homeDirectory = "/home/admin";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
