{...}: {
  services.jellyfin = {
    enable = true;
    group = "publicstore";
    user = "publicstore";
  };

  services.caddy.virtualHosts."jellyfin.kaliwe.ru".extraConfig = ''
    reverse_proxy http://[::1]:8096
  '';
}
