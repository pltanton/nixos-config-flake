{ pkgs, osConfig, config, ... }:
let
  style = osConfig.lib.stylix.colors {
    template = builtins.readFile ./nwg-dock.css.mustache;
    extension = "css";
  };
in {
  services.nwg-dock = {
    enable = true;
    package = pkgs.master.nwg-dock-hyprland;
    executableName = "nwg-dock-hyprland";
    style = style;
  };
}
