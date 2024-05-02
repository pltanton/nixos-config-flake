{
  config,
  pkgs,
  ...
}: let
  port = 1337;
  vpn-dev = "tun0";
in {
  networking.nat = {
    enable = true;
    externalInterface = "ens3";
    internalInterfaces = [vpn-dev];
  };

  networking.firewall.allowedUDPPorts = [port];

  services.openvpn.servers.mainServer = {
    autoStart = false;
    config = ''
      server 10.10.20.0 255.255.255.0

      port ${toString port}
      proto udp
      dev ${vpn-dev}

      ca   /root/nixos/openvpn/keys/ca.crt
      cert /root/nixos/openvpn/keys/server.crt
      key  /root/nixos/openvpn/keys/server.key
      dh   /root/nixos/openvpn/keys/dh2048.pem

      push "redirect-gateway def1"
      push "dhcp-option DNS 8.8.8.8"
      push "dhcp-option DNS 8.8.4.4"

      keepalive 20 60
      compress
      cipher AES-128-CBC
      ncp-disable
      tun-mtu 1400

      log-append /var/log/openvpn.log
      verb 3
    '';
  };
}
