{ inputs, pkgs, ... } : {
  imports = [
    ./ui/ui.nix
    ./programs/programs.nix
  ];

  programs.kitty.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    username = "bob";
    homeDirectory = "/home/bob";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
