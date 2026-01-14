{ hwInfo, ... } : {
  wayland.windowManager.hyprland.settings.workspace = [
    "1, monitor:${hwInfo.primaryDisplay.name} default:true"
    "2, monitor:${hwInfo.primaryDisplay.name}"
    "3, monitor:${hwInfo.primaryDisplay.name}"
    "4, monitor:${hwInfo.primaryDisplay.name}"
    "5, monitor:${hwInfo.primaryDisplay.name}"
    "6, monitor:${hwInfo.primaryDisplay.name}"
    "7, monitor:${hwInfo.primaryDisplay.name}"
    "8, monitor:${hwInfo.primaryDisplay.name}"
    "9, monitor:${hwInfo.primaryDisplay.name}"
    "10"
  ];
}
