{pkgs, ...}: {
  networking.firewall.allowedUDPPorts = [8388];
  networking.firewall.allowedTCPPorts = [8388];

  services.shadowsocks = {
    enable = true;
    password = "putin-huilo";
  };
}
