{ pkgs, ... } : {
  home.packages = with pkgs; [
    vital
  ];
}