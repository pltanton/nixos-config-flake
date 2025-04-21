{
  pkgs,
  config,
  lib,
  ...
}: {
  services.dbus = {
    enable = true;
    packages = with pkgs; [dconf gcr];
    implementation = "broker";
  };
}
