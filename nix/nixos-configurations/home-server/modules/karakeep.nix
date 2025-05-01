_: {
  services.karakeep = {
    enable = true;
  };

  services.caddy.virtualHosts."karakeep.pltanton.dev".extraConfig = ''
    reverse_proxy http://127.0.0.1:3000
  '';
}
