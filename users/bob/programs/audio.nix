{ pkgs, ... } : {
  home.packages = with pkgs; [
    (yabridge.override {wine = wineWowPackages.waylandFull;})
    (yabridgectl.override {wine = wineWowPackages.waylandFull;})
    
    reaper
    vital
  ];
#  nixpkgs.overlays = [
#    (final: prev:
#      let
#        nixpkgs-wine922 = import
#          (prev.fetchFromGitHub {
#            owner = "NixOS";
#            repo = "nixpkgs";
#            rev = "dea5930f0ed8c29d3758d5ade9898b4e99d80b74"; #wineWow64Packages.stable: 9.20 -> 9.22
#            sha256 = "uw/KGs5qQIFoYvBxuGVsc75BMy7P04utZJg7K2Nv7So=";
#          })
#          {
#            system = "x86_64-linux";
#          };
#      in
#        {
#          inherit (nixpkgs-wine922) yabridge yabridgectl;
#        })
#  ];
}