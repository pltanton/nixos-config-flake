{
  pkgs,
  lib,
  fetchPypi,
  inputs,
  ...
}: {
  home.packages = with pkgs;
    lib.mkIf true [
      audacity
      discord

      transmission-remote-gtk
      transmission-gtk
      rapid-photo-downloader

      steam

      # stable.darktable
      # rawtherapee
      # lightworks
      # kdenlive
    ];
}
