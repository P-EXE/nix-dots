{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Programs
    yazi.url = "github:sxyazi/yazi";
    bunny-yazi = {
      url = "github:stelcodes/bunny.yazi";
      flake = false;
    };

    # Audio stuff
    musnix  = { url = "github:musnix/musnix"; };
    
    #Server stuff
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs : {
    nixosConfigurations = {
      framework13 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./machines/hwInfo.nix
          ./machines/framework13/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.musnix.nixosModules.musnix
        ];
      };
      whitebox = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./machines/hwInfo.nix
          ./machines/whitebox/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.musnix.nixosModules.musnix
        ];
      };
      pexe-server = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./machines/pexe-server/configuration.nix
        ];
      };
    };
  };
}
