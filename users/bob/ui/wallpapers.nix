{ pkgs, ... } : {
  home.packages = with pkgs; [
    wpaperd
    mpvpaper
    swww
    waypaper
  ];
}