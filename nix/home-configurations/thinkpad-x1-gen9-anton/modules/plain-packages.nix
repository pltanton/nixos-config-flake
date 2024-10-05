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
      # discord
      vesktop

      transmission-remote-gtk
      transmission_4-gtk
      stable.rapid-photo-downloader
      # stable.darktable
      # rawtherapee
      # lightworks
      # kdenlive
    ];
}
