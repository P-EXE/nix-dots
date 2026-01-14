{ ... } : {
  imports = [
    ./hyprland/hyprland.nix
    ./hyprland/theme-archive.nix
    ./waybar/waybar.nix
    #./waybar/theme-archive.nix todo!
    ./tofi/tofi.nix
    ./tofi/theme-archive.nix
    ./dunst/dunst.nix
    #./dunst/theme-archive.nix todo!
    ./wallpapers.nix
  ];
}