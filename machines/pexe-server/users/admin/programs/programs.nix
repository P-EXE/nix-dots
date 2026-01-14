{pkgs, ...}: {
  imports = [
    ./git.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
  ];
}
