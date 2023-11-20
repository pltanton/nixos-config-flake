{ pkgs, config, ... }: {
  services.ankisyncd = {
    enable = true;
    # host = "ankisyncd.kaliwe.ru";
  };

  services.caddy.virtualHosts."ankisyncd.kaliwe.ru".extraConfig = ''
    reverse_proxy http://127.0.0.1:${toString config.services.ankisyncd.port}
  '';
}
