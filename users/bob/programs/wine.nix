{ pkgs, ... } : {
  nixpkgs.overlays = [
    (final: prev:
      let
        nixpkgs-wine94 = import
          (prev.fetchFromGitHub {
            owner = "NixOS";
            repo = "nixpkgs";
            rev = "f60836eb3a850de917985029feaea7338f6fcb8a"; #wineWow64Packages.stable: 9.3 -> 9.4
            sha256 = "BpQ0tkhz0Tbgz1rN05H6zhEvJgPvPbZy554gTVShn8M=";
          })
          {
            system = "x86_64-linux";
          };
      in
      {
        inherit (nixpkgs-wine94) yabridge yabridgectl;
      })
  ];
  home.packages = with pkgs; [
    #wineWowPackages.stable
    #wineWowPackages.waylandFull
    #wineWowPackages.staging
    #winetricks
    #wineasio
    yabridge
    yabridgectl
  ];
}