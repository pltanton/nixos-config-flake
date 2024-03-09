{ pkgs, ... }: {
  networking.firewall.allowedUDPPorts = [ 8388 8388 ];
  networking.firewall.allowedTCPPorts = [ 4443 4443 ];

  services.shadowsocks = {
    enable = false;
    password = "putin-huilo";
    plugin = "${pkgs.shadowsocks-v2ray-plugin}/bin/v2ray-plugin";
  };

  services.go-shadowsocks2.server = {
    enable = true;
    listenAddress = "ss://AEAD_CHACHA20_POLY1305:putin-huilo@:8388";
  };
