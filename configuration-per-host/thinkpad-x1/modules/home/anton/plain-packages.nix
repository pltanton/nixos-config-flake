{ pkgs, lib, fetchPypi, inputs, ... }: {
  home.packages = with pkgs;
    lib.mkIf true [
      audacity
      discord
      zoom
      master.skypeforlinux

      transmission-remote-gtk
      transmission-gtk
      stable.rapid-photo-downloader

      shotcut

      # (steam.override {
      #   # extraPkgs = pkgs: [ SDL2 libstdcxx5 ];
      #   nativeOnly = false;
      # })
      steam
      steam-run

      adoptopenjdk-bin
      jetbrains.idea-community
    ];
}
