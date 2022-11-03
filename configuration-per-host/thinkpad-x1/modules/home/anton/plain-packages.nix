{ pkgs, lib, fetchPypi, inputs, ... }: {
  home.packages = with pkgs;
    lib.mkIf true [
      discord

      transmission-remote-gtk
      transmission-gtk

      shotcut
    ];
}
