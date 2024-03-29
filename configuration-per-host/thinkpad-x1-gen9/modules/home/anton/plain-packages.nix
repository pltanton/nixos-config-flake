{ pkgs, lib, fetchPypi, inputs, ... }: {

  home.packages = with pkgs;
    lib.mkIf true [
      audacity
      discord

      transmission-remote-gtk
      transmission-gtk
      # rapid-photo-downloader

      # tor-browser-bundle-bin

      # (stable.steam.override {
      #   extraPkgs = pkgs: with pkgs; [ SDL2 renderdoc ];
      #   extraProfile = "unset VK_ICD_FILENAMES";
      # })
      steam
      # steam-run

      darktable
      rawtherapee
      lightworks
      pitivi
      kdenlive

      # (pkgs.factorio.override {
      #   username = "pltanton";
      #   token = "2233a0430e2167528d62bf19499fa7";
      # })
    ];
}
