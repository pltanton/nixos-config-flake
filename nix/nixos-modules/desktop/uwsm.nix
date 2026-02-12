{
  config,
  lib,
  ...
}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors = lib.mkMerge [
      (lib.optionalAttrs config.programs.hyprland.enable {
        hyprland = {
          prettyName = "Hyprland (UWSM)";
          comment = "Hyprland managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      })
      {
        niri = {
          prettyName = "Niri (UWSM)";
          comment = "Niri managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri";
        };
      }
    ];
  };
}
