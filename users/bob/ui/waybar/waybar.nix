{ hwInfo, ... } : let 
  rotation = if (hwInfo.primaryDisplay.resolution.x / hwInfo.primaryDisplay.resolution.y < 1.7777) then
    0 
  else
    90;
  edge = if (hwInfo.primaryDisplay.resolution.x / hwInfo.primaryDisplay.resolution.y < 1.7777) then
    "top"
  else
    "left";
  pad = if (hwInfo.primaryDisplay.resolution.x / hwInfo.primaryDisplay.resolution.y < 1.7777) then
    "0 4px"
  else
    "4px 0";
in {
  programs.waybar = {
  enable = true;
  settings = {
    mainBar = {
      layer = "bottom";
      position = edge;
      modules-left = [ "hyprland/workspaces" "wlr/taskbar" ];
      modules-center = [ "custom/waybar-mpris" ];
      modules-right = [ "tray" "hyprland/language" "network" "cpu" "memory" "wireplumber" "battery" "clock" ];
      #output = [];
      "hyprland/workspaces" = {};
      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 10;
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
        rotate = rotation;
      };
      "tray" = {
        icon-size = 10;
        spacing = 8;
        rotate = rotation;
      };
      "hyprland/language" = {
        format = "{}";
        format-de = "DE";
        format-en = "US";
        rotate = rotation;
      };
      "network" = {
        format-ethernet = "ETH: {ipaddr}/{cidr}";
        format-wifi = "WLAN: {essid}-↑{bandwidthUpBits}↓{bandwidthDownBits}";
        format-disconnected = "";
        format-icons = ["░" "▂" "▄" "▆" "█"];
        tooltip-format = "if: {ifname}\nip: {ipaddr}/{cidr}/{cidr6}\ngw: {gwaddr}";
        tooltip-format-wifi = "if: {ifname}\nip: {ipaddr}/{cidr}/{cidr6}\ngw: {gwaddr}\nstr: {signalStrength}\nstr dB: {signaldBm}\nfreq: {frequency} GHz\nup: {bandwidthUpBits}\ndown: {bandwidthDownBits}";
        rotate = rotation;
      };
      "cpu" = {
        format = "CPU: {usage}%";
        rotate = rotation;
      };
      "memory" = {
        format = "RAM: {}%";
        rotate = rotation;
      };
      "wireplumber" = {
        format = "Vol: {volume}%-{node_name}";
        format-muted = "Mute";
        on-click = "helvum";
        format-icons = ["◂" "◄" "◀"];
        rotate = rotation;
      };
      "pulseaudio" = {
        scroll-step = 1;
        format = "Vol: {volume}%";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = " ";
        format-icons = {
          "headphone" = " ";
          "hands-free" = " ";
          "headset" = " ";
          "phone" = " ";
          "portable" = " ";
          "car" = " ";
          "default" = ["" " " " "];
        };
        on-click = "pavucontrol";
        rotate = rotation;
      };
      "battery" = {
        "states" = {
          "good" = 95;
          "warning" = 30;
          "critical" = 15;
        };
        format = "BAT: {capacity}%";
        format-charging = "CRG-{capacity}%";
        format-plugged = "PLG-{capacity}%";
        format-alt = "{icon} {time}";
        format-full = "";
        format-icons = ["░" "▂" "▄" "▆" "█"];
        rotate = rotation;
      };
      "clock" = {
        format = "{:L%A %d.%m.%Y(W%V) %H:%M:%S (%z)}";
        rotate = rotation;
      };
      "custom/waybar-mpris" = {
        "return-type"= "json";
        "exec" = "waybar-mpris --position --autofocus";
        "on-click" = "waybar-mpris --send toggle";
        # This option will switch between players on right click.
        "on-click-right" = "waybar-mpris --send player-next";
        # The options below will switch the selected player on scroll
        # "on-scroll-up" = "waybar-mpris --send player-next";
        # "on-scroll-down" = "waybar-mpris --send player-prev";
        # The options below will go to next/previous track on scroll
        #"on-scroll-up" = "waybar-mpris --send next";
        #"on-scroll-down" = "waybar-mpris --send prev";
        "escape" = true;
        rotate = rotation;
      };
    };
  };
  style = ''
    * {
      all: unset;
      font-family: 'JetBrains Mono';
    }

    window#waybar>box {
      background: #000000;
      font-size: 10px;
      padding: 4px 4px
    }

    tooltip {
      background: transparent;
      /* border: 1px solid rgba(100, 114, 125, 0.5); */
    }
    tooltip label {
      background: #000000;
      margin: 4px;
    }

    #workspaces {
    }
    #workspaces button {
      padding: ${pad};
      color: rgba(255, 255, 255, 0.5);
    }
    #workspaces button.active {
      color: #ffffff;
    }
    #taskbar {
      padding: ${pad};
    }
    #taskbar * {
      padding: 1px;
    }

    #tray {
      padding: ${pad};
    }
    #language {
      padding: ${pad};
    }
    #network {
      padding: ${pad};
      color: #ff6188;
    }
    #cpu {
      padding: ${pad};
      color: #fc9867;
    }
    #memory {
      padding: ${pad};
      color: #ffd866;
    }
    #wireplumber {
      padding: ${pad};
      color: #a9dc76;
    }
    #battery {
      padding: ${pad};
      color: #78dce8;
    }
    #clock {
      padding: ${pad};
      color: #ab9df2;
    }
  '';
};
}
