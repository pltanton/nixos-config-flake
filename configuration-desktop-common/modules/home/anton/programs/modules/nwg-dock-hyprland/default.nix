{ pkgs, osConfig, config, ... }:
let
  # style = osConfig.lib.stylix.colors {
  #   template = builtins.readFile ./nwg-dock.css.mustache;
  #   extension = "css";
  # };
in {
  # services.nwg-dock = {
  #   enable = false;
  #   package = pkgs.master.nwg-dock-hyprland;
  #   executableName = "nwg-dock-hyprland";
  #   configDir = "${config.xdg.configHome}/nwg-dock-hyprland";
  #   hotspotDelay = 0;
  #   style = style;
  # };
}
