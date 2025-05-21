{
  config,
  pkgs,
  ...
}: let
  consts = import ../constants.nix;
in {
  nixpkgs.config.allowBroken = true;
  services = {
    immich = {
      enable = true;
      package = pkgs.immich;
      mediaLocation = "${consts.archiveMountPoint}/photoprism-data";
      settings = {
        server = {
          externalDomain = "https://immich.pltanton.dev";
        };
      };
    };

    caddy.virtualHosts."immich.pltanton.dev".extraConfig = ''
      reverse_proxy http://127.0.0.1:${toString config.services.immich.port}
    '';
  };

  systemd.tmpfiles.rules = [
    "d ${config.services.immich.mediaLocation} 0755 ${config.services.immich.user} ${config.services.immich.group}"
  ];
}
