{ config, lib, pkgs, inputs, ... }:
let wallpaper = ../../../../backgrounds/nord-5.png;
in {

  home.file."${config.xdg.configHome}/hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = eDP-1,${wallpaper}
    wallpaper = DP-1,${wallpaper}
    wallpaper = ,${wallpaper}
    ipc = off
  '';
}
