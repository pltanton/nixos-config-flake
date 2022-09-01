{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;

  lan = "enp1s0";
  wifi = "wlp8s0";
  prefixLength = 24;
  ipAddress = "10.1.0.1";
  dhcpRange = "10.1.0.2,10.1.0.199,5m";
in {
  services.hostapd = {
    enable = true;
    interface = wifi;
    ssid = "AnanasikServerAP";
    wpaPassphrase = secrets.apPassword;
  };

  networking.nat = {
    enable = true;
    externalInterface = lan;
    internalIPs = [ "10.1.0.1/24" ];
  };

  networking.interfaces."${wifi}".ipv4.addresses = [{
    address = "${ipAddress}";
    prefixLength = prefixLength;
  }];

  systemd.services.dnsmasq = {
    after = [ "wireguard-wg0.service" ];
    requires = [ "wireguard-wg0.service" ];
  };
  services.dnsmasq = {
    enable = true;
    servers = [ "8.8.8.8" "8.8.4.4" ];
    extraConfig = ''
      domain=lan
      interface=${wifi}
      interface=${lan}
      interface=wg0
      bind-interfaces

      dhcp-range=${dhcpRange}

      dhcp-host=34:ce:00:bc:be:b2,10.1.0.200 # Kitchen philips light
      dhcp-host=34:ce:00:bc:c7:4b,10.1.0.201 # Room philips light
      dhcp-host=04:cf:8c:7b:71:17,10.1.0.202 # YeeLight bulb color toilet
      dhcp-host=04:cf:8c:77:37:83,10.1.0.203 # YeeLight bulb color bed
      dhcp-host=80:7d:3a:68:45:f7,10.1.0.204
      dhcp-host=80:7d:3a:68:47:db,10.1.0.205
      dhcp-host=f0:b4:29:0f:2b:f4,10.1.0.206 # YeeLight white
      dhcp-host=78:11:dc:e9:55:fd,10.1.0.207 # vacuum cleaner
      dhcp-host=7c:49:eb:b2:84:0a,10.1.0.208 # humidifier
      dhcp-host=58:b6:23:9c:67:cf,10.1.0.209 # fan

      address=/server.home/10.100.0.1
      address=/thinkpad-x1.home/10.100.0.3
      address=/thinkbook.home/10.100.0.4

      address=/home.kaliwe.ru/192.168.50.2
      address=/hass.kaliwe.ru/192.168.50.2
      address=/jellyfin.kaliwe.ru/192.168.50.2
      address=/filestash.kaliwe.ru/192.168.50.2
      address=/monitorrent.kaliwe.ru/192.168.50.2
      address=/nextcloud.kaliwe.ru/192.168.50.2
      address=/mqtt.kaliwe.ru/192.168.50.2
      address=/torrent.kaliwe.ru/192.168.50.2
      address=/plex.kaliwe.ru/192.168.50.2
      address=/vacuum.kaliwe.ru/192.168.50.2
      address=/motioneye.kaliwe.ru/192.168.50.2
    '';
  };
  networking.firewall.allowedUDPPorts = [ 53 67 ]; # DNS & DHCP
  services.haveged.enable = true;

  services.resolved.extraConfig = ''
    DNSStubListener=no
  '';
}
