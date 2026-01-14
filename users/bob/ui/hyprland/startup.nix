{ ... } : {
  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user start hyprpolkitagent"
    "udiskie"
    "waybar"
    "systemctl --user enable --now hyprpaper.service"
    #"awww-daemon"
  ];
}
