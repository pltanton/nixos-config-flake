{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs;
    lib.mkIf true [
      vesktop
      skypeforlinux
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
