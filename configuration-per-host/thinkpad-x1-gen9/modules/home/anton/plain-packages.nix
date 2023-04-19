{ pkgs, lib, fetchPypi, inputs, ... }: {
  home.packages = with pkgs;
    lib.mkIf true [
      audacity
      discord

      transmission-remote-gtk
      transmission-gtk
      master.rapid-photo-downloader

      shotcut

      # tor-browser-bundle-bin

      (steam.override {
        extraPkgs = pkgs: with pkgs; [ SDL2 renderdoc ];
        extraProfile = "unset VK_ICD_FILENAMES";
      })
      # steam
      # steam-run

      darktable
      kdenlive
      shotcut
      rawtherapee

      (pkgs.factorio.override {
        username = "pltanton";
        token = "2233a0430e2167528d62bf19499fa7";
      })
    ];
}
