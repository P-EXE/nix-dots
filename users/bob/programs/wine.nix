{ pkgs, ... } : {
  home.packages = with pkgs; [
    #wineWowPackages.stable
    wineWowPackages.waylandFull
    #wineWowPackages.staging
    winetricks
    wineasio
    yabridge
    yabridgectl

    #bottles
  ];
}