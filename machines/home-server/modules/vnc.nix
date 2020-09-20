{ config, pkgs, ... }:

let username = "remote";
in {
  users.extraUsers."${username}" = {
    description = "User that runs vnc server";
    isNormalUser = true;
    extraGroups = [ "lp" "scanner" "wheel" "privatestore" "publicstore" ];
  };

  systemd.services.display-manager.path = with pkgs; [ tigervnc ];

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    tcp.enable = true;
    tcp.anonymousClients.allowedIpRanges = [ "127.0.0.1" "192.168.0.0/16" ];
    zeroconf.discovery.enable = true;
  };

  environment.systemPackages = with pkgs; [ tigervnc gthumb mpv firefox
                                            #steam
                                          ];

  services = {
    xserver = {
      enable = true;
      videoDrivers =
        [ "amdgpu" "radeon" "cirrus" "vesa" "vmware" "modesetting" ];
      desktopManager.xfce.enable = true;
    };
  };

  systemd.services.vncserver = {
    wantedBy = [ "multi-user.target" ];
    after = [ "syslog.target" "network.target" ];
    path = with pkgs; [ xorg.xauth tigervnc ];
    description = "Start VncServer for user: ${username}";
    serviceConfig = {
      Type = "forking";
      User = username;
      Group = "users";
      WorkingDirectory = "/home/${username}";
      ExecStartPre =
        "/bin/sh -c '${pkgs.tigervnc}/bin/vncserver -kill :1 > /dev/null 2>&1 || :'";
      ExecStart =
        "${pkgs.tigervnc}/bin/vncserver -depth 24 -geometry 1920x1080 :1";
      ExecStop = "${pkgs.tigervnc}/bin/vncserver -kill :1";
    };
  };

  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;

}
