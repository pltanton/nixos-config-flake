{ pkgs, ... }: {
  networking.firewall.allowedUDPPorts = [ 8388 ];
  networking.firewall.allowedTCPPorts = [ 8388 ];

  services.shadowsocks = {
    enable = false;
    password = "putin-huilo";
  };

  services.go-shadowsocks2.server = {
    enable = true;
    listenAddress = "ss://AEAD_CHACHA20_POLY1305:putin-huilo@:8388";
  };
}
