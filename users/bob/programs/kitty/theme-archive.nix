{ pkgs, ... } : {
  home.packages = with pkgs; [
    jetbrains-mono
  ];

  programs.kitty.settings = {
    font_family = "JetBrains Mono";
    cursor_shape = "beam";
    cursor_shape_unfocused = "unchanged";
    window_padding_width = 0;
    background = "#000000";
    foreground = "#E6E6E6";
    cursor = "#ffffff";
    selection_background = "#E6E6E6";
    selection_foreground = "#000000";
    color0 = "";
    color1 = "#FF6188";
    color2 = "#A9DC76";
    color3 = "#FFD866";
    color4 = "#2386D1";
    color5 = "#AB9DF2";
    color6 = "#78DCE8";
    color7 = "";
    color8 = "";
    color9 = "#CC768C";
    color10 = "#92A87D";
    color11 = "#CCB87A";
    color12 = "#3A739E";
    color13 = "#A7A3BF";
    color14 = "#82B0B5";
    color15 = "";
  };
}
