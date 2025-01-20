_: let
  consts = import ../constants.nix;
in {
  virtualisation.oci-containers.containers = {
    monitorrent = {
      image = "werwolfby/monitorrent";
      ports = ["6687:6687"];
      extraOptions = ["--network=host"];
      volumes = [
        "${consts.mediaAppHomes}/monitorrent-home/monitorrent.db:/var/www/monitorrent/monitorrent.db"
      ];
    };
  };

  services.caddy.virtualHosts."monitorrent.kaliwe.ru".extraConfig = ''
    reverse_proxy http://localhost:6687
  '';
}
