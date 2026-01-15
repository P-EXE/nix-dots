{ inputs, config, pkgs, ...}: {
  imports = [
    ./keybinds.nix
    ./workspaces.nix
    ./monitors.nix
    ./startup.nix
  ];

  home.packages = with pkgs; [
    hyprshot
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    systemd.enable = false;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      hyprexpo
      hyprbars
    ];
  };
}
