{ pkgs, ... } : {
  home.packages = with pkgs; [
    jetbrains-mono
  ];

  services.dunst.enable = true;
  services.dunst.settings.global = {
    monitor = 0;
    follow  = "none";
    width = 300;
    height = 300;
    offset = "30x50";
    origin = "top-right";
    #transparency = 10;
    #frame_color = "#eceff1";
    background = "#000000";
    frame_width = 0;
    font = "Proto Mono 9";
  };
}