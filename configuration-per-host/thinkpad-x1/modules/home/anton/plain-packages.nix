{ pkgs, lib, fetchPypi, inputs, ... }: {
  home.packages = with pkgs;
    lib.mkIf true [
      audacity
      discord

      transmission-remote-gtk
      transmission-gtk
      stable.rapid-photo-downloader

      shotcut

      # tor-browser-bundle-bin

      # (steam.override {
      #   # extraPkgs = pkgs: [ SDL2 libstdcxx5 ];
      #   nativeOnly = false;
      # })
      steam
      # steam-run

      darktable
      kdenlive
      shotcut
      rawtherapee
    ];
}
