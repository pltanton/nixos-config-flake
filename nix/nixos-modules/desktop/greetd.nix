{
  config,
  lib,
  pkgs,
  ...
}: let
  useDmsGreeter =
    (config.programs.dank-material-shell.greeter.enable or false)
    || (config.services.displayManager.dms-greeter.enable or false);
in {
  services.greetd = {
    enable = true;
    settings = lib.mkIf (!useDmsGreeter) {
      default_session = {
        user = "greeter";
        command =
          "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions";
      };
    };
  };
}
