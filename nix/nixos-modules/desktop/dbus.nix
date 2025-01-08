{
  pkgs,
  config,
  lib,
  ...
}: {
  services.dbus = lib.mkIf (!config.services.xserver.desktopManager.gnome.enable) {
    enable = true;
    packages = with pkgs; [dconf gcr];
    implementation = "broker";
  };
}
