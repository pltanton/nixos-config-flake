{ config, lib, pkgs, ... }:

let XCURSOR_SIZE = toString (config.lib.base16.theme.cursorSize * 2);
in {
  xdg.desktopEntries = lib.mkIf config.wayland.windowManager.hyprland.enable {
    idea-ultimate = {
      name = "IntelliJ IDEA";
      exec = "env XCURSOR_SIZE=${XCURSOR_SIZE} = idea-ultimate";
    };
  };
}
