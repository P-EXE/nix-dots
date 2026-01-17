{ ... } : {
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "public" = {
        "path" = "/mnt/share";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "7777";
        "directory mask" = "7777";
        "force user" = "username";
        "force group" = "groupname";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
}
