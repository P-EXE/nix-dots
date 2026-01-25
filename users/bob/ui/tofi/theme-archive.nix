{ pkgs, hwInfo, ... } : {
  home.packages = with pkgs; [
    jetbrains-mono
  ];

  programs.tofi.settings = {
    width = "100%";
    height = "100%";
    border-width = 0;
    outline-width = 0;
    padding-left = 32;
    padding-top = 16;
    result-spacing = -16;
    num-results = 0;
    font = "JetBrains Mono";
    font-variations = "wght 900";
    font-features = "ss08 on";
    font-size = "${toString (96 * hwInfo.primaryDisplay.pseudoScale)}px";
    text-color = "#FFFFFF33";
    background-color = "#000000FF";
    selection-color = "#FFFFFFE6";
    selection-match-color = "#FF4F00";
    selection-background-padding = "16px 0 16px 16px";
    prompt-text = "↘";
  };
}