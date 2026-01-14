{ pkgs, ... } : {
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "workbench.sideBar.location" = "right";
        "nixEnvSelector.useFlakes" = "true";
        "rust-analyzer.server.path" = "rust-analyzer";
      };
      extensions = with pkgs.vscode-extensions; [
        arrterian.nix-env-selector
        kamadorueda.alejandra
      ];
    };
    package = pkgs.vscode.fhsWithPackages ( 
      ps: with ps; [
      ]
    );
  };
}
