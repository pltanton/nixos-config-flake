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
      rapid-photo-downloader
      darktable
      # rawtherapee
      # lightworks
      # kdenlive
    ];
}
