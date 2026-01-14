{ hwInfo, ... } :
let monitors = map (m:
  "${m.name}, ${toString m.resolution.x}x${toString m.resolution.y}@${toString m.refreshRate}, ${toString m.offset.x}x${toString m.offset.y}, ${toString m.scale}, bitdepth, 8, cm, auto, sdrbrightness, 1, sdrsaturation, 1"
) hwInfo.displays; in {
  wayland.windowManager.hyprland.settings.monitor = monitors;
  #wayland.windowManager.hyprland.settings.monitor  = [ ", preferred, auto, 1" ];
}
