{ pkgs, config, lib, ... }: {
  wayland.windowManager.sway = {
    config.output = {
      "eDP-1" = { scale = "1.6"; };
    };
  };

  home.file.".Xdefaults".text = ''
    Xft.dpi: 154
    Xcursor.size: 32
  '';
}
