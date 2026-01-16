{ pkgs, ... } : {
  imports = [
    ./kitty/kitty.nix
    ./kitty/theme-archive.nix
    ./yazi/yazi.nix
    ./yazi/theme-archive.nix
    ./vscode/vscode.nix
    ./htop/htop.nix
    ./btop/btop.nix
    ./btop/theme-archive.nix
    ./git/git.nix
    ./wine.nix
  ];
  home.packages = with pkgs; [
    # System
    htop
    pavucontrol
    helvum
    wineWowPackages.waylandFull
    winetricks
    wineasio
    localsend

    # Web & Media
    firefox
    spotify
    mpv
    mpvScripts.uosc

    # Development
    vscodium
    podman-desktop

    # Notes & keeping
    bitwarden-desktop
    obsidian

    # Graphics
    #(blender.override { cudaSupport = true; })
    inkscape
    gimp
    rawtherapee
    art
    darktable
    digikam

    # Games
    steam
    (modrinth-app.overrideAttrs (oldAttrs: {
			buildCommand = 
				''
					gappsWrapperArgs+=(
						--set GDK_BACKEND x11
						--set WEBKIT_DISABLE_DMABUF_RENDERER 1
					)
				''
				+ oldAttrs.buildCommand;
		}))
  ];
}
