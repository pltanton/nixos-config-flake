{ pkgs, config, lib, ... }: {
  wayland.windowManager.sway = {
    config.output = {
      # "DP-1" = { scale = "1.1"; };
      "eDP-1" = { scale = "2.0"; };
      # "eDP-1" = { scale = "1.7"; };
    };
  };
}
