_: {
  networking.firewall.allowedTCPPorts = [41168 41169];
  networking.firewall.allowedUDPPorts = [41168 41169];

  virtualisation.oci-containers.containers.xui = {
    image = "ghcr.io/mhsanaei/3x-ui:latest";
    ports = ["127.0.0.1:2053:2053" "41168:41168" "41169:41169"];
    volumes = [
      "/var/lib/x-ui:/etc/x-ui"
    ];
  };

  services.caddy.virtualHosts."xui.sprintbox.pltanton.dev".extraConfig = ''
    reverse_proxy 127.0.0.1:2053
  '';

  services.caddy.virtualHosts."xui.sprintbox.kaliwe.ru".extraConfig = ''
    reverse_proxy 127.0.0.1:2053
  '';
}
