{ config, pkgs, lib, ... }: {
  systemd.tmpfiles.rules = lib.mkIf config.service.transmission.enable [
    "d /media 1774 publicstore publicstore"
    "d /media/store 1774 publicstore publicstore"
  ];
}
