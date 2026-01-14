{ pkgs, ... } : {
  imports = [
    ./kitty/kitty.nix
    ./kitty/theme-archive.nix
    ./yazi/yazi.nix
    ./yazi/theme-archive.nix
    ./vscode/vscode.nix
    ./htop/htop.nix
    ./git/git.nix
  ];
  home.packages = with pkgs; [
    #Web & Media
    firefox
    spotify

    #Development
    vscodium

    #Graphics
    #(blender.override { cudaSupport = true; })

    #Games
    modrinth-app
    steam
  ];
}
