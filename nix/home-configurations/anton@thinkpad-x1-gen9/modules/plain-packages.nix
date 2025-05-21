{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs;
    lib.mkIf true [
      vesktop
      sidequest

      transmission-remote-gtk
      transmission_4-gtk
      stable.rapid-photo-downloader
      darktable
      # rawtherapee
      # lightworks
      # kdenlive
    ];
}
