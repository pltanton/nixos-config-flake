{ config, lib, pkgs, ... }:
with lib;
let cfg = config.wayland.windowManager;
in {
  options = {
    config.wmEnabled = mkOption {
      type = types.bool;
      default = cfg.sway.enable || cfg.hyprland.enable;
      description =
        "Aggregated option to indicate if any wayland display manager enabled";
    };
  };
}
