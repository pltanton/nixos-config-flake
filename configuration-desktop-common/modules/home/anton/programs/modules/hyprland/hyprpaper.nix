{ config, lib, pkgs, inputs, ... }:
let wallpaper = ../../../../backgrounds/ign_unsplash44.png;
in {

  home.file."${config.xdg.configHome}/hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = eDP-1,${wallpaper}
    wallpaper = DP-1,${wallpaper}
    wallpaper = DP-2,${wallpaper}
    wallpaper = DP-3,${wallpaper}
  '';
}
